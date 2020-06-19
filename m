Return-Path: <SRS0=1V8V=AA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E3C433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324D320776
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 12:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOMhl/Vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgFSMxp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:53:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgFSMxn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jun 2020 08:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592571221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=YzZy3JbD+P8OFcpi7WUlJm2WDGqMYBSbU1gbu3ATpbI=;
        b=MOMhl/VuAyTuDmNx6ntgecWmJGpqY3Co3JSnVLIo6QCTG9b2vQAQ4HDh2Yb7hXnBiHuxTU
        SzfLon1LujinI544n1vQ10mlESexrxE7fMCr99DIxlBidKrn9IBiQB1IKl5BPyRIlkx+Mo
        pynQJaFREjy0EyqbIdwdtOWqs/PR65k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-CjXpcandMk6FvMFuBifVww-1; Fri, 19 Jun 2020 08:53:32 -0400
X-MC-Unique: CjXpcandMk6FvMFuBifVww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 942A318585A0
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02BB410013C4
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 12:53:30 +0000 (UTC)
Date:   Fri, 19 Jun 2020 14:53:28 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.1-rc2 release candidate
Message-ID: <20200619125328.GE785659@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

A 3.1-rc2 release candidate for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out=20
in release notes for packagers and users in the final release
announcement, let us know.=20

Thanks to all the contributors to this release candidate!

User-visible changes since 20200518 / 3.1-rc1:

* New `restorecon -x` option - prevent `restorecon` from crossing file syst=
em
  boundaries.

* Handle `semanage module` in semanage bash completion

* Added section about CFLAGS to README.md, see Packaging-relevant changes

* Improved man pages

* Add Travis CI job to run SELinux kernel testsuite on latest Fedora cloud =
image

* `sepolgen-ifgen` parses a gen_tunable statement as bool

Packaging-relevant changes:

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

Issues fixed:

* https://github.com/SELinuxProject/selinux/issues/248
* https://github.com/SELinuxProject/selinux/issues/208

A shortlog of changes since the 3.1-rc1 pre-release:

Andrej Shadura (1):
      checkpolicy: Minor tweaks to the names of the contributors to the man=
pages

Christian G=F6ttsche (3):
      sepolgen: parse gen_tunable as bool
      refparser: add missing newline after error message
      sepolgen-ifgen: refactor default policy path retrieval

James Carter (8):
      libsepol/cil: Initialize the multiple_decls field of the cil db
      libsepol/cil: Return error when identifier declared as both type and =
attribute
      libsepol: Fix type alias handling in kernel_to_cil
      libsepol: Fix type alias handling in kernel_to_conf
      libsepol: Write CIL default MLS rules on separate lines
      libsepol: Improve writing CIL sensitivity rules
      libsepol: Improve writing CIL category rules
      libsepol: Sort portcon rules consistently

Ji Qin (1):
      libselinux: Fix NULL pointer use in selinux_restorecon_set_sehandle

Peter Whittaker (1):
      Add restorecon -x option to not cross FS boundaries

Petr Lautrbach (2):
      python/sepolicy: Use xml.etree.ElementTree.Element.iter()
      Update VERSIONs to 3.1-rc2 for release.

Stephen Smalley (1):
      libselinux: fix selinux_restorecon() statfs bug

Topi Miettinen (3):
      secilc/docs: fix use of TMPDIR
      semanage bash completion: handle semanage module
      semanage-node.8: describe netmask

William Roberts (3):
      ci: run SELinux kernel test suite
      ci: dont use hardcoded project name
      README: start a section for documenting CFLAGS

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7stUEACgkQviIJHj72
InUsPA//cF4NYx/zAMtQybGdG2zfSd5qP8dDCWqssgta4yk6hSz6QOb5CCyOcqqc
kZKjMa+d+FNOCjTRzPZeBJZl9bTSfGtgfVFtt6Uwb6NGGXpntjBDWKC+GriXpCTJ
KWmGLaKsM5sO4PzHZH/i5wVFsFkpUbtUcZszRrJdS5R///ExpD2eyBqnuMK0I49S
THHWQ4lw5i2jj9uEWLpyusVX5H4kWozE36SVXEyuHn+JlkY6pZl+fGjHaRMtyCPX
XLmBdM+CtVIMIMyWz3mNVXOgDMm7ZGKib5U1cKqgWWpcJ9m5AABVdBoRyJf/cMQG
caau/1DVZJG+YAXMnCUpA2BbQOGXGe8x5JXxpIAFR2GgSbZr0ZdMQB7Xyv9gztEm
Ra6lRQJaol747YImkZMgE6aTzo1ZGueajSQrrBtkVJrqggG02mKXv13mxHYUev4t
Hk3CtvQeV9Cz9u05PGZ16j7++hFz3DuzSSXsGQlkK65kaquGiZv4JWFR8IWkkBnb
1FfkDovxpsm7QSelt3xJ+eoUw4+p8/jUNylV8I0coIfiuV8iVGr5eH4nvtnwafeo
juPkBUA/4iQfkYYrP7QOt2/+/C0nsS1vwlNJh4cjDQ12Hx8vMeNgSgHloeQSlmy5
P9MeUN/ghhMPAJJv4fFF5viCnRB/+ExEfH4rTZ3W+PE39Tgewns=
=EaTs
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--

