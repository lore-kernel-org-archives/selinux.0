Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A255C83001
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 07:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CA120784
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 07:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD3HQE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:16:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:28453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgD3HQE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 30 Apr 2020 03:16:04 -0400
IronPort-SDR: 9xMGMNaUYrczB0xGHi7ocA5dickWwud1WKeUCb9VS4+Yw7ag3Vk6n/RNXXGoWXeGffGzXf6Njk
 32AQBHw9APtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 00:16:03 -0700
IronPort-SDR: fUD0gyVvzpYJBfzFPfp1dgMiGx+PpiFKZUmUCEeVOlrroMQyYvNrWRkNwADKEXKq4R/Jo0uUsz
 wK5j7ZOygVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="405307891"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2020 00:16:01 -0700
Received: from [10.249.229.126] (abudanko-mobl.ccr.corp.intel.com [10.249.229.126])
        by linux.intel.com (Postfix) with ESMTP id 526905805EB;
        Thu, 30 Apr 2020 00:15:58 -0700 (PDT)
Subject: [PATCH v3 2/3] perf tool: make Perf tool aware of SELinux access
 control
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
Organization: Intel Corp.
Message-ID: <819338ce-d160-4a2f-f1aa-d756a2e7c6fc@linux.intel.com>
Date:   Thu, 30 Apr 2020 10:15:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Implement selinux sysfs check to see the system is in enforcing
mode and print warning message with pointer to check audit logs.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/cloexec.c |  4 ++--
 tools/perf/util/evsel.c   | 39 ++++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index a12872f2856a..9c8ec816261b 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -65,7 +65,7 @@ static int perf_flag_probe(void)
 		return 1;
 	}
 
-	WARN_ONCE(err != EINVAL && err != EBUSY,
+	WARN_ONCE(err != EINVAL && err != EBUSY && err != EACCES,
 		  "perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected error %d (%s)\n",
 		  err, str_error_r(err, sbuf, sizeof(sbuf)));
 
@@ -83,7 +83,7 @@ static int perf_flag_probe(void)
 	if (fd >= 0)
 		close(fd);
 
-	if (WARN_ONCE(fd < 0 && err != EBUSY,
+	if (WARN_ONCE(fd < 0 && err != EBUSY && err != EACCES,
 		      "perf_event_open(..., 0) failed unexpectedly with error %d (%s)\n",
 		      err, str_error_r(err, sbuf, sizeof(sbuf))))
 		return -1;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9fa92649adb4..bf437c059c2b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2514,32 +2514,41 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
-	int printed = 0;
+	int printed = 0, enforced = 0;
 
 	switch (err) {
 	case EPERM:
 	case EACCES:
+		printed += scnprintf(msg + printed, size - printed,
+			"Access to performance monitoring and observability operations is limited.\n");
+
+		if (!sysfs__read_int("fs/selinux/enforce", &enforced)) {
+			if (enforced) {
+				printed += scnprintf(msg + printed, size - printed,
+					"Enforced MAC policy settings (SELinux) can limit access to performance\n"
+					"monitoring and observability operations. Inspect system audit records for\n"
+					"more perf_event access control information and adjusting the policy.\n");
+			}
+		}
+
 		if (err == EPERM)
-			printed = scnprintf(msg, size,
+			printed += scnprintf(msg, size,
 				"No permission to enable %s event.\n\n",
 				perf_evsel__name(evsel));
 
 		return scnprintf(msg + printed, size - printed,
-		 "You may not have permission to collect %sstats.\n\n"
-		 "Consider tweaking /proc/sys/kernel/perf_event_paranoid,\n"
-		 "which controls use of the performance events system by\n"
-		 "unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).\n\n"
-		 "The current value is %d:\n\n"
+		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
+		 "access to performance monitoring and observability operations for users\n"
+		 "without CAP_PERFMON or CAP_SYS_ADMIN Linux capability.\n"
+		 "perf_event_paranoid setting is %d:\n"
 		 "  -1: Allow use of (almost) all events by all users\n"
 		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
-		 ">= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
-		 "      Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN\n"
-		 ">= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN\n"
-		 ">= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN\n\n"
-		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
-		 "	kernel.perf_event_paranoid = -1\n" ,
-				 target->system_wide ? "system-wide " : "",
-				 perf_event_paranoid());
+		 ">= 0: Disallow raw and ftrace function tracepoint access\n"
+		 ">= 1: Disallow CPU event access\n"
+		 ">= 2: Disallow kernel profiling\n"
+		 "To make the adjusted perf_event_paranoid setting permanent preserve it\n"
+		 "in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)",
+		 perf_event_paranoid());
 	case ENOENT:
 		return scnprintf(msg, size, "The %s event is not supported.",
 				 perf_evsel__name(evsel));
-- 
2.24.1


