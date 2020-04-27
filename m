Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F8C4CECD
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BD22073C
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz3bRdYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgD0UXu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726758AbgD0UXt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8C8C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so113092pjb.5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wiVoXHCZfOfoKdhi+sHyBpp+DYMa9HEsPbAr/QfHrLk=;
        b=Jz3bRdYRe4VJZwPfbBe/G50w1eydjl2N1Vuour6b2QyKdHYpAKX11JabUyP22LLzeU
         GOehsWgG/EjdAllfMCtZ53EuI3COyNxEV+8zxDJfUHcrZ+j7Zf7jYU/3L1+BmJslsaxb
         zQ1TPznoKMANWOezSZLGsirixEsvLNMdb8lNu6/h0fIaMrHehdQ5UAuUFy3gcpqVsmqe
         c/ZRHIior6YxsWTP3KIXFzxxewNedwmppxgCO6HLbq/Dzgrd/lbv4gBxEMPR3Y8yEno+
         WwzSHQhaMYxEA/1sejsM2U1GhVpaxVJrejn0RW/GsLdEVXYbrkkuu6zMwaMJWJZ59lUm
         DycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wiVoXHCZfOfoKdhi+sHyBpp+DYMa9HEsPbAr/QfHrLk=;
        b=EnKvJjMnbQnVGTt231m6AboC6OhvAwmzWH4m6OlRIrtVgIIWVkm1D27AT0a1VHrwtR
         rGZ/oOT3ANxZDmeL0ogeZ1FV46d3mMCPRLmMAaSft14HK5q/UFtzZ4tRgDqR8BEITgX9
         D/fnA4w/FT7sWYx65FIXfrNsUNrlMP5B7SIh9IBPDJzXR94d/5IJSyoRCcQ8dtGQC7VU
         dZ60A8kSCFaJe2iTVJk0G82Vqk9GR4Zy4QXJ3Gct5R69bbttGhC4L4woTNxbTqXD3INm
         +2JTv1M907B1fXnve7XvOfkN8Y99x0aAHqJwy8Wnh4ivuZB6d5rTMO6m+5xSISRFzBxb
         hIPg==
X-Gm-Message-State: AGi0PuYYRfo1wBwtGLmYvzZRCGLzYNbPacQUevRVO4Ehr+0QFap3LAo1
        KM3rV/vS1jVDy3A+T5IKDiA=
X-Google-Smtp-Source: APiQypJ6Jr3MKTICLLufvuBjQxBjJr0VCSbbSjtSmycONxpjNleEz7uaQ2WZMjb55EsR/9KdYpbgKw==
X-Received: by 2002:a17:902:bf46:: with SMTP id u6mr16813996pls.318.1588019027852;
        Mon, 27 Apr 2020 13:23:47 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:47 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 15/18] selinux_check_passwd_access: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:12 -0500
Message-Id: <20200427202315.4943-16-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Update the one internal tree caller in the same file to
call selinux_check_passwd_access2.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 7 ++++++-
 libselinux/src/checkAccess.c         | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 5633cf40607d..aaf28ffdf9be 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -630,7 +630,12 @@ extern int selinux_check_access(const char * scon, const char * tcon, const char
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
-extern int selinux_check_passwd_access(access_vector_t requested);
+extern int selinux_check_passwd_access(access_vector_t requested)
+#ifdef __GNUC__
+  __attribute__ ((deprecated("Use selinux_check_access")))
+#endif
+;
+
 extern int checkPasswdAccess(access_vector_t requested)
 #ifdef __GNUC__
    __attribute__ ((deprecated("Use selinux_check_access")))
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 677e2ecd7df4..3491fded7895 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -64,7 +64,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
 }
 
-int selinux_check_passwd_access(access_vector_t requested)
+static int selinux_check_passwd_access_internal(access_vector_t requested)
 {
 	int status = -1;
 	char *user_context;
@@ -99,8 +99,11 @@ int selinux_check_passwd_access(access_vector_t requested)
 	return status;
 }
 
+int selinux_check_passwd_access(access_vector_t requested) {
+	return selinux_check_passwd_access_internal(requested);
+}
 
 int checkPasswdAccess(access_vector_t requested)
 {
-	return selinux_check_passwd_access(requested);
+	return selinux_check_passwd_access_internal(requested);
 }
-- 
2.17.1

