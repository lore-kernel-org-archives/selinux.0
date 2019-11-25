Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D0FC432C0
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FAC207FD
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjAy6xXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfKYNuI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:50:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35481 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfKYNuI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 08:50:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so18117369wrw.2
        for <selinux@vger.kernel.org>; Mon, 25 Nov 2019 05:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GN+Po4bLBcP6vtj+wDrc7aL/+I4Ym1fEeVM87GRHEvc=;
        b=sjAy6xXnDD4If/N54eDje7zu6B76r4QfLYa/vsiJAeY8s+Qgb6CtMzaJRtpHDSsJtb
         IQe7UCXX1k1PRrRbSEwZx6W68aDUvDuunvSphwFiAozk16IpHHKeZsV4m09Dm4ru51+S
         yaDf6dmcd6z/mgV6XtB4U2y+DHp48zad1NSq3bQlgCNEgdCZJEMkBwzDvgEslJ0IdgKg
         5rLE3kHpTzRFmxqehXki4FKHHWlt5tsnT1wKoRK+7zv+wGE8zLgPvlMbbGrfTg24Hc5A
         Yk78Hn7lzqh5WkSe+ibDFd13CHIjnL5o4aNDHgcKGcebJ4qWzPgVFgm9ZeLY+vaVe6AY
         uZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GN+Po4bLBcP6vtj+wDrc7aL/+I4Ym1fEeVM87GRHEvc=;
        b=rbh6JE+yb5O6FPE8ExN1PUTV0mXrAFYAaGM4NWUP6qUAPEgSKmaNrM+wflUmhgXAeV
         gYHCkC917aAtFD04ATFUj2oyZ6JpyrJQaE3HEL9QPuBFmIRS/eLbHr/mdlKWrj0fto51
         qHrLITZ1pHY8sRyGmu6D6Ydc1BbIBQHZBgw6enaMCLJN+ByHTnAXZRu53mAStv7KI2fv
         oFOjcmwK+d7/mEQLLQWhDYno3xpN+rQ+eTkoPHbnh3TBkNLjdyWYaLupuuM6drlkD5m2
         lz0rA6/gAT0Uxj43rYmjURoOOAAdpvjsKvlrqQBEO6XjXL9caYwfZ85QMuBL47FPHQOo
         TYFA==
X-Gm-Message-State: APjAAAW+RHs4Zl9CA2q5FaIWHa3zDDbRH+JDaHmyus+CvfACGTbEYPSa
        Jp2T4PdNCfcoYGpUShc3HCBQMkQW
X-Google-Smtp-Source: APXvYqwSDhbDQlrgcj+IdnmbT5KI5G+QkhpQ+p/Og3JvS0byCLxN21UIpeRL13oCK6BYsJcN3QTgpQ==
X-Received: by 2002:a05:6000:104:: with SMTP id o4mr1661977wrx.309.1574689806390;
        Mon, 25 Nov 2019 05:50:06 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id c72sm8839189wmd.11.2019.11.25.05.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:50:05 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:50:03 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole
 transition
Message-ID: <20191125135003.GA441967@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20191123144245.3079306-1-dac.override@gmail.com>
 <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 08:24:21AM -0500, Stephen Smalley wrote:
> On 11/23/19 9:42 AM, Dominick Grift wrote:
> > In 2008 support for UserPrefix was removed from Reference policy.
> > The code to support this functionality in libsepol and libsemanage howe=
ver remained albeit slightly modified.
> > I am not sure why it was not fully removed.
> >=20
> > DefaultRole replaces UserPrefix functionality but the code in libsepol =
and libsemanage was only slighty adjusted to accomodate my use-case.
> > This was done in 88e334f1923396d5ace56b8439c731dcde0d1f3b (2016).
> > I do not use semanage and I do not mind using the old UserPrefix statem=
ent, but there is some confusion.
> > For example there was a report recently about how semanage does not doc=
ument UserPrefix.
> > The documentation was likely removed from view because UserPrefix is no=
 longer supported as such.
> >=20
> > I want to make the situation better and this proposal is the next phase.
> > This proposal causes some disruption as Reference policy based policy o=
ften calls the gen_user() macro with the "user" prefix.
> >=20
> > Example: gen_user(user_u, user, user_r, s0, s0)
> >=20
> > This will no longer be valid, and the userprefix parameter in gen_user(=
) can be left empty (or needs a valid role if RBACSEP DefaultRole is levera=
ged).
> >=20
> > Example: gen_user(user_u,, user_r, s0, s0)
> >=20
> > UserPrefix will now default to object_r. This should not affect common =
policy implementations.
> >=20
> > The next phases will be:
> >=20
> > Renaming the UserPrefix statement to UserRBACSEPRole, and renaming refe=
rences to (user)?prefix to (user)?rbacseprole.
> > Adjusting semanage to expose UserRBACSEPRole.
> > Removing legacy UserPrefix (ROLE/USER_TEMPLATE) references from libsema=
nage.
> >=20
> > After this the UserPrefix to UserRBACSEPRole transition should be compl=
eted.
> >=20
> > This should get us by until someone decides to rewrite libsemanage to t=
ake advantage of CIL, simplify the code, and to make the code more robust.
>=20
> I guess my only question with regard to this phase and the next ones is w=
ith
> regard to backward compatibility.  Even if no one is using this facility,=
 we
> have to make sure we do not break existing installs upon upgrade.

I believe that Reference policy and derivatives can and probably should alr=
eady omit the "user" prefix from their gen_user() calls.
They probably can and probably should remove any UserPrefix statements alto=
gether without any issues.

If there are no UserPrefixes present in the policy then genhomedircon shoul=
d fall back to object_r.
Any upgrades will then just add specified userrbacseproles and other existi=
ng users should fall back to object_r via genhomedircon.

I might have overlooked aspects, and truth be told this is a little above m=
y pay grade.
Then again this functionality is already broken, and it has been for a long=
 time.

If Reference policy ever were to implement separation based on roles then t=
his needs to be addressed first I believe.

>=20
> >=20
> > Dominick Grift (3):
> >    libsemanage: fall back to valid "object_r" role instead of "user"
> >      prefix string
> >    semanage: do not default prefix to "user"
> >    cil: qualify roles from symtable when resolving userprefix
> >=20
> >   libsemanage/src/genhomedircon.c    |  2 +-
> >   libsemanage/src/user_record.c      |  4 ++--
> >   libsepol/cil/src/cil.c             |  7 +++++--
> >   libsepol/cil/src/cil_internal.h    |  1 +
> >   libsepol/cil/src/cil_resolve_ast.c | 10 ++++------
> >   python/semanage/semanage           |  2 +-
> >   6 files changed, 14 insertions(+), 12 deletions(-)
> >=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3b3AcACgkQJXSOVTf5
R2nsHgv/TeBmOKThS4PfQRIGXNIEg7dS6GxFCUUEgrc77s4TQnySr7T2KH6rXreG
hDVlNcaT8cxhw5Fmo1FEcNsuT/pJfMSJmwaHRux/rkRrsMIyMQyje6hlndRl645H
Ep8phRrohEfy+a06tMl1pfEURtSJQI/OmI7PPgSfwE1lbF37n8KCIGtRjyzJlb+g
R6O2+CPad8rjua/qaueqERDNm4z4eShhSUA6Yq3thRuXZBdqxY6ZER4FboF82UAK
Hh0mf77ktTa3cx0nzl4xPv+f+Du5ISdJsPIxyFm2x4bclPJfg4Kga6HPn9B+r00Q
6QVoe+HksEZZONYRCD/yIcUcXz0FSJKQajxdLwFOFPt9xHR9cLTChlN4MGhEybxH
qHFpqkUZ8/aoJOeuMYz1JsIbaGqz3Is7ka6Z/KCaehDH7NQ3yYpeKOlk7/BXWtFa
yyqwzxRfdx5SjsJcv4l+dmza6sn6tRh7tU/4D2xvcY1mdo0LglOojyKUNPIreSYK
yjDMDdm6
=QzgT
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
