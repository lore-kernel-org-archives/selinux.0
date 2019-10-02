Return-Path: <SRS0=0msR=X3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE198C10F14
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 19:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47D220659
	for <selinux@archiver.kernel.org>; Wed,  2 Oct 2019 19:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIY56HV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfJBTlG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:41:06 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38621 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfJBTlG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Oct 2019 15:41:06 -0400
Received: by mail-ed1-f47.google.com with SMTP id l21so262107edr.5
        for <selinux@vger.kernel.org>; Wed, 02 Oct 2019 12:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IR4ZRqCU2qjonA6rOEzgZI++mAMbaRN66PhJ9Whk/qg=;
        b=JIY56HV598V7Pi2kOpyIingEYte8Q56gzgggv7rDkGSGCNKsE284aEjEx/U9vXuciK
         P6OcAWPph+JafqIWvYTWN63+BN+fvXsUx6lIksapSp36JhB+Lxt+iUnmKrSdkYsyw5bl
         d7HRJ4ts1ZIylROd4A0lEUMnda8qGgfgnMN0i+ptJorW9k4sie8Tc2P4uL2H1hj0MSre
         LMqh72viRJ7KrJeejEjY85Rf+fHlFlWEjNWiFhdfj3o3m5yV6HovgwlpEWXRCYaLUSQG
         faMjf6dWqSIm8aB+rnconSxG3oF7m7L4iGot3hLRTxMzqNZIJzJhQqwUVNkZaJwi39Mn
         bbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=IR4ZRqCU2qjonA6rOEzgZI++mAMbaRN66PhJ9Whk/qg=;
        b=WAjFHKnOP2tw85Mk9Jh6y9u1YrS5J2axTXnUiiHL5+Q1n5+9be0J0JMaYCJ8K564xc
         VY90LyQcpDH4cLniUB1TFVL3C5dU2jRACbGHX3/D4HFzGnFJ+6JpEgX6ra+k6OmMBjIT
         3LVmeHppHJppav5+OusSWZCy7ZgLnXULlO90PD491uX3+HDAc6hANw6sHNjhZHWbe2ac
         XwPY4z9nc2u4RAgZRKNwv2FnepgGx7lOY0q/hroztPQdd4g6GmOCElJf4N2M7sb3p08f
         DEnwDeSHBVnOxZ3/jCu+d5dVhYk9aWAMTxC0T5yGCBYrifdPZZ9wOiwn4vSo6He+jCtN
         70jA==
X-Gm-Message-State: APjAAAUMRtyuqmAlbawBD/mQbVBMDAB2YyQm4FCqdRltoouWA1iuluKs
        ZFxMbWAMoX0/3snA4UKpWQh340AK
X-Google-Smtp-Source: APXvYqzuEoxVfdD+ygcjQoVMRONFVnDbLr1u6IufklN4XMKYipDPr9X5Zbi5BQ9lFpOEeilS9cm+6w==
X-Received: by 2002:a17:906:4990:: with SMTP id p16mr4664321eju.9.1570045263220;
        Wed, 02 Oct 2019 12:41:03 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id x17sm17955edl.64.2019.10.02.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:41:02 -0700 (PDT)
Date:   Wed, 2 Oct 2019 21:41:00 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: execve silently blocked
Message-ID: <20191002194100.GB1167620@brutus.lan>
Mail-Followup-To: Ian Pilcher <arequipeno@gmail.com>,
        selinux@vger.kernel.org
References: <43c6d9cc-bf9f-b729-2a0c-54a73fa79fdc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <43c6d9cc-bf9f-b729-2a0c-54a73fa79fdc@gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 02:25:22PM -0500, Ian Pilcher wrote:
> I am writing an SELinux policy for a daemon that needs to exec an
> external program.  The execve call is being denied (permission denied),
> but no denial is being logged, even after disabling dontaudit rules
> (semodule -DB).

Are you also looking for "selinux_err" records?

`ausearch -m avc,user_avc,selinux_err -i`

will return avc, user_avc and selinux_err records if auditd is running.

>=20
> (The execve call does succeed in permissive mode.)
>=20
> How can I troubleshoot this?
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

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2U/UgACgkQJXSOVTf5
R2lvzgv+MhD4iAOH8z/5dPZYhS2FXvtTyB5a0NFyuo7wNoVvs8BMvWNNkxbthgN+
42/tTWbWuk71jygLXJQiCKyKrgnXB2LUqGQrwTXuVwk00ubqdvbNzT2+Ok+hVspj
X4vt8oGrNOgovO2dpkcY6/L8iubKPNu8eSuKla5N6UO3+z52/fxr8p2ZTR9ek44o
H7JwE+8MiN5afbCKbvEdyFsKdgTLzDz+24kMKayS0z7ns8g5YKCBcnk84JXoylg0
YdTttcn/2ZoXUsg9mqlVvqJJt6hTt6lsWs0xuFfITDtBgF5hN/4rhQJvCrWx16pj
JwXPMc5JPzS6wd53AgpOXwL0Ml1GB4JalCf0tdBgza6256ShLYeXkEAq++9Dsj7/
8Kea9jCXdoVXLm1E3qraYPB7AS1z5/6irLC+KgAYMqrlPm2U3eNpMaFV6OTYOwBC
+9Oscg7eY8lK8+CWXpsqKa72obUGps3BGhwMc2qe8xDzfGsDDzjeQOBkgJZCbqZm
bKs9GbNz
=OmLH
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
