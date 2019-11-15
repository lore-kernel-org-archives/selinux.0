Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09174C43215
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC3C20733
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2B7EWgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOPQd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:16:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727429AbfKOPQd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573830992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YynLGcwqfrg1zrZcC7yWAsZBhR/R+Oy3X5+AJIk9Z2o=;
        b=H2B7EWgqasahMjjTNDW+8V2RxWW3wpcf4k2HHJP8yoa9xag6JeldrA21BStCZb8dh8M5Vv
        r1YS79zFL9lMN1Al+99gkzotqrFN3zjL7EGJlFFm05iPu1V9fKooK2qdJyxTgZDdD/JxZk
        3UObbdazMwPeoJudJdbAbLkopfIbmZ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ePzVMZO4PuKjs3GfwOBfuw-1; Fri, 15 Nov 2019 10:16:30 -0500
Received: by mail-wm1-f71.google.com with SMTP id i23so6159193wmb.3
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 07:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCsn/X0nmr4hSWIgFPGsvpX5LzN+Uu1MiAqfZRe9+Lg=;
        b=GZJ4S1M0BbQbIxySrWxUpaq2zrNdMl1MmaXrBSSsPPgViEyE5dtkbXlrWVLGpUCFoI
         nwlKTKvMvNAyfSiORWJJLa5Q2uUdABwo7NH0joy7qqVVFUuOaTHJKe5WfNoWynOgn4Ja
         gOcO3esLEl4efyKRZ17kd2F+JCsi6nRXqDM9HVFW5k9m673MDA4mmzTIThWUvEzneWBp
         onYSbr3cOSghmr7Nx7ypSkV82friO4xD2hbWFUVs+0SJ27UeK9AvWVy6uaJ1DJwhn1PB
         6qNIiGe5HlrMamVLSNBS4LDIvLwAC/Ijg+6kSEKYYN4Bptw2ze91oPRc01p0g+hLPGhL
         po2Q==
X-Gm-Message-State: APjAAAXokxxPBt9gQ0qJyQJ8d5u6DAiwvQYax+uliA6FnDOsKXjI3BIj
        cv6s50hjiWQ8Upzl20yPInl7qHusipKsqrfcfcqKGB7DfLundGe4UBa/J9n0PxLj4TzgD0MH4qi
        aRbheFDBxlzOhFP6ZfA==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr15314033wri.138.1573830988647;
        Fri, 15 Nov 2019 07:16:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxagkNvpd25vRjPaSV9iPVc7AowRmEpXppYsLYCgzNN7A5KS85EEaJycCYVIwlWp8mZhnLJ0A==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr15313996wri.138.1573830988375;
        Fri, 15 Nov 2019 07:16:28 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j63sm10337239wmj.46.2019.11.15.07.16.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 07:16:27 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2 3/3] travis: test building the test policy package
Date:   Fri, 15 Nov 2019 16:16:23 +0100
Message-Id: <20191115151623.265770-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115151623.265770-1-omosnace@redhat.com>
References: <20191115151623.265770-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: ePzVMZO4PuKjs3GfwOBfuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Download, build, and install Fedora policy & refpolicy and try building
the test policy package against both of them.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml                         | 48 ++++++++++++++++++++++++++---
 policy/Makefile                     | 11 ++++---
 travis-ci/enable-policy.sh          | 10 ++++++
 travis-ci/setup-policy-fedora.sh    | 33 ++++++++++++++++++++
 travis-ci/setup-policy-refpolicy.sh | 19 ++++++++++++
 5 files changed, 113 insertions(+), 8 deletions(-)
 create mode 100644 travis-ci/enable-policy.sh
 create mode 100644 travis-ci/setup-policy-fedora.sh
 create mode 100644 travis-ci/setup-policy-refpolicy.sh

diff --git a/.travis.yml b/.travis.yml
index fbbe98d..42b2490 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,6 +1,6 @@
 language: c
=20
-dist: xenial
+dist: bionic
=20
 addons:
   apt:
@@ -8,16 +8,56 @@ addons:
       - astyle
       - libselinux1-dev
       - libsctp-dev
+      - libaudit-dev
+      - libcap-dev
+      - libdbus-glib-1-dev
+      - xmlto
+
+cache:
+  directories:
+    - selinux-policy
+    - container-selinux
+    - refpolicy
=20
 before_install:
+  - export LIBRARY_PATH=3D/usr/local/lib
+  - export LD_LIBRARY_PATH=3D/usr/local/lib
   # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
   - git clone https://github.com/perltidy/perltidy.git perltidy
   - |
     (cd perltidy &&
      perl Makefile.PL &&
-     make &&
-     sudo make install)
+     make PREFIX=3D/usr/local &&
+     sudo make install PREFIX=3D/usr/local)
+  # install libbpf from sources
+  - git clone https://github.com/libbpf/libbpf
+  - (cd libbpf/src && make PREFIX=3D/usr/local)
+  - (cd libbpf/src && sudo make install PREFIX=3D/usr/local)
+  # install keyutils from sources
+  - git clone https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/key=
utils.git
+  - KEYUTILS_OPTS=3D""
+  - KEYUTILS_OPTS+=3D"BINDIR=3D/usr/local/bin SBINDIR=3D/usr/local/sbin "
+  - KEYUTILS_OPTS+=3D"LIBDIR=3D/usr/local/lib USRLIBDIR=3D/usr/local/lib "
+  - KEYUTILS_OPTS+=3D"INCLUDEDIR=3D/usr/local/include "
+  - KEYUTILS_OPTS+=3D"SHAREDIR=3D/usr/local/share/keyutils MANDIR=3D/usr/l=
ocal/share/man"
+  - (cd keyutils && make $KEYUTILS_OPTS)
+  - (cd keyutils && sudo make install $KEYUTILS_OPTS)
+  # install SELinux userspace from source
+  - git clone https://github.com/SELinuxProject/selinux
+  - (cd selinux && sudo make install PREFIX=3D/usr/local SHLIBDIR=3D/usr/l=
ocal/lib)
+  # install Fedora policy and refpolicy
+  - bash travis-ci/setup-policy-fedora.sh
+  - bash travis-ci/setup-policy-refpolicy.sh
+  # establish a fake "selinuxfs" mount (policy/Makefile just greps for sel=
inuxfs)
+  - sudo mkdir -p /tmp/fake-selinuxfs
+  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
+  - echo 999 >/tmp/fake-selinuxfs/policyvers
=20
 script:
   - tools/check-syntax -f && git diff --exit-code
-  - make
+  - |
+    bash travis-ci/enable-policy.sh targeted &&
+    make PREFIX=3D/usr/local POLDEV=3D/usr/share/selinux/targeted
+  - |
+    bash travis-ci/enable-policy.sh refpolicy &&
+    make PREFIX=3D/usr/local POLDEV=3D/usr/share/selinux/refpolicy
diff --git a/policy/Makefile b/policy/Makefile
index ff65153..39ae84a 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -1,8 +1,11 @@
=20
-POLDEV ?=3D /usr/share/selinux/devel
-SEMODULE =3D /usr/sbin/semodule
-CHECKPOLICY =3D /usr/bin/checkpolicy
-CHECKMODULE =3D /usr/bin/checkmodule
+PREFIX ?=3D /usr
+BINDIR ?=3D $(PREFIX)/bin
+SBINDIR ?=3D $(PREFIX)/sbin
+POLDEV ?=3D $(PREFIX)/share/selinux/devel
+SEMODULE =3D $(SBINDIR)/semodule
+CHECKPOLICY =3D $(BINDIR)/checkpolicy
+CHECKMODULE =3D $(BINDIR)/checkmodule
=20
 DISTRO=3D$(shell ../tests/os_detect)
=20
diff --git a/travis-ci/enable-policy.sh b/travis-ci/enable-policy.sh
new file mode 100644
index 0000000..ae53fbe
--- /dev/null
+++ b/travis-ci/enable-policy.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+
+set -e
+
+# create a dummy /etc/selinux/config
+sudo mkdir -p /etc/selinux
+sudo tee /etc/selinux/config >/dev/null <<EOF
+SELINUX=3Ddisabled
+SELINUXTYPE=3D$1
+EOF
diff --git a/travis-ci/setup-policy-fedora.sh b/travis-ci/setup-policy-fedo=
ra.sh
new file mode 100644
index 0000000..d2793f0
--- /dev/null
+++ b/travis-ci/setup-policy-fedora.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+
+set -ex
+
+if ! [ -d selinux-policy/.git ]; then
+=09git clone --recursive https://github.com/fedora-selinux/selinux-policy
+=09(cd selinux-policy/policy/modules/contrib && git checkout rawhide)
+else
+=09(cd selinux-policy && git pull || { git checkout '*' && git pull; })
+=09(cd selinux-policy/policy/modules/contrib && git pull)
+fi
+
+if ! [ -d container-selinux/.git ]; then
+=09git clone https://github.com/containers/container-selinux.git
+=09for f in container.if container.te; do
+=09=09ln -s ../../../../container-selinux/$f \
+=09=09=09selinux-policy/policy/modules/contrib/$f
+=09done
+else
+=09(cd container-selinux && git pull)
+fi
+
+cd selinux-policy
+
+grep -q refpolicy build.conf && sed -i 's/refpolicy/targeted/' build.conf
+
+[ -f policy/modules.conf ] || make conf
+
+make -j`nproc --all` BINDIR=3D/usr/local/bin SBINDIR=3D/usr/local/sbin
+sudo make install install-headers
+
+# workaround for different Makefile location in Fedora RPMs
+sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-r=
efpolicy.sh
new file mode 100644
index 0000000..abd4ca4
--- /dev/null
+++ b/travis-ci/setup-policy-refpolicy.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+
+set -ex
+
+if ! [ -d refpolicy/.git ]; then
+=09git clone https://github.com/SELinuxProject/refpolicy
+else
+=09git pull || { git checkout '*' && git pull; }
+fi
+
+cd refpolicy
+
+[ -f policy/modules.conf ] || make conf
+
+make -j`nproc --all` BINDIR=3D/usr/local/bin SBINDIR=3D/usr/local/sbin
+sudo make install install-headers
+
+# workaround for different Makefile location in Fedora RPMs
+sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
--=20
2.23.0

