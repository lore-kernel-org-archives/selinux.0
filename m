Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDADC433EF
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiETMn6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiETMn5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 08:43:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1191666A5
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 05:43:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i40so10640875eda.7
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=p2PAXHm9Awp1JGUyDH3OTTFP5Y4/J1ug5thvnL+FFgI=;
        b=bpPQTVkVF/twDwT4ag6fsamWTh9aXBabcOI7XcfJdsUTDXObVTNBJgkNKUnJnCHc43
         c0sy7wtZELmhO+F6AnIH+2hrrue84CsAMS5Fob9nujM8CQRkQT9rw9lskANSw9nJLT1Y
         GD8Xoq4DWDlQlKC9JeGkCB/miFiSaA5NFBx1kZffkRibQ0NhfA5aRIm7uRk6PoIZYVAl
         4Q25hF9cXMxTotX9IQfDN1nIAmStt8NjbMfmxSoaZqWfRxsezhjp430R5hXl+FeEhvsS
         y9KxuS42Qfu370WIaCTjjAeCk3gVzevKFm/iXb78qF1jUMbQaxu5t0sNCOVN2rToADJi
         04oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2PAXHm9Awp1JGUyDH3OTTFP5Y4/J1ug5thvnL+FFgI=;
        b=SKyz3frS+xAjrxOSDWQX/l2s3oOG9V5+6ZRXPpaoa5XRHmvK7TO1R5sHQ3lvqcSlO4
         q9fCJcS/tiLPA2U6sF3GoDlcxBuscPwwVGL4666+eoauYisZI/q3yjGzZh3vcT/wuWSv
         OtXA2YmALAENleBvSnwlYfmmgWuYs4R5QjHwGcgO8BrNIsw6973bvcWauxIrKcBOQBfw
         7mK2S8sjxWk59MAghgYQPPaIFdazFc0f+mq8UolFR6jUjrxUvvOrvrrMPQZvpqBXQv6o
         Xt3ku1ksnG8b4Yd9AMdi/pyOawS+5GEUPCPUN7UG/lTejxeYqzv0wFzeVYTuaSDp0O/X
         eDVQ==
X-Gm-Message-State: AOAM532OeLogWWvdQ1TGZRHMsHr/NlIbUb3YQSNOj0T0ctH4/aEcxPrb
        jPVhtXIfR5PrPfO05EbmRe5rS08r6fA=
X-Google-Smtp-Source: ABdhPJw1P9ptSx7i4+WK1BcsAxSsFxvussfd9iS18rzxAT01y/qsLURhTuLZ4i5Dhexb2dXHfgBtNg==
X-Received: by 2002:aa7:c506:0:b0:42a:b067:cbe7 with SMTP id o6-20020aa7c506000000b0042ab067cbe7mr10725725edq.4.1653050632658;
        Fri, 20 May 2022 05:43:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id l25-20020a056402231900b0042ad05632a1sm4263903eda.23.2022.05.20.05.43.51
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:43:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 4/4] libselinux: check for truncations
Date:   Fri, 20 May 2022 14:43:23 +0200
Message-Id: <20220520124323.7575-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517150748.29542-1-cgzones@googlemail.com>
References: <20220517150748.29542-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check for truncations when building or copying strings involving user
input.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v3:
   - free buf in error branch in security_canonicalize_context_raw()
v2:
   - add explicit casts to avoid int <-> size_t comparisons
   - ensure containing functions return -1

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/canonicalize_context.c |  6 +++++-
 libselinux/src/compute_av.c           |  8 +++++++-
 libselinux/src/compute_create.c       |  7 +++++++
 libselinux/src/compute_member.c       |  8 +++++++-
 libselinux/src/compute_relabel.c      |  8 +++++++-
 libselinux/src/compute_user.c         |  8 +++++++-
 libselinux/src/selinux_restorecon.c   | 10 +++++++++-
 libselinux/src/setrans_client.c       |  8 +++++++-
 8 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canonicalize_context.c
index faab7305..6af8491d 100644
--- a/libselinux/src/canonicalize_context.c
+++ b/libselinux/src/canonicalize_context.c
@@ -33,7 +33,11 @@ int security_canonicalize_context_raw(const char * con,
 		ret = -1;
 		goto out;
 	}
-	strncpy(buf, con, size);
+	if (strlcpy(buf, con, size) >= size) {
+		errno = EOVERFLOW;
+		ret = -1;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf) + 1);
 	if (ret < 0)
diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c
index 9d17339d..354a19e1 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -40,8 +40,14 @@ int security_compute_av_flags_raw(const char * scon,
 	}
 
 	kclass = unmap_class(tclass);
-	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
+
+	ret = snprintf(buf, len, "%s %s %hu %x", scon, tcon,
 		 kclass, unmap_perm(tclass, requested));
+	if (ret < 0 || (size_t)ret >= len) {
+		errno = EOVERFLOW;
+		ret = -1;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index 1d75714d..e9f3c96a 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -75,8 +75,15 @@ int security_compute_create_name_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
+
 	len = snprintf(buf, size, "%s %s %hu",
 		       scon, tcon, unmap_class(tclass));
+	if (len < 0 || (size_t)len >= size) {
+		errno = EOVERFLOW;
+		ret = -1;
+		goto out2;
+	}
+
 	if (objname &&
 	    object_name_encode(objname, buf + len, size - len) < 0) {
 		errno = ENAMETOOLONG;
diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_member.c
index 16234b79..53d2f559 100644
--- a/libselinux/src/compute_member.c
+++ b/libselinux/src/compute_member.c
@@ -36,7 +36,13 @@ int security_compute_member_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+
+	ret = snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+	if (ret < 0 || (size_t)ret >= size) {
+		errno = EOVERFLOW;
+		ret = -1;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_relabel.c
index dd20d652..9c0a2304 100644
--- a/libselinux/src/compute_relabel.c
+++ b/libselinux/src/compute_relabel.c
@@ -36,7 +36,13 @@ int security_compute_relabel_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+
+	ret = snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+	if (ret < 0 || (size_t)ret >= size) {
+		errno = EOVERFLOW;
+		ret = -1;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index ae5e7b4a..f55f945a 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -38,7 +38,13 @@ int security_compute_user_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s", scon, user);
+
+	ret = snprintf(buf, size, "%s %s", scon, user);
+	if (ret < 0 || (size_t)ret >= size) {
+		errno = EOVERFLOW;
+		ret = -1;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 9dd6be81..ab79f543 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -961,7 +961,15 @@ loop_body:
 			}
 			/* fall through */
 		default:
-			strcpy(ent_path, ftsent->fts_path);
+			if (strlcpy(ent_path, ftsent->fts_path, sizeof(ent_path)) >= sizeof(ent_path)) {
+				selinux_log(SELINUX_ERROR,
+					    "Path name too long on %s.\n",
+					    ftsent->fts_path);
+				errno = ENAMETOOLONG;
+				state->error = -1;
+				state->abort = true;
+				goto finish;
+			}
 
 			if (state->parallel)
 				pthread_mutex_unlock(&state->mutex);
diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index faa12681..920f9032 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -66,7 +66,13 @@ static int setransd_open(void)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
-	strncpy(addr.sun_path, SETRANS_UNIX_SOCKET, sizeof(addr.sun_path));
+
+	if (strlcpy(addr.sun_path, SETRANS_UNIX_SOCKET, sizeof(addr.sun_path)) >= sizeof(addr.sun_path)) {
+		close(fd);
+		errno = EOVERFLOW;
+		return -1;
+	}
+
 	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
 		close(fd);
 		return -1;
-- 
2.36.1

