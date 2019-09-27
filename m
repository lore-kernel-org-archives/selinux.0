Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B40C4360C
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 08:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A894821850
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 08:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr4hH7/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfI0IYG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:24:06 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:46176 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfI0IYG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 04:24:06 -0400
Received: by mail-ed1-f49.google.com with SMTP id t3so1538104edw.13
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6rlQXqanoHfGdVm3xgwYTmV3L+C2I9QFyFzMTMSHh6E=;
        b=gr4hH7/CpNBAvMEUf3HxPmeTXexiKADLQnpc0Kqoeg7EcK9zFd9WxQCWAIeiVUuyH0
         LppffisjGd4EjMY7uVsUv7AANgnGRyaTupiD0uVKySdAJup02eV7rEmT2pxmo4Xw7GI2
         95uziR4m751on9SMRgHNkMvjYt4WCN0BngT06fVGKnzL2N2CbTKZGhO3kIcBSSbeLd9n
         Y6pau/z3/VXs7GRTt94aRuiMrjE8HWS5i4YMRlYjb00PolR7BZM6UF3akfAgdjbOsw1r
         3JOTTucYXKEruGb8OgPZrHJOtcPrWe3iMuTgOaleVzlJT1LAwQP0E50Zi3t5CQ5uGdJX
         +3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6rlQXqanoHfGdVm3xgwYTmV3L+C2I9QFyFzMTMSHh6E=;
        b=P/TOXCuPqTDtq0VRx1FEyPP5TFKCq4HKPx3FGPW0s6grGbNYGBLvXex97oYht9qzCr
         ICT3nQF2IXijZUUw/9D8wKBEioOS0pzZufaSfMKGxzS7xi3WTJ7R0ZomvBHDXHDDPvpn
         lHs7MohCXS5DoouDi+YJamcn8UiUc5EAxEchQNFkkmmm6KF5VLwx8hd1/5EVMzxNQE+v
         3jAfj2J4OP7dDEkNjYcToTnAXDgdW4yiN+69zh6CCPqUw7NTtwuEePncY+w+N2spwOdR
         U1AWdbhBVE9LmgYQ2ravwzxP8U8tob4cgqP6rC5sK9CzMP2Gq8dt611DJQkLUfKIxMi+
         pBpQ==
X-Gm-Message-State: APjAAAVK8/xYRXZ0Ag/mQYJwoJblkWGB1v6w1ZWMkTI2y4/Q7cS0qYKT
        XvIwzsrhWhU/qN11hYZB8IcEdw6a
X-Google-Smtp-Source: APXvYqzxjus068GzamiKybbD45Htkpib+tVGeLPulrzehijzXkvbxkDTKqclTlgAHBPnlE5m2GRMgQ==
X-Received: by 2002:a05:6402:651:: with SMTP id u17mr3213493edx.104.1569572643838;
        Fri, 27 Sep 2019 01:24:03 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id i53sm371074eda.33.2019.09.27.01.24.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:24:02 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:24:01 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
Message-ID: <20190927082401.GB20555@seamus.lan>
Mail-Followup-To: selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20190927075507.GA20555@seamus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 09:55:07AM +0200, Dominick Grift wrote:
> sudo does not reset the role of my tty properly [1], and i was wondering =
if anyone is able to determine what is causing this [2]
>=20
> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=3D898
> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c

Does fgetfilecon() get the context from the actual path or does it get it f=
rom file_contexts?
If it does the latter then i guess that would explain it as pty/tty context=
s are customizable and thus have no entry in file_contexts:

# matchpathcon /dev/pts/0
/dev/pts/0      <<none>>

In that case i guess it skips the relabel?

>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2Nxx0ACgkQJXSOVTf5
R2ktTgwAjJ9C9pN4IHxVGgHp21kAhFoUZLnaYwG7tWVzxZEG8BBMpJRbJe0NxRG6
KWCNtEh8O3bC0tK6MCtFkRd8kvURwnlUf4qNBMHJw9ZmSrUMaRI95u+ELDFjPQpr
mkHxVoNnqUo2hg9fNApNmGf8+JW/KIjSjksXZsc4lzq066fXFkTO+Ycj2qVfPPiF
XlyMsycCYqULPsp4QA+fbakZgbIF2s9uAoHLuClmumFFb+ltY4K32wcPcy8HKiGX
nLjt4dcfj0s52AKhHZ9SdVG/3U2JW/bH0gCA6mll9jjQD2ExQ+MEla+LyCQ3o2fU
t2Ys4aSPj6IFEyJfUo3+TACiTy/dFfNLfkDmYsYHlcRLpbvhYN0Y8b0Q+WoVhbGc
HG2DOe2qh7ySTlOmzRwEKfboMmxwMrPEWKcltVliDv2+QItOOH+lQMU6PcfSz68A
NNiOtJl+FDtOf35AM2F3FyvUJuAUe/PEg9JoWheQwN/sinBH3aMos1kKckaoiopP
pSts7q0h
=VpsD
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
