Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596549;
	b=HnRaktRHCCj6FHUaftiymHnW4Pg0n+0e6QoOtlEWfBBsERq+OQAUbIBaAwUTBDHmZh6C
	 ILFPIZq2mU3vj9R4Hj0jYlwFpWCvfLunSZGmMoAczyhxeOeOlYB4+ZAXI9TJ6zL2AWaOs
	 91yMuy5jZ3qJ1K0HYJgL6bWYTsu0wrFgKo3I6nEWhYbqsa9JVuSN08Pm07PiHFgXI75ME
	 Pi60W4F0vKgpW4i/XarKTfxJ2M/ikP+T521lAv9tbo+SvpOemDXHrOvWVdHvnIcNotmb8
	 3GHs5Iq4wZPI9yBIsaJallp/y8ryT+O5rB0535ULWv4ByW69L6SSrOIBjTXpVLe0a3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596549;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key:
	 X-Scanned-By;
	bh=RA8e29v2UfOX+j0RunaRG7R7vpt/VitAFtYaEN+ZJyA=;
	b=JmztxJeld9Injan20NkjqdcG2GDMtIHcVn/nLOXz9XSSFX9QwnIi66PaGVEGiWZNLHbh
	 zftkx2og3HiH7InLh4LUzBqjBtIk9HLP5ltlrWWMqbWilVuyg+KVvjitIEkznDi92zyJ+
	 iQBO9d3/IFjquiGqgDOXrtRsyqfLkjtKn8fA8Ym8mopwstt0dftvI37oBn7E+NgdxwF+Z
	 o83mru/paVW90LDmrce4ghvqYfRDDpvQZUDGWXE7OLzcO3X5PNqVss6a32z6AK3MibWuF
	 8IKmkOI8AaS3hmwlOS0769F9DM0zwCYHFGFKu8G0qsu6Gc+70nzLoz47IP6clCRk4aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lun7m7FM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CC606A338
	for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 08:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239CC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lun7m7FM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795596548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RA8e29v2UfOX+j0RunaRG7R7vpt/VitAFtYaEN+ZJyA=;
	b=Lun7m7FMhulgy3wbJ48+U4dhIZSFPL0c76Xdcmbmi1dni9QIsM5yvisV8ViJW1HfwgFNNC
	4p3yfliNp+qnBfoFXNs2BmPczlwdkdOYPH3SgQDVqBxv0ZYF/e2Bx9yvcIMUqCUfdW38rr
	EASq4e2Z4oAZauGbBhyBvl/HD5Rz0qg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-8ogqmfRiNQGvr3AWRp9XFw-1; Wed,
 25 Nov 2026 08:49:04 +0000
X-MC-Unique: 8ogqmfRiNQGvr3AWRp9XFw-1
X-Mimecast-MFC-AGG-ID: 8ogqmfRiNQGvr3AWRp9XFw_1795596543
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1057018004FE;
	Wed, 25 Nov 2026 08:49:03 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1B191800550;
	Wed, 25 Nov 2026 08:49:01 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 25 Nov 2026 09:48:59 +0100
Subject: [PATCH] policy,tests: add tests for cgroup charge_to
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-cgroup-transfer-test-v1-1-91f58dc62073@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz7VEQolQr1J1IImhZgjIDggJc
 XdCO77h/wOUhEnhVR0gtLHynArMo4Lw7dNIyLEYbG2dMbbFMMq8LpilTzqQYCbN6HzrusbHWLs
 nlHQRGnj/bd+fv3X1E4V8v+A8L6qmZpN4AAAA
X-Change-ID: 20261125-cgroup-transfer-test-6b5683bdd064
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795596539; l=10600;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=YXDrG9jxDZPQPTfkHUdGjpXOcjorsRyHTwIBM77ZpLs=;
 b=7xzhrsNikiTh+rU+QETK69v+yTAKx1Je8GMgZyc3I4IJ0RQI8TGcXXt0uxAQ958XHErSVfUmP
 T+wTfE2lEDvB2/wPGbF4M2x0XT+w+KwUwNnSvlZ7TgjWblvVvSF1bFU
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Test the cgroup:charge_to permission added by the dma-buf memcg
accounting series [1], for both charge_fd flavours (pidfd and cgroupfd),
negative and positive tests, including a default-labeled (genfscon) and
an xattr-relabeled cgroup.

The class is new, so the base policy has to be taught about it first:

  semodule -c -E base
  echo '(class cgroup (charge_to))' >> base.cil
  perl -0pi -e \
    's/\(classorder\s*\((.*?)\)\)/(classorder ($1 cgroup))/s' base.cil
  semodule -X 456 -i base.cil

AI agent helped with policy file and reviews.

[1] https://lore.kernel.org/all/20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com

Assisted-by: Claude Code:deepseek-v4.1-flash
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 defconfig                     |   6 +++
 policy/Makefile               |   6 +++
 policy/test_memcg_charge.te   |  50 ++++++++++++++++++++
 tests/Makefile                |   5 ++
 tests/memcg_charge/.gitignore |   1 +
 tests/memcg_charge/Makefile   |   5 ++
 tests/memcg_charge/charge.c   | 106 ++++++++++++++++++++++++++++++++++++++++++
 tests/memcg_charge/test       |  76 ++++++++++++++++++++++++++++++
 8 files changed, 255 insertions(+)

diff --git a/defconfig b/defconfig
index 3dcf710..67f3515 100644
--- a/defconfig
+++ b/defconfig
@@ -94,6 +94,12 @@ CONFIG_NET_KEY=m
 # This is not required for SELinux operation itself.
 CONFIG_TUN=m
 
+# Test the cgroup charge_to checks
+# They are not required for SELinux operation itself.
+CONFIG_MEMCG=y
+CONFIG_DMABUF_HEAPS=y
+CONFIG_DMABUF_HEAPS_SYSTEM=y
+
 # Test perf events.
 # This is not required for SELinux operation itself.
 CONFIG_HAVE_PERF_EVENTS=y
diff --git a/policy/Makefile b/policy/Makefile
index 012199a..262fb7c 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -212,6 +212,12 @@ export M4PARAM += -Dio_uring_allowed_defined
 endif
 endif
 
+# memcg_charge test dependencies: charge_to on the cgroup class, in the
+# loaded policy (or the policy headers when building without selinuxfs).
+ifeq ($(shell if [ -e $(SELINUXFS)/policyvers ]; then [ -f $(SELINUXFS)/class/cgroup/perms/charge_to ]; else grep -q all_cgroup_perms.*charge_to $(POLDEV)/include/support/all_perms.spt; fi && grep -q dev_rw_dma_dev $(POLDEV)/include/kernel/devices.if && echo true),true)
+TARGETS += test_memcg_charge.te
+endif
+
 .PHONY: all build clean expand_check load unload
 
 all: build
diff --git a/policy/test_memcg_charge.te b/policy/test_memcg_charge.te
new file mode 100644
index 0000000..a0614dc
--- /dev/null
+++ b/policy/test_memcg_charge.te
@@ -0,0 +1,50 @@
+########################################
+#
+# Policy for testing the dma-buf memcg charge controls.
+
+attribute memcg_chargetestdomain;
+
+# Label of the xattr-relabeled cgroup directory.
+type test_memcg_cgroup_t;
+files_type(test_memcg_cgroup_t)
+fs_associate_cgroupfs(test_memcg_cgroup_t)
+
+require {
+	type cgroup_t;
+	class cgroup { charge_to };
+}
+
+#
+# memcg_charge_test_domain(domain)
+#
+# Generate a test domain that can open the dma-heap and reach the
+# cgroup directories, but is not allowed charge_to.
+#
+define(`memcg_charge_test_domain', `
+type $1;
+testsuite_domain_type($1)
+typeattribute $1 memcg_chargetestdomain;
+')
+
+dev_rw_dma_dev(memcg_chargetestdomain)
+fs_search_cgroup_dirs(memcg_chargetestdomain)
+
+# Reaching the cgroup directories is not what is being tested.
+allow memcg_chargetestdomain cgroup_t:dir list_dir_perms;
+allow memcg_chargetestdomain test_memcg_cgroup_t:dir list_dir_perms;
+
+# pidfd: checked against the target process SID.
+memcg_charge_test_domain(test_memcg_charge_task_t)
+allow test_memcg_charge_task_t self:cgroup charge_to;
+
+memcg_charge_test_domain(test_memcg_nocharge_task_t)
+
+# cgroupfd: checked against the cgroup label.
+memcg_charge_test_domain(test_memcg_charge_cgroup_t)
+allow test_memcg_charge_cgroup_t cgroup_t:cgroup charge_to;
+
+memcg_charge_test_domain(test_memcg_nocharge_cgroup_t)
+
+# Same, with the label in the security.selinux xattr.
+memcg_charge_test_domain(test_memcg_charge_xattr_t)
+allow test_memcg_charge_xattr_t test_memcg_cgroup_t:cgroup charge_to;
diff --git a/tests/Makefile b/tests/Makefile
index 4c8e82b..e9da52b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -186,6 +186,11 @@ SUBDIRS += io_uring
 endif
 endif
 
+# memcg_charge test dependencies: charge_to on the cgroup class in the loaded policy
+ifeq ($(shell [ -f $(SELINUXFS)/class/cgroup/perms/charge_to ] && grep -qs charge_fd $(INCLUDEDIR)/linux/dma-heap.h && echo true),true)
+SUBDIRS += memcg_charge
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/memcg_charge/.gitignore b/tests/memcg_charge/.gitignore
new file mode 100644
index 0000000..e78f0d8
--- /dev/null
+++ b/tests/memcg_charge/.gitignore
@@ -0,0 +1 @@
+charge
diff --git a/tests/memcg_charge/Makefile b/tests/memcg_charge/Makefile
new file mode 100644
index 0000000..0b48692
--- /dev/null
+++ b/tests/memcg_charge/Makefile
@@ -0,0 +1,5 @@
+TARGETS=charge
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/memcg_charge/charge.c b/tests/memcg_charge/charge.c
new file mode 100644
index 0000000..dd6d027
--- /dev/null
+++ b/tests/memcg_charge/charge.c
@@ -0,0 +1,106 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <linux/dma-heap.h>
+
+#define HEAP "/dev/dma_heap/system"
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open 434
+#endif
+
+/*
+ * Returns 0 on success, -1 if the heap cannot be opened, otherwise
+ * the errno of the failing ioctl.
+ */
+static int alloc_charged(int charge_fd)
+{
+	struct dma_heap_allocation_data data = {
+		.len = 4096,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+		.charge_fd = charge_fd,
+	};
+	int heap_fd, err;
+
+	heap_fd = open(HEAP, O_RDWR | O_CLOEXEC);
+	if (heap_fd < 0) {
+		perror("open " HEAP);
+		return -1;
+	}
+
+	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &data) < 0) {
+		err = errno;
+		perror("DMA_HEAP_IOCTL_ALLOC");
+		close(heap_fd);
+		return err;
+	}
+
+	close(data.fd);
+	close(heap_fd);
+	return 0;
+}
+
+/* Returns 0 if allowed, 2 if denied (EACCES), 1 otherwise. */
+static int status(int err)
+{
+	if (!err)
+		return 0;
+	return err == EACCES ? 2 : 1;
+}
+
+static void print_usage(char *progname)
+{
+	fprintf(stderr, "Usage: %s probe | pid | cgroup <dir>\n", progname);
+	exit(1);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd, err;
+
+	if (argc < 2 || argc > 3) {
+		print_usage(argv[0]);
+	}
+
+	if (argc == 2 && strcmp(argv[1], "probe") == 0) {
+		/*
+		 * A kernel without charge_fd support ignores the field and the
+		 * allocation succeeds. One that has it rejects an fd that is
+		 * neither a pidfd nor a cgroupfd.
+		 */
+		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+		if (fd < 0) {
+			perror("/dev/null");
+			exit(1);
+		}
+		exit(alloc_charged(fd) == EBADF ? 0 : 1);
+	}
+
+	if (argc == 2 && strcmp(argv[1], "pid") == 0) {
+		fd = syscall(__NR_pidfd_open, getpid(), 0);
+		if (fd < 0) {
+			perror("pidfd_open");
+			exit(1);
+		}
+	} else if (argc == 3 && strcmp(argv[1], "cgroup") == 0) {
+		fd = open(argv[2], O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd < 0) {
+			perror(argv[2]);
+			exit(1);
+		}
+	} else {
+		print_usage(argv[0]);
+	}
+
+	err = alloc_charged(fd);
+	close(fd);
+	exit(status(err));
+}
diff --git a/tests/memcg_charge/test b/tests/memcg_charge/test
new file mode 100755
index 0000000..205e353
--- /dev/null
+++ b/tests/memcg_charge/test
@@ -0,0 +1,76 @@
+#!/usr/bin/perl
+
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    if ( !-e "/sys/fs/cgroup/cgroup.controllers" ) {
+        plan skip_all => "cgroup v2 unified hierarchy not mounted";
+    }
+    elsif ( system("$basedir/charge probe >/dev/null 2>&1") != 0 ) {
+        plan skip_all => "kernel does not validate dma-heap charge_fd";
+    }
+    elsif (
+        system(
+            "echo +memory > /sys/fs/cgroup/cgroup.subtree_control 2>/dev/null")
+        != 0
+      )
+    {
+        plan skip_all => "memory controller not enabled in the cgroup root";
+    }
+    else {
+        plan tests => 6;
+    }
+}
+
+my $root  = "/sys/fs/cgroup";
+my $dflt  = "$root/selinuxtest_memcg_default";
+my $xattr = "$root/selinuxtest_memcg_xattr";
+
+# Charge to our own process (pidfd): checked with cgroup:charge_to on the
+# target process SID.
+sub charge_pid {
+    my ($domain) = @_;
+    return system("runcon -t $domain -- $basedir/charge pid 2>&1") >> 8;
+}
+
+# Charge to a cgroup (cgroupfd): checked with cgroup:charge_to on its label.
+sub charge_cgroup {
+    my ( $domain, $cg ) = @_;
+    my $join = "echo \$\$ > $cg/cgroup.procs";
+    my $run  = "exec runcon -t $domain -- $basedir/charge cgroup $cg";
+    return system("sh -c '$join && $run' 2>&1") >> 8;
+}
+
+# One cgroup keeps the default label (genfscon), the other is relabeled
+# through the security.selinux xattr.
+mkdir($dflt);
+mkdir($xattr);
+system("chcon -t test_memcg_cgroup_t $xattr");
+
+$result = charge_pid("test_memcg_charge_task_t");
+ok( $result eq 0, "charge to a pidfd with cgroup:charge_to" );
+
+$result = charge_pid("test_memcg_nocharge_task_t");
+ok( $result eq 2, "charge to a pidfd without cgroup:charge_to" );
+
+$result = charge_cgroup( "test_memcg_charge_cgroup_t", $dflt );
+ok( $result eq 0, "charge to a default-labeled cgroup with cgroup:charge_to" );
+
+$result = charge_cgroup( "test_memcg_nocharge_cgroup_t", $dflt );
+ok( $result eq 2,
+    "charge to a default-labeled cgroup without cgroup:charge_to" );
+
+$result = charge_cgroup( "test_memcg_charge_xattr_t", $xattr );
+ok( $result eq 0, "charge to a relabeled cgroup with cgroup:charge_to" );
+
+$result = charge_cgroup( "test_memcg_charge_cgroup_t", $xattr );
+ok( $result eq 2, "charge to a relabeled cgroup allowed for another label" );
+
+# Cleanup.
+rmdir($xattr);
+rmdir($dflt);
+
+exit;

---
base-commit: 459fc1c7f460a712d7aa4ee19ff31d4d3ae193c9
change-id: 20261125-cgroup-transfer-test-6b5683bdd064

Best regards,
--  
Albert Esteve <aesteve@redhat.com>

