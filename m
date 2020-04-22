Return-Path: <SRS0=Xew/=6G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27931C55185
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5772077D
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 14:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgDVOo7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:44:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:63947 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDVOo6 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 22 Apr 2020 10:44:58 -0400
IronPort-SDR: utVCDyUzPh+V4NRjbJt02diWMoVmVNxb6zUYj9b3N/Km0NVAkSHJh/DloBBYq0xHITqWri1eSp
 EpWBXQW6e9Gg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:44:57 -0700
IronPort-SDR: 1L91aZrf0wL+5BL4j6agU5mLFDRPbJdAcwATbeYYmRxG0ptjt1/yQAhEnUWHeBnKRtSz2lLq0P
 CdEq6w7fKEvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="247481908"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 22 Apr 2020 07:44:57 -0700
Received: from [10.249.227.181] (abudanko-mobl.ccr.corp.intel.com [10.249.227.181])
        by linux.intel.com (Postfix) with ESMTP id D361E5802C9;
        Wed, 22 Apr 2020 07:44:54 -0700 (PDT)
Subject: [PATCH v2 2/4] perf docs: substitute CAP_SYS_ADMIN with CAP_PERFMON
 where needed
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
Message-ID: <f1b48de9-e2b7-d20b-3686-3a15b73ef45c@linux.intel.com>
Date:   Wed, 22 Apr 2020 17:44:53 +0300
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


Substitute CAP_SYS_ADMIN with CAP_PERFMON in the docs where admin
is mentioned. CAP_SYS_ADMIN still works in keeping with user space
backward compatibility approach.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 2 +-
 tools/perf/design.txt                      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 456fdcbf26ac..176597be0755 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -687,7 +687,7 @@ The v4.2 kernel introduced support for a context switch metadata event,
 PERF_RECORD_SWITCH, which allows unprivileged users to see when their processes
 are scheduled out and in, just not by whom, which is left for the
 PERF_RECORD_SWITCH_CPU_WIDE, that is only accessible in system wide context,
-which in turn requires CAP_SYS_ADMIN.
+which in turn requires CAP_PERFMON.
 
 Please see the 45ac1403f564 ("perf: Add PERF_RECORD_SWITCH to indicate context
 switches") commit, that introduces these metadata events for further info.
diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index a42fab308ff6..6fd879440c40 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -258,8 +258,7 @@ gets schedule to. Per task counters can be created by any user, for
 their own tasks.
 
 A 'pid == -1' and 'cpu == x' counter is a per CPU counter that counts
-all events on CPU-x. Per CPU counters need CAP_PERFMON or CAP_SYS_ADMIN
-privilege.
+all events on CPU-x. Per CPU counters need CAP_PERFMON privilege.
 
 The 'flags' parameter is currently unused and must be zero.
 
-- 
2.24.1


