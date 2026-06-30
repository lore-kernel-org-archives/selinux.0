Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26F63EE1FD;
	Tue, 30 Jun 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814532; cv=none; b=mu2yzoYUKzVgu08S05q40RsR3swV5ajfzdK5ysNTkj4paU4ObfvvOKn8cJUeU4U1jnweaSlV24IvDzjdugNgzFosilUh6FKq4THeHRH1LbCDOnQgP30jieSGbKSi4jn8JzL4nHfN7Qug/9eeFLHnKFv5Sx6gSA0lRgdFESohTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814532; c=relaxed/simple;
	bh=d1w/k0MSb+e0ysFnjHMRr70pZpHh1iPqR9VmPEuxUr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l0kASo6qC/Z13Fdpk5Jv1oRqdOyVzz6UGQU5woJztj2R0iRF3xlm5JoMGFSkzQDqe1nYCzh/W0QC+lgJ4DOiuY/UBXqb+1+oLXxUIn+U30B145TB0VpCzKdKPYn2VVI8NMFftwwPL9KGLmQwKmrZ9kHCOZFX+Qd2BD+BNlTLWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/XVErlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/XVErlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3631F000E9;
	Tue, 30 Jun 2026 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782814530;
	bh=lI3NPkDDbaOtWN0AagWeM0hopceUDy8AbC/aW08cank=;
	h=From:Date:Subject:To:Cc;
	b=l/XVErlH88YHdtfHcc78riCZQuDZj2CApRlflyee2XodqHkXoiIDMdoQUkS1S5eGl
	 uyj36gRnqTtrjcrTP4N8lCyFa85YB8QuzW8p5/Rj4CK9W0huMjYOUm9Gri25tzTGh1
	 dZjTDb3Ou/C0xjPDleCfCOu1p2H/0qkUhfA1xrf2ywR1qYHlpo2U24iH3FhfpOOTlF
	 HNxjgrrrJYiiJE/+TfPzUwrmP3FEEnsb9SHe+0oaeHcXN93RxE5TAJh6i87/LT4LuO
	 6sTmXS3Tk9pLS0q8oCzxkUZDSzJRHkPD9ppMUds33nUS27ofwQauVj9d1kNZ3eZbnD
	 JkpwyjiADTnLg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:15:24 +0300
Subject: [PATCH v2] selinux: hooks: use kmalloc() to allocate path buffer
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-security-v2-1-560d33c13ee6@kernel.org>
X-B4-Tracking: v=1; b=H4sIADuXQ2oC/22OTQ6CMBCFr0JmbU1bI6Ir72FYtJ0RqqaYGSASw
 t2luHX5vby/GYQ4ksClmIFpjBK7tILdFRBalxpSEVcGq22pj1YroTBw7CdVBsRSozsZe4bV/ma
 6x89Wdat/LIN/UOhzPju8E1KeXQptljJmuY3SdzxtF0aT43/WRqO0qg7GY0XWIOrrkzjRa99xA
 /WyLF/3zrrWygAAAA==
X-Change-ID: 20260520-security-6cdd60da7129
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
 Mike Rapoport <rppt@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, selinux@vger.kernel.org
X-Mailer: b4 0.15.2

selinux_genfs_get_sid() allocates memory for a path with __get_free_page().

Such usage does not require a "page" and the size of the buffer should
actually be PATH_MAX which may be less than PAGE_SIZE on some
architectures.

Replace __get_free_page() for allocation of a path buffer with kmalloc()
and make it explicit that the buffer size is PATH_MAX.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc:

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/security
---
v4 changes:
* rebase on v7.2-rc1

v3: https://lore.kernel.org/all/20260531165852.1478916-1-rppt@kernel.org
* get the args in the right order

v2: https://lore.kernel.org/all/20260531151502.1467515-1-rppt@kernel.org
* explicitly use kmalloc() with PATH_MAX
---
 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..d1f089917a82 100644
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
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260520-security-6cdd60da7129

Best regards,
--  
Sincerely yours,
Mike.

