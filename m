Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B9C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4C420708
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXC2vpwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGIJpd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:45:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbgGIJpd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 05:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594287931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rNW46gvj45HeI14DOE5vuOy7mEvp/ARmC8VjZJ+haQo=;
        b=YXC2vpwGbOfZ+FJ4UKDosW/CecOzdfCPJxh93wJshPZpBJAOIGR9PxUmJWYnY2G5CWRNw+
        tXQxck6N9JoWn/6sN0NNWVBznIWN/HWAbKbqp4KREWbf3g/jU+nGZ72ny070bhXdy5sFSC
        FVOm+ZbNxFuj2OEKMPgUFAtlarsDUN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-rRkJotCgNta59KFjP6gs2w-1; Thu, 09 Jul 2020 05:45:26 -0400
X-MC-Unique: rRkJotCgNta59KFjP6gs2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671F8800401
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDF1D2B6D9
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 09:45:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: 3.1 release notes draft
Date:   Thu,  9 Jul 2020 11:45:08 +0200
Message-Id: <20200709094509.1620563-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


I'd like to release 3.1 today/tommorow to open the development of other
performance related improvemenets which which postponed. This is release notes
draft which is based on RELEASE-20200518.txt and RELEASE-20200619.txt:

RELEASE 202007XX (3.1)

User-visible changes:

* selinux/flask.h and selinux/av_permissions.h were removed

  The flask.h and av_permissions.h header files were deprecated and
  all selinux userspace references to them were removed in
  commit 76913d8adb61b5 ("Deprecate use of flask.h and av_permissions.h.")
  back in 2014 and included in the 20150202 / 2.4 release.
  All userspace object managers should have been updated
  to use the dynamic class/perm mapping support since that time.
  Remove these headers finally to ensure that no users remain and
  that no future uses are ever introduced.

  Use string_to_security_class(3) and string_to_av_perm(3) to map the class and
  permission names to their policy values, or selinux_set_mapping(3) to create a
  mapping from class and permission index values used by the application to the
  policy values.

* Support for new polcap genfs_seclabel_symlinks

* New `setfiles -E` option - treat conflicting specifications as errors, such
as where two hardlinks for the same inode have different contexts.

* `restorecond_user.service` - new systemd user service which runs `restorecond -u`

* `setsebool -V` reports errors from commit phase

* Improved man pages

* `semanage` uses ipaddress Python module instead of IPy

* matchpathcon related interfaces are deprecated

* selinuxfs is mounted with noexec and nosuid

* Improved README which was renamed to README.md and converted to markdown.

* `setup.py` builds can be customized using PYTHON_SETUP_ARGS, e.g. to for
  Debian Python layout use: `make PYTHON_SETUP_ARGS=--install-layout=deb ...`

* the dso wrappers for internal calls were removed and it is now strongly recommended to CFLAGS with
  `-fno-semantic-interposition`

* `security_compute_user()` was deprecated - usage of /sys/fs/selinux/user { security:compute_user } might be revisited

* checkpolicy treats invalid characters as an error - it might break (but intentional) rare use cases

* New `restorecon -x` option - prevent `restorecon` from crossing file system
  boundaries.

* Handle `semanage module` in semanage bash completion

* Added section about CFLAGS to README.md, see Packaging-relevant changes

* Improved man pages

* Add Travis CI job to run SELinux kernel testsuite on latest Fedora cloud image

* `sepolgen-ifgen` parses a gen_tunable statement as bool

* `semanage` handles getprotobyname() failure case on Debian where /etc/protocols does not contain an entry for "ipv4"

Packaging-relevant changes:

* Setting CFLAGS during the make process will cause the omission of many defaults. While the project strives
  to provide a reasonable set of default flags, custom CFLAGS could break the build, or have other undesired
  changes on the build output. Thus, be very careful when setting CFLAGS. CFLAGS that are encouraged to be
  set when overriding are:

  - -fno-semantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
    will support passing this flag, but ignore it. Previous clang versions fail.

Issues fixed:

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


