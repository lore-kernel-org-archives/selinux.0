Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBB408009
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208328; cv=none; b=OAk5nSrt24VYV6hvlt8GIIDub6WDfpY3hSv00Gb0uKs+3hkt4nn6xzYzcku3dIcv07mNmAVutvstgc/PyKQd6v3GSgyj5HXB2SQE8AENVxYvy4fch6vC9ZdPxig4f6hp8oMqxmTJOq3VXXncQI/6xDCTi/UK/eU/xLJyumtWeY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208328; c=relaxed/simple;
	bh=j57PWtV0NQF10rdXmDFJ8Xx+5uxhHz36S1paURWnN0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RjidjUhsR4kCGQIDMLuboQtIe6h3CHh8XMqUq5XdJYnUzFfIsVwgPUTmXMKdmEJ0cjr7SX7RNsw5XXu6j/jkuSfmzdFby01UW0SfdUJxXKcCbOYtd7nZMVuonUUrtbwucuac+Vc4GRA4uNo0Ztvvtkljv/MpYSYLii8tLOl/+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Rqg3UXJS; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Rqg3UXJS"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1779208324;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QOOTKHYoPGkbS4DeqaNPuKACgWu2kAsL2f9fI/d0CSo=;
	b=Rqg3UXJSUm2lduPfXsH7uV40CX5s9SYOl4Nc2qF8+jsKx2p0aPfj+sPX64CFJwjn7sUhkD
	QZhJwCCGjYuSpcmcu+J/WoxTJlG8JOm1SLCPkhU2foH2um4Ue4+2WjYRDqvSqSriyPvWc9
	PKzTBgBzzLp+MOsQZVxDWCaLXs4eKNgr84vhl4XXIx/RByiY+ZE7S9fsqQZgmxi1SaPj39
	Q0raJle6tpDuMzbY3AByxBoA0uL9JpA7769KY3vVvOjBydRxI1HX6IXb91T5WymqFvSFP3
	mHL/6/CRgGT04irhzPNovFDaK87cF0sKXHGi49kBAbdjuGEhP3zFE8oyjrZJ6Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: skip per-dirent fstat() when d_type is sufficient
Date: Tue, 19 May 2026 18:31:54 +0200
Message-ID: <20260519163154.449162-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Profiling restorecon with perf on a multi-core SELinux-enabled host
showed that every dirent paid an fstat(2) even when d_type already
gave us the file type.

In walk_next() skip fstat() when dirent::d_type is reliable, the entry
is not a directory, and neither SELINUX_RESTORECON_XDEV nor
SELINUX_RESTORECON_ADD_ASSOC needs st_dev/st_ino.  Directories and
DT_UNKNOWN still fstat as before.

This relies on the kernel/filesystem reporting an accurate d_type for
non-directories (DT_UNKNOWN is handled by falling back to fstat()).
The same trust is already implicit in find(1) and similar tools, and
a buggy filesystem that mislabels a real directory as DT_REG would
already break a wide range of userspace; directories are still
verified via fstat() here for the cycle-detection and descend paths.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 49 ++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 8b6eba0c..2c329ac0 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1040,6 +1040,24 @@ static bool walk_is_cycle(const struct rest_state *st, dev_t dev, ino_t ino)
 	return false;
 }
 
+/*
+ * Map a dirent d_type to the matching S_IF* file-type bits, or 0 if d_type
+ * is not informative (e.g. DT_UNKNOWN on filesystems that do not fill it in).
+ */
+static mode_t d_type_to_mode(unsigned char d_type)
+{
+	switch (d_type) {
+	case DT_REG:  return S_IFREG;
+	case DT_DIR:  return S_IFDIR;
+	case DT_LNK:  return S_IFLNK;
+	case DT_FIFO: return S_IFIFO;
+	case DT_SOCK: return S_IFSOCK;
+	case DT_BLK:  return S_IFBLK;
+	case DT_CHR:  return S_IFCHR;
+	default:      return 0;
+	}
+}
+
 static int open_final(int dfd, const char *name, struct stat *sb)
 {
 	int fd;
@@ -1189,13 +1207,30 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 			state->pathbuf[top->pathlen] = '\0';
 			continue;
 		}
-		if (fstat(fd, ent_sb) < 0) {
-			selinux_log(SELINUX_ERROR,
-				    "Could not stat %s: %m.\n",
-				    state->pathbuf);
-			close(fd);
-			state->pathbuf[top->pathlen] = '\0';
-			continue;
+
+		/*
+		 * Skip fstat() when d_type already gives the file type and
+		 * neither xdev (st_dev) nor add_assoc (st_ino) is needed.
+		 * Directories always fstat for cycle detection and walk_push().
+		 */
+		mode_t mode_from_dtype = d_type_to_mode(de->d_type);
+		bool need_fstat = mode_from_dtype == 0 ||
+				  S_ISDIR(mode_from_dtype) ||
+				  state->flags.set_xdev ||
+				  state->flags.add_assoc;
+
+		if (need_fstat) {
+			if (fstat(fd, ent_sb) < 0) {
+				selinux_log(SELINUX_ERROR,
+					    "Could not stat %s: %m.\n",
+					    state->pathbuf);
+				close(fd);
+				state->pathbuf[top->pathlen] = '\0';
+				continue;
+			}
+		} else {
+			memset(ent_sb, 0, sizeof(*ent_sb));
+			ent_sb->st_mode = mode_from_dtype;
 		}
 
 		int rdfd = -1;
-- 
2.53.0

