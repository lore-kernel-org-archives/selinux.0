Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535661F92E
	for <selinux@vger.kernel.org>; Sat, 18 Oct 2025 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760764821; cv=none; b=qSaqVucKhMQd2wucIGINS+UtB1BchpRSTHyrQsEUksMvYR3BDPz+tXlT4yHhs4dRFGuibNocJgg6VssRw/VNqKGBwGBJI3+hH8heF/0Z6gqVPHsFvYxhKmol09PTnS5JSOhKNgRHPIncz9nbVmJIPHj9DzeA8YWBbjL3Nc/AUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760764821; c=relaxed/simple;
	bh=Y5UkCRMSH6ldQUmyKq2i2LXKiZVJmwQVqj3vPpsr2r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JR6Dcsv0TcMLFMUevsYUF3kfoMaQBXBpYWB3ak1gjts8+xysGq5ErfvgfFerl2kwc395NlZhc+aQIAZYVhTM2NSTuLb2BOAM9ISpTQ6GayBty1DQAwBX3CAPuz8b4zQ3qXSh5s2x7iAnOVLeBr9/8si5+Lrck1ehaQu+tlx2n4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ea8ke10t; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ea8ke10t"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so542195166b.3
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760764817; x=1761369617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6WIeGCGC9/5HEKB2ECG5kjh2djgHNgJuy4YbMQKudU=;
        b=ea8ke10t83gL8FRpQx28FGqmUjM13LwlvFxiZ4qflur/Ub3diBhdd1rbQL0qdcbAfB
         000ODaycQB5a2LrR94H0rt3L1Gt0HcMnqqRsYZUfLr7ykLvUBOLbsDf/pL+ZyOsaPX1N
         kYjdYBKZHvo0QqQBR2Nhs//qaHyiKhgHiNCA6BVA40qQs8yTpazUd1hb5VSYrQyNocZZ
         2ShEKSBrSz+JCZ05xzd13SRYnoGTKw3XFjXF/SPIHWkOevlrxbqDMaTdEnUQMx/ZVSYs
         EJFDcIOUq0chlyltL9mfxc/TMhJ8EFiNDANdACtvwcC6XOg4W7OUIeMmkgI51tP4gr7I
         X/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760764817; x=1761369617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6WIeGCGC9/5HEKB2ECG5kjh2djgHNgJuy4YbMQKudU=;
        b=E1LRGP58NUgxkLsR3RybDf+fKc27ntjYGBtQzsJRk0lNKDWS2PHDpsU/jHkq2+iXdO
         f/Eaccboip5puaOL2cDY4tlUEl7Tc/Rf9vEC1k2VOxn7EpAcqjOpgDeN+re3DQAE6Kvl
         /UCxZNkcmUH5eyzQUk+qPSq11nStJEQ5KIzMIvcIaW+acqv9QUtZ/9DHfVEfqvrVlIR4
         0lSnlyi/mVwasQ2/zkULU1CJEvZ0Q9jtI+GBTphGo5l36QTPScU9pLG6uerte5GkxYC+
         bUnJQ1yAK52n4fWE7SfKJ3LglWhbNi6OVl8s+tIXxnzHW8YZaBrIvGlgwr1CigwZlQCy
         OXng==
X-Gm-Message-State: AOJu0YwsGbWWkqkTcSLy113Fy0FfMZyTd2iyKuUtiNdurNzIU9sPl9Z5
	fof0CbiuiBV3RJMaRSjgO10Uzgx8prRf6FSmWlsYemWZQCAVzTB1FCaAKUqpsw==
X-Gm-Gg: ASbGncuHDelLG3RTnCiEQsbVOOjmoP13CaFZK+yJg55pnA5HEFLSnaCWG/3izXEO581
	tNppYhjKEpyihyJbN1l0Y9LehKfckQFUV4jFkr4diPPiP0vPcfzXZLuCjsKvjfeECHVoRj3zyCE
	Sfh5BxEpnx3W/Yw4wfgxTCxF2nLtpexno26PIYBl1bBgUz/pLm7X62Dl/0KJRFirYHP1KZiGIY6
	UEfcOpPGP/lwk53ujKuAvwWUe8jV2aKHQjSxZwiut5Q3SdcWLx6sZ/ODt9TsjAxHF1eICXq2H8k
	S3Y4hceakshtCL0R7uZjTCaZQHMkenmHBo2L//f5S1/SdJAZ9r90mmHC5+SoHS/nwNipMbkqfuD
	kUp11r1ibvAmMufvf5OdWQlfwYVwAiY7KlvtjeAC7d8g0BeoiU8Z4ZVa4BlSlDN24J/srE96sSb
	5KUvg=
X-Google-Smtp-Source: AGHT+IGUObIwsl414q2tK4OTFzRtWAZk/iIR0G+0R5rp6C260GogBGruG62c+s3FblWzLBCesbQdlA==
X-Received: by 2002:a17:907:3d87:b0:b33:a2ef:c7 with SMTP id a640c23a62f3a-b6475706fcdmr723357366b.55.1760764817203;
        Fri, 17 Oct 2025 22:20:17 -0700 (PDT)
Received: from graphite ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2bd2sm149494966b.10.2025.10.17.22.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:20:16 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libsemanage: semanage_store: recursively create SEMANAGE_ROOT
Date: Sat, 18 Oct 2025 06:19:45 +0100
Message-ID: <20251018051945.51425-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.51.0
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
erorr instead of warning if we fail to chown the policy root to 0700.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libsemanage/src/semanage_store.c | 58 ++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 1731c5e8..c1425f15 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -491,6 +491,44 @@ char *semanage_conf_path(void)
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
+	if (len + 1 >= sizeof(path_buffer)) {
+		return -ENAMETOOLONG;
+	}
+
+	strncpy(path_buffer, path, sizeof(path_buffer) - 1);
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
@@ -506,14 +544,20 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 
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
@@ -529,6 +573,8 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	}
+	/* We no longer need to use mkdir_recursive at this point: the toplevel
+	   directory heirachy has been created by now.  */
 	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
-- 
2.51.0

