Return-Path: <SRS0=LR26=YA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA0C47404
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150AE2084D
	for <selinux@archiver.kernel.org>; Mon,  7 Oct 2019 16:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrPZvEGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJGQwB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:52:01 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40992 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfJGQwB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Oct 2019 12:52:01 -0400
Received: by mail-ed1-f42.google.com with SMTP id f20so13101323edv.8
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2019 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y4Oxn3/4IhCgqfBya0E+qHJhE9wN7TMg9j5d0Twg2d8=;
        b=qrPZvEGNSzIegyXjSmx1DclsSIBpo2YHuHPCgqWLm7KhtLIiE3uJ4PJHV+HKlBcCcu
         ZO4aq95WVy8Xq7yKCJWkrLOzW+1nKdH0629YS7WbzPUaTKDfgJstgj37+mSyGGudUUE3
         Q/HDkXtotMjfk07Am96Dd9i6LGg6q4RgKhaxusAzRm/KDySq2dQh1xh4nQUdqfKSYeIC
         XYTDtkHX7V5As0rm6RLQwymluV6LZ1Nx0nr6q87qYbG2lnkghWW2a8aPWUw0ZGwzj6av
         TIVaOol59eq5whLCRSTN+ylVC+N265sCR+7GoaHxOMVsExvWolctHhdWGSxsWYgDebHM
         xnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=y4Oxn3/4IhCgqfBya0E+qHJhE9wN7TMg9j5d0Twg2d8=;
        b=LL3usVvwSZFlRoWPdnGLAvT8tSlaEnyzg9sfUopf0MsNLejwiP81m4MZ3gdIYvq/7D
         fnEXoTQ7Y43Lidcnuu+pCsIB5/G654k6P58xA2BmpWQj1rsrxu2bSQfkckK3gVPT0Ia3
         qvfoc4BaOvYp2hblpGi8fkfy1m9kTREmRgWixmQgA1VYeMogYTko+GW5x+j152pw/6iC
         7R3+wRGv+vRiPaMO0dS4+ZX41AenGDnV1Bzu/W+y8ffOlGZeyeDNC7T20nF1C/e5zkzn
         3f9oOIsUd/6RuLEico+a/u1+oXB1k2Fvm7f3ULQE/fUDnj3WakA4tMElZPjI6w9SPyLX
         lElw==
X-Gm-Message-State: APjAAAVODC+ZTVoGSH5vZIBT4D4tUwURO705bVzspSGTY//xeUKw9VFg
        d4l7I6Eg6lkYTG8cGG/T9n8=
X-Google-Smtp-Source: APXvYqymA8G9g4O+E1KR4KTqaRyX393Zi3TMuy0613jD4df3YU+XJ17RpBwpipKhb02q8Pfe9Uig2Q==
X-Received: by 2002:a17:907:2126:: with SMTP id qo6mr25233534ejb.256.1570467119719;
        Mon, 07 Oct 2019 09:51:59 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id j6sm1903851ejv.36.2019.10.07.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:51:58 -0700 (PDT)
Date:   Mon, 7 Oct 2019 18:51:57 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     selinux@vger.kernel.org,
        Systemd <systemd-devel@lists.freedesktop.org>
Subject: Re: [systemd SELinux] system status permission
Message-ID: <20191007165157.GC1088825@brutus.lan>
Mail-Followup-To: Ian Pilcher <arequipeno@gmail.com>,
        selinux@vger.kernel.org,
        Systemd <systemd-devel@lists.freedesktop.org>
References: <ae9ac0bb-0354-4d5a-fce7-dfc37481f439@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <ae9ac0bb-0354-4d5a-fce7-dfc37481f439@gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 11:03:44AM -0500, Ian Pilcher wrote:
> I am hitting this (non-fatal) denial when reloading a service via the
> systemd dbus API:
>=20
> > type=3DUSER_AVC msg=3Daudit(1570462081.809:743): pid=3D1 uid=3D0
> > auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
> > msg=3D'avc:  denied  { status } for auid=3Dn/a uid=3D0 gid=3D1001
> > cmdline=3D"/usr/bin/python2 /usr/local/bin/test.py"
> > scontext=3Dsystem_u:system_r:denatc_t:s0
> > tcontext=3Dsystem_u:system_r:init_t:s0 tclass=3Dsystem
> > exe=3D"/usr/lib/systemd/systemd" sauid=3D0 hostname=3D? addr=3D? termin=
al=3D?'
> https://selinuxproject.org/page/NB_ObjectClassesPermissions defines this
> permission as "Get system status information," which isn't particularly
> helpful.
>=20
> Ultimately, I need to decide whether to allow or "dontaudit" this
> denial, so any information/pointers on what systemd is doing here and
> what functionality I will lose if I dontaudit this denial would be
> appreciated.

Not sure but this is my best bet:

Generally, i think, its about "getting" information from systemd1, as oppos=
ed to setting things.

Stuff like: introspection, getting info about objects it manages, about it'=
s properties.

Theres a lot of "status information" to be gotten I guess. Introspect syste=
md1 to see what all is there.

But if you reload a unit, I gather, you might get some status information a=
bout it from systemd1.

I guess you can probably see the methods that are being invoked if you set =
the systemd loglevel to debug

systemd-analyze log-level debug && systemctl reload foo && journalctl -rb

>=20
> Thanks!
>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Ian Pilcher                                         arequipeno@gmail.com
> -------- "I grew up before Mark Zuckerberg invented friendship" --------
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2bbSgACgkQJXSOVTf5
R2miZAwAltrMr0Y36TwPMF6pDpBWdAty+gshEoTTKB0SU4jQSb3xB6YGUW00y2PZ
CNORez4rHn8y6hmHAOw3qCaP9D2vdxK5RryMK4K1nru+QpW+3gv+h0ivdKg4i6TG
xLHZMbPXo3Ug8oOeCdTBOFlYciCYq+P/9IkYhtXRZ351ZMM+xi9uMLUColKXLe6F
4cj8XBz+Up4iXlrY8/CiQWyjfgJiVaZS3KcJFTlnVxhDhaGZKyJ6yUH7QZGwa6gX
CYDRU7RZ2wSiFLEH2GYXZjaa0qPdnOtpVeQPXaQNNpP6idY4IY4Wl9AJ/dGddBMD
H/DhVvSQ6nWFDaPrN0Qco05fa7rEO+iBk4QfGlmK/6XhEWnnMhW8pay4a0xrbkC3
tH3vQQqD4H3/xAUFTDJ5DGQYGBhRDU0wsO9BfI624z5dS/3x1MV/lSe9PSWDT000
crvP3LBBBEW/kX1nYW0SV0bJ/zXrmW8J38wuh69qYKgywUFcUCIArduZPV4NgjXH
/Q2qbh2x
=bYQv
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
