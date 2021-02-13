Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34111C433DB
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 07:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E075264E00
	for <selinux@archiver.kernel.org>; Sat, 13 Feb 2021 07:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhBMHXP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 13 Feb 2021 02:23:15 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:58832 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhBMHXO (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 13 Feb 2021 02:23:14 -0500
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 88D372A0CF2;
        Sat, 13 Feb 2021 08:22:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 88D372A0CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1613200951;
        bh=LMrf/4/iBmF23ugTXKnFvxi/amF0/XIbOq4zXp9McnQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OYrfFA9r79oX5CytEQV37rh2vxyU6liAcLm5HBG+5UsSiMPN2Ue8oqn+AiyvGpCK+
         v4mS8DAPXgGNKzTJiug7frrHuFRn8OkO+6RiXMEDLnBRMm2xkOe8jJPDAWcBduk9Nt
         I/YNqo4jT7v71eBKFKEK8mU73xIbu/PMOc8r1/9g=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
        <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
        <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
        <ypjl35y1ot14.fsf@defensec.nl>
        <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
Date:   Sat, 13 Feb 2021 08:22:29 +0100
In-Reply-To: <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
        (Peter Whittaker's message of "Fri, 12 Feb 2021 17:43:44 -0500")
Message-ID: <ypjlv9awo2iy.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:

> On Fri, Feb 12, 2021 at 4:52 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>> > On Fri, Feb 12, 2021 at 2:58 AM Dominick Grift
>> > <dominick.grift@defensec.nl> wrote:
>> >> Dominick Grift <dominick.grift@defensec.nl> writes:
>> >> > Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>> >> >>     BLUF: Logging in via SSH or directly at the console results
>> >> >>     in "Unable to get valid context...". Help! Much info included.
>> >
>> > Thanks to Dominick, I have made at least some progress: I can get the
>> > role to transition, but not the user or the process type. Details below.
>
> SNIP

You missed a fundamental type attribute association:

type xferHigh2Local_t, CDTml_types, userdomain, process_user_target;

It seems that you did not associate your process types with "domain":

typeattribute xferHigh2Local_t domain;

See if adding that helps

>
>> > That rule was already present (it is the only one I really need, these
>> > users will be coming in via SSH only).
>>
>> Okay I dont think you mentioned that before
>
> No, I didn't. I've been testing with both SSH and local login in an
> attempt to determine where the problem might lie.
>
>> > I added process_user_target to the type definition, no effect:
>> >
>> >     type xferHigh2Local_t, CDTml_types, userdomain, process_user_target;
>>
>> I dont think you mentioned this before and I think you also didnt
>> mention that you had userdomain associates with it.
>
> Correct. Oversight on my part.
>
>> > I then added
>> >
>> >     role_transition system_r sshd_exec_t CDTml_high2local_r;
>>
>> That is wrong
>
> OK. I thought so to, thinking that the context/users and default_*
> files would control this, but it did cause a change. Thought it might
> be a useful data point.
>
> Can you validate my assumption re the users and default_* files?
>
>> > and this got me my first real progress - 'id -Z' now shows:
>> >
>> >     system_u:CDTml_high2local_r:unconfined_t:s0
>>
>> Yes but that is wrong
>
> Indeed!
>
>> > What surprises me most is that originally nothing showed up in ausearch.
>> > I suppose this is because either PAM or SSHD is doing the computation
>> > and not logging it in audit.log, but that is just a guess, likely misguided.
>>
>> Yes the computation does not cause any logging
>
> Ah. Unfortunate.
>
>> > However! After that last allow, above, I finally have errors in ausearch,
>> > many repeats of:
>> >
>> >     libsepol.context_from_record: invalid security context:
> snip
>> >
>> > I then expanded the basic allow rule for the CDTml_high2local_r role:
>> >
>> >    role CDTml_high2local_r types {
>> >        sshd_t
>> >        unconfined_t
>> >        xferHigh2Local_t
>> >        xferHigh2Local_exec_t
>> >    };
>>
>> Yes but the above is not right, and so those errors are expected.
>
> OK, that makes sense.
>
>> > This didn't get me any farther, though.
>> >
>> > Do I need to widen the roles associated with CDTml_high2local_u at login?
>>
>> It helps if you post your full policy related to this and also the output
>> of the following:
>>
>> seinfo -xuCDTml_high2local_u
>> seinfo -xrCDTml_high2local_r
>> seinfo -xtxferHigh2Local_t
>
> Attached as seinfosnip. You'll see that the final seinfo output is
> much too broad, I need to narrow down some of the access rules once I
> get basic functionality working.
>
>> That shouldnt matter, but it helps if you post the full policy rather
>> than snippets.
>
> Didn't want to overwhelm things! I've attached the full policy, CDTml.te.
>
>> getconlist:
>> getdefaultcon:
>
> I'll look into those next week.
>
>> There is also a boolean that might affect things (but speculation
>> without a closer look at your policy):
>>
>> ssh_sysadm_login
>
> I removed the bogus role perms and tried again, with that binary set. No effect.
>
> Thanks again!
>
> P
>
>
>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
