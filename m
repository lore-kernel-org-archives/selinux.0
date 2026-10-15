Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67494367B99
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043153; cv=none; b=gIM1bAt06979nUMSynSjyh+Rr1iyZPWSfW/aDL3A+FXdVPVJFrKKjfSPwJqE0OYC3AjRJHrukeNADP5HWqvtMNSmicQ+2ZxaEj55kngbCBArTXHpq/XnrytYi7PQcbgyQK9k0svC/toUzccY77Eyh8UV09LY6EuFdw2BG6t/gSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043153; c=relaxed/simple;
	bh=KAoqFY0GAgniZJv9vQjkanXAcNn9vdHT2RtqcKGkiNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bm0vp6RvZ/v76o9eDpgt5/AY8iMxEjvv2xH1k0QFmn2tnpX6WQ3oe2Do7GXXY0vDZP//jPUwas6iLb2vtGR8EwVXp4PpWRO0ybkNgWAPFWCUS31C5d9U8E2kvzVkKn+MdNJli+H2HX69IXblPlDhc4C/lFJMUTAc9z1Urb9vWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyZoRXu1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyZoRXu1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so16710045e9.2
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043150; x=1792647950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gPRn8hkr+mMt/Fu1GRbQ/3CuOqM8KlW/klowNi1HWGs=;
        b=ZyZoRXu1dAHojERBHd7zl2pe7LQ5Kfgn5rG1FHD3gB1Qw9/PpR++Cpy5OKtbUxsqy/
         CG67BtI05Rygx+wa8Zr2dxH6+lNSEfp7Czrt3zjFwS/Vb5oHXSgBGgDGcUlt7VUPNMqB
         aFSNJ0ralbLdwhcyeJjYM8N8qHuwtTyAsAFRKx1wkfGX5dasFQ47sxmVWBDuagGQmZ5N
         aepltc3XpX4ptx6Tw/KqOFHBPHXzDMu4atwicHXbnBKx8hMQjP1lQX0LE2um8zRoVh/r
         6FETmiknGlIVoDMkSzeub4wb0TboGKQB/dwn+lQoPadaLZi+lNTj91+mEdFaPjOX+jaz
         Ycig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043150; x=1792647950;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPRn8hkr+mMt/Fu1GRbQ/3CuOqM8KlW/klowNi1HWGs=;
        b=aqVT3jSZyMgCy04p2P1+rYeOfEHv9ZV/dqypI8Z1TDh+dh53AtDEfS3XIrVuuehWo3
         QEJY/to2k2Bv7QP3CBNF0n6qGLzjRZBUezaEWy3H9OSAAVn0eQTiBZiWWlLkzHJEukRC
         ovs7Lb1FlMPkPDjATdoKTeVJEyoRKcVqCDnGyKPBRRWmA8P/XdXXudsHw+4szXLIvVU7
         J4fJIUOakoqMLsCMNmx3MBrtFoR7rFS68nYNb5V2G7dyEXwrPCzZhIh0E6RlJ8Cvuf6s
         sTUzgcDKrl4B3MXP3jkln1nYUuFn8K1sHWM3lWzz6Tunf5zlloP0tEGhtrRx7xlMtagc
         AcTg==
X-Gm-Message-State: AFq9FYL10PY7o1gt4Py0RSK9CpDPUhOKhtH7IOjoXJVQMpiQ9LGcXraU
	13bVpUfHE/GRsr6wLiN3/cO5AeNO+ChDA1+7lKGeh7meanttdaODQkWf9YVKEw==
X-Gm-Gg: AYBFou0qT5rOpfrVkORKml04lKmYH0F0BedyzMljmlmSeDO+AbAqEnwO5om6pEDVOhz
	cFMqPY6v83Asg5ldvvdgKx9tIfLmMkJZcNTOI575l6ROmgwDUBQXM0Hrmrp6A7sxsleozMHPtU6
	FBjcoSEH3GGDc5cCRNC69hEFt3011w9zW5QPamiq/v+qNbImRWOpPDupfQgxwkm5W4Xq5cCqVZH
	GOP8KcncRP7sQO9qh+PovAux8Xdt+vvSWKdwj2xDfDXk4zlDrCiE0eX26JlyWbDl3tt/BEY0PLY
	2oLTDbJHwiw5i/iPIrde5IJopAwj7LAgz9rvufHhtFEB21cNjxYDLGHTBMPNeEMlZm9wXSUIzSG
	q/36GsdUbq++etDnYBBtdzKhjh9SW/AfROKjzA8WZsv066ntVFyTpgvyQKibCZumsxOFlw9zSmn
	zngh/0IBwjGeihN1GVRcFUCS4jCjBQlgrnLFc8cGEuBoa9rkeTK8M18G6ks0fS0l7ecPiSkFrBP
	flhVHbK/G/kz10=
X-Received: by 2002:a05:600c:870e:b0:4a1:6dca:51e3 with SMTP id 5b1f17b1804b1-4a18e4487ccmr358843725e9.3.1792043150510;
        Wed, 14 Oct 2026 22:45:50 -0700 (PDT)
Received: from omos-acer ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbb4a30sm41982805e9.15.2026.10.14.22.45.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:45:49 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 3/5] tmt: rework sysadm_t testing
Date: Thu, 15 Oct 2026 07:45:33 +0200
Message-ID: <20261015054535.844874-4-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054535.844874-1-omosnacek@gmail.com>
References: <20261015054535.844874-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For sysadm testing we currently rely on the fact that TMT will connect
to the test machine via SSH and thus SELinux login configuration will be
applied. However, TMT uses `ssh -M` and `ssh -S` to keep a single SSH
session across test execution and while a new shell is still started for
each remote command, the SELinux context for the login shell is not
recomputed, so `semanage login` changes are not applied.

We currently work around this by forcing a reboot in the prepare-system
phase, but after https://github.com/teemtee/tmt/pull/5069, we would now
need to also do the reboot in unprepare phase as well, otherwise new SSH
connections fail due to the ssh_sysadm_login boolean being already
turned off and SSH still trying to transition into the sysadm context.

So let's stop relying on TMT "logging in" via SSH and instead do a local
SSH login over loopback, avoiding the need for reboots and unwanted
interactions between `semanage login` configuration and TMT's SSH
connections.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tmt/tests.fmf | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 814b65d..75484f4 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -4,21 +4,30 @@
   summary: Prepare the system for testing
   order: 1
   duration: 10m
-  require: policycoreutils-python-utils
+  require:
+    - policycoreutils-python-utils
+    - openssh-server
+    - openssh-clients
   test: |
     set -ex
 
     if [ "$TMT_REBOOT_COUNT" -eq 0 ]; then
       reboot=0
 
+      # Enable root to log in via SSH as itself (so we can potentially test
+      # sysadm confined root)
+      systemctl start sshd
+      if ! [ -e ~/.ssh/id_rsa.pub ]; then
+        echo | ssh-keygen -t rsa -q -N ''
+      fi
+      if ! grep -qF "$(cat ~/.ssh/id_rsa.pub)" ~/.ssh/authorized_keys; then
+        echo "$(cat ~/.ssh/id_rsa.pub)" >>~/.ssh/authorized_keys
+      fi
+
       case "$STS_ROOT_DOMAIN" in
       unconfined_t|'')
         ;;
       sysadm_t)
-        semanage boolean --modify --on ssh_sysadm_login
-        semanage login --modify -s sysadm_u root
-
-        reboot=1
         ;;
       *)
         echo "Invalid STS_ROOT_DOMAIN value!"
@@ -129,16 +138,32 @@
     - rdma-core-devel
     - kexec-tools
     - liburing-devel
+  test: |
+    set -ex
+
+    if [ "$STS_ROOT_DOMAIN" = sysadm_t ]; then
+      semanage boolean --modify --on ssh_sysadm_login
+      semanage login --modify -s sysadm_u root
+      trap '
+        semanage boolean --modify --off ssh_sysadm_login
+        semanage login --modify -s unconfined_u root
+      ' EXIT
+    fi
+
+    # Force a new login to pick up the `semanage login` changes
+    ssh localhost -o StrictHostKeyChecking=no env -C "$PWD/.." $TEST_COMMAND
   /main:
     summary: Run the testsuite
     duration: 20m
-    test: make -C .. test
+    environment:
+      TEST_COMMAND: make test
   /nfs:
     summary: Run the NFS tests
     tag: [nfs]
     duration: 25m
     require+: [nfs-utils]
-    test: env -C .. bash -x ./tools/nfs.sh
+    environment:
+      TEST_COMMAND: bash -x ./tools/nfs.sh
 /avc-check:
   summary: Check unwanted denials
   order: 4
@@ -164,10 +189,6 @@
     set -ex
 
     make -C ../policy unload || true
-    if [ "$STS_ROOT_DOMAIN" = sysadm_t ]; then
-      semanage boolean --modify --off ssh_sysadm_login
-      semanage login --modify -s unconfined_u root
-    fi
     if [ "$STS_KERNEL" = secnext ]; then
       semodule -X 456 -r base
       env -C /usr/share/selinux/devel/include/support mv all_perms.spt.orig all_perms.spt
-- 
2.54.0

