Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDEC43381
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 07:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91880218C3
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 07:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3AkPa6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfBRHIl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:08:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42252 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfBRHIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Feb 2019 02:08:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id j89so3516156edb.9
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 23:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wDHXGCJCGEVMENhIicYWOefm0iwwZAGrGOIPB+Q9YHA=;
        b=E3AkPa6Y7/u5nhzo6oEBzESLZjQENWuonfvFa3/Z8VMkX/fXySmLoztSgLbaQIKz0j
         cPJn6wpBLR0S29hZUnGngyp9pSZd2DOiUTV9FHD7ylya9oa9kMNHFmQsLVP+C7/6wrsf
         DuderMZVXFYD5R26RRmzGamaq3u4B19JGQvDZWpFuKlc+gUk3S1lDpyq4qu0M1YxZ0GS
         QCkFSJRlVeNCSg9QvQarsnn9DuSFWgJsDo4zNV8vyVeJ68AS6PVIxeY3In3HVMKPiUb5
         QfXVnIk9nzAjKFgJ1UVnAnvIQChg3ro3GqYd/Jl/zVBt+f6JjKQiEqqVf3rKf+RR4cT2
         lciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wDHXGCJCGEVMENhIicYWOefm0iwwZAGrGOIPB+Q9YHA=;
        b=RtAjnPFSvNfcu0fOVgANFq5Iv/poAF4EqbSmBJNcP5medDBgx/c0PZd0CJbnJpas5R
         7KHBJh5XtvZoRVC1/VamKgdsy1MaLUnfidW2TzJWz3NjpxKysCeAlENd9j+YEk1bd8PW
         hrZGcke+U150ewoV2GvW1pmIdnw0H75HLWWApNY/oVwyq0gpl27V0xBU/2eRud/ggWVW
         XU1Ed3V4iT7/v5/WQ/ObtVX2W3hqHTjeSn1rp8DzBIYOVcgp/o21XFu+AjB/rvEq/kVL
         pFAnFRmios4kmJLGgb70RWJ0EnqUiYW9mwhfNMdnst5I55Ejkg59OM/+Y1dfyKvDlNJf
         7Lfw==
X-Gm-Message-State: AHQUAuacld2ZAFXcVEA9eb1LcK80hzJGEt/ZaigxZ4bdiQkwpbAsMzrl
        rtMc8bCXSE/1PI4W9vl4YMA=
X-Google-Smtp-Source: AHgI3IZGqSXSCoImzkkDK+FaNtm5M8na8BmfbCR01Fr04vTTKyA+KpWVxGQbgLTo+RTyv8Hk1GaRrA==
X-Received: by 2002:a17:906:2ad2:: with SMTP id m18mr3599786eje.89.1550473718806;
        Sun, 17 Feb 2019 23:08:38 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id s3sm2823878ejq.61.2019.02.17.23.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 23:08:38 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        Petr Lautrbach <plautrba@redhat.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
References: <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
        <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
        <87zhqxkn8a.fsf@gmail.com> <87r2c9klrh.fsf@gmail.com>
        <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
        <87lg2g97sr.fsf@gmail.com>
        <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
        <87h8d4974p.fsf@gmail.com>
        <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
        <20190216120412.GA11908@brutus.lan>
        <20190216121256.GB11908@brutus.lan>
        <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com>
Date:   Mon, 18 Feb 2019 08:08:35 +0100
In-Reply-To: <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com>
        (Paul Moore's message of "Sun, 17 Feb 2019 22:12:53 -0500")
Message-ID: <87d0np8tfw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift <dac.override@gmail.com> wrote:
>>
>> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift wrote:
>> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley wrote:
>> > <snip>
>> >
>> > >
>> > > Oh, I see: scripts/selinux/install_policy.sh just invokes checkpolicy
>> > > without specifying -U / --handle-unknown, so the policy defaults to deny,
>> > > and that would indeed render dbus-daemon and systemd broken with that
>> > > policy.  Might be as simple to fix as passing -U allow.
>> >
>> > I have looked a litte into this and here are some observations:
>> >
>> > 1. You can boot mdp as-is in permissive mode if you use `checkpolicy` with `-U allow`
>> >
>> > 2. You need *at least* an `/etc/selinux/dummy/seusers` with
>> > `__default__:user_u` and an accompanying
>> > `/etc/selinux/dummy/contexts/failsafe_context` with
>> > `base_r:base_t` to boot mdp in enforcing
>
> Wow.  I didn't expect we would get to this point so quickly.
>
> Originally my plan had been to just merge the mdp changes that Stephen
> submitted, and leave the rest for some other time.  Although based on
> everything in this thread, it looks like we are really close to having
> something that you can build and boot without too many hacks.
>
>> > 3. There is an issue with checkpolicy and object_r:
>> >
>> > PAM libselinux clients such as `login` try to associate `object_r` with the tty and fail.
>> >
>> > if you try to append: `role object_r; role object_r types base_t;`
>> > to policy.conf and compile that with `checkpolicy` then the
>> > `roletype-rule` does *not* end up in the compiled policy for some
>> > reason.
>
> This sounds like a bug in checkpolicy ... ?

Yes, looks like it

>
>> > thus, you cannot log in because object_r:base_t is not valid.
>> >
>> > To hack around this add `default_role * source` rules to policy.conf and recompile.
>> >
>> > This will allow you to log into the system locally in enforcing mode.
>> >
>> > 4. I also noticed that fedoras' ssh seems to hardcode `sshd_net_t`
>> > for its "privsep" functionality so, while untested, you probably
>> > need an `openssh_contexts` with `privsep_preauth=base_t`
>
> Petr, what's the deal with ssh on Fedora?

I wonder whether it would be possible (and feasible) to not transition on
privsep_preauth at all *unless* a privsep preauth type is specified in
openssh_context.

Currently it falls back to a hardcoded type to transition to if
openssh_contexts does not exist.

Then again, i would not want to risk breaking or regressing some of the nice
functionality openssh in fedora has for selinux. It's state is currently
very good even compared to RHEL.

>
>> The `install_policy.sh` script should probably also do a bash file test for `checkpolicy` and fail gracefully if its not found

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
