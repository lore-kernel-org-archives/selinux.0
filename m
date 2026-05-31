Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD6C62809;
	Sun, 31 May 2026 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246739; cv=none; b=RojKLBzzY5b1jRMPlIfaO6Ybmid7WL9xOPLkp48p8rDWghqAMW6pu6Zeg4qMVieMlVlhcCEE4jBbTZ+JJp/Vg4gn2h/DzdAyXnJFJ/kj20tI7xgZg5NTDUBGWEsj0nFRiHzCuJLrBkGwtrhDWtttxVnA7EoxPZZrJ6rDRnp95D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246739; c=relaxed/simple;
	bh=WU+XKYsAiXzJG1dBlM/fNcNF8SSeHRpnpLpmlTEu8PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8PaNzNGIPykhpBDNApO7d+7Ul7vefOCtuZe/QYqzfla/rrZxyLbwDfZJdBQkLDuZ+tjQblwQJH5v3u6KKlOUspgxlfhWDkBn3OosMhrXUfZEw/YdFSE8vW9qnmNQLXkOUAZ+27GxUA4jUqw6IUFX6oKEehkZqsQoZhBrY0haHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7xnJvyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7xnJvyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA06C1F00893;
	Sun, 31 May 2026 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780246737;
	bh=lTKP/SKiHif+1zaTbvX9eUqUmu2fEpRXwar44ocwCbg=;
	h=From:To:Cc:Subject:Date;
	b=c7xnJvyEghYzzLpqfOVdFETLP5TtBVbfkLc7G60GEwZcYCy1Ox5b00kZARAJh4cUs
	 SMZg5rTwA/6fUghSpA2S7o/bWWZSLfimpdOefl0e6fh8hQtynRd3WHfUCY5Dm/5NYY
	 dN4bUks/SUzPotVt1v5xdKXbUyl7Zayo4aN6N6Aa7J9hcpwvG5FzHQV8r+PVbipgBx
	 P2vmZLVhd5K3jPR8Aju1uL9rpo64ABLSspTBbpR3+nvZBGLRKmg49xiwdjgc5UuH/Q
	 rp1z8Ob/wyVj4S54S1JLqtRjhuRg/cTKOxNXQBff00r7K9+xHlC/C3wTXmP92wJYsX
	 hesRSPUI+w6lg==
From: Mike Rapoport <rppt@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selinux: hooks: use kmalloc() to allocate path buffer
Date: Sun, 31 May 2026 19:58:52 +0300
Message-ID: <20260531165852.1478916-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

selinux_genfs_get_sid() allocates memory for a path with __get_free_page().

Such usage does not require a "page" and the size of the buffer should
actually be PATH_MAX which may be less than PAGE_SIZE on some
architectures.

Replace __get_free_page() for allocation of a path buffer with kmalloc()
and make it explicit that the buffer size is PATH_MAX.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
v3:
get the args in the right order

v2:
* explicitly use kmalloc() with PATH_MAX


 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..a2ebdd649016 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1336,11 +1336,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	struct super_block *sb = dentry->d_sb;
 	char *buffer, *path;
 
-	buffer = (char *)__get_free_page(GFP_KERNEL);
+	buffer = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
-	path = dentry_path_raw(dentry, buffer, PAGE_SIZE);
+	path = dentry_path_raw(dentry, buffer, PATH_MAX);
 	if (IS_ERR(path))
 		rc = PTR_ERR(path);
 	else {
@@ -1361,7 +1361,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 			rc = 0;
 		}
 	}
-	free_page((unsigned long)buffer);
+	kfree(buffer);
 	return rc;
 }
 
-- 
2.53.0

