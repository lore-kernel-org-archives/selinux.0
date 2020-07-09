Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40151C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1778720767
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuN9Pfsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgGIQJh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:09:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27969 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726357AbgGIQJh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 12:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594310975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YGJrpPaNq9t/q8fmy5y8yMpfmDhY37xkwfBMvNZMT4s=;
        b=YuN9PfsmSZoNMYjfYCiqNOEIHQlEtBN7qv7N5S5ipBfh6/xFuvYZ3vJlFzWXk2vE3DWKDk
        /2TDKwxiW7mzpY1TgxoGpF7O2Y/Dexc+Vb9ni0HN+17PLtSvOVOyP18LZl4DwLTtjvkQet
        Lrq1HG89lbSFy6QdYcFVbK3dFL+R1QY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-1XitDtUmMjihhkHQ_u639g-1; Thu, 09 Jul 2020 12:09:19 -0400
X-MC-Unique: 1XitDtUmMjihhkHQ_u639g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5749A1088;
        Thu,  9 Jul 2020 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE7D87F8BE;
        Thu,  9 Jul 2020 16:09:16 +0000 (UTC)
Date:   Thu, 9 Jul 2020 18:09:13 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: 3.1 release notes draft
Message-ID: <20200709160913.GB1641304@localhost.localdomain>
References: <20200709094509.1620563-1-plautrba@redhat.com>
 <CAFqZXNs4UD-wb7fM3Vmh9DEhjQHhZnL+JGBomswuwyZQT=f-ug@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFqZXNs4UD-wb7fM3Vmh9DEhjQHhZnL+JGBomswuwyZQT=f-ug@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 09:32:37AM -0400, Stephen Smalley wrote:
> On Thu, Jul 9, 2020 at 5:46 AM Petr Lautrbach <plautrba@redhat.com> wrote=
:
> >
> >
> > I'd like to release 3.1 today/tommorow to open the development of other
> > performance related improvemenets which which postponed. This is releas=
e notes
> > draft which is based on RELEASE-20200518.txt and RELEASE-20200619.txt:
> >
> > RELEASE 202007XX (3.1)
> >
> > User-visible changes:
> >
> > * selinux/flask.h and selinux/av_permissions.h were removed
>=20
> Also sepol/policydb/flask.h although hopefully there were no external
> users of it.

Added

> > * `security_compute_user()` was deprecated - usage of /sys/fs/selinux/u=
ser { security:compute_user } might be revisited
>=20
> Not sure what the last part "might be revisited" means; we have
> removed all uses of it internal to libselinux and deprecated the
> interface, with the intent of someday dropping it altogether and
> removing the kernel interface.

I've dropped " - usage of ... " part completely to make it simple


> One other user-visible change is commit
> 8677ce5e8f592950ae6f14cea1b68a20ddc1ac25 ("libsepol,checkpolicy:
> support omitting unused initial sid contexts") which allows policies
> to start omitting unused initial SID contexts going forward, as per
> its description and
> https://github.com/SELinuxProject/selinux-kernel/issues/12.
>=20

Added

On Thu, Jul 09, 2020 at 05:23:13PM +0200, Ondrej Mosnacek wrote:
> Hi,
>=20
> a couple nits below...
>=20
> On Thu, Jul 9, 2020 at 11:45 AM Petr Lautrbach <plautrba@redhat.com> wrot=
e:
> [...]
> >
> > * Support for new polcap genfs_seclabel_symlinks
>=20
> s/polcap/policy capability/ ?

Changed

> >
> > * New `setfiles -E` option - treat conflicting specifications as errors=
, such
> > as where two hardlinks for the same inode have different contexts.
> >
> > * `restorecond_user.service` - new systemd user service which runs `res=
torecond -u`
> >
> > * `setsebool -V` reports errors from commit phase
> >
> > * Improved man pages
> >
> > * `semanage` uses ipaddress Python module instead of IPy
> >
> > * matchpathcon related interfaces are deprecated
> >
> > * selinuxfs is mounted with noexec and nosuid
> >
> > * Improved README which was renamed to README.md and converted to markd=
own.
>=20
> This is more of a developer/packager/builder visible change rather
> than user visible IMHO. Maybe move it to a "Development-related
> changes" section?
>=20
> >
> > * `setup.py` builds can be customized using PYTHON_SETUP_ARGS, e.g. to =
for
> >   Debian Python layout use: `make PYTHON_SETUP_ARGS=3D--install-layout=
=3Ddeb ...`
>=20
> Ditto. Maybe the "Packaging-relevant changes" would fit better for this o=
ne?
>=20
> >
> > * the dso wrappers for internal calls were removed and it is now strong=
ly recommended to CFLAGS with
> >   `-fno-semantic-interposition`
> >
> > * `security_compute_user()` was deprecated - usage of /sys/fs/selinux/u=
ser { security:compute_user } might be revisited
> >
> > * checkpolicy treats invalid characters as an error - it might break (b=
ut intentional) rare use cases
>=20
> I'd reword this to "might break rare use cases (intentionally)".
>=20
> >
> > * New `restorecon -x` option - prevent `restorecon` from crossing file =
system
> >   boundaries.
>=20
> "New `restorecon -x` option, which prevents it from crossing file
> system boundaries"?
>=20
> >
> > * Handle `semanage module` in semanage bash completion
> >
> > * Added section about CFLAGS to README.md, see Packaging-relevant chang=
es
>=20
> Also mainly devel/packager-related.
>=20
> >
> > * Improved man pages
>=20
> This one is already listed further above .
>=20
> >
> > * Add Travis CI job to run SELinux kernel testsuite on latest Fedora cl=
oud image
>=20
> Another purely development-related change.
>=20
> >
> > * `sepolgen-ifgen` parses a gen_tunable statement as bool
> >
> > * `semanage` handles getprotobyname() failure case on Debian where /etc=
/protocols does not contain an entry for "ipv4"
> >
> > Packaging-relevant changes:
> [...]
>=20

I've applied all your suggestions. The updated version is bellow.

Thanks for the feedback!


RELEASE 202007XX (3.1)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

User-visible changes
--------------------

* selinux/flask.h, selinux/av_permissions.h and sepol/policydb/flask.h were=
 removed

  The flask.h and av_permissions.h header files were deprecated and
  all selinux userspace references to them were removed in
  commit 76913d8adb61b5 ("Deprecate use of flask.h and av_permissions.h.")
  back in 2014 and included in the 20150202 / 2.4 release.
  All userspace object managers should have been updated
  to use the dynamic class/perm mapping support since that time.
  Remove these headers finally to ensure that no users remain and
  that no future uses are ever introduced.

  Use string_to_security_class(3) and string_to_av_perm(3) to map the class=
 and
  permission names to their policy values, or selinux_set_mapping(3) to cre=
ate a
  mapping from class and permission index values used by the application to=
 the
  policy values.

* Removed restrictions in libsepol and checkpolicy that required all declar=
ed
  initial SIDs to be assigned a context.

* Support for new policy capability genfs_seclabel_symlinks

* New `setfiles -E` option - treat conflicting specifications as errors, su=
ch
as where two hardlinks for the same inode have different contexts.

* `restorecond_user.service` - new systemd user service which runs `restore=
cond -u`

* `setsebool -V` reports errors from commit phase

* Improved man pages

* `semanage` uses ipaddress Python module instead of IPy

* matchpathcon related interfaces are deprecated

* selinuxfs is mounted with noexec and nosuid

* the dso wrappers for internal calls were removed and it is now strongly r=
ecommended to CFLAGS with
  `-fno-semantic-interposition`

* `security_compute_user()` was deprecated

* checkpolicy treats invalid characters as an error - might break rare use =
cases (intentionally)

* New `restorecon -x` option which prevents it from crossing file system bo=
undaries.

* Handle `semanage module` in semanage bash completion

* `sepolgen-ifgen` parses a gen_tunable statement as bool

* `semanage` handles getprotobyname() failure case on Debian where /etc/pro=
tocols does not contain an entry for "ipv4"


Packaging-relevant changes
--------------------------

* Setting CFLAGS during the make process will cause the omission of many de=
faults. While the project strives
  to provide a reasonable set of default flags, custom CFLAGS could break t=
he build, or have other undesired
  changes on the build output. Thus, be very careful when setting CFLAGS. C=
FLAGS that are encouraged to be
  set when overriding are:

  - -fno-semantic-interposition for gcc or compilers that do not do this. c=
lang does this by default. clang-10 and up
    will support passing this flag, but ignore it. Previous clang versions =
fail.

* `setup.py` builds can be customized using PYTHON_SETUP_ARGS, e.g. to for
  Debian Python layout use: `make PYTHON_SETUP_ARGS=3D--install-layout=3Dde=
b ...`


Development-relevant changes
----------------------------

* Improved README which was renamed to README.md and converted to markdown.

* Added Travis CI job to run SELinux kernel testsuite on latest Fedora clou=
d image


Issues fixed
------------

* https://github.com/SELinuxProject/selinux/issues/248
* https://github.com/SELinuxProject/selinux/issues/239
* https://github.com/SELinuxProject/selinux/issues/237
* https://github.com/SELinuxProject/selinux/issues/225
* https://github.com/SELinuxProject/selinux/issues/217
* https://github.com/SELinuxProject/selinux/issues/208
* https://github.com/SELinuxProject/selinux/issues/204
* https://github.com/SELinuxProject/selinux/issues/187
* https://github.com/SELinuxProject/selinux/issues/179
* https://github.com/SELinuxProject/selinux/issues/164
* https://github.com/SELinuxProject/selinux/issues/70
* https://github.com/SELinuxProject/selinux/issues/28



--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl8HQSMACgkQviIJHj72
InV8QBAAhh2ah7T0EFpkodfHuPQYa8RUWpvE/SC6S6P4Y+086ZlsAGiPnwFAFCIM
C0ce/pfE5TFyzGpd7XXAkyPdksajqTZLpBgQsvKkNpfXzVANLVTg8y+SxBnxAS6N
yIA7r6TpgphBEP6jw8ugLNqCaWSEZAGp4e82QklQjVeLG3/N0RsJ/WKj8OnRH/rS
Iz/PFbsRPQRRmx+nOZ7arcBNS6GrklDLvP8v2ZSYBe7Wa0444yuiBgwoSUTFocR2
tV8c1LYaiDrHgbc2PpLvjUMbsq3GBX76IjRSPN3viDXlcVjQzG4guqIWA5NoVNKi
hBSWefLY/2AU3V+Li/KJ32wF4nyMOXdRqDh62oGGSIWIH98Cw0uJnl4IsXKR/r6e
iacQTe7obiSto8NrESi+6hG0rE877vmAyZGA3VzNFvuYEyK1fWyIhkRmpGF6PWyN
uSqaZLMMXkfUXTQ9Rgw0M+1qWuMZAUAFJ3l+y6X1qzdhR4rcAr/zyqtthI16vNLv
oow0ND+eX+4w4cWf/o08zwQqBCGFmmrsz/buGBnUNjOXmnRksi1ozn9ma04YoZ+H
ifMRTWzHuOaWwuVYoxtehLrjr0+kPrhGcgXigrJX5f/W1I5ipyhfxcVaruoHI7R4
Zr1iQo/nCDU01rf7kPB5uNWukMIZ0P6e7/t/Ev3MCZu4LNU6O0E=
=dnV8
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--

