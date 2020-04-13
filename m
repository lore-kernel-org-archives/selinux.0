Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD39EC2BA19
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71D520857
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586796868;
	bh=blwsC7ILMJIN/7IR1dWYCrGRlPxdNYlBnvdX5628Ph0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sCBCXJZyvgjziM0B4aU3zxmSd/M3Ih5eJxXdmcTtgC2dXONPzSiNpgzTF1PN7YoFJ
	 JfqupVbr1WIjMPl92B3k9b/j6Pc9V9SOgrHWep4aVatpz8PSubBkY7z4ejSPkx2huY
	 rUUNRzI9sL0vlCrFoMMrX9fuGU0+XAgF/E3cPlB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgDMQxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732024AbgDMQxi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 13 Apr 2020 12:53:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 111E920936;
        Mon, 13 Apr 2020 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796818;
        bh=blwsC7ILMJIN/7IR1dWYCrGRlPxdNYlBnvdX5628Ph0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jac6//yEcwWpKMfxYQMdquOzQ1ZFVLVD11UhJFVlki6s4LhHNDXKWMH1NxA/wiWmq
         yc5LAojBWQ1Rm8/b8b910aPHpVF2kbDuDjLevy9x/wXSXKRPLCQjIo6Q+F3zzQyOVj
         kitizemhMviJEZ7eLkgsaSY3Rvp/CT07ie4uhbrk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        intel-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/26] doc/admin-guide: update kernel.rst with CAP_PERFMON information
Date:   Mon, 13 Apr 2020 13:51:53 -0300
Message-Id: <20200413165203.1816-17-acme@kernel.org>
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

Update the kernel.rst documentation file with the information related to
usage of CAP_PERFMON capability to secure performance monitoring and
observability operations in system.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: linux-doc@vger.kernel.org
Cc: linux-man@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: selinux@vger.kernel.org
Link: http://lore.kernel.org/lkml/84c32383-14a2-fa35-16b6-f9e59bd37240@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 335696d3360d..aaa5bbcd1e33 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -709,7 +709,13 @@ perf_event_paranoid
 ===================
 
 Controls use of the performance events system by unprivileged
-users (without CAP_SYS_ADMIN).  The default value is 2.
+users (without CAP_PERFMON).  The default value is 2.
+
+For backward compatibility reasons access to system performance
+monitoring and observability remains open for CAP_SYS_ADMIN
+privileged processes but CAP_SYS_ADMIN usage for secure system
+performance monitoring and observability operations is discouraged
+with respect to CAP_PERFMON use cases.
 
 ===  ==================================================================
  -1  Allow use of (almost) all events by all users.
@@ -718,13 +724,13 @@ users (without CAP_SYS_ADMIN).  The default value is 2.
      ``CAP_IPC_LOCK``.
 
 >=0  Disallow ftrace function tracepoint by users without
-     ``CAP_SYS_ADMIN``.
+     ``CAP_PERFMON``.
 
-     Disallow raw tracepoint access by users without ``CAP_SYS_ADMIN``.
+     Disallow raw tracepoint access by users without ``CAP_PERFMON``.
 
->=1  Disallow CPU event access by users without ``CAP_SYS_ADMIN``.
+>=1  Disallow CPU event access by users without ``CAP_PERFMON``.
 
->=2  Disallow kernel profiling by users without ``CAP_SYS_ADMIN``.
+>=2  Disallow kernel profiling by users without ``CAP_PERFMON``.
 ===  ==================================================================
 
 
-- 
2.21.1

