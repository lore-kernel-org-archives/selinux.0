Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB6C43215
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647520659
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zt5raw2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKROwr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:52:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726748AbfKROwr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 09:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574088765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YynLGcwqfrg1zrZcC7yWAsZBhR/R+Oy3X5+AJIk9Z2o=;
        b=Zt5raw2hvd+ijlBjfOV1Qp3N5WqA0sjyOFuTGLz/HgHO6K45vj5td1GlX8b5gDgbIMjMUO
        1X3ufTCAn89G0IdDhm2yZbpB9M7DOjczpXOu27dAxni3d0puxa7aRxixXDGxVTxj6fWPz9
        6lIV0ze23ULpMkaDXdsK5I/9HLv8xmQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220--F3xdTPrN4Cs7EuAtL8IJg-1; Mon, 18 Nov 2019 09:52:43 -0500
Received: by mail-wr1-f69.google.com with SMTP id n11so3120935wrq.5
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 06:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCsn/X0nmr4hSWIgFPGsvpX5LzN+Uu1MiAqfZRe9+Lg=;
        b=BlKYn33y9Qi8E+Xtv2pwzqO5UEhdVnQu5l6Nw2klej06dOV/9tFtHatXpVpO6Gssrh
         4FPA2Qx+BFlTVyC0ne/jGhupoczo7h0SGTcvgYu6rB5Cl0/8H0EYLJy6Vc6mgfFhtNeB
         tfxZx1EVzkhTfXfTQCRd334UZ478Y/svr3zS2xFjaeYrT7LuNN8CmGEDTusJSQvI3euA
         zA2SdDpKxI9mLxEbct1SBQDrf414IQ13tfmnqUpJtH+2RMldFQFvFO3IfrqH+9vHwDgb
         Ay5zan+v2tQ83VspxKNStdqD7ag94qYmvbifWQag9tb99rsGJtHL70KbJcV5A0CUxAS9
         h/BA==
X-Gm-Message-State: APjAAAXGZSn8qMNFCB+uoeX2q9Tg2Mpyjeifl8hXm9gpHkXtTrl478N/
        byqhm9ooVm40wC7fqA+LN5DviVuYAhrKlh9ximfgCeqIvRCOFdvaSW17CCB8SNEXbtryPaqrq4v
        N975fjTdD3BLwhYqI0g==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr29518075wma.12.1574088761632;
        Mon, 18 Nov 2019 06:52:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcYHSUybkg8vlk+wVMCrxxq+uACtLM66OfFFuA0n6CHTDWsO8VV4wt+Uqux2oLoJ8L3CSPBg==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr29518048wma.12.1574088761352;
        Mon, 18 Nov 2019 06:52:41 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o5sm23044658wrx.15.2019.11.18.06.52.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:52:40 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v4 3/3] travis: test building the test policy package
Date:   Mon, 18 Nov 2019 15:52:38 +0100
Message-Id: <20191118145238.408124-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118145238.408124-1-omosnace@redhat.com>
References: <20191118145238.408124-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: -F3xdTPrN4Cs7EuAtL8IJg-1
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

