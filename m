Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E6C43612
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACFE222FE
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfAETiN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:38:13 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:51019 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAETiN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 14:38:13 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3F4155647FA
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 20:38:10 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/5] python/audit2allow: make the tests useful again
Date:   Sat,  5 Jan 2019 20:37:56 +0100
Message-Id: <20190105193759.3333-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105193759.3333-1-nicolas.iooss@m4x.org>
References: <20190105193759.3333-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 20:38:10 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

audit2allow testsuite requires a system which uses SELinux with a MLS
policy. This is a lot to ask for a continuous integretation system.
Thankfully this can be worked around by using option -p to run the tools
with a specific configuration. Doing this, the testsuite can even be run
on a system without SELinux.

This approach requires building a custom policy for parsing test.log.
Add a minimal policy written in CIL for this need.

While at it:
* Do not invoke "sudo sepolgen-ifgen" but produce a file in a writable
  directory (instead of /var/lib/sepolgen/interface_info)
* Use sys.executable instead of 'python', in order to really test
  python3 and python2 when calling the test script with one of these
  interpreters.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/audit2allow/.gitignore            |  1 +
 python/audit2allow/Makefile              |  8 ++-
 python/audit2allow/test_audit2allow.py   | 16 +++--
 python/audit2allow/test_dummy_policy.cil | 75 ++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 7 deletions(-)
 create mode 100644 python/audit2allow/test_dummy_policy.cil

diff --git a/python/audit2allow/.gitignore b/python/audit2allow/.gitignore
index 3816d2e0e6ea..2cd46afd0fe7 100644
--- a/python/audit2allow/.gitignore
+++ b/python/audit2allow/.gitignore
@@ -1 +1,2 @@
 sepolgen-ifgen-attr-helper
+test_dummy_policy
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 513bb2b6252a..06fc3b692136 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -1,4 +1,5 @@
 PYTHON ?= python
+SECILC ?= secilc
 
 # Installation directories.
 PREFIX ?= /usr
@@ -22,9 +23,12 @@ sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
 audit2why:
 	ln -sf audit2allow audit2why
 
-test: all
+test: all test_dummy_policy
 	@$(PYTHON) test_audit2allow.py -v
 
+test_dummy_policy: test_dummy_policy.cil
+	$(SECILC) -o $@ -f /dev/null $<
+
 install: all
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	install -m 755 audit2allow $(DESTDIR)$(BINDIR)
@@ -36,7 +40,7 @@ install: all
 	install -m 644 audit2why.1 $(DESTDIR)$(MANDIR)/man1/
 
 clean:
-	rm -f *~ *.o sepolgen-ifgen-attr-helper
+	rm -f *~ *.o sepolgen-ifgen-attr-helper test_dummy_policy
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])
diff --git a/python/audit2allow/test_audit2allow.py b/python/audit2allow/test_audit2allow.py
index 4427dea763b2..0320c6dd5c1b 100644
--- a/python/audit2allow/test_audit2allow.py
+++ b/python/audit2allow/test_audit2allow.py
@@ -1,6 +1,7 @@
 import unittest
 import os
-import shutil
+import os.path
+import sys
 from tempfile import mkdtemp
 from subprocess import Popen, PIPE
 
@@ -25,15 +26,19 @@ class Audit2allowTests(unittest.TestCase):
 
     def test_sepolgen_ifgen(self):
         "Verify sepolgen-ifgen works"
-        p = Popen(['sudo', 'sepolgen-ifgen'], stdout=PIPE)
+        temp_directory = mkdtemp(suffix='audit2allow_test')
+        output_file = os.path.join(temp_directory, 'interface_info')
+        p = Popen([sys.executable, './sepolgen-ifgen', '-p', 'test_dummy_policy', '-o', output_file], stdout=PIPE)
         out, err = p.communicate()
         if err:
             print(out, err)
         self.assertSuccess("sepolgen-ifgen", p.returncode, err)
+        os.unlink(output_file)
+        os.rmdir(temp_directory)
 
     def test_audit2allow(self):
         "Verify audit2allow works"
-        p = Popen(['python', './audit2allow', "-i", "test.log"], stdout=PIPE)
+        p = Popen([sys.executable, './audit2allow', '-p', 'test_dummy_policy', '-i', 'test.log'], stdout=PIPE)
         out, err = p.communicate()
         if err:
             print(out, err)
@@ -41,7 +46,7 @@ class Audit2allowTests(unittest.TestCase):
 
     def test_audit2why(self):
         "Verify audit2why works"
-        p = Popen(['python', './audit2why', "-i", "test.log"], stdout=PIPE)
+        p = Popen([sys.executable, './audit2why', '-p', 'test_dummy_policy', '-i', 'test.log'], stdout=PIPE)
         out, err = p.communicate()
         if err:
             print(out, err)
@@ -49,12 +54,13 @@ class Audit2allowTests(unittest.TestCase):
 
     def test_xperms(self):
         "Verify that xperms generation works"
-        p = Popen(['python', './audit2allow', "-x", "-i", "test.log"], stdout=PIPE)
+        p = Popen([sys.executable, './audit2allow', '-x', '-p', 'test_dummy_policy', '-i', 'test.log'], stdout=PIPE)
         out, err = p.communicate()
         if err:
             print(out, err)
         self.assertTrue(b"allowxperm" in out)
         self.assertSuccess("xperms", p.returncode, err)
 
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/python/audit2allow/test_dummy_policy.cil b/python/audit2allow/test_dummy_policy.cil
new file mode 100644
index 000000000000..795fedc3e746
--- /dev/null
+++ b/python/audit2allow/test_dummy_policy.cil
@@ -0,0 +1,75 @@
+; This is a dummy policy which main aim is to be compatible with test.log
+
+; Define one category and one sensitivity in order to make things work
+(mls true)
+(category c0)
+(categoryorder (c0))
+(sensitivity s0)
+(sensitivityorder (s0))
+(sensitivitycategory s0 (c0))
+
+; Define some users and roles
+(user system_u)
+(user root)
+(user unconfined_u)
+(role system_r)
+(role unconfined_r)
+(userrole root system_r)
+(userrole system_u system_r)
+(userrole unconfined_u unconfined_r)
+(userlevel system_u (s0))
+(userlevel root (s0))
+(userlevel unconfined_u (s0))
+(userrange system_u ((s0)(s0 (c0))))
+(userrange root ((s0)(s0 (c0))))
+(userrange unconfined_u ((s0)(s0 (c0))))
+
+; Define domain types
+(type automount_t)
+(type ftpd_t)
+(type httpd_t)
+(type kernel_t)
+(type nsplugin_t)
+(type postfix_local_t)
+(type qemu_t)
+(type smbd_t)
+
+(roletype system_r automount_t)
+(roletype system_r ftpd_t)
+(roletype system_r httpd_t)
+(roletype system_r kernel_t)
+(roletype system_r postfix_local_t)
+(roletype system_r qemu_t)
+(roletype system_r smbd_t)
+(roletype unconfined_r nsplugin_t)
+
+; Define file types
+(type automount_lock_t)
+(type default_t)
+(type fixed_disk_device_t)
+(type home_root_t)
+(type httpd_sys_content_t)
+(type httpd_sys_script_exec_t)
+(type mail_spool_t)
+(type ssh_home_t)
+(type usr_t)
+(type var_t)
+
+; Define port types
+(type mysqld_port_t)
+(type reserved_port_t)
+
+; Define initial SID
+(sid kernel)
+(sidorder (kernel))
+(sidcontext kernel (system_u system_r kernel_t ((s0) (s0))))
+
+; Define classes
+(class blk_file (getattr open read write))
+(class dir (append open search))
+(class file (execute execute_no_trans getattr open read write))
+(class tcp_socket (ioctl name_bind name_connect))
+(classorder (blk_file file dir tcp_socket))
+
+; The policy compiler requires at least one rule
+(allow kernel_t default_t (file (open read write)))
-- 
2.20.1

