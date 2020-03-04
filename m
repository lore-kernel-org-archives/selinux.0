Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC8C3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 15:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9725621739
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 15:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCDP2d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:28:33 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:46922 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbgCDP2d (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Mar 2020 10:28:33 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 9F260132006F;
        Wed,  4 Mar 2020 16:28:31 +0100 (CET)
Date:   Wed, 4 Mar 2020 16:28:29 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: strange pam selinux issue
Message-ID: <20200304152829.GE1032355@brutus.lan>
Mail-Followup-To: Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200304072940.GA1026144@brutus.lan>
 <CAEjxPJ4qQgoMq6so-qGMm6fL5CKRKxC-TJXjxmEe=Qv2DAHGTQ@mail.gmail.com>
 <20200304144726.GD1032355@brutus.lan>
 <CAEjxPJ5=YT-EttK8iE5h4Z7A59nJd6pTD1sUR=5sR8UajmrsNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <CAEjxPJ5=YT-EttK8iE5h4Z7A59nJd6pTD1sUR=5sR8UajmrsNw@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 10:19:54AM -0500, Stephen Smalley wrote:
> On Wed, Mar 4, 2020 at 9:47 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> > Practically yes name-based type transitions but other than that it make=
s the experience much simpler if you have just one unconfined system domain.
> > I actually kind of got that idea from you when you mentioned the three =
domain model.
>=20
> Not sure that was me but whatever.

That is what I thought when you mentioned it, but I am glad you did because=
 I was a bit too focussed on least privilege.
A bit of corner cutting here and there can be a good thing. Besides it is f=
un to explore alternatives.

>=20
> > Its also used by pam_selinux env_params (which in turn is used by ssh f=
or "ssh user/role/level@host")
> > The problem is that the default_type for ssh and sudo sessions may diff=
er (ie. default_type is not really a default_type)
>=20
> Fair enough; originally it was only used by newrole and only if a type
> wasn't explicitly specified via -t.  Maybe
> get_default_context_with_role(3)
> would be better since it can take into account the caller context.
>=20
> > > Probably needs to be converted to using selinux_check_access().
> >
> > We hit that same isssue when we revisted mdp a while ago. Removing the =
env_params was a quick fix for that then.
>=20
> Well, the right fix is to use selinux_check_access().

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5fyRcACgkQAlFoDzf+
eROOJw//bpAyUxTn1J4Jq/dy0PuRIlF/AnjtG2nAvoKNlAV8n9DbNhm5t142D1No
5cBeoTCBplzCPnQp73qMn2AY0O/I2YO1FjTu8CSVR9NFtndH77rAffhogmHCVNMi
HYmrzIm6ckMpWkqMxTlJ3EI7rL47nf4RZTDIA5KM2E6AvW7ydvrxiEzRci2Sxhia
xeeQIhHcdNr72FxGMvzgTkmDFHV7JKIVPGPAXo9kgS0IWyA1grpLrsuWHtjTb9jH
ty9N6Uc+NU+A08rMON3w0JTB6ujumVWb3zoeGnCFvr5JcEDhWtweunKhLXeNE9aI
f5G32d+g4nyoCka/aNbRyRmifR60KmpH8uj6xDgzFvy+XRU3yCKy2OXAsqdS5oOK
XpOFq2eBJQvcYnawMoWXzINgRWHi/xxDcRZqDFP35iECvyfR8g6lIm71ojIai7im
BPGAX9e3dv2tiWOIGhH7Ko5iJLT9SCGDp1l3zXnPwfgjodahjfiO1QP15HaDTZWN
rRCTzNwLE8En9jnBd9isWX4XAPYAx48VQP6MkKrVbQkrzL1BJqVH+tA83cUCHS7L
5ivPHScVGaNZG/N+S8YCFGl0U+JfX8cqOUCjZMaL/2lychYscVU+0cpHM453lXec
NtqNJk5zT9pOuInnxiRqoOM4DZujeeDIaN813QusNIsi8n9yc5U=
=zFGs
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
