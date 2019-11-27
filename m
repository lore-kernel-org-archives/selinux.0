Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFD3C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B083520835
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Zp0OE/df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfK0Ruu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:50:50 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:6782 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0Ruu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 12:50:50 -0500
X-EEMSG-check-017: 30763137|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="scan'208";a="30763137"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 17:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574877047; x=1606413047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PP2CaadKRhc33ju6RuxnownZ8+2U7o59J2l8gDok4uw=;
  b=Zp0OE/dfcn54R7gXvPdOkXQo/x/2KAie0nhFEDK4qxgJWqzJ8F3TI2ly
   qroZZOpEeIocUn3fhrxlIWuz3tz9aCNVPY7JGQI+OBqCzwuxbnCM6Of5H
   BY4Bk4iEVy24djsNdREjbi8ET7ICIuu1jjpORnMtfe3R8yAhU0nS7Og1M
   SyYALBXkaQ+2NH70ttyqQHjseAaXRczYW8AycoeYo0dO5DmqcmYpYezJ7
   vrLO/g/YnuZ5E+nVezfegSHI4lRWDx2CTFI8s8Fc8iZUmzgougkisqRL3
   fHrokwF2QR7WsA/+x6VWHG8DTwmpDBNiioLvvEHh2rX7cM+wO+zCSxGIM
   A==;
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="scan'208";a="30569382"
IronPort-PHdr: =?us-ascii?q?9a23=3AxTO4FhPzHyTxVCf2DP0l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfrzrarrMEGX3/hxlliBBdydt6sfzbOI7uu5ATVIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjQtsQajpZuJrosxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKjA28HvTisdtkqxVphyvrAF7z4LNYIyYMP9yc6XAdt0YWG?=
 =?us-ascii?q?VBRN5cWSxfDI2hYYUBDO0PMulXoYTmu1cDrgGzCRW2Ce/z1jNFgGL9060g0+?=
 =?us-ascii?q?QmFAHLxBEuH84Qv3TMrNX6KqESWv2owqnN1zrDa/dW1in96YPVdR0huuyDXa?=
 =?us-ascii?q?lrfMrNyUggCwPFjlKKpYzjJDOazP4Bs2ec7+p+TO+ijXMspQJpojW328shhY?=
 =?us-ascii?q?bEipgVx1zZ7yl13ok4KcOiREJmZ9OvDYFeuDuAN4RsR8MvW2RouCEnxbIYoZ?=
 =?us-ascii?q?O7Zy0KyIg/xx7YdvyHb5CE4hL9W+aVJjd1nG5ld6ilhxaz7Eig0ffwVsiy0F?=
 =?us-ascii?q?ZEqSpFicfDuWwX2xzP6smIVvt9/kC71TaJyw/T8f1LLVoxlaraL54t2r8wlp?=
 =?us-ascii?q?wNvkTfBiL6hUr7gaCMekgk5+Sk8frrb7r4qpOGKoN4kgT+Pb4vmsy7D+Q4KA?=
 =?us-ascii?q?8OX22D9OSnybLj5lb0QKlKj/IqkqnZt4rWJcIApqGjGQNV3YEj6winAze8zN?=
 =?us-ascii?q?sYhWUHLE5CeB+flIjmJVXOIPH+DfeijFWhiylrx//YMb37GJnNLWbMkK3nfb?=
 =?us-ascii?q?lj705Q0g0zzcpQ58EcNrZUO//3W0nspPTGARIjdQ+52eDqDJN6zIxNd3iIB/?=
 =?us-ascii?q?qiLK7KsVKOrtkqKu2IaZ5d7C3xMNA59vXuijk/glZbcq63i8hEIEukF+hrdh?=
 =?us-ascii?q?3KKUHnhc0MRCJX7wc=3D?=
X-IPAS-Result: =?us-ascii?q?A2BVAADftt5d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWwFA?=
 =?us-ascii?q?QELAYFzgWwBIBIqjS6ReI9JgXsJAQEBAQEBAQEBGxwBAYRAgiY2Bw4CEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOymDJwFGgVGCYz+CUyW1CoVPgy2BSIE2AYc8hHN5g?=
 =?us-ascii?q?QeBR4MbijcEjRSKFXSWHII3gjmTEQwbmh+qXQ4kgVgrCAIYCCEPgydQERSVL?=
 =?us-ascii?q?CMDMI5DAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Nov 2019 17:50:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARHogxM083222;
        Wed, 27 Nov 2019 12:50:42 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH v3] selinux-testsuite: add lockdown tests
Date:   Wed, 27 Nov 2019 12:50:44 -0500
Message-Id: <20191127175044.8089-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test all permissions associated with the lockdown class.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v3 fixes a mismerge that broke v2 build.
 policy/Makefile         |  4 +++
 policy/test_lockdown.te | 54 +++++++++++++++++++++++++++++++++++++++++
 tests/Makefile          |  4 +++
 tests/lockdown/Makefile |  2 ++
 tests/lockdown/test     | 42 ++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+)
 create mode 100644 policy/test_lockdown.te
 create mode 100644 tests/lockdown/Makefile
 create mode 100755 tests/lockdown/test

diff --git a/policy/Makefile b/policy/Makefile
index 87b2856ae1ca..dc637793aa86 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -101,6 +101,10 @@ ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && ech
 TARGETS+=test_module_load.te
 endif
 
+ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_lockdown.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
diff --git a/policy/test_lockdown.te b/policy/test_lockdown.te
new file mode 100644
index 000000000000..a7a4b6bb8aec
--- /dev/null
+++ b/policy/test_lockdown.te
@@ -0,0 +1,54 @@
+#################################
+#
+# Policy for testing lockdown
+#
+
+attribute lockdowndomain;
+
+# Domain for lockdown (all operations allowed)
+type test_lockdown_all_t;
+domain_type(test_lockdown_all_t)
+unconfined_runs_test(test_lockdown_all_t)
+typeattribute test_lockdown_all_t lockdowndomain;
+typeattribute test_lockdown_all_t testdomain;
+
+dev_read_raw_memory(test_lockdown_all_t)
+kernel_read_core_if(test_lockdown_all_t)
+corecmd_bin_entry_type(test_lockdown_all_t)
+allow test_lockdown_all_t self:lockdown integrity;
+allow test_lockdown_all_t self:lockdown confidentiality;
+
+# Domain for integrity
+type test_lockdown_integrity_t;
+domain_type(test_lockdown_integrity_t)
+unconfined_runs_test(test_lockdown_integrity_t)
+typeattribute test_lockdown_integrity_t lockdowndomain;
+typeattribute test_lockdown_integrity_t testdomain;
+
+dev_read_raw_memory(test_lockdown_integrity_t)
+kernel_read_core_if(test_lockdown_integrity_t)
+corecmd_bin_entry_type(test_lockdown_integrity_t)
+allow test_lockdown_integrity_t self:lockdown integrity;
+
+# Domain for confidentiality
+type test_lockdown_confidentiality_t;
+domain_type(test_lockdown_confidentiality_t)
+unconfined_runs_test(test_lockdown_confidentiality_t)
+typeattribute test_lockdown_confidentiality_t lockdowndomain;
+typeattribute test_lockdown_confidentiality_t testdomain;
+
+dev_read_raw_memory(test_lockdown_confidentiality_t)
+kernel_read_core_if(test_lockdown_confidentiality_t)
+corecmd_bin_entry_type(test_lockdown_confidentiality_t)
+allow test_lockdown_confidentiality_t self:lockdown confidentiality;
+
+# Domain for lockdown (all operations denied)
+type test_lockdown_none_t;
+domain_type(test_lockdown_none_t)
+unconfined_runs_test(test_lockdown_none_t)
+typeattribute test_lockdown_none_t lockdowndomain;
+typeattribute test_lockdown_none_t testdomain;
+
+dev_read_raw_memory(test_lockdown_none_t)
+kernel_read_core_if(test_lockdown_none_t)
+corecmd_bin_entry_type(test_lockdown_none_t)
diff --git a/tests/Makefile b/tests/Makefile
index 1cdb1ac33875..096bbb472c51 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -78,6 +78,10 @@ SUBDIRS+=module_load
 endif
 endif
 
+ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS += lockdown
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/lockdown/Makefile b/tests/lockdown/Makefile
new file mode 100644
index 000000000000..e7c006f270c5
--- /dev/null
+++ b/tests/lockdown/Makefile
@@ -0,0 +1,2 @@
+all:
+clean:
diff --git a/tests/lockdown/test b/tests/lockdown/test
new file mode 100755
index 000000000000..0b81cb16c1a6
--- /dev/null
+++ b/tests/lockdown/test
@@ -0,0 +1,42 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 8 }
+
+# everything is allowed
+$result =
+  system "runcon -t test_lockdown_all_t -- head /dev/mem > /dev/null 2>&1";
+ok( $result, 0 );
+
+$result =
+  system "runcon -t test_lockdown_all_t -- head /proc/kcore > /dev/null 2>&1";
+ok( $result, 0 );
+
+# only integrity operations allowed
+$result = system
+  "runcon -t test_lockdown_integrity_t -- head /dev/mem > /dev/null 2>&1";
+ok( $result, 0 );
+
+$result = system
+  "runcon -t test_lockdown_integrity_t -- head /proc/kcore > /dev/null 2>&1";
+ok($result);
+
+# only confidentiality operations allowed
+$result = system
+  "runcon -t test_lockdown_confidentiality_t -- head /dev/mem > /dev/null 2>&1";
+ok($result);
+
+$result = system
+"runcon -t test_lockdown_confidentiality_t -- head /proc/kcore > /dev/null 2>&1";
+ok( $result, 0 );
+
+# nothing is allowed
+$result =
+  system "runcon -t test_lockdown_none_t -- head /dev/mem > /dev/null 2>&1";
+ok($result);
+
+$result =
+  system "runcon -t test_lockdown_none_t -- head /proc/kcore > /dev/null 2>&1";
+ok($result);
+
+exit;
-- 
2.23.0

