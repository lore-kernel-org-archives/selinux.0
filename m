Return-Path: <SRS0=CFpO=6I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A2AC2BA1A
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 06:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D15F2098B
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 06:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgDXGpn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:45:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:23572 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgDXGpn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 Apr 2020 02:45:43 -0400
IronPort-SDR: eSVOhYbpE/RyQWdfBypNZZb8Uo9cSrmR/CJSiUGb7391vDsV+W7a45lnLsHerIcbBpPwpTLLYe
 qCHFSvLqF7yQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 23:45:42 -0700
IronPort-SDR: UFNXNo99gi3xSih5Mq+nRTg6KILpleImFdiu+1kkn0Jnd7ve0e89Sogsrwh6VVH+oGkDfDwL7A
 p0O+pGedimpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,310,1583222400"; 
   d="scan'208";a="291465264"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2020 23:45:42 -0700
Received: from [10.249.228.69] (abudanko-mobl.ccr.corp.intel.com [10.249.228.69])
        by linux.intel.com (Postfix) with ESMTP id 30F71580100;
        Thu, 23 Apr 2020 23:45:40 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3 0/3] perf: make Perf tool aware of SELinux access control
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
Organization: Intel Corp.
Message-ID: <d7cec72d-cc3c-381b-38cd-20e7242bfda8@linux.intel.com>
Date:   Fri, 24 Apr 2020 09:45:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Changes in v3:
- mention "CAP_PERFMON or CAP_SYS_ADMIN" instead of sole CAP_PERFMON or 
  CAP_SYS_ADMIN capability in the docs and messages to support use case
  of newer Perf tool on kernel w/o CAP_PERFMON
- reverted double new line in "No permission to enable %s event.\n\n"
- updated security.txt content with new messages wording

v2: https://lore.kernel.org/lkml/66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com/

Changes in v2:
- implemented minor doc and code changes to substitute CAP_SYS_ADMIN
  with CAP_PERFMON capability;
- introduced Perf doc file with instructions on how to enable and use
  perf_event LSM hooks for mandatory access control to perf_event_open()
  syscall;

v1: https://lore.kernel.org/lkml/b8a0669e-36e4-a0e8-fd35-3dbd890d2170@linux.intel.com/

repo: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
sha1: ee097e8ee56f8867cbbf45fe2a06f6b9e660c39c


Extend Perf tool with the check of /sys/fs/selinux/enforce value and notify 
in case access to perf_event_open() syscall is restricted by the enforced 
SELinux policy settings. See new added security.txt file for exact steps
how the changes look like and how to test the patch set.

---
Alexey Budankov (3):
  perf docs: extend CAP_SYS_ADMIN with CAP_PERFMON where needed
  perf tool: make Perf tool aware of SELinux access control
  perf docs: introduce security.txt file to document related issues

 tools/perf/Documentation/perf-intel-pt.txt |   2 +-
 tools/perf/Documentation/security.txt      | 237 +++++++++++++++++++++
 tools/perf/util/cloexec.c                  |   4 +-
 tools/perf/util/evsel.c                    |  39 ++--
 4 files changed, 264 insertions(+), 18 deletions(-)
 create mode 100644 tools/perf/Documentation/security.txt

-- 
2.24.1
