Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2F1C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6FE21920
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwjKXthM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfIRNtx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:49:53 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40488 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfIRNtx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 09:49:53 -0400
Received: by mail-ed1-f49.google.com with SMTP id v38so40197edm.7
        for <selinux@vger.kernel.org>; Wed, 18 Sep 2019 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpiVi7nHJ/o/uagV70xys8Q3fYXnKh4+Zw86x1pfI6Y=;
        b=cwjKXthMkuu8BfMkzRbQB7RS7j1mw4V+0weMHgoJtgfh417F4YD1UwIW8RX4qNz6VM
         lDPVYDaUJwDprTqMgc1AvNdUZmh/WTTltTpYRhyWVgtRgMzYB2k240+xtIImWtRjVImw
         7rkz4YzI3SZcLVMmZTycw02OGAYmlyZfFjYa3q4JVse0nMN5RsdhivNi1zP2BhI/IR8a
         lDr3Bl54yWCuq9ed2dE1tf0mAL3qEgaq1szOlV+uX+8Z0b2xyvvNFqikmGPpeXau2Xia
         PP5iTHqw3TbTzAAA4w9ZtopGKyzjPlwH8NOWQ37k45tmWfFYYjXszsxH5PlaWNBcUe+h
         E+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpiVi7nHJ/o/uagV70xys8Q3fYXnKh4+Zw86x1pfI6Y=;
        b=BBbSfzA7ix/NSvtxEMG4VeUthTJ2gQBkM/8oIeOSjncl/LncTOsXXARLlLJWSmjnWM
         hoOmWk3a51ZI0YGnGFXfoR1CEeERKiI5L32f6Z9pNvmsUOZdRm+n8fssVDIBngXVo9e2
         oFTEjZXwuQyV2UAZaxfJHL+p8Uft90sUJKBRFmHqQ6UoHJ1vCNZrGtDnAsLl/mBkyEmJ
         zKPmlznisXfLubsma7U0SpM74PWX1BTEWAj239DJ9H3rD9iavPfB/o6TnkkNiKqng6jk
         ikkNqtBbcmFpkVHtGIWYphXQQxA7pJrRbj+Sn8FHcHoodVVOOPjF8zLPBCXs8HO0jLon
         3xyQ==
X-Gm-Message-State: APjAAAWLLPY/F+GIZJ7naNogdwcP/3Ml7QgxR6sCO+hHjv9kc+QhPnhH
        ABxSaVwLkXeI8XIBg4F+srQ=
X-Google-Smtp-Source: APXvYqybBvGnDn7GuteB1RhfL9eIkOYYbGiUWgEE0sfPzcitCVqDC4qvCyiYSxDUhBpmXnOdJ8gynA==
X-Received: by 2002:aa7:d40d:: with SMTP id z13mr10186436edq.229.1568814591713;
        Wed, 18 Sep 2019 06:49:51 -0700 (PDT)
Received: from seamus.lan ([2001:985:d55d:0:6257:18ff:fe75:6e8f])
        by smtp.gmail.com with ESMTPSA id a19sm751141edy.37.2019.09.18.06.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:49:50 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:49:49 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ted Toth <txtoth@gmail.com>, selinux@vger.kernel.org
Subject: Re: strange tclass in AVCs
Message-ID: <20190918134949.GB15688@seamus.lan>
Mail-Followup-To: Ted Toth <txtoth@gmail.com>, selinux@vger.kernel.org
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <20190918134642.GA15688@seamus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20190918134642.GA15688@seamus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 03:46:42PM +0200, Dominick Grift wrote:
> On Wed, Sep 18, 2019 at 08:35:09AM -0500, Ted Toth wrote:
> > I'm seeing things like tclass=3Dcontext#012 in some AVCs what is this t=
elling me?
>=20
> https://selinuxproject.org/page/ObjectClassesPerms#context

Not sure what the #012 suffix is doing there though

>=20
> >=20
> > Ted
>=20
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl2CNfgACgkQJXSOVTf5
R2nTkgv/UN4k2h3Ckl/I7NOnvq9GFYnglDhSp6GEaP/JfEufpO2k9Vk1f3bFpuey
xmY87QJHGVtjpaFUxHewtqMBIzys27rG8Ob2tawnC0pOxNv3LhDoEu7TXhLoC7GZ
j+1CHsyfSf9Alv/aJ9n7pTuow6myKNcVqSl3U1Z6PFxZQtSCWPDjfs9dkbrBt4SS
LelFOLa8DVj8arRxlDhD6Rri6OEOHtm4COhY60WAL3qicJX9oVVBnaCPct15VPr2
vtcIf+vAUXOtjBBmiP9er3y/DHhcllZzuPsYiWoiWOw0+GXclyJU5N1zfzLVopFK
8ugICfU/9w37hqehBWiVx0Mvv5mo/uPvbnsy/ig70Ar3oGPqbooF3tx/4uSev2qY
M1cDfcs0OguMx66kPDOuQhFOXt+MAZNV7kkuE0rgnInIQTswSX4F6HJTA7gNDyvV
gCwZWKxa5sCIkQNBUYNEsOjePSZdOJrnH2jsPJmSVMfBAxrF2r+Ht6DFyArLs3Ag
mBfRg0DH
=uH61
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
