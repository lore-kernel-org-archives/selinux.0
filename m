Return-Path: <SRS0=K0yT=Z3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA0C43603
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D924249
	for <selinux@archiver.kernel.org>; Thu,  5 Dec 2019 16:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfLEQVi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:21:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:62139 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLEQVi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 5 Dec 2019 11:21:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 08:21:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="201816551"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2019 08:21:36 -0800
Received: from [10.125.252.254] (abudanko-mobl.ccr.corp.intel.com [10.125.252.254])
        by linux.intel.com (Postfix) with ESMTP id 2D8155804A0;
        Thu,  5 Dec 2019 08:21:32 -0800 (PST)
Subject: [PATCH v1 2/3] perf/core: apply CAP_SYS_PERFMON to CPUs and kernel
 monitoring
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
Message-ID: <fdd428a9-1906-410c-99b0-c9568a72f320@linux.intel.com>
Date:   Thu, 5 Dec 2019 19:21:32 +0300
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


Enable CAP_SYS_PERFMON privileged process with secure performance monitoring
of available online CPUs, when executing code in kernel and user modes.

For backward compatibility reasons performance monitoring functionality of 
perf_events subsystem remains available under CAP_SYS_ADMIN but its usage for
secure performance monitoring use cases is discouraged with respect to the
introduced CAP_SYS_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/linux/perf_event.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 34c7c6910026..e8dc8411de9a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1285,7 +1285,8 @@ static inline int perf_is_paranoid(void)
 
 static inline int perf_allow_kernel(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
+	if (sysctl_perf_event_paranoid > 1 &&
+	   !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)))
 		return -EACCES;
 
 	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
@@ -1293,7 +1294,8 @@ static inline int perf_allow_kernel(struct perf_event_attr *attr)
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
+	if (sysctl_perf_event_paranoid > 0 &&
+	    !(capable(CAP_SYS_PERFMON) || capable(CAP_SYS_ADMIN)))
 		return -EACCES;
 
 	return security_perf_event_open(attr, PERF_SECURITY_CPU);
-- 
2.20.1

