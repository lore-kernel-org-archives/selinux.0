Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5FEC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE0C20657
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGyjh06x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgEONiJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 09:38:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20012 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgEONiJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 09:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589549887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5SiKn4ZlKsyAK+LZLN2rX2WHsisiuZg4YmKGJOeaLvE=;
        b=RGyjh06xlFUJ1jMvTosamdomi/sLE1jU0CbYJPXD+iBVT1lGTJtXxz51Ipp4ElH4IpjlkX
        irtNURT34qqzp12IfCACpp527PF3gsateOQNpPRQsAekwThxM5zYRG56eESSoCiHEKOEi4
        gIl/3PnLH2z0kE74Jxfzv0Pvbihif2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Ye_Yj9RpNJKn33F3lsSyJA-1; Fri, 15 May 2020 09:38:04 -0400
X-MC-Unique: Ye_Yj9RpNJKn33F3lsSyJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA21107ACCA;
        Fri, 15 May 2020 13:38:03 +0000 (UTC)
Received: from workstation (unknown [10.40.194.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00351614E7;
        Fri, 15 May 2020 13:38:01 +0000 (UTC)
Date:   Fri, 15 May 2020 15:37:59 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH] libsepol: drop broken warning on duplicate filename
 transitions
Message-ID: <20200515133759.GE255621@workstation>
References: <20200513211508.4477-1-stephen.smalley.work@gmail.com>
 <CAFqZXNtNSH8_8ow-ZkAMK=UXvs_rCieUr3xgn6pqrpb-Xvnbtw@mail.gmail.com>
 <CAEjxPJ4g5+erpnA-ikj6RjZ0KL2v5jd6mENcX1Ahtk2-7=s0bw@mail.gmail.com>
 <CAFqZXNuj__kQrnUBDgtjv=z2Bu-+WpuQPKkhnHi6zKYK-vFmXA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFqZXNuj__kQrnUBDgtjv=z2Bu-+WpuQPKkhnHi6zKYK-vFmXA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 02:19:05PM +0200, Ondrej Mosnacek wrote:
> On Thu, May 14, 2020 at 2:03 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, May 14, 2020 at 4:19 AM Ondrej Mosnacek <omosnace@redhat.com> w=
rote:
> > >
> > > On Wed, May 13, 2020 at 11:16 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > As per the issue below, libsepol segfaults on loading old kernel po=
licies
> > > > that contain duplicate filename transition rules.  The segfault is =
due to
> > > > the fact that the val_to_name arrays have not yet been populated at=
 this
> > > > point in the policydb_read() processing.  Since this warning appare=
ntly
> > > > never worked since it was first introduced, drop it and just silent=
ly
> > > > discard the duplicate like the kernel does.  I was not able to prod=
uce a
> > > > policy with such duplicates using the current policy toolchain, eit=
her
> > > > via CIL or via binary modules with manual semodule_link/expand.
> > > >
> > > > Fixes: https://github.com/SELinuxProject/selinux/issues/239
> > > > Fixes: 8fdb2255215a1f14 ("libsepol,checkpolicy: convert rangetrans =
and filenametrans to hashtabs")
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > >  libsepol/src/policydb.c | 9 +--------
> > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > >
> > > > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > > > index 5b289a52..3992ea56 100644
> > > > --- a/libsepol/src/policydb.c
> > > > +++ b/libsepol/src/policydb.c
> > > > @@ -2655,15 +2655,8 @@ int filename_trans_read(policydb_t *p, struc=
t policy_file *fp)
> > > >                          * Some old policies were wrongly generated=
 with
> > > >                          * duplicate filename transition rules.  Fo=
r backward
> > > >                          * compatibility, do not reject such polici=
es, just
> > > > -                        * issue a warning and ignore the duplicate=
.
> > > > +                        * ignore the duplicate.
> > > >                          */
> > > > -                       WARN(fp->handle,
> > > > -                            "Duplicate name-based type_transition =
%s %s:%s \"%s\":  %s, ignoring",
> > > > -                            p->p_type_val_to_name[ft->stype - 1],
> > > > -                            p->p_type_val_to_name[ft->ttype - 1],
> > > > -                            p->p_class_val_to_name[ft->tclass - 1]=
,
> > > > -                            ft->name,
> > > > -                            p->p_type_val_to_name[otype->otype - 1=
]);
> > >
> > > Not sure if it's the same situation, but should we also do something
> > > about a similar pattern in checkpolicy/policy_define.c?
> > >
> > > https://github.com/SELinuxProject/selinux/blob/63bf6afe5ed20e1d62f966=
de65882dc327fb2915/checkpolicy/policy_define.c#L3408
> >
> > No, in that case we are compiling source policy and we want to warn on
> > it to encourage removal of duplicates (and we have populated the
> > val_to_name arrays there so the warning works).
>=20
> Ok, makes sense. In that case:
>=20
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>=20

Applied.


--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6+mzAACgkQviIJHj72
InXFcRAAm1Tjyazs97WeCl8hsVzTKPgpuWWfUO4XkxqzJWrlNLfDAkYg7PvNp4J7
D1FG0xKtHTqjSObUoRMmyCoisQmQ+g6asC5vM8X/0ssr5ewn5bw7tx8Ekshb0XW3
4rB4T8pSFydHiYRXq+6yIcEE2haM9Q196bNUo4VHfbNlrkdlslUUu9u5Xdh+QUa+
7APwwkKiVCi18wipXQEFCYY41Iu5Wh5cK5fv8uQpK6Z809LJC+bwXeaqYOidDWfc
EOEMXNKhqDRnbFuK2cdzV6vn5c+pTJMv4Sc5PuTRyxOW5YMpBHfoLuRtWxJ6gfCC
IE8oH+OFCAKg9X6uUwQOfgFAgU/TVrlX+9f/uCPazXX9el9gBIi6hIYMRp2flJXd
qtizxJnzutO3H0JSdWbahvg9hXIJHhFoKAQwwLIgpYbLwc+NNFG1iYRDQa15lcwA
us7NMvG0314ozjcVeh+n/BeFCCbr2Y3T4/AZDY33mEx6VQ2d83+xqobOfDaop+Hu
LJewwHF0TLefRqBgNhPK18yRYN23ghgeJ056hDdgiKvBTf1tZboMfxDYZdhesxA0
U2gwtcag4V+yE7mAqbcYypCIndukfUVW96bBJd4zKQ9YtlhwmXwdZKN+Q3B4/4Qm
bw1Sj9A4zNkSknhBGsRLmgaHie0YnwfvAeyXtY2fzP8CDzw5ODk=
=ixcg
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--

