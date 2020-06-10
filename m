Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044AC433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F009B2067B
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 16:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lmej9fHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgFJQTc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:19:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54346 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728077AbgFJQTc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 12:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591805970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sWR/V201NCx7/xsOBNCPrsJ0KN5EY8CQSi3abhvVH4=;
        b=Lmej9fHAr/KbZagc+hUEV37bWGEv3ECr03CVYNNLz12LJEpPvUsIUEhvxNDfEJVxV3R7zL
        4fpskTD0Y5NvXJYrgRr2h98Hl5cibjvdwwOfw7r3H5M1o3hMIVQZWnfKNOdLa/Md2V4UEv
        cXeoXJd11rGm0L/e8Rfp5X6duAf15j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-IWdHwvxLNWaIvaKfX6bXdw-1; Wed, 10 Jun 2020 12:19:26 -0400
X-MC-Unique: IWdHwvxLNWaIvaKfX6bXdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C21F8107ACCA;
        Wed, 10 Jun 2020 16:19:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDFD319C71;
        Wed, 10 Jun 2020 16:19:24 +0000 (UTC)
Date:   Wed, 10 Jun 2020 18:19:22 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: fix selinux_restorecon() statfs bug
Message-ID: <20200610161922.GA350952@localhost.localdomain>
References: <20200604200831.28866-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ503XEoYEKdRpsfrzaf1A8gBfxXj9quG7tP0=2+Ect4zA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ503XEoYEKdRpsfrzaf1A8gBfxXj9quG7tP0=2+Ect4zA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 11:56:28AM -0400, Stephen Smalley wrote:
> On Thu, Jun 4, 2020 at 4:08 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > As reported in https://github.com/SELinuxProject/selinux/issues/248,
> > setfiles -r (rootpath) fails when the alternate root contains a symlink
> > that is correct relative to the alternate root but not in the current r=
oot.
> > This is a regression introduced by commit e016502c0a26 ("libselinux: Sa=
ve
> > digest of all partial matches for directory").  Do not call statfs(2) h=
ere
> > if acting on a symbolic link.  Unfortunately there is no lstatfs() call=
.
> > Ensure that we initialize the statfs buffer always.  If the supplied
> > file is a symlink, then we don't need to worry about the later tests of
> > filesystem type because we wouldn't be setting the digest anyway and
> > we are not performing a full sysfs relabel.  While here, fix the earlie=
r
> > test for a directory to use the correct test.
> >
> > Reproducer:
> > $ mkdir /root/my-chroot && echo foo > /root/my-chroot/link-target && ln=
 -s /link-target /root/my-chroot/symlink
> > $ echo "/root/my-chroot/symlink" | setfiles -vFi -r /root/my-chroot -f =
- /etc/selinux/targeted/contexts/files/file_contexts
> >
> > Before:
> > setfiles: statfs(/root/my-chroot/symlink) failed: No such file or direc=
tory
> >
> > After:
> > Relabeled /root/my-chroot/symlink from unconfined_u:object_r:admin_home=
_t:s0 to system_u:object_r:default_t:s0
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/248
> > Fixes: e016502c0a26 ("libselinux: Save digest of all partial matches fo=
r directory")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>=20
> Anyone want to ack or object to this patch?

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> > ---
> >  libselinux/src/selinux_restorecon.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 91dfeb66..d1ce830c 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -938,7 +938,7 @@ int selinux_restorecon(const char *pathname_orig,
> >         }
> >
> >         /* Skip digest if not a directory */
> > -       if ((sb.st_mode & S_IFDIR) !=3D S_IFDIR)
> > +       if (!S_ISDIR(sb.st_mode))
> >                 setrestorecondigest =3D false;
> >
> >         if (!flags.recurse) {
> > @@ -952,7 +952,8 @@ int selinux_restorecon(const char *pathname_orig,
> >         }
> >
> >         /* Obtain fs type */
> > -       if (statfs(pathname, &sfsb) < 0) {
> > +       memset(&sfsb, 0, sizeof sfsb);
> > +       if (!S_ISLNK(sb.st_mode) && statfs(pathname, &sfsb) < 0) {
> >                 selinux_log(SELINUX_ERROR,
> >                             "statfs(%s) failed: %s\n",
> >                             pathname, strerror(errno));
> > --
> > 2.23.3
> >
>=20

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7hCAMACgkQviIJHj72
InV5qQ/+M/bfY9uD6anpknYQqVcODZA2yFcJXckkSFRChgllAmAEfRwuXuplZFTM
41Z8nJDctY+A8z0TuOxhWiF+y7/ULUNG51o/z2+FBVWPo+r6mN8r36ZSQ+8yKzcL
5k+3nJuXPYaO1PD3GW+QlbBgm+e7RpguqHCVVh5aq2QypyW8fjvh+EzqCUrZ23a9
gDg+eFye2XlietKTnJ0VOP4rcZaH6CiaboAMJUdhgLv/VMW99ijINHjSdgzi7xRC
ZECMqv0JfmOGYFrOwDDg7DGc0iIGgwsy6lyExCvE/wjEyaLdatqB2ItcVvRSQ84n
1O1xOSlPk3aTLr6mZGw1k/06U3tE2C+6qGtTqsjc2wkfjfqcNexsK3IykMnZv/hF
PVb0SWgz/ZmlHYB2HCEn95BpL72cThUxyqZENoKnqe3Ta+QauShAm+vFbcaYeqqv
9atTfAHadzr8/s+yEZImRyUdtWEmLjeBdJbu9o5BASrrF40wEmYJdPPq8vnNzaVv
gvLP+a9i497XjR6kmmj1qGbeToR4tuFjOBPRnaI87jj9uHFxt8HFF8wdkICwGVPv
8gr+NBAIfBG6PkXP9IzDrESCKmn/oSVo2DgPWGF9vfOXkYyBtzjY22rjiJllEGCZ
UY2k4qYrqQoeHdvhKFbhj8+JI+AGD92QR2EgXq3pm7FDcJrb5RQ=
=mYW7
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

