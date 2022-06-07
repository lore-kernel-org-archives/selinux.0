Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB0C43334
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbiFGROT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbiFGROS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 13:14:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C226E102774
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 10:14:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id fd25so23884200edb.3
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2x1UPG/zHUHU3hCA4hFKmwS5HB7/7TTwWwlGYMcyuk4=;
        b=Cf0sTzOzia+WBFU/Ks92EaTq7BuqyXBkrEw4BPiml6A82oVQVJg2QGhyNrVQ5FzM2y
         /R9Ys4U1P3eP6W8Ol4rjN/g6CGxl4RGd+AnhtxYU6sjwSsh8u6YrBU4Fm7Qkhmk9A69A
         SgedBWi7OXQN/RfOuIooOkXut6ufMtVVL7URzgRZ3XOQEfKwTEu+F7cQFmqcXBosz6WE
         mwvOyL19wnGphc4IVCCfcz59kG7U734VPqE4uWtEUOHPH3mpQe9VL85ASRVNZBJZWL5L
         urvgIr5ar169mbpDnH5zOyXsaJRDRX58JuiV6PTnobwYh+7RxH2FiQcEqdGQ9g/oYMUW
         rESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2x1UPG/zHUHU3hCA4hFKmwS5HB7/7TTwWwlGYMcyuk4=;
        b=3upv5xroDxEJ2YC9FGE9yiYxlWLUyX5QIS3C1awZZIlwxAx9nmErTL9gPcYjiLmCx8
         Ypey3mfcWIl1U8F+0ZyWrk7KTx/7eZpo04UinHWk8A0hDAv2ea4C99c9eX2RzZo7ACAD
         VNr0mxb8G6lLIyHXdU5IYNeNbKMIxZHZviLpwzdKyn767EOeSObnpChynwTAu61vAYki
         3+MIWMGwXagLc1Mi8JJahhdJAo8++XafE3R4iyOrke5M1XdJZcVrkktYRgDHq80cpAfx
         vJIbNEY1Bsuno8FTsG1Yk2/BDMEuCHbB5+6hiECQj2fiRhdo+xpylPJcYkzTJydCLNio
         ornA==
X-Gm-Message-State: AOAM532dvyby9JGeZil6zlyiTByKce9fSEGYvTNVEcjvBPvGeJ2oAJbM
        rNtPTjAn5GTUVlX0824X7SpeRGVJog0=
X-Google-Smtp-Source: ABdhPJxj0bXrxgkVv16ht0ebYjTTCz4uW/Hwlh0MJJ6OMRVI7PZsFRILgc7Tyq/Ike1pj4LafIOL2Q==
X-Received: by 2002:a05:6402:1f03:b0:42b:38ed:a9ff with SMTP id b3-20020a0564021f0300b0042b38eda9ffmr34417432edb.218.1654622055281;
        Tue, 07 Jun 2022 10:14:15 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-054-039.77.8.pool.telefonica.de. [77.8.54.39])
        by smtp.gmail.com with ESMTPSA id c10-20020a056402120a00b0042dd1d3d571sm10654437edw.26.2022.06.07.10.14.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:14:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v4 4/4] libselinux: check for truncations
Date:   Tue,  7 Jun 2022 19:14:09 +0200
Message-Id: <20220607171409.42034-1-cgzones@googlemail.com>
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
v4:
   - rebase on top of de285252 ("Revert "libselinux: restorecon: pin
     file to avoid TOCTOU issues"")
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
 libselinux/src/selinux_restorecon.c   | 11 ++++++++++-
 libselinux/src/setrans_client.c       |  8 +++++++-
 8 files changed, 57 insertions(+), 7 deletions(-)

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
index 9f5b326c..66e6a4a2 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -954,7 +954,16 @@ loop_body:
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
+
 			ent_st = *ftsent->fts_statp;
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

