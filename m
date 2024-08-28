Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C143AC2B
	for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875216; cv=none; b=LXeMkx46Fp8Ua+7ZXFzcXVn/jDKTWlscGkSwDsVZ1K/GcIGs9AUmlwRVB6I1HStmLBxhK2dRKAavVjMmagt+vm4zGq4LnIv/4XxBj5nKWIqmbI/L4BfeYZv4mC0uoyMqmLaiWAnGgRIUSeNcDMD/myo6n5rgmzb+WUpTkUjE8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875216; c=relaxed/simple;
	bh=TYaBL/xl+QQCgWtQ0PW4LmVaUYDEuj9quXhFWUMDx2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X/dPiZ5nVUfdR8CXz2ri3iJQapDB/48UOtvYYJwmRfaFd2Q18UuD2nXNhDUZJ1ryJRxlKtnZg7y/+jLb9JGOfmvGmIzbC3TUX0g85jtFzielMRdlCtsrbdWr2DS5E0HGM6k179J8xpUv/qLC7quf/Sbhr9BfZNwN4BkAqc2vERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRH1Odhc; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRH1Odhc"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4fd01340753so1994670e0c.1
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2024 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724875213; x=1725480013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa7T+gI0DTk4lod+AHEf59gLHNfu8Xp0eHGwtIxhUXM=;
        b=XRH1Odhcm6swTLaRcZa8fRcg+wDmeIGfwjyagzG82FtYddY6Epxf0zucLiqqoRjufo
         yuqOiQMQ2WRiPKazeMn9nnjImjSm5DjsztYpwZc5Sw5+X2PhhQika/ci5tnXDR1Ofien
         NMObru6Kj2vQXBi3THuMhYvSp0qL2ZKH2qnDOtYorHn3nSq9LYSrmRW1hXT+Mc+l6dSi
         3SaW0LewVfcNu2uphkXmlZ7etPrH8S2n2Ugy8e+1F2ohugtoAA7R4se/YPCOORl3p9WA
         CVCZytcohlryA6UEgqTiOvGPkKpSdzNI8YGzgDoWBA3i9i8v7G3wUEW4sFymaWb2dTKT
         itvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875213; x=1725480013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa7T+gI0DTk4lod+AHEf59gLHNfu8Xp0eHGwtIxhUXM=;
        b=tllF0OBYsT6kSotqheXstBDN5dXJIPbPckZSKJFCIzOYBSjHAAEWuWPpZSFFGPCJW1
         B9UjtZe4FfFG3BjEjFjJxcyW8aeHi+V1D/aQwmJVK7GB4RflcE3Qv5kgdwYIZ+OX1Sff
         /7gIZNSqaJ8RVkxgLcYaDoT0l/xYN/iz0pgfgzN2cmv2IWtqxFtFUzujNpQRFKtIYoRc
         FHEehjTM05gfTTD6T1P/dMdZgbMXRm6dfH1C4ftU/YWZIeG6JY6ufWVGYKbAnmUlAlFI
         AzVU1R6y5zcCxWtlqMrqD1EwKS9B82538XBaqZqz4amxoxjXVxmS2TLC4Jud+3PLewIa
         sSGQ==
X-Gm-Message-State: AOJu0YwE3ylhXgnz3HgWY6wPY/AHG4fTIXqxRs0bt25TZKdeCgZbZfoV
	xgJ/bggBMUZMlC8ssI6MI79A//jyc5KTW3RUx5P+uX5+93S4+5Rpq3hkRQ==
X-Google-Smtp-Source: AGHT+IGfRpI15wwK9hdpcWC6P5rkz4RQeMVZ93bnnwL29dufS/uJgqv3IiwQtLvKyjMYjy5AB9+lRA==
X-Received: by 2002:a05:6122:8d2:b0:4f2:ea44:fd2b with SMTP id 71dfb90a1353d-4ffdc01ceedmr651455e0c.0.1724875212651;
        Wed, 28 Aug 2024 13:00:12 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4567d5c4b8fsm3377441cf.27.2024.08.28.13.00.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 13:00:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	tweek@google.com,
	brambonne@google.com,
	jeffv@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] policy,tests: add tests for netlink xperms
Date: Wed, 28 Aug 2024 15:57:56 -0400
Message-Id: <20240828195755.19385-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for netlink xperms. Test program is based on an earlier test
program for netlink_send checking by Paul Moore. Exercising these
tests depends on the corresponding kernel patch, userspace patches,
and updating the base policy to define the new nlmsg permissions
and to enable the new netlink_xperm policy capability.

For testing purposes, you can update the base policy by manually
modifying your base module and tweaking /usr/share/selinux/devel
(latter only required due to writing the test policy as a .te file
rather than as .cil in order to use the test macros) as follows:
    sudo semodule -c -E base
    sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" base.cil
    sudo semodule -i base.cil
    echo "(policycap netlink_xperm)" > netlink_xperm.cil
    sudo semodule -i netlink_xperm.cil
    sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" \
        /usr/share/selinux/devel/include/support/all_perms.spt

When finished testing, you can semodule -r base netlink_xperm to
undo the two module changes and restore your all_perms.spt file
from the saved .orig file.

NB The above may lead to unexpected denials of the new nlmsg permission
for existing domains on your system and prevent new ssh sessions from
being created. Recommend only inserting the netlink_xperm.cil module
just prior to running the testsuite and removing immediately thereafter.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/Makefile        |  5 +++++
 policy/test_nlmsg.te   | 34 ++++++++++++++++++++++++++++
 tests/Makefile         |  5 +++++
 tests/nlmsg/.gitignore |  1 +
 tests/nlmsg/Makefile   |  5 +++++
 tests/nlmsg/nlmsg.c    | 50 ++++++++++++++++++++++++++++++++++++++++++
 tests/nlmsg/test       | 28 +++++++++++++++++++++++
 7 files changed, 128 insertions(+)
 create mode 100644 policy/test_nlmsg.te
 create mode 100644 tests/nlmsg/.gitignore
 create mode 100644 tests/nlmsg/Makefile
 create mode 100644 tests/nlmsg/nlmsg.c
 create mode 100755 tests/nlmsg/test

diff --git a/policy/Makefile b/policy/Makefile
index f18e15d..32d7ede 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -158,6 +158,11 @@ TARGETS += test_userfaultfd.te
 endif
 endif
 
+# nlmsg test dependencies: policy >= 30, nlmsg permission, netlink_xperm capability
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && [ -f /sys/fs/selinux/class/netlink_route_socket/perms/nlmsg ] && grep -q 1 $(SELINUXFS)/policy_capabilities/netlink_xperm && echo true),true)
+TARGETS += test_nlmsg.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
diff --git a/policy/test_nlmsg.te b/policy/test_nlmsg.te
new file mode 100644
index 0000000..9e1e2a4
--- /dev/null
+++ b/policy/test_nlmsg.te
@@ -0,0 +1,34 @@
+########################################
+#
+# Policy for testing the nlmsg extended permissions.
+
+define(`RTM_GETLINK', `18')
+define(`RTM_SETLINK', `19')
+define(`RTM_GETADDR', `22')
+
+attribute nlmsgtestdomain;
+
+# Domain that is allowed the nlmsg extended permissions.
+type test_nlmsg_xperm_t;
+typeattribute test_nlmsg_xperm_t nlmsgtestdomain;
+testsuite_domain_type(test_nlmsg_xperm_t)
+allow test_nlmsg_xperm_t self:netlink_route_socket create_socket_perms;
+# Also allow the legacy nlmsg_read/write permissions to ensure no false positives.
+allow test_nlmsg_xperm_t self:netlink_route_socket { nlmsg nlmsg_read nlmsg_write };
+allowxperm test_nlmsg_xperm_t self:netlink_route_socket nlmsg { RTM_GETLINK RTM_SETLINK RTM_GETADDR };
+
+# Domain that is not allowed the nlmsg extended permissions.
+type test_nlmsg_noxperm_t;
+typeattribute test_nlmsg_noxperm_t nlmsgtestdomain;
+testsuite_domain_type(test_nlmsg_noxperm_t)
+allow test_nlmsg_noxperm_t self:netlink_route_socket create_socket_perms;
+# Also allow the legacy nlmsg_read/write permissions to ensure no false positives.
+allow test_nlmsg_noxperm_t self:netlink_route_socket { nlmsg nlmsg_read nlmsg_write };
+allowxperm test_nlmsg_noxperm_t self:netlink_route_socket nlmsg ~{ RTM_GETLINK RTM_SETLINK RTM_GETADDR };
+
+#
+# Common rules for all nlmsg test domains.
+#
+
+# Trigger kernel module auto-loading of the protocol implementations.
+kernel_request_load_module(nlmsgtestdomain)
diff --git a/tests/Makefile b/tests/Makefile
index db4cb38..35bb358 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -153,6 +153,11 @@ ifneq ($(shell ./kvercmp $$(uname -r) 6.5),-1)
 SUBDIRS += inet_socket/mptcp
 endif
 
+# nlmsg test dependencies: policy >= 30, nlmsg permission, netlink_xperm capability
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && [ -f /sys/fs/selinux/class/netlink_route_socket/perms/nlmsg ] && grep -q 1 $(SELINUXFS)/policy_capabilities/netlink_xperm && echo true),true)
+SUBDIRS += nlmsg
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/nlmsg/.gitignore b/tests/nlmsg/.gitignore
new file mode 100644
index 0000000..d4bea66
--- /dev/null
+++ b/tests/nlmsg/.gitignore
@@ -0,0 +1 @@
+nlmsg
diff --git a/tests/nlmsg/Makefile b/tests/nlmsg/Makefile
new file mode 100644
index 0000000..1edab98
--- /dev/null
+++ b/tests/nlmsg/Makefile
@@ -0,0 +1,5 @@
+TARGETS=nlmsg
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/nlmsg/nlmsg.c b/tests/nlmsg/nlmsg.c
new file mode 100644
index 0000000..a976b95
--- /dev/null
+++ b/tests/nlmsg/nlmsg.c
@@ -0,0 +1,50 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <asm/types.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+
+int main(int argc, char *argv[])
+{
+	int i, rc;
+	int fd;
+	unsigned char data[512];
+	struct nlmsghdr *nh[3];
+	struct sockaddr_nl sa;
+	struct iovec iov;
+	struct msghdr msg;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.nl_family = AF_NETLINK;
+
+	memset(data, 0, sizeof(data));
+	iov.iov_base = data;
+	iov.iov_len = 3 * NLMSG_SPACE(0);
+
+	for (i = 0; i < 3; i++) {
+		nh[i] = (struct nlmsghdr *)(data + (i * NLMSG_SPACE(0)));
+		nh[i]->nlmsg_len = NLMSG_HDRLEN;
+	}
+	nh[0]->nlmsg_type = RTM_GETLINK; // nlmsg_read
+	nh[1]->nlmsg_type = RTM_SETLINK; // nlmsg_write
+	nh[2]->nlmsg_type = RTM_GETADDR; // nlmsg_read
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_name = &sa;
+	msg.msg_namelen = sizeof(sa);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	rc = sendmsg(fd, &msg, 0);
+
+	if (rc < 0) {
+		perror("sendmsg");
+		exit(-1);
+	}
+	exit(0);
+}
+
diff --git a/tests/nlmsg/test b/tests/nlmsg/test
new file mode 100755
index 0000000..18bb794
--- /dev/null
+++ b/tests/nlmsg/test
@@ -0,0 +1,28 @@
+#!/usr/bin/perl
+#
+# This test exercises the netlink extended perms support
+#
+
+use Test;
+
+BEGIN {
+    $test_count = 2;
+    plan tests => $test_count;
+}
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+#
+# Attempt to send the netlink messages from the allowed domain.
+#
+$result = system "runcon -t test_nlmsg_xperm_t -- $basedir/nlmsg 2>&1";
+ok( $result, 0 );
+
+#
+# Attempt to send the netlink messages from the not-allowed domain.
+#
+$result = system "runcon -t test_nlmsg_noxperm_t -- $basedir/nlmsg 2>&1";
+ok($result);
+
+exit;
-- 
2.40.1

