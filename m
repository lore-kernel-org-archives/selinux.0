Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44D442B38;
	Fri, 24 Jul 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904474; cv=none; b=RwzcFkkQ6vqSW9Op+2YAxeuQ5IB96rJ9PDnOWcl6GsGiQNKnRov9dcPIOCy8GOlwu0Y3By7fD8GT0MJG4BN5I1A4P19rl1U03aG1cvhx8+XfV19qY0n4MdU0HUrb0+pihLtrcHPdaJfcMahFWsy9ffwPXyHUgmu1zJrwwFljaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904474; c=relaxed/simple;
	bh=7G24fX5TzUc8Tve1qsdLsuH+gW8Sg9Dt6BCAQCeEFlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kO0SVfYwJV0wy9piicXaseML3DOrqOFIMsiySxhnBExIVp1c6o/rMNIaKR6F8bEwXn5fhPSU8+QoJA38FQyvrdM8g48O7TnZZ+EW/0VblxR7XjO3EcK2fIRYaiMUgf8iS+expUQf6t5UJwx0rd2eIYorn+K331/r+roWTJQPo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4A0E1Vk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4A0E1Vk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF2A0C2BCB3;
	Fri, 24 Jul 2026 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784904473;
	bh=7G24fX5TzUc8Tve1qsdLsuH+gW8Sg9Dt6BCAQCeEFlM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=G4A0E1VkvzAFdkfJ9I2DavUAzeM4U5Gwj9cQOLAYwgdH/yp+EhEzxFP/15HPUwZrs
	 XdIJMubiXY8tx3r7bTSFAnkOfy5VIC5qwhwf0CzC3gJszm327YAZtTgfql4k6jd7T2
	 FO4LArwn1nSoolnxsSewjCeeYCx5XVgdQQ7RlyNxmQng6M1bz+O+B0JyBFrrdCiDE1
	 vhiIRWCYh5gCy78j894m828FBhe+H6K6xJSbwL9pUTsJ04btQdHp9sLf9UYb+YLfft
	 IuXHD/KTQIADnk+JIOeItxSRp5L6KndoY9sNgMfIrOosw0/CMm20nX+1hr6HxEibHZ
	 ZuASbjVqIEa6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCB5C531FA;
	Fri, 24 Jul 2026 14:47:53 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 24 Jul 2026 09:47:53 -0500
Subject: [PATCH] selinux: reject a permission value exceeding the class
 permission count
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJqbUFr2JclGGqwwJIR4gJ4
 e4WXL7F/xsoZ2GFe7VB5lVUprGgvlRA7zi+GKUvBmusN8E67Bz2ojMyNZHa5PEWPF1THUI0Dko
 2Z07yPZeP59+6dAPT5/jAvv8AJSDY/3QAAAA=
X-Change-ID: 20260724-b4-disp-ec8ac9f6-576c3f177a04
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
 Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784904472; l=2709;
 i=hexlabsecurity@proton.me; s=default; h=from:subject:message-id;
 bh=x09qCOc67iye83BfdnhVgxWmQx/htHDGaJ30yFzOV2w=;
 b=lM6mKKeMGO+1H2Ju7gB8MHLYyN971H+gqYdlwgwpwhbj1gcPJFDLYRGbWlvOYA2j8eqqATZ1X
 PlkZ+/nL+KVAq/GAgAfRyj3SLKiiO9N3yjZc6fR76qDtGPHm54XBj2A
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=xw1AhCtQdvuoQc+bOQIYy9o8G++cp4/VniI2G/tc3G8=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/default with
 auth_id=893
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

perm_read() bounds a permission value by SEL_VEC_MAX but never by the
owning class or common's nprim, which is taken verbatim from the policy
image.  security_get_permissions() then writes perms[value - 1] into an
nprim-sized kcalloc() array, so a class declaring fewer permissions than
its largest permission value drives an out-of-bounds heap write.  The
top-level symbol tables are validated this way; the nested per-class
permission table is not.

Reject a permission whose value exceeds nprim, which is already set when
perm_read() runs.  Well-formed policies are unaffected.

Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproducer and A/B verification (below the --- so git am drops it):

A binary policy whose "process" class carries permissions.nprim = 1 while
keeping its 31 permissions (values 1..31) is accepted by the parser.  On
load, security_get_permissions() allocates a one-entry array and writes
perms[value - 1] for each permission -- a heap slab-out-of-bounds write.

Tested on a KASAN kernel, loading via /sys/fs/selinux/load:

  Build A (without this patch): loading the malformed policy ->
    BUG: KASAN: slab-out-of-bounds in get_permissions_callback
    Write of size 8 ... security_get_permissions()
    (followed by a GPF once an adjacent object's pointer is overwritten)

  Build B (with this patch): the same policy is rejected at parse time
    (-EINVAL); no KASAN report.

  Control (without this patch): a well-formed policy (nprim = 31) loads
    cleanly, no KASAN report -- the fault is specific to nprim < value.

Reachable by a process with CAP_MAC_ADMIN writing a crafted policy to
/sys/fs/selinux/load; SELinux policy load is not namespaced.
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

---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-b4-disp-ec8ac9f6-576c3f177a04

Best regards,
--  
Bryam Vargas <hexlabsecurity@proton.me>


