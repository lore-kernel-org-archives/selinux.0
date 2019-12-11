Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE6C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612C32173E
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neVTWx63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfLKOVa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:21:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55818 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbfLKOV3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 09:21:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so7278742wmj.5
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2019 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7v5WGZUGMuUC+AH+TuArPdgK2zDIaY5sMj1jeNsT3Pw=;
        b=neVTWx63ErYGvavmZ/EARboH6hRwyGTOmnLt80JLVj6BElTFsKEbalck7+76TTAvcm
         NZshIDyKZif6qYiTxdwNPlrlN7KnLETprEVRYF4XwH7eW6rat66jXMhQplR31wz6/vov
         EdzlgCFfCkNckRIcLxN04HJIfXf9wTqGzIab4gtDhXjrx678YNLCB2PiLTMwqOZ7Ape+
         7s1L25LQPTTQL3kpDB3UDvUTA3Lmt/DKm7EjBCx5Wm87U8kz6792vPWdeVBerwi9aVQU
         rY9Yh2F7BYkRFNi/YM9u1eTf1ot5xXBCIWGy+Jq8J3RvjEbCKqiqg6zIwWeOVLCINlQH
         gV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7v5WGZUGMuUC+AH+TuArPdgK2zDIaY5sMj1jeNsT3Pw=;
        b=dDJTNnue65Tn5TLfZzXMYhRo1QSFuhuqYOtoCR/LfZq+jS+JZJIOVqyuvNS08jeXh5
         KVMU9scMSbPZ/+TCODs4vGcIM/mH2PiEAumGIMVP9jlaZkBAmKuW9+RZx3eykPiefObz
         zoxCaFfARb2uBKgbt6i64m8LUjOtW2S9h6BvmdtVvJOtay2hocEalVfsCWHch1xyKBwb
         2C3r72ZkqTmqnwvM9xQabWgKGerzka5Z1tI2yB9C1BIYr3AH7+UYR9gN7nwjmtdFIg01
         64JByHp3VqaLU6bjjy3ghIgzQtWHE9CGQ2M/rMZ+QL5MsumzpYIs0rH2LG27mmG5JIQf
         T3Vw==
X-Gm-Message-State: APjAAAXSEL46YiIxEX9d2BJs33J/MUK5r0pLVL+W0lyG1DwhEjp72CYJ
        /9pEYwpiVec8Cc6dDYizo8S1wxNs
X-Google-Smtp-Source: APXvYqxFiQcgQTEHuU7C04mZD4t3IydMtKO1+2rAOC58ofujAnlY7yjl60EfuygHVkRUd3RozvhFog==
X-Received: by 2002:a05:600c:2101:: with SMTP id u1mr22487wml.43.1576074087118;
        Wed, 11 Dec 2019 06:21:27 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id x17sm2209339wrt.74.2019.12.11.06.21.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:21:25 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:21:24 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] mcstrans: start early and stop late
Message-ID: <20191211142124.GB2233813@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
References: <20191211134423.2357254-1-dac.override@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20191211134423.2357254-1-dac.override@gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 02:44:23PM +0100, Dominick Grift wrote:
> It stopped too early, exposing a bug in sudo selinux_restore_tty():
>=20
> SELINUX_ERR op=3Dsetxattr invalid_context=3D"wheel.id:wheel.role:users.te=
rminals.pty.pty_file:SystemLow"
> avc:  denied  { mac_admin } for  pid=3D859 comm=3D"sudo" capability=3D33 =
scontext=3Dwheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=3Dwheel.id:wheel=
=2Erole:sudo.wheel.subj:s0 tclass=3Dcapability2 permissive=3D0
>=20
> If we want to be able to reference human readable contexts in SELinuxCont=
ext=3D and nspawn -Z and -L then we need mcstrans ASAP

Unfortunately it does not quite seem to address this challenge, at least cu=
rrently, but still
I think systemd would need to refresh its label cache when mcstrans is star=
ted, as per systemd v245 that should be a little less painful than it is to=
day
Something like a: ExecStartPost=3D/bin/systemctl daemon-reload would do tha=
t then

>=20
> v2: stop late, but do stop
> Signed-off-by: Dominick Grift <dac.override@gmail.com>
> ---
>  mcstrans/src/mcstrans.service | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
> index 09529432..c13cd09a 100644
> --- a/mcstrans/src/mcstrans.service
> +++ b/mcstrans/src/mcstrans.service
> @@ -2,6 +2,9 @@
>  Description=3DTranslates SELinux MCS/MLS labels to human readable form
>  Documentation=3Dman:mcstransd(8)
>  ConditionSecurity=3Dselinux
> +DefaultDependencies=3Dno
> +Before=3Dshutdown.target sysinit.target
> +Conflicts=3Dshutdown.target
> =20
>  [Service]
>  ExecStart=3D/sbin/mcstransd -f
> --=20
> 2.24.0
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3w+18ACgkQJXSOVTf5
R2mImAv+IvFwyl7wZU031TXxo896qZiILfX5ZjutLbEaziEZCm8hvZLwib0aRm4b
dSCAfiV30O7Mpjcfv2D/FOFRWC7KkrDY6QbhPwcWJ0kTlUoKzLHQJeV6pk1nvQuL
6gyL5taIVx4vPwifO6XDyO+rWkOsMIEpEATzZwDVT45O3lkgZWntg2EAEB423Sfw
UC4NmKTTd6RP1GkQjE9nOizxwPbbY/R6zFRS3IJayA30hPjyICCjjFgHUnfizaKw
An2AVZasL52Tvb2Fre+cA2VzCE09f8G/viKy1Sod2uum/wyrWzLSTkvrW3yYJY5f
TdWiRBp50gbpRpU6H6waKKUr99WLTxeTccbnnJN2cP51jJsgjMOxsWRaHWJuZKgt
rc37gTKICwZRVyDMyDJewmVCJuQ2dRQplhBfNrqqwAPW843lZ29BSMTxQxRHtPvP
7JK9pZxjXkX+W0fgklo7JI/qyLJh4tz2YZqQlAJf8DpRRY4O8SFXlriqTzGABM1E
6V+QaRwq
=fUPT
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
