Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F8C433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Oct 2022 16:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJKQHP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJKQHP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Oct 2022 12:07:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E0A5209D
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 09:07:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s30so20856819eds.1
        for <selinux@vger.kernel.org>; Tue, 11 Oct 2022 09:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1VU/ApITVInT965CVP/9rzpcHKHYtr2XSiQ8Ofkh/w=;
        b=DCVNUWFoK+Eh9U0SnEEmd1nDLwCzd3UU2EBuDBa6EaJnfSlxnmXu4hKxQqmsFYovja
         SeOv+wPsbjUHidMWg5lAqVbHe8Mh/px3RhyatmnVQU5pzOaFacGzuacy55ZM15Y7oQR8
         np+vIyFMYEtIq6Ly/hGCBtubqiZ8Ty1C1kQYDoWujztqtgm0F/KKpuZJ7kFCEWg40dOH
         RtMqTdFTjSQomsrbFtN96KdExCLFUjc6KBaEZwy/zRcos5XaNG1ROGdX48tW8zHMWyOg
         PKm9hMy1rBnpP+edtA8JzlbglZq6doUyxCRqaL46vLAJI4gtMjnCyStGTpW4QYBNJ04/
         27ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1VU/ApITVInT965CVP/9rzpcHKHYtr2XSiQ8Ofkh/w=;
        b=Wxg44BXVtyi5edJgSA9bvE9It5B1+qsN+6HlADhExuNg+qOTclVEXd130vbQngrDtR
         H+sqa9OZdIBzo2djxt8ysiBBQykaScyWytboD3AcFcWC6zkTAOo37faHVUwJ1FyBfQ0S
         coalUqKTLQdtm8ZSOIUti9aSoY403lPd/9qt2Wynh4+1mPr97Iz9fICPubn73x6bkMW7
         1dKnIJOSJ4SHPdiacC76pXOhkYoafhHrtmUKyxPRgxbji6t+TvKXQKRAlwUgnEzdkIZY
         s462GSoCtrV5QfmyTps2eV3E19FImNe3wFFzHyqKEoeyhagyeUHK6CLDzQ06f+Il0vw5
         eXvg==
X-Gm-Message-State: ACrzQf3zdW3m2eBtOeKpuXnTJJ+ntxBVpfyNUVTUT1XkZkAgbhwOCz5B
        JRjB1NhMvddty7JAAcZeAGc=
X-Google-Smtp-Source: AMsMyM4Teet4XZaezMow6Of0sNRo0QBz4U25PqRHIyEYsLbPKhfbPd4+RloMHdF1+6UZDMxY7YUBqQ==
X-Received: by 2002:aa7:db07:0:b0:458:f6e5:ab71 with SMTP id t7-20020aa7db07000000b00458f6e5ab71mr24152309eds.330.1665504432574;
        Tue, 11 Oct 2022 09:07:12 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-152-095.77.3.pool.telefonica.de. [77.3.152.95])
        by smtp.gmail.com with ESMTPSA id d6-20020a50f686000000b00459e3a3f3ddsm9592936edn.79.2022.10.11.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:07:12 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     debian-dpkg@lists.debian.org
Cc:     guillem@debian.org, selinux@vger.kernel.org
Subject: [DPKG PATCH] selinux: install log callback to filter messages
Date:   Tue, 11 Oct 2022 18:07:00 +0200
Message-Id: <20221011160700.82258-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since libselinux 3.2, via commit 05bdc03130d7 ("libselinux: use kernel
status page by default") [1], selinux_status_updated(3) will issue log
messages on enforcing changes and policy loads.  dpkg is only interested
in whether the policy changed to then reload the SELinux label database.

Ignore non-relevant log messages and forward messages of type error,
warning and avc (which should be treated as error if not audited
according to selinux_set_callback(3)).

Example (the missing newline is a libselinux bug [2]):

    Unpacking valgrind-dbg (1:3.19.0-1) ...                                                                                                │
    uavc:  op=setenforce lsm=selinux enforcing=0 res=1Preparing to unpack .../vnstati_2.9-1_amd64.deb ...

See also https://github.com/rpm-software-management/rpm/pull/2201

[1]: https://github.com/SELinuxProject/selinux/commit/05bdc03130d741e53e1fb45a958d0a2c184be503
[2]: https://lore.kernel.org/selinux/20221011112733.194079-1-plautrba@redhat.com/
---
 src/common/selinux.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/src/common/selinux.c b/src/common/selinux.c
index 07f87a3dd..c123fb924 100644
--- a/src/common/selinux.c
+++ b/src/common/selinux.c
@@ -44,6 +44,33 @@
 static struct selabel_handle *sehandle;
 #endif
 
+#ifdef WITH_LIBSELINUX
+DPKG_ATTR_PRINTF(2)
+static int log_callback(int type, const char *fmt, ...)
+{
+	char *msg;
+	va_list ap;
+
+	switch (type) {
+	case SELINUX_ERROR:
+	case SELINUX_WARNING:
+	case SELINUX_AVC:
+		break;
+	default:
+		return 0;
+	}
+
+	va_start(ap, fmt);
+	m_vasprintf(&msg, fmt, ap);
+	va_end(ap);
+
+	warning("libselinux:  %s", msg);
+	free(msg);
+
+	return 0;
+}
+#endif
+
 void
 dpkg_selabel_load(void)
 {
@@ -65,9 +92,7 @@ dpkg_selabel_load(void)
 		if (rc < 0)
 			ohshit(_("cannot open security status notification channel"));
 
-		/* XXX: We could use selinux_set_callback() to redirect the
-		 * errors from the other SELinux calls, but that does not seem
-		 * worth it right now. */
+		selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) { .func_log = log_callback });
 	} else if (selinux_enabled && selinux_status_updated()) {
 		/* The SELinux policy got updated in the kernel, usually after
 		 * upgrading the package shipping it, we need to reload. */
-- 
2.37.2

