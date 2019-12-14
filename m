Return-Path: <SRS0=NFTj=2E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBADFC43603
	for <selinux@archiver.kernel.org>; Sat, 14 Dec 2019 20:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BAF20866
	for <selinux@archiver.kernel.org>; Sat, 14 Dec 2019 20:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0/cHgWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLNUaj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:30:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40020 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNUai (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 14 Dec 2019 15:30:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2369984wmi.5
        for <selinux@vger.kernel.org>; Sat, 14 Dec 2019 12:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UOxhi6+Z0aq+uYOx5yjJOikHBP2UaOly8Rh6ZJVM/4=;
        b=J0/cHgWlH3frV+cw6uWr409Vw+hIoeOIl7lY2gI+rd8GDPCdsghT5b3PLu8vt7CbW0
         jG5Ua+C/0eIy83a7PSqYLOGEfA8OB3Q/hZ3rg7N4XLownMM6iO/1C9O0fGYzpqWpJXs6
         sNXVyy1xhxgJkRR+GAJaIzOqpTaHEJxX5/ur1vBnuZwQI7pBhRvijBHjS5YgFd+dYtE1
         Fxa2wx5Doe4/vbwjrUVIxH2XviMTjE/TbBwFg+mZdqnn6NtfwjKBB26s6sKQkIMVaQBv
         7zKe/I+1I4VAFoIn2DQjfcHAbWVBRgqS3X2dFFxfbNnghW/ybN9B6+jSpOsRM4KdqlWu
         OetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6UOxhi6+Z0aq+uYOx5yjJOikHBP2UaOly8Rh6ZJVM/4=;
        b=MZc6o09CH0TGlaUUKyLyJYrcywnBPgSIf9uRklsOCKvnqbQgjZt34GYPBGBfJFZgGJ
         XvP/avYMTwLtAvgGA5OmAHZrKDGhiCBwsmOeHRf3AlyNMG/Fazxu11a5LCrDdwThBKsb
         PxR8GdhrdufO/cd837lGpLvq9W7V75CAcdCiIsS+gjfm6dyW5vIVQxLeVjloxxUfOXt7
         qYWXa2hL7fZEbiw00YjlGYVlk5vub2Ju4n+d/N6vrr0mINV7oDAmICf69HrCR2JgBtZL
         LU4cxA0+m0DusJiWOEWGtCcVvxgK14jsQmrRpQW4DZ2INLFo9Op1Ne+46n289ghghYJP
         S2dQ==
X-Gm-Message-State: APjAAAXwxv1bO6ousxpDmTRi6nZBiLLNpx+QO9L+kHG2UQorZnUBjH9/
        xnfCt7smFb2+hGDYGoBROkNAFNOp
X-Google-Smtp-Source: APXvYqyZLvPtlPGznAznstlCnqfq4s69OilaKGXxzhugI9V/NBM3RJ31ql8Js6srejxFPXUQn5FQaw==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr20010611wmc.70.1576355436807;
        Sat, 14 Dec 2019 12:30:36 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id o15sm15597066wra.83.2019.12.14.12.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 12:30:35 -0800 (PST)
Date:   Sat, 14 Dec 2019 21:30:34 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     selinux@vger.kernel.org, acgoide@tycho.nsa.gov, paul@paul-moore.com
Subject: Re: "watch" - Problem when using kernel >= 5.4
Message-ID: <20191214203034.GA233591@brutus.lan>
Mail-Followup-To: Alexander Wetzel <alexander@wetzel-home.de>,
        selinux@vger.kernel.org, acgoide@tycho.nsa.gov, paul@paul-moore.com
References: <9d54debb-7031-4d93-38b7-62c853289512@wetzel-home.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <9d54debb-7031-4d93-38b7-62c853289512@wetzel-home.de>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2019 at 05:40:51PM +0100, Alexander Wetzel wrote:
> Hello,
>=20
> I've a strange problem with selinux when switching a kernel >=3D 5.4.0 and
> since this could be an unintended regression I want to report it here, to=
o.
>=20
> There are two threads in the Gentoo forum with more details:
> https://forums.gentoo.org/viewtopic-t-1105128.html (started by me)
> https://forums.gentoo.org/viewtopic-t-1104916.html (looks like the same
> underlying issue)
>=20
> In a nutshell commit ac5656d8a4cd ("fanotify, inotify, dnotify, security:
> add security hook for fs notifications") added new hooks for fs
> notifications which also seem to requite updated user space and policies
> which seem to be unavailable as for now.
>=20
> So when updating the kernel to >=3D 5.4.0 all processes trying to registe=
r for
> file notifications will be blocked. And at least I was unable to add rules
> for the new permission "watch", even after updating all selinux
> tools/libraries and policies to the upstream git versions - as provided by
> Gentoo's -9999 version of the packages.
>=20
> Dec  8 14:49:01 web kernel: audit: type=3D1400 audit(1575812941.870:2069):
> avc:  denied  { watch } for  pid=3D2826 comm=3D"crond"
> path=3D"/var/spool/cron/crontabs" dev=3D"sda3" ino=3D2539899
> scontext=3Dsystem_u:system_r:crond_t tcontext=3Dsystem_u:object_r:cron_sp=
ool_t
> tclass=3Ddir permissive=3D0
>=20
> I ended up reverting commit ac5656d8a4cd ("fanotify, inotify, dnotify,
> security: add security hook for fs notifications") and asked in the gentoo
> forum - so far without success (link above) - how that should work proper=
ly.
>=20
> If there is a way to use an unmodified kernel >=3D 5.4.0 with older (so f=
ar
> all current) selinux tools and policies I did miss it.
>=20
> Do you have a pointer how I can keep the commit ac5656d8a4cd in a selinux
> enabled system in enforcing mode without breaking all file change
> notifications?
>=20
> Alexander

I do not believe there is a regression. However support in the policy for t=
his functionality may be lagging behind (be non existent as of now).
You could try this as a temporary workaround:

echo "(handleunknown allow)" > mytest.cil && sudo semodule -i mytest.cil

If that works then that should tell selinux to ignore the watch access vect=
or permissions (and any other permission unknown to the policy).

>=20
>=20
>=20
>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl31RmUACgkQJXSOVTf5
R2k84gwAscgv2tncBRUSohI2ltWz1G9JkSHNE2wI6HfSGwla/pNB6owzAw8g/0S7
1JqNDodw6dBnlokf4gSpoaI5//nZr00ggIwRnLNY+VKQ+O8HDytcvPrFKJeOzgCS
QSmDGVHE9H5LjP2WnRn0U9XVh1fvGwlNwNgmlFsIac8igH1dUN0IHlwWbLUEQe47
vbwDkk8K1A4c/nRLxA+ptf0K1a2IEYJtX2PPiaxLpmyP9fchz0HtaBO6qw0IhR/z
qvzsnCum83tlWQzP+0naAd+Bu1OxFg229kp/rL4tJwOap9ZlXwZwRwglWA8y2ww5
3emtUs7ZUGzHlyhnv/vZeZuT2AVS+4DoGGk1P0/d07j+33IEv3ZXlTy/A4ng4zli
xb1PwXzlIkNFXY9z9z8zcjVM7+XX+CJTzvUzob307IXztZxbnv/ojVxiZdisrDmN
VZv6AVd9fRnVqgq99uQ1clf1SU+XjNy/JI3LcFCvWY05IN7HBCMTVjCBVBjYcIYA
IoOSz3UQ
=c1HT
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
