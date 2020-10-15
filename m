Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97549C433DF
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C69822254
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrPwlf1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgJOR1T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgJOR1T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602782837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AbGqkGK2CacuMtPjvfFLASIvxXijpvXCvkLVA3rpWzc=;
        b=hrPwlf1PLtrVw0DtLOkkDsNc0CLo7LI+JbfN8biX8qsw65gHSKTVG15bJ5FEdaQe5PCDQq
        vqOlbGgu3edeRkNE5YKPDd25mFOnAlXLPINC7g5pXHVfdPSgOansqRBWjPZLAQEDoVcLvr
        1Pa8FEus80BaXtRs6KzO7QXGC0w2Xa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-2uBGbOHKP8-ZBUyh2piEHQ-1; Thu, 15 Oct 2020 13:27:14 -0400
X-MC-Unique: 2uBGbOHKP8-ZBUyh2piEHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2657E64092;
        Thu, 15 Oct 2020 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 077F410013C1;
        Thu, 15 Oct 2020 17:27:11 +0000 (UTC)
Date:   Thu, 15 Oct 2020 19:27:09 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH userspace] libsepol/cil: fix signed overflow caused by
 using (1 << 31) - 1
Message-ID: <20201015172709.GA45449@localhost.localdomain>
References: <20201003131908.1867282-1-nicolas.iooss@m4x.org>
 <20201014180106.GA16337@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201014180106.GA16337@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 08:01:06PM +0200, Petr Lautrbach wrote:
> On Sat, Oct 03, 2020 at 03:19:08PM +0200, Nicolas Iooss wrote:
> > When compiling SELinux userspace tools with -ftrapv (this option
> > generates traps for signed overflow on addition, subtraction,
> > multiplication operations, instead of silently wrapping around),
> > semodule crashes when running the tests from
> > scripts/ci/fedora-test-runner.sh in a Fedora 32 virtual machine:
> >=20
> >     [root@localhost selinux-testsuite]# make test
> >     make -C policy load
> >     make[1]: Entering directory '/root/selinux-testsuite/policy'
> >     # Test for "expand-check =3D 0" in /etc/selinux/semanage.conf
> >     # General policy build
> >     make[2]: Entering directory '/root/selinux-testsuite/policy/test_po=
licy'
> >     Compiling targeted test_policy module
> >     Creating targeted test_policy.pp policy package
> >     rm tmp/test_policy.mod.fc
> >     make[2]: Leaving directory '/root/selinux-testsuite/policy/test_pol=
icy'
> >     # General policy load
> >     domain_fd_use --> off
> >     /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.=
cil test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
> >     make[1]: *** [Makefile:174: load] Aborted (core dumped)
> >=20
> > Using "coredumpctl gdb" leads to the following strack trace:
> >=20
> >     (gdb) bt
> >     #0  0x00007f608fe4fa25 in raise () from /lib64/libc.so.6
> >     #1  0x00007f608fe38895 in abort () from /lib64/libc.so.6
> >     #2  0x00007f6090028aca in __addvsi3.cold () from /lib64/libsepol.so=
.1
> >     #3  0x00007f6090096f59 in __avrule_xperm_setrangebits (low=3D30, hi=
gh=3D30, xperms=3D0x8b9eea0)
> >         at ../cil/src/cil_binary.c:1551
> >     #4  0x00007f60900970dd in __cil_permx_bitmap_to_sepol_xperms_list (=
xperms=3D0xb650a30, xperms_list=3D0x7ffce2653b18)
> >         at ../cil/src/cil_binary.c:1596
> >     #5  0x00007f6090097286 in __cil_avrulex_ioctl_to_policydb (k=3D0xb8=
ec200 "@\023\214\022\006", datum=3D0xb650a30,
> >         args=3D0x239a640) at ../cil/src/cil_binary.c:1649
> >     #6  0x00007f609003f1e5 in hashtab_map (h=3D0x41f8710, apply=3D0x7f6=
0900971da <__cil_avrulex_ioctl_to_policydb>,
> >         args=3D0x239a640) at hashtab.c:234
> >     #7  0x00007f609009ea19 in cil_binary_create_allocated_pdb (db=3D0x2=
394f10, policydb=3D0x239a640)
> >         at ../cil/src/cil_binary.c:4969
> >     #8  0x00007f609009d19d in cil_binary_create (db=3D0x2394f10, policy=
db=3D0x7ffce2653d30) at ../cil/src/cil_binary.c:4329
> >     #9  0x00007f609008ec23 in cil_build_policydb_create_pdb (db=3D0x239=
4f10, sepol_db=3D0x7ffce2653d30)
> >         at ../cil/src/cil.c:631
> >     #10 0x00007f608fff4bf3 in semanage_direct_commit () from /lib64/lib=
semanage.so.1
> >     #11 0x00007f608fff9fae in semanage_commit () from /lib64/libsemanag=
e.so.1
> >     #12 0x0000000000403e2b in main (argc=3D7, argv=3D0x7ffce2655058) at=
 semodule.c:753
> >=20
> >     (gdb) f 3
> >     #3  0x00007f6090096f59 in __avrule_xperm_setrangebits (low=3D30, hi=
gh=3D30, xperms=3D0x8b9eea0)
> >         at ../cil/src/cil_binary.c:1551
> >     1551     xperms->perms[i] |=3D XPERM_SETBITS(h) - XPERM_SETBITS(low=
);
> >=20
> > A signed integer overflow therefore occurs in XPERM_SETBITS(h):
> >=20
> >     #define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
> >=20
> > This macro is expanded with h=3D31, so "(1 << 31) - 1" is computed:
> >=20
> > * (1 << 31) =3D -0x80000000 is the lowest signed 32-bit integer value
> > * (1 << 31) - 1 overflows the capacity of a signed 32-bit integer and
> >   results in 0x7fffffff (which is unsigned)
> >=20
> > Using unsigned integers (with "1U") fixes the crash, as
> > (1U << 31) =3D 0x80000000U has no overflowing issues.
> >=20
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged, thanks!

> > ---
> >  checkpolicy/policy_define.c   | 2 +-
> >  libsepol/cil/src/cil_binary.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 395f62284e3c..bf6c3e68bef3 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -2147,7 +2147,7 @@ out:
> >  /* index of the u32 containing the permission */
> >  #define XPERM_IDX(x) (x >> 5)
> >  /* set bits 0 through x-1 within the u32 */
> > -#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
> > +#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
> >  /* low value for this u32 */
> >  #define XPERM_LOW(x) (x << 5)
> >  /* high value for this u32 */
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 36720eda4549..e417c5c28b8b 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -1526,7 +1526,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const=
 struct cil_db *db, struct cil_
> >  /* index of the u32 containing the permission */
> >  #define XPERM_IDX(x) (x >> 5)
> >  /* set bits 0 through x-1 within the u32 */
> > -#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
> > +#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
> >  /* low value for this u32 */
> >  #define XPERM_LOW(x) (x << 5)
> >  /* high value for this u32 */
> > --=20
> > 2.28.0
> >=20
>=20

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+IhmYACgkQviIJHj72
InXHvA/+MjMcbUzAn86zAdfphWVCW3ec3vyFdRw4wf9FGgqovXu+xiaSgLzP2RjW
GLHcHEpdkg3tIuU2U5HKdYwzNvoZfT8McLteQNAt8Thn30AAu1FQop/zZBoB2ZHN
rAD0xQ45m1D76Y4oYIRy7XrYiDHLWTLuXVaNPKpAPWGKqyIo7e54/lDoMmXhAiP1
8Dj2Xt/fCAzdK5zRQdfqNlhE6fpbNP0wFYcurbmqoV6owYxmWpU0NOaettm8Bgxa
Vb+10oD2VC9BdBF5Ju4RP6kXBsqs7Uu3//6d2tBL/t8NgHX1lFgajh5y+1sOkCSl
luOwIgHFwp/p6qAawfNtYvN5jjTB6576Z0VeDyTO2XI+ddwRUYCreLCgdQoMTCwA
pkrkF+6W1Xi4VnIJV14b4SvcTvzxvyD1qN/eMyxVyPFpkfEeMTdTSGixPUNhonvW
NibcNIziJB2bKDJ70TsuKJUMQ8bE+aAhLNm864DkVrs/JmgmTYV6PgfZREHWZS7h
o2sCZ2newWI5d4ZmN7WMegI5vPbItyAnNnUimzLXd7uNmbt/PSqZinZJg1lgzIca
0XIPEGUwI98CGmfCxhhukFay8bQGHmXHU70RVT1jHEia/HUXVpiVOmt0TWvqdwcN
8VDmyOHnSCH7PcIabSP5abm0TcoYf0KRk/QKNFSyDkk8bxKT0vM=
=4/Ev
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

