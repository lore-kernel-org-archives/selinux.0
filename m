Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC30C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 11:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567F12068E
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 11:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiokqJeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfK0LWs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:22:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35662 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfK0LWr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 06:22:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so26207765wrw.2
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 03:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=el1wYhiRhmdk8YFCi1ZllU/kbcyofYG7B+1RzeQ8jy0=;
        b=uiokqJeVaGmmbeRgR0cxcnOs6woQw6sRS1Or8gakKmWP55R3KGBqMvO3H3o+LMlaMS
         iEW+kC5DTmAA7deo9EofwxZsLAXOXHzx7YL6OwlZ3crPaVq6Lv6Gg1z4ij8iubTs3ssy
         viFL37RHgZVt4SvZ5GvF0vzOMVeOUVp+ifPg7NU3gM0IBrgrQu7wQXQIkEPQ6VT+OEIN
         0VAI8Tr6grWG0pMk8VufCFo9l0Xcxslqh9DGxzqfcbZpZf2PVEly5LGm8ljoH1T6e+YV
         8SyniZrA7ai24wwQh1gqqyzY+5bIF24na33/WrllnE+Numlq3ktgpW4636IdayvJOXQ0
         iEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=el1wYhiRhmdk8YFCi1ZllU/kbcyofYG7B+1RzeQ8jy0=;
        b=Q3UiODG87vpnkVEeJPa/m6/AE5ROZFOZga2w8fqojrWkH88Mw02Ek2CYstbnhZcU7T
         xQUNgsQ0TMlpSYqfpbSyvPbCGK1p8Z/p4hcVFROYyt9RI8xFaJRCGrwzrDq+e+uo9kCW
         5ziIt2rqTKVfP1kJijh4VftFUOy6JzcTWgVFaQHcV+7tzO8uS3YAGvhlFIIYt/FSXhkK
         SS0ya33o5Z85ttCUKmii3EjFIY9lZaLbAAIUya36aIQN4rnTQLFf9fBBq76Rdtonj3Ep
         pSEy8qStLUTbMDDGu02sksLWaBcndUvoIxqe0u4ou3SmaXUsQukc3h2TOroo9TqvHXkw
         fbhw==
X-Gm-Message-State: APjAAAVYOf3o+8Ayer/vnMsk/tVaa5MhWXYszXHimz9poH3vYJJbw075
        0bG8nysssepmixHMAeAdOqMtJbrL
X-Google-Smtp-Source: APXvYqyYBkq056fOsODOFcSLIiCgLioX4aLHUj1vRQXcocyEg4FL1Rwy0z7I48SA7RMJiHsq6Qg7Og==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr44754352wrw.385.1574853764711;
        Wed, 27 Nov 2019 03:22:44 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id h97sm20432568wrh.56.2019.11.27.03.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 03:22:43 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:22:41 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole
 transition
Message-ID: <20191127112241.GA23027@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20191123144245.3079306-1-dac.override@gmail.com>
 <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
 <20191125141035.GB441967@brutus.lan>
 <fe0d0ffe-a96a-9438-76f2-7759a41b823c@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <fe0d0ffe-a96a-9438-76f2-7759a41b823c@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2019 at 01:27:42PM -0500, Stephen Smalley wrote:
> On 11/25/19 9:10 AM, Dominick Grift wrote:
> > On Mon, Nov 25, 2019 at 08:24:21AM -0500, Stephen Smalley wrote:
> > > On 11/23/19 9:42 AM, Dominick Grift wrote:
> > > > In 2008 support for UserPrefix was removed from Reference policy.
> > > > The code to support this functionality in libsepol and libsemanage =
however remained albeit slightly modified.
> > > > I am not sure why it was not fully removed.
> > > >=20
> > > > DefaultRole replaces UserPrefix functionality but the code in libse=
pol and libsemanage was only slighty adjusted to accomodate my use-case.
> > > > This was done in 88e334f1923396d5ace56b8439c731dcde0d1f3b (2016).
> > > > I do not use semanage and I do not mind using the old UserPrefix st=
atement, but there is some confusion.
> > > > For example there was a report recently about how semanage does not=
 document UserPrefix.
> > > > The documentation was likely removed from view because UserPrefix i=
s no longer supported as such.
> > > >=20
> > > > I want to make the situation better and this proposal is the next p=
hase.
> > > > This proposal causes some disruption as Reference policy based poli=
cy often calls the gen_user() macro with the "user" prefix.
> > > >=20
> > > > Example: gen_user(user_u, user, user_r, s0, s0)
> > > >=20
> > > > This will no longer be valid, and the userprefix parameter in gen_u=
ser() can be left empty (or needs a valid role if RBACSEP DefaultRole is le=
veraged).
> > > >=20
> > > > Example: gen_user(user_u,, user_r, s0, s0)
> > > >=20
> > > > UserPrefix will now default to object_r. This should not affect com=
mon policy implementations.
> > > >=20
> > > > The next phases will be:
> > > >=20
> > > > Renaming the UserPrefix statement to UserRBACSEPRole, and renaming =
references to (user)?prefix to (user)?rbacseprole.
> > > > Adjusting semanage to expose UserRBACSEPRole.
> > > > Removing legacy UserPrefix (ROLE/USER_TEMPLATE) references from lib=
semanage.
> > > >=20
> > > > After this the UserPrefix to UserRBACSEPRole transition should be c=
ompleted.
> > > >=20
> > > > This should get us by until someone decides to rewrite libsemanage =
to take advantage of CIL, simplify the code, and to make the code more robu=
st.
> > >=20
> > > I guess my only question with regard to this phase and the next ones =
is with
> > > regard to backward compatibility.  Even if no one is using this facil=
ity, we
> > > have to make sure we do not break existing installs upon upgrade.
> >=20
> > Maybe we can duplicate the code instead. That way we would not have to =
touch the existing, but dead userprefix code.
> > That should address any compatibility issues.
>=20
> At a minimum, we must avoid breaking existing installs upon upgrade, and =
we
> must avoid breaking compilation of existing policy modules (both refpolicy
> and CIL).
>=20
> A simple test would be ensuring that if you upgrade the userspace and run
> semodule -B with your previously installed policy (including its existing
> userprefix statements), there are no errors and you get the same
> file_contexts.homedirs as you had before.
>=20
> That should be relatively easy to ensure for targeted policy.  Might be m=
ore
> complicated with your policy, the CLIP policy, or perhaps others.

I am thinking that we might be able to add something to cil_resolve_userpre=
fix() that would just not process any entries referencing the "prefix" keyw=
ord as in "user ... prefix ...;" instead of "user ... rbacseprole ...;", an=
d instead emits a warning: "Not processing deprecated userprefix: userprefi=
x. Use userrbacseprole instead."
That would then just not add those entries to users_extra, and instead rely=
 on "fallback_rbacseprole=3Dobject_r" in genhomedircon.c, if the "migration=
" code in libsemanage does not catch it first.

>=20
> >=20
> > >=20
> > > >=20
> > > > Dominick Grift (3):
> > > >     libsemanage: fall back to valid "object_r" role instead of "use=
r"
> > > >       prefix string
> > > >     semanage: do not default prefix to "user"
> > > >     cil: qualify roles from symtable when resolving userprefix
> > > >=20
> > > >    libsemanage/src/genhomedircon.c    |  2 +-
> > > >    libsemanage/src/user_record.c      |  4 ++--
> > > >    libsepol/cil/src/cil.c             |  7 +++++--
> > > >    libsepol/cil/src/cil_internal.h    |  1 +
> > > >    libsepol/cil/src/cil_resolve_ast.c | 10 ++++------
> > > >    python/semanage/semanage           |  2 +-
> > > >    6 files changed, 14 insertions(+), 12 deletions(-)
> > > >=20
> > >=20
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3eXHwACgkQJXSOVTf5
R2nBVwv/XfdTDvITXCBFxfEFEILszQ2kkcAL8X6Ea5kNnHGbdh+7ZNgX9RaQHSiv
R3WLXEZm0WbO3wN9lrblEiWq/4rAGSlfIJaI8LfCq1QrPdcsrtd3f8jiBsac+M1w
e5k7HiC+r1XpXy2HbT+B7Y761ZtUnr6fKLnSNJXSHGNwmlNDeVnl7dO0WvBg1P3d
CJGIWESX5j331Gg5DLKLuZ7eBonyvcVuozaYA+30R1GDx63v337IYkUD/FiltRky
gXzx6fNxe4gSb35VDrpG/y0PZH03DRjNHAzibi+l2BTOy4QQj3aYKgJWCicfNngn
jOPpCRiWFtSWOx6y8SXx8/dMsmAJtwn4WVi6D1kaOv7qoFOZLFINw5U2Sh9MfGNR
QHvalzp4DEXNv1+Nv41ZGJm2x//ndodqGU7fP/AISgGLTaSyu0H7jr70FqAKVGcH
IGFgL73Y7whoZ4rDQAqWHncG611l79rYwGYw87v0UKcuWWXmYQdg9eDwgJ8hB4wT
jGSgu0ml
=Qo53
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
