Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA58DC432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854F12075C
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="J3z8QStO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0RgS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:36:18 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:10486 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfK0RgR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 12:36:17 -0500
X-EEMSG-check-017: 55342441|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="scan'208";a="55342441"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 17:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574876176; x=1606412176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B8kRJWavoYs/x7DBfetkBwfeA1QIvrUclhKjMj9ewnQ=;
  b=J3z8QStOvtPBJuSW6eK7frvr5opDZJFsxscSxm1BqdCZBj8/NDSLDdHH
   BYNM1eFzBO/eKqEGTn3DxU4APTRhLXWyX4dQerAv/iJ5l7Oy+hGw/bbE+
   R/q808egRhdN8kX0TjiYVN4FsTr/52ml8DkituUcZ/HgMRT/axz4JtZbu
   Fu3dUUqH5y5ZApSgk3BtD9xVums0XwXeyB7A4j+f3smUVbn5QsUxFwyMC
   e1cdXnBdlRUa2w9IuYGJxe87+Ivabw8qNgF91lBxgISjsxSaNl3bkUSVY
   cb70tSxgafM8MB9N3vcIsYd3lCQGwQapaY42s1K6MnrWkBTtd7ay7g99W
   A==;
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="scan'208";a="30567949"
IronPort-PHdr: =?us-ascii?q?9a23=3Af0ZoyBToUyeYAnJE28LK3EOXVdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69YhyN2/xhgRfzUJnB7Loc0qyK6vumADJdqs/Z6DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIpiJ6o+1x?=
 =?us-ascii?q?fFvmdEcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKhMNwlqZbqw+/qRJ5zYDffYWZOON+c67ZeN8XQ3?=
 =?us-ascii?q?dKUMRMWCxbGo6yb5UBAfcPM+hbqIfyqFQAoACiCQSvHu7j1iVFimPq0aA8zu?=
 =?us-ascii?q?8vERvG3AslH98WrXrUsMv6NL8SUe+ryqnD0CjNb/ZM1jf57IjHbBAgquyLUL?=
 =?us-ascii?q?JrbMXR0lIiFx/Fj1qMqYzlOCmZ1uIWs2eB9eZgWuWvi3A+pgx3vzOhxd8sh5?=
 =?us-ascii?q?HUio8axV3I7yV0zJsvKdGmR0N3f8SoHIZWuiqHLYV5WNkiTHttuCsiz70Gvo?=
 =?us-ascii?q?O0czYSxZQ8wh7fd+SHc4+V4hL/TOqRISl3hHZieL+nmxa961KgyuzhVsmvyl?=
 =?us-ascii?q?pKryxFktfLtnAWyRPc9tKLSud9/0i92TaP0Brf6udYLkAviaXXMZshwr80lp?=
 =?us-ascii?q?YLsETDGDH5mFnugaOLeUgp9fKk5uT6brn8uJOROJF4hhvjPqg2n8ywG+U4Mg?=
 =?us-ascii?q?wAX2iB/uS80aXu/VbkT7VRlfA2jqnYv4zaJcQcvKK5BRRV3Zw55xawCDemzs?=
 =?us-ascii?q?wUnWMbI1JdZBKHk4/pNknVIP/mCfe/glKskCpkxv3dIL3hDYvCLmLZnLfiY7?=
 =?us-ascii?q?l98UhcxxQ3zdxF4JJUEL4Bc7rPXRrqudjZCAIpGxK7zvyhC9hn0I4aH2WVDf?=
 =?us-ascii?q?y3KqTX5GSU6/ovLu/EX4ocvDLwOrBx/PL1pWMokl8aO6+y1N0Yb27uTacuGF?=
 =?us-ascii?q?mQfXe52oRJKmwNpAdrCbG7hQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BVAABMs95d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWwFA?=
 =?us-ascii?q?QELAYFzgWwBIBIqjS6Rd49JgXsJAQEBAQEBAQEBGxwBAYRAgiY2Bw4CEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOymDJwFGgVGCYz+CUyW1BoVPgzyBSIE2AYc8hHN5g?=
 =?us-ascii?q?QeBR4MbijcEjRSKFXSWHII3gjmTEQwbmh+qXQ4kgVgrCAIYCCEPgydQERSVL?=
 =?us-ascii?q?CMDMI5DAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Nov 2019 17:36:15 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARHaBHc082869;
        Wed, 27 Nov 2019 12:36:11 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH v2] selinux-testsuite: add lockdown tests
Date:   Wed, 27 Nov 2019 12:36:18 -0500
Message-Id: <20191127173618.4387-1-sds@tycho.nsa.gov>
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
 policy/Makefile         |  3 +++
 policy/test_lockdown.te | 54 +++++++++++++++++++++++++++++++++++++++++
 tests/Makefile          |  3 +++
 tests/lockdown/Makefile |  2 ++
 tests/lockdown/test     | 42 ++++++++++++++++++++++++++++++++
 5 files changed, 104 insertions(+)
 create mode 100644 policy/test_lockdown.te
 create mode 100644 tests/lockdown/Makefile
 create mode 100755 tests/lockdown/test

diff --git a/policy/Makefile b/policy/Makefile
index 87b2856ae1ca..c94d40a3a659 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -99,6 +99,9 @@ endif
 
 ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS+=test_module_load.te
+
+ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_lockdown.te
 endif
 
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
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
index 1cdb1ac33875..af2f44c95420 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -76,6 +76,9 @@ ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && ech
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
 SUBDIRS+=module_load
 endif
+
+ifeq ($(shell grep -q lockdown $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS += lockdown
 endif
 
 ifeq ($(DISTRO),RHEL4)
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

