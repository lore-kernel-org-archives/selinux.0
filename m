Return-Path: <SRS0=yfq3=WM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179BAC3A59C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D2D2077C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 07:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbhpDbFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfHPH1t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:27:49 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34951 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfHPH1t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Aug 2019 03:27:49 -0400
Received: by mail-ed1-f47.google.com with SMTP id w20so4336313edd.2
        for <selinux@vger.kernel.org>; Fri, 16 Aug 2019 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=+bRGjtVg+frD6eP+K0FNi/JLrNMGmrY79+AiqT0NHwY=;
        b=JbhpDbFkT1ZJCyvluk5l4CaZR6DFkeS5zVcg2wx0ZsJ3jeKOi7lBwNZu+0OCp348F7
         eR9HF8YB+Pwfst3b0kcY+sxiv8A7WJPIT8XFeKZsCGVb9N0T1sDJur23PJsL3NShA2gf
         XUmmqFODvMzz5PsHabiKzXtdrZdPnmiGr4lQldxoal/PH6DaFpBodxZ3nOWPzC0Dg2K5
         LNVbAy1EAitDe6OCJunq96rMJ1QnUo6DWFut46x4/8MPU0aM4IOLlUe4ePIriBet8KsX
         DWkLKRRNmeQshKA8ouYFGxK4w9Z29QRacgejZVYRrls9BLInHTB+ya0FN/dTj3ir6sNj
         vS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=+bRGjtVg+frD6eP+K0FNi/JLrNMGmrY79+AiqT0NHwY=;
        b=hB4KdIy/8ewZ3VH8Rr0tQhpc6WvvA+sK1N28eg137qI8X8J8EVqLZmISba7mJkdf/p
         OcE921v2Muh5kfo/LeIbYrU3bAciqNW4icN+txE7u6yXl5PxY+XHbVsJFCP+Gzn7bfXz
         HszohS4brgIf4WOVbB5Ik1mfEvPMggyy2BN1p1kWMQzF7iX283gCSisRhd5eV3Su82xc
         I/dKYLl/fiCWddjh3cpAflavhEyx3qZW3GwkDMPWq1q2zfokaauLu4qVXlpjUgAsSMF3
         fwc2g8j2ESODFJmX6TdflLXLpDTi6SMXYk7cssLGMFprXu6yxwyzp7tG1cgQFHW9YV0a
         yokA==
X-Gm-Message-State: APjAAAXgg5FE2QPVka8T0EYTQdvPPs/ZT2+jykt9b9pkgdyQv8X2ApxT
        WfFIB19eqraKmQEGTlu0f7eF5JwZ
X-Google-Smtp-Source: APXvYqz6AP9plcd3Xb2032a2nI56UfsmnPN8gDbGX3DRE9Uc43YVk5vG9m+oB5oc9ETf4kAt9j4PtQ==
X-Received: by 2002:a17:906:6dc1:: with SMTP id j1mr8009521ejt.85.1565940467324;
        Fri, 16 Aug 2019 00:27:47 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id cb19sm700277ejb.51.2019.08.16.00.27.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 00:27:46 -0700 (PDT)
Date:   Fri, 16 Aug 2019 09:27:44 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Subject: Question about BPF acccess checks
Message-ID: <20190816072744.GA520884@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As of systemd v243rc1 I have been noticing bpf prog_load and prog_run acces=
s checks for systemd --user instances (only if secure boot is disabled)
I suspect that this is for IPAddressAllow/Deny=3D functionality.
So i tried it out and I was not allowed to use the above due to lack of roo=
t-access.

Then i read this:
https://lore.kernel.org/linux-security-module/4F52274A-CD70-4261-A255-2C4A7=
E818141@fb.com/T/#t

My question is: Is it expected that BPF prog_load and prog_run is checked w=
hen an *unprivileged* process, i suppose, tries to load and run bpf progs?

Are prog_load and prog_run unprivileged operations?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl1WWuwACgkQJXSOVTf5
R2k57gwAoTTqxyR29ZhTKblZB0yh4ClZDUuJbmoNzgZ/uFmwA2lZHPp4twd11b9m
ntBcl3KTk4GrWzmicxF19YsIoCDGFzB/mAP00djhVR6gAfPRDM+UbWmxogjvlOLH
q3bfBC5wbAqXgXeVcr3grlLFxOOvKOsNZRxU2IK9/zxU3+NnP94NIFYGIG7hVyuh
AsdzuoQMs9utAgZP1fHF2VKB1CnWm58rC/j8Mx6vYjBnRZ+3d6LWX1/Rv6vxpTxB
zYNpQgkhiwpusUeEB/jYJBGB1ntzv7+0aeGIEqpHvKiCWyxK+b6OCjaaS/8m5J4L
chHcJqZYUMPf3aAEA4in6+rByfGlzb9p1ix62MXSNPtmKy8uDfy5gH4iawj68NaU
uM3CP93Ua6Pb7NJhAZcIRiRzRyutthogjxOE7QSxDgpv4XRPTU5eCAPC4rSnaZe3
ziYaGMgL+a4HJdbaz+6upVgBX3w9rG33KI01t78ZZYqY2rGr1sFD+pg6w/bg8/18
WreonZ/4
=xyxh
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
