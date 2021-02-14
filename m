Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D49CC433E0
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689F564E26
	for <selinux@archiver.kernel.org>; Sun, 14 Feb 2021 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhBNQdf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Feb 2021 11:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhBNQd2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Feb 2021 11:33:28 -0500
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84256C061574
        for <selinux@vger.kernel.org>; Sun, 14 Feb 2021 08:32:48 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6957C2A0CF2;
        Sun, 14 Feb 2021 17:32:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6957C2A0CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1613320366;
        bh=sa4mXuVenuq2f3O7YMBpRySkykK7F9CFVzj9pG0ZzAQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mZFcMiDM8xGY0nIRgXnHaoP530kXgHTkg1mj4CSHdG3iTPa+sTorSGGeJ+Iz5OuiU
         gg/+XXThkODI/zjJVzzy504+Yw4jrSGEFvUsml6BopqOt28U10CSCp8QSxR24fAhAT
         Osy22hdyki41l7QYgMjA3Vg9bHq5rPGsdfKrc5eE=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Peter Whittaker <peterwhittaker@sphyrnasecurity.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: Defining SELinux users, "Unable to get valid context...". Help!
References: <CAGeouKF3jSsvDosCWDb3q4RSq8g1RiZma6V1N=1ZaSUtf2TadA@mail.gmail.com>
        <ypjlblcppx6o.fsf@defensec.nl> <ypjl7dndpvoy.fsf@defensec.nl>
        <CAGeouKEX-suBZgmCniX=FLUB4LxyfK67=NyDRdqoCfpHnzYk+g@mail.gmail.com>
        <ypjl35y1ot14.fsf@defensec.nl>
        <CAGeouKFS+VOoPZhxCBN0awMqjsc1b59kiZMU_jyHJ+G+4sO2LQ@mail.gmail.com>
        <ypjlv9awo2iy.fsf@defensec.nl>
        <CAGeouKEmq5aiGT7ByaSZBAZ0k5C=epmkDZzvZzW7taMpr3BADQ@mail.gmail.com>
        <ypjlmtw8ne46.fsf@defensec.nl>
        <878dc2cd-5691-328e-d258-805fb14517f4@gmail.com>
        <CAGeouKFG_JkoBH=iUeD-nsPTHQPJqm2wUVnr22oOE=knsQo3Vg@mail.gmail.com>
        <ypjlim6vog7a.fsf@defensec.nl>
        <CAGeouKF5n_HU3h7tMEOFr3S0dXAQjbhMPtgi=AB5g9i3w1s_aw@mail.gmail.com>
        <ypjleehjnm2m.fsf@defensec.nl>
        <CAGeouKFKT5dj8E7YOS-+jG0v=vO1r8HoJGi6weSy0zwRgD=4hA@mail.gmail.com>
Date:   Sun, 14 Feb 2021 17:32:42 +0100
In-Reply-To: <CAGeouKFKT5dj8E7YOS-+jG0v=vO1r8HoJGi6weSy0zwRgD=4hA@mail.gmail.com>
        (Peter Whittaker's message of "Sun, 14 Feb 2021 11:25:49 -0500")
Message-ID: <ypjla6s6obit.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:

> On Sun, Feb 14, 2021 at 2:32 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> Peter Whittaker <peterwhittaker@sphyrnasecurity.com> writes:
>>
>> > Yes, I may need it, but at this point I want to understand why one
>> > works and the other doesn't.
>>
>> I know that the openssh-server in red-hat based distributions has custom
>> selinux patches.
>
> Well. Just fixed it by accident. The relevant line of /etc/pam.d/sshd was
>
>     session    required     pam_selinux.so open env_params
>
> In an attempt to debug the problem, I changed this to
>
>     session    required     pam_selinux.so open select_context
>
> PAM did not ask me for a context, but did set the context correctly.
>
>     session    required     pam_selinux.so open
>
> also worked fine.

oh right! ... yes corner case...

to make it work with env_params you need:

allow xferHigh2Local_t self:context contains;

Sorry for overlooking that

>
> I need to do some research on this. The env_params option was a system
> default, I dislike changing system defaults unless I understand why.
>
> Now to figure why the auditor's context is failing to be set.
>
> P
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
