Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375BC432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6592053B
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmWUGcYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0PZv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:25:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35092 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PZv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:25:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so27145910wrw.2
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EpFbYV3UZuiklqFeRfVyRAzYGuQB9Zl6ancX0cstro8=;
        b=rmWUGcYzbNc1FRAcq8Aqm+P+are5UtD0JWNv+2jsy6IivNER4+HvsiX8ur1T6Qe4l5
         Do9WefdDkMmnxxvNfhU/nWfZG7mUdBycfmx8JWN/o0KX8WlHt8suDF6OrGjEbK8eMZAa
         yCFDCQPQtRVcLNXMZJt6+hI20IniPKO5LjIxTl5NovfU2ibrYIY3LUVzYvechl0G0AiR
         09u+v+632oHXT4tTyfDGhKAfTC+Vn0CLLN/B0MHuDPsV0T0szpZC0ESu0CDSYOOMfm+D
         NOFPwORFxSN4b5vG5VNUpps8gMB9tiwlSeAoaanUO7TZV3kmtgxNr3QVwOD5ykw/dPpj
         au3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EpFbYV3UZuiklqFeRfVyRAzYGuQB9Zl6ancX0cstro8=;
        b=blgsYmyW/+HDnbNAP3xcKREPc9xzQqaz+PPna2Lzx+223zzysUpD8V8hVHiN6i/jsg
         lBpSKPGwk5m4nX9SOUfWDHtqGFht53TERiul2L+kroBub7eDWQOZVT4+52/aZJYmrw2T
         jGnO2zfaRXySU046PTu2uG4L8hJdeGVYH9oeygWAFTzhNl3lr9JKzZpbhoz69p8k+J9T
         HdkIsFt8+8x+iWpN5iHeRGXIHneOirRV1R6fgNuH7n8G4qFPO92t8bWyFvehehfGMiYC
         gYtdf8ZbYZ9CL4R70ySlNnzLAbwmFoRxWp6fovHSHFmIBz7/Lrpuyg7FF65dL9kWG3OX
         QPvQ==
X-Gm-Message-State: APjAAAUpxEgeYgetRJburhBOlGpcZMg/Dy501C2H2IkLam7Ze2UGUXWZ
        Zmp9ite24GTg6kJXixmNO8M=
X-Google-Smtp-Source: APXvYqzCD+cpiJFtTiWdZICu/hjDmM3AjphhZyJrUjiZO9A4vJZw8lsKQwUwdBbIatpNOBTYNshohg==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr7069840wrp.321.1574868348273;
        Wed, 27 Nov 2019 07:25:48 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id d7sm19731507wrx.11.2019.11.27.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:25:47 -0800 (PST)
Date:   Wed, 27 Nov 2019 16:25:46 +0100
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org,
        "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: Re: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole
 transition
Message-ID: <20191127152546.GB23027@brutus.lan>
Mail-Followup-To: Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@vger.kernel.org,
        "Christopher J. PeBenito" <pebenito@ieee.org>
References: <20191123144245.3079306-1-dac.override@gmail.com>
 <7f62f389-f531-f1dd-cb38-3a5b75e40731@tycho.nsa.gov>
 <20191125141035.GB441967@brutus.lan>
 <fe0d0ffe-a96a-9438-76f2-7759a41b823c@tycho.nsa.gov>
 <20191127112241.GA23027@brutus.lan>
 <49b2e25e-d317-3ea9-dd75-5beae73309ee@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <49b2e25e-d317-3ea9-dd75-5beae73309ee@tycho.nsa.gov>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 10:03:44AM -0500, Stephen Smalley wrote:
> On 11/27/19 6:22 AM, Dominick Grift wrote:
> > On Tue, Nov 26, 2019 at 01:27:42PM -0500, Stephen Smalley wrote:
> > > On 11/25/19 9:10 AM, Dominick Grift wrote:
> > > > On Mon, Nov 25, 2019 at 08:24:21AM -0500, Stephen Smalley wrote:
> > > > > On 11/23/19 9:42 AM, Dominick Grift wrote:
> > > > > > In 2008 support for UserPrefix was removed from Reference polic=
y.
> > > > > > The code to support this functionality in libsepol and libseman=
age however remained albeit slightly modified.
> > > > > > I am not sure why it was not fully removed.
> > > > > >=20
> > > > > > DefaultRole replaces UserPrefix functionality but the code in l=
ibsepol and libsemanage was only slighty adjusted to accomodate my use-case.
> > > > > > This was done in 88e334f1923396d5ace56b8439c731dcde0d1f3b (2016=
).
> > > > > > I do not use semanage and I do not mind using the old UserPrefi=
x statement, but there is some confusion.
> > > > > > For example there was a report recently about how semanage does=
 not document UserPrefix.
> > > > > > The documentation was likely removed from view because UserPref=
ix is no longer supported as such.
> > > > > >=20
> > > > > > I want to make the situation better and this proposal is the ne=
xt phase.
> > > > > > This proposal causes some disruption as Reference policy based =
policy often calls the gen_user() macro with the "user" prefix.
> > > > > >=20
> > > > > > Example: gen_user(user_u, user, user_r, s0, s0)
> > > > > >=20
> > > > > > This will no longer be valid, and the userprefix parameter in g=
en_user() can be left empty (or needs a valid role if RBACSEP DefaultRole i=
s leveraged).
> > > > > >=20
> > > > > > Example: gen_user(user_u,, user_r, s0, s0)
> > > > > >=20
> > > > > > UserPrefix will now default to object_r. This should not affect=
 common policy implementations.
> > > > > >=20
> > > > > > The next phases will be:
> > > > > >=20
> > > > > > Renaming the UserPrefix statement to UserRBACSEPRole, and renam=
ing references to (user)?prefix to (user)?rbacseprole.
> > > > > > Adjusting semanage to expose UserRBACSEPRole.
> > > > > > Removing legacy UserPrefix (ROLE/USER_TEMPLATE) references from=
 libsemanage.
> > > > > >=20
> > > > > > After this the UserPrefix to UserRBACSEPRole transition should =
be completed.
> > > > > >=20
> > > > > > This should get us by until someone decides to rewrite libseman=
age to take advantage of CIL, simplify the code, and to make the code more =
robust.
> > > > >=20
> > > > > I guess my only question with regard to this phase and the next o=
nes is with
> > > > > regard to backward compatibility.  Even if no one is using this f=
acility, we
> > > > > have to make sure we do not break existing installs upon upgrade.
> > > >=20
> > > > Maybe we can duplicate the code instead. That way we would not have=
 to touch the existing, but dead userprefix code.
> > > > That should address any compatibility issues.
> > >=20
> > > At a minimum, we must avoid breaking existing installs upon upgrade, =
and we
> > > must avoid breaking compilation of existing policy modules (both refp=
olicy
> > > and CIL).
> > >=20
> > > A simple test would be ensuring that if you upgrade the userspace and=
 run
> > > semodule -B with your previously installed policy (including its exis=
ting
> > > userprefix statements), there are no errors and you get the same
> > > file_contexts.homedirs as you had before.
> > >=20
> > > That should be relatively easy to ensure for targeted policy.  Might =
be more
> > > complicated with your policy, the CLIP policy, or perhaps others.
> >=20
> > I am thinking that we might be able to add something to cil_resolve_use=
rprefix() that would just not process any entries referencing the "prefix" =
keyword as in "user ... prefix ...;" instead of "user ... rbacseprole ...;"=
, and instead emits a warning: "Not processing deprecated userprefix: userp=
refix. Use userrbacseprole instead."
> > That would then just not add those entries to users_extra, and instead =
rely on "fallback_rbacseprole=3Dobject_r" in genhomedircon.c, if the "migra=
tion" code in libsemanage does not catch it first.
>=20
> I don't think we want warnings; otherwise someone upgrading Fedora to new
> userspace would get constant warnings on all subsequent libsemanage
> transactions due to their existing distro-provided users_extra file.
>=20
> Also, not to bikeshed, but userrbacseprole is hard on the eyes.  Looks li=
ke
> libsemanage/src/genhomedircon.c currently tests whether the prefix value =
is
> a homedir role (prefix_is_homedir_role()) and uses it as such in that cas=
e.
> Can we just do that?  And if we have to rename it, maybe just call it
> homedir_role instead.

I would then prefer something like "userfilerole", "filerole" and "user ...=
 filerole ...;"

homedir_role is inaccurate. It never was a homedir only thing:

/tmp, /var/tmp, /run/user/%{USERID}, /var/spool/mail/%{USERNAME}, /home, /d=
ev/shm

>=20
>=20
>=20
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAl3elXUACgkQJXSOVTf5
R2liMQv+PPs7F04Efdq7y5NV/ZA+BDcHVWr6jOxF8MOR77GDX7cvCE36Mk+uHLv1
yH3EN5jKDiofHTTjOpgQB63URUhfYeyYG3LKbsC+s6X0lU8UInoW81bDw9FqVlmg
IRG+uW5vB3XpOJwIPAFn6h/lTjgtgRq9OWL3yOEnDVpA0fD1kPUoDFW4OHnu3j/K
UxgjRnpcj6mnkC2o9OFJm3uFpYv02JO4NeaL5t3W4/b5CQOmVjwk2Uo0nWZD0SGu
t1vhef8XPCqEK6yPRQ5MIL2ntQ8Xg3F0aZ6VoOqJM18Oi51zGkXNA/dAzy1GIBnM
pgRXTTCluk+PNFNYN0Tv8+UWvi35BQX9i4pidT7dZYmLXd3QSLWCOdTB3a8LIq1+
C2VNVWPr7yQPdpeB5Hjh0VCEbiV3lEudt90Oz77HldNBMfvOH7dUIhUBDC5vdfgu
/ZfBm6rINs87nFp9EBIb56wDf90Xv58dlVRD2n+9yR53kf+LPE6mbwcW5gLIitOI
hL1uMgBe
=XhpY
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
