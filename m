Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D6C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52EC2177B
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgH0OTF convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:19:05 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:18340 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbgH0OQm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 10:16:42 -0400
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2020 10:16:39 EDT
Subject: Re: [RFC PATCH] selinux: Add denied trace with permssion filter
To:     Paul Moore <paul@paul-moore.com>
CC:     <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com>
 <20200824132252.31261-2-peter.enderborg@sony.com>
 <CAHC9VhR8PscKpA5BrgTNj8cq_eQ6svqru6UXidc=v5+Ha+PM7Q@mail.gmail.com>
 <6cbe5d27-ebb2-70a6-bad4-31c9f310eff2@sony.com>
 <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
 <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com>
 <CAHC9VhRE94YVK5bTcqqbNYJu-EwjbcwjSFgqV8jkyLn9HD39Ag@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <abaccc15-85a8-24d2-4481-8303e3a42362@sony.com>
Date:   Thu, 27 Aug 2020 16:04:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRE94YVK5bTcqqbNYJu-EwjbcwjSFgqV8jkyLn9HD39Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=FfdJO626 c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=RpNjiQI2AAAA:8 a=AKTmbaUPI3psir6HZzAA:9 a=jpIH26JlB8aEU1M81S3jpgcb7nU=:19 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/27/20 3:30 PM, Paul Moore wrote:
> On Wed, Aug 26, 2020 at 11:06 AM peter enderborg
> <peter.enderborg@sony.com> wrote:
>> On 8/26/20 4:45 PM, Paul Moore wrote:
>>> On Wed, Aug 26, 2020 at 10:34 AM peter enderborg
>>> <peter.enderborg@sony.com> wrote:
>>>> On 8/26/20 3:42 PM, Paul Moore wrote:
>>>>> On Mon, Aug 24, 2020 at 9:23 AM Peter Enderborg
>>>>> <peter.enderborg@sony.com> wrote:
>>>>>> This adds tracing of all denies. They are grouped with trace_seq for
>>>>>> each audit.
>>>>>>
>>>>>> A filter can be inserted with a write to it's filter section.
>>>>>>
>>>>>> echo "permission==\"entrypoint\"" > events/avc/selinux_denied/filter
>>>>>>
>>>>>> A output will be like:
>>>>>>           runcon-1046  [002] .N..   156.351738: selinux_denied:
>>>>>>           trace_seq=2 result=-13
>>>>>>           scontext=system_u:system_r:cupsd_t:s0-s0:c0.
>>>>>>           c1023 tcontext=system_u:object_r:bin_t:s0
>>>>>>           tclass=file permission=entrypoint
>>>>>>
>>>>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
>>>>>> ---
>>>>>>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
>>>>>>  security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
>>>>>>  2 files changed, 62 insertions(+), 2 deletions(-)
>>>>> My most significant comment is that I don't think we want, or need,
>>>>> two trace points in the avc_audit_post_callback() function.  Yes, I
>>>>> understand they are triggered slightly differently, but from my
>>>>> perspective there isn't enough difference between the two tracepoints
>>>>> to warrant including both.  However, while the tracepoints may be
>>>> We tried that but that was problematic too.
>>> My apologies if I was on that thread, but can you remind me why it was
>>> a problem?  Why can't we use a single tracepoint to capture the AVC
>>> information?
>> The problem is parsing the event.
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2020_8_18_842&d=DwIBaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=qmi2ROWsLC_0mLLhHkpb71j1YoicydLh-7l4cOsLYcY&s=iS3eZr3TFrN5I7BbnvPFYOKd6DfW1FHTFcwI7joS_fk&e= 
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2020_8_21_526&d=DwIBaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=qmi2ROWsLC_0mLLhHkpb71j1YoicydLh-7l4cOsLYcY&s=9OsLN0Y5mUWxEAAqUE6K4PS57Pn1XyZz7GXak6uc_Ls&e= 
>>
>> and the "single list" version
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2020_8_17_1346&d=DwIBaQ&c=fP4tf--1dS0biCFlB0saz0I0kjO5v7-GLPtvShAo4cc&r=oO5HuGEGxznA2F3djiiYxmxxWQonw0h6Sks-BEoB4ys&m=qmi2ROWsLC_0mLLhHkpb71j1YoicydLh-7l4cOsLYcY&s=tWSY2ry2IT6RcT5BIUwMuqBL_yPObDE1VljbLqI1zrA&e= 
>>
>> With this patch we follow standard message format so no plugin should be needed.
> I'm evidently missing something very fundamental (likely), and/or I'm
> just not communicating very clearly (also likely), because the above
> links don't appear to make any sense with respect to my question.
>
> Let me try a reset ... Why can't we basically take the
> "selinux_denied" TRACE_EVENT implementation in your patch and use it
> to replace the "selinux_audited" TRACE_EVENT in the selinux/next tree
> (of course with the necessary changes to the AVC callback code)?
>
> If the "selinux_denied" implementation is valid from a tracing point
> of view, why can we not do this?  Of course if the "selinux_denied"
> implementation is not a valid TRACE_EVENT then I'm not sure why this
> was suggested for SELinux :)
>
Im happly fine with replacing the selinux_audited with selinux_denied.  However it is the case where there are more than one denial at the same time. Im not sure how and when it might happen.
When that happen we got more than one event. I have no problems with that, but im not sure if the debug tools and perf can make sense of that.

A other feature with the selinux_audited event it might be inserted on other places in the code too.  A denial is sort of final.



