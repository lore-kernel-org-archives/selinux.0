Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD5382292
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223846; cv=none; b=NL+J6FiPlZZWgmx8tpJU1OfLs3kPoQhZuAnUUslYqAcMb79olzWxI0BC2+c7BfEVcy5IFGf2ixq+QGMod1UZX9iE5doPL4dXZqps5FVJDfJYStFZfmGKhxTHpsVAhu+deci6n4T4FpBV3bGnAqwTD6x/lktpoUVX+hVZNkUVnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223846; c=relaxed/simple;
	bh=MLVn6qONi+s1kmCzKb1XHPCyNbEnvMuZZRGoFC9FJdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bTTCJI1j8UUEbov9B+UZcT/LNffKNKX8APNdDhFuqrRk+veiln3BM+/ouRugVZH0eH6EFYdHBFqeT5Cl6bb3Gh7PGtAKkOXWPsgazXRk7zZp1OGxNbtnHEGzNgxs42lCDdeQNTqqnTVxEQ0rWPRqnuAm3J5aXxhqCUSH/0q88jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=W0MY99fz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="W0MY99fz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782223838;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jjFyoIsSoqTUsHQXe4Lf3p8zOtomWVybsDeqccXYMMs=;
	b=W0MY99fzJU3D1Jd4Nj4WoAZJkd6MODjg9EZORz7x1esOZq4tHDrMyBTI7BPR1NGZjaT74+
	hV9yltzMJN5GDwxT+pD1SoqXTYAIe3CFYsGHTdGlnw+tmdE8r5bQETCCnVl+UdOJaqcMvB
	ksxVUBhFKJ5SUIvs3+3LAhvTT6AS7v+bFWRP7x2LNmExctRF2GgwONJHSBsPAeveJyAGH8
	Le3nkvO0qH1gX0dS6mFEk/cbH8jWs1ljpqCn+PEIli6E2YNHN2jA6sUjZBFZYynJAL4fLk
	xwD38pfWjwsuhvdeFgeoX6DXIZnF7IPCYwWWjdA2x7Z0eMmBjmTFNrNJ+KGP6A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/5] newrole: compare shadow hashes in constant time
Date: Tue, 23 Jun 2026 16:10:19 +0200
Message-ID: <20260623141023.114173-1-cgoettsche@seltendoof.de>
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

Replace strcmp() with hash_equal(), which ORs byte differences across
the full stored-hash length so the comparison time is independent of
where the first mismatch occurs.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 960c8875..ef194efb 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -343,6 +343,22 @@ static void memzero(void *ptr, size_t size)
 	}
 }
 
+/* Compare two crypt() strings without an early exit on the first mismatching
+ * byte, so the number of matching leading bytes is not leaked via timing. */
+static int hash_equal(const char *computed, const char *stored)
+{
+	size_t clen = strlen(computed);
+	size_t slen = strlen(stored);
+	volatile unsigned char diff = (clen != slen);
+	size_t i;
+
+	for (i = 0; i < slen; i++)
+		diff |= (unsigned char)computed[clen ? i % clen : 0] ^
+			(unsigned char)stored[i];
+
+	return diff == 0;
+}
+
 /* authenticate_via_shadow_passwd()
  *
  * in:     uname - the calling user's user name
@@ -388,7 +404,7 @@ static int authenticate_via_shadow_passwd(const char *uname)
 		return 0;
 	}
 
-	ret = !strcmp(encrypted_password_s, p_shadow_line->sp_pwdp);
+	ret = hash_equal(encrypted_password_s, p_shadow_line->sp_pwdp);
 	memzero(encrypted_password_s, strlen(encrypted_password_s));
 	return ret;
 }
-- 
2.53.0

