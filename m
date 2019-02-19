Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B34EC43381
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 12:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2B321736
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 12:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob9tqlWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfBSMlC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:41:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34801 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfBSMlC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Feb 2019 07:41:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so16657770ede.1
        for <selinux@vger.kernel.org>; Tue, 19 Feb 2019 04:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSPKaIDa+JwHv59X5mD8CzbkfCn/dFs/O5RH6RPQ2Ls=;
        b=ob9tqlWVlOAchndaaWtbsSvBLUhBbc+jD2upMKvH+4qYFXjMh2W+SnRTnyVS1QkPx9
         JVcu34+cQ2yqgNBtjlCfFelXppQ5/lwf500P5UDmHBknQpvl6zYeCuBv4Ov7JVtO9gS+
         OPverRAVGITbz+OFTukMDQaYLGLrRGki/6u6iyLd9qCiDh2a3HgaCqOZhkp5mjjgChb7
         b7vGDAHp8tnPfwQD3U1ne73RxpwTv+HhpF0Vgy6U0bSQmn0306yGrSE/3T4GAEmohDGR
         NOqSjOctzp37SEFpeVK+TM6Vkk2axYoLUtIi7C0lYmfNxu0J3Otq5qURtDbeWktYWoMP
         XLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XSPKaIDa+JwHv59X5mD8CzbkfCn/dFs/O5RH6RPQ2Ls=;
        b=U25xJeas1dylzUOiVfAgHqRubQKW8Rj3IwYpRbWUDB+8o4nyD2IIbqGHqXLlboniw+
         iAg84XKjzG1FxWbVfWHkxYb0GDlf1h9xnLbKqhRS3Crs0F5eM8+L3QCfFzDO0SWoxqmt
         jLbltm74xGfwgs+cA4qEme0VFBCseu3ZCbJPNIjqLJ0aRuWpjNz7WIu8L8vuyDlV4y69
         Q3LfLE6i6hr57KEsorUjpAt6dgxJITeKDtItAUlErbw5hzlO5Uum0ouJP0uPSsQMzWHw
         M3ffLAfy5gPEQ3YMSEfYwt9dAgQ9kSqVWIl2k4+kCVp8BWpdapEQV8g9e+WbbMHevBOs
         HGcg==
X-Gm-Message-State: AHQUAuZAsQG2GPSs7rk6jRw7/L+8Arl4rReXS1DoHMi64DLXqRgOmnr7
        Ia4GzQZ4StsdaGY3Sj4a8BU=
X-Google-Smtp-Source: AHgI3IYEbYXnOQsNxWiX5BxbdXisAuvqnAZQHfZQSCl+RAH2gnRvgILHxZb/ajXgvM+ypsRsTYgByg==
X-Received: by 2002:a17:906:d1cc:: with SMTP id bs12mr20306774ejb.79.1550580059869;
        Tue, 19 Feb 2019 04:40:59 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id g5sm867078ejj.42.2019.02.19.04.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 04:40:59 -0800 (PST)
Date:   Tue, 19 Feb 2019 13:40:57 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
Message-ID: <20190219124057.GA13993@brutus.lan>
Mail-Followup-To: Petr Lautrbach <plautrba@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <87lg2g97sr.fsf@gmail.com>
 <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
 <87h8d4974p.fsf@gmail.com>
 <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
 <20190216120412.GA11908@brutus.lan>
 <20190216121256.GB11908@brutus.lan>
 <CAHC9VhQsj8UnV=CZ+vkvruB6Nn_W7SzW-W4oTK9=QcJRkfeiJg@mail.gmail.com>
 <87d0np8tfw.fsf@gmail.com>
 <pjdmumsm0zv.fsf@redhat.com>
 <87wolw6jk3.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <87wolw6jk3.fsf@gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 01:37:16PM +0100, Dominick Grift wrote:
> Petr Lautrbach <plautrba@redhat.com> writes:
>=20
> > Dominick Grift <dac.override@gmail.com> writes:
> >
> >> Paul Moore <paul@paul-moore.com> writes:
> >>
> >>> On Sat, Feb 16, 2019 at 7:12 AM Dominick Grift
> >>> <dac.override@gmail.com> wrote:
> >>>>
> >>>> On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift wrote:
> >>>> > On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley >
> >>>> wrote:
> >>>> > <snip>
> >>>> >
> >>>> > >
> >>>> > > Oh, I see: scripts/selinux/install_policy.sh just invokes > >
> >>>> checkpolicy
> >>>> > > without specifying -U / --handle-unknown, so the policy > >
> >>>> defaults to deny,
> >>>> > > and that would indeed render dbus-daemon and systemd > >
> >>>> broken with that
> >>>> > > policy.  Might be as simple to fix as passing -U allow.
> >>>> >
> >>>> > I have looked a litte into this and here are some >
> >>>> observations:
> >>>> >
> >>>> > 1. You can boot mdp as-is in permissive mode if you use >
> >>>> `checkpolicy` with `-U allow`
> >>>> >
> >>>> > 2. You need *at least* an `/etc/selinux/dummy/seusers` with
> >>>> > `__default__:user_u` and an accompanying
> >>>> > `/etc/selinux/dummy/contexts/failsafe_context` with
> >>>> > `base_r:base_t` to boot mdp in enforcing
> >>>
> >>> Wow.  I didn't expect we would get to this point so quickly.
> >>>
> >>> Originally my plan had been to just merge the mdp changes that
> >>> Stephen
> >>> submitted, and leave the rest for some other time.  Although based
> >>> on
> >>> everything in this thread, it looks like we are really close to
> >>> having
> >>> something that you can build and boot without too many hacks.
> >>>
> >>>> > 3. There is an issue with checkpolicy and object_r:
> >>>> >
> >>>> > PAM libselinux clients such as `login` try to associate >
> >>>> `object_r` with the tty and fail.
> >>>> >
> >>>> > if you try to append: `role object_r; role object_r types >
> >>>> base_t;`
> >>>> > to policy.conf and compile that with `checkpolicy` then the
> >>>> > `roletype-rule` does *not* end up in the compiled policy for >
> >>>> some
> >>>> > reason.
> >>>
> >>> This sounds like a bug in checkpolicy ... ?
> >>
> >> Yes, looks like it
> >>
> >>>
> >>>> > thus, you cannot log in because object_r:base_t is not > valid.
> >>>> >
> >>>> > To hack around this add `default_role * source` rules to >
> >>>> policy.conf and recompile.
> >>>> >
> >>>> > This will allow you to log into the system locally in >
> >>>> enforcing mode.
> >>>> >
> >>>> > 4. I also noticed that fedoras' ssh seems to hardcode >
> >>>> `sshd_net_t`
> >>>> > for its "privsep" functionality so, while untested, you >
> >>>> probably
> >>>> > need an `openssh_contexts` with `privsep_preauth=3Dbase_t`
> >
> > "sshd_net_t" is really hardcoded as a fallback but
> > ssh_selinux_change_context("sshd_net_t"); is not a fatal operation.
> > If it fails it just logs a debug message and the type of the process
> > stays unaffected - by default it's sshd_t
> >
> > I believe that openssh_context is not necessary if you don't mind or
> > want to use different type for privsep preauth sshd processes.
>=20
> Thanks. So just a warning message. Might be possible to only log it if
> debug is enabled?

Whoops sorry. I overlooked the remainder of your reply. Thanks for addressi=
ng.

>=20
> >
> >
> >>> Petr, what's the deal with ssh on Fedora?
> >>
> >> I wonder whether it would be possible (and feasible) to not
> >> transition on
> >> privsep_preauth at all *unless* a privsep preauth type is specified
> >> in
> >> openssh_context.
> >>
> >> Currently it falls back to a hardcoded type to transition to if
> >> openssh_contexts does not exist.
> >>
> >> Then again, i would not want to risk breaking or regressing some of
> >> the nice
> >> functionality openssh in fedora has for selinux. It's state is
> >> currently
> >> very good even compared to RHEL.
> >
> > I think it's feasible without a big risk.=20
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1678695
> >
> >>>
> >>>> The `install_policy.sh` script should probably also do a bash file
> >>>> test for `checkpolicy` and fail gracefully if its not found
> >
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlxr+VUACgkQJXSOVTf5
R2l3pQv/TZ/cFQSAHQY8iIpROtEU9GkAS8EjhYCuvzLOwT4Mavd4YqQwKGI04hAY
aIryIbeGQqbnZ5eXL/mkmVbS+xK2Mv714QqIUa4l/yczMtHHqcvHFIpanDhFZXEU
OtjBktrNbs9iZ/KpIlOYFeGfLFrHt+/MWziwruHwcxOHZWrwjSMGZGO0Yl7soxCD
T+ivW+4y9nJP7ICp4G1KAcr5l+5e9RgvAHXPYNX3dyYCFYFxd8lfY7I/zsNk6Sn3
52Y9lVSf2CnN54fYtb/M/P1a/Ad9XSArchorjGG8lrZ8R/LMG0q9jX1cdVwXgfhY
rBtfdj05oTy5uuTp4H4RyiM2o2w9Q7pxEk3qaAUAM+DJqaMyamqGvX3g4Dggj40D
C0xMJcyAh+goPjMMu6vWLUoMtAHPxbeRMIv3p/odPLTfJqxbDhTzZchXgcnhPS9G
9NyOcYrcWvEQZQmg+FnmKmCR4nOrHQFfKGG0uIRdZzMABG0agXO+zz0KJzHsRnD4
aQzTgyPd
=t5TU
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
