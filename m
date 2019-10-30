Return-Path: <SRS0=VtUM=YX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1957ECA9EC5
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 13:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D982F20663
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="i7Qk2CKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfJ3NSz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:18:55 -0400
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:40279 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJ3NSz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Oct 2019 09:18:55 -0400
X-EEMSG-check-017: 44909681|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="scan'208";a="44909681"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Oct 2019 13:18:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572441533; x=1603977533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g+z/GQ3TjZis3EjyTH4t1RRFjhgDyZiqnIKkpvzSSTY=;
  b=i7Qk2CKqhV+DiQ9mCFOlMT+auayCGXFdnwjlPSR8dEttDpTrml9MZTQi
   XL4y2JcNWc3ytAMZr5HIJGDrWOm8B1gIhEF0jytzkgOuCQtW4emoxenbG
   5TZzlVtIjrs1Vwl0Bl31tYD3Hv1sbCi4rxXHZ6Zn0DCMqdSh9SUUHa/T7
   2gJrBwjqfLMm/ElIECVcMFHASruUJiMJaA/bCZhLK2+nIOwWhaW6hoUMc
   DJS7up6jX4l5FpkreEpLfuGdjtZamV588DA9hvLbnK+yOOGcz+bhzPbuu
   UnlkIlDwQDgAZUHRwf+rWbWET41XIt1c1B4DhkX2fIYDiRMq4eWsLVOJV
   w==;
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="scan'208";a="34868663"
IronPort-PHdr: =?us-ascii?q?9a23=3AOGgyURHMafyDCdZb0zxElp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zp8+wAkXT6L1XgUPTWs2DsrQY0rGQ6vi7EjBRqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAndqscbjYRtJ6s11x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMODAj8GHTl8d+kqRVrhy8rBB72oLZYIWYOP94c6jAf90VWH?=
 =?us-ascii?q?BBU95RWSJfH42yYYgBAe0OMuhXtITxu1gDoAGiCQS2GO/j1jlFjWL2060g1O?=
 =?us-ascii?q?QhFBnL0hE8H90QqHTUrMv6NKEPWu6oyanH1zHDb/dI1jb99YPFdQshruyXXb?=
 =?us-ascii?q?9rbcrQyVUgFwPCjlmKr4zlJCma2v4Cs2ic8eptTOSigHMkpQFpujWj28ghh4?=
 =?us-ascii?q?bTio8V11zI7zt1zYkrKdGiVUJ2Z8OvHoFKuCGALYR2R9svQ2RvuCkn1LILoY?=
 =?us-ascii?q?W7fC0WyJQ/wB7fduCHf5CI4h39UOaRJi91hG5/d7Klhhay7FOgxvfgVsi0zF?=
 =?us-ascii?q?lKri1FnsPKtn8RzBzc9tKLSv58/kelwTqP1gbT5f9YIU0siKbWJJEszqQwm5?=
 =?us-ascii?q?YOq0jPACD7lFvsgKOLbkkk//Kn6+XjYrXovJ+cMIp0hxnlMqszgcyyGvg4Mw?=
 =?us-ascii?q?gSUGib/uSwzrvj/VbjT7lQgf02lbfZvIjAJcsHvq65HxNV0oE75hanFTimzd?=
 =?us-ascii?q?AYkGIfLF1fZRKHi5HlO1TJIPD/F/ewnU6gnytsx/DDJrfhGInCLmDfkLf9er?=
 =?us-ascii?q?Zw81VcxxQ3zdBe4ZJUF74ALentWk/+qtPYFAU1Mw+qzOb9DtVyyIceVXiIAq?=
 =?us-ascii?q?+DP6OB+WOPs/kiJ+iKeZ89pjnwMb4m6uTogHt/nkUSLoez2p5CU2y1BvRrJQ?=
 =?us-ascii?q?2iZHPohtoQWTMRshEWUP3hiFrEVyVaIXm1QfRvtXkAFIu6ANKbFciWi7ub0X?=
 =?us-ascii?q?L+Q8xb?=
X-IPAS-Result: =?us-ascii?q?A2BLAAAVjbld/wHyM5BkHAEBAQEBBwEBEQEEBAEBgWkHA?=
 =?us-ascii?q?QELAYFzLIFBMiqMS5JXjzaBewkBAQEBAQEBAQEbGQECAQGEQINoJDQJDgIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KYMmAUaBUYJjP4JTJbUZhU6DQoFIgTYBhzeEW?=
 =?us-ascii?q?Rh4gQeEYYozBIx+inCWAIIugjOScgwbmV0Bqgg5gVgrCAIYCCEPgydQEBSRa?=
 =?us-ascii?q?CUDMIEFAQGNZQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Oct 2019 13:18:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9UDIqTY017330;
        Wed, 30 Oct 2019 09:18:52 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] selinux-testsuite: add lockdown tests
Date:   Wed, 30 Oct 2019 09:18:50 -0400
Message-Id: <20191030131850.9517-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test all permissions associated with the lockdown class.

(original patch authored by an intern who wishes to remain
anonymous; I am signing off on his behalf)

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
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
index 5c2c4384cc86..7cc06504f724 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -86,6 +86,10 @@ ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && e
 TARGETS += test_keys.te
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
index 42f7f4026e4a..0a3c68ea9715 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -64,6 +64,10 @@ ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
 SUBDIRS += cgroupfs_label
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

