Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F9C28E82
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E41204FD
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpdDkZjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgHFIF4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgHFIEN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 04:04:13 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C365C061575
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 01:04:09 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id gg11so7322819ejb.6
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 01:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=LcmumI/w/Hm4tyicPdUaUNyCK6OWHY8oQP8ZiSpx1Fw=;
        b=vpdDkZjdkXkYqtDgFNnezY0woangi9BN3lrLOrCQwyy4EsZMw0fsi+t57Qm3ccQVBS
         00a062McIzIhQbGYSxG5vsmjITQcYN7jdm5ab6WLIZ3FLWXcdmuCfuA88SxfBreLLCfc
         HE5HJAeSzQuQwkCwyHszArHeK6OIbutuS6bkiaRzXgo+P9NmpiU1tR/lerHt/LVOtw7T
         MOKsDoVAUy/jqkpdqagqAQviyhdOWfW0KowT2CG40pmUz2xRC5Vi0vE0um3Ad4yf3ddS
         k1epQ1Skpk0dMnKQmsw8O1rt7rQp6giPZOPMzCnhoGNv6YE6U1yX3g2Uk0DRUVOltRkA
         G4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=LcmumI/w/Hm4tyicPdUaUNyCK6OWHY8oQP8ZiSpx1Fw=;
        b=MQLK7hi1BcvFNBeTxdv7FkI21c1iefoVsfRqBdLkS7lq3s7q92Pcwkjupn6et1hNtV
         hzTR/kD/wd6G9Kf8l5ko0KsbknN/j8vdJENOk+/NWHKfh+O349b7XMn5EiCORxSfyVOu
         frlT//UHyPdhyBUh4pzNYwMx5LIouuHlDbX4rmZb5ji+DsccMEuZ3t0qCpGUmq5Bem9L
         H5iteS72PlR8utWR1dGwVgGWEwkN9pLWcdGmxr1tOupVuA/Gtb98SMEXtoa+6gEwJ+8q
         Fhbrfo+uCQTZuur2IqGJY3poQKmZEMvNUjAyxXxpXYxhUlGwuBsMmNF+q9UQW0VrB1rf
         WdaQ==
X-Gm-Message-State: AOAM533KlhrtCYa2i92+pnPFyxqouPXU2JFFf7XkXTy1P7OsoN2L+4Tb
        MVb0mfSvMKcOwzZxjqxnRvwJNQAMKg==
X-Google-Smtp-Source: ABdhPJzUel/EPiNJ94rUHLsYATT2qjBrxXNXOu8GqzYUfz1/Vy6keCPUJzpkyY5F3u6H+k+5Pnu0DEgsgA==
X-Received: by 2002:a17:906:d930:: with SMTP id rn16mr3267737ejb.330.1596701044913;
 Thu, 06 Aug 2020 01:04:04 -0700 (PDT)
Date:   Thu,  6 Aug 2020 10:03:41 +0200
Message-Id: <20200806080358.3124505-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/2] selinux: add tracepoint on denials
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
2.28.0.163.g6104cc2f0b6-goog

