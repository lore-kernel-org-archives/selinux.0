Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACACC43603
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 10:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3082467F
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 10:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf3+7MaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLTKyV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:54:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33602 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTKyV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 05:54:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so9177771wmd.0
        for <selinux@vger.kernel.org>; Fri, 20 Dec 2019 02:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwI4lmFuTJ38Q942Df3HJ+fPQDmd0ICmX5L79x7Rq/w=;
        b=kf3+7MaBKnwn70w9QBPqGHzNzk+GGZyM2d/82BI67BnoF52JW19TE2TY1Y5WHOpBMg
         sSZELC/CTEtqrRYlH2/v1JYThKCTL62kpL+n38lHA2rxJZ3AJ1CSPCCR8c/UxjSPgEXB
         PjT/sQ3NM7x03HxnBp8f7RRM1ze/tZypDKYCzEc/ktmFP/QJGTrvi44DQ03K7pHbR2iS
         JsZzGQwpNlH7eV/YSc71w6+Y3GPASc48blPEtKgxcZC3uhaigtOfU0pvJAzwNBpSHWQi
         nbtt/7bt6dCN07h81/S0Fy5xShsftnHifQO5vhaalMo1fJaZDFAfGgD9Nk/f6D/KWO3s
         rSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bwI4lmFuTJ38Q942Df3HJ+fPQDmd0ICmX5L79x7Rq/w=;
        b=C1p1RYmc1wOkFfsBqtTFVhjeshs0VLk8RMKymYmZN8ML779xkY9fRGbepsZO2we/rr
         U+s8MaWwvTqeJ2Y8soPPwLNRV3tPM4OrmzfsI9aQZfiX8g6dSN1rMUWUel+8EXDXrCJv
         45W6CVaazpeKHckthT6i+GKoy9nBCW+p0vg+sZlhALxwfHqSXOQYcJ5XyLepjWLgSmz9
         mQigrDeE59qGvgJsJvuCjFJpf1WbV6HaKR4Qg3p35i9dp+SxKCmc4aRqEu8npXQxjb/q
         IE7qN7OEzO0pbimJYZ7PkCZ9I/g6Hy3gn9ygnkQ83y+f9qpALwXUMvkRh8yW02iip3j5
         JaxA==
X-Gm-Message-State: APjAAAXqtZHWjQDR2U205bGmwX0w9yBITmqERlG5crl4Cgjmh0+J9Fq4
        BqdpGfcSB1Ga/OGiMJLojlQ=
X-Google-Smtp-Source: APXvYqxQ+bNvseMZBJZPKSbApM5/syhS/+nWnvSccQdy73THl56/F93SopcUrdFhpjxQ2ojuDPUhxA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr7300586wmb.80.1576839258733;
        Fri, 20 Dec 2019 02:54:18 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id o15sm9673766wra.83.2019.12.20.02.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 02:54:17 -0800 (PST)
Date:   Fri, 20 Dec 2019 11:54:16 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] systemd: improve SELinux support
Message-ID: <20191220105416.GB632812@brutus.lan>
Mail-Followup-To: Chris PeBenito <pebenito@ieee.org>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20191218142808.30433-1-cgzones@googlemail.com>
 <2bf8ca3c-e1be-45ac-1472-5dc2d046620b@ieee.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <2bf8ca3c-e1be-45ac-1472-5dc2d046620b@ieee.org>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 03:24:34PM -0500, Chris PeBenito wrote:
> On 12/18/19 9:28 AM, Christian G=F6ttsche wrote:
> > Improve the SELinux support in systemd, especially re-adding checks for
> > unit file operations, like enable, mask...
> >=20
> > The original pull request can be found at https://github.com/systemd/sy=
stemd/pull/10023
> >=20
> > Patch 1 and 2 improve logging on failures in permissive mode.
> >=20
> > Patch 3 adds the ability to obtain the context for a masked unit.
> >=20
> > Patch 4 and 5 change several system und service checks. For better
> > distinction two new permissions are introduced: modify and listdynusers.
> >=20
> > Patch 6 and 7 re-introduce checking unit file install operations.
> > They were dropped in 8faae625dc9b6322db452937f54176e56e65265a .
> > For consistency in the unexpected case while perforimg a service access
> > check no path can be gathered, now the check will still be executed on
> > the service security class (currently it switches to the system security
> > class).
> >=20
> > Patch 8 adds some notes for adding future D-Bus interfaces.
>=20
> Thanks for working on this.  Just to make sure I didn't miss anything whi=
le
> reading the patches, there are no new permissions being added to the syst=
em
> class, correct?

This is what i understand:

Systemd first wants the regression fixed (re-add enable disable permission =
checks)
This phase should not add anything to the system class. It merely addresses=
 a previous regression.
When that is done, then either the whole thing can be redone properly using=
 policy capabilities, or we can add new permissions and in that scenario i =
guess the new permissions would be added to the existing system class (?).
If we redo the whole thing without interfering with the existing implementa=
tion then we can get rid of the system class usage for systemd.
One can opt in for the proper implementation by enabling the policy capabil=
ity or otherwise one can stick with the current implementation.

>=20
> --=20
> Chris PeBenito

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl38qFMACgkQJXSOVTf5
R2nKQAwArqUpu1ps7Tvd9vZw4wy4p0mvGbG+lV0IxJggbVIFJLE95mc5Un7IGPSs
YaMhdv8ceHYPDJ49Bl1/nJUXfpio3X5k2jJipH9piRKurFhxekoW5a1xLRpQv9mB
FtflZN5zHnw83ttQdGXdDD4L+KDILPoFxx1KD2hfv+dd18JjooPjVPuSZZp83bOh
t9g1IA9op2GLG9YgDO1ZcgEM+zglLn5PEkfEDiYvjMOfzkJzyvgCQsqYF7p4PlJ6
o9ew53O5gdCkBn+0JbYD26m5guY0UFD6KnrxWi4duAl+IEtSxI1D3eElMQCHvOoS
nSdoFlMeY0m9V8yh5ZQomKZSnbHX3QivOZqegGbYcFU20BKJa2sCM14I/TOMzPX7
+ZaS99F+rmJtbiyMXJYRXuEhZoQvKGr/QA15/BSyK5G5MdmYiedCq62r3sA0PeR5
kJriJCRV/rPTkkjtG287VZ5uJ1hGZoFUOrzYB2vOv/kg2nmpNcSYLHfB5qPya0PV
enfUvBHa
=pihi
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
