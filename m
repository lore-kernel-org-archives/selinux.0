Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E5C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA0B20825
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHZPGQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:06:16 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:3158 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgHZPGP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:06:15 -0400
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
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <59fa190f-37c0-79f3-ea46-8f821d820e1c@sony.com>
Date:   Wed, 26 Aug 2020 17:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRGaE4FwE8iXo_zeAPdimE9ryMR+r4Jcq=ZpF_2aTJxzQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=dtal9Go4 c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=D19gQVrFAAAA:8 a=K-nJozlINqW-tucNYmoA:9 a=QEXdDO2ut3YA:10 a=d-OLMTCWyvARjPbQ-enb:22 a=W4TVW4IDbPiebHqcZpNg:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/26/20 4:45 PM, Paul Moore wrote:
> On Wed, Aug 26, 2020 at 10:34 AM peter enderborg
> <peter.enderborg@sony.com> wrote:
>> On 8/26/20 3:42 PM, Paul Moore wrote:
>>> On Mon, Aug 24, 2020 at 9:23 AM Peter Enderborg
>>> <peter.enderborg@sony.com> wrote:
>>>> This adds tracing of all denies. They are grouped with trace_seq for
>>>> each audit.
>>>>
>>>> A filter can be inserted with a write to it's filter section.
>>>>
>>>> echo "permission==\"entrypoint\"" > events/avc/selinux_denied/filter
>>>>
>>>> A output will be like:
>>>>           runcon-1046  [002] .N..   156.351738: selinux_denied:
>>>>           trace_seq=2 result=-13
>>>>           scontext=system_u:system_r:cupsd_t:s0-s0:c0.
>>>>           c1023 tcontext=system_u:object_r:bin_t:s0
>>>>           tclass=file permission=entrypoint
>>>>
>>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
>>>> ---
>>>>  include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
>>>>  security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
>>>>  2 files changed, 62 insertions(+), 2 deletions(-)
>>> My most significant comment is that I don't think we want, or need,
>>> two trace points in the avc_audit_post_callback() function.  Yes, I
>>> understand they are triggered slightly differently, but from my
>>> perspective there isn't enough difference between the two tracepoints
>>> to warrant including both.  However, while the tracepoints may be
>> We tried that but that was problematic too.
> My apologies if I was on that thread, but can you remind me why it was
> a problem?  Why can't we use a single tracepoint to capture the AVC
> information?

The problem is parsing the event.

https://lkml.org/lkml/2020/8/18/842

https://lkml.org/lkml/2020/8/21/526

and the "single list" version

https://lkml.org/lkml/2020/8/17/1346

With this patch we follow standard message format so no plugin should be needed.


>> Having partly overlapping traces is not unheard off.  Check
>> compaction.c where we have a     trace_mm_compaction_begin
>> and a more detailed trace_mm_compaction_migratepages.
>> (And a  trace_mm_compaction_end)
> It may not be unique to SELinux, but that doesn't mean I like it :)
>
> One of my concerns with adding tracepoints is that the code would get
> littered with tracepoints; I accepted that it the AVC decision
> codepath was an obvious place for one, so we added a tracepoint.
> Having two tracepoints here is getting awfully close to my original
> fears.
>
>>> redundant in my mind, this new event does do the permission lookup in
>>> the kernel so that the contexts/class/permissions are all available as
>>> a string which is a good thing.
>>>
>>> Without going into the details, would the tracing folks be okay with
>>> doing something similar with the existing selinux_audited tracepoint?
>>> It's extra work in the kernel, but since it would only be triggered
>>> when the tracepoint was active it seems bearable to me.
>> I think the method for expanding lists is what we tried first on
>> suggestion from Steven Rostedt.  Maybe we can do a trace_event
>> from a TP_prink but that would be recursive.
> Wait, why would you be adding a trace event to a trace event, or am I
> misunderstanding you?
>
> All I was talking about was adding the permission resolution code to
> the already existing SELinux AVC tracepoint.
>

