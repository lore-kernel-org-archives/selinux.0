Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81283C433EF
	for <selinux@archiver.kernel.org>; Thu, 21 Apr 2022 08:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386613AbiDUIXI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386663AbiDUIWt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Apr 2022 04:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE7B56359
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650529199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=QCVxPG3bVzPtF1fiIfWu/DSo9G2poJN9q06c4ZOwJkg=;
        b=J9sYUzMhXwYvSrkywIfDulSqa6QlWa0xki/a8INOg357rYA5qN91IA0/eHCcXT2KHLeIxc
        7xQYq3gC1exW0X6xYxgmYUd37WxDMHPU5Jdq48capjQsuSyf/HJWQDYYJ3NDbTeRGC97zo
        p7GfTpebOlpgUTFupa4HcrZCxV6YHEg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-uB88q0kYNECm7ezBerkZ1g-1; Thu, 21 Apr 2022 04:19:57 -0400
X-MC-Unique: uB88q0kYNECm7ezBerkZ1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13BEC1C0BF21
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 08:19:57 +0000 (UTC)
Received: from localhost (unknown [10.40.194.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B10BC4047295
        for <selinux@vger.kernel.org>; Thu, 21 Apr 2022 08:19:56 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: SELinux userspace 3.4-rc2 release candidate
Date:   Thu, 21 Apr 2022 10:19:44 +0200
Message-ID: <87zgkesva7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

A 3.4-rc2 release candidate for the SELinux userspace is now
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Tarballs are signed with
https://people.redhat.com/plautrba/plautrba@redhat.com.asc

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out
in release notes for packagers and users in the final release
announcement, let us know.

Thanks to all the contributors to this release candidate!

Changes since 3.4-rc1
=2D--------------------

* New policy utilities in libsepol - sepol_check_access,
  sepol_compute_av, sepol_compute_member, sepol_compute_relabel,
  sepol_validate_transition

* Improved code quality and bug fixes

Shortlog of changes since the 3.4-rc1 release
=2D--------------------------------------------
Christian G=C3=B6ttsche (19):
      libsepol: add sepol_av_perm_to_string
      libsepol: introduce sepol_const_security_context_t typedef
      libsepol: export functions for policy analysis
      libsepol: add policy utilities
      libselinux/utils: check for valid contexts to improve error causes
      policycoreutils: drop usage of egrep in fixfiles
      libsepol/cil: declare file local function pointer static
      libsepol: check correct pointer for oom
      libsepol: drop unnecessary const discarding casts
      libselinux: limit has buffer size
      libsemanage: avoid double fclose
      Correct misc typos
      libsepol/tests: adjust IPv6 netmasks
      libsepol/cil: comment out unused function __cil_verify_rule
      libsemanage: ignore missing prototypes in swig generated code
      Enable missing prototypes
      libselinux: correct parameter type in selabel_open(3)
      libselinux: free memory on selabel_open(3) failure
      libselinux: correctly hash specfiles larger than 4G

James Carter (7):
      libsepol: Replace calls to mallocarray() with calls to calloc()
      setfiles.8: -q is deprecated and has no effect
      libsepol/tests Include policydb.h header for policydb_t declaration
      libsepol/tests: Include paired headers for prototypes
      libsepol/tests: Declare file local functions as static
      libsemanage/tests: Declare file local functions as static
      libsemanage/tests: Remove unused functions

Petr Lautrbach (1):
      Update VERSIONs to 3.4-rc2 for release.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAmJhE6AACgkQviIJHj72
InVTuQ/+OYZt3DgG0Xlzab/B5z136oPI3OE+rsjrZHcgs1eyTNsiLluvg2oxi8Hh
HxuQ9UN3En0Wfi/3co/s/SPEbqWYolDm/Ncz6F3qMgO2pR3uO+4uB/Wx/BJxTk36
Th8ovTYRro+dHX8BsckCCTIwjXRmQaCn8xune/UkhuasmNr88O73D+xQhivGJp4M
4zyuChmiCQgSdsaKkeF9nMBPVYbiblZVTuLioxwFsEuCaLxMqufcyHxCuFTI5v9Z
adeCuQaUuCH8w4z04/ZQUM79QhxITpFB8kNNCtxUoVTeLZZQrk4+kVqWnKi+HkjR
DW83ZY+J4xMGsi6+IeDhrdpSs2fk+cz7oRoPCsPvzCFLm5QaRPbPNmJS8n2WJjFb
e2mhly56cEGEip0uCNtO2mq8eylnft7CyOdE708GpFV2xNOzqWaNgb2aKZKaCDP6
Qzvfc2Ko1IHW82q/vdGAhkrEVrJjEVER+pUs5u8VUgv33dkWfcSRVHY9wgEYPu4b
oeypywXloR7brDQbgCpWGTqfRXujDe14ZIIjzFTW4nFc/0QLCzTPu66k9x/tjz1c
0kn6nz46mzQ8Du/zEut5tJ/gfQEasd4I3JtvyKqdqTgVBokb2y9aubvglM/vvJTF
JhZjCNcX+vhsLRiPDX8cqPfTGd4HCayj637c07bMZVwX9LXcUks=
=VQ21
-----END PGP SIGNATURE-----
--=-=-=--

