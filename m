Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA5DC3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1A42166E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCDOr3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:47:29 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:46880 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDOr3 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Mar 2020 09:47:29 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 9CFF8132006F;
        Wed,  4 Mar 2020 15:47:27 +0100 (CET)
Date:   Wed, 4 Mar 2020 15:47:26 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: strange pam selinux issue
Message-ID: <20200304144726.GD1032355@brutus.lan>
Mail-Followup-To: Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200304072940.GA1026144@brutus.lan>
 <CAEjxPJ4qQgoMq6so-qGMm6fL5CKRKxC-TJXjxmEe=Qv2DAHGTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ4qQgoMq6so-qGMm6fL5CKRKxC-TJXjxmEe=Qv2DAHGTQ@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 09:40:17AM -0500, Stephen Smalley wrote:
> On Wed, Mar 4, 2020 at 2:30 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> > Some semi irrelevant background:
> >
> > I am designing an improved "targeted" policy. Common targeted policies
> > are inefficient because they have several "unconfined" domains.
> > Unconfined domains are expensive because they have a lot of rules assoc=
iated with them.
> > They're essentially all the same. Just duplicates.
>=20
> Why can't you just define a single unconfined attribute with
> associated allow rules, and then define multiple domains that
> have that attribute?  Where is the duplication occurring?  Name-based
> type transitions?  IMHO, those should be used far more
> sparsely than they are presently in Fedora and there has been some
> optimization recently in how they are internally represented.

Practically yes name-based type transitions but other than that it makes th=
e experience much simpler if you have just one unconfined system domain.
I actually kind of got that idea from you when you mentioned the three doma=
in model.

It works reasonably nicely with exception of this pam_selinux issue.

>=20
> > I decided to have just one unconfined domain: "the system", and everyth=
ing that is not targeted ends up in the system domain.
> > So now I want to have a confined login shell with role access to the sy=
stem a'la: staff_u:staff_r:staff_t -> staff_u:unconfined_r:unconfined_t
> > pam_selinux seemingly cannot deal with this scenario as shown above. pa=
m_selinux has many other issues. One of them is its concept of
> > "default_type". There is no such thing as a "default_type" and implying=
 that there is a "default_type" causes issues.
>=20
> default_type was to support providing a default type to use when only
> a role was specified to e.g. newrole or pam_selinux.  Not sure that's
> a problem.

Its also used by pam_selinux env_params (which in turn is used by ssh for "=
ssh user/role/level@host")
The problem is that the default_type for ssh and sudo sessions may differ (=
ie. default_type is not really a default_type)

Ex. joe's default type for sudo might be joe_r:joe_t, but for ssh it might =
be joe_r:joe_ssh_t

>=20
> > There are other issues related to this as well: the env_params option d=
epends on the "context contains" access vector being present.
> > It will not work even if you have handle_unknown=3Dallow set.
>=20
> Probably needs to be converted to using selinux_check_access().

We hit that same isssue when we revisted mdp a while ago. Removing the env_=
params was a quick fix for that then.

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5fv3gACgkQAlFoDzf+
eRN83w/9F39oax4a25pm9lVx5ooJo7d/aQQ/T3gYNlOcLuM/ODiRlsr7oPno7UOf
+6LzfSyQyaEWe74j2BO9yz7py6LYuU7EmmSGa1X/ScZ1FksBiOkhbJoXHrFpoRXv
ogw692Hl+bhBYscfkrpQ7KN4yIrm3eUO7zB3xKOZe55LpU4nXcsVKwqfM2xx4JoZ
efrhXPVilrGGSaNwbl3RFsn0wVUUwAaL1H/SfrkxrRBbemgDLDEQaVZMsSIlRPmU
93iSEKckvcynCTkrz5bV7O1Eu7HZmIrS+8D+AonkUNk3N5sw+PFoxeTJ8KeLX3zv
zY/lAlbLVcwo2OahPk03twle4XNvii0YRoUQ6C0EePr3IagnwVlebugvGIhFO1AL
NodrfDG83f5+SJRW4jhY0BIVhccTdxGiYSNAIxuXjhLf2RMzPS3uBj6JxDmzk2Lm
VvhCHV1eGJvnWxTuFcuAYOFb7f1I8QfI5YJBvYWo4uPCnkDlUFPXmfjv7vCUaSH9
S9wjZUeuHjc9eACTIVAKtYMnOZWImgU4TZNtbT1BAAfaP9IsBhywC9xedyXP1XwO
CMlljQ5yDdN+EGjWNZ/C1XCpTXoH6cD4WeWAznEX2IDYbQCUbYV8WJi1X3XniQG8
bkGVCSzfDXxxcAqS84ga0d70ABevXAfM6EGP+uhI4oDqVBTCZAA=
=f5I8
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
