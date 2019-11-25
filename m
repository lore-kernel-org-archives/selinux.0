Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475DEC432C0
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FDA20748
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 14:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0aSadw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfKYOKl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:10:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38690 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOKl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 09:10:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so16132533wmk.3
        for <selinux@vger.kernel.org>; Mon, 25 Nov 2019 06:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a7oTm6JsCs1X+JnnZrEXRetvSsTqHxfFjD9KXDaRvfs=;
        b=V0aSadw/K7fimktuQgdJ9g74uhkgTZQnUsvmTQ8Nm4QRFEvrchT7R1t/TwgvQ63KhR
         RpfbPBPQqZPN3RSEBXRHmwiLLvHZpqI9PTZZtHrJrUhwXQscG5EI9Cegr/xkUPBmUqgL
         SSrOn/n6KOtI7TIzcbQONp7skBE1UDYJFuvyg5s4WYpOi2EcoiKDVxuoqdz9CaPTn/+z
         Nx6xLm9pbMMvfxo7OMtcXdQJIykcIrKdJh8OQ2/Zas5QSmns1QlnskvhndwoV93wmf44
         2MiAcseoElv0nhixajecudKUr+ut8J5K60dyljxzor3MytXdh/tRqQka653u47ZUaaXS
         tqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=a7oTm6JsCs1X+JnnZrEXRetvSsTqHxfFjD9KXDaRvfs=;
        b=XAfb5Hs2VTbiMURVjhxeu5LWaHZy/Ua5Ob4yd1bhLBy6r/9c3p3uFNKq2BsrvqHiAY
         8CQCAqU/78MLY4NLU/b3p23Sj0cxtoaRQGw3Uh46xIIUrvDFHnumsTtsg2sknJIWUZm3
         iUMZZnQ7sDL+geypPs/wgbjz55witSmAo/ToN5J45la9XA+qK7ywoKlDaMBmteD9bXeY
         QCP0Fnf9ZnrFb4+HI22zPLK8MaSgW0PufTWxfLOkSOFFpnbUYOpYtfJwHW3aT2dU95pU
         FivXexS+A2dqzYIs+SNkK8PE9Q60LmHt7Vq6xNXCilGmvtfJgoKyD2jhMg/Vj0imxuHn
         m6iA==
X-Gm-Message-State: APjAAAWWW2Mc0Htr9hEZsn2tKggPmh1gfardowhpKCIcRIKzYRZBTQKG
        DpwC92BzQyVpdQj93x+TqM08ih40
X-Google-Smtp-Source: APXvYqytJkil3Ns9V1pi035qJuw8R/XpH0V0vyM7GePXPSFkrn72n0rItqa+EfAko4bzmfAF2XBaww==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr31015019wmb.150.1574691037571;
        Mon, 25 Nov 2019 06:10:37 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id c144sm8622404wmd.1.2019.11.25.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:10:36 -0800 (PST)
Date:   Mon, 25 Nov 2019 15:10:35 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole
 transition
Message-ID: <20191125141035.GB441967@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org
References: <20191123144245.3079306-1-dac.override@gmail.com>
 <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--H+4ONPRPur6+Ovig
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

Maybe we can duplicate the code instead. That way we would not have to touc=
h the existing, but dead userprefix code.
That should address any compatibility issues.

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

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3b4NYACgkQJXSOVTf5
R2nzWwv+OBv2b4z+0iD/PfwbTpnvjwYTl/2/xQbdM5qD+RlntJgc55NWlN+qdxHK
eKGKSRkfSD+7nH6IpKtYqfqAYgeRq800s5AOtajng8vs1fSAhrT7gf8FpBzfKP9u
U5Zf8M2GSswkYjqCT0+ctPz3sKNtu7IX8mplNptBBEw7DYQkhUlmK5k7ZFTKwnQJ
yZlzQqBPxECC6/aDtrAy2cYx3WYLLqgVomQeJUVoA6XHNclG4krbcNssBCHh1vV0
jpM9BjsfbuixHKv2FDnZT5Irnf+sZ7bL6bYTpzU/h2sxFsP1b8klpxm1mfZqCp59
nrVMHRF/4Ui/y4z5fpaw+8UXOAewU3l/hJcwRHTYOHRd2wZ6FNBEuNR6ZR0GlSBk
UH/rmxNGmWFCWFZH6gbrquYJrFjFtkORL3nlw+PGKQYmLM4ryqs7uWzcKFDd3qS9
d5vpfwCv1fkvunuviNmsM4LFPBkHhoR4qmlehUzfu7PEs66qtDJvpLKyxKHVJwip
5GCGTyGR
=4Boe
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
