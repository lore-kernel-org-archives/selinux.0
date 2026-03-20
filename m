Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2B3ACA6F
	for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009766; cv=none; b=qPbJPE/FvV9EDCHYBzZDaTffSbBXUr+nOhe0pSRSJu0mn0g3+zI80DmNzPJokKfBv/Vc6TqTjLniDu9WBQiPk1TGVYctcxKdTi8Kj+Ut8UuB/Y4HrkMXW+uwcpqoXjnxEpZWgXlp0l27Vu+g2Cx3oT3b8HL7QWMlNH4GTtQa7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009766; c=relaxed/simple;
	bh=poSpfqt8/Yzn979lw8Qf/FBPtAw4waGRBHvjDcstTVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMYk4KTU1o2NgW7rFWpM0w/0Gcntimsj0veiN1nNVD6yh2Nvaqwk/DNejQp0GdPURXfJ7hiswsh/ulEX4MhhmWeHAkZ7fVM3ZvovGgHHxeMe589CTvU2XwnjubsalJ3WU382Y1enhYoKcnKivdhhNBsOuZA987+QKjNwwiPaLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG0R3dqC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG0R3dqC"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso206055866b.3
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774009761; x=1774614561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Py9dQG34+cgMso0dXF7GsCnnqB5bfyHvTV9BR0i/BXo=;
        b=TG0R3dqCvwnFyc3VoaVyvsLEmlRAwQoOAwZyM13TIL+d6QRllmlf2VV3/26vS/qh5a
         i2NXu6g2Ed9hnB/A4bfMg5nMmdrortsYtrzOGJl2BqaXzQ1zuEb7TQfMRa3kWoULhifH
         SXkVcwnaEElIvyEJskWYAnNOWw+Hyi+sDlOEm14zmWvyD5AN1dLwTBBuGpwlN9ePobNT
         X1YH390q1Nl+4OY2zVixgnk+1GH0Ly+YbOpCamAx9LbCSp5GdiBt8sK707zRhDdQcsLb
         j0uggvQsFHkdOeALp4y1DtJN3oNjF7Lq0vKmyvcTZfjRXbF3+hm/fBOUprTNIc2mEMC8
         YgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774009761; x=1774614561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Py9dQG34+cgMso0dXF7GsCnnqB5bfyHvTV9BR0i/BXo=;
        b=EEzilaqVPop7splqMmx2dcKuhdL+GejjrP+1T+cpl3Vr0veie+xv8jxx0hpXah/Np9
         cEw5c8WdMImR4dPMAuRA1MHsYGyVexy3aUy/PVluIgTgrXRToC5B93rTQ/z8cJnZvTxv
         zPVAP3jxSEGQ9Q3tRGBO4IviURKssEH+kGrFEJTHxl8m6daBbA+T8z+WEh6RpK1u3xz0
         H821WWVZdIEx42WdokLIWnaBBaKEGsNDql3yj0LsmRlbGqH6c74xC0VAq6X6w/nEWSZ3
         eVwjm/DO9uIsBtLQd06SrWG2yeAdE6fDZ06BBIUmeAKuKL8k/SIrRz/1f+eiKcNw/SA8
         cPng==
X-Forwarded-Encrypted: i=1; AJvYcCW4RW7y4q0ub/zJS0/38M06nvOXhRDzdTKAN1o1b2hMhCRuaZ2HoudJ/tvajfDrfDfnKgh9wHxX@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUQP6NkCnwHSnoDIpIewABSa11trGhHvRY4gNyqir4SZGhm5S
	ldN5/ryOLi+Ew6wWJXtMpPwvaGHeRpYVIbxZBdmuI6jIMjkk05gAo6j4jIYfKgpe
X-Gm-Gg: ATEYQzxu4DoMqPyK8Xg+vtOHH+hxiBRzYXZN9YJ/4/XCUVwDVptDUBtOWbCPqQmUvay
	ulpLLwaNIe4R8YQqTXitYajNH2/+WeMU0wjBDVvGR/EJyPmp6+qbbzYyK2CQlgrFS/3LACTa9q5
	yW+vjepHgnHqMGS/w3ieyZF5LhYY07P8Zn5DtqsWcsfCa/6F7HnayPgP9NAyqCYqAX9Tf3vXEyY
	IDOoXhvQ+NVdUhokf8v/kd7Jd567yyOIl1x4Rae0kftS6Vk06sO5tuSXi+cMH4Y5c3fN/FKmwIQ
	MCyFSKnkwNZD0JiZmyU0B3uK3xnaESrF46JEsyIAHaA6sKO0EWTI5o9PaD/N9Keio+/qHF4ekw5
	VUDEDJ5CbtUHg9+Rr/Erb8y8zRdqDHTuxLsSh1S9Pk+sbY10wvdJrkm8JfBE1ycTjvqINII20n+
	pFN1XWSpiTy9Ti3XsY1OY16C0PvFUVNu71uwEVBJykbdYawrvOBGXxtPIcLfUOpIR6avUdTg4Xu
	mZjf6smkqdivtWoH2/LDEI60oFgY3WM3wWvqT8=
X-Received: by 2002:a17:907:e11a:b0:b96:edcd:cd19 with SMTP id a640c23a62f3a-b982f502793mr138927666b.50.1774009760240;
        Fri, 20 Mar 2026 05:29:20 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-e98d-b8f7-8d95-53b2.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:e98d:b8f7:8d95:53b2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f42f0dsm154218566b.12.2026.03.20.05.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:29:19 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Paul Moore <paul@paul-moore.com>,
	Gao Xiang <xiang@kernel.org>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Subject: [PATCH v2] fs: allow backing file code to open an O_PATH file with negative dentry
Date: Fri, 20 Mar 2026 13:29:18 +0100
Message-ID: <20260320122918.1726043-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fields f_mapping and f_wb_err are irrelevant for the O_PATH file
in backing_file_user_path_file().

Create a dedicated helper kernel_path_file_open(), which skips all the
generic code in do_dentry_open() and does only the essentials, so that
the internal O_PATH file could be opened with a negative dentry.

This is needed for backing_tmpfile_open() to open a backing O_PATH
tmpfile before instantiating the dentry.

The callers of backing_tmpfile_open() are responsible for calling
backing_tmpfile_finish() after making the path positive.

Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This patch fixes the syzbot report [1] that the
backing_file_user_path_file() patch [2] introduces.

Following your feedback on v1, this version makes an effort to stay
out of the way of main vfs execution paths and restrict the changes
to backing_file users.

This still introduced a temporary state of an O_PATH file with negative
path, but only for a short time and only for backing_file users and
ones that use backing_tmpfile_open() (i.e. only overlayfs), so the
risk is minimal.

WDYT?

Thanks,
Amir.

Changes since v1:
- Create helper for internal O_PATH open with negative path
- Create backing_tmpfile_finish() API to fixup the negative path

[1] https://syzkaller.appspot.com/bug?extid=f34aab278bf5d664e2be
[2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir73il@gmail.com/

 fs/backing-file.c            |  6 ++++++
 fs/file_table.c              | 14 ++++++++++++--
 fs/internal.h                |  7 +++++++
 fs/open.c                    | 34 ++++++++++++++++++++++++++++++----
 fs/overlayfs/dir.c           |  2 ++
 include/linux/backing-file.h |  1 +
 6 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index d0a64c2103907..3357d624eac96 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -80,6 +80,12 @@ struct file *backing_tmpfile_open(const struct path *user_path,
 }
 EXPORT_SYMBOL(backing_tmpfile_open);
 
+void backing_tmpfile_finish(struct file *file)
+{
+	backing_file_set_user_path_inode(file);
+}
+EXPORT_SYMBOL_GPL(backing_tmpfile_finish);
+
 struct backing_aio {
 	struct kiocb iocb;
 	refcount_t ref;
diff --git a/fs/file_table.c b/fs/file_table.c
index e8b4eb2bbff85..a4d1064d50896 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -69,11 +69,21 @@ EXPORT_SYMBOL_GPL(backing_file_user_path_file);
 
 int backing_file_open_user_path(struct file *f, const struct path *path)
 {
-	/* open an O_PATH file to reference the user path - should not fail */
-	return WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
+	if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
+		return -EIO;
+	kernel_path_file_open(&backing_file(f)->user_path_file, path);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(backing_file_open_user_path);
 
+void backing_file_set_user_path_inode(struct file *f)
+{
+	if (WARN_ON(!(f->f_mode & FMODE_BACKING)))
+		return;
+	file_set_d_inode(&backing_file(f)->user_path_file);
+}
+EXPORT_SYMBOL_GPL(backing_file_set_user_path_inode);
+
 static void destroy_file(struct file *f)
 {
 	security_file_free(f);
diff --git a/fs/internal.h b/fs/internal.h
index 7c44a58627ba3..4a9e5e00678d9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -109,6 +109,13 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
 				      const struct cred *user_cred);
 int backing_file_open_user_path(struct file *f, const struct path *path);
+void backing_file_set_user_path_inode(struct file *f);
+void kernel_path_file_open(struct file *f, const struct path *path);
+
+static inline void file_set_d_inode(struct file *f)
+{
+	f->f_inode = d_inode(f->f_path.dentry);
+}
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/open.c b/fs/open.c
index 91f1139591abe..a7b3b04cd9ae7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -884,10 +884,38 @@ static inline int file_get_write_access(struct file *f)
 	return error;
 }
 
+static const struct file_operations empty_fops = {};
+
+static void do_path_file_open(struct file *f)
+{
+	f->f_mode = FMODE_PATH | FMODE_OPENED;
+	file_set_fsnotify_mode(f, FMODE_NONOTIFY);
+	f->f_op = &empty_fops;
+}
+
+/**
+ * kernel_path_file_open - open an O_PATH file for kernel internal use
+ * @f:		pre-allocated file with f_flags and f_cred initialized
+ * @path:	path to reference (may have a negative dentry)
+ *
+ * Open a minimal O_PATH file that only references a path.
+ * Unlike vfs_open(), this does not require a positive dentry and does not
+ * set up f_mapping and other fields not needed for O_PATH.
+ * If path is negative at the time of this call, the caller is responsible for
+ * callingn backing_file_set_user_path_inode() after making the path positive.
+
+ */
+void kernel_path_file_open(struct file *f, const struct path *path)
+{
+	f->__f_path = *path;
+	path_get(&f->f_path);
+	file_set_d_inode(f);
+	do_path_file_open(f);
+}
+
 static int do_dentry_open(struct file *f,
 			  int (*open)(struct inode *, struct file *))
 {
-	static const struct file_operations empty_fops = {};
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
@@ -898,9 +926,7 @@ static int do_dentry_open(struct file *f,
 	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
-		f->f_mode = FMODE_PATH | FMODE_OPENED;
-		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
-		f->f_op = &empty_fops;
+		do_path_file_open(f);
 		return 0;
 	}
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 5fd32ccc134d2..4010c87e10196 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1408,6 +1408,8 @@ static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
 			err = ovl_instantiate(dentry, inode, newdentry, false, file);
 			if (!err) {
 				file->private_data = of;
+				/* user_path_file was opened with a negative path */
+				backing_tmpfile_finish(realfile);
 			} else {
 				dput(newdentry);
 				ovl_file_free(of);
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 8afba93f3ce07..52ac51ada6ff9 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -47,6 +47,7 @@ struct file *backing_tmpfile_open(const struct path *user_path,
 				  const struct cred *user_cred, int flags,
 				  const struct path *real_parentpath,
 				  umode_t mode, const struct cred *cred);
+void backing_tmpfile_finish(struct file *file);
 ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 			       struct kiocb *iocb, int flags,
 			       struct backing_file_ctx *ctx);
-- 
2.53.0

