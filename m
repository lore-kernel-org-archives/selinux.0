Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E04A093C
	for <selinux@vger.kernel.org>; Thu, 10 Sep 2026 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051740; cv=none; b=WSvlqPZhhZjGVZw3vK0Ajpxlm3Rh0X0k+KLjcEBrYtTpYFoc0re0KzoRdQxPuW0/241JqABAuEkRQWxFHLZT8s8ffXqoYf0vJLNDbHKjZ0nHtbyWwwAGe2HnrFIWcGCmbe7+aKEFD8OJxkrmZJInzatwUtyfcy+Z9GwUtemxjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051740; c=relaxed/simple;
	bh=K8GKWHG18DKGFQUXIWqsjvzQONV3ZlsJjG0SvT8K/sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJNukZx6pb5SHuJwJO3MdxeXa/8tCBHq/9IY3alG8/2UNFfHwACa0EQ3G6Q65wKxKX9LN+I0HN4ZC/vCKQ6vAbFn+vAcs+IZdmABgq2nekIJ5OTFSZJocqfLx3XwzT73UrV0sA4CbxjZ4g4fkah4+amj8vdq+xVyLxjb5kcL8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=h+ONieHS; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="h+ONieHS"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hggXx70dZz2VV;
	Thu, 10 Sep 2026 16:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789051729;
	bh=Zf70hVp7hFNa/7hbnAOEkncpDexz1CIpuhb71zACocM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+ONieHSiVxrgzBmZHaf2eHrziCQ9sSTpbdw6yp3FPzGhUpgaNsUgb+0E8PZIrlph
	 TQO95qg745l2DPq6hpIsUsNHnoMmp2D9ygwQIDsJaWt8Ak02Hcp/TjZVEVBT/iDwu6
	 YVH1wKtRuxCaOfyetRtusqh9Z6gFvpzxZj9c+iUU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hggXx0HrzzXXG;
	Thu, 10 Sep 2026 16:48:49 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Nick Kralevich <nnk@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/landlock: Check full ioctl commands in audit records
Date: Thu, 10 Sep 2026 16:48:34 +0200
Message-ID: <20260910144837.381855-3-mic@digikod.net>
In-Reply-To: <20260910144837.381855-1-mic@digikod.net>
References: <20260910144837.381855-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The ioctl audit test uses FIONREAD, whose command value fits in 16 bits.
It therefore cannot detect truncation of encoded direction and size
bits.

Use an architecture-independent unknown command with set upper bits and
require its complete value in the audit record.  Landlock rejects the
command before the device handles it, and the existing ioctl enforcement
test already exercises the same request.  The new expectation fails with
ioctlcmd=0xfeee on an unfixed kernel and passes with ioctlcmd=0xc00ffeee
after the shared audit field is widened.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 18dbdb99aeba..1abdcc9ee784 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4146,6 +4146,9 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
 
+/* Arbitrary command with nonzero bits in both 16-bit halves. */
+static const unsigned int unknown_ioctl_cmd = 0xc00ffeee;
+
 /*
  * ioctl_error - generically call the given ioctl with a pointer to a
  * sufficiently large zeroed-out memory region.
@@ -4249,7 +4252,7 @@ TEST_F_FORK(layout1, blanket_permitted_ioctls)
 	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FS_IOC_ZERO_RANGE));
 
 	/* Default case is also blocked. */
-	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, 0xc00ffeee));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
 
 	ASSERT_EQ(0, close(fd));
 }
@@ -7943,6 +7946,7 @@ TEST_F(audit_layout1, truncate)
 	EXPECT_EQ(1, records.domain);
 }
 
+/* Checks that audit records preserve every ioctl command bit. */
 TEST_F(audit_layout1, ioctl_dev)
 {
 	struct audit_records records;
@@ -7952,10 +7956,10 @@ TEST_F(audit_layout1, ioctl_dev)
 
 	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, fd);
-	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, FIONREAD));
+	EXPECT_EQ(EACCES, ioctl_error(_metadata, fd, unknown_ioctl_cmd));
 	EXPECT_EQ(0, matches_log_fs_extra(_metadata, self->audit_fd,
 					  "fs\\.ioctl_dev", "/dev/null",
-					  " ioctlcmd=0x541b"));
+					  " ioctlcmd=0xc00ffeee"));
 
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-- 
2.55.0

