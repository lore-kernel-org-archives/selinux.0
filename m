Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F49C35280
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E1D206BB
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 10:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cx8XW0tY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfI3KtE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:49:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729870AbfI3KtE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 06:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569840543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wDmwmE0HNQ5tRAfHtKAbS8QJGf1L4RWctr1w7KHviMA=;
        b=Cx8XW0tY7MY0CMi9JTuBSWXND1pT4QygeZSTh4/edZkyr7WYyVYMiw1y8+kPQw+C7JWlUI
        gmgzGw2KVLJeE1aR2b0iuhPaniCv8GzBszhp7qYuB2hv3VtOrRhcEdDGip8dE4LDq+madK
        6JxAnLtj2SvxyVh/AtWZexwsJRPw/fc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-6wD1Yr-_MR-gM4hAfyOD8Q-1; Mon, 30 Sep 2019 06:48:58 -0400
Received: by mail-wr1-f69.google.com with SMTP id n3so4346896wrt.9
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 03:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5v53W6hoYMweBa+McQa3Fq6y1mhOiYeLwB8uv6eBX3Q=;
        b=tnxqL1Km1JwovI8TpzRW+0zPAGhoZtcqjJLkCbVFkx/MwhCoUuWKaMXCShDJvbiF5i
         VKDXZWC6zNLiFbP2i3DunZUhRApJ61q+DPKdHFm5yGc6O1cZ1tIgK8RPJBSqfmwzGCcc
         M8sk8p4WBYMhGtRwFWqWfgMrtrohhflLXK9uWBuDhHRs8+TBjMABILmlSHful4sGxeWq
         hGXPcVeE1i0/eTb/AABDcZFAn7vEbB8LkSaQ6rzqghFR/+PtS6DDPiYY4NowY2RxtOiu
         9kCtxbPClK8HyLDHoiT70Edeo/5OR3g512h3XjS7yVjngj7qehhy8AfCfsZrjyBmH2nj
         Mihw==
X-Gm-Message-State: APjAAAUjEJ/j0oNvZVVjQlRXsbznao8dsnwYwprgXfoQR656P7qQ6B6/
        /rI8YwOcvYkl5uxevfXPUL/9VKnR48N2u0KJ1kCis/M43fTHjkbWiNBQfE/++meETEhbF2xo/lg
        lHSgU8y6uVAVoTU6vLg==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr17465496wmb.93.1569840537356;
        Mon, 30 Sep 2019 03:48:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4xX5NH3+9ZBQn+Ipovca4EKgGSTcWdFQlwJk9ztPKJH3e3ayMoiBiEOLJleDQaivs29B4uQ==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr17465483wmb.93.1569840537113;
        Mon, 30 Sep 2019 03:48:57 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i73sm27081254wmg.33.2019.09.30.03.48.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:48:56 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 3/3] travis: test building the test policy package
Date:   Mon, 30 Sep 2019 12:48:50 +0200
Message-Id: <20190930104850.5482-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930104850.5482-1-omosnace@redhat.com>
References: <20190930104850.5482-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 6wD1Yr-_MR-gM4hAfyOD8Q-1
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
 .travis.yml                         | 24 ++++++++++++++++++--
 travis-ci/enable-policy.sh          | 10 +++++++++
 travis-ci/setup-policy-fedora.sh    | 35 +++++++++++++++++++++++++++++
 travis-ci/setup-policy-refpolicy.sh | 22 ++++++++++++++++++
 4 files changed, 89 insertions(+), 2 deletions(-)
 create mode 100644 travis-ci/enable-policy.sh
 create mode 100644 travis-ci/setup-policy-fedora.sh
 create mode 100644 travis-ci/setup-policy-refpolicy.sh

diff --git a/.travis.yml b/.travis.yml
index fbbe98d..c8cd44e 100644
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
@@ -8,6 +8,14 @@ addons:
       - astyle
       - libselinux1-dev
       - libsctp-dev
+      - checkpolicy
+      - semodule-utils
+
+cache:
+  directories:
+    - selinux-policy
+    - container-selinux
+    - refpolicy
=20
 before_install:
   # FYI: known good with HEAD at 8551fc60fc515cd290ba38ee8c758c1f4df52b56
@@ -17,7 +25,19 @@ before_install:
      perl Makefile.PL &&
      make &&
      sudo make install)
+  # install libbpf from sources
+  - git clone https://github.com/libbpf/libbpf
+  - (cd libbpf/src && make PREFIX=3D/usr/local)
+  - (cd libbpf/src && sudo make install PREFIX=3D/usr/local)
+  # install Fedora policy and refpolicy
+  - bash travis-ci/setup-policy-fedora.sh
+  - bash travis-ci/setup-policy-refpolicy.sh
+  # establish a fake "selinuxfs" mount (policy/Makefile just greps for sel=
inuxfs)
+  - sudo mkdir -p /tmp/fake-selinuxfs
+  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
+  - echo 31 >/tmp/fake-selinuxfs/policyvers
=20
 script:
   - tools/check-syntax -f && git diff --exit-code
-  - make
+  - bash travis-ci/enable-policy.sh targeted  && make POLDEV=3D/usr/share/=
selinux/targeted
+  - bash travis-ci/enable-policy.sh refpolicy && make POLDEV=3D/usr/share/=
selinux/refpolicy
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
index 0000000..192e234
--- /dev/null
+++ b/travis-ci/setup-policy-fedora.sh
@@ -0,0 +1,35 @@
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
+grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
+=09sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
+
+[ -f policy/modules.conf ] || make conf
+
+make -j`nproc --all`
+sudo make install install-headers
+
+# workaround for different Makefile location in Fedora RPMs
+sudo ln -s include/Makefile /usr/share/selinux/targeted/Makefile
diff --git a/travis-ci/setup-policy-refpolicy.sh b/travis-ci/setup-policy-r=
efpolicy.sh
new file mode 100644
index 0000000..d89b041
--- /dev/null
+++ b/travis-ci/setup-policy-refpolicy.sh
@@ -0,0 +1,22 @@
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
+grep -q '^portcon sctp' policy/modules/kernel/corenetwork.te.in && \
+=09sed -i '/^portcon sctp/d' policy/modules/kernel/corenetwork.te.in
+
+make -j`nproc --all`
+sudo make install install-headers
+
+# workaround for different Makefile location in Fedora RPMs
+sudo ln -s include/Makefile /usr/share/selinux/refpolicy/Makefile
--=20
2.21.0

