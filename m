Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51441A50A;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519850; cv=none; b=cX/DGH1Fa2eojIHw7jIkstil602kHU0haxcCg6wOdh/YlcwEQ/uYEq/gc4zI7SGgqpOxCX1ssaAZGP6JlKX+yS3meBOdoW9UgXvyfYBK9M78VgWsjAsmnztbz1HJaQRgwkypjwWh0zGw42Bhvs9sLBU1Yn4V2RAiiE7zjElq3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519850; c=relaxed/simple;
	bh=bFweYXHzDsjnKqwBBx2UMemvlHC1eJ4kYwCV3M57T3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNf+ULEFHX9h4pBY29RnHeO89ijxQYFTTqkkzRcmlDgvStcsbSV4Sr5ZqUEhTD+MmsNpQWEwipBDGcAGMpuYGW3ompX5ugbJXUqSHpqUN4Kfh5hyjViKxohNT9g5D6VKPKQki2/VYbW13fZwpiro/2YMXW4HQHrFCt0FaFLjboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyi6G5Sw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyi6G5Sw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 260DFC2BCFD;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785519850;
	bh=bFweYXHzDsjnKqwBBx2UMemvlHC1eJ4kYwCV3M57T3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wyi6G5SwUsmpmRr50UURgk4a3EzEgzxb9AdHb/2Rw69H/b3nDoP6NIPAJaSwJD5ZZ
	 rS/B3FPSv057DLN2v1c2ggCvMB5n/5au7RFtYHlKcKnNngXkTP15xMPeV9lzNzzxNV
	 WMmto3sCdKtXnyvF8Jk1nAsLTCL3dd/1nGlyFlIBI5OCpHqauJJlWojjv+qeOSUcE3
	 80DV2ZyrzqYEYrotGs/K2vrVE7dirFDSb2fZYB+7kyCtkNdQCPrjbaex7X+v3bj1l9
	 Hl6cBCLkGldgWtW7mQ9ubC7iUS28MzXFzDjk/DNPtUZakmAbX9Lldanurtmnr7S16m
	 iZbhwrwsoSf7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E575C55174;
	Fri, 31 Jul 2026 17:44:10 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 31 Jul 2026 12:44:12 -0500
Subject: [PATCH 4/4] selinux: require every boolean value to be defined
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-b4-disp-d32e997b-v1-4-0341d038ee47@proton.me>
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
 Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785519848; l=2108;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=I7aNEIxlzRwFx8VoQh04N3ZU/iwunm3TR1TrNlfSSMw=;
 b=xlN1scXScpwCr94ODTYukby6eRZzCnJ4J8SLTAx69Wrc1Z/ByhoW6GiXq2lXmxnnxj/aTJpCM
 Huj0PC2hY5qA8pV25NA1wYbbzCA/Pv8ZfYRxXH7yKK9ErBS7rtk/qQb
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

p_bools.nprim comes from the policy image independently of how many
booleans follow it, and cond_index_bool() fills bool_val_to_struct[] at
value - 1, so a count larger than the values present leaves NULL entries.
Every user of that array then walks it by index and dereferences each
entry: cond_evaluate_expr() on the access-vector path,
security_get_bools() and security_get_bool_value() behind selinuxfs, and
security_set_bools(). A sparse class value is absorbed by
policydb_class_isvalid() and its siblings; booleans have no such
predicate, and no consumer that could use one.

Reject a boolean value that no boolean defines, once, where the array is
built. Conforming policies define every boolean they declare and are
unaffected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/selinux/ss/policydb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index d358200817bd..d88713201be9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -719,6 +719,7 @@ static inline void symtab_hash_eval(struct symtab *s)
 static int policydb_index(struct policydb *p)
 {
 	int i, rc;
+	u32 v;
 
 	if (p->mls_enabled)
 		pr_debug(
@@ -769,6 +770,24 @@ static int policydb_index(struct policydb *p)
 		if (rc)
 			goto out;
 	}
+
+	/*
+	 * A sparse class value is absorbed by policydb_class_isvalid() and
+	 * its siblings, but no such predicate exists for booleans: every
+	 * user of bool_val_to_struct[] walks it by index and dereferences
+	 * each entry -- cond_evaluate_expr(), the two getters and
+	 * security_set_bools() -- so an unclaimed one has no consumer that
+	 * can tolerate it.
+	 */
+	for (v = 0; v < p->p_bools.nprim; v++) {
+		if (!p->bool_val_to_struct[v]) {
+			pr_err("SELinux:  boolean %u is declared but not defined\n",
+			       v + 1);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
 	rc = 0;
 out:
 	return rc;

-- 
2.55.0


