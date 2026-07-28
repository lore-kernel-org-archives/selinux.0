Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901526A1C4;
	Tue, 28 Jul 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202259; cv=none; b=EBVEEAa4v4E+mZxVkr1wGozyWpSf2CcTZFVMKyLlOOmUDafwqCsH99a3EY/Wba9j0mb7KGjRHdLjoBHqKRr6y9DuIDIWYgaB8sm4IbmMPG2z1E9WVVQ77nCs4Y/DUfyyvNOVfCV87RPMbaYVoKVTVv34enjixvnk31ZWVdJDsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202259; c=relaxed/simple;
	bh=IUAAQeY1ttsCPr1spBxmvPKX1rp+/Hsnqk5wZOn6tx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGAt0dvRAenVXJ3+mcsYujTz2zPiHb+cker4Ama/4PISkeYA7rowRaolhLBXAVme4JC/ZrgDVqBLCFX2ZHJYFdBN/tFEVK+zvW3pPOPz1w9kPW3OaOKD8yChntupkPESypFE0p6ad6vwC8n65aHyVNyTbGTmATpGx+oukZhsyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+qIZjwd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+qIZjwd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E156AC2BCF7;
	Tue, 28 Jul 2026 01:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785202259;
	bh=IUAAQeY1ttsCPr1spBxmvPKX1rp+/Hsnqk5wZOn6tx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K+qIZjwdOliXTVEXCCE6mBC69Bth0m3ufewOkxlcU1m1B2jfl3JxfshCYmS6VctzG
	 D4nB0swKXrwUEUnLY0xEvDmDkMXZWKDi51GUCx/gYbGY7gqwYwa+ysLbsiaIDgrEof
	 cj5NeyHvcm5Gm2oJyboqAQ1A/BlMoMGFGGvUv6Gr8QmdFGtEWN4/fyopcWCynpQkQJ
	 NOQC9IUQhcIw53QZ4wjDitpvzGZSenf6soxkiQo3edelgijmmbW2WtVm3CT57rJ0S9
	 hOd5aNsjUjJKUH4XBA9IgM5dGGxTnBbcqXgA3aiBktnNsijD5/EVkgbjpayUTcKadN
	 mmPXYreKhr4Aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F14C531D0;
	Tue, 28 Jul 2026 01:30:58 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 27 Jul 2026 20:30:59 -0500
Subject: [PATCH v2 2/2] selinux: reject a class permission count below its
 inherited common
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me>
References: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
In-Reply-To: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785202257; l=1793;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=axntQSnIG2WGrQfpV5GsiSNroNNW1F4YZJy6q4kqSWo=;
 b=arKPlgG7oPTYXLAfp1enS/EjTgKbG3UmWih2wc5fSmK2n/OQqcKFed7RlYri0uXTHDL6xPznl
 rZMlFod9ug4DBb0XY+xqoZHRE8au8msOaMaZ5WC2/uAKX3rVcclkrMv
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

security_get_permissions() maps an inherited common's permissions into
an array sized by the class's own permissions.nprim, but class_read()
takes that nprim verbatim from the policy image and never checks that it
covers the common.  A class that inherits a common of N permissions while
declaring a smaller nprim is accepted, and on load the common's
permissions are written past the class-sized array -- an out-of-bounds
heap write.

Reject a class whose permission count is below its inherited common's.
Well-formed policies, where the class count already includes the
inherited permissions, are unaffected.

Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 security/selinux/ss/policydb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6973b68d9782..c6f55f0b4cb5 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1422,6 +1422,18 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 			       cladatum->comkey);
 			goto bad;
 		}
+
+		/*
+		 * security_get_permissions() maps the common's permissions
+		 * into an array sized by this class's nprim, so a class must
+		 * declare at least as many as the common it inherits.
+		 */
+		if (cladatum->permissions.nprim <
+		    cladatum->comdatum->permissions.nprim) {
+			pr_err("SELinux:  class %s has fewer permissions than common %s\n",
+			       key, cladatum->comkey);
+			goto bad;
+		}
 	}
 	for (i = 0; i < nel; i++) {
 		rc = perm_read(p, &cladatum->permissions, fp);

-- 
2.55.0


