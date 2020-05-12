Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48398CA90AF
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F60B205ED
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMHKmxdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgELRQY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 13:16:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726367AbgELRQY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 13:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589303782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cSADa2w13R5CmFMNsUav6sqximx9RZUbjjp/bymOGuQ=;
        b=BMHKmxdo7W0xx1oYngnREdeBFZ9KcMn8gKz7aGYlQ62iqixmf5eiVtrA2wKBSLtubrTSH7
        JSWdRKUkDqw4H4jI3ZSEIpOrHF/FeJValu/NGc3Y/Pz1ZoakaU7ukjb4ujYoU49OWzSXRs
        9B4bJbBrE+/mjMRvLk8/VpQWVjz79Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-PfV57SoIMkyzs8TZoCM38A-1; Tue, 12 May 2020 13:16:10 -0400
X-MC-Unique: PfV57SoIMkyzs8TZoCM38A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E672108BD12;
        Tue, 12 May 2020 17:16:09 +0000 (UTC)
Received: from workstation (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3621000320;
        Tue, 12 May 2020 17:16:07 +0000 (UTC)
Date:   Tue, 12 May 2020 19:16:05 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
Message-ID: <20200512171605.GK108209@workstation>
References: <20200305135337.113248-1-omosnace@redhat.com>
 <20200511122703.GA26404@workstation>
 <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com>
 <CAP+JOzTUiNhyPPVOm-cFqNzPUGmQKmGvR9n_yNbTatQ8tYnJng@mail.gmail.com>
 <CAEjxPJ7Px-LkZPGk_Oe=G6HZP_Yu1a=nWDBPc6i=oNOMf0nG9A@mail.gmail.com>
 <CAP+JOzTX3tFUAeheUUDB4br+nLhqCUP+EPY_XuTugDoqpwNGVg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+JOzTX3tFUAeheUUDB4br+nLhqCUP+EPY_XuTugDoqpwNGVg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDymnuGqqhW10CwH"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 03:01:06PM -0400, James Carter wrote:
> On Mon, May 11, 2020 at 2:09 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, May 11, 2020 at 2:03 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Mon, May 11, 2020 at 9:25 AM James Carter <jwcart2@gmail.com> wrot=
e:
> > > >
> > > > On Mon, May 11, 2020 at 8:27 AM Petr Lautrbach <plautrba@redhat.com=
> wrote:
> > > > >
> > > > > On Thu, Mar 05, 2020 at 02:53:37PM +0100, Ondrej Mosnacek wrote:
> > > > > > The value attrs_expand_size =3D=3D 1 removes all empty attribut=
es, but it
> > > > > > also makes sense to expand all attributes that have only one ty=
pe. This
> > > > > > removes some redundant rules (there is sometimes the same rule =
for the
> > > > > > type and the attribute) and reduces the number of attributes th=
at the
> > > > > > kernel has to go through when looking up rules.
> > > > > >
> > > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > > ---
> > > > > >
> > > > > > v2: fix typos (Tne -> The; cointains -> contains)
> > > > > >
> > > > > >  libsepol/cil/src/cil.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > > > > index d222ad3a..c010ca2a 100644
> > > > > > --- a/libsepol/cil/src/cil.c
> > > > > > +++ b/libsepol/cil/src/cil.c
> > > > > > @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
> > > > > >       (*db)->disable_dontaudit =3D CIL_FALSE;
> > > > > >       (*db)->disable_neverallow =3D CIL_FALSE;
> > > > > >       (*db)->attrs_expand_generated =3D CIL_FALSE;
> > > > > > -     (*db)->attrs_expand_size =3D 1;
> > > > > > +     /* 2 =3D=3D remove attributes that contain none or just 1=
 type */
> > > > > > +     (*db)->attrs_expand_size =3D 2;
> > > > > >       (*db)->preserve_tunables =3D CIL_FALSE;
> > > > > >       (*db)->handle_unknown =3D -1;
> > > > > >       (*db)->mls =3D -1;
> > > > > > --
> > > > > > 2.24.1
> > > > > >
> > > > >
> > > > >
> > > > > This patch broke `semanage node -l` on Fedora [1]
> > > > >
> > > > > :: [ 21:25:25 ] :: [  BEGIN   ] :: Running 'make LIBDIR=3D/usr/li=
b64 SHLIBDIR=3D/lib64 test'
> > > > > ...
> > > > > test_list (__main__.SemanageTests) ... Traceback (most recent cal=
l last):
> > > > >   File "/usr/sbin/semanage", line 967, in <module>
> > > > >     do_parser()
> > > > >   File "/usr/sbin/semanage", line 946, in do_parser
> > > > >     args.func(args)
> > > > >   File "/usr/sbin/semanage", line 649, in handleNode
> > > > >     OBJECT =3D object_dict['node'](args)
> > > > >   File "/usr/lib/python3.8/site-packages/seobject.py", line 1849,=
 in __init__
> > > > >     self.valid_types =3D list(list(sepolicy.info(sepolicy.ATTRIBU=
TE, "node_type"))[0]["types"])
> > > > > IndexError: list index out of range
> > > > >
> > > > > While the `IndexError: list index out of range` error can be simp=
ly fixed, it
> > > > > uncovered the problem that semanage uses attibutes to list certai=
n records -
> > > > > node_type, port_type, file_type, device_node, ... and these attri=
butes can disappear when
> > > > > there's only 1 type assigned.
> > > > >
> > > > > I guess it should be reverted as there's no other way how to find=
 out that a
> > > > > type node_t is node_type.
> > > > >
> > > > > [1] https://jenkins-continuous-infra.apps.ci.centos.org/job/fedor=
a-rawhide-pr-pipeline/3462/artifact/package-tests/logs/FAIL-upstream-err.lo=
g
> > > > >
> > >
> > > I see now.  python/semanage/seobject.py and
> > > python/semanage/semanage-bash-completion.sh both assume that node_typ=
e
> > > is always defined as an attribute in a policy. There seems to be quit=
e
> > > a lot that is assumed about policy in the python directory.
> > >
> > > This is not a bug in CIL or libsepol. Ideally the tests should have
> > > their own policy and the python code should gracefully handle the
> > > situation when its assumptions are wrong. If we need to revert this
> > > patch in the short-term than I am ok with that.
> >
> > We can mark these attributes explicitly in policy to prevent their
> > expansion, right?  So while we cannot make this change right now
> > without breaking compatibility with selinux userspace tools (not just
> > tests), we could start marking these attributes on which the tools
> > depend in policy and then later we can re-apply this?
>=20
> Yes, we can add the rule "expandattribute node_type false;" in policy
> for node_type and any other attributes that are required to exist.
>=20


It doesn't seem to be propagated to cil:

# cat mypolicy.te=20
policy_module(mypolicy,1.0)

type myapp_t;
type myapp_log_t;

attribute myattribute;
expandattribute myattribute false;
typeattribute myapp_t myattribute;

allow myattribute myapp_log_t:file read;

# make -f /usr/share/selinux/devel/Makefile mypolicy.pp
make: 'mypolicy.pp' is up to date.

# /usr/libexec/selinux/hll/pp mypolicy.pp
(type myapp_t)
(roletype object_r myapp_t)
(type myapp_log_t)
(roletype object_r myapp_log_t)
(typeattribute myattribute)
(typeattributeset myattribute (myapp_t ))
(roleattributeset cil_gen_require system_r)
(allow myattribute myapp_log_t (file (read)))


But it works with mypolicy.cil which contains:
(expandtypeattribute myattribute false)


I'm not really experienced in writing policy but I still find the behaviour
confusing.
It's not only about `semanage`, you can hit this using `sesearch` as well, =
e.g.
before policy is rebuilt with new libsepol, `sesearch -A -t node_type` find=
s
about 535 rules with node_type, then you rebuild policy and it's 0. But if
assign node_type to another type, it's again more than 536.

For this particular attribute we can/should use `expandtypeattribute` but s=
hould
be this expression used every time you have an attribute assigned to only 1=
 type?


If it stays as it is, it definitely needs to be part of release notes.


--qDymnuGqqhW10CwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl662c8ACgkQviIJHj72
InV2Cg//Qp/KqyDSc9rCqNAhregSUJT4+mj/QQl8U8RXyheGtMiS1947na5IZstJ
0VK5W20zm8/3XPxzysruyP/PFOS5Od31gSbD7AdmpVVM6wj67H7vh2otDmxFleTl
EKbr6TnYw2p1ClGjgq5l0S0wFZx693hGGT2NDolaFTaWQCxQb1pFrPO/LLpvo0CX
0xPKUY4mIddT+d/TFnfxuvLkHCEVjMbooE2FragIgr6YlONAoXhXjzpenXriYQTm
XqtB1g4iWmLi7m8RJrdQ2EZKLSzBAGLqxYyjsPOxsrdvOi364uiG9T+fav/prD8I
Z3JUhN4phpYcyVmeWdy0MyYTNJqnBSo+6q55F6gnPO1JpC9sH77rF5Ox77+XqR+J
Tw0t06meGk7u9tZypMer9FMMYPjG/O9XV7YLDNopf3kn2tiOTDj38l1YnaV5/kIm
5Trf0xqx+QqKZDwDUUy9HTe4mDdv8IuylPgzSKjqddo/lA1vno4kwJlQIc4k9vqF
VC8G77E5pd0srW8I8HyxvcOF6l63QYpPGfbmKKe9/zrYOZ3U3G7gj49rgvGab42R
Emwl07Nz8JbM7cg4HC6q6+RE1Ry0cvaeDdpxBPM/pX/zB0B8Rwarlkgl/W/aj5qq
cy0Cet6yMtRIjPouuxsBSJeAUzfHzfh0T3h8lsxW5/6jbT72Grc=
=YtVt
-----END PGP SIGNATURE-----

--qDymnuGqqhW10CwH--

