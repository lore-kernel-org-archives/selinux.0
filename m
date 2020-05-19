Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C60DC433DF
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 07:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035B520709
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 07:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgESHeX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 03:34:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:6668 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgESHeX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 19 May 2020 03:34:23 -0400
IronPort-SDR: BXL9YI/ypoiJbt+8oE0oFIUWFgjvCj/dRrO1qYOn4c/bTcYdSBpYDF5RsyoViPg2fbBf/9I3ef
 4+SNzMrn629g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 00:34:22 -0700
IronPort-SDR: Blu/9zIQ7wFZBkWMbQjohPpeAbG6EwVuLapMalKVYr5osIL8cdT841osR8otHH1WiNs9LWOHFE
 WTb4NRLHDbmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="308331886"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 19 May 2020 00:34:21 -0700
Received: from [10.249.225.158] (abudanko-mobl.ccr.corp.intel.com [10.249.225.158])
        by linux.intel.com (Postfix) with ESMTP id 52D6C580613;
        Tue, 19 May 2020 00:34:19 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] perf tool: make Perf tool aware of SELinux access
 control
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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
 <819338ce-d160-4a2f-f1aa-d756a2e7c6fc@linux.intel.com>
 <20200518155843.GF24211@kernel.org>
 <d10fd4b0-d516-cf16-4379-c5299d0c5cc3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <74f8d079-39ef-756e-7e43-ba4c897fd441@linux.intel.com>
Date:   Tue, 19 May 2020 10:34:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d10fd4b0-d516-cf16-4379-c5299d0c5cc3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 18.05.2020 19:43, Alexey Budankov wrote:
> 
> On 18.05.2020 18:58, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Apr 30, 2020 at 10:15:57AM +0300, Alexey Budankov escreveu:
>>>
>>> Implement selinux sysfs check to see the system is in enforcing
>>> mode and print warning message with pointer to check audit logs.
>>
>> There were some changes in this area meanwhile, so I had to apply the
>> evsel.c by hand, when I push this please double check everything is ok,
> 
> Will do. I appreciate your integrating effort.

Checked at tmp.perf/core branch. The message looks like this:

[root@nntvtune39 acme.tmp]# tools/perf/perf stat
Error:
Access to performance monitoring and observability operations is limited.
Enforced MAC policy settings (SELinux) can limit access to performance
monitoring and observability operations. Inspect system audit records for
more perf_event access control information and adjusting the policy.
Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
access to performance monitoring and observability operations for users
without CAP_PERFMON or CAP_SYS_ADMIN Linux capability.
perf_event_paranoid setting is 2:
  -1: Allow use of (almost) all events by all users
      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>= 0: Disallow raw and ftrace function tracepoint access
>= 1: Disallow CPU event access
>= 2: Disallow kernel profiling
To make the adjusted perf_event_paranoid setting permanent preserve it
in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)

Edited patch at security.txt didn't apply cleanly. It requires white space
prior tab in the first block for wake_alarm etc till perfmon:

---8<---
diff -Nura a/policy/flask/access_vectors b/policy/flask/access_vectors
--- a/policy/flask/access_vectors	2020-02-04 18:19:53.000000000 +0300
+++ b/policy/flask/access_vectors	2020-02-28 23:37:25.000000000 +0300
@@ -174,6 +174,7 @@
 	wake_alarm
 	block_suspend
 	audit_read
+	perfmon
 }

 #
@@ -1099,3 +1100,15 @@

 class xdp_socket
 inherits socket
+
+class perf_event
+{
+	open
+	cpu
+	kernel
+	tracepoint
+	read
+	write
+}
+
+
diff -Nura a/policy/flask/security_classes b/policy/flask/security_classes
--- a/policy/flask/security_classes	2020-02-04 18:19:53.000000000 +0300
+++ b/policy/flask/security_classes	2020-02-28 21:35:17.000000000 +0300
@@ -200,4 +200,6 @@

 class xdp_socket

+class perf_event
+
 # FLASK

---8<---

~Alexey
