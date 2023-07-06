Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31BCEB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 15:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGFPlT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFPlS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 11:41:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F2F171D
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 08:41:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d9695ec29so1176715a12.1
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688658073; x=1691250073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8rj38NpTFwrTtiUFG/O8reLxJk/UrrjVw/gNwpPies=;
        b=k698PuiqDqTiIuAFmX6R68W5XUMwDZZS0B4BzpY03G6V8aL7S2lvVrYxK0atxgzRNv
         cDUAx+FhSTzaeIhWkI/w14ys34hHFbUCdd53GSYKGRCOTQVxVDKmRs7HEmliU/BwEnB0
         IU1A43FSoMFkpjiGwy0dxwHapFKPqeg98IAw9HH1faXHc4U91YGEttc+Qmp70lTdBGCX
         0XRda3Fk1R9AIxm2J5jmiDwi0bC4bLqzAJ6vI0NA0nMbFXvB/5esF6PHSpF5BMajMg/k
         3ybVu4HZE0S3QX3yzgzz+jksdS8KpyZswjLl7VU1/hkNgcXvUhXOu4RDCRE/NrS02kx4
         8WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688658073; x=1691250073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8rj38NpTFwrTtiUFG/O8reLxJk/UrrjVw/gNwpPies=;
        b=jp1MGHKGS+Qv398hm5g6cJ6JNg5tw9wFb2tnFFSNea1x2P4hHwJm8Xp+CEbcibPjJw
         5r3EiunJmP9t0lM5IJGtyb2Mpn2RX1D2CqiPLzyyu0v4hTHtUcDPC9LCXtJm57PW4G+j
         mrE/p5WXxW5LBMMx9YbQORSjEnH+Sg7SxGDOaMEGbrfcQnZZbUNnKm6erIqlxflKv8lt
         DqOQpbes9xkRuaEzaSpzYmB4cZkIPILcTfkwTOnkA4GoAWgwBHH8vrdwMYoU6f1P6hMW
         5Rw7LAOHRHDcOq8kx8alMMO1zvEXZLRt0wvH2mU9HH057+6dXa5iKAvtOrBxLH40b6u0
         BR8w==
X-Gm-Message-State: ABy/qLY2F69C6O2FHqh5jyPzju/yfHhF1+s+V1bQDwaJK8qMmcjTH3vj
        wkiujs68y7pBdii4w4XQP0IiTUQWo+LQwwoA
X-Google-Smtp-Source: APBJJlHUgAl1U1SKwoS4F8D6wLBK+g6otujZun/BNk3D7LyZs35b0zlnz4qzt6/0hLo3q/3NYcnPzQ==
X-Received: by 2002:a05:6402:685:b0:51e:2e88:f86c with SMTP id f5-20020a056402068500b0051e2e88f86cmr1531928edy.37.1688658073010;
        Thu, 06 Jul 2023 08:41:13 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id o16-20020a056402039000b0051e0c0d0a8bsm928412edv.7.2023.07.06.08.41.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 08:41:12 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] checkpolicy: add round-trip tests
Date:   Thu,  6 Jul 2023 17:41:08 +0200
Message-Id: <20230706154108.89846-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add round-trip tests for checkpolicy(8).
Test standard and MLS minimal policies as well as SELinux and Xen
policies with each available statement.
The output is checked against an expected result and then then checked
for idempotence.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/.gitignore                        |  2 +
 checkpolicy/Makefile                          |  6 +-
 checkpolicy/tests/policy_allonce.conf         | 80 ++++++++++++++++
 .../tests/policy_allonce.expected.conf        | 76 +++++++++++++++
 .../tests/policy_allonce.expected_opt.conf    | 76 +++++++++++++++
 checkpolicy/tests/policy_allonce_mls.conf     | 92 +++++++++++++++++++
 .../tests/policy_allonce_mls.expected.conf    | 88 ++++++++++++++++++
 .../policy_allonce_mls.expected_opt.conf      | 88 ++++++++++++++++++
 checkpolicy/tests/policy_allonce_xen.conf     | 62 +++++++++++++
 .../tests/policy_allonce_xen.expected.conf    | 65 +++++++++++++
 .../policy_allonce_xen.expected_opt.conf      | 61 ++++++++++++
 checkpolicy/tests/policy_minimal.conf         | 10 ++
 checkpolicy/tests/policy_minimal_mls.conf     | 15 +++
 checkpolicy/tests/test_roundtrip.sh           | 41 +++++++++
 14 files changed, 761 insertions(+), 1 deletion(-)
 create mode 100644 checkpolicy/tests/policy_allonce.conf
 create mode 100644 checkpolicy/tests/policy_allonce.expected.conf
 create mode 100644 checkpolicy/tests/policy_allonce.expected_opt.conf
 create mode 100644 checkpolicy/tests/policy_allonce_mls.conf
 create mode 100644 checkpolicy/tests/policy_allonce_mls.expected.conf
 create mode 100644 checkpolicy/tests/policy_allonce_mls.expected_opt.conf
 create mode 100644 checkpolicy/tests/policy_allonce_xen.conf
 create mode 100644 checkpolicy/tests/policy_allonce_xen.expected.conf
 create mode 100644 checkpolicy/tests/policy_allonce_xen.expected_opt.conf
 create mode 100644 checkpolicy/tests/policy_minimal.conf
 create mode 100644 checkpolicy/tests/policy_minimal_mls.conf
 create mode 100755 checkpolicy/tests/test_roundtrip.sh

diff --git a/checkpolicy/.gitignore b/checkpolicy/.gitignore
index a7bd076d..01a694d4 100644
--- a/checkpolicy/.gitignore
+++ b/checkpolicy/.gitignore
@@ -3,3 +3,5 @@ checkpolicy
 lex.yy.c
 y.tab.c
 y.tab.h
+tests/testpol.bin
+tests/testpol.conf
diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index f9e1fc7c..86c4a197 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -50,6 +50,10 @@ y.tab.c: policy_parse.y
 lex.yy.c: policy_scan.l y.tab.c
 	$(LEX) policy_scan.l
 
+.PHONY: test
+test: checkpolicy
+	./tests/test_roundtrip.sh
+
 install: all
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(MANDIR)/man8
@@ -68,7 +72,7 @@ relabel: install
 	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
 
 clean:
-	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c
+	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
 	$(MAKE) -C test clean
 
 indent:
diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/policy_allonce.conf
new file mode 100644
index 00000000..ae0fe9b5
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce.conf
@@ -0,0 +1,80 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid kernel
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 ioctl }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+expandattribute ATTR1 true;
+expandattribute ATTR2 false;
+type TYPE1;
+type TYPE2, ATTR1;
+type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
+type TYPE4 alias TYPEALIAS4, ATTR2;
+typealias TYPE1 alias TYPEALIAS1;
+typeattribute TYPE1 ATTR1;
+typebounds TYPE4 TYPE3;
+bool BOOL1 true;
+tunable TUNABLE1 false;
+tunable TUNABLE2 true;
+type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
+type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME";
+type_member TYPE1 TYPE2 : CLASS1 TYPE2;
+type_change TYPE1 TYPE2 : CLASS1 TYPE3;
+allow TYPE1 self : CLASS1 { PERM1 };
+auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
+dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
+neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
+allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
+auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
+dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
+neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
+permissive TYPE1;
+attribute_role ROLE_ATTR1;
+role ROLE1;
+role ROLE3;
+role ROLE2, ROLE_ATTR1;
+dominance { role ROLE1 { role ROLE3; } }
+role_transition ROLE1 TYPE1 ROLE2;
+role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
+allow ROLE1 ROLE2;
+roleattribute ROLE3 ROLE_ATTR1;
+role ROLE1 types { TYPE1 };
+if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
+if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow TYPE1 self: CLASS3 *; }
+optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLASS2 *; }
+user USER1 roles ROLE1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+# sameuser will be turned into (u1 == u2)
+validatetrans CLASS2 sameuser and t3 == ATTR1;
+sid kernel USER1:ROLE1:TYPE1
+# fscon statements are not dumped
+fscon 2 3 USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+fs_use_xattr btrfs USER1:ROLE1:TYPE1;
+fs_use_trans devpts USER1:ROLE1:TYPE1;
+fs_use_task pipefs USER1:ROLE1:TYPE1;
+# paths will be turned into quoted strings
+genfscon proc / -d USER1:ROLE1:TYPE1
+genfscon proc "/file1" -- USER1:ROLE1:TYPE1
+genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
+portcon tcp 80 USER1:ROLE1:TYPE1
+portcon udp 100-200 USER1:ROLE1:TYPE1
+netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
+nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
+# hex numbers will be turned in decimal ones
+ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1
+ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1
+ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
+ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy/tests/policy_allonce.expected.conf
new file mode 100644
index 00000000..63739e1f
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce.expected.conf
@@ -0,0 +1,76 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid kernel
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 ioctl }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+bool BOOL1 true;
+type TYPE1;
+type TYPE2;
+type TYPE3;
+type TYPE4;
+typealias TYPE1 alias TYPEALIAS1;
+typealias TYPE3 alias TYPEALIAS3A;
+typealias TYPE3 alias TYPEALIAS3B;
+typealias TYPE4 alias TYPEALIAS4;
+typebounds TYPE4 TYPE3;
+typeattribute TYPE4 ATTR2;
+permissive TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+allow TYPE1 self:CLASS2 { CPERM1 };
+auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
+auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
+dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
+dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
+auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
+dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
+type_transition TYPE1 TYPE2:CLASS1 TYPE3;
+type_member TYPE1 TYPE2:CLASS1 TYPE2;
+type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
+if (BOOL1) {
+} else {
+    allow TYPE1 self:CLASS1 { PERM1 ioctl };
+}
+role ROLE1;
+role ROLE2;
+role ROLE3;
+role ROLE1 types { TYPE1 };
+role_transition ROLE1 TYPE1:CLASS1 ROLE2;
+role_transition ROLE1 TYPE1:process ROLE2;
+allow ROLE1 ROLE2;
+user USER1 roles ROLE1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
+sid kernel USER1:ROLE1:TYPE1
+fs_use_xattr btrfs USER1:ROLE1:TYPE1;
+fs_use_trans devpts USER1:ROLE1:TYPE1;
+fs_use_task pipefs USER1:ROLE1:TYPE1;
+genfscon proc "/" -d USER1:ROLE1:TYPE1
+genfscon proc "/file1" -- USER1:ROLE1:TYPE1
+genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
+portcon tcp 80 USER1:ROLE1:TYPE1
+portcon udp 100-200 USER1:ROLE1:TYPE1
+netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
+nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
+ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
+ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
+ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
+ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpolicy/tests/policy_allonce.expected_opt.conf
new file mode 100644
index 00000000..1c969961
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
@@ -0,0 +1,76 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid kernel
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 ioctl }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+bool BOOL1 true;
+type TYPE1;
+type TYPE2;
+type TYPE3;
+type TYPE4;
+typealias TYPE1 alias TYPEALIAS1;
+typealias TYPE3 alias TYPEALIAS3A;
+typealias TYPE3 alias TYPEALIAS3B;
+typealias TYPE4 alias TYPEALIAS4;
+typebounds TYPE4 TYPE3;
+typeattribute TYPE4 ATTR2;
+permissive TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+allow TYPE1 self:CLASS2 { CPERM1 };
+auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
+auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
+dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
+dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
+auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
+dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
+type_transition TYPE1 TYPE2:CLASS1 TYPE3;
+type_member TYPE1 TYPE2:CLASS1 TYPE2;
+type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
+if (BOOL1) {
+} else {
+    allow TYPE1 self:CLASS1 { ioctl };
+}
+role ROLE1;
+role ROLE2;
+role ROLE3;
+role ROLE1 types { TYPE1 };
+role_transition ROLE1 TYPE1:CLASS1 ROLE2;
+role_transition ROLE1 TYPE1:process ROLE2;
+allow ROLE1 ROLE2;
+user USER1 roles ROLE1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
+sid kernel USER1:ROLE1:TYPE1
+fs_use_xattr btrfs USER1:ROLE1:TYPE1;
+fs_use_trans devpts USER1:ROLE1:TYPE1;
+fs_use_task pipefs USER1:ROLE1:TYPE1;
+genfscon proc "/" -d USER1:ROLE1:TYPE1
+genfscon proc "/file1" -- USER1:ROLE1:TYPE1
+genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
+portcon tcp 80 USER1:ROLE1:TYPE1
+portcon udp 100-200 USER1:ROLE1:TYPE1
+netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
+nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
+nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1
+ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
+ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
+ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
+ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce_mls.conf b/checkpolicy/tests/policy_allonce_mls.conf
new file mode 100644
index 00000000..eeeaa6e9
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce_mls.conf
@@ -0,0 +1,92 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid kernel
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 ioctl }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+sensitivity s0;
+sensitivity s1;
+sensitivity s2 alias SENSALIAS;
+dominance { s0 s1 SENSALIAS }
+category c0;
+category c1 alias CATALIAS;
+level s0:c0;
+level s1:c0,c1;
+level s2;
+mlsconstrain CLASS1 { PERM1 } l1 == l2;
+mlsvalidatetrans CLASS1 r1 domby r2 and l1 incomp h2;
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+expandattribute ATTR1 true;
+expandattribute ATTR2 false;
+type TYPE1;
+type TYPE2, ATTR1;
+type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
+type TYPE4 alias TYPEALIAS4, ATTR2;
+typealias TYPE1 alias TYPEALIAS1;
+typeattribute TYPE1 ATTR1;
+typebounds TYPE4 TYPE3;
+bool BOOL1 true;
+tunable TUNABLE1 false;
+tunable TUNABLE2 true;
+type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
+type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME";
+type_member TYPE1 TYPE2 : CLASS1 TYPE2;
+type_change TYPE1 TYPE2 : CLASS1 TYPE3;
+range_transition TYPE1 TYPE2 : CLASS1 s1:c0.c1;
+allow TYPE1 self : CLASS1 { PERM1 };
+auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
+dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
+neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
+allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
+auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
+dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
+neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
+permissive TYPE1;
+attribute_role ROLE_ATTR1;
+role ROLE1;
+role ROLE3;
+role ROLE2, ROLE_ATTR1;
+dominance { role ROLE1 { role ROLE3; } }
+role_transition ROLE1 TYPE1 ROLE2;
+role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
+allow ROLE1 ROLE2;
+roleattribute ROLE3 ROLE_ATTR1;
+role ROLE1 types { TYPE1 };
+if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
+if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow TYPE1 self: CLASS3 *; }
+optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLASS2 *; }
+user USER1 roles ROLE1 level s0 range s0 - s1:c0.c1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+# sameuser will be turned into (u1 == u2)
+validatetrans CLASS2 sameuser and t3 == ATTR1;
+sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0.c1
+# fscon statements are not dumped
+fscon 2 3 USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
+fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0.CATALIAS;
+fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
+fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
+# paths will be turned into quoted strings
+genfscon proc / -d USER1:ROLE1:TYPE1:s0
+genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0
+genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0
+portcon tcp 80 USER1:ROLE1:TYPE1:s0
+portcon udp 100-200 USER1:ROLE1:TYPE1:s0
+netifcon lo USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
+nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0
+nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1:s0
+# hex numbers will be turned in decimal ones
+ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1:s0
+ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1:s0
+ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0
+ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0
diff --git a/checkpolicy/tests/policy_allonce_mls.expected.conf b/checkpolicy/tests/policy_allonce_mls.expected.conf
new file mode 100644
index 00000000..87c36f92
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce_mls.expected.conf
@@ -0,0 +1,88 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid kernel
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 ioctl }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+sensitivity s0;
+sensitivity s1;
+sensitivity s2 alias SENSALIAS;
+dominance { s0 s1 s2 }
+category c0;
+category c1 alias CATALIAS;
+level s0:c0;
+level s1:c0,c1;
+level s2;
+mlsconstrain CLASS1 { PERM1 } l1 == l2;
+mlsvalidatetrans CLASS1 (r1 domby r2 and l1 incomp h2);
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+bool BOOL1 true;
+type TYPE1;
+type TYPE2;
+type TYPE3;
+type TYPE4;
+typealias TYPE1 alias TYPEALIAS1;
+typealias TYPE3 alias TYPEALIAS3A;
+typealias TYPE3 alias TYPEALIAS3B;
+typealias TYPE4 alias TYPEALIAS4;
+typebounds TYPE4 TYPE3;
+typeattribute TYPE4 ATTR2;
+permissive TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+allow TYPE1 self:CLASS2 { CPERM1 };
+auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
+auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
+dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
+dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
+auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
+dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
+type_transition TYPE1 TYPE2:CLASS1 TYPE3;
+type_member TYPE1 TYPE2:CLASS1 TYPE2;
+type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
+range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
+if (BOOL1) {
+} else {
+    allow TYPE1 self:CLASS1 { PERM1 ioctl };
+}
+role ROLE1;
+role ROLE2;
+role ROLE3;
+role ROLE1 types { TYPE1 };
+role_transition ROLE1 TYPE1:CLASS1 ROLE2;
+role_transition ROLE1 TYPE1:process ROLE2;
+allow ROLE1 ROLE2;
+user USER1 roles ROLE1 level s0 range s0 - s1:c0,c1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
+sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0,c1
+fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0,c1;
+fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
+fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
+genfscon proc "/" -d USER1:ROLE1:TYPE1:s0 - s0
+genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0 - s0
+genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0 - s0
+portcon tcp 80 USER1:ROLE1:TYPE1:s0 - s0
+portcon udp 100-200 USER1:ROLE1:TYPE1:s0 - s0
+netifcon lo USER1:ROLE1:TYPE1:s0 - s0 USER1:ROLE1:TYPE1:s0 - s0
+nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0 - s0
+nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1:s0 - s0
+ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1:s0 - s0
+ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1:s0 - s0
+ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0 - s0
+ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0 - s0
diff --git a/checkpolicy/tests/policy_allonce_mls.expected_opt.conf b/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
new file mode 100644
index 00000000..38176166
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
@@ -0,0 +1,88 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid kernel
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 ioctl }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+sensitivity s0;
+sensitivity s1;
+sensitivity s2 alias SENSALIAS;
+dominance { s0 s1 s2 }
+category c0;
+category c1 alias CATALIAS;
+level s0:c0;
+level s1:c0,c1;
+level s2;
+mlsconstrain CLASS1 { PERM1 } l1 == l2;
+mlsvalidatetrans CLASS1 (r1 domby r2 and l1 incomp h2);
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+bool BOOL1 true;
+type TYPE1;
+type TYPE2;
+type TYPE3;
+type TYPE4;
+typealias TYPE1 alias TYPEALIAS1;
+typealias TYPE3 alias TYPEALIAS3A;
+typealias TYPE3 alias TYPEALIAS3B;
+typealias TYPE4 alias TYPEALIAS4;
+typebounds TYPE4 TYPE3;
+typeattribute TYPE4 ATTR2;
+permissive TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+allow TYPE1 self:CLASS2 { CPERM1 };
+auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
+auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
+dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
+dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
+allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
+auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
+dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
+type_transition TYPE1 TYPE2:CLASS1 TYPE3;
+type_member TYPE1 TYPE2:CLASS1 TYPE2;
+type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
+range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
+if (BOOL1) {
+} else {
+    allow TYPE1 self:CLASS1 { ioctl };
+}
+role ROLE1;
+role ROLE2;
+role ROLE3;
+role ROLE1 types { TYPE1 };
+role_transition ROLE1 TYPE1:CLASS1 ROLE2;
+role_transition ROLE1 TYPE1:process ROLE2;
+allow ROLE1 ROLE2;
+user USER1 roles ROLE1 level s0 range s0 - s1:c0,c1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
+sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0,c1
+fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0,c1;
+fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
+fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
+genfscon proc "/" -d USER1:ROLE1:TYPE1:s0 - s0
+genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0 - s0
+genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0 - s0
+portcon tcp 80 USER1:ROLE1:TYPE1:s0 - s0
+portcon udp 100-200 USER1:ROLE1:TYPE1:s0 - s0
+netifcon lo USER1:ROLE1:TYPE1:s0 - s0 USER1:ROLE1:TYPE1:s0 - s0
+nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0 - s0
+nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:ROLE1:TYPE1:s0 - s0
+ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1:s0 - s0
+ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1:s0 - s0
+ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0 - s0
+ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0 - s0
diff --git a/checkpolicy/tests/policy_allonce_xen.conf b/checkpolicy/tests/policy_allonce_xen.conf
new file mode 100644
index 00000000..6402683a
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce_xen.conf
@@ -0,0 +1,62 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid kernel
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+attribute ATTR1;
+attribute ATTR2;
+expandattribute ATTR1 true;
+expandattribute ATTR2 false;
+type TYPE1;
+type TYPE2, ATTR1;
+type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
+type TYPE4 alias TYPEALIAS4, ATTR2;
+typealias TYPE1 alias TYPEALIAS1;
+typeattribute TYPE1 ATTR1;
+typebounds TYPE4 TYPE3;
+bool BOOL1 true;
+tunable TUNABLE1 false;
+tunable TUNABLE2 true;
+type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
+type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME";
+type_member TYPE1 TYPE2 : CLASS1 TYPE2;
+type_change TYPE1 TYPE2 : CLASS1 TYPE3;
+allow TYPE1 self : CLASS1 { PERM1 };
+auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
+dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
+neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
+permissive TYPE1;
+attribute_role ROLE_ATTR1;
+role ROLE1;
+role ROLE3;
+role ROLE2, ROLE_ATTR1;
+role_transition ROLE1 TYPE1 ROLE2;
+role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
+allow ROLE1 ROLE2;
+roleattribute ROLE3 ROLE_ATTR1;
+role ROLE1 types { TYPE1 };
+if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
+if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow TYPE1 self: CLASS3 *; }
+optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLASS2 *; }
+policycap open_perms;
+user USER1 roles ROLE1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+validatetrans CLASS2 sameuser and t3 == ATTR1;
+sid kernel USER1:ROLE1:TYPE1
+pirqcon 13 USER1:ROLE1:TYPE1
+iomemcon 13 USER1:ROLE1:TYPE1
+iomemcon 23-31 USER1:ROLE1:TYPE1
+ioportcon 13 USER1:ROLE1:TYPE1
+ioportcon 23-31 USER1:ROLE1:TYPE1
+pcidevicecon 13 USER1:ROLE1:TYPE1
+devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce_xen.expected.conf b/checkpolicy/tests/policy_allonce_xen.expected.conf
new file mode 100644
index 00000000..a4573ccb
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce_xen.expected.conf
@@ -0,0 +1,65 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid xen
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+bool BOOL1 true;
+type TYPE1;
+type TYPE2;
+type TYPE3;
+type TYPE4;
+typealias TYPE1 alias TYPEALIAS1;
+typealias TYPE3 alias TYPEALIAS3A;
+typealias TYPE3 alias TYPEALIAS3B;
+typealias TYPE4 alias TYPEALIAS4;
+typebounds TYPE4 TYPE3;
+typeattribute TYPE4 ATTR2;
+permissive TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+allow TYPE1 self:CLASS2 { CPERM1 };
+auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
+auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
+dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
+dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
+type_transition TYPE1 TYPE2:CLASS1 TYPE3;
+type_member TYPE1 TYPE2:CLASS1 TYPE2;
+type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
+if (BOOL1) {
+} else {
+    allow TYPE1 self:CLASS1 { PERM1 };
+}
+role ROLE1;
+role ROLE2;
+role ROLE3;
+role ROLE1 types { TYPE1 };
+role_transition ROLE1 TYPE1:CLASS1 ROLE2;
+role_transition ROLE1 TYPE1:process ROLE2;
+allow ROLE1 ROLE2;
+user USER1 roles ROLE1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
+sid xen USER1:ROLE1:TYPE1
+pirqcon 13 USER1:ROLE1:TYPE1
+iomemcon 0xd USER1:ROLE1:TYPE1
+iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
+ioportcon 0xd USER1:ROLE1:TYPE1
+ioportcon 0x17-0x1f USER1:ROLE1:TYPE1
+pcidevicecon 0xd USER1:ROLE1:TYPE1
+devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_allonce_xen.expected_opt.conf b/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
new file mode 100644
index 00000000..8fd3b226
--- /dev/null
+++ b/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
@@ -0,0 +1,61 @@
+# handle_unknown deny
+class CLASS1
+class CLASS2
+class CLASS3
+class dir
+class file
+class process
+sid xen
+common COMMON1 { CPERM1 }
+class CLASS1 { PERM1 }
+class CLASS2 inherits COMMON1
+class CLASS3 inherits COMMON1 { PERM1 }
+default_user { CLASS1 } source;
+default_role { CLASS2 } target;
+default_type { CLASS3 } source;
+policycap open_perms;
+attribute ATTR1;
+attribute ATTR2;
+bool BOOL1 true;
+type TYPE1;
+type TYPE2;
+type TYPE3;
+type TYPE4;
+typealias TYPE1 alias TYPEALIAS1;
+typealias TYPE3 alias TYPEALIAS3A;
+typealias TYPE3 alias TYPEALIAS3B;
+typealias TYPE4 alias TYPEALIAS4;
+typebounds TYPE4 TYPE3;
+typeattribute TYPE4 ATTR2;
+permissive TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+allow TYPE1 self:CLASS2 { CPERM1 };
+auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
+auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
+dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
+dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
+type_transition TYPE1 TYPE2:CLASS1 TYPE3;
+type_member TYPE1 TYPE2:CLASS1 TYPE2;
+type_change TYPE1 TYPE2:CLASS1 TYPE3;
+type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
+type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
+role ROLE1;
+role ROLE2;
+role ROLE3;
+role ROLE1 types { TYPE1 };
+role_transition ROLE1 TYPE1:CLASS1 ROLE2;
+role_transition ROLE1 TYPE1:process ROLE2;
+allow ROLE1 ROLE2;
+user USER1 roles ROLE1;
+constrain CLASS1 { PERM1 } (u1 == u2 or (r1 == r2 and t1 == t2));
+validatetrans CLASS2 (u1 == u2 and t3 == ATTR1);
+sid xen USER1:ROLE1:TYPE1
+pirqcon 13 USER1:ROLE1:TYPE1
+iomemcon 0xd USER1:ROLE1:TYPE1
+iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
+ioportcon 0xd USER1:ROLE1:TYPE1
+ioportcon 0x17-0x1f USER1:ROLE1:TYPE1
+pcidevicecon 0xd USER1:ROLE1:TYPE1
+devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_minimal.conf b/checkpolicy/tests/policy_minimal.conf
new file mode 100644
index 00000000..e8cff6df
--- /dev/null
+++ b/checkpolicy/tests/policy_minimal.conf
@@ -0,0 +1,10 @@
+# handle_unknown deny
+class CLASS1
+sid kernel
+class CLASS1 { PERM1 }
+type TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+role ROLE1;
+role ROLE1 types { TYPE1 };
+user USER1 roles ROLE1;
+sid kernel USER1:ROLE1:TYPE1
diff --git a/checkpolicy/tests/policy_minimal_mls.conf b/checkpolicy/tests/policy_minimal_mls.conf
new file mode 100644
index 00000000..9ea65169
--- /dev/null
+++ b/checkpolicy/tests/policy_minimal_mls.conf
@@ -0,0 +1,15 @@
+# handle_unknown deny
+class CLASS1
+sid kernel
+class CLASS1 { PERM1 }
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+mlsconstrain CLASS1 { PERM1 } l1 == l2;
+type TYPE1;
+allow TYPE1 self:CLASS1 { PERM1 };
+role ROLE1;
+role ROLE1 types { TYPE1 };
+user USER1 roles ROLE1 level s0 range s0 - s0:c0;
+sid kernel USER1:ROLE1:TYPE1:s0 - s0
diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test_roundtrip.sh
new file mode 100755
index 00000000..d05b36bb
--- /dev/null
+++ b/checkpolicy/tests/test_roundtrip.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+set -eu
+
+BASEDIR=$(dirname "$0")
+CHECKPOLICY="${BASEDIR}/../checkpolicy"
+
+check_policy() {
+	POLICY=$1
+	EXPECTED=$2
+	OPTS=$3
+
+	echo "==== Testing ${1}"
+
+	${CHECKPOLICY} ${OPTS} "${BASEDIR}/${POLICY}" -o "${BASEDIR}/testpol.bin"
+	${CHECKPOLICY} ${OPTS} -b -F "${BASEDIR}/testpol.bin" -o "${BASEDIR}/testpol.conf"
+	diff -u "${BASEDIR}/${EXPECTED}" "${BASEDIR}/testpol.conf"
+
+	${CHECKPOLICY} ${OPTS} "${BASEDIR}/${EXPECTED}" -o "${BASEDIR}/testpol.bin"
+	${CHECKPOLICY} ${OPTS} -b -F "${BASEDIR}/testpol.bin" -o "${BASEDIR}/testpol.conf"
+	diff -u "${BASEDIR}/${EXPECTED}" "${BASEDIR}/testpol.conf"
+
+	echo "==== ${1} success"
+	echo ""
+}
+
+
+check_policy  policy_minimal.conf      policy_minimal.conf                   '-E'
+check_policy  policy_minimal.conf      policy_minimal.conf                   '-E -S -O'
+
+check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf               '-M -E'
+check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf               '-M -E -S -O'
+
+check_policy  policy_allonce.conf      policy_allonce.expected.conf          ''
+check_policy  policy_allonce.conf      policy_allonce.expected_opt.conf      '-S -O'
+
+check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected.conf      '-M'
+check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected_opt.conf  '-M -S -O'
+
+check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected.conf      '--target xen -c 30 -E'
+check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected_opt.conf  '--target xen -c 30 -E -S -O'
-- 
2.40.1

