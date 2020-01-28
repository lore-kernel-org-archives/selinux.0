Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9920C35240
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 06:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37CC2467E
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 06:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgA1GM2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:12:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:32365 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgA1GM2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 28 Jan 2020 01:12:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 22:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,372,1574150400"; 
   d="scan'208";a="221990078"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2020 22:12:27 -0800
Received: from [10.252.25.124] (abudanko-mobl.ccr.corp.intel.com [10.252.25.124])
        by linux.intel.com (Postfix) with ESMTP id 909725803C1;
        Mon, 27 Jan 2020 22:12:19 -0800 (PST)
Subject: [PATCH v6 07/10] powerpc/perf: open access for CAP_PERFMON privileged
 process
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>, Will Deacon <will@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        oprofile-list@lists.sf.net
References: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3ce8fc61-a61f-5efc-9167-94f5d39b6f1b@linux.intel.com>
Date:   Tue, 28 Jan 2020 09:12:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <74d524ab-ac11-a7b8-1052-eba10f117e09@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Open access to monitoring for CAP_PERFMON privileged process.
Providing the access under CAP_PERFMON capability singly, without the
rest of CAP_SYS_ADMIN credentials, excludes chances to misuse the
credentials and makes operation more secure.

CAP_PERFMON implements the principal of least privilege for performance
monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39 principle
of least privilege: A security design principle that states that a process
or program be granted only those privileges (e.g., capabilities) necessary
to accomplish its legitimate function, and only for the time that such
privileges are actually required)

For backward compatibility reasons access to the monitoring remains open
for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for secure
monitoring is discouraged with respect to CAP_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/powerpc/perf/imc-pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index cb50a9e1fd2d..e837717492e4 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -898,7 +898,7 @@ static int thread_imc_event_init(struct perf_event *event)
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!perfmon_capable())
 		return -EACCES;
 
 	/* Sampling not supported */
@@ -1307,7 +1307,7 @@ static int trace_imc_event_init(struct perf_event *event)
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!perfmon_capable())
 		return -EACCES;
 
 	/* Return if this is a couting event */
-- 
2.20.1


