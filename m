Return-Path: <SRS0=de3E=QX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E39C43381
	for <selinux@archiver.kernel.org>; Sat, 16 Feb 2019 12:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1F72192C
	for <selinux@archiver.kernel.org>; Sat, 16 Feb 2019 12:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMrnWMrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfBPMNA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Feb 2019 07:13:00 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39854 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfBPMNA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Feb 2019 07:13:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id p27so2488361edc.6
        for <selinux@vger.kernel.org>; Sat, 16 Feb 2019 04:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vIzjwyKFh0qpKEVFYwkVlUhep6O45SqpbDeAqQhzy8=;
        b=tMrnWMrcbY63OK4ALiNuhyp+HIhxVhuBBWhJj81NfIzkqLitUIbfTs0rO3BfD59Rx/
         ITv67rTsnMxVYuvJdihFpuuE3kpkhh/ZDhb4I3wZ0wj9D2slHSBREkA7zVo+Gdp9d3RE
         WwU/9oyBG/i9NGv52i3/abrqdFjyYvwfxHayV7CVtxaiI07eZTiKgWmt6NDbne04E110
         uTT/mPPw30xrOg8Z0nbMOOoh1zhB7ci/vsQX2moWOb4KSQm8VNqOCv9LXrKIxSErtWLY
         Dv49NxyKQE26vM3Kr35BjWPWxqXSrzcWAgdsccJ3j8+J0h7RejzleQ0tg1GRTP9QSn6r
         fROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0vIzjwyKFh0qpKEVFYwkVlUhep6O45SqpbDeAqQhzy8=;
        b=FUVgnqEnXogGKyikRDBhvsEW1xsAAygOEQ5VuZx8dO1KLsu7Ciwg4aiGRv/NfLMDAd
         O1uZaQOXCo6u7YnjxuXuQaW8hAXz1omBo5mSki6WHhf9DPL0u/RKCSUnHUOU8mmlXyeb
         /ZyWcnTrr1PSGU3oEKsgEJlrdmkHhpGmnDGpvIUYBh64ddnbCer7Y3hRNDFHldpyrrvO
         EF8qfKA+OWYnuWjZUNfeWW/wnYh+MeNn9tiPz4QzNz6A0JOppGBfc98Q0E1Nb0F12ubY
         gihu6UOly6NmxPFFc7Bd+r7bv2vOXm/4RevkcT40dYKEFn10CSHwkWIpSEzWkSgp3fIM
         uN5w==
X-Gm-Message-State: AHQUAubDTLbgjTTeNqEKwH10xFk/miNr+19SrKYh20VDuQd0MFTkDVtQ
        YSqn6ZzdwOpQnEdH5f7wiUa6DfKH
X-Google-Smtp-Source: AHgI3IaQJujvh0QwRgD37b52tqt0J+ZdvHzvh7jlVYLskI31SMHFG3UEU0H1AW9ez/cHLR7oJG7RuQ==
X-Received: by 2002:a50:9938:: with SMTP id k53mr6601510edb.134.1550319178449;
        Sat, 16 Feb 2019 04:12:58 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id c12sm2225711edi.52.2019.02.16.04.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 04:12:57 -0800 (PST)
Date:   Sat, 16 Feb 2019 13:12:56 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
Message-ID: <20190216121256.GB11908@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
 <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
 <87zhqxkn8a.fsf@gmail.com>
 <87r2c9klrh.fsf@gmail.com>
 <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
 <87lg2g97sr.fsf@gmail.com>
 <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
 <87h8d4974p.fsf@gmail.com>
 <27efd865-7d08-fc61-e004-0a07f27e165e@tycho.nsa.gov>
 <20190216120412.GA11908@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20190216120412.GA11908@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 16, 2019 at 01:04:12PM +0100, Dominick Grift wrote:
> On Fri, Feb 15, 2019 at 02:48:45PM -0500, Stephen Smalley wrote:
> <snip>
>=20
> >=20
> > Oh, I see: scripts/selinux/install_policy.sh just invokes checkpolicy
> > without specifying -U / --handle-unknown, so the policy defaults to den=
y,
> > and that would indeed render dbus-daemon and systemd broken with that
> > policy.  Might be as simple to fix as passing -U allow.
>=20
> I have looked a litte into this and here are some observations:
>=20
> 1. You can boot mdp as-is in permissive mode if you use `checkpolicy` wit=
h `-U allow`
>=20
> 2. You need *at least* an `/etc/selinux/dummy/seusers` with `__default__:=
user_u` and an accompanying `/etc/selinux/dummy/contexts/failsafe_context` =
with `base_r:base_t` to boot mdp in enforcing
>=20
> 3. There is an issue with checkpolicy and object_r:
>=20
> PAM libselinux clients such as `login` try to associate `object_r` with t=
he tty and fail.
>=20
> if you try to append: `role object_r; role object_r types base_t;` to pol=
icy.conf and compile that with `checkpolicy` then the `roletype-rule` does =
*not* end up in the compiled policy for some reason.
>=20
> thus, you cannot log in because object_r:base_t is not valid.
>=20
> To hack around this add `default_role * source` rules to policy.conf and =
recompile.
>=20
> This will allow you to log into the system locally in enforcing mode.
>=20
> 4. I also noticed that fedoras' ssh seems to hardcode `sshd_net_t` for it=
s "privsep" functionality so, while untested, you probably need an `openssh=
_contexts` with `privsep_preauth=3Dbase_t`
>=20

The `install_policy.sh` script should probably also do a bash file test for=
 `checkpolicy` and fail gracefully if its not found

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlxn/kMACgkQJXSOVTf5
R2lF/Av8CgCja13BXR7HjQhUJFMFIEqFvkJ7IP++e5G3ZkK1mXMMVhiEIY/iEhML
Hpzql7Qy9y59loONsANxuMprzO25C9ReGkD5tsEzfNKi9+9+tGHCNX/RSzDwzJcF
oCOjaUnyqwrjqZSDUMxqUoRkANlIb+BqCgabAn8KBo9a6QXPAvprMMEXvLqNO+mx
8NTceq3Tdz4d/md8X/Z1SE+1iOFo/1KUQOUpF58XSD7heIXG6LhMoGxnqzCS2d8+
onfaSlvvOZ4coH4OWIyjbkGX8dR8T7+gnYxFV+ZRMkH+ga93IHl1/+3rAtuAkY70
VMXpZuDSdWMWogLGJ4HW3t2wXrE7sfHNylO+nz5B8KaS0dGRq1MqbyYES/vv30P0
KcFhvV0RLIEKxt3vtYWS/sCOC7k4GnLNhTd1Ha0xpnJ683Krd33Tb+Z3yeODbAGJ
6ZpTpBhiMLr0bqHzfHaX/9SOVY8q804QkfYX9qCI3UtJz4lTPpjZfQBFxc3aMZUw
yI+Le0UV
=pbOd
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
