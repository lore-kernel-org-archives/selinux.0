Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA21EC2BBFD
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA17420739
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796794;
	bh=8BaehHL+XwhrO6lxdvYxo5llL3H9pC0YPOrBU5W0ve0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RV7hyma269HOJ5vAInvM0ovBemHfHxgf1iHQ6uZslyE+n0PuB0ixRfuxyeMZwCs3H
	 aqFeDsWZrMQeIG1cdB6yvbXFHrBw5FLDp+5mDWtiSFJYtXg/aVcBZyrfH0EQlKadY1
	 RgSs3knlDcCkiiAucv3RHw8rjmdZm45KDmM9ubYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgDMQxH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731938AbgDMQxF (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 13 Apr 2020 12:53:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113652137B;
        Mon, 13 Apr 2020 16:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796784;
        bh=8BaehHL+XwhrO6lxdvYxo5llL3H9pC0YPOrBU5W0ve0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQvCns7bp5ivoVnL8LUena+caaD7KfSakGvU0UeHevRfX9cwVC02zpImFi0db5w5T
         o+Tmtbxiz8Tc5qrq4rkpquJ0fta2ld3eNSYHqSyQGCq2CqH1vAqyXhBglSBN75p77d
         0FLDElKbBSL8JNWtiZgdLL62Q0NlNE644nFtDOR0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephane Eranian <eranian@google.com>,
        intel-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/26] trace/bpf_trace: Open access for CAP_PERFMON privileged process
Date:   Mon, 13 Apr 2020 13:51:47 -0300
Message-Id: <20200413165203.1816-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Open access to bpf_trace monitoring for CAP_PERFMON privileged process.
Providing the access under CAP_PERFMON capability singly, without the
rest of CAP_SYS_ADMIN credentials, excludes chances to misuse the
credentials and makes operation more secure.

CAP_PERFMON implements the principle of least privilege for performance
monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39
principle of least privilege: A security design principle that states
that a process or program be granted only those privileges (e.g.,
capabilities) necessary to accomplish its legitimate function, and only
for the time that such privileges are actually required)

For backward compatibility reasons access to bpf_trace monitoring
remains open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN
usage for secure bpf_trace monitoring is discouraged with respect to
CAP_PERFMON capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: linux-doc@vger.kernel.org
Cc: linux-man@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: selinux@vger.kernel.org
Link: http://lore.kernel.org/lkml/c0a0ae47-8b6e-ff3e-416b-3cd1faaf71c0@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 68250d433bd7..770b742fc922 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1416,7 +1416,7 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 	u32 *ids, prog_cnt, ids_len;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!perfmon_capable())
 		return -EPERM;
 	if (event->attr.type != PERF_TYPE_TRACEPOINT)
 		return -EINVAL;
-- 
2.21.1

