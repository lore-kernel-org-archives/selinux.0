Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A0C433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A099B2177B
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EU+fJH0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgHUOJR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgHUOJO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 10:09:14 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F400C061574
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 07:09:14 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id n12so792422ejz.6
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=WbkBQ4+3z/Ot6sbqqq8NLsjBfrTpm7bxNJKwF4zPNxs=;
        b=EU+fJH0P2XOsXa2F3Nzicvv6xCPoAKfudHYonTUsulkHtN42K6PJ8CGEH/iwXcYdh/
         NsiSjQrdSMeLPWAlcODAwVY6KS9rOgo78reUXgPm+Ps5R6kDglPyp282hLGbpvAiS3lk
         wXN5GJmY9vvmENFW3T/SWgRTFd+GgOyWXsuy9SQZQyLB447hy4yUHKefFPyBZIXXn1Ob
         82Fx+T1IEvjfZVSEp1jVgrq9koBj0/wsq/Synd7JWYQMF1cPvAlN4xvISeXFiY8tjf/4
         w+M5EeJpDD2QjjOWRsQ4WX7KJKoy8ZXxr5tydVAjhnqcHetxbMAX9ioGNW2OHyLYuJkO
         WtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=WbkBQ4+3z/Ot6sbqqq8NLsjBfrTpm7bxNJKwF4zPNxs=;
        b=AAv6c1pZ3aWxZFiTAonlAvi+52TA3OGAuE+7FgX441CKkkXZmpfvUsFk9gl9+geF80
         3qXMW3XN4mWV7kzgSHLYJDvCgCequa1t4ybGEZhlyDZn7yI6XEtEDYT2wlrecFKScGED
         +AfiBfJDhB34w/Evkmkg7mV2P8BoJFfdvuLe208k1TFmt5pF71CVB0ENnxbA8EsHSX0f
         E/3oxSoAJ7zRTxfT6ffXsnpphXTcwxAiyG6b+dwmtABk5ll5mT4bie58pIxSwETnm/HN
         cxQUXxenWBB+hUHM+HRHu82NWG9XWWRLoDqdfP6QRK34OkrMjQo32Tkt4eEXgl2GZtx4
         eSWQ==
X-Gm-Message-State: AOAM532iud6w267f6dYkWMhDACVD3q6MPXePp+n0EfBIUwI61OC+4qPH
        PbCsIYb1WihKKQHCg984Sp1zn6pFqA==
X-Google-Smtp-Source: ABdhPJycYwIlgR1/3MQcUQpCA/jvMjkw1ymd9AtU6+k+l7ChKK3QeTYfeyDAta7wOHPvSUFI+S+KmQmAxQ==
X-Received: from tweek1.zrh.corp.google.com ([2a00:79e0:61:100:f693:9fff:fef4:a93d])
 (user=tweek job=sendgmr) by 2002:a17:906:c1d7:: with SMTP id
 bw23mr3089611ejb.315.1598018951604; Fri, 21 Aug 2020 07:09:11 -0700 (PDT)
Date:   Fri, 21 Aug 2020 16:08:21 +0200
In-Reply-To: <20200821140836.3707282-1-tweek@google.com>
Message-Id: <20200821140836.3707282-2-tweek@google.com>
Mime-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 1/2] selinux: add tracepoint on audited events
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The audit data currently captures which process and which target
is responsible for a denial. There is no data on where exactly in the
process that call occurred. Debugging can be made easier by being able to
reconstruct the unified kernel and userland stack traces [1]. Add a
tracepoint on the SELinux denials which can then be used by userland
(i.e. perf).

Although this patch could manually be added by each OS developer to
trouble shoot a denial, adding it to the kernel streamlines the
developers workflow.

It is possible to use perf for monitoring the event:
  # perf record -e avc:selinux_audited -g -a
  ^C
  # perf report -g
  [...]
      6.40%     6.40%  audited=3D800000 tclass=3D4
               |
                  __libc_start_main
                  |
                  |--4.60%--__GI___ioctl
                  |          entry_SYSCALL_64
                  |          do_syscall_64
                  |          __x64_sys_ioctl
                  |          ksys_ioctl
                  |          binder_ioctl
                  |          binder_set_nice
                  |          can_nice
                  |          capable
                  |          security_capable
                  |          cred_has_capability.isra.0
                  |          slow_avc_audit
                  |          common_lsm_audit
                  |          avc_audit_post_callback
                  |          avc_audit_post_callback
                  |

It is also possible to use the ftrace interface:
  # echo 1 > /sys/kernel/debug/tracing/events/avc/selinux_audited/enable
  # cat /sys/kernel/debug/tracing/trace
  tracer: nop
  entries-in-buffer/entries-written: 1/1   #P:8
  [...]
  dmesg-3624  [001] 13072.325358: selinux_denied: audited=3D800000 tclass=
=3D4

The tclass value can be mapped to a class by searching
security/selinux/flask.h. The audited value is a bit field of the
permissions described in security/selinux/av_permissions.h for the
corresponding class.

[1] https://source.android.com/devices/tech/debug/native_stack_dump

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Suggested-by: Joel Fernandes <joelaf@google.com>
Reviewed-by: Peter Enderborg <peter.enderborg@sony.com>
---
 MAINTAINERS                |  1 +
 include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
 security/selinux/avc.c     |  5 +++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/avc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c8e8232c65da..0efaea0e144c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15426,6 +15426,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/gi=
t/pcmoore/selinux.git
 F:	Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
 F:	Documentation/ABI/obsolete/sysfs-selinux-disable
 F:	Documentation/admin-guide/LSM/SELinux.rst
+F:	include/trace/events/avc.h
 F:	include/uapi/linux/selinux_netlink.h
 F:	scripts/selinux/
 F:	security/selinux/
diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
new file mode 100644
index 000000000000..07c058a9bbcd
--- /dev/null
+++ b/include/trace/events/avc.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Thi=C3=A9baud Weksteen <tweek@google.com>
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM avc
+
+#if !defined(_TRACE_SELINUX_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SELINUX_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(selinux_audited,
+
+	TP_PROTO(struct selinux_audit_data *sad),
+
+	TP_ARGS(sad),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, tclass)
+		__field(unsigned int, audited)
+	),
+
+	TP_fast_assign(
+		__entry->tclass =3D sad->tclass;
+		__entry->audited =3D sad->audited;
+	),
+
+	TP_printk("tclass=3D%u audited=3D%x",
+		__entry->tclass,
+		__entry->audited)
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..b0a0af778b70 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -31,6 +31,9 @@
 #include "avc_ss.h"
 #include "classmap.h"
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/avc.h>
+
 #define AVC_CACHE_SLOTS			512
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
@@ -706,6 +709,8 @@ static void avc_audit_post_callback(struct audit_buffer=
 *ab, void *a)
 	u32 scontext_len;
 	int rc;
=20
+	trace_selinux_audited(sad);
+
 	rc =3D security_sid_to_context(sad->state, sad->ssid, &scontext,
 				     &scontext_len);
 	if (rc)
--=20
2.28.0.297.g1956fa8f8d-goog

