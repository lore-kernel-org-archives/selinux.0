Return-Path: <SRS0=yCNt=2K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A8CC43603
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 14:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ADB21655
	for <selinux@archiver.kernel.org>; Fri, 20 Dec 2019 14:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN0nklnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLTOxv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:53:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38803 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLTOxv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 09:53:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so9515177wmc.3
        for <selinux@vger.kernel.org>; Fri, 20 Dec 2019 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pst0OiFrTYnnsG8j27X9JepESrBknjGx84NC4O0IxWI=;
        b=mN0nklnLiTkB2QozlFpf6W9oYEA0lUERSh4m6VsjNY1jDI9YKLWyw/CmhECgyUd8N3
         xjInD0/nAwhCecFiSaIBtruKvceT50pyDLImBOtVaRhhgXJ2ORwcm1btekhLwOCuqPEV
         IYjkYp/G7U9uTzGiRGcCotP5I/jl0Are4z6O6UaavyH16CxMcnhOn4QRgpgkZMkk9500
         u0lmRDR/+fbIAHlCWyFg1QgtLMBGV5+jVmdcWruDVvZeBwHrurzQWSKCHBs8gEmHE8Rk
         2SmdibC2GbGLQ6g4wT9lyXnxfzLbMiMcM8/XIceezIM+GUSfa6xiVkH8E5pVFuShY8aI
         G/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Pst0OiFrTYnnsG8j27X9JepESrBknjGx84NC4O0IxWI=;
        b=ppaAPFj7Bv0EObQjoJmbMhpSGsIaZN9TiL1rl750FXLQUNPiMqaBq4IRfCeVLvVgUs
         Pfew8+h0lmhvsHZh9kLBduUoNfyl1YUwHl9ednP+U9pVMgWPzLrw9YP0ON/8EyMw6+Bp
         XgdMHd4YOD9IAqhiu5WFS1ucxBdjqDcXmtRmG/tha8JwUg/YSH+fsLlAaKgZvB7HZcBC
         jve1WuE46KqWtIDcQDeXBsi6Weup/ts0ajPwe6uW5O/oLGQ7EPk7zybBGwA8ARRrpawM
         /sZkGHLSN9lGVByfHfJ6bXjJ5/b8xuO/9WDoZdfQNirM/Bk1UX+N9Cd5UPG0If0VZHrU
         tWIw==
X-Gm-Message-State: APjAAAWhLf94IVvGwIcsN/aFH9nWNydqWDOondTcwhqAhWOvoKIzbQUu
        zMR9IO8GCZuvC0nF0IapTwI=
X-Google-Smtp-Source: APXvYqzbn9U1hkDAe4j1tci9CIjuR8y76su5eiuEY67p+x7zEI8huGYXj0v0r6aTowzPmksj3FDQwA==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr15906922wmj.41.1576853629244;
        Fri, 20 Dec 2019 06:53:49 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id n10sm9799400wrt.14.2019.12.20.06.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:53:48 -0800 (PST)
Date:   Fri, 20 Dec 2019 15:53:46 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] systemd: improve SELinux support
Message-ID: <20191220145346.GE632812@brutus.lan>
Mail-Followup-To: Chris PeBenito <pebenito@ieee.org>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20191218142808.30433-1-cgzones@googlemail.com>
 <2bf8ca3c-e1be-45ac-1472-5dc2d046620b@ieee.org>
 <20191220105416.GB632812@brutus.lan>
 <57742923-f40d-d4b8-117b-ec6fb4bdb7bc@ieee.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Content-Disposition: inline
In-Reply-To: <57742923-f40d-d4b8-117b-ec6fb4bdb7bc@ieee.org>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 09:43:09AM -0500, Chris PeBenito wrote:
> On 12/20/19 5:54 AM, Dominick Grift wrote:
> > On Thu, Dec 19, 2019 at 03:24:34PM -0500, Chris PeBenito wrote:
> > > On 12/18/19 9:28 AM, Christian G=F6ttsche wrote:
> > > > Improve the SELinux support in systemd, especially re-adding checks=
 for
> > > > unit file operations, like enable, mask...
> > > >=20
> > > > The original pull request can be found at https://github.com/system=
d/systemd/pull/10023
> > > >=20
> > > > Patch 1 and 2 improve logging on failures in permissive mode.
> > > >=20
> > > > Patch 3 adds the ability to obtain the context for a masked unit.
> > > >=20
> > > > Patch 4 and 5 change several system und service checks. For better
> > > > distinction two new permissions are introduced: modify and listdynu=
sers.
> > > >=20
> > > > Patch 6 and 7 re-introduce checking unit file install operations.
> > > > They were dropped in 8faae625dc9b6322db452937f54176e56e65265a .
> > > > For consistency in the unexpected case while perforimg a service ac=
cess
> > > > check no path can be gathered, now the check will still be executed=
 on
> > > > the service security class (currently it switches to the system sec=
urity
> > > > class).
> > > >=20
> > > > Patch 8 adds some notes for adding future D-Bus interfaces.
> > >=20
> > > Thanks for working on this.  Just to make sure I didn't miss anything=
 while
> > > reading the patches, there are no new permissions being added to the =
system
> > > class, correct?
> >=20
> > This is what i understand:
> >=20
> > Systemd first wants the regression fixed (re-add enable disable permiss=
ion checks)
> > This phase should not add anything to the system class. It merely addre=
sses a previous regression.
>=20
>=20
> I didn't look at all of the implementation details, but as long as there =
are
> no new permissions in the system class, I'm ok with the changes.

This patch series has already been rejected by systemd in the mean time, th=
e reason being that they first want to only address the existing regression.
Addding anything new requires a blessing from the various (distribution) ma=
intainers (good luck with that).

>=20
>=20
> > When that is done, then either the whole thing can be redone properly u=
sing policy capabilities, or we can add new permissions and in that scenari=
o i guess the new permissions would be added to the existing system class (=
?).
> > If we redo the whole thing without interfering with the existing implem=
entation then we can get rid of the system class usage for systemd.
> > One can opt in for the proper implementation by enabling the policy cap=
ability or otherwise one can stick with the current implementation.
> The correct thing to do with future changes is to remove the userspace
> permissions and put them in a new userspace object class (with appropriate
> compat, etc).  If you're adding new permissions at the same time, a disab=
led
> policy capability would mean not checking the new permission; it wouldn't
> mean adding the new permission to the system class.
>=20
> --=20
> Chris PeBenito

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl384HYACgkQJXSOVTf5
R2n0sgwAn1dAbHOWk8szSqeFJXFzUp7rap1kDzbdK5f0VfaTVjpg2Z66XFyx2S9V
SLRXkQOlxGeukgYccp1RCZs970QHD7qW8LCfn1QPVcQhk00FXLEREUe+5rBXioOZ
SMSze6Cf18pqSGKf3j6EEIOk1MGn2aXgXq6TdKhjEhpZqVGYRnM1il8DDmYishxr
OTPTfsJMU6WVAuoH2gCaGkfOdHG8oNTYilS+3/Gh1lHaXXt3FnKLPRo7tHMq665E
WWgiXaiwJG4VQcRLn6iHw+xOV76pKPtOxBZPoHcA/5TBtJXnCGi0Edkfds8PZ+Of
kfLigVL+TNaW8ivlreUEcEycrffbtLXH9FTVNjl23zKJ1Au7M3f4zOL05PUFfwFt
LYb7YgXyKP6xF3Cg8+p1g/zBEb+4LIDGhhR++rP3CKSO7zPLPWlaxWNNHgp6CU7n
VGWGIuc1eYzICq8wrKR3hPLrC3HxTxBmC7lF7nvyLwUq5WTrBCzc1wQ/bo0HIZJN
zauAvFmI
=k6zb
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
