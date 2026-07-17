Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55C38838A
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313670; cv=none; b=u++4n0I5dx+qBZ609sa+GUoiEu5sJKwNHfII3Bp65wuyCetIuW+4++K7f6naajhOjteiN9tDhL6cLknakGQoFk1oOhlGWUZUeFB+8mM69y0mYHWbd0Cg4qhaGvrjwx9e0+xiVLvgDmwHDnk/Q6cboVj5Q2cNCiLTVsdBQB934IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313670; c=relaxed/simple;
	bh=0VVnNzIu0GwGJsB1mBmOyG27M11hnD0+HF5tnARRhBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+UYVnOpRhyLDfQ1LGg5GZxI2UXsRVIpfP3GYY+YNSSYVprGQZJAYh7fQ4QGtzvygsbQJiAnIlVa1UDq05/ky4ax9OVfc2k0KW0R6FnymP1DaQkl6fAD9wkSrmfdjvNe+9WQ5htGPlh8LKpx0EoqKITkIXENiU+JyWRbqeRxBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5N7F5Aq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5N7F5Aq"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so32063236d6.3
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313665; x=1784918465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J30b4tmOSxxqJ305KDbKkQhjejEU272lIWBUhRTAaUo=;
        b=d5N7F5Aq45LymWUklc6x0Y4Wp/0YYVjSSwc4xVDWbqIlpGN+nO8zR06l1J/uMmntcK
         B78JDEieCf7rMc9dhEiKVoLA6YucgmG1dyrfqu4tA0ESqgq0Z92YvPnNqu7k3amvLbyN
         hwKQYtejyTPiTBvlr88ON4Gc/fExIh3Ee3Ce4irDhYbfPS8JDAJ4w4mdNisNCLyWCUhR
         BBCQ7ehqNX2M8bY2J8VljA1c058eOI8Qr0yrRNpLlFdiK/Enh0FDxvtjGgux3RvQd1fL
         7iHUm505/Rs5OcaLuQJWs6TrtPHW8EhjO4r9E90gK/1Y+WGrL5oxGq48ZIxkbkiH7IJ9
         poew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313665; x=1784918465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J30b4tmOSxxqJ305KDbKkQhjejEU272lIWBUhRTAaUo=;
        b=FRDMAC9fkyIyLFo4BpYHrO/2mAbQvCGDNfYG61S9TGJqjKw80pIuX8/meKj0FdtM7m
         qQfEmlsWwnIzatX3mzYAEKAeSuHJvSZTHnZ0/JVqvfSH36HpAQNS8tAVURcXmGtnax1d
         DN7eX6xwcidHI9Hdl2IeS2ec7W+uDm83oMlmiI217fNbMznFmSNNHD8kppfoMs2U9dOn
         EsOoT79SyElcC2k8k8Y9IiDKKKkoTi5G2KA8zPuM6adfG9G+owMCN8EHP4lKZ0mY4Xq0
         hWuaEDVfbGcnaHWZ6a3Tgb4lxAN1EtBvpKGCViyCWOguVe+wimETbJJJECJo2Xq97Mv9
         bmDg==
X-Gm-Message-State: AOJu0YxQ0ruzDQoRbW3eh8QWPDU1+flQl52syxLkIlqNc+Bw7WZKApo5
	u0qjowK4dXD0Vcsqu84Ne71+EQv9/sQMeEGzt8jHiskdPpxgn8JW6vN3sPnxdw==
X-Gm-Gg: AfdE7cm+o3DZC3sOPoejl36nsDgJWRhJKXI0a/R3P5tnXIejpzBOwyWMsXc1J4Nku8p
	HbJUSVlc52Hs0xXXmD8XSOy/doA6nep1jAK1GNpquYuhihkBNCFuxkE4eF3kosP6ocd6qkHZg/u
	BzaG6JQ/sDNkYjBDIq2jNmu83VsCQsTk4YDyCppsc98aJQ9YMygNbIqp4dJu0dI5nI09Eb258U4
	KczS2o+RbE5/5Td4hAoFYJDOJIEaNEsSjkqlCnQaNmq0EZrJgJuBacXL/e9d/1rBo6x9+MdY5jN
	tgiEVKCpYvO7Ke1/Us9x9fCt+fqsdHpixdr5pMAZVqD5b5YK04wjfi3BS25F/2OC/rqjTPhfvS2
	U3rcIiIxI6JOISjdLPuBXEfBWbQSB/J3oPbEeyMFWPF4Z8yEe0xWmVAHbjj/LaQK/OnOEyC9njm
	8l1rBnU1l7Vexz38ia2gEADZCWNNcBfA5Kb41RLP3q78D1wH16957tk59psooCzTdEkJH1QbmAB
	RAqpQ==
X-Received: by 2002:a05:6214:400f:b0:907:5451:8954 with SMTP id 6a1803df08f44-90778334fc4mr44778186d6.16.1784313665277;
        Fri, 17 Jul 2026 11:41:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:41:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 06/10] sandbox/seunshare: remove files under tmpdir as user
Date: Fri, 17 Jul 2026 14:34:21 -0400
Message-ID: <20260717183424.20324-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
References: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The files under the tmpdir are user-owned so removal of those files is
best done under the user's uid. Only the tmpdir itself is root-owned
and therefore should be removed as root.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 makes the setfsuid_checked() failure to the user a fatal error to
prevent proceeding if it couldn't switch to the user. It also drops
the odd switch back to user at the end since the function is entered
with fsuid 0 and no caller relies on this.

 sandbox/seunshare.c | 46 ++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 7c6154e1..9f7e49da 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -486,7 +486,8 @@ err:
  *         not be followed.
  */
 #define RM_RF_MAXDEPTH 128
-static bool rm_rf(int targetfd, const char *path, unsigned int depth)
+static bool rm_rf(int targetfd, const char *path, unsigned int depth,
+		  bool removetop)
 {
 	struct stat statbuf;
 
@@ -527,24 +528,31 @@ static bool rm_rf(int targetfd, const char *path, unsigned int depth)
 				continue;
 			}
 
-			if (!rm_rf(dirfd(dir), entry->d_name, depth + 1)) {
+			if (!rm_rf(dirfd(dir), entry->d_name, depth + 1,
+				   true)) {
 				rc = false;
 			}
 		}
 
 		closedir(dir);
 
-		if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
-			perror("unlinkat");
-			rc = false;
+		if (removetop) {
+			if (unlinkat(targetfd, path, AT_REMOVEDIR) < 0) {
+				perror("unlinkat");
+				rc = false;
+			}
 		}
 
 		return rc;
 	}
-	if (unlinkat(targetfd, path, 0) < 0) {
-		perror("unlinkat");
-		return false;
+
+	if (removetop) {
+		if (unlinkat(targetfd, path, 0) < 0) {
+			perror("unlinkat");
+			return false;
+		}
 	}
+
 	return true;
 }
 
@@ -630,20 +638,28 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		free_args(args);
 	}
 
-	if (setfsuid_checked(0, 0) < 0)
-		rc++;
-
-	/* Recursively remove the runtime temp directory.  */
-	if (!rm_rf(AT_FDCWD, tmpdir, 0)) {
+	/* Remove files under the tmpdir as the user */
+	if (setfsuid_checked(0, pwd->pw_uid) < 0) {
+		fprintf(stderr,
+			_("unable to switch to user for removing files under tmp dir\n"));
+		return ++rc;
+	}
+	if (!rm_rf(AT_FDCWD, tmpdir, 0, false)) {
 		fprintf(stderr,
 			_("Failed to recursively remove directory %s\n"),
 			tmpdir);
 		rc++;
 	}
 
-	if (setfsuid_checked(0, pwd->pw_uid) < 0) {
+	/* Then remove the tmpdir itself as root */
+	if (setfsuid_checked(pwd->pw_uid, 0) < 0) {
 		fprintf(stderr,
-			_("unable to switch back to user after clearing tmp dir\n"));
+			_("unable to switch back to root to delete tmpdir\n"));
+		return ++rc;
+	}
+	if (rmdir(tmpdir) < 0) {
+		fprintf(stderr, _("Failed to remove directory %s: %m\n"),
+			tmpdir);
 		rc++;
 	}
 
-- 
2.55.0

