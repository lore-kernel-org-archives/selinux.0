Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342653;
	b=oTnjoLsTbpEtype8atcz9VLxtBLr9PhERmlaSGQyzEvgM0k1KXkqkVWsjys8puDB91PC
	 BVZynC3YOMStniegAoJBKHvaso8asbvxtCbxgiazBGwQa5T5X5By8ojHm7990DmOa4Etk
	 BWvMU0/qusWiUmiLdiffHCi1u8j7nEfW+m6QlMpZELxG74toZY5ZQoJbfsfMkKzDw9Bi7
	 kjK7p1jrUwOKXZbpCkzoZKPHL1X2bhkLee7AamtwklHBGOTiaZ3BCscJglhjqovE76jt1
	 DQykYZOBm3D+uiYITgTMuTRlurgwxRvERTXSOfb6ZeDJasP4DVnclfgB9W15j+zGHSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342653;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=SLTuo8Bf8VesaAkT6DczV4E9wggKp8EAHDqnPASoGtA=;
	b=TWQiZzhL/PtWIviwUsNavXC+keX1s73lRXjlGQC5xzvIHN7O8m9zWk+rNjv5zgyLLy/2
	 QEj8xSmr29flFWCIIydjdgoMBwMfpbv1VDgms+DRrtPK+etAENl134pnsQiNK0IQLaUxo
	 hhu+QVuvi0xD3CN0aO0eqCKxI4YC7Wi8WjWLdBIq33nnKIlOBiIQ3EVkyz90BLC4x+5V+
	 1wZ/LicD2vz1fOjfEk0q6f4ZhxleHdlw5jMs3PelFNLBPJcq5Ax+Sf4WpsxKk9TK9YVoN
	 tTguW5Go4LBCHBjmH4aS19dttZqT6YrRrO9udsYaHwGUujE8jEjbjqSvHPaZXKyGySA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=smJhIW3Z;
	arc=none smtp.remote-ip=83.166.143.174
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AF606A33F
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 20:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3AF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=smJhIW3Z
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPJFQ39ZgzhSr;
	Tue, 10 Nov 2026 21:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794342650;
	bh=SLTuo8Bf8VesaAkT6DczV4E9wggKp8EAHDqnPASoGtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smJhIW3ZiKdcSt4kr0Z4Nr3AHa2wf7l+F+SUlwNRZg1toAtSo1Zw35GwKCmVWnDC4
	 bmBKoGh55a0w4d/GAgxCJ0vlek9GdMfSQiKwjbWbDJSEQlo7ViX/1yV0iqm2Y17J8E
	 pQNvy4Xb/7ts4BXdHXMt+73mNuAQPA9Ukel1kJLA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jPJFN6pDRzxBr;
	Tue, 10 Nov 2026 21:30:48 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	James Morris <jmorris@namei.org>,
	John Johansen <john.johansen@canonical.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH 2/6] landlock: Restrict capabilities guarding other LSMs' policies
Date: Tue, 10 Nov 2026 21:30:36 +0100
Message-ID: <20261110203042.2410140-3-mic@digikod.net>
In-Reply-To: <20261110203042.2410140-1-mic@digikod.net>
References: <20261110203042.2410140-1-mic@digikod.net>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

A process in a domain that denies CAP_MAC_ADMIN or CAP_MAC_OVERRIDE
could still use them for AppArmor, Smack or SELinux policy, and
CAP_SYS_PTRACE for Smack's ptrace rule, because these LSMs check them
with cap_capable() instead of capable().

Implement the capable_lsm hook with the same check as the capable hook,
so that such capability uses are restricted like any other.  The
following commits switch these LSMs to security_capable_lsm().

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/cap.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/security/landlock/cap.c b/security/landlock/cap.c
index c9a900888f3b..162edf689f29 100644
--- a/security/landlock/cap.c
+++ b/security/landlock/cap.c
@@ -91,6 +91,28 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
 	return check_cap(cred, cap, opts);
 }
 
+/**
+ * hook_capable_lsm - Deny capabilities guarding another LSM's policy
+ *
+ * @cred: Credentials being checked.
+ * @ns: Target user namespace (intentionally ignored, see hook_capable()).
+ * @cap: Capability number (CAP_*).
+ * @opts: Capability check options, see check_cap().
+ * @lsm_id: LSM_ID_* of the LSM whose policy @cap guards (unused: Landlock does
+ *          not call security_capable_lsm()).
+ *
+ * Other LSMs check the capabilities that guard their own policy (e.g.
+ * CAP_MAC_ADMIN) with security_capable_lsm() instead of capable().  Restrict
+ * them like any other capability use.
+ *
+ * Return: 0 if allowed, -EPERM if capability use is denied.
+ */
+static int hook_capable_lsm(const struct cred *cred, struct user_namespace *ns,
+			    int cap, unsigned int opts, u64 lsm_id)
+{
+	return check_cap(cred, cap, opts);
+}
+
 /**
  * hook_capset - Restrict inheritable capability changes
  *
@@ -163,6 +185,7 @@ static int hook_vm_enough_memory(struct mm_struct *mm, long pages)
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capable, hook_capable),
+	LSM_HOOK_INIT(capable_lsm, hook_capable_lsm),
 	LSM_HOOK_INIT(capset, hook_capset),
 	LSM_HOOK_INIT(mmap_addr, hook_mmap_addr),
 	LSM_HOOK_INIT(vm_enough_memory, hook_vm_enough_memory),
-- 
2.56.0

