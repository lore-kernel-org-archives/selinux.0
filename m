Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057AFC433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0B62100A
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeRUgbGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFRTet (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:34:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgFRTet (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 15:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592508887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icZhAa9vNya5P45HZvfp9aHh4sttz5qk2aJWiN/ZntI=;
        b=QeRUgbGDuj/8gDz5y0lHaDJS/8JyjeXeP3dwtgvzNrJP21Gn4Rcaz3LUN1OFsykZE7RNrg
        n6gHQ1NZBeat0JrIJ3LKepf+K9jb3dIBhyq4SPjRg847kir5P4j9yKO1y2jukPkS7oz8M2
        tiFs1cqQIiXAWt2N9spgHQGHc6mPMWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16--H_m8AyKM-6daZycrg7FiA-1; Thu, 18 Jun 2020 15:34:43 -0400
X-MC-Unique: -H_m8AyKM-6daZycrg7FiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 338BDA0BD7;
        Thu, 18 Jun 2020 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A66E5D9E8;
        Thu, 18 Jun 2020 19:34:41 +0000 (UTC)
Date:   Thu, 18 Jun 2020 21:34:38 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: fix selinux_restorecon() statfs bug
Message-ID: <20200618193438.GD689512@localhost.localdomain>
References: <20200604200831.28866-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ503XEoYEKdRpsfrzaf1A8gBfxXj9quG7tP0=2+Ect4zA@mail.gmail.com>
 <20200610161922.GA350952@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200610161922.GA350952@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 06:19:22PM +0200, Petr Lautrbach wrote:
> On Wed, Jun 10, 2020 at 11:56:28AM -0400, Stephen Smalley wrote:
> > On Thu, Jun 4, 2020 at 4:08 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > As reported in https://github.com/SELinuxProject/selinux/issues/248,
> > > setfiles -r (rootpath) fails when the alternate root contains a symli=
nk
> > > that is correct relative to the alternate root but not in the current=
 root.
> > > This is a regression introduced by commit e016502c0a26 ("libselinux: =
Save
> > > digest of all partial matches for directory").  Do not call statfs(2)=
 here
> > > if acting on a symbolic link.  Unfortunately there is no lstatfs() ca=
ll.
> > > Ensure that we initialize the statfs buffer always.  If the supplied
> > > file is a symlink, then we don't need to worry about the later tests =
of
> > > filesystem type because we wouldn't be setting the digest anyway and
> > > we are not performing a full sysfs relabel.  While here, fix the earl=
ier
> > > test for a directory to use the correct test.
> > >
> > > Reproducer:
> > > $ mkdir /root/my-chroot && echo foo > /root/my-chroot/link-target && =
ln -s /link-target /root/my-chroot/symlink
> > > $ echo "/root/my-chroot/symlink" | setfiles -vFi -r /root/my-chroot -=
f - /etc/selinux/targeted/contexts/files/file_contexts
> > >
> > > Before:
> > > setfiles: statfs(/root/my-chroot/symlink) failed: No such file or dir=
ectory
> > >
> > > After:
> > > Relabeled /root/my-chroot/symlink from unconfined_u:object_r:admin_ho=
me_t:s0 to system_u:object_r:default_t:s0
> > >
> > > Fixes: https://github.com/SELinuxProject/selinux/issues/248
> > > Fixes: e016502c0a26 ("libselinux: Save digest of all partial matches =
for directory")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >=20
> > Anyone want to ack or object to this patch?
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

> > > ---
> > >  libselinux/src/selinux_restorecon.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/sel=
inux_restorecon.c
> > > index 91dfeb66..d1ce830c 100644
> > > --- a/libselinux/src/selinux_restorecon.c
> > > +++ b/libselinux/src/selinux_restorecon.c
> > > @@ -938,7 +938,7 @@ int selinux_restorecon(const char *pathname_orig,
> > >         }
> > >
> > >         /* Skip digest if not a directory */
> > > -       if ((sb.st_mode & S_IFDIR) !=3D S_IFDIR)
> > > +       if (!S_ISDIR(sb.st_mode))
> > >                 setrestorecondigest =3D false;
> > >
> > >         if (!flags.recurse) {
> > > @@ -952,7 +952,8 @@ int selinux_restorecon(const char *pathname_orig,
> > >         }
> > >
> > >         /* Obtain fs type */
> > > -       if (statfs(pathname, &sfsb) < 0) {
> > > +       memset(&sfsb, 0, sizeof sfsb);
> > > +       if (!S_ISLNK(sb.st_mode) && statfs(pathname, &sfsb) < 0) {
> > >                 selinux_log(SELINUX_ERROR,
> > >                             "statfs(%s) failed: %s\n",
> > >                             pathname, strerror(errno));
> > > --
> > > 2.23.3
> > >
> >=20



--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7rwccACgkQviIJHj72
InUZzQ/+Nsw557gzOC5rGK2HlB2rrBARnAB6EDVNNs+NRJLYQKaGARB26AUaUmlD
flPShVmEpnowkauj22y+oPoP5jgTiJwjxVI69oZticsmbbVNV6DLB06rNUMzOF+E
09/8OS3wZR3+VZ6sSfDzcI3KTtIiVzkd54AlNPGi5e7tKJe+a0HS6K6+8Vzxnlx6
FdvsMADE2vZXBiY4ctHkeikaKO63pRyZvCiYfledtN6AqRCdIgUzVX2FOFfxBusD
iiwj5jQkcLgKWx8d5F1hnJ+FAmD0Fq2CcH2eEY8X42Hqnnj/ZP7t2P9OJrRAifBC
NRuMGj0Xsvg8l3xhi2Ch3J1KioS7Vpu9IsnID21QOLp9cZN5l/rgzs0Mgw8zGvq3
q2O73XGNWrNz/vLQKClzgXzQ70GP6bDfhru1wdxsBoU63gRrWeXs3AmnmepFlpA3
5PKuDIk1snBjURC6KTutA9JxnyZcxnQloq3+xxz4us8eu+wXbqYKOO08KwL0qSk9
qp48pnEh/xQvU74wcsCFhMCiWeg0pBQxetSGavl0YsCtwHHVhdXsqww0gt3/A0Z8
Nm6vnWAdny881sP4Ax05K0h+6Jfow80f9Gbu14TBDrXZICFIJ+jeBSTy3qJ8j+U5
yCZS3qGkWG/ocX9thly55Hogavji/H8JE0ky+0vrGoBPbcLL0P4=
=JSOF
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--

