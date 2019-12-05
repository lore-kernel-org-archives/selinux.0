Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE66BC43603
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881DD20801
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfLEQUD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:20:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:55878 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLEQUC (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 5 Dec 2019 11:20:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 08:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="223685585"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2019 08:19:55 -0800
Received: from [10.125.252.254] (abudanko-mobl.ccr.corp.intel.com [10.125.252.254])
        by linux.intel.com (Postfix) with ESMTP id 446C0580418;
        Thu,  5 Dec 2019 08:19:52 -0800 (PST)
Subject: [PATCH v1 1/3] capabilities: introduce CAP_SYS_PERFMON to kernel and
 user space
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        elena.reshetova@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4ebe4d05-85c3-20dc-89a4-ed8f052d586e@linux.intel.com>
Date:   Thu, 5 Dec 2019 19:19:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <283f09a5-33bd-eac3-bdfd-83d775045bf9@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Introduce CAP_SYS_PERFMON capability dedicated to secure performance
monitoring activity so that CAP_SYS_PERFMON would assist CAP_SYS_ADMIN
capability in its governing role for perf_events based performance
monitoring of a system.

CAP_SYS_PERFMON aims to harden system security and integrity during
performance monitoring by decreasing attack surface that is available
to CAP_SYS_ADMIN privileged processes.

CAP_SYS_PERFMON aims to take over CAP_SYS_ADMIN credentials related to
performance monitoring functionality of perf_events and balance amount of
CAP_SYS_ADMIN credentials in accordance with the recommendations provided in
the man page for CAP_SYS_ADMIN [3]: "Note: this capability is overloaded;
see Notes to kernel developers, below."

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/uapi/linux/capability.h     | 10 +++++++++-
 security/selinux/include/classmap.h |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
index 240fdb9a60f6..c9514f034be1 100644
--- a/include/uapi/linux/capability.h
+++ b/include/uapi/linux/capability.h
@@ -366,8 +366,16 @@ struct vfs_ns_cap_data {
 
 #define CAP_AUDIT_READ		37
 
+/*
+ * Allow usage of perf_event_open() syscall (perf_events subsystem):
+ * http://man7.org/linux/man-pages/man2/perf_event_open.2.html
+ * beyond the scope permitted by perf_event_paranoid kernel setting.
+ * See Documentation/admin-guide/perf-security.rst for more information.
+ */
+
+#define CAP_SYS_PERFMON		38
 
-#define CAP_LAST_CAP         CAP_AUDIT_READ
+#define CAP_LAST_CAP         CAP_SYS_PERFMON
 
 #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 7db24855e12d..bae602c623b0 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -27,9 +27,9 @@
 	    "audit_control", "setfcap"
 
 #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
-		"wake_alarm", "block_suspend", "audit_read"
+		"wake_alarm", "block_suspend", "audit_read", "sys_perfmon"
 
-#if CAP_LAST_CAP > CAP_AUDIT_READ
+#if CAP_LAST_CAP > CAP_SYS_PERFMON
 #error New capability defined, please update COMMON_CAP2_PERMS.
 #endif
 
-- 
2.20.1

