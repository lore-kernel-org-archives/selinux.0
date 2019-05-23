Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F1C282DD
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E63B20851
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 13:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOWLIa+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfEWNPB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 09:15:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44615 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWNPA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 09:15:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so9159110edm.11
        for <selinux@vger.kernel.org>; Thu, 23 May 2019 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A4luETZ74gsX2bG/WYku/rBInWu3hwJNJjRimrJqvBE=;
        b=HOWLIa+ekMyk2NpxVWYfbgCgEAOMGUSasGkVutQciCYILafPjhQYfR8WQpIPZD0aV2
         xaJld1KLASFGOeOBigTe/8e4hQegt72Vki8P+hvaZ8UHdpOMGJzalTDiGCKDEU4SnCcu
         V2a/5fm5kG6sMIAOU7YWhPrMDrFbdh6zcBt6yIvjGrFmellpUbFh4c6Gjmi3hbTS/ICi
         lLe8ZW/HDIayMXxZJ60r5eN2AC6bIr9GU2CFkQPGDjgz9VJUSuGdhvD8TsGH9wo02u5h
         T87+hGItAIHXQKXKtptpS5XhsbbjkXjXBT+XtJFnJb6ewp8FTGTjnsMqhgzab/LIapcn
         jWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=A4luETZ74gsX2bG/WYku/rBInWu3hwJNJjRimrJqvBE=;
        b=sAQ1GB5eC9S6Ogt5ukutgkoOvku+NuJSSo5AFHiYQLE5dvNshF5QdvDugYzkMdH3p2
         Vv+IldZGsdHQ/hvQ7vUXu/J5TlmnudtyakVg3q3qZwv7OcHyQr9HJcbv72NHwwUYwlH2
         Aw0sxrg4Lb4w2X7UqrZXNlAY/YRv9a6BBaAA/D/H3Xtjs0sW5cgwdVrEZPPdIbrm559y
         cJxB4xqOqLsOrcRx5SUFu6i+G7+xNmodAKMLJG6VSxW1q8TeB/K4vXDrXpzti1mCBHjh
         4EAG/Y/Z/iDcJr54AgBax5czmz4y3zFS+Kj3HbCGMKUMeoRSm0ZNN7E94I6LXrR5uu7/
         sPNQ==
X-Gm-Message-State: APjAAAUN1RquC8wG0g3CYdnSYMtNSn0VzXiimjhvCwlwpVBjFXytrF/K
        ljrZHBeSngHjO/0RWQb2cv0=
X-Google-Smtp-Source: APXvYqwaycwoaGOugyRNmFLsqocUpvpSZuVUOQ6GWUktKtYG/7zQXbRaKGxa64nnJ5dHUXZNdXClbg==
X-Received: by 2002:a50:ac3a:: with SMTP id v55mr96934777edc.96.1558617298941;
        Thu, 23 May 2019 06:14:58 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id k57sm7910763ede.17.2019.05.23.06.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 06:14:57 -0700 (PDT)
Date:   Thu, 23 May 2019 15:14:55 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH userspace 0/4] Remove redundant rules when building
 policydb
Message-ID: <20190523131455.GA30512@brutus.lan>
Mail-Followup-To: Ondrej Mosnacek <omosnace@redhat.com>,
        selinux@vger.kernel.org
References: <20190523102449.9621-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190523102449.9621-1-omosnace@redhat.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2019 at 12:24:45PM +0200, Ondrej Mosnacek wrote:
> This series implements an optional optimization step when building
> a policydb via semodule or secilc, which identifies and removes rules
> that are redundant -- i.e. they are already covered by a more general
> rule based on attribute inheritance.

Some stats with dssp2-standard:

[kcinimod@myguest dssp2-standard]$ time secilc -n `find . -name *.cil` -o p=
olicy.31.noopt

real    0m9.278s
user    0m7.036s
sys     0m2.017s
[kcinimod@myguest dssp2-standard]$ time secilc `find . -name *.cil` -o poli=
cy.31.opt

real    0m19.343s
user    0m16.939s
sys     0m2.027s
[kcinimod@myguest dssp2-standard]$ ls -lh policy.*
-rw-rw-r--. 1 kcinimod kcinimod 2.4M May 23 15:11 policy.31.noopt
-rw-rw-r--. 1 kcinimod kcinimod 2.3M May 23 15:12 policy.31.opt

Was unable to see the actual diff as sediff got oom-killed on me

>=20
> Since the performance penalty of this additional step is very small
> (it adds about 1 s to the current running time of ~20-30 s [1]) and
> it can have a big positive effect on the number of rules in policy
> (it manages to remove ~40% AV rules from Fedora 29 policy), the
> optimization is enabled by default and can be turned off using a
> command-line option (--no-optimize) in secilc and semodule [2].
>=20
> The optimization routine eliminates:
>  * all allow/neverallow/dontaudit/auditallow rules (including xperm
>    variants) that are covered by another more general rule,
>  * all conditional versions of the above rules that are covered by a
>    more general rule either in the unconditional table or in the same
>    branch of the same conditional.
>=20
> The optimization doesn't process other rules, since they currently
> do not support attributes. There is some room left for more precise
> optimization of conditional rules, but it would likely bring only
> little additional benefit.
>=20
> When the policy is mostly or fully expanded, the optimization should
> be turned off. If it isn't, the policy build time will increase a lot
> for no benefit. However, the complexity of optimization will be only
> linear w.r.t. the number of rules and so the impact should not be
> catastrophic. (When testing with secilc on a subset of Fedora policy
> with -X 100000 the build time was 1.7 s with optimization vs. 1 s
> without it.)
>=20
> Tested live on my Fedora 29 devel machine under normal use. No unusual
> AVCs were observed with optimized policy loaded.
>=20
> Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/536157=
427
>=20
> NOTE: The xperm rule support wasn't tested -- I would welcome some
>       peer review/testing of this part.
>=20
> [1] As measured on my machine (Fedora 29 policy, x86_64).
> [2] I have no problem with switching it to opt-in if that is preferred.
>=20
> Ondrej Mosnacek (4):
>   libsepol: add a function to optimize kernel policy
>   secilc: optimize policy before writing
>   libsemanage: optimize policy on rebuild
>   semodule: add flag to disable policy optimization
>=20
>  libsemanage/include/semanage/handle.h      |   4 +
>  libsemanage/src/direct_api.c               |   7 +
>  libsemanage/src/handle.c                   |  13 +
>  libsemanage/src/handle.h                   |   1 +
>  libsemanage/src/libsemanage.map            |   5 +
>  libsepol/include/sepol/policydb.h          |   5 +
>  libsepol/include/sepol/policydb/policydb.h |   2 +
>  libsepol/src/libsepol.map.in               |   5 +
>  libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
>  libsepol/src/policydb_public.c             |   5 +
>  policycoreutils/semodule/semodule.c        |  12 +-
>  secilc/secilc.c                            |  16 +-
>  12 files changed, 442 insertions(+), 3 deletions(-)
>  create mode 100644 libsepol/src/optimize.c
>=20
> --=20
> 2.20.1
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlzmnMsACgkQJXSOVTf5
R2kP8gv+Ju3GRqNAkvjw88uacGZ9NdtOCzQs1usEsfC4d9IKkjyjgMmDSD/VmWER
jO2UdqG4wuVd6DYXKsaV0eUT41oKjseHSSqMJoCcG1Mup+NE6TFTCy/0KvKcUK0e
KY1MqGv9FWVQcSp4puqB7d1NLDEAPBekp029hF3W7Mz+xRfoQhjrboz52zlAkCcT
d4WlMcEKgtp1242rWxPnJECwQNtDYRNawJW1pCAxQnbYpH/9qR079rhB5OBC6BTr
e7hXvRzQ3k2vguo5PfDnQiQMr2pdgolajQ45u+pvO++enVJO+RhpZ6m+BstG8tQZ
WKvTr7Te31P4RQEkKiax/lqwOsjfhJCh6veZHoLs/oBfxipbh5QOmEGE6ISMxovY
zEDGbFDYCyCKiTaAmCzJ6zqWPMZQQVdqEAz8O/n8e9fwnewScSQSmnFTGnwxHsNJ
Xmr2MK/Q+Tpb5F4WdMh/+WYzfDew+/x0LDTSXPAIoJLqrXuhiGdbEjAAEs2Xqev3
Md7tWtSL
=Hq8u
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
