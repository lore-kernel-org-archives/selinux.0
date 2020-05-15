Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315AEC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CCC20657
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/UA5IcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgEONm2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 09:42:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgEONm2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 09:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589550146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOrHTGgvbvcB2hm+32jEDTYC5AzgDZwB+bxJTKUiMvs=;
        b=C/UA5IcBCZ3zLlbIk1UMP6iXLAynFEBRC8f9rW0836x82GdFY7pL//BQSv5vrK/Ec4PqBL
        /Kwx92SBRzAjGY88MWKxoNNyuIjITHYHyQKJf3uZ6L80gK+D0wV/EjM+UUw5p9ubxhYQxQ
        cT+oLG0I0Ipac1PWcyg7tcLO//PdwcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-GSZGCsy9PEu__J-8djuTHw-1; Fri, 15 May 2020 09:42:22 -0400
X-MC-Unique: GSZGCsy9PEu__J-8djuTHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B3A58014D7;
        Fri, 15 May 2020 13:42:21 +0000 (UTC)
Received: from workstation (unknown [10.40.194.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BECE25C1D6;
        Fri, 15 May 2020 13:42:19 +0000 (UTC)
Date:   Fri, 15 May 2020 15:42:17 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Smalley <stephen.smalley.work@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH v2] libsemanage: fsync final files before rename
Message-ID: <20200515134217.GF255621@workstation>
References: <5ebc4bc6.1c69fb81.a8850.464e@mx.google.com>
 <CAJfZ7==4oSmvECxX-Roarvc5w=EsAtF=M-yjGv2bQD9rN7GUeg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==4oSmvECxX-Roarvc5w=EsAtF=M-yjGv2bQD9rN7GUeg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 08:44:42PM +0200, Nicolas Iooss wrote:
> On Wed, May 13, 2020 at 9:34 PM Smalley <stephen.smalley.work@gmail.com> =
wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Prior to rename(2)'ing the final selinux policy files into place,
> > fsync(2) them to ensure the contents will be fully written prior to
> > rename.  While we are here, also fix checking of write(2) to detect
> > short writes and treat them as an error.  This code could be more
> > generally improved but keeping to the minimal changes required to fix
> > this bug.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/237
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v2 falls back to EIO if errno is not set by a short write, and
> > only fsync's the final selinux policy files being created in
> > /etc/selinux, avoiding the overhead of fsync on every file copied
> > under /var/lib/selinux.
> >
> >  libsemanage/src/direct_api.c     | 10 +++++-----
> >  libsemanage/src/semanage_store.c | 20 +++++++++++++++-----
> >  libsemanage/src/semanage_store.h |  4 +++-
> >  3 files changed, 23 insertions(+), 11 deletions(-)
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 1088a0ac..d2b91fb2 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -1188,7 +1188,7 @@ cleanup:
> >   * overwrite it. If source doesn't exist then return success.
> >   * Returns 0 on success, -1 on error. */
> >  static int copy_file_if_exists(const char *src, const char *dst, mode_=
t mode){
> > -       int rc =3D semanage_copy_file(src, dst, mode);
> > +       int rc =3D semanage_copy_file(src, dst, mode, false);
> >         return (rc < 0 && errno !=3D ENOENT) ? rc : 0;
> >  }
> >
> > @@ -1488,7 +1488,7 @@ rebuild:
> >                         retval =3D semanage_copy_file(path,
> >                                                     semanage_path(SEMAN=
AGE_TMP,
> >                                                                   SEMAN=
AGE_STORE_SEUSERS),
> > -                                                   0);
> > +                                                   0, false);
> >                         if (retval < 0)
> >                                 goto cleanup;
> >                         pseusers->dtable->drop_cache(pseusers->dbase);
> > @@ -1506,7 +1506,7 @@ rebuild:
> >                         retval =3D semanage_copy_file(path,
> >                                                     semanage_path(SEMAN=
AGE_TMP,
> >                                                                   SEMAN=
AGE_USERS_EXTRA),
> > -                                                   0);
> > +                                                   0, false);
> >                         if (retval < 0)
> >                                 goto cleanup;
> >                         pusers_extra->dtable->drop_cache(pusers_extra->=
dbase);
> > @@ -1595,7 +1595,7 @@ rebuild:
> >
> >         retval =3D semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMAN=
AGE_STORE_KERNEL),
> >                         semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAG=
E_KERNEL),
> > -                       sh->conf->file_mode);
> > +                       sh->conf->file_mode, false);
> >         if (retval < 0) {
> >                 goto cleanup;
> >         }
> > @@ -1634,7 +1634,7 @@ rebuild:
> >                         retval =3D semanage_copy_file(
> >                                                 semanage_path(SEMANAGE_=
TMP, SEMANAGE_STORE_FC_HOMEDIRS),
> >                                                 semanage_final_path(SEM=
ANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS),
> > -                                               sh->conf->file_mode);
> > +                                               sh->conf->file_mode, fa=
lse);
> >                         if (retval < 0) {
> >                                 goto cleanup;
> >                         }
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 859c0a22..cd5e46bb 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -707,7 +707,8 @@ static int semanage_filename_select(const struct di=
rent *d)
> >
> >  /* Copies a file from src to dst.  If dst already exists then
> >   * overwrite it.  Returns 0 on success, -1 on error. */
> > -int semanage_copy_file(const char *src, const char *dst, mode_t mode)
> > +int semanage_copy_file(const char *src, const char *dst, mode_t mode,
> > +               bool syncrequired)
> >  {
> >         int in, out, retval =3D 0, amount_read, n, errsv =3D errno;
> >         char tmp[PATH_MAX];
> > @@ -735,8 +736,11 @@ int semanage_copy_file(const char *src, const char=
 *dst, mode_t mode)
> >         }
> >         umask(mask);
> >         while (retval =3D=3D 0 && (amount_read =3D read(in, buf, sizeof=
(buf))) > 0) {
> > -               if (write(out, buf, amount_read) < 0) {
> > -                       errsv =3D errno;
> > +               if (write(out, buf, amount_read) !=3D amount_read) {
> > +                       if (errno)
> > +                               errsv =3D errno;
> > +                       else
> > +                               errsv =3D EIO;
> >                         retval =3D -1;
> >                 }
> >         }
> > @@ -745,6 +749,10 @@ int semanage_copy_file(const char *src, const char=
 *dst, mode_t mode)
> >                 retval =3D -1;
> >         }
> >         close(in);
> > +       if (syncrequired && fsync(out) < 0) {
> > +               errsv =3D errno;
> > +               retval =3D -1;
> > +       }
>=20
> The patch looks good to me, even though I am wondering whether it
> makes sense to call fsync() if an error happens (by changing the
> condition to "if (!retval && syncrequired && fsync(out) < 0)").
> Anyway, this is a minor comment and I am fine with the other changes.
>=20
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20

Applied.


> >         if (close(out) < 0) {
> >                 errsv =3D errno;
> >                 retval =3D -1;
> > @@ -811,7 +819,8 @@ static int semanage_copy_dir_flags(const char *src,=
 const char *dst, int flag)
> >                         umask(mask);
> >                 } else if (S_ISREG(sb.st_mode) && flag =3D=3D 1) {
> >                         mask =3D umask(0077);
> > -                       if (semanage_copy_file(path, path2, sb.st_mode)=
 < 0) {
> > +                       if (semanage_copy_file(path, path2, sb.st_mode,
> > +                                               false) < 0) {
> >                                 umask(mask);
> >                                 goto cleanup;
> >                         }
> > @@ -1639,7 +1648,8 @@ static int semanage_install_final_tmp(semanage_ha=
ndle_t * sh)
> >                         goto cleanup;
> >                 }
> >
> > -               ret =3D semanage_copy_file(src, dst, sh->conf->file_mod=
e);
> > +               ret =3D semanage_copy_file(src, dst, sh->conf->file_mod=
e,
> > +                                       true);
> >                 if (ret < 0) {
> >                         ERR(sh, "Could not copy %s to %s.", src, dst);
> >                         goto cleanup;
> > diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanag=
e_store.h
> > index 34bf8523..b9ec5664 100644
> > --- a/libsemanage/src/semanage_store.h
> > +++ b/libsemanage/src/semanage_store.h
> > @@ -24,6 +24,7 @@
> >  #ifndef SEMANAGE_MODULE_STORE_H
> >  #define SEMANAGE_MODULE_STORE_H
> >
> > +#include <stdbool.h>
> >  #include <sys/time.h>
> >  #include <sepol/module.h>
> >  #include <sepol/cil/cil.h>
> > @@ -162,6 +163,7 @@ int semanage_nc_sort(semanage_handle_t * sh,
> >                      size_t buf_len,
> >                      char **sorted_buf, size_t * sorted_buf_len);
> >
> > -int semanage_copy_file(const char *src, const char *dst, mode_t mode);
> > +int semanage_copy_file(const char *src, const char *dst, mode_t mode,
> > +               bool syncrequired);
> >
> >  #endif
> > --
> > 2.23.3
> >
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6+nDIACgkQviIJHj72
InUEAxAAqehI9VaLpftpFdtBCx7vj4m7UngoKrsbeQDmbgJeyGblgixt//uUgVEq
F43wLMj/4J7o+Lk76RHzKu5er3ICRAsZxXe19awGUbbQRZ98+jmE9jdj2C1Cyx6s
NgG6GlcpxNm6vK3POKjJ32pjSm/koKKqoT2ekXNIohwS1gzke+cycNhMW83xHMzl
KB0ThHWmV5EqMsAKmqGOErBEjgde3k9aIhks0dt1mTVP/CEapifjSPWZRkN2G46k
t1b0kAhhQBsSA0YfxOt2ZsZHeJwD/UnmAPln+czAxW/jcxU1neIVIrk5KpiMO7Jc
Srai9epZL3WzpOBI+ynKH+pYJDt8NI9JF9zGhayA56Zrqe5UJofYYdosstXHd0ET
um+f+n3lzpsdGE45pbOcgmdshL5LdUMlbvKmdHJzfatkQcR8K/19/nyhmLO3c7X3
TDnKnVfuh1w8kRt4jvK9XzQrTnfurLhnxnj9tJKB+Zhb/KudLO9WNQFRjrQE4JJ5
73n0VXXyifPP5VyIlDP95vmbcebUNHKL8J9MuJx576LgsUTY4SUc4fuS+913011x
UOniT6EbzkwGxlsU8IdY7pe8x8y28Y+keYHDkNJNZ5j8WDuUafz/u08BBgLI9dGH
qpqK58BlR9xgh5Hxp6dH2QvFLg1THfBULIedTfFQJPvB2AwR+/A=
=pstG
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--

