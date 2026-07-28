Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D82D7DCF;
	Tue, 28 Jul 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202259; cv=none; b=rmW5sWfXi4G++KHy+5EYj1tt6CuY7YmG6eOyD/mIXFXnrItg4D9EKq27upC+HTapFLqnx1FrcqP+vP+Wh5H468AgpL9rI1LCOllB4wIO5ejV89oMYS8Q6GxUbLXM+UuO3gFlOwjOWEKlF8jzBmhoWoQilqv0QvZ+Mv07ety+zAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202259; c=relaxed/simple;
	bh=g6ELA6w6wX71TLC+GpqqzwmtUwgwnpmoH0/55gXfLPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rp5vi3a5WdymskBNkX0LiSRHxpRhk40oLR4pfCaBnJXx8SJfEsm6W59JZi9MTYZvu4eaBu4trDBFhKit9LEcG7gvu44tiaZnmCLedksafTpkC+zRM6eSjmnbGscZ3ny61xQHJYF+GTQkOzbXUXl2qTGi5a6BhgoH0PZ9OtmDbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZyLzcKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZyLzcKN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8E89C2BCF6;
	Tue, 28 Jul 2026 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785202258;
	bh=g6ELA6w6wX71TLC+GpqqzwmtUwgwnpmoH0/55gXfLPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lZyLzcKNV0ckhFvLj0voQRoVt5ALBBj8Ohm4GBobDi9/PjQ9KHyGTdohjpSprN+XO
	 LmcHltWawQqrbYJNnB5+15/TLnkMHW0K7ilK4IV1FNqiIDOsnc0wmsXmzwUz3Mj9KJ
	 HvuxbAoxROr4v/0FTXTEg+jnaL06Uu2WudCeF4wHbDAF/U8lOgMMBi50EfjNRDS0Cp
	 90W9mS1N+m2e9HNCAP9O/+LBozKn7y4TMfhjH+ifrVfdzyjmJl7evrf2vqLed4IO3z
	 z04Taxc/IeD2aMtPkdvDbwsy0pT1WPWbbidcXNe3160Vy+6Luu/KkEyXOHgZBbhInY
	 XNKTdAArj+7Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D05C53219;
	Tue, 28 Jul 2026 01:30:58 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 27 Jul 2026 20:30:58 -0500
Subject: [PATCH v2 1/2] selinux: reject a permission value exceeding the
 class permission count
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-b4-disp-eed1276a-v2-1-82d58cf5f882@proton.me>
References: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
In-Reply-To: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785202257; l=1530;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=yrR0J/KtX6kOGBTtPStu41rJtkaFIXc1/3i/rJVo4oE=;
 b=CpNGcsUh6o8Zv6M3FjXDkbjYlYGi91EIgV8GqGVISea+A+F3fDfkDIZ2ekqWaH2eO5MCnyvjH
 WQrB4/8ZUHaCE+VkrEuYB2a6LMQwID1VUOZhriAPvVoG5S6sXGUmFZe
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

perm_read() bounds a permission value by SEL_VEC_MAX but never by the
nprim of the owning class or common, which is taken verbatim from the
policy image.  security_get_permissions() then writes perms[value - 1]
into an nprim-sized kcalloc() array, so a class declaring fewer
permissions than its largest permission value drives an out-of-bounds
heap write.  The top-level symbol tables are validated this way; the
nested per-class permission table is not.

Reject a permission whose value exceeds nprim, which is already set when
perm_read() runs.  Well-formed policies are unaffected.

Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/policydb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ead504a639e3..6973b68d9782 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1175,6 +1175,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	rc = -EINVAL;
 	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
 		goto bad;
+	/* the value indexes an nprim-sized array in security_get_permissions() */
+	if (perdatum->value > s->nprim)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)

-- 
2.55.0


