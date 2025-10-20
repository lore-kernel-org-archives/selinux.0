Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F0265296
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982133; cv=none; b=mMrVRNHSD9/7rl72+jtsqw91qF01xox6GFdG+sf1tYhsDl7bkhjxHgi9nvuFcE3E+Mwe4ZxuTnF1erw2uxU88GS/P0ZsGMPfBNllBa/pRE0TmRUQbeh/QNXXxSG99sOwDRWEUA/otI7zr5w6C+8qtFFDcoXFbZhqEhDcsJfVXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982133; c=relaxed/simple;
	bh=jjhALjynFyPWdmg9jT6aB2utL81HZQqiUG3RXCDBpRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDgoxgZo/TEKhZTFZut3g+yUALMsmZzmFu2nCHMbiqVIz6N59N5WyvjQpay81SREM3F5j86zm3Iw2CAxUqQFU1+PQlfdpi4PV9jtFl1W7djNtbY/hfAFKhPt4QDty7mBBdEaCryVMOGXJaz5KSo8EAZLgchq2LhDPwWq8gCZ+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NASw0U12; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NASw0U12"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46b303f755aso48629425e9.1
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760982130; x=1761586930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XlHdde2e+y3oQLZ4t8YIvzksB9BvGuZMEtdFyeZn7Q=;
        b=NASw0U12y3xlhmwOiZJLfXvB94ejR8QpT21joEEeF5+bmeWxDKMNEm50TAjpVQawU4
         j/iZQmHm8N7m1hZ29f6+jqv3g0eKhVbTmZX6oilcGMuYMFEKEv4x6PObKhojYbl/r8VB
         iCOXaA+SgYwbOqbHDkviE4rGuVLEpZU7o/V/wrFiuPndf8gzKGqk+DwqPyvZuiZn9oxJ
         4dTIKsLc+5Ckk80+hZxwOTnvfiWFXLj1y6q1dZI6iBnG0AX7PaLUA5XHOMrhvetyQpuL
         NzgehksqqkJyuhFx+lS+kI14gStRf/JpFNuNMfmoehTNCpgiKgc9yns8jki/dsMzBwER
         rWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982130; x=1761586930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XlHdde2e+y3oQLZ4t8YIvzksB9BvGuZMEtdFyeZn7Q=;
        b=opMB9fW9AQMP7PJbUut9kybCF8WLgIkRxJHU8GBemBTKQ/XtEXEgQmvZkskkse2KDQ
         wub+eOS0NRd8RGigIhmmKa82UbX5dW7Ac3vagsYVBs32q/nANP2BodwMgFlbkuEivzAR
         62bksGO0OIomd7YOWmivV6mX/I4gdYbs2g/wg2RgoknfC6xSCtPASArm8R7Zrh3D/o8q
         daz0M3TCGxcnTrg3VHSgUka/WjjXztw5adDYsCtjSsFi9YA3oEOx4WW3TvunT9DH7ctH
         +RFafu+VvsbFokhrPENkM1wpPkkhkp23UNlL9sEeLh9oqLVKHTse+EqrztfoxRlj64XC
         ZtoA==
X-Forwarded-Encrypted: i=1; AJvYcCUL3aP60IPA9OY4Csedw02RBUcSpMQFsMzFTm3VbUYu7UPPJgVKnwcZruHhGbpg/hY/KaTD3teA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Mvci/zowda7N47coUy4nCxxW2ah5nrpIpjFKFSsiQohYXhD/
	SPK54TmeAdAt8bmzFhsG5Bhps7Fa4g+BusSAMt/Jj1rqVOi7X7XnzVMp
X-Gm-Gg: ASbGncu5VXrDBUysT8nwtTT+mK1kShRHjUT37Dgce+Q9o0+mLm8Ji9xRAT1ZyyUzWfW
	t1lnxuJEsArB40qjZ0rZ1Skyvd8YBezozBbS75Rtyyxvo+TNf3yxFMRSewEYyuVVQq+w2inMRMh
	s2QadCa0F/Qag7A5VuGBuhfXLBJoSDyb6YMSKPvvC9zkR6sWqjPIteFNJGalT5gUs4oUomiKZ4g
	YtAgs4J1ZI7TFcwU2kEAuvUss0EuLbO/Lx4up9ZvTZ3CHVGS5dKcGXNMh0Ie8jfdR1WrECsG+Aj
	d2/ABtmhgQ6O0uKIuetPVCzUUhaABV9URJasnX7RuO+lAT8/1HZSShJc3EyPzplChI6AZlYCTxY
	ue+MAWglsD3CEo99xc8FXpDkxsC9HA/tJ5f64MaZg8Q5VRUrRJ8WDQJ4nN+01Ryd4jV4aDMj7
X-Google-Smtp-Source: AGHT+IE7GjatNOEXmqNpNPy6o8vvcO1NcavHbFMg6fw2sBMik+b9HomRlZNIfaAdSPOyqH8k8mdj3A==
X-Received: by 2002:a05:600c:871a:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-471179177camr113018815e9.28.1760982130100;
        Mon, 20 Oct 2025 10:42:10 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba01bsm16061913f8f.41.2025.10.20.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:42:09 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v2] libsemanage: semanage_store: recursively create SEMANAGE_ROOT
Date: Mon, 20 Oct 2025 18:40:27 +0100
Message-ID: <20251020174027.11343-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAEjxPJ7VktYWYreg4PMUSTeoxRvBBoD0HVb1bsXdsach+j7PyA@mail.gmail.com>
References: <CAEjxPJ7VktYWYreg4PMUSTeoxRvBBoD0HVb1bsXdsach+j7PyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In package build/install environments, when semodule(8) is passed the
`--path` option, it is expected that it creates the entire directory
tree for the policy root.

Some package managers warn or error if permissions do not align between
the tree on the existing system and the build environment about to be
merged. To make sure this is a non-issue, create the tree of the policy
root with 0755 permissions (in line with standards for `/var/lib`) and
then chmod the final path to the more restrictive 0700 permissions. As
the contents being placed in the policy root are security sensitive,
error instead of warning if we fail to chown the policy root to 0700.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/semanage_store.c | 59 ++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

v2: fix-up buffer length check, use memcpy instead of strncpy: we check
    the size already.

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 1731c5e8..e3048c08 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -491,6 +491,45 @@ char *semanage_conf_path(void)
 	return semanage_conf;
 }
 
+/* Recursively create a directory from a path string.
+ * Returns 0 on success, -errno on failure.
+ */
+static int mkdir_recursive(const char *path, mode_t mode)
+{
+	if (!path || !*path) {
+		return -EINVAL;
+	}
+
+	char path_buffer[PATH_MAX] = {0};
+	size_t len = strlen(path);
+	/* + 1 for nullterm.  */
+	if (len + 1 > sizeof(path_buffer)) {
+		return -ENAMETOOLONG;
+	}
+
+	/* + 1 for nullterm.  */
+	memcpy(path_buffer, path, len + 1);
+
+	/* trim possible trailing slashes, except if '/' is the entire path.  */
+	while (len > 1 && path_buffer[len - 1] == '/') {
+		path_buffer[--len] = '\0';
+	}
+
+	for (char *pos = path_buffer + 1, *slash; (slash = strchr(pos, '/')); pos = slash + 1) {
+		*slash = '\0';
+		if (mkdir(path_buffer, mode) != 0 && errno != EEXIST) {
+			return -errno;
+		}
+		*slash = '/';
+	}
+
+	if (mkdir(path_buffer, mode) != 0 && errno != EEXIST) {
+		return -errno;
+	}
+
+	return 0;
+}
+
 /**************** functions that create module store ***************/
 
 /* Check that the semanage store exists.  If 'create' is non-zero then
@@ -506,14 +545,20 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
-			mask = umask(0077);
-			if (mkdir(path, S_IRWXU) == -1) {
-				umask(mask);
-				ERR(sh, "Could not create module store at %s.",
-				    path);
+			/* First we create directories recursively with standard permissions so that
+			   we don't screw up ownership of toplevel dirs such as `/var` in pkgmgr
+			   environments.  */
+			const int r = mkdir_recursive(path, (mode_t)0755);
+			if (r != 0) {
+				ERR(sh, "Could not create module store at %s: %s.", path, strerror(-r));
+				return -2;
+			}
+			/* Now that we've created the directory tree, we set the permissions of the
+			   target path to 0700. */
+			if (chmod(path, (mode_t)0700) != 0) {
+				ERR(sh, "Failed to chown module store at %s: %s.", path, strerror(errno));
 				return -2;
 			}
-			umask(mask);
 		} else {
 			if (create)
 				ERR(sh,
@@ -529,6 +574,8 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	}
+	/* We no longer need to use mkdir_recursive at this point: the toplevel
+	   directory hierarchy has been created by now.  */
 	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
-- 
2.51.0

