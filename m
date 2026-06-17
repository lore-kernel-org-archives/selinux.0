Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6130F94B
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700387; cv=none; b=tkRv7+IGf/Bv2GLFCMBhmrqdMw1H/f/fzecoDF43B1eDY70xaJY733Vs3wU7zExJHQcFEislqmkeegJtQ5VE4KGjXMOZDhafk9YKrvF57kVnXtJAc40UKbpNKVtR3FPai9a/D52X/zzaVgfO37yK0elYs7yMdB84oAhQoxqHtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700387; c=relaxed/simple;
	bh=7lkGsJHQq5OsYWb8v/Qpmk8wHaTEu2Z39BzMuwJ9jAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSPyPeAn196Gr7DKoYd1Sx8mZtrCFFNIujzE8DS6T+2uie2J9sJlQZ51UbpArmLN2XxsucRap4qbaJmh8XNMk5IaMFTIJky/saDqlPSzHP+1EhP2pltnDnqtYGVHYlq2fOepaFL/cnKwWstlGkvFBRRREzJWjNI7JL24X7xbf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fckmcwg/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fckmcwg/"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9159951f05aso628036985a.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781700385; x=1782305185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omIktVGPkATG6i7O/PtF8yw0mLZF9PmpmAFwct5wGXc=;
        b=fckmcwg/HrS1Y+o3K6joRMkcIFs+f/1gKnHSCo507QeBC3skul+/Xc4N6gyLHfJGWH
         497zoK4jautKl3xbhXi/feVv+q/2ZsJ9IM1Q9WURNm8CxLZcsFp57kjn7ZFipHzTS75N
         l4Q0E5gwH9lcccEU2uXUqYI7rt38f39vMgVWLcyR58ubXKA5nMz0dyjsN+bcqT4y9FAT
         9CqUYSPhTcXfuiBby9/5Pom4CJZCjnhNEv4QhuVkDarGa5tdAoYFGZJx0/74KEYFUZPD
         1s14xd5/QpLVyY6La1sedKsQZgUcvvrc3Ulne/jY0F3XwuNvFzmSnWyk6z2yLzE37Cif
         EUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781700385; x=1782305185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omIktVGPkATG6i7O/PtF8yw0mLZF9PmpmAFwct5wGXc=;
        b=Z6atgt5AODjtSq2BAucJMbVac1KZ0SfcgAGoUWTAQzJXlT0MWxFkKeHZa2JJ2SlDgw
         Yx9S0M5DaCJfYbT4obg0dYY3U6BeNnop4Cg69+HTA4/AKWYHgCKMcXNP9asC8dvTk96U
         ptSGOn0g14zBW2fwtOVJBs+CTRUY1Dfng5are4267YUtUXhC40/SKWp8kLw8lOZH5ZSO
         r9/xHNZWD7VNNSldljZ7eCJGm1puW55BHYrKY3/4azDoJzSoTrtwMtzqFX7Q73mnTOgC
         bRvlpzUD4nkXYJakdbD01hSC+0xcvuGK5UEFYPwtNzAg/86mZGll1Lm6BZhxVlDxI+4r
         9pyw==
X-Gm-Message-State: AOJu0YwvTpQuWS3rVhw3iA4ojX6zMTh2+fjLmfuTv8is4eL7xZ+KZyyp
	mjTLPEeMB4jhYxu5m5QO4UA73GsqNfiOaIqzbwC0FFCpbBdPKutkgfHzWyKlIw==
X-Gm-Gg: Acq92OFzgQoHnDtXpfhY9aDL5f+vEQWnRWnLdZsdLSSVSy6uyStbJR8KhTjvuw9w1XR
	YbwfEJSadVoK/a7zWqXXleX9iAfXg4uxj3CvYI/Ce/h5F7jfDMDqARMGzrqrh+BhEmTTbrR2NgT
	b+0O+KduVKSGSv1vNg7oRy2XsymuAhNRCi0Ul8L0Cynjt+NhLU7tm6C4TTzbJge7fpVAj6H588G
	Mt5TGxtL2PCO9jJ0tm6iRSvf2gBWkKwGM8ALZ18GY5K9D8gWWHOFiQWVxvxyWXFImxfjG5T1LJJ
	Cc317RRN/0TRTlxvO0LVSLCkJTW1iE0M2CQ0o7+bx4Uxc45I8bU8/KsTs7OVFSKBSpVJjvFay7K
	6zrOudTdcQ8wJbkH9PlD1/Y6eZrHz7a7ZUjxFsb1KfEL/+XwPemAJHwpQMF8hSD9pnUs9a5ARJD
	MKy20DgsDD5kyvlF8QJmS7U0HNtDrWa0gxfpuPnUar0sAj+JE1jlwCVF8ELDbK6VEwF+pTENhx5
	9oncvHf10d11dXP
X-Received: by 2002:a05:620a:40cc:b0:914:c82c:79fe with SMTP id af79cd13be357-91dbb947d96mr513368885a.27.1781700384416;
        Wed, 17 Jun 2026 05:46:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619d2fc0dsm1743920385a.0.2026.06.17.05.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:46:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] libsepol: bound category values in mls_semantic_level_expand
Date: Wed, 17 Jun 2026 08:46:09 -0400
Message-ID: <20260617124609.65706-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

1. mls_semantic_level_expand() checks the sensitivity against
p_levels.nprim but never bounds the per-category low/high values
against p_cats.nprim.

2. For a base module the user MLS range and default level are read in
semantic form with no bounds check, and policydb_read() expands them
through policydb_index_others() -> policydb_user_cache() before
policydb_validate() runs, so a crafted base policy with a category
value past the declared count reads p_cat_val_to_name[] out of bounds,
both in the "Category range is not valid" message and in the
p_cat_val_to_name[i] reference inside the loop.

3. Reject cat->high > p_cats.nprim and guard the error-message indices
with the same upper bound, matching the existing sensitivity check
just above.

Confirmed under ASAN: a semantic level with a category low/high beyond
the declared category count reports a heap-buffer-overflow read in
mls_semantic_level_expand before the patch, and is rejected cleanly
with an error after it.

Fixes: https://github.com/SELinuxProject/selinux/pull/528
Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 libsepol/src/expand.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 7162f80a..0bd61c82 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1128,11 +1128,13 @@ int mls_semantic_level_expand(mls_semantic_level_t *sl, mls_level_t *l,
 		return -1;
 	}
 	for (cat = sl->cat; cat; cat = cat->next) {
-		if (!cat->low || cat->low > cat->high) {
+		if (!cat->low || cat->low > cat->high ||
+		    cat->high > p->p_cats.nprim) {
 			ERR(h, "Category range is not valid %s.%s",
-			    cat->low > 0 ? p->p_cat_val_to_name[cat->low - 1] :
-					   "Invalid",
-			    cat->high > 0 ?
+			    (cat->low && cat->low <= p->p_cats.nprim) ?
+				    p->p_cat_val_to_name[cat->low - 1] :
+				    "Invalid",
+			    (cat->high && cat->high <= p->p_cats.nprim) ?
 				    p->p_cat_val_to_name[cat->high - 1] :
 				    "Invalid");
 			return -1;
-- 
2.54.0

