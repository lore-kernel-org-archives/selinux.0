Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0EC433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01D920791
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 14:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brQMO6gX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgHMOtZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMOtW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 10:49:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA38C061383
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 07:49:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w17so6922736ybl.9
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=SEalPAaL/L400EFRhNDiBFOTi7pT/2kjH95anJxxgxI=;
        b=brQMO6gXvTrV2iIjuWTZ0a0xYUjqCYajx8AKbapPdz63kQ6krMyNmy5nRKklvp5bCn
         w41xOH4gOa0rGhWRgSSPP+zInZZipzm3Xqq+DqPQ7S6/3oroY0FUngVjJ9aQmrLaagsy
         OHY51yBqks31Yed941hnElUusZA5AB/Bs4X3me0ZHTrw+Zo6PKgEUeZdpdsnmCI96tKx
         i+4R3An/1umtigsoxZ5Tzx/ZAkI1K5WmIIv/E0C8amv1gcjVbo+CtTn6ZZtyB07QTzEj
         R49z2EfrHfvj5x3mCe4nJ33AYh0SEeiuvFmbeoKRsSas+zIFsnrflu0c8vsesRZNb54c
         byWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=SEalPAaL/L400EFRhNDiBFOTi7pT/2kjH95anJxxgxI=;
        b=neDFAn55UVbIfjWKrVChdyoI25QtF6Y83BTS1UYSNDcqblc7pGtUPHtLo4ckSet9/M
         wNI41qahrE9bFPHyTPBED1Yh3b0klvg1nXGUidIiN566EjpgV0lnvJP4gl3MDYul5nhX
         bjXFYDOIzm6+3cD16/e2/mAht8M/DMi6vWK6SUbXmgNRQcvFFwjfSmm68cDJwa9Nm0Cq
         sqlpb2rnCwN3Xt8Y6clFVXEynSVFEYYLSEghkKQrXx/kA6IonHbUEom7kgKTE67uaTfy
         KoV5lkpgOWZXcKcOA1JfNDsm+wgAN6ulDkKSBGaEnLPaY9oh8OKn/Pi6RKshmiB3H42Z
         1JXw==
X-Gm-Message-State: AOAM5335R8rznbP8t7vVvDf0MPpxIuu/PzKlZ/Pxoc/pbiUaDFMEvJpI
        puFXe8UZ0cApaW9r43+Ul7ficwS92A==
X-Google-Smtp-Source: ABdhPJzZtAT/LPYngsPA4jm9kXHeRMw5dGr+JkxZ1qFWnJ/D4JgdZUTLHH3l2MhXFU0U+oHTuGsdHjNawA==
X-Received: by 2002:a25:8689:: with SMTP id z9mr7576775ybk.226.1597330160576;
 Thu, 13 Aug 2020 07:49:20 -0700 (PDT)
Date:   Thu, 13 Aug 2020 16:48:58 +0200
Message-Id: <20200813144914.737306-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 1/2] selinux: add tracepoint on denials
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
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
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

[1] https://source.android.com/devices/tech/debug/native_stack_dump

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Suggested-by: Joel Fernandes <joelaf@google.com>
Reviewed-by: Peter Enderborg <peter.enderborg@sony.com>
---
v2 changes:
- update changelog to include usage examples

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
2.28.0.236.gb10cc79966-goog

