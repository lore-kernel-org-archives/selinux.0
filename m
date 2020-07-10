Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4339C433E2
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762472063A
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImsutWfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGJNmb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:42:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726921AbgGJNma (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jul 2020 09:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594388549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72qSHHqVXv4YEqEZ27Hu77WRaqAOWc5Ial+j0HWez7Y=;
        b=ImsutWfDi9+4satSKJi4Hyflqo+tKIueyQVMm9Cjwai6mPkgop/T7xHNAKwxUmuwFqol5Q
        s76D0a0z8J5ZLfRMMDV5bvEd3H+WGj6Eg9WEBhIIL0jS0QNbGL+677izsooKrJLMqcXYwG
        KiXQFWkTSKXPqmMMST00OFq6mrS1xfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-2eCAnburNlWoKsuBMU989Q-1; Fri, 10 Jul 2020 09:42:27 -0400
X-MC-Unique: 2eCAnburNlWoKsuBMU989Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9DD100CCE0;
        Fri, 10 Jul 2020 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.251])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA9A60E1C;
        Fri, 10 Jul 2020 13:42:23 +0000 (UTC)
Date:   Fri, 10 Jul 2020 15:42:20 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2] policycoreutils: setfiles: do not restrict checks
 against a binary policy
Message-ID: <20200710134220.GA1768200@localhost.localdomain>
References: <20200707143501.670785-1-antoine.tenart@bootlin.com>
 <CAEjxPJ6_447nPv__1cfcDzj9ybqbaPzTn1Pn3e-JKT0op5578w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6_447nPv__1cfcDzj9ybqbaPzTn1Pn3e-JKT0op5578w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2020 at 11:43:24AM -0400, Stephen Smalley wrote:
> On Tue, Jul 7, 2020 at 10:35 AM Antoine Tenart
> <antoine.tenart@bootlin.com> wrote:
> >
> > The -c option allows to check the validity of contexts against a
> > specified binary policy. Its use is restricted: no pathname can be used
> > when a binary policy is given to setfiles. It's not clear if this is
> > intentional as the built-in help and the man page are not stating the
> > same thing about this (the man page document -c as a normal option,
> > while the built-in help shows it is restricted).
> >
> > When generating full system images later used with SELinux in enforcing
> > mode, the extended attributed of files have to be set by the build
> > machine. The issue is setfiles always checks the contexts against a
> > policy (ctx_validate =3D 1) and using an external binary policy is not
> > currently possible when using a pathname. This ends up in setfiles
> > failing early as the contexts of the target image are not always
> > compatible with the ones of the build machine.
> >
> > This patch reworks a check on optind only made when -c is used, that
> > enforced the use of a single argument to allow 1+ arguments, allowing t=
o
> > use setfiles with an external binary policy and pathnames. The followin=
g
> > command is then allowed, as already documented in the man page:
> >
> >   $ setfiles -m -r target/ -c policy.32 file_contexts target/
> >
> > Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>=20

Applied. Thanks!
--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl8IcDUACgkQviIJHj72
InWolBAAsBJe+FUOsI4Vr/vqp1tjAgCS+/E+EGHxmQy1qxvYo8tqwQpSEpQ1ZUWI
IcKGlNee+v7y8Rl11bvalVDD5VLumJIbJbNSfKUOVBc5U2tV1dqqgvCJal2lIU5c
TbOS1ZkfZIaBUHVQbdU+pE3yfbQO7S4WmSoRHikzSGSPJGX0RNOYAgR+FI22z5Oz
lWQTP1vs2J87cyHQMcQ2J88xPDe7R4vo5SwCf7ot5DjstoyG70TbVwAvEHD7/Rmg
UZntlqEWZXgSN6K25PSkx4c1LZaJujXVeZ8XEuDDEvf4A+BA+WEBsQ4163oUhnbW
u+brtU2PqsmcWnvRQ7/jgSuhtTUrrfEqKa68a9S81VBRqTkXbRE0G5yajHfdevJv
S0J1XjF7qvbxpK3y1H/C3D1vYrdYL2g8tpn5wi8ItFrWI2Jf463m6EC3a+mlrSDi
IO6jMTCJcVQlTBuGzBmde9KvYZyLsB8mJRnAK56pPVj/rSk3cCjzGy2tKIceLoRO
VMIrj0kMHbToNXYMNSi4PC32XdCVsx76vYuKD+I8vAiM4Ch32XV3Bu93Ax+rO31u
VZIW03S1Bn8ZJq0y9lDCycXUJdjnBNVEEYfmCKm0xBHlL2FxUIzQP1pdVb6/xPqV
1wGQLyv8XCgi8pzRsB2pE5qN+1KD/yxcetPp19aYJSczmGO8oxk=
=IRhM
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

