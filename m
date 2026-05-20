Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FE43AE184;
	Wed, 20 May 2026 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265164; cv=none; b=Hr3IIU3u7UG9Oref/KQfis0tgHNwL+21SuQPPIxc13ZObeAmtRWYBDrIoBM/lpJxTQEoB/aWLa3h+zSCAhH9rsTBikh4OeIpw7zqKR+TLobaEIkdZ4K8F6TltIeJQ3+qQD+dB5wTybJeMSTPTkwYXJr5pbSFoJMr7jv2CZJDYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265164; c=relaxed/simple;
	bh=F5N75Y8mUQYU1TgbgAwnzxz6xj0Y0zUFBQbr3qsftFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkT3lhNz1Pqm2tnjDRqDGao1JPumYMTGLZWLw5vjH5tFChB7YU4mOxKEu9HeYWnuc2hQRokGsBQbUdqPeo9sBF7w9z8poc2uYcRLssSvQmfaD9UvYZj889HtKJGejaP0jz9aYmIfQzrs1S01I44HZsrlBoLdBi3lw++/bj4lbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fcgnwf+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fcgnwf+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBAD1F000E9;
	Wed, 20 May 2026 08:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779265161;
	bh=zQRjpjIyAer953PPORKHqLJlFZ+L04n/ATscYla4KeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Fcgnwf+NkTvhc7Mit+rAGitTzJZDlSEN/uHXD+gkXTB4npyMOpLlukZugq5ohxYtX
	 lp6Azi92eVPhKV2Of6k/TAuTwG5evXZE5iWXANKE368n2gb20O7Yk1D8poK4bptGLN
	 gKe8i674mGmddBOIeCjCdBQZB++cVpQ3pABKGDDtYv1sDVGuBJybOROagMRccDcSYN
	 IOJ+03oCmUzYmIeuCTV917LSALVXG/MOjKC37dj+ruYComBK3Zm/MddcvAxEHycf0d
	 5NeR4M53U0lDs0Dt7niUyxN8BHwvrWRr2eCyzFovqPzYoGX+jRtPZSSK5eflbyRre6
	 JMGR0/leTjL/g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 20 May 2026 11:18:56 +0300
Subject: [PATCH 2/3] selinux: hooks: use __getname() to allocate path
 buffer
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-security-v1-2-831bd8e21dd0@kernel.org>
References: <20260520-security-v1-0-831bd8e21dd0@kernel.org>
In-Reply-To: <20260520-security-v1-0-831bd8e21dd0@kernel.org>
To: James Morris <jmorris@namei.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, apparmor@lists.ubuntu.com, 
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=rppt@kernel.org;
 h=from:subject:message-id; bh=F5N75Y8mUQYU1TgbgAwnzxz6xj0Y0zUFBQbr3qsftFc=;
 b=owEBbQGS/pANAwAKATkDhibLDv2RAcsmYgBqDW55/xeAuypW72Duwu823AN1y512GZtlik/jj
 f9D/szH8CKJATMEAAEKAB0WIQR45VhVpZkvn3TRr+k5A4Ymyw79kQUCag1ueQAKCRA5A4Ymyw79
 kZuWB/43kQ89qeDN/5ULkrNOC7BisGyehYajp/+I5dGOiekEQFVDn0eaXHd2QTlf2f+hnv9BbpS
 fupeiqIj/Ou0trjtruRc0roPfmTRWNl9OxfhUuaSxc9GbFpfOSSmDFlvcmAvuVfqHGwLIFMFssG
 8mm454MTwB23N3EFSGJSY2MNo4gGywEW6qmCrvBydmM27UydkD17stPOyxleOIbhjcFw9EU+Tbb
 +ElbtkFJ9OCCiKpoaEQ2mt0A6m1jr7ibLlu4TaUUYxaBcV2k/0oDtw0F6cQCRfH5oKGirJnU7/p
 mu1k/3MeSbO7pTCcTcyGil3l1Jnug1PwZNhjPyZbODCzEwv3
X-Developer-Key: i=rppt@kernel.org; a=openpgp;
 fpr=B8E96E880C4A40C3C1255AA8C532392DE6DA7CE9

selinux_genfs_get_sid() allocates memory for a path with __get_free_page()
although there is a dedicated helper for allocation of file paths:
__getname().

Replace __get_free_page() for allocation of a path buffer with __getname().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..05b84b3781e0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1336,7 +1336,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 	struct super_block *sb = dentry->d_sb;
 	char *buffer, *path;
 
-	buffer = (char *)__get_free_page(GFP_KERNEL);
+	buffer = __getname();
 	if (!buffer)
 		return -ENOMEM;
 
@@ -1361,7 +1361,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 			rc = 0;
 		}
 	}
-	free_page((unsigned long)buffer);
+	__putname(buffer);
 	return rc;
 }
 

-- 
2.53.0

