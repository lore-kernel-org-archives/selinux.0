Return-Path: <SRS0=CFpO=6I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5265EC2BA1A
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 06:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE4420774
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 06:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDXGtd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:49:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:40409 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgDXGtd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 Apr 2020 02:49:33 -0400
IronPort-SDR: r5ICoHa4/pH8LXMXsQwaWqU9vwC7deplj+YWv1ad9cSa/Qj8GZDHiFmNxKhgFTP5PjufAtdv2u
 aOuQ2DI7wjfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 23:49:32 -0700
IronPort-SDR: Ljg+v7YIu1xTz76lcT5LXHp5XR5ykTEqFz0weRpwWkPt0WIsu3crKvxGafHvIG1NXQhrTSGxcp
 pN05dHxsu+hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="259720879"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2020 23:49:32 -0700
Received: from [10.249.228.69] (abudanko-mobl.ccr.corp.intel.com [10.249.228.69])
        by linux.intel.com (Postfix) with ESMTP id 674D5580100;
        Thu, 23 Apr 2020 23:49:30 -0700 (PDT)
Subject: [PATCH v3 1/3] perf docs: extend CAP_SYS_ADMIN with CAP_PERFMON where
 needed
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
References: <d7cec72d-cc3c-381b-38cd-20e7242bfda8@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f79344ba-e861-2710-e3d1-2bcccea85348@linux.intel.com>
Date:   Fri, 24 Apr 2020 09:49:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d7cec72d-cc3c-381b-38cd-20e7242bfda8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Extend CAP_SYS_ADMIN with CAP_PERFMON in the docs.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 456fdcbf26ac..832408a54c1c 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -687,7 +687,7 @@ The v4.2 kernel introduced support for a context switch metadata event,
 PERF_RECORD_SWITCH, which allows unprivileged users to see when their processes
 are scheduled out and in, just not by whom, which is left for the
 PERF_RECORD_SWITCH_CPU_WIDE, that is only accessible in system wide context,
-which in turn requires CAP_SYS_ADMIN.
+which in turn requires CAP_PERFMON or CAP_SYS_ADMIN.
 
 Please see the 45ac1403f564 ("perf: Add PERF_RECORD_SWITCH to indicate context
 switches") commit, that introduces these metadata events for further info.
-- 
2.24.1

