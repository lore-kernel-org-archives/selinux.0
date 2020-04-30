Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60437C83002
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 07:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CE220784
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 07:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgD3HPq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:15:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:42192 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgD3HPq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 30 Apr 2020 03:15:46 -0400
IronPort-SDR: Q2MYjqK/DWU2uBBjpP5LMybLyroO7l3FjiTQc5dcrq/Cg0+85lYJCM9A4x6SNZjOLrYOvKrmBf
 nMf3WX0S1oFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 00:15:45 -0700
IronPort-SDR: n91qNzkX1l82MhoicLietInMyXKYMW9JTz+X32HY2znoZXSR+IlKxECRjzEqNA7wScoLvfkA1I
 zx0N07yLJvOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="249668452"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 30 Apr 2020 00:15:45 -0700
Received: from [10.249.229.126] (abudanko-mobl.ccr.corp.intel.com [10.249.229.126])
        by linux.intel.com (Postfix) with ESMTP id 32F63580646;
        Thu, 30 Apr 2020 00:15:21 -0700 (PDT)
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
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3b19cf79-f02d-04b4-b8b1-0039ac023b2c@linux.intel.com>
Date:   Thu, 30 Apr 2020 10:15:21 +0300
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


