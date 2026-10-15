Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8914367B99
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043389; cv=none; b=PDeVQ5GJGwN2ww3zKtyAxF7O0kmt54JjXo5Y+6t4euPHI6dU+oI/qUtqx94TJtLg456SOswazjpTFdajLPZtULtDDxk0GiRqTl1vGYyGdOPLW41tTnkKPwIYZixMTSEBhLxqpN6CWIhVfy72GyVo3Vq3P04Mi9RYNoeZ4QQuSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043389; c=relaxed/simple;
	bh=F2duk0aY7mw7AsRDENe2d6gKMfvSpS6HkjGDagg79oI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5/y/qOWjwgJwFhBSCtUp7QXK5a82wSdIbB0jZ+jpbyJfSsUvcu2suXnIbxyIeiklhLHM7KBZvSIyuEY/+kG6weBCFRQPDm6qFKJ2S8GrdYAPSFi6W4lQ/vn8tEQif/p0pxZ2Cwpv3xUc7RdFvrHQp2mdfs8kGVs0CxRbAKqSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYyl5Qkj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYyl5Qkj"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b001cd92bso670031f8f.2
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043386; x=1792648186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YC3EYRobmFjfrIUCGX6wHsyG9ZNVek3XW7Q4Ef5xcTE=;
        b=lYyl5QkjurKa2CgMZZSWJ5cehBCT8bcmUJSZRBSL+6r8NBVUNAw2LY0dXk+/+m8dvI
         hwNSrr3dDaPlHfL3updETqS+IwODT7OswRcWy7Jaq8tD10hpMfM89kUKuJF/akbvrfuF
         p8ZDPoiTvlTNl/CfeEJzaVEujISw6+co/3DQH/8VSN9NlZkSRlHEycjvj79zzicEss90
         KRRRCFPKD4xcDWqhWPH663/KZEEG+UKPgh9Pkuke/8te6oVCyiRM3T4I8hOE8Q8y85gI
         WoApSsQKP3Z/R+OoxBRbSMNw/xuqr2qxCofXlsqQQ5njp1QvmSDHWgf85fAYpmSGblqB
         37eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043386; x=1792648186;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YC3EYRobmFjfrIUCGX6wHsyG9ZNVek3XW7Q4Ef5xcTE=;
        b=KHSihIPQDVtIgLOWGz0CFnd/7gMcVmdRFN+Yem5jo9YOXmm0SHbCdAjwl+rMQXmpn1
         nNX0uctxh/5N4JtwMvIVrGU2ZHW9TC26Ck5sFDmqRNShZYIrdP/C8ns9d723pxY9/4IY
         vCi3m1snA/h+pIjttwFH1xMwrcQfISzsTsXvgF5JZGDQFSo82iD2jE6sdg0mXedjvZRx
         GmfOjmTDFoXxIifgBtvZQrmezV4M4cNvzqTq/PhZb+eDetZ9YLzmaH3SSogmJpk6HN+C
         8dR71Wbd+fIeXupGsnqsMDdKMCBSqBRmEnZnxsywJNrN6h6AmQKmcynLPVYrU0ue0PDx
         yeSA==
X-Gm-Message-State: AFq9FYIS/NdXDKpE9C65R3p3r1b/iRejxNMwXa1J2C/X0rAePxTkCTFZ
	1XWTa8lhHZ8//PlSQto/wUIYON29Bnuq2yT5+bcfy8p6va/soBcCTFXs5/JVYQ==
X-Gm-Gg: AYBFou1QAqC4tdTz2QKJmlCSyysoyJwBcZPDgFbJp0/YzcEsr14IXihhs3g/wQqwzEA
	RDtirkVHN4OCNDe//7Jpb8CosYwTPotVXRu659QJWa7frC6BnTZNtKIO1D4yXp5JGNFgvrDaDTG
	fzcuC4VnwnTg/p8C0je8uvVlk6Tx0qeCa5/63Rp6+ogx4BRbyZJCINKYSt49yron4yLFpgcACSH
	sl5PkFn9AxrkyX3KBRThePNetL53QBtGDfg+I2CTf2rxI3SPgcPUVuNgpIJxu33Uxv0rJfo8FGu
	wsWbeKbuxcXSnjuaNLf/bybRLMoqcET0+0xa+7B7Q+7iyO9whTzgRTaTxPjsAcZwEKBLT65Pf8D
	5mC3ZTXrdTALGnkxp7PRkEnJFUOWKhRvkoSSlipVtbRI69l2RNy7KvPs9aBIHi0cfkKIsJAhEia
	rHX+48V4F1NpuxwyBem12m3YpumooovnxueIPhbXsGxyFexQ1weGjMzAIF4cevadIPn15YxUxZR
	tzHk7Skuvf6q9c=
X-Received: by 2002:a05:6000:2f82:b0:48a:fbcf:6f43 with SMTP id ffacd0b85a97d-48dbacf6731mr40730857f8f.54.1792043385947;
        Wed, 14 Oct 2026 22:49:45 -0700 (PDT)
Received: from omos-acer ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48deeadc0b5sm6901587f8f.6.2026.10.14.22.49.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:49:45 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 4/4] tmt,ci: add a mutli-arch compile test
Date: Thu, 15 Oct 2026 07:49:32 +0200
Message-ID: <20261015054932.845406-5-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054932.845406-1-omosnacek@gmail.com>
References: <20261015054932.845406-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test that the testsuite builds on all architectures supported by Fedora
in a mock chroot. The test runs on an x86_64 machine, with x86_64 build
ran natively, while transparent QEMU emulation is used for the other
arches (that is slow, but better than having no coverage).

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 .github/workflows/checks.yml | 13 +++++++++
 tmt/README.md                |  2 +-
 tmt/plans.fmf                | 11 +++++++-
 tmt/tests.fmf                | 54 ++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
index 82837c4..9844be5 100644
--- a/.github/workflows/checks.yml
+++ b/.github/workflows/checks.yml
@@ -11,6 +11,19 @@ jobs:
       - uses: actions/checkout@v4
       - run: sudo chown $(id -u):$(id -g) .
       - run: tools/check-syntax -f && git diff --exit-code
+  compile-test:
+    runs-on: ubuntu-latest
+    steps:
+      - name: Schedule compile-test on Testing Farm
+        uses: sclorg/testing-farm-as-github-action@main
+        with:
+          api_key: ${{ secrets.TESTING_FARM_API_TOKEN }}
+          arch: x86_64
+          compose: Fedora-latest
+          tmt_plan_filter: tag:compile
+          tmt_hardware: '{ "cpu": { "cores": ">=16" } }'
+          # no need for the "guest setup" - it just takes a lot of time for no benefit
+          environment_settings: '{ "pipeline": { "skip_guest_setup": true } }'
   run:
     runs-on: ubuntu-latest
     strategy:
diff --git a/tmt/README.md b/tmt/README.md
index 4d90724..f23e33e 100644
--- a/tmt/README.md
+++ b/tmt/README.md
@@ -4,7 +4,7 @@ This directory contains basic "test plans" for running the selinux-testsuite via
 
 ```bash
 tmt run [-e STS_ROOT_DOMAIN=...] [-e STS_KERNEL=...] \
-    plans -f 'tag:-ci' --all provision -h ...
+    plans -f 'tag:-ci & tag:-compile' --all provision -h ...
 ```
 
 See `tmt run provision --help` for information about possible provisioning methods (most useful are `local`, `connect`, or `virtual.testcloud`).
diff --git a/tmt/plans.fmf b/tmt/plans.fmf
index 52315f7..29e9b30 100644
--- a/tmt/plans.fmf
+++ b/tmt/plans.fmf
@@ -2,7 +2,7 @@
   summary: Run the testsuite
   discover:
     how: fmf
-    filter: tag:-ci
+    filter: tag:-ci & tag:-compile
   execute:
     how: tmt
 /run-ci:
@@ -10,5 +10,14 @@
   tag: [ci]
   discover:
     how: fmf
+    filter: tag:-compile
+  execute:
+    how: tmt
+/compile-test:
+  summary: Test compilation on various architectures
+  tag: [compile]
+  discover:
+    how: fmf
+    filter: tag:compile
   execute:
     how: tmt
diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 08bd129..1663983 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -171,3 +171,57 @@
       semodule -X 456 -r base
       env -C /usr/share/selinux/devel/include/support mv all_perms.spt.orig all_perms.spt
     fi
+/compile-test:
+  summary: Run a compile test
+  tag: [compile]
+  duration: 30m
+  require: mock
+  test: |
+    set -x
+
+    arch="$BUILD_ARCH"
+
+    mock -r "fedora-rawhide-$arch" --forcearch "$arch" --init || exit 2
+    mock -r "fedora-rawhide-$arch" --forcearch "$arch" --install \
+      make \
+      perl-Test \
+      perl-Test-Harness \
+      perl-Test-Simple \
+      perl-lib \
+      selinux-policy-devel \
+      gcc \
+      libselinux-devel \
+      net-tools \
+      netlabel_tools \
+      iptables \
+      nftables \
+      lksctp-tools-devel \
+      attr \
+      libbpf-devel \
+      keyutils-libs-devel \
+      quota \
+      xfsprogs-devel \
+      libuuid-devel \
+      e2fsprogs \
+      f2fs-tools \
+      jfsutils \
+      dosfstools \
+      btrfs-progs \
+      rdma-core-devel \
+      kexec-tools \
+      liburing-devel \
+      || exit 2
+    cp -a .. "$(mock -r "fedora-rawhide-$arch" --forcearch "$arch" --print-root-path)"/root/selinux-testsuite || exit 2
+    mock -r "fedora-rawhide-$arch" --forcearch "$arch" --chroot 'make -j"$(nproc)" -C /root/selinux-testsuite all || exit 1'
+  /x86_64:
+    environment:
+      BUILD_ARCH: x86_64
+  /aarch64:
+    environment:
+      BUILD_ARCH: aarch64
+  /ppc64le:
+    environment:
+      BUILD_ARCH: ppc64le
+  /s390x:
+    environment:
+      BUILD_ARCH: s390x
-- 
2.54.0

