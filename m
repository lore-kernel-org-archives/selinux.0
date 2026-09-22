Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF166381B0E
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087643; cv=none; b=bJTaFVegLSrBRNRtOGfg0cPmLMeEnL7JD77G70kjU+L2nmob73RpWXXWUzNHkwCTBzBjZkENXJc529moZhFOZ//7b3tQ1EmNMGKLZKvI3edBusRaMLv27KeumNtrtiyNLAYB7wnadJ/CdqBM/QqE5suFxfTH39PyBo+SbsSr6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087643; c=relaxed/simple;
	bh=WOuN9nuSarnfY07fMTxFvMXGhulqgzNfK9+AVvrAEVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dcs1lL9DTtGi+dUqmD7HBYTh0l/DQjKwzgfKRgt9oLYDUVIgbyFyJLHRpAW+b3tlP2ziTdfyBSoxTWwKWQOk8hI+Q0VY7zifoWQbUxBZ76ivXSGB6Fj/E4u+ngzVxi3NNE+tHAgwJ86BIzNbmI6GgmuBCHYeKKNKsdpW1neeWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJzPksoR; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJzPksoR"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5059f8so1360704e0c.1
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087641; x=1790692441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+fbkQ4DUDNoGbkKpDW5hclYfAN0gqp5Q4jM5+raedfs=;
        b=YJzPksoRDZVlfL99aif1AqPQ1qLqYsQjGMziTyP32DZeDMBPkglMrIIRBbOTkQeE8P
         RU2o0fMDc1qMHYGp6Is6W7mtflxgK/ZLyYv95rxiOGzig1Zvvjfidt8zACEgPsQIC1gv
         qg429OxrUZEp/XgUV1D1HixnBKz8yflobLAkOkadtARf3lhjTaIsOBSgCz21ghn6khVD
         O58ZsJLlHByTv+yArs4HEID58tSdVHDL3SHY+4nlFUKutBVccR4WMrnoN0D8O63S/t9p
         g1vxbqBTIDDItODKPKo+ebk+v0wqJOJUpFP4jP760UgOxlOTjxwNTa1dq2MyZm54YJdq
         ieqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087641; x=1790692441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+fbkQ4DUDNoGbkKpDW5hclYfAN0gqp5Q4jM5+raedfs=;
        b=TmyFbv4MihSr76Ph+emgxJaU1bzGX0KJxbC2u6fM8CzPsGfHnxnju20lbkYPBWYCY6
         RAl6Plj8J2VCiFVH3PqwbgBwYppwj9QNNLvw6eVygIyCJ3BBTLxKBtWgV5XWSqon+2zS
         g+Khir/O99074x3H7KAqSJKzMil6OAn11OWWO4U16q1N1A93zjmwzxR7+tqEPeFHMPO7
         9aiKWISUWueXTpis7fGSsyrBaxdkO01Zpl6dsDU+ZeR3g4KsvC97MC1BGnuGQ26Vzgbf
         KiXD1NEmdeHeAY4wc/5TrUG0lkXaK2CGZc/OwaKuus0e2jIbOYB1d+Tj0yR632WrGFJp
         DMlg==
X-Gm-Message-State: AFuF++mA/PDa5fmmOK0SFH0Bp/bnGmyrEE0hnwbnmeWWaa1s9D7q90N5
	0rnHy+vwsnldCX0QDZGWYiJui7KtgRynATSEHB3N1nrIgRhGvUmZUyxY2riNlg==
X-Gm-Gg: AYBFou2Ogw4QQCQl4iaw1pHycKy7mm1HPH9JwFkFfK7Yx3n4zvPwArZp8S3ytyWisqY
	K3nToN9apKuurodHDlt+v7VPxIglyqcf9/54pPhgQsISgXZR1ES8HX29j+l2TYMSiFKT+qVq25A
	VziLG4ZFMwa1M44/NGOWUEKV5MmKvYI4ZEmIXQ/snYkiBcW0q6l56aIEN1t9fLNBbv45GJIyg9l
	Kp7IhHyzXvXZ5snExI7bUZ2cvpDtVK7frMts3LAfHP1YiyOc/g+0VU9pXnoDIF4DffOHd+hpynd
	NQ6n4oOS5EHukISWME9AImGEiTMdJQHG8dehJxG28YArgXlkUIvC7W2ZTZVGFAEXz9P9XD6y0I9
	p0mjRjC9mTnilbwOEjTMhOlnAhZtpcv4IiABDHy0BTZyDtUSiAuvbQltLK7Sa9nD+SbK8H2f5cE
	PcNNTO2Ivec7+MZT4MRms/O5vTRWOcfSCh5m/e19+WFxb/cV4GDOG6VGzHSG7xtbhIK8P9UedM5
	wmcn4g6S+1fj/Upggc9m1Dj9/4oU+kFI417H/a2niS7vRjzysP4tV5MEgx3qrz7SQRhLVsMudY=
X-Received: by 2002:a05:6122:209e:b0:5c9:a491:641a with SMTP id 71dfb90a1353d-5c9b8a6c1afmr8707927e0c.4.1790087640611;
        Tue, 22 Sep 2026 07:34:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e1716786sm14227871cf.4.2026.09.22.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:34:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] libselinux: export selinux_policy_open()
Date: Tue, 22 Sep 2026 10:33:43 -0400
Message-ID: <20260922143345.46093-1-stephen.smalley.work@gmail.com>
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

The search remaps paths under selinux_poicy_root() only. Files that
live directly under /etc/selinux (semanage.conf, restorecond.conf,
newrole_pam.conf) are per-installation rather than per-policy-type;
the former already has its own search in libsemanage and the latter
two are handled separately without needing this interface.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
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
index 00000000..dbd17010
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
+.BR selinux (8
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

