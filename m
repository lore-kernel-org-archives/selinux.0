Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1869C7EE23
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 00:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjFBAFr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 20:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjFBAFr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 20:05:47 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA8112C
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 17:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685664342; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=c3x8/dvkkFH2FNmEcAzw+KpTlJkjKKAqfyQxR3yrsG6GRMfXknuWy2xZdVeGwy11kT2E8L1gp1cPo1cOE8RgAtd7rY0yoSW2J9L/2Zf9lvMDmv7u2XEcA24OrOO580dhovmqK2PSVSxOin4wawQzOv2CJEURZ1FOLcq5Tq21aCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685664342; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:Resent-Date:Resent-To:References:Resent-Message-ID:Resent-From:Subject:To; 
        bh=NPYtkmCjIHWmHj5YnnZfGOk9+jVNis/oLLZe5D73jhE=; 
        b=hVmOqeKQ5JY4M1Mm2LA29yvQW254n3hIGEqtgAwKemnvlHDWVVNrA4AFj3FuFJR66/tOLWDtwLRxp4tmce+1vO8seZU5YrTgxOWohP5Ck8zviUpvaXJzxyGQoXFRrRYeUuD0F/NXlcJuTib+pDww4l8R/myveAia+WmbTmSHfFs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685664342;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=Resent-From:Resent-Date:Resent-Message-ID:Resent-To:Date:Date:From:From:To:To:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=NPYtkmCjIHWmHj5YnnZfGOk9+jVNis/oLLZe5D73jhE=;
        b=TTKbg9PdUtqB/Dxh1nFeb3aEWhe2B2VSxkdW9IBwxYtWOxg8HVXkdb35LJSTJtts
        a46KPztEjJJHuzrjVz1F1U5PyRVPzU7rywDu4C/M5C1kZY/dSI0Ys93r9KrOGznnvdx
        ky2jaJiPNCnaCtB1YA839DG9hom9nWlxTCIfNBQc=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 168566434031781.25643635688118; Fri, 2 Jun 2023 02:05:40 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id A94172081F76
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 00:05:39 +0000 (UTC)
Date:   Fri, 2 Jun 2023 01:59:50 +0200
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 0/8] checkpolicy, libsepol: add prefix/suffix matching to
 filename type transitions
Message-ID: <20230601235948.nv6ypxqqlm3hkl2n@jmarcin-t14s-01>
References: <20230531114914.2237609-1-juraj@jurajmarcin.com>
 <CAP+JOzS1nhxF8EttikRtYBW2QtW=ck+P4mC2dovgP4kp-g9WQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP+JOzS1nhxF8EttikRtYBW2QtW=ck+P4mC2dovgP4kp-g9WQQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2023-06-01 17:03, James Carter wrote:
> I did a bit of testing.
>=20
> These all work:
> ~/local/usr/bin/secil2tree -o test_01.cil.tree test_01.cil
> ~/local/usr/bin/secilc -o test_01.cil.bin test_01.cil
> ~/local/usr/bin/checkpolicy -C -b -o test_01.cil.bin.cil test_01.cil.bi=
n
>=20
> /local/usr/bin/checkpolicy -o test_01.conf.bin test_01.conf
> ~/local/usr/bin/checkpolicy -C -b -o test_01.conf.bin.cil test_01.conf.=
bin
>=20
> ~/local/usr/bin/secil2conf -o test_01.cil.conf test_01.cil
> ~/local/usr/bin/checkpolicy -o test_01.cil.conf.bin test_01.cil.conf
>=20
> ~/local/usr/bin/checkmodule -o base_01.mod base_01.te
> ~/local/usr/bin/checkmodule -m -o mod_02.mod mod_02.te
> ~/local/usr/bin/semodule_package -o base_01.pp -m base_01.mod
> ~/local/usr/bin/semodule_package -o mod_02.pp -m mod_02.mod
> ~/local/usr/bin/semodule_link -o test_01.pp.lnk base_01.pp mod_02.pp
> ~/local/usr/bin/semodule_expand test_01.pp.lnk test_01.pp.bin
>=20
> These do not work:
> ~/local/usr/bin/checkpolicy -F -b -o test_01.cil.bin.conf test_01.cil.b=
in
> ~/local/usr/bin/checkpolicy -F -b -o test_01.conf.bin.conf test_01.conf=
.bin
> ~/local/usr/bin/checkpolicy -F -b -o test_01.pp.bin.conf test_01.pp.bin
>=20
> It appears something is wrong with translating the binary to a
> policy.conf, but I haven't had a chance to look deeper.

Thank you for your feedback! I have managed to find the issue in the 6th
patch of the series (checkpolicy, libsepol: add prefix/suffix support to
kernel policy) where I forgot to increment the number of arguments.

With this fix all the mentioned tests work (I will also include it in v2
later):


diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index fd036fa9..0d5fef33 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1721,7 +1721,7 @@ static int name_trans_to_strs_helper(hashtab_key_t =
k, hashtab_datum_t d, void *a
                sepol_log_err("Unknown name match type: %" PRIu8, args->m=
atch);
                return SEPOL_ERR;
        }
-       return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\"%s %s)=
", 6,
+       return strs_create_and_add(args->strs, "(%s %s %s %s \"%s\"%s %s)=
", 7,
                                   args->flavor, args->src, args->tgt,
                                   args->class, name, match_str,
                                   args->pdb->p_type_val_to_name[*otype -=
 1]);
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
index 50fad1fb..e58eb67d 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1699,7 +1699,7 @@ static int name_trans_to_strs_helper(hashtab_key_t =
k, hashtab_datum_t d, void *a
                sepol_log_err("Unknown name match type: %" PRIu8, args->m=
atch);
                return SEPOL_ERR;
        }
-       return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\"%s;"=
, 6,
+       return strs_create_and_add(args->strs, "%s %s %s:%s %s \"%s\"%s;"=
, 7,
                                   args->flavor, args->src, args->tgt,
                                   args->class,
                                   args->pdb->p_type_val_to_name[*otype -=
 1],


--=20
Juraj Marcin

>=20
> I've attached the very simple test policies I used.
>=20
> Thanks,
> Jim
>=20
> On Wed, May 31, 2023 at 7:51=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> >
> > Currently, filename transitions are stored separately from other type
> > enforcement rules and only support exact name matching. However, in
> > practice, the names contain variable parts. This leads to many
> > duplicated rules in the policy that differ only in the part of the na=
me,
> > or it is even impossible to cover all possible combinations.
> >
> > This series implements equivalent changes made by this kernel patch
> > series [1].
> >
> > First, this series of patches moves the filename transitions to be pa=
rt
> > of the avtab and avrule structures. This not only makes the
> > implementation of prefix/suffix matching and future enhancements easi=
er,
> > but also reduces the technical debt regarding the filename transition=
s.
> > Next, the last three patches implement the support for prefix/suffix
> > name matching itself by extending the structures added in previous
> > patches in this series and adding the support to CIL in the last of t=
he
> > triple.
> >
> > Even though, moving everything to avtab increases the memory usage an=
d
> > the size of the binary policy itself and thus the loading time, the
> > ability to match the prefix or suffix of the name will reduce the
> > overall number of rules in the policy which should mitigate this issu=
e.
> >
> > [1]: https://lore.kernel.org/selinux/20230531112927.1957093-1-juraj@j=
urajmarcin.com/
> >
> > Juraj Marcin (8):
> >   checkpolicy, libsepol: move transition to separate structure in avt=
ab
> >   checkpolicy, libsepol: move filename transitions to avtab
> >   checkpolicy, libsepol: move filename transition rules to avrule
> >   libsepol: implement new kernel binary format for avtab
> >   libsepol: implement new module binary format of avrule
> >   checkpolicy, libsepol: add prefix/suffix support to kernel policy
> >   checkpolicy, libsepol: add prefix/suffix support to module policy
> >   libsepol/cil: add support for prefix/suffix filename transtions to =
CIL
> >
> >  checkpolicy/checkmodule.c                  |   9 +
> >  checkpolicy/module_compiler.c              |  12 -
> >  checkpolicy/module_compiler.h              |   1 -
> >  checkpolicy/policy_define.c                | 211 +-----
> >  checkpolicy/policy_define.h                |   3 +-
> >  checkpolicy/policy_parse.y                 |  15 +-
> >  checkpolicy/policy_scan.l                  |   6 +
> >  checkpolicy/test/dismod.c                  |  39 +-
> >  checkpolicy/test/dispol.c                  | 106 +--
> >  libsepol/cil/src/cil.c                     |   8 +
> >  libsepol/cil/src/cil_binary.c              |  63 +-
> >  libsepol/cil/src/cil_build_ast.c           |  25 +-
> >  libsepol/cil/src/cil_copy_ast.c            |   1 +
> >  libsepol/cil/src/cil_internal.h            |   5 +
> >  libsepol/cil/src/cil_policy.c              |  17 +-
> >  libsepol/cil/src/cil_resolve_ast.c         |  10 +
> >  libsepol/cil/src/cil_write_ast.c           |   2 +
> >  libsepol/include/sepol/policydb/avtab.h    |  19 +-
> >  libsepol/include/sepol/policydb/hashtab.h  |  14 +
> >  libsepol/include/sepol/policydb/policydb.h |  50 +-
> >  libsepol/src/avrule_block.c                |   1 -
> >  libsepol/src/avtab.c                       | 336 +++++++++-
> >  libsepol/src/conditional.c                 |   6 +-
> >  libsepol/src/expand.c                      | 149 ++---
> >  libsepol/src/kernel_to_cil.c               | 182 ++----
> >  libsepol/src/kernel_to_common.h            |  10 +
> >  libsepol/src/kernel_to_conf.c              | 178 ++----
> >  libsepol/src/link.c                        |  57 +-
> >  libsepol/src/module_to_cil.c               |  86 +--
> >  libsepol/src/optimize.c                    |   8 +
> >  libsepol/src/policydb.c                    | 479 +++-----------
> >  libsepol/src/policydb_validate.c           | 100 +--
> >  libsepol/src/services.c                    |   5 +-
> >  libsepol/src/write.c                       | 712 ++++++++++++++++---=
--
> >  34 files changed, 1534 insertions(+), 1391 deletions(-)
> >
> > --
> > 2.40.0
> >
