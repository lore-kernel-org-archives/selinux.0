Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBCEC433EF
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 18:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbiEJSYt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 14:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbiEJSYr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 14:24:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655EE33E18
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ks9so28190395ejb.2
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=m0ZZIM1jYTPOi/+Cnxi42QrrjY8MArH1CZ7vK8K+Q2U=;
        b=LVdTaSgL+A+vKqE81u/p5mHGL9qxeD5uP7winkhlndnfzPy+SOeIFzbCYcHAEHCPp2
         3bVOl0zQebkojEC6Uo4SjXjkaphYCNASziWpcMo0FNjktAFqnhAtG8w8i/pzCS97DIa+
         47jHi4hfp9CT6bVtGl2jtvUiokPbeo8n9kGqA2jM6HLzfSykYjfmRMmOze0tK3xmCWog
         Kh1DZpW6ibswF7LOXdV/bbb+4QafP9VkltZvpg7ibixpDvMPAwGYTI4A9IGPqqmwbkq4
         3QbcuP7EzYXP++GBNMpK2Zt/H7qWxMZEnpOQC0nZOoK+IYBbfr66oRnZSl8yqFnSkxZr
         eLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0ZZIM1jYTPOi/+Cnxi42QrrjY8MArH1CZ7vK8K+Q2U=;
        b=kzSsEumBSvdnO7POCebt4jd8OaOS3zKATFvxCkeLKn2CWkx/84h0Ek1vmBWkyeUDN+
         3leLknYzThJLnVlpYtA9QNLl8X1PHJ2GdJ6blsySuBWHUrqsF7iaI1EnpJvjMZlFou9V
         8rkK2s9AMI7ZkFQwUSd6ZgkFYZlP2s6bSbuQY+U85bexDyjN1WgQ8cbpuLnCQa66S90N
         A1IIX8hmJgycG6T5SCubt/vwqEmbDLS3VOwMuoKMAKbSlGGJr+XiGZVeik6tnA+9Oisx
         l5bpNfoAtbNKUGMoSXgI8Vi3DkgYsnhe7eZtnZrdOLEfUggHFynzdO3qt3uXxKGnI2Fu
         DBCw==
X-Gm-Message-State: AOAM532og3ThY9YefaDcpTuHbc6tG9P1hWGsgcT+eb5MnP70Gws4ZJK+
        2oBFieceUrwpigk1SAWrAMhc/1Fj8ls=
X-Google-Smtp-Source: ABdhPJzwWpDkZEHIQiupEfJrgJ7cc/m10mCl1cKQP5CNGYbewLcNz17fxHXcIs6vk6LRrGLioUDFrA==
X-Received: by 2002:a17:906:6a10:b0:6f5:5e4:9d5 with SMTP id qw16-20020a1709066a1000b006f505e409d5mr20482202ejc.122.1652206845838;
        Tue, 10 May 2022 11:20:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-078-050-241-079.78.50.pool.telefonica.de. [78.50.241.79])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402154300b0042877d166fdsm5339947edx.38.2022.05.10.11.20.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:20:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/4] libselinux: check for truncations
Date:   Tue, 10 May 2022 20:20:39 +0200
Message-Id: <20220510182039.28771-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510182039.28771-1-cgzones@googlemail.com>
References: <20220510182039.28771-1-cgzones@googlemail.com>
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
 libselinux/src/canonicalize_context.c |  6 +++++-
 libselinux/src/compute_av.c           |  7 ++++++-
 libselinux/src/compute_create.c       |  6 ++++++
 libselinux/src/compute_member.c       |  7 ++++++-
 libselinux/src/compute_relabel.c      |  7 ++++++-
 libselinux/src/compute_user.c         |  7 ++++++-
 libselinux/src/selinux_restorecon.c   | 11 ++++++++++-
 libselinux/src/setrans_client.c       |  8 +++++++-
 8 files changed, 52 insertions(+), 7 deletions(-)

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
index 9d17339d..e513be6a 100644
--- a/libselinux/src/compute_av.c
+++ b/libselinux/src/compute_av.c
@@ -40,8 +40,13 @@ int security_compute_av_flags_raw(const char * scon,
 	}
 
 	kclass = unmap_class(tclass);
-	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
+
+	ret = snprintf(buf, len, "%s %s %hu %x", scon, tcon,
 		 kclass, unmap_perm(tclass, requested));
+	if (ret < 0 || ret >= len) {
+		errno = EOVERFLOW;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index 1d75714d..4cba2d2f 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -75,8 +75,14 @@ int security_compute_create_name_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
+
 	len = snprintf(buf, size, "%s %s %hu",
 		       scon, tcon, unmap_class(tclass));
+	if (len < 0 || len >= size) {
+		errno = EOVERFLOW;
+		goto out2;
+	}
+
 	if (objname &&
 	    object_name_encode(objname, buf + len, size - len) < 0) {
 		errno = ENAMETOOLONG;
diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_member.c
index 16234b79..82d76080 100644
--- a/libselinux/src/compute_member.c
+++ b/libselinux/src/compute_member.c
@@ -36,7 +36,12 @@ int security_compute_member_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+
+	ret = snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+	if (ret < 0 || ret >= size) {
+		errno = EOVERFLOW;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute_relabel.c
index dd20d652..96259bac 100644
--- a/libselinux/src/compute_relabel.c
+++ b/libselinux/src/compute_relabel.c
@@ -36,7 +36,12 @@ int security_compute_relabel_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+
+	ret = snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+	if (ret < 0 || ret >= size) {
+		errno = EOVERFLOW;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index ae5e7b4a..23a551e4 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -38,7 +38,12 @@ int security_compute_user_raw(const char * scon,
 		ret = -1;
 		goto out;
 	}
-	snprintf(buf, size, "%s %s", scon, user);
+
+	ret = snprintf(buf, size, "%s %s", scon, user);
+	if (ret < 0 || ret >= size) {
+		errno = EOVERFLOW;
+		goto out2;
+	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index e6192912..7436dab5 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -940,7 +940,16 @@ loop_body:
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

