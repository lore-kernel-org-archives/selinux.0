Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3C5208BC
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093394; cv=none; b=ofkkFKDXP7FxT6emRIGpmC4HlruzqwGruPZ890OhgzN9+E6qc73R9cUuBUvH8LNpzjbP+e4WcNn0Ku4raHI9wkWS/TTzfscRf+PU/+GeYf00AOmdOqSl20u4hJAK3g0qBKSR6JEQR82Y9lakax/kWk22fZJAbThtoZckgcf7p90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093394; c=relaxed/simple;
	bh=ia+mD1enosFJxjpwUgUvKOab/iZfGKA2UcC7CHbHztU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFI/cVbWgJZ3nXc1CPTYqRaQ5o1NZMANaf4d7Ed6YVImI10xXlaFsTYQqC24OEyzlTeprpwTudk2WfWT3OajmYupjaywGdQU2NO1wE+zxRoxOvvYXbHS6CodsuWjJs1W8IVuayDox6IrAOuC74C4qjPJlawjpujcg5oGxmxCqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmV/rBhb; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmV/rBhb"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a2a8c29c4so6198985a.3
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790093391; x=1790698191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtqDDtxeG/l9gjCTPOWUVJ8s87OYODbyE1Kv2UHAR1E=;
        b=jmV/rBhbLy5VavwfEsQ8T36I9epB4uHNtLFYLRbupWGMd5dxVmsne7Eoq/bkyLpepL
         TNxDF4FvOHz1vmBDvA2oueeb0XOAK9IWjrzJ9PWjYHXqZoh3SZ8IT4YAX0H1hUdl4P5U
         J2PFiU5iFK6+R7oJ+uSV6jYpocTcjxqDw3v2azBfSjgnEmNeadON1Q2QayOlGExLEKBt
         TskzH2H2mSZDlf5enFTPn3CFUrgG5VSGvrUW48TjUXUi/cDs6F26H+XHAJ52efyfjNiJ
         VU39E9YXy7aAu6ucAakHsmuLP0CjjKRwdTD8iorHNmJj4VkCvk18BJmin2SDuDeU/dOy
         4FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093391; x=1790698191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BtqDDtxeG/l9gjCTPOWUVJ8s87OYODbyE1Kv2UHAR1E=;
        b=JM/rWct/8Jfktpbf4hje7rq5AXR+DiRZLcoaCF5C9TE+LAl5zN10xG6RBq/pxv0CTU
         azjMOiBfG8yuyqvCtb1baAhLlG/QYe6JlNCSLc2zt75g2d2mQzduEm7QjERtrrnZxh2i
         +JUWTyf8KgZOhBSuetprzVwvqGaTmdZaWFby0qNhGUSJW67ElwbZTaMqDnHpfIguuFON
         faUy1P5iVY+QyemUiuTcYypy1Pdt61050emo8U5PjL2GPBe1tqJvJ/NaSul9H+aB7GB6
         IKd/hyOgihqxZwiCwZo0qaZHA4SwSjQYrY4J276IXvuXu3jMU76GH8DQbW8OX5WGzSlV
         ZpxQ==
X-Gm-Message-State: AFuF++n0tBYQYz5NkTDt+ulhVnkJKtyoqHfKZwnDNP8FXUlzVn2jxAbE
	3LgRlfGsT4d58IbUDLDOvpf5Ymax8+Xczi10NfRCJ2s365Cddizx63C7CIVIWw==
X-Gm-Gg: AYBFou2OUwru8VguzvtvgZSCcmtPrHAXgRNOzXQLdHaRgK0npVgfOLcXMBCSoqPflam
	t9mcgmQcLmvt36h6KYM/427dvLV070GYf2MTOTkj5ZG6w+vPoCm3BwE5SbAzUMeq05P6PQnw7dd
	GMUAxGwvBqhKKsfBES0i8GZ5rwZn3RDQKiTUqtv42a/dRzq5+ZnX9dct0CAzXw2rRjs2sai17ln
	vXq53QNxX/+ttU/ZgCNdS7OB12CFKON53nb4/QVHmVDRaJ53o7Siaqrisd1VqJRgLkOc0JoQmZ7
	C/Tmu71vWsxJWPU8yZRe8SGI4j0gd05e9IeC6/sUpPV7vAGaQmX36vpQtM+rlZKu5FtYTfBG/n7
	uCKFQBIQDC0rD+ueusC7R5UvNtaE81JNnPz6XvqqCNv0TWKNO2Vw0luO9sK/J8Srzw2/TolRY7o
	ab1QNbMN7MkdfuCj8mARhqKOa22cby00vwnTrh1GbzMmbJafB3nLN8gaHUw9Ts1h5trWbY1KFm8
	Bkqi06sUTEUsj6zFn2VJmPyyZB7LH9y8WeLLCcZ2QMA1lhmynsdwv2WNSl6/25XpkF4uMQHLDNy
X-Received: by 2002:a05:620a:444d:b0:93b:6f87:ff60 with SMTP id af79cd13be357-93c15d7c395mr581010385a.14.1790093391173;
        Tue, 22 Sep 2026 09:09:51 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24753395sm9132885a.4.2026.09.22.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 09:09:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/3] libselinux: export selinux_policy_open()
Date: Tue, 22 Sep 2026 12:08:58 -0400
Message-ID: <20260922160859.47233-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The configuration-root search list added by the stateless series is
used inside libselinux via the internal selinux_policy_fopen()/
selinux_policy_open() helpers, but external readers of policy
configuration such as mcstransd and run_init still open the paths
returned by selinux_translations_path()/selinux_colors_path()/
selinux_contexts_path() directly and so do not fall back to a vendor
root under /usr/lib/selinux.

Export the fd-returning selinux_policy_open() so those callers can use
the same search without duplicating it. The FILE * variant stays
internal so that <selinux/selinux.h> does not need to grow a <stdio.h>
dependency; callers that want a stream can fdopen() the result.

The search remaps paths under selinux_policy_root() only. Files that
live directly under /etc/selinux/ (semanage.conf, restorecond.conf,
newrole_pam.conf) are per-installation rather than per-policy-type;
the former already has its own search in libsemanage and the latter
two are handled separately without needing this interface.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes a typo in the commit message and a missing ')' in the man page.

 libselinux/include/selinux/selinux.h      | 12 +++++
 libselinux/man/man3/selinux_policy_open.3 | 57 +++++++++++++++++++++++
 libselinux/src/libselinux.map             |  5 ++
 libselinux/src/selinux_internal.h         |  3 +-
 4 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_policy_open.3

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 364f955d..b789ee08 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -565,6 +565,18 @@ extern const char *selinux_policy_root(void);
  */
 extern int selinux_set_policy_root(const char *rootpath);
 
+/*
+ * selinux_policy_open opens @path for reading, and if @path is under
+ * selinux_policy_root() and yields ENOENT or EACCES, retries the open
+ * under each fallback configuration root in turn (e.g. /usr/lib/selinux
+ * when a distribution ships policy configuration there instead of /etc).
+ * @path is normally a path returned by one of the selinux_*_path()
+ * functions below. Returns a file descriptor on success or -1 with
+ * errno set (ENOENT if no configuration root had the file, EACCES if
+ * at least one root had it but refused access).
+ */
+extern int selinux_policy_open(const char *path, int flags);
+
 /* These functions return the paths to specific files under the 
    policy root directory. */
 extern const char *selinux_current_policy_path(void);
diff --git a/libselinux/man/man3/selinux_policy_open.3 b/libselinux/man/man3/selinux_policy_open.3
new file mode 100644
index 00000000..e4252b64
--- /dev/null
+++ b/libselinux/man/man3/selinux_policy_open.3
@@ -0,0 +1,57 @@
+.TH "selinux_policy_open" "3" "" "SELinux" "SELinux API Documentation"
+.SH "NAME"
+selinux_policy_open \- open a SELinux policy configuration file, searching fallback roots
+.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int selinux_policy_open(const char *" path ", int " flags ");"
+.
+.SH "DESCRIPTION"
+.BR selinux_policy_open ()
+opens
+.I path
+with the given
+.BR open (2)
+.IR flags .
+If
+.I path
+is under
+.BR selinux_policy_root (3)
+and the open fails with
+.B ENOENT
+or
+.BR EACCES ,
+the open is retried under each fallback configuration root in turn
+(for example
+.I /usr/lib/selinux
+on a system that ships vendor policy configuration there and keeps
+.I /etc/selinux
+for administrator overrides).
+.PP
+.I path
+is normally a value returned by one of the
+.BR selinux_binary_policy_path (3)
+family of accessors. Paths outside the policy root are opened as-is
+with no fallback. If
+.BR selinux_set_policy_root (3)
+has been called, the search is disabled and only
+.I path
+is tried.
+.
+.SH "RETURN VALUE"
+On success a file descriptor is returned. On failure \-1 is returned and
+.I errno
+is set:
+.B ENOENT
+if no configuration root contained the file, or
+.B EACCES
+if at least one root contained it but access was refused. Any other
+.BR open (2)
+error is returned against the root that produced it.
+.
+.SH "SEE ALSO"
+.BR selinux_policy_root (3),
+.BR selinux_binary_policy_path (3),
+.BR open (2),
+.BR selinux (8)
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 95cd53b0..9b439d8e 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -267,3 +267,8 @@ LIBSELINUX_3.10 {
   global:
     selinux_restorecon_get_relabeled_files;
 } LIBSELINUX_3.9;
+
+LIBSELINUX_3.12 {
+  global:
+    selinux_policy_open;
+} LIBSELINUX_3.10;
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 718beb6e..c32bb4c0 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -117,10 +117,9 @@ const char *const *selinux_policy_roots(void);
 /*
  * Open @path (as returned by one of the selinux_*_path() accessors),
  * falling back through selinux_policy_roots() when the primary path
- * yields ENOENT or EACCES. Internal-only.
+ * yields ENOENT or EACCES. selinux_policy_open() is the public form.
  */
 FILE *selinux_policy_fopen(const char *path, const char *mode);
-int selinux_policy_open(const char *path, int flags);
 
 /*
  * Resolve @path against the configuration-root list: write into @out
-- 
2.55.0

