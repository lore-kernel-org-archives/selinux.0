Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E837C433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 21:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0404364DC3
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 21:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBLVut (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:50:49 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:57644 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhBLVus (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 12 Feb 2021 16:50:48 -0500
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id DFFF02A06F9;
        Fri, 12 Feb 2021 22:50:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl DFFF02A06F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1613166603;
        bh=hARjeb8JDXy+YfONjIenUs5ce7KkalGEySkP8OINL1M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aaFndU8Jq9Qq/UMexrHlg61sZ5sjSBic6qHOKwuSzudSAPa60YhxmuiyGwgtbf+l1
         KPD4jR310+4HNQRCuMZ6mVfkNk5mBX7v1Sq0+z+O71cbmdbY8nH6fXXb72kRM9DILe
         2QNBFuzNpOwwCbBBWxoFd8NZDgQmwYFfaaoClR9c=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
        <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
        <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
Date:   Fri, 12 Feb 2021 22:49:59 +0100
In-Reply-To: <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
        (Peter Whittaker's message of "Fri, 12 Feb 2021 16:16:02 -0500")
Message-ID: <ypjl35y1ot14.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:

> On Fri, Feb 12, 2021 at 2:58 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Dominick Grift <dominick.grift@defensec.nl> writes:
>> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>> >
>> >>     BLUF: Logging in via SSH or directly at the console results
>> >>     in "Unable to get valid context...". Help! Much info included.
>
> Thanks to Dominick, I have made at least some progress: I can get the
> role to transition,
> but not the user or the process type. Details below.
>
>> > A few things that I could find but that are needed for computing
>> > contexts are:
>> >
>> > the login programs need to be allowed to manual transition to the user
>> > type. So for example if you want to login with sshd_t:
>> > allow sshd_t xferHigh2Local_t:process transition;
>
> That rule was already present (it is the only one I really need, these
> users will be coming in via SSH only).

Okay I dont think you mentioned that before

>
>> In relation to the above, ensure that the xferHigh2Local_t type is
>> associated with the process_user_target typeattribute:
>> typeattribute xferHigh2Local_t process_user_target;
>
> I added process_user_target to the type definition, no effect:
>
>     type xferHigh2Local_t, CDTml_types, userdomain, process_user_target;

I dont think you mentioned this before and I think you also didnt
mention that you had userdomain associates with it.

>
>> > The user type needs to be a bin and shell entry type:
>> > allow xferHigh2Local_t { bin_t shell_exec_t }:file entrypoint;
>
> Also added that, after testing process_user_target, no effect. (So I
> had all three suggestions active.)
>
> I then added
>
>     role_transition system_r sshd_exec_t CDTml_high2local_r;

That is wrong

>
> and this got me my first real progress - 'id -Z' now shows:
>
>     system_u:CDTml_high2local_r:unconfined_t:s0

Yes but that is wrong

>
>> > There is probably more that i am overlooking but these, i think, are
>> > important part for computation of contexts
>
> Any other suggestions would be most welcome! I am at a loss,
> especially since the
> *_u "types" are not part of the policy but are defined via semanage,
> and I already have
> rules for the _t types, via an existing rules:
>
>     allow { sshd_t unconfined_t } xferHigh2Local_t:process transition;
>
> What surprises me most is that originally nothing showed up in ausearch.
> I suppose this is because either PAM or SSHD is doing the computation
> and not logging it in audit.log, but that is just a guess, likely misguided.

Yes the computation does not cause any logging

>
> However! After that last allow, above, I finally have errors in ausearch,
> many repeats of:
>
>     libsepol.context_from_record: invalid security context:
> "system_u:CDTml_high2local_r:sshd_t:s0"
>     libsepol.context_from_record: could not create context structure
>     libsepol.context_from_string: could not create context structure
>     libsepol.sepol_context_to_sid: could not convert
> system_u:CDTml_high2local_r:sshd_t:s0 to sid
>     libsepol.context_from_record: invalid security context:
> "system_u:CDTml_high2local_r:unconfined_t:s0"
>     libsepol.context_from_record: could not create context structure
>     libsepol.context_from_string: could not create context structure
>     libsepol.sepol_context_to_sid: could not convert
> system_u:CDTml_high2local_r:unconfined_t:s0 to sid
>
> I then expanded the basic allow rule for the CDTml_high2local_r role:
>
>    role CDTml_high2local_r types {
>        sshd_t
>        unconfined_t
>        xferHigh2Local_t
>        xferHigh2Local_exec_t
>    };

Yes but the above is not right, and so those errors are expected.

>
> This didn't get me any farther, though.
>
> Do I need to widen the roles associated with CDTml_high2local_u at login?

It helps if you post your full policy related to this and also the output
of the following:

seinfo -xuCDTml_high2local_u
seinfo -xrCDTml_high2local_r
seinfo -xtxferHigh2Local_t

>
> I really am trying to keep them as tight as possible. (Which,
> incidentally, is one
> of the reasons I am using "old school" rules and not CIL: the M4 macros may
> do more than I need them to....)

That shouldnt matter, but it helps if you post the full policy rather
than snippets.

also there are some tools that you can use to verify if a specified
context can be reached.

getconlist:
https://github.com/SELinuxProject/selinux/blob/master/libselinux/utils/getconlist.c
getdefaultcon:
https://github.com/SELinuxProject/selinux/blob/master/libselinux/utils/getdefaultcon.c

There is also a boolean that might affect things (but speculation
without a closer look at your policy):

ssh_sysadm_login

see if setting that to on helps

>
> Thanks,
>
> P
>
> PS apologies to all for the double send of the original, user error (PEBCAD).
>
> Peter Whittaker
> Director, Business Development
> www.SphyrnaSecurity.com
> +1 613 864 5337

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
