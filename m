Return-Path: <SRS0=Zo7G=CK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ADFC433E7
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA7D2078B
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbgIARTE convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Tue, 1 Sep 2020 13:19:04 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:13854 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729198AbgIARSw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Sep 2020 13:18:52 -0400
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
 <abaccc15-85a8-24d2-4481-8303e3a42362@sony.com>
 <CAHC9VhRi87H2GhsKQN9iMOQeSw3g5_qwok9jpx+pfFSouQ9d5w@mail.gmail.com>
 <000e6a1b-6026-5e99-9a92-6ae9aafc07d4@sony.com>
 <CAHC9VhQiPTEarUWWA1RH8AsymhRpAa7kWTmmefTAqfouts8WGw@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <aa37c79f-d908-0a75-4916-6aaa21426212@sony.com>
Date:   Tue, 1 Sep 2020 19:18:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQiPTEarUWWA1RH8AsymhRpAa7kWTmmefTAqfouts8WGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=FfdJO626 c=1 sm=1 tr=0 a=fZcToFWbXLKijqHhjJ02CA==:117 a=IkcTkHD0fZMA:10 a=reM5J-MqmosA:10 a=nyYj2fbFlj4J1w-omPgA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/1/20 5:31 PM, Paul Moore wrote:
> On Mon, Aug 31, 2020 at 11:34 AM peter enderborg wrote:
>> On 8/31/20 4:16 PM, Paul Moore wrote:
>>> On Thu, Aug 27, 2020 at 10:04 AM peter enderborg wrote:
> ...
>
>>>> Im happly fine with replacing the selinux_audited with selinux_denied.  However it is the case where there are more than one denial at the same time. Im not sure how and when it might happen.
>>> One thing I wondered about was why not build up a single string with
>>> all of the permissions instead of generating multiple trace events?
>>> In the previous discussion it was implied that this was due to
>>> limitations in the tracing subsystem's filtering, and based on the
>>> discussion thus far I'm guessing there is little desire for this
>>> information if it can't be filtered on?
>> The information is of course as essential as for audit messages.
>> I dont see much of the problem with having as the first suggestion with
>> a list. It works fine for trace_pipe. It is not failing due to that we can not
>> filter with that.
> I don't really have much personal experience with the kernel tracing
> tools, so an example would be helpful as I'm not really following what
> you are saying.  Are you talking about something like
> "permission=foo,bar,baz"?

In the first patch we hade premission that was in the format:

permission={read !write open}

That would have work fine if it was not for that the permission can be created
dynamically.  It would be very easy to change that to

permission=read permission=!write permission=open

But I think that will cause problems too. The create a format specifiaction
in the trace tree, and I dont think we can describe this format.


>
>> It is cause in other tools in user-space
>> that needs a plugin to parse it. It need static
>> mapping for something that is not really static. Not in runtime, and it will
>> change over time.
> I think we've all come to the conclusion that doing the permission
> bitmap-to-string translation in a plugin is not really desirable.

Yes. But Im arguing that we still have the same information,
but it will "cost" that we have more events. It is a fair trade-off,
it is usually a lot better to have the trace simple than
flexible and let it cost events when needed.


>> A other idea based on the first one is to have multiple pairs like
>>
>> class=file permission=read permission=write permission=open
>>
>> but then you need to filter on numeric values that are not static and
>> I don't know if library can make anything useful from that.
> Oh, wait, is the issue that the tracing subsystem can't filter on
> strings?  That doesn't seem right, but I can understand why one might
> want to avoid that for performance reasons.  If the tracing subsystem
> *can* filter on strings, why did you say that in the "perm=foo
> perm=bar" format one would need to filter on numeric values?  I still
> think I'm missing something here ...
>
No. It can filter on strings. But it can not do any fuzzy matching.
They are equal not not equal. So if you have a parameter value
that is { open read !write } you need to specify a exact match.

With multiple events you match for "open" or "write" not "{ open read !write }".

So you get one event for "open" and a other event for "write".

The numeric values is not matching perm=, it is a match for the
bits in the denied= parameter that is present within selinux_audited event.


