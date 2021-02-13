Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44BCC433E0
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B140364DE3
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBMQKd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 11:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMQKa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 13 Feb 2021 11:10:30 -0500
X-Greylist: delayed 65985 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Feb 2021 08:09:50 PST
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19DC2C061574
        for <selinux@vger.kernel.org>; Sat, 13 Feb 2021 08:09:50 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 257EA2A0CF2;
        Sat, 13 Feb 2021 17:09:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 257EA2A0CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1613232588;
        bh=QbX3GqI6VdmtHAjDToK/zD0LyW9TKqnBcxxnMwvobgg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UzEv4qRS8k7sedHYUl399+j+eJZxha61BRaOUG1mEiBbl6FTBJi3k1iCOqoInNSm+
         /ttRXacEvu1lBfzRtzdz5lhj7WdJB+2DpuUJPHsLxVq+P/BOzrKwtMS12AmP5Dx6g8
         10je6gvYgYYvnMYvBdGCtnIdDvj9zkvssJDzy1to=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
        <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
        <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
        <ypjl35y1ot14.fsf@defensec.nl>
        <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
        <ypjlv9awo2iy.fsf@defensec.nl>
        <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
Date:   Sat, 13 Feb 2021 17:09:45 +0100
In-Reply-To: <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
        (Peter Whittaker's message of "Sat, 13 Feb 2021 09:13:12 -0500")
Message-ID: <ypjlmtw8ne46.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:

> On Sat, Feb 13, 2021 at 2:24 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>> > On Fri, Feb 12, 2021 at 4:52 PM Dominick Grift
>> > <dominick.grift@defensec.nl> wrote:
>> >> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>> >> > On Fri, Feb 12, 2021 at 2:58 AM Dominick Grift
>> >> > <dominick.grift@defensec.nl> wrote:
>> >> >> Dominick Grift <dominick.grift@defensec.nl> writes:
>> >> >> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>> >> >> >>     BLUF: Logging in via SSH or directly at the console results
>> >> >> >>     in "Unable to get valid context...". Help! Much info included.
>>
>> You missed a fundamental type attribute association:
>>
>> type xferHigh2Local_t, CDTml_types, userdomain, process_user_target;
>>
>> It seems that you did not associate your process types with "domain":
>>
>> typeattribute xferHigh2Local_t domain;
>>
>> See if adding that helps
>
> It didn't - but! The failure motivated me to dive more deeply back
> into /var/log/audit/audit.log, wherein I noticed that the desired user
> context has been being computed correctly since sometime yesterday
> (15:29:25 EST, in fact) - but SSH logins were still failing to assign
> that context. So I tried a console login and it worked (I've not made
> any console related changes since you started helping me with this).

Okay but all processes should alway's associate with the domain attribute

>
> Progress: The desired context is properly computed and assigned, at
> least with console (local) login. This leaves me two major items to
> figure out:
>
>     1. Of the changes I have applied over the last 1-3 days,
>         what is the minimum set required to achieve this? My
>         immediate future includes bisection.

Yes i guess work your way back and see...

>
>      2. Why doesn't it work with SSH, when it does work with
>           the console (yes, the ssh_sysadm_login is on)?

see if the ssh daemon runs with the expected:
system_u:system_r:sshd_t:s0 context (ps auxZ | grep ssh)

then doubt check that
/etc/selinux/targeted/contexts/users/CDTml_high2local_u has:
system_r:sshd_t:s0 CDTml_high2local_r:xferHigh2Local_t:s0

And use sesearch to verify that the following queries return:

sesearch -A -s sshd_t -t xferHigh2Local_t -c process -p transition
sesearch -A -s xferHigh2Local_t bin_t -c file -p entrypoint
sesearch -A -s xferHigh2Local_t shell_exec_t -c file -p entrypoint

Also, just in case, try in permissive mode to see if that changes
anything (unlikely but worth a try)

>
> I've read that the latter may have to do with network labelling and/or
> default network context, I may need to explore that.

I dont think that is related

>
> All suggestions welcome!
>
> Thanks! Progress restores optimism.
>
> P

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
