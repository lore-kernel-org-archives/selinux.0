Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51E214A61
	for <selinux@vger.kernel.org>; Wed,  5 Feb 2025 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789198; cv=none; b=CqGuqQsMTfncQGyVIS5stK8Wsl1OKuHH3F8t13YftWvzrUy5QAIMww2Ff62Uahx7magqApdj93BN9vzrpOIe0O3rN8RfW+k2YCicp4H3BduMj5GMKnNg1I+QNkpe8PGkCg7RiV+upqEqi4Z6pGOuRETRtmHt+dyS4YDmPnEHL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789198; c=relaxed/simple;
	bh=mzgpe83V2l6GW9seL/xYKbhu8ppMGJ3jkfe00TU0Fp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ony1eahTM9kFoXDYoXYz5vINXLLaXTgwwYc+DQgNY6laCsfCkvMrYgzFkLZ3KNWSCwwwBDt7dpIgMWqLZcuxA2mm8trtXC1NhcD3sV67kYwv1+QPt54iRv7kIAXyjKHQ/Xdtw1r0i+X9TTJtrb7hj6kXVd16/PRiwcP2eb8k6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=kippndavis.work@gmx.com header.b=OvcRUqDL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=kippndavis.work@gmx.com header.b="OvcRUqDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738789189; x=1739393989; i=kippndavis.work@gmx.com;
	bh=KhJHE/w1d4pG9IspSoAHQsRWsUMzgj0MmQqe4MqDD8c=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OvcRUqDL1Xsa1dG5SeVp8Yw/1icIJa3NgP1ZO6i4+CmSOUvrpyDDhvYDOAGgFnX0
	 FlLrJxLE/Z+dV8rdC4KxvtO3JHKFmI0Zfqyijv48+fi6uYRMioOr2vjJC/aRrzNIG
	 jZSqqXqp20SYvjZZu7yf8fByllhA7hPtCblPovTjFhfp07dDP54g0k6v42yu43Kq8
	 ZLKfQlotUjZG+hSGXLBcF2Ag3em6eXizRgFqPaSctz5YSnbsHt4fOo7zx6fak8oKe
	 WELPrOgPxJI+sqX9bGHpZ3tnPMZMCL4e0C9LWm71NgTK2F09ZLFa5801lfeYuwekZ
	 BjLQuxIgns5fZdstjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ip-192-168-122-31.ec2.internal ([52.70.167.183]) by
 mail.gmx.net (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MRCOE-1u2nWy3Uay-00LXg4; Wed, 05 Feb 2025 21:59:49 +0100
From: kippndavis.work@gmx.com
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	stephen.smalley.work@gmail.com
Subject: [PATCH testsuite] policy,tests: add tests for new permissions for loading files/data
Date: Wed,  5 Feb 2025 15:59:40 -0500
Message-ID: <20250205205940.19527-1-kippndavis.work@gmx.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p83pcS4Avw0L0eNxSCr8HCa2Xky/eZBWVmFUj142HJWOn8OnLCU
 0XtoRbwH6sRZt08K8nx2To+arsKsetzOpbhuuaiwtFVauvRLtjrl/GNJj969InfX6ui26Ua
 3x6fSlmEL/he+rryji3DjSZtbrR0v1IVoxOjdrmsivC/B/JSnOX0Q/Yew+3mHapLwj41tei
 A1P1V/e7z5ExfhCC2mu3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FiBZ9/aF8Io=;4jeHcRwo9cv5dxSrgLmhjCESeCY
 l7HsC4zqUfQFZae6M4nF3PRw3PiXksD5nhroidjq70gSv2esWtBLRiRgjTp7N98hBfn/WAgap
 ONmPEuTFeUovD9c1xrvoHLxXidFHRIyFNUYOUMbVVmTfggOTDVK9qisPNLNw4ltfGFawIJjUs
 SMP9jf60LzTYvycxlJXY0spjGP84Jarh6VV95UVfZddc28q/H2lvUMu5xtZL5RfVzto+U1z0A
 1Bdb0pK91HL+CuQco+oLwHBJtZM8uiHn78JWVspwN3w0M7D6at1LdbgUarS9Cye3rSYPTmM47
 FJ3P1l2N6qelFa6lBWYp0d8ePpH8UBUFtrRYOI5LD035DDPZbC/gfmnce+WXt1jUR3gOKrHKv
 GoWRluLbjoBkjYCiIf7TdBVZrJN2fBT5PKq76QA27J0oT3c6+sAFi4LNLzY4Yb0eHTypoJk9f
 vFPhrAHzEL1Cum2zwTGNyaz4Oz1A0d8zIVrleQ+gtZyjr6lJ2Y1Iop+eoZGOTbo1YBlHse/Qe
 GRC38VHWyCQXpFXEqTBK2LXJK02QmSMNYQlq/PpEQzeLtOeT6nzyzavojqtj5a4bUPwuuUFRx
 zovldQjenmk+KKRUc4o8v71/Z1UXsvp/nNjzUAdBGYliNCVtQP21gjdwb7IJ8xuYO9gg7NHpk
 AefWeZ1iKjroiKXwJN+oEVGqj0NmHS5/nwZJWqzPiY7cItDakxhyDvffJXz7/4KbO83yB4xFc
 BSHfx2JJ7IJ0Wz/jW7BgpPCAdoZJh+rlVILka/HYXT6s1m6vn60/hpsKmYU365Vri1Mlrh63W
 lqvMd61HrmZdBvB1usmTJVzscNBotAURJ45DXDesZEo3Uj8ggSNNaA6TBJ+ehVyTmfsrHrSkR
 xH+jh1JSAXp+2GJZjC6s/qqxDn5aD+1+egIVIolz091eKFgrVg1pSgFzHUQyIViLYc0cqAfH3
 wCPqAo95kajTh3DirBgqmQG2tkeEpuH0WG3Pz0UWPuT7BKAaYtDLqji5F5petIWiFwE2w5XkY
 VMRRpxMrWi5X1/KltowlJmWnlGzsCw+DvA4U3LH9+hzkhhSyYE0LH34pLem5QJR5srbd1LXOO
 7rIYrCeX8VpUEMQ/RljfJBRnx3qTsv7D2lS/4014kIS98Y4RdmwsB4QimZRulAH+413bR845X
 suag9bSrCoH904/ulxNPQJIk31kYppU9wH5L+mjj8lNNn0/dNah9fGLV2Ks2WE13u9Fdp636p
 brCW+/ICz2k+gbo8wKLoC+MV4Ughp/tNDVaJ5qOf71PWX/w2Bwf5LjHn+scw63wHT+x8id8NJ
 PWeecVGr7CwDUU0sEDCRbK43d1T+YwgISS/on65p+42/LGIQx0anR6qo0DYLlg3LmJckPSgBo
 KKM0QJA1SK2GzLAs8SqpjSTf+Io6OFsJZiBDs+oD4NIaTOuDssYMtLk4eux0wmspMkISVa0ge
 C43Y1iA==

From: "Kipp N. Davis" <kippndavis.work@gmx.com>

These tests exercise new SELinux hooks for firmware_load, kexec_image_load=
,
kexec_initramfs_load, and policy_load alongside module_load. These tests
depend on the corresponding kernel patch and updating the base policy to
define the new system permissions. If the kernel does not support them,
they will be skipped.

For testing purposes, you can update the base policy by manually modifying
your base module and tweaking /usr/share/selinux/devel (latter only requir=
ed
due to writing the test policy as a .te file rather than as a .cil in orde=
r
to use the test macros) as follows:

    sudo semodule -c -E base
    sudo sed -i.orig \
    "s/module_load/module_load firmware_load kexec_image_load \
    kexec_initramfs_load policy_load x509_certificate_load/" base.cil
    sudo semodule -i base.cil
    sudo sed -i.orig \
    "s/module_load/module_load firmware_load kexec_image_load \
    kexec_initramfs_load policy_load x509_certificate_load/" \
    /usr/share/selinux/devel/include/support/all_perms.spt

When finished testing, you can sudo semodule -r base to undo the module
change and restore your all_perms.spt file from the saved .orig file.

Note: The x509_certificate_load permission is newly added in the kernel
but is not tested here due to no callers remaining after boot.

Signed-off-by: Kipp Davis <kippndavis.work@gmx.com>
=2D--
 policy/Makefile                          |   8 ++
 policy/test_file_load.te                 | 102 +++++++++++++++++++++++
 tests/module_load/Makefile               |   2 +-
 tests/module_load/setest_firmware_load.c |  29 +++++++
 tests/module_load/test                   |  70 +++++++++++++++-
 5 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_file_load.te
 create mode 100644 tests/module_load/setest_firmware_load.c

diff --git a/policy/Makefile b/policy/Makefile
index 46e51f3..fcc80f0 100644
=2D-- a/policy/Makefile
+++ b/policy/Makefile
@@ -180,6 +180,14 @@ ifeq ($(shell [ $(POL_VERS) -ge 34 -a $(MAX_KERNEL_PO=
LICY) -ge 34 ] && echo true
 TARGETS +=3D test_ioctl_cond_xperms.te
 endif

+ifeq ($(shell grep -q firmware_load $(POLDEV)/include/support/all_perms.s=
pt && \
+             grep -q kexec_image_load $(POLDEV)/include/support/all_perms=
.spt && \
+             grep -q kexec_initramfs_load $(POLDEV)/include/support/all_p=
erms.spt && \
+             grep -q policy_load $(POLDEV)/include/support/all_perms.spt =
&& \
+             echo true),true)
+TARGETS +=3D test_file_load.te
+endif
+
 all: build

 expand_check:
diff --git a/policy/test_file_load.te b/policy/test_file_load.te
new file mode 100644
index 0000000..e98503a
=2D-- /dev/null
+++ b/policy/test_file_load.te
@@ -0,0 +1,102 @@
+###################### Test file loading ###################
+
+require {
+    type boot_t;
+    type kdump_exec_t;
+    type tmpfs_t;
+    type user_tmp_t;
+}
+
+###################### Allow sys kexec_image_load ######################
+type test_kexec_allow_kexec_image_load_t;
+testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t);
+
+files_search_boot(test_kexec_allow_kexec_image_load_t);
+fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t);
+exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, kdu=
mp_exec_t);
+domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t);
+allow test_kexec_allow_kexec_image_load_t self:capability sys_boot;
+
+allow test_kexec_allow_kexec_image_load_t boot_t:system  kexec_image_load=
;
+allow test_kexec_allow_kexec_image_load_t tmpfs_t:system kexec_image_load=
;
+
+###################### Deny sys kexec_image_load ######################
+type test_kexec_deny_kexec_image_load_t;
+testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t);
+
+files_search_boot(test_kexec_deny_kexec_image_load_t);
+fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t);
+exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, kdum=
p_exec_t);
+domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t);
+allow test_kexec_deny_kexec_image_load_t self:capability sys_boot;
+
+neverallow test_kexec_deny_kexec_image_load_t boot_t:system  kexec_image_=
load;
+neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:system kexec_image_=
load;
+
+###################### Allow sys kexec_initramfs_load ###################=
###
+type test_kexec_allow_kexec_initramfs_load_t;
+testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t);
+
+files_search_boot(test_kexec_allow_kexec_initramfs_load_t);
+fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t);
+domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t);
+allow test_kexec_allow_kexec_initramfs_load_t  self:capability sys_boot;
+
+allow test_kexec_allow_kexec_initramfs_load_t  boot_t:system  { kexec_ima=
ge_load kexec_initramfs_load } ;
+allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:system { kexec_ima=
ge_load kexec_initramfs_load };
+
+###################### Deny sys kexec_initramfs_load ####################=
##
+type test_kexec_deny_kexec_initramfs_load_t;
+testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t);
+
+files_search_boot(test_kexec_deny_kexec_initramfs_load_t);
+fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t);
+domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t);
+allow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_image_l=
oad;
+allow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_image_l=
oad;
+allow test_kexec_deny_kexec_initramfs_load_t self:capability sys_boot;
+
+neverallow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_in=
itramfs_load;
+neverallow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_in=
itramfs_load;
+
+###################### Allow sys firmware_load ######################
+type test_kmodule_allow_firmware_load_t;
+testsuite_domain_type_minimal(test_kmodule_allow_firmware_load_t)
+typeattribute test_kmodule_allow_firmware_load_t kmoduledomain;
+
+type firmware_allow_file_t;
+files_type(firmware_allow_file_t);
+
+allow test_kmodule_allow_firmware_load_t self:capability sys_module;
+allow test_kmodule_allow_firmware_load_t test_file_t:system module_load;
+allow test_kmodule_allow_firmware_load_t self:system module_load;
+allow kernel_t firmware_allow_file_t:system firmware_load;
+
+###################### Deny sys firmware_load ######################
+type test_kmodule_deny_firmware_load_t;
+testsuite_domain_type_minimal(test_kmodule_deny_firmware_load_t)
+typeattribute test_kmodule_deny_firmware_load_t kmoduledomain;
+
+type firmware_deny_file_t;
+files_type(firmware_deny_file_t);
+
+allow test_kmodule_deny_firmware_load_t self:capability { sys_module };
+allow test_kmodule_deny_firmware_load_t test_file_t:system { module_load =
};
+allow test_kmodule_deny_firmware_load_t self:system { module_load };
+neverallow kernel_t firmware_deny_file_t:system firmware_load;
+
+###################### Allow sys policy_load ######################
+type test_policy_allow_policy_load_t;
+testsuite_domain_type_minimal(test_policy_allow_policy_load_t);
+
+userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t);
+userdom_write_user_tmp_files(test_policy_allow_policy_load_t);
+allow test_policy_allow_policy_load_t user_tmp_t:system policy_load;
+
+###################### Deny sys policy_load ######################
+type test_policy_deny_policy_load_t;
+testsuite_domain_type_minimal(test_policy_deny_policy_load_t);
+
+userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t);
+userdom_write_user_tmp_files(test_policy_deny_policy_load_t);
+neverallow test_policy_deny_policy_load_t user_tmp_t:system policy_load;
diff --git a/tests/module_load/Makefile b/tests/module_load/Makefile
index 0839532..fc93aec 100644
=2D-- a/tests/module_load/Makefile
+++ b/tests/module_load/Makefile
@@ -1,4 +1,4 @@
-obj-m =3D setest_module_load.o setest_module_request.o
+obj-m =3D setest_module_load.o setest_module_request.o setest_firmware_lo=
ad.o

 TARGETS =3D finit_load init_load
 LDLIBS +=3D -lselinux
diff --git a/tests/module_load/setest_firmware_load.c b/tests/module_load/=
setest_firmware_load.c
new file mode 100644
index 0000000..d67470b
=2D-- /dev/null
+++ b/tests/module_load/setest_firmware_load.c
@@ -0,0 +1,29 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/firmware.h>
+
+static int __init setest_firmware_request_init(void)
+{
+	const struct firmware *fw;
+	int result;
+
+	pr_info("INIT - setest_firmware_request\n");
+	result =3D request_firmware(&fw, "dummy-firmware", NULL);
+	if (result) {
+		pr_err("request_firmware failed: %d\n", result);
+		return result;
+	}
+	pr_info("request_firmware succeeded\n");
+	release_firmware(fw);
+	return 0;
+}
+
+static void __exit setest_firmware_request_exit(void)
+{
+	pr_info("EXIT - setest_firmware_request\n");
+}
+
+module_init(setest_firmware_request_init);
+module_exit(setest_firmware_request_exit);
+MODULE_LICENSE("GPL");
\ No newline at end of file
diff --git a/tests/module_load/test b/tests/module_load/test
index 524b333..98c5946 100755
=2D-- a/tests/module_load/test
+++ b/tests/module_load/test
@@ -16,7 +16,13 @@ BEGIN {
         $v =3D " ";
     }

-    plan tests =3D> 8;
+    $kexec_perm_file   =3D "/sys/fs/selinux/class/system/perms/kexec_imag=
e_load";
+    $kexec_load_exists =3D 0;
+    if ( -f $kexec_perm_file ) {
+        $kexec_load_exists =3D 1;
+    }
+
+    plan tests =3D> 17;
 }

 print "Test finit_module(2)\n";
@@ -59,4 +65,66 @@ $result =3D system
 "runcon -t test_kmodule_deny_module_request_t $basedir/init_load $v $base=
dir setest_module_request 2>&1";
 ok( $result >> 8 eq 13 );

+SKIP: {
+    skip(
+"Not all system permissions available; skipping kexec, initramfs, firmwar=
e and policy tests",
+        9
+    ) unless $kexec_load_exists;
+
+    $kver =3D `uname -r`;
+    chomp($kver);
+    $kernel =3D "/boot/vmlinuz-$kver";
+    $initrd =3D "/boot/initramfs-$kver.img";
+
+    $result =3D
+      system "runcon -t test_kexec_allow_kexec_image_load_t kexec -l $ker=
nel";
+    ok( $result eq 0 );
+
+    $result =3D system "runcon -t test_kexec_allow_kexec_image_load_t kex=
ec -u";
+    ok( $result eq 0 );
+
+    # Deny system { kexec_image_load }
+    $result =3D system
+      "runcon -t test_kexec_deny_kexec_image_load_t kexec -l $kernel 2>&1=
";
+    ok( $result >> 8 eq 255 );
+
+    $result =3D system
+"runcon -t test_kexec_allow_kexec_initramfs_load_t kexec -l --initrd=3D$i=
nitrd $kernel";
+    ok( $result eq 0 );
+
+    # Deny system { kexec_initramfs_load }
+    $result =3D system
+"runcon -t test_kexec_deny_kexec_initramfs_load_t kexec -l --initrd=3D$in=
itrd $kernel 2>&1";
+    ok( $result >> 8 eq 255 );
+
+    system("mkdir -p /usr/lib/firmware");
+    system("echo 'Test firmware' > /usr/lib/firmware/dummy-firmware");
+    system("chcon -t firmware_allow_file_t /usr/lib/firmware/dummy-firmwa=
re");
+
+    $result =3D system
+"runcon -t test_kmodule_allow_firmware_load_t $basedir/init_load $v $base=
dir setest_firmware_load";
+    ok( $result eq 0 );
+
+    system("chcon -t firmware_deny_file_t /usr/lib/firmware/dummy-firmwar=
e");
+
+    # Deny system { firmware_load } - EACCES
+    $result =3D system
+"runcon -t test_kmodule_deny_firmware_load_t $basedir/init_load $v $based=
ir setest_firmware_load 2>&1";
+    ok( $result >> 8 eq 13 );
+
+    system("rm -f /usr/lib/firmware/dummy-firmware");
+    system("echo 'measure func=3DBPRM_CHECK' > /tmp/test_ima_policy");
+
+    $result =3D system
+qq(runcon -t test_policy_allow_policy_load_t bash -c "echo '/tmp/test_ima=
_policy' > /sys/kernel/security/ima/policy");
+    ok( $result eq 0 );
+
+    # Deny system { policy_load } - EACCES
+    $result =3D system
+qq(runcon -t test_policy_deny_policy_load_t bash -c "echo '/tmp/test_ima_=
policy' > /sys/kernel/security/ima/policy 2>&1");
+    ok( $result >> 8 eq 1 );
+
+    system("rm -f /tmp/test_ima_policy");
+}
+
 exit;
=2D-
2.48.1

