Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D957C282DD
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4405720881
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 13:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkOLXOdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfEWNjx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 09:39:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45530 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbfEWNjw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 09:39:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so9261057edc.12
        for <selinux@vger.kernel.org>; Thu, 23 May 2019 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jXc2s0ib9el1/GVfCATbHKxMt9OETK5bj/CE+mVKAd4=;
        b=hkOLXOdPXZEyJFZWbaod0kb8qXUmU5+R0Dpm506ffVqDWfX8bCo5G0TKwoaje5f5ss
         M14xuzWGtmXLFrbLlwmkJCBqU4h78tbb7lsTuqo7LnJpD5ommPj0Urf+sF3jKgK44zv+
         dpgP1cGH8/6MprzMmiY0xZyJWEArH5T2fyI+fion8U18FzZ6WlWbOkiElMaVIj/klzpJ
         WPyGeByWTrYxpONomd0qcA6ndqyJ5VdiejGP9mvmkFvFz54g8erDU4e2fyWTDM4hX4Jr
         PjwK7aM/bsROiGzhKcPg5fs6L7M+nlTHHlOdkMGuGi4e3gh16PLb11cQQnrJJewHcwmb
         lwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jXc2s0ib9el1/GVfCATbHKxMt9OETK5bj/CE+mVKAd4=;
        b=P79GYzakd+QNN4d9MjP1Xv0MfazTcVfvlGNKxx+Di0l4ujEB0oS/XZBDOXh5RdkE9d
         /pwh9L1nWGt72J/yFsslkar0KZ4tdch1QO+AXx0TuprD3R9JSg8LKrmFLnGkPS1LMMEe
         fL9IHN6WvZljMEPpzuXnmvEc7t5wdmR087sCsKXzTawg21NjvT7OxTp0/nlj7/U8nXPB
         0i6QIIyBa+y4whAkdsPswgxxToGeRNamQPAuCH5nbqyq4NtSjl20IiFOi/bLl6RnbF1S
         brZBzFO4W9ABPcCH51ibYIKyya/KE1GC2WnCEf2yJOdNnhAjrfDPcNuQKOGBw6d3TNaO
         JlVw==
X-Gm-Message-State: APjAAAWvRzwomSFcrhhFVmvIwF7tk+PdQCp5qM+RHTeYlugQMZ39IH8C
        ovOuM7QvOa3FkFMChrXKRIoDleur
X-Google-Smtp-Source: APXvYqyS7M1ZJG6/2nqkXU8qPBF/bKkGQ9Q1rQVUuQYdaw6rwyaEBTE1mmEKsRudpvYeQoudHNrH+g==
X-Received: by 2002:a17:906:68c4:: with SMTP id y4mr64355902ejr.198.1558618790827;
        Thu, 23 May 2019 06:39:50 -0700 (PDT)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id v27sm4452148eja.68.2019.05.23.06.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 06:39:49 -0700 (PDT)
Date:   Thu, 23 May 2019 15:39:47 +0200
From:   Dominick Grift <dac.override@gmail.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Subject: Re: [PATCH userspace 0/4] Remove redundant rules when building
 policydb
Message-ID: <20190523133947.GB30512@brutus.lan>
Mail-Followup-To: Ondrej Mosnacek <omosnace@redhat.com>,
        selinux@vger.kernel.org
References: <20190523102449.9621-1-omosnace@redhat.com>
 <20190523131455.GA30512@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20190523131455.GA30512@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2019 at 03:14:55PM +0200, Dominick Grift wrote:
> On Thu, May 23, 2019 at 12:24:45PM +0200, Ondrej Mosnacek wrote:
> > This series implements an optional optimization step when building
> > a policydb via semodule or secilc, which identifies and removes rules
> > that are redundant -- i.e. they are already covered by a more general
> > rule based on attribute inheritance.
>=20
> Some stats with dssp2-standard:
>=20
> [kcinimod@myguest dssp2-standard]$ time secilc -n `find . -name *.cil` -o=
 policy.31.noopt
>=20
> real    0m9.278s
> user    0m7.036s
> sys     0m2.017s
> [kcinimod@myguest dssp2-standard]$ time secilc `find . -name *.cil` -o po=
licy.31.opt
>=20
> real    0m19.343s
> user    0m16.939s
> sys     0m2.027s
> [kcinimod@myguest dssp2-standard]$ ls -lh policy.*
> -rw-rw-r--. 1 kcinimod kcinimod 2.4M May 23 15:11 policy.31.noopt
> -rw-rw-r--. 1 kcinimod kcinimod 2.3M May 23 15:12 policy.31.opt
>=20
> Was unable to see the actual diff as sediff got oom-killed on me

According to percentage calculator thats roughly a 4 percent gain size-wise=
 at a 47 percent performance penalty.
Looks like dssp2-standard is pretty efficient as it is.

>=20
> >=20
> > Since the performance penalty of this additional step is very small
> > (it adds about 1 s to the current running time of ~20-30 s [1]) and
> > it can have a big positive effect on the number of rules in policy
> > (it manages to remove ~40% AV rules from Fedora 29 policy), the
> > optimization is enabled by default and can be turned off using a
> > command-line option (--no-optimize) in secilc and semodule [2].
> >=20
> > The optimization routine eliminates:
> >  * all allow/neverallow/dontaudit/auditallow rules (including xperm
> >    variants) that are covered by another more general rule,
> >  * all conditional versions of the above rules that are covered by a
> >    more general rule either in the unconditional table or in the same
> >    branch of the same conditional.
> >=20
> > The optimization doesn't process other rules, since they currently
> > do not support attributes. There is some room left for more precise
> > optimization of conditional rules, but it would likely bring only
> > little additional benefit.
> >=20
> > When the policy is mostly or fully expanded, the optimization should
> > be turned off. If it isn't, the policy build time will increase a lot
> > for no benefit. However, the complexity of optimization will be only
> > linear w.r.t. the number of rules and so the impact should not be
> > catastrophic. (When testing with secilc on a subset of Fedora policy
> > with -X 100000 the build time was 1.7 s with optimization vs. 1 s
> > without it.)
> >=20
> > Tested live on my Fedora 29 devel machine under normal use. No unusual
> > AVCs were observed with optimized policy loaded.
> >=20
> > Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/5361=
57427
> >=20
> > NOTE: The xperm rule support wasn't tested -- I would welcome some
> >       peer review/testing of this part.
> >=20
> > [1] As measured on my machine (Fedora 29 policy, x86_64).
> > [2] I have no problem with switching it to opt-in if that is preferred.
> >=20
> > Ondrej Mosnacek (4):
> >   libsepol: add a function to optimize kernel policy
> >   secilc: optimize policy before writing
> >   libsemanage: optimize policy on rebuild
> >   semodule: add flag to disable policy optimization
> >=20
> >  libsemanage/include/semanage/handle.h      |   4 +
> >  libsemanage/src/direct_api.c               |   7 +
> >  libsemanage/src/handle.c                   |  13 +
> >  libsemanage/src/handle.h                   |   1 +
> >  libsemanage/src/libsemanage.map            |   5 +
> >  libsepol/include/sepol/policydb.h          |   5 +
> >  libsepol/include/sepol/policydb/policydb.h |   2 +
> >  libsepol/src/libsepol.map.in               |   5 +
> >  libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
> >  libsepol/src/policydb_public.c             |   5 +
> >  policycoreutils/semodule/semodule.c        |  12 +-
> >  secilc/secilc.c                            |  16 +-
> >  12 files changed, 442 insertions(+), 3 deletions(-)
> >  create mode 100644 libsepol/src/optimize.c
> >=20
> > --=20
> > 2.20.1
> >=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlzmop8ACgkQJXSOVTf5
R2lVhAwAhYohkpWeKKUnNmckekfCBJN9pQ1pIOLIL18nAhndTPiJJ+R1zqdajw3U
h78dVcnzPjbICV5S0vZtKdFiUQ7a3bdMM61ZXWfe/480GKY/5bGif6K9g8+wopM7
kWDPTluxoY0++KG1bLnUZAjuu3cVzMgOtr+dkKvpOPkiW9pCchTkoR+zrfTGgoJP
T1uef1aWqZlr6P9UOJx19fnDhvkFdGFEb3gczjU1x6Rw0HC0fPp86hZC17QvepQA
5gTG0wK2/RfiMuiVFmn8niNsgmiuHt4ZEzwPm4V6fjOdQq23f5FhvEcfQL9MwypS
V66N6nuWngYQYtvm4N7Gqekrowh6Xq/2jlJfdrIis0LRBURkyhr3ukAYuh2nPmfO
nm7OsCvhmho3mH9bLl9PwzBmwCiDG5w3KneQS2R9P3hf8L9DAok9aBIAn/LddCBM
fgb4G40hueWSnsr1nzZyt3+1YL3So+GdO7LBGyzffrOwszFG3iC6rsOMsgm34dR+
AzxjlXF9
=VjLW
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
