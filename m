Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079737E303;
	Sun, 31 May 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240509; cv=none; b=TLKe521Hwo3Sqop9gfQNZMlisNYIk2Z8heOeK9i5Z+4XY709zjKsWf8uCyC8Y3cZOEdGRQQuI07c+dA3HY+gVvo0nFb2b/mEBciZ/2Qj9272lMfNJfm5gjf08Mf8/TEynagvjh2rUYlOdwieEBazRbPyphD1Zx0XPJlouoRh0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240509; c=relaxed/simple;
	bh=hpE1yswsCE1IWztZlgPRsxaOiET3mRWldHteKzzqj7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEq3n/spG37HF0Cpu4JSsjfcZ00Qxi5vmRomukmKfAW5ysUsp92X+fVdBZmKDrgJ3MugEMNacLBCYwIGR62xUaMDggy3QakAPXqLt/P9N0GCAZWfs7wBtzb0DqPw5hJe7yFQIx2xWkZHe6fQLfdEvxD1rq0BgkOp47iOKRawRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPdvPH8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPdvPH8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D471F00893;
	Sun, 31 May 2026 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780240508;
	bh=vuEQbwwKyO30Nemm7p6CWpzET2/kiphIT966xrtNLBg=;
	h=From:To:Cc:Subject:Date;
	b=EPdvPH8ICHFH1z+9dpuJ5Qju7Nvy8Pvn1kUT2Ylln+8a5IF4hN61iq/ua3jQfg/aK
	 sPn1EYUDoswVY9Rj31mEzgvtt7XVSWcIgkPQIo+4rOFqFu09l92gNT1CwSP2Cb1ogq
	 rHDK7XJVbbkQO65fev0qhrhpb5P9+7MO0Jf4SOgyAbOTdgdJd+oUQjE4XLrDd6nEHM
	 /oL0sDQlf6NaEXhsrZCzjjF6UF3yKMHG20MSAqh3dPo3NangCCuNbXKBzSXPI1J/ag
	 kKFTLr+EGHO70dhVWeL3lcgs63hDELQw1tZ7N7StvNj9yXBYAa7S5Zxdk597ThWNco
	 uph5Z8UX6TBGQ==
From: Mike Rapoport <rppt@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: hooks: use kmalloc() to allocate path buffer
Date: Sun, 31 May 2026 18:15:02 +0300
Message-ID: <20260531151502.1467515-1-rppt@kernel.org>
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
v2 changes:
* explicitly use kmalloc() with PATH_MAX

 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..19493198ece1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1336,11 +1336,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	struct super_block *sb = dentry->d_sb;
 	char *buffer, *path;
 
-	buffer = (char *)__get_free_page(GFP_KERNEL);
+	buffer = kmalloc(GFP_KERNEL, PATH_MAX);
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

