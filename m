Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F700C433F5
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 15:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349643AbiEQPIB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349646AbiEQPH5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 11:07:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0CF3BA5E
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 08:07:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kq17so35305381ejb.4
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZISP39mHcx3nx1Mftku9cCV+IPBCdc6shA1g4LByjf8=;
        b=An4l/gX2QnG5kYF/gZNOvSPvU9SztYHWhsJS0ZWPmjIN4FtFoyB1ngb/pfA1WLb9RJ
         gnzQSzrO1pBL8lG1SSFIpjg0O2oaGcpTefl6SZMenzGVwrzp5ljJsfoNSyzog0gskHOq
         b6lqkAihyrEJKdu8/a0sHNpWvAJ8Imid157+JgLPMyGc1wSZ6OKeet2egFro8C6+PTlr
         RgJGCn4IinUPddSrrqrhbpk7UVESARoG8MT7rlArpbEGNplVAu8AxGIJJA+cjlfMhx8i
         7N/avESTTalnGC0N0Zz0l8LOWx7Te3UEa1P++gL5WJRtKqJyEFnVR/BzWV4JcMFaad4Z
         jOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZISP39mHcx3nx1Mftku9cCV+IPBCdc6shA1g4LByjf8=;
        b=4yu4JGzzN6MBJ9X/l/QW6/Jn5armAv+VS+jGVSmNDJtDevhbB3gdzvwDm+Pk1jNKK3
         K2ZgskhXFOQOYuxQlndh/P8uRKSWEAviUHNGVGL7iCTtzZhIh1DcE/5/ZZQbM+coCS7L
         8iej46vpS0k8NGDp3b/7eHpY36hdZ88X22VRuDp1l+J41g58h4lu7REwnYXO654MQKa6
         xmS9rpkVqy+8Vkk4Wi9i1elS7YWPuFA5th6GhoszKBTYDouaYy/R1DYXtfL15NuyV079
         uvNuj/Y0ccOKfcpwrDpkLDNZ5dnyye44pTnepLQki4FlMJlBnWft7WYeHXuGUPriEYoK
         o9Nw==
X-Gm-Message-State: AOAM5306hg9nF067hcmQhE/1bHE0BE5GTmmvdFgAXAX5/qyVnO8PFb6E
        g3c3KK6GzwIqY/Vlma942QadWOlWZqA=
X-Google-Smtp-Source: ABdhPJz5q++fFen4dhXa6MhKqEgdFXMcokUjtuThnFeFRx8hKG4oILBXxntqVZ0ZNWjjpFmKLve4+Q==
X-Received: by 2002:a17:907:3e04:b0:6f5:1132:59de with SMTP id hp4-20020a1709073e0400b006f5113259demr21234164ejc.755.1652800073278;
        Tue, 17 May 2022 08:07:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-065-249.95.112.pool.telefonica.de. [95.112.65.249])
        by smtp.gmail.com with ESMTPSA id ev6-20020a056402540600b0042aa5a74598sm4511418edb.52.2022.05.17.08.07.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:07:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 4/4] libselinux: check for truncations
Date:   Tue, 17 May 2022 17:07:48 +0200
Message-Id: <20220517150748.29542-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510182039.28771-4-cgzones@googlemail.com>
References: <20220510182039.28771-4-cgzones@googlemail.com>
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
v2:
   - add explicit casts to avoid int <-> size_t comparisons
   - ensure containing functions return -1
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
index faab7305..8a22a4cd 100644
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
+		goto out;
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

