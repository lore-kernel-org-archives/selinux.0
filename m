Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C18C2D0BF
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B2E2464D
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfLEQW2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:22:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:4819 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbfLEQW2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 5 Dec 2019 11:22:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 08:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="263324514"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2019 08:22:27 -0800
Received: from [10.125.252.254] (abudanko-mobl.ccr.corp.intel.com [10.125.252.254])
        by linux.intel.com (Postfix) with ESMTP id BD5715804A0;
        Thu,  5 Dec 2019 08:22:23 -0800 (PST)
Subject: [PATCH v1 3/3] perf tool: extend Perf tool with CAP_SYS_PERFMON
 support
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
Message-ID: <bbb40b80-be40-335a-c7b7-61fb4bce20d2@linux.intel.com>
Date:   Thu, 5 Dec 2019 19:22:22 +0300
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


Extend error messages to mention CAP_SYS_PERFMON capability as an option
to substitute CAP_SYS_ADMIN credentials where applicable. 

Make perf_event_paranoid_check() to be aware of CAP_SYS_PERFMON in case
perf_event_paranoid value >= 0.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/design.txt   |  3 ++-
 tools/perf/util/cap.h   |  4 ++++
 tools/perf/util/evsel.c | 10 +++++-----
 tools/perf/util/util.c  | 15 +++++++++++++--
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index 0453ba26cdbd..71755b3e1303 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -258,7 +258,8 @@ gets schedule to. Per task counters can be created by any user, for
 their own tasks.
 
 A 'pid == -1' and 'cpu == x' counter is a per CPU counter that counts
-all events on CPU-x. Per CPU counters need CAP_SYS_ADMIN privilege.
+all events on CPU-x. Per CPU counters need CAP_SYS_PERFMON or
+CAP_SYS_ADMIN privilege.
 
 The 'flags' parameter is currently unused and must be zero.
 
diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
index 051dc590ceee..0f79fbf6638b 100644
--- a/tools/perf/util/cap.h
+++ b/tools/perf/util/cap.h
@@ -29,4 +29,8 @@ static inline bool perf_cap__capable(int cap __maybe_unused)
 #define CAP_SYSLOG	34
 #endif
 
+#ifndef CAP_SYS_PERFMON
+#define CAP_SYS_PERFMON 38
+#endif
+
 #endif /* __PERF_CAP_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f4dea055b080..3a46325e3702 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2468,14 +2468,14 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 		 "You may not have permission to collect %sstats.\n\n"
 		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
 		 "which controls use of the performance events system by\n"
-		 "unprivileged users (without CAP_SYS_ADMIN).\n\n"
+		 "unprivileged users (without CAP_SYS_PERFMON or CAP_SYS_ADMIN).\n\n"
 		 "The current value is %d:\n\n"
 		 "  -1: Allow use of (almost) all events by all users\n"
 		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
-		 ">= 0: Disallow ftrace function tracepoint by users without CAP_SYS_ADMIN\n"
-		 "      Disallow raw tracepoint access by users without CAP_SYS_ADMIN\n"
-		 ">= 1: Disallow CPU event access by users without CAP_SYS_ADMIN\n"
-		 ">= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN\n\n"
+		 ">= 0: Disallow ftrace function tracepoint by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n"
+		 "      Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n"
+		 ">= 1: Disallow CPU event access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n"
+		 ">= 2: Disallow kernel profiling by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n\n"
 		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
 		 "	kernel.perf_event_paranoid = -1\n" ,
 				 target->system_wide ? "system-wide " : "",
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 969ae560dad9..d8334fa97c85 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -271,8 +271,19 @@ int perf_event_paranoid(void)
 
 bool perf_event_paranoid_check(int max_level)
 {
-	return perf_cap__capable(CAP_SYS_ADMIN) ||
-			perf_event_paranoid() <= max_level;
+	bool res = false;
+
+	res = perf_cap__capable(CAP_SYS_ADMIN);
+
+	if (!res) {
+		if (max_level >= 0)
+			res = perf_cap__capable(CAP_SYS_PERFMON);
+	}
+
+	if (!res)
+		res = perf_event_paranoid() <= max_level;
+
+	return res;
 }
 
 static int
-- 
2.20.1

