Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66CC43381
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A2C2077B
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 08:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drP8IUss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfBSIPN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:15:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32870 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfBSIPN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Feb 2019 03:15:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2so15970430edi.0
        for <selinux@vger.kernel.org>; Tue, 19 Feb 2019 00:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Zm5vyskj7ePCM2A2VdXV16YGyk2IRaJnQBLHWRfXW2E=;
        b=drP8IUssXpblczFifYjBat2Ti2qXod28hpi8XrYuZkWJUf25iJhxXSToWok2p+8ij4
         wwSXVtFkb9hl++cKgGBNGF64k21UoFhY8fJs9y9IAflOxjuSrngQSslr/t20Qi4m+jVl
         /YQwHsABaDUjMtDSDDhhUOWUUvatbRsJoLR7fF+NRTzJaUUckbVou9a+o0pU/+wGqvSs
         Qw6+aM6oHTBAwY9oBegEP17bHFsNq+1FaidEG129cr8rJ2XQ5ZwrmSEkTCUlEDcIsn0U
         pCKB6aIp+Ebj/xfC9z1fypW1TAXNfjAd34sxL8GC1juhR9mazL34e7JwbjB3iqoYmvez
         XxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Zm5vyskj7ePCM2A2VdXV16YGyk2IRaJnQBLHWRfXW2E=;
        b=qyQDwl5TdcuMXdOHy/Ekaw5gEL79rgZB2kYzcV1XeTsDHfJIG/RYzetHUgpielbP0M
         0aCwUYFuwv4wS4zgEbVJgbu5NV5EuFAVDmBw5W8mF9KBBz34Qg1wd20RMD2HRSwXBrVY
         EOf71PxJIWrfzIAZEvk00mSmJGhnxXPQfS07ROxK6H/R4SCUhHWNT5+LeaTU/TMpyTBe
         8nmQ2pDUdJnsw5AlVLyUGjba5FlOAQ+Ltz5rTTeQdQhm68vQ3aDaJSceSLQUsIRLyTZK
         7EjR13lIVVy23Py6UbbeVMGBauggTVLYDW6SUSuPhw0D97eMDvjdlMLQsI8KhNfDRw6B
         wGfw==
X-Gm-Message-State: AHQUAuY8pfdB3WlDVRAov95yDuIZtAqLfX+at1eXYjJzhkPKle1N3AYe
        tQzS3F9g65hDnvXgk/MzHb7QJ3T5
X-Google-Smtp-Source: AHgI3IZ5w6fXd8OKlphnGBKLAAx4gcGLhFSnWXyzFDBB1QgaZjAvHuwIh0r4wccQCY/2yGanobJQgQ==
X-Received: by 2002:a17:906:1945:: with SMTP id b5mr19106075eje.156.1550564110695;
        Tue, 19 Feb 2019 00:15:10 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id x30sm4801148edd.30.2019.02.19.00.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 00:15:09 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        "Stephen D. Smalley" <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
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
        <87d0np8tfw.fsf@gmail.com>
        <CAB9W1A3f1jxJQPrU-o=gEKzgjRGmbThoqPvzbK7QNqprdE-LAw@mail.gmail.com>
Date:   Tue, 19 Feb 2019 09:15:09 +0100
In-Reply-To: <CAB9W1A3f1jxJQPrU-o=gEKzgjRGmbThoqPvzbK7QNqprdE-LAw@mail.gmail.com>
        (Stephen Smalley's message of "Mon, 18 Feb 2019 19:07:33 -0500")
Message-ID: <871s448a9e.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley@gmail.com> writes:

> On Mon, Feb 18, 2019, 2:09 AM Dominick Grift <dac.override@gmail.com wrote:
>
>  Paul Moore <paul@paul-moore.com> writes:
>
>  > On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift <dac.override@gmail.com> wrote:
>  >>
>  >> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift wrote:
>  >> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley wrote:
>  >> > <snip>
>  >> >
>  >> > >
>  >> > > Oh, I see: scripts/selinux/install_policy.sh just invokes checkpolicy
>  >> > > without specifying -U / --handle-unknown, so the policy defaults to deny,
>  >> > > and that would indeed render dbus-daemon and systemd broken with that
>  >> > > policy.  Might be as simple to fix as passing -U allow.
>  >> >
>  >> > I have looked a litte into this and here are some observations:
>  >> >
>  >> > 1. You can boot mdp as-is in permissive mode if you use `checkpolicy` with `-U allow`
>  >> >
>  >> > 2. You need *at least* an `/etc/selinux/dummy/seusers` with
>  >> > `__default__:user_u` and an accompanying
>  >> > `/etc/selinux/dummy/contexts/failsafe_context` with
>  >> > `base_r:base_t` to boot mdp in enforcing
>  >
>  > Wow.  I didn't expect we would get to this point so quickly.
>  >
>  > Originally my plan had been to just merge the mdp changes that Stephen
>  > submitted, and leave the rest for some other time.  Although based on
>  > everything in this thread, it looks like we are really close to having
>  > something that you can build and boot without too many hacks.
>  >
>  >> > 3. There is an issue with checkpolicy and object_r:
>  >> >
>  >> > PAM libselinux clients such as `login` try to associate `object_r` with the tty and fail.
>  >> >
>  >> > if you try to append: `role object_r; role object_r types base_t;`
>  >> > to policy.conf and compile that with `checkpolicy` then the
>  >> > `roletype-rule` does *not* end up in the compiled policy for some
>  >> > reason.
>  >
>  > This sounds like a bug in checkpolicy ... ?
>
>  Yes, looks like it
>
> I don't think so. object_r has always been handled specially. The kernel ignores the role-type definition for it and always exempts contexts
> that contain it from user-role, role-type, and user-range restrictions. We didn't use to include it in the policy at all; I think CIL does but
> we only generate a stub in the kernel policy with the role name and value but no types and the kernel ignores it. What exactly breaks with
> pam_selinux? 

The login program (pam_selinux) is not able to relabel the login user tty
(/dev/ttys0: user_u:base_r:base_t -> user_u:object_r:base_t) and so the user cannot log into the system in enforcing mode.

Maybe a missing contexts config file? I suppose I should look at it
again since you sound confident that this is not a bug. I also suppose
Android uses checkpolicy so they would have noticed?

>
>  >
>  >> > thus, you cannot log in because object_r:base_t is not valid.
>  >> >
>  >> > To hack around this add `default_role * source` rules to policy.conf and recompile.
>  >> >
>  >> > This will allow you to log into the system locally in enforcing mode.
>  >> >
>  >> > 4. I also noticed that fedoras' ssh seems to hardcode `sshd_net_t`
>  >> > for its "privsep" functionality so, while untested, you probably
>  >> > need an `openssh_contexts` with `privsep_preauth=base_t`
>  >
>  > Petr, what's the deal with ssh on Fedora?
>
>  I wonder whether it would be possible (and feasible) to not transition on
>  privsep_preauth at all *unless* a privsep preauth type is specified in
>  openssh_context.
>
>  Currently it falls back to a hardcoded type to transition to if
>  openssh_contexts does not exist.
>
>  Then again, i would not want to risk breaking or regressing some of the nice
>  functionality openssh in fedora has for selinux. It's state is currently
>  very good even compared to RHEL.
>
>  >
>  >> The `install_policy.sh` script should probably also do a bash file test for `checkpolicy` and fail gracefully if its not found
>
>  -- 
>  Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
>  https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>  Dominick Grift
>

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
