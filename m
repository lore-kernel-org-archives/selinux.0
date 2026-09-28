Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC624E50AF
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617625; cv=none; b=XCuSnpRPKpDe1vtkjUVxOJI8+fSS/Lr9jl+zVO9CH5qwUA7xWozea16BjcmIylnpNuJWERBS13hHoB3kJlsjF0sJW6UzeYpLSL1u8ooO0FwfwS1Xkv8YJSBY17ASP6K+HxHXf+OvUe06Urark3qKai0jfq/YjtGp5hIgyjC7bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617625; c=relaxed/simple;
	bh=wFZ3S0+0FMr7yy5rcAeRwGcxsoaT7BqF8Fom7xbH3Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8BsPDj6jyl/WKfzg7hejdphJXeo1lwsUb3sNnCTo8Mj2NXsX9xVKZ8cHIPUTMG/0jav4IkDsZ67a1D1qw8/BTBDM51mg0Nkz+pg+dqyD7rijHDWjkmavVfVNKp+jZaWin8l9JIhlhtKlFmxTfSlVEeADmZRnqlLkFFQ13X4ESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Lvwz/OGh; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Lvwz/OGh"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617621;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJTAJuu2W1ENVZPLsi1Zw/TM1hYV84CQN4ualZGZvuo=;
	b=Lvwz/OGhKOXs6CszClkpIiqyUrW+KXiK2ODQlpoyUyR/AAyvCz47C+ZUKBYcolkYkFh8jD
	904b21GNYwSupV/coyicVOee4PDs1KcqXZ5RNuYfuyVDMRGW/LGkjM46ISzEljQdcGpTVs
	+uKmW4zsPhcLxaqVDVMmNso0FkNzIxwj1H2urhmtyxRUzg7IE54tFxLEWvL7Q2LBU7QN58
	LJJg79/Jc3jdqdb887wBQc32fbVMS85gxAnbVrh41PSqHIV2I0rnI7ldHDvfmInAuMj8Eb
	PachSD9N/qN3E4sgSmjKOgJ5RLuVZyKBca6G/OnU3fEqYVwFIFkIHKZkvuHAfg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 16/32] selinux: drop unused policydb parameter of perm_read()
Date: Mon, 28 Sep 2026 19:46:26 +0200
Message-ID: <20260928174643.2458710-15-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
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

perm_read() never uses its policydb argument.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ba96baec74a9..94b0f1392ad3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1224,8 +1224,8 @@ static u32 perm_claimed_mask(u32 nprim)
 	return nprim ? U32_MAX >> (SEL_VEC_MAX - nprim) : 0;
 }
 
-static int perm_read(struct policydb *p, struct symtab *s,
-		     struct policy_file *fp, u32 *claimed)
+static int perm_read(struct symtab *s, struct policy_file *fp,
+		     u32 *claimed)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1310,7 +1310,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &comdatum->permissions, fp, &claimed);
+		rc = perm_read(&comdatum->permissions, fp, &claimed);
 		if (rc)
 			goto bad;
 	}
@@ -1561,7 +1561,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &cladatum->permissions, fp, &claimed);
+		rc = perm_read(&cladatum->permissions, fp, &claimed);
 		if (rc)
 			goto bad;
 	}
-- 
2.55.0

