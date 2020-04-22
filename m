Return-Path: <SRS0=Xew/=6G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B850C55185
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 14:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247CF2074B
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 14:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDVOoH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:44:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:61020 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgDVOoH (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 22 Apr 2020 10:44:07 -0400
IronPort-SDR: vypBW5ngPsnXF4APKXfI2fXCT9I12TfORsgJj9Hr5FRfxZ3SD/eDgaQKT44xk5bkDoq6HBZGck
 6O7ZJIodn6RA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:44:06 -0700
IronPort-SDR: tLSeGNEbtY+85s7yBaxF7jZJh/mZinNLoZ7gHB8m1WmRElRkeWeEIgkV4+xWqIVsA9DifsKRT8
 O01TQ7miLIJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="429936844"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2020 07:44:06 -0700
Received: from [10.249.227.181] (abudanko-mobl.ccr.corp.intel.com [10.249.227.181])
        by linux.intel.com (Postfix) with ESMTP id B23335802C9;
        Wed, 22 Apr 2020 07:44:03 -0700 (PDT)
Subject: [PATCH v2 1/4] perf trace: substitute CAP_SYS_ADMIN with CAP_PERFMON
 in error message
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
Organization: Intel Corp.
Message-ID: <450d035a-c192-10e5-1c28-664ccae3e46e@linux.intel.com>
Date:   Wed, 22 Apr 2020 17:44:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Update error message to mention CAP_PERFMON only. CAP_SYS_ADMIN still
works in keeping with user space backward compatibility approach.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 55eda54240fb..39d43ad02f30 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -288,7 +288,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	      perf_cap__capable(CAP_SYS_ADMIN))) {
 		pr_err("ftrace only works for %s!\n",
 #ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
+		"users with the CAP_PERFMON capability"
 #else
 		"root"
 #endif
-- 
2.24.1

