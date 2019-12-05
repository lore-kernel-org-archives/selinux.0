Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E737BC2BD09
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68EF22525
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP7lAzok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLEOE2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:04:28 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43719 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbfLEOE2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Dec 2019 09:04:28 -0500
Received: by mail-wr1-f54.google.com with SMTP id d16so3707885wre.10
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2019 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=4edA1Dc0isUmiru0SLFa/PDFBc4K1wKDIVHyf8AyCUc=;
        b=SP7lAzokD8OGlvtZww8ZuzhZ4EWXeMCTkmzFlwPxu4hl7uGflGq3uFFTaqxWZIiMdd
         aD4oCVVuFVX2O6s/b7FV6yT7YgpkPK6FEJKgnEut/u5dXWZ3ebrEaw04pcLXCTb5UZWK
         jAjVCvisTdXmBsJe4lXX7/n8QbkTuTHEDRTEDa+dijiYJ4taCRIpmcO/z5ol3yKVcF7y
         gnpEgn9m6rCVi5MeAh80fEYrxWWd2uBWpzJSeEehq8t+anH7tC1RSi0Zp1nLFe58rCkg
         jTbDFJgKgcJXO1vaXCloAbMPAPObaZHF5wTZw6JVOsvblZcjEPu5Tkon5I9PaSnpNmye
         j3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=4edA1Dc0isUmiru0SLFa/PDFBc4K1wKDIVHyf8AyCUc=;
        b=ZSRULAJTDWWVuytuOiy+CIcc4x6t7OSlcKYcU31y6xQMsNhx5BICNuq01kIcZ/y7h5
         eoipRRD5vmbNv4zdMKq28hzSihjcNqAkFHr7S1tm7z3Huk8G/l3mVcJCPFWXe47zpagO
         b1HGmAxETH4ATRV08ngGjWAEHN5eRYdkuxi3+alYzcLkSUYxrSiCs3gUyfvp2+CzPn+2
         Hf4A3SQ2mn0yfdwv6acFvATxcvQb6VBLhPL8V9212234LEiiM9DgkbMhcnWGEVG1gAfn
         7s/uVNjXkaZOZGosAOaNz3RRDEgALFzu6xdwBk+/RhAE+seOKyqmwEQNy5F/BtqoUUEx
         iP8A==
X-Gm-Message-State: APjAAAUMskf5yesyd3xz5sA6T1ZplTAZSRCQd7kP8L2/fo6q2obtjK7Z
        F+G/XzPMKLs5S9OVn6BwzLBkbyMn
X-Google-Smtp-Source: APXvYqwnpg3PI4r7d8X8/ZjfvBHfXPgWv9jGPVswpKgoUf3YnQVZ5/g8VZIyCQhtFTvVc1+xf+jv1g==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr11097757wrq.232.1575554665935;
        Thu, 05 Dec 2019 06:04:25 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id a186sm10439343wmd.41.2019.12.05.06.04.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:04:24 -0800 (PST)
Date:   Thu, 5 Dec 2019 15:04:23 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Subject: perf and cap_syslog
Message-ID: <20191205140423.GB1734091@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am also trying out the new perf_event access vectors. I use the perf util=
 for this.

Whilst I wwas confining `perf` at some point there were no avc denials anym=
ore but `perf` was segfaulting in enforcing mode.
After some brute force it turns out that it wanted access to cap_syslog.

My question: why was it not logging the capability2 syslog event?
Could this be due to an access vectors ordering issue?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3pDmIACgkQJXSOVTf5
R2kSxgv/V1YqZSW1gl8v39nDl3xAR671sxBh5oMlO8CfeYmVXEpioogSguVN275f
4CJGuc6mcqRuJ4//46ddUwISqDTKTpu1bW9rwtpGXbGVCvj51g4rByYNJXfQV8w0
3eU3hs8IyFTlM5Y58Zi068Zfg3/MLix8WW8Bl3dRX8mtQzKivJlOMXtvL7fVuUds
1uQzYPSHC0tk2anlQtxEOhRm5esGHtM02vYgkH5eqTpscAMkP7ZyxttDb9XoFWKx
T7Y9jbTkLIi8J/HLoFiv4qnabSeGccmtLY4WaN+jjufkesd8w+Y4uuoQh14NZS1S
LpIpo31qRdM9/wFt0Zl+QfbM+lN1yNuF/mm85Ke8anWda/xqITsnFj7fTc74xGUI
xbG3SlGAyQMGfdOdDH9i/Bibn2FDRgm3aPPtH8G5EK007IB5+GmzCTBSgEf7nQX9
XjAMm90nrfEMyg+PbzJMlvZ/vXYn8xn3zU3JUK39pchMxMSBE+cgA0s8WU1laLpy
WFWx+iOz
=0x66
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
