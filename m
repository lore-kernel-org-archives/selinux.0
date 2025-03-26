Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383419DF4A;
	Wed, 26 Mar 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742985886; cv=none; b=elRt6wnKR7GjCPqYi8uSB5MyIJjWsDM8Y0Ilmjxqm/Dr1tUzVzAKj2bjIIQbUjwcouRhKWXNcIP++NYTQJZQQ7P3bg96IibYQNwhJywFceb9rl/HL/E2fOSk5s/zet5DY6BDVjj+tAaWbKiab9PMSSP4zMdz7fCbNWpMv2dRFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742985886; c=relaxed/simple;
	bh=9Tu1NPoHREO5KCMLTljMMco/ZIML/4h+5x/5DN/1080=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oEDR3TH7d8AzZ+XVY+nmmBz+u4HQpAJtJNc7i3MqT5OaFMBFmAwmqrowoPuH7g15c3QDSMi1claaQbHR07NZyXOgN7GdF2z0KAMt40OzqkLml73LcGXOg7eDVOOtP2r+dQMeNipxNt3ZCvaTn61mebCnlnlxTGKrRYbtjWIlCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KP6VJ4Zi; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KP6VJ4Zi"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742985520;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PXzJ60ydahUKlZREbw7QqW/SQ79Dg/dg31FTuvz+gew=;
	b=KP6VJ4Zi35QZ3i5fop5jmr/bqjQ1/OMuohYmAG1hCKO63iVvfy62TfpaN27sGvw/QWbVDx
	e0U7LX1XXWpMIjtCXHA0/36PeCfjDz09nVQQ+ckiJHQPL48z4il8bqFjwzcP23XzruheVi
	JzP6iU2ZYM/nZygSrb6+1o7J72fCkWPPx2BVSJUQDsUFF8gpQeyYKacnM7Yqfh4yTWttUi
	HOOqO5rDiWUwalDfu73Hu4qIjG5lxryZNJNlqMaMJLNhf/wyugKA/8miV7M2GG4BlzkNSH
	NGODIhOvfPcf+2/f4EY3RYTRoTmpU7TFved+It0RR4sIdr9C0opHMnyziFj63w==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	"Kipp N. Davis" <kippndavis.work@gmx.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Jens Axboe <axboe@kernel.dk>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] selinux: rename io_uring permission to match syscall
Date: Wed, 26 Mar 2025 11:38:11 +0100
Message-ID: <20250326103819.93387-1-cgoettsche@seltendoof.de>
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

Commit c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks for
io_uring_setup()") introduced the LSM hook `uring_allowed` and
implemented it in SELinux via a new `io_uring` class permission
`allowed`.  Rename the permission to `setup` since most permission verbs
are named after the corresponding syscall, in this case
io_uring_setup(2), and avoid confusing policy rules with an allow
keyword and an allowed permission.

Fixes: c6ad9fdbd44b ("io_uring,lsm,selinux: add LSM hooks for io_uring_setup()")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Note: this patch targets torvalds/master
---
 security/selinux/hooks.c            | 2 +-
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7150c953fec3..bcc66dea8bdc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7188,7 +7188,7 @@ static int selinux_uring_allowed(void)
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(sid, sid, SECCLASS_IO_URING, IO_URING__ALLOWED,
+	return avc_has_perm(sid, sid, SECCLASS_IO_URING, IO_URING__SETUP,
 			    NULL);
 }
 #endif /* CONFIG_IO_URING */
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 04a9b480885e..49fb584f2056 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -179,7 +179,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "perf_event",
 	  { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL } },
 	{ "anon_inode", { COMMON_FILE_PERMS, NULL } },
-	{ "io_uring", { "override_creds", "sqpoll", "cmd", "allowed", NULL } },
+	{ "io_uring", { "override_creds", "sqpoll", "cmd", "setup", NULL } },
 	{ "user_namespace", { "create", NULL } },
 	/* last one */ { NULL, {} }
 };
-- 
2.49.0

