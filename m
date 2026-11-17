Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910738;
	b=JYbJ6KdmYQiEECAdLSIc4iVfm6ksS9tuxLgJRZ0MrbUDdOiKeU47hpuZ7KC7JqZw7Anx
	 lpNQtlQHuttl7Wfhx7yG7J0EoWlX/EA1tSBYZyYC7z2faewh9ylhWCUgxnDENrnLe3zdk
	 ACgIRLwdFaecyFOi72zoK4nFDPq2QD9n7EbiypRexGwq3IwgeWxPDNUIRvaH6ggEXB7/q
	 KwUqmoYUj+Yr0y15s6lyt2J31kJNOOcBfe1DhcqFVUVl+IFVLeo5iD31eHqSGHuGV1YvG
	 XtXpOPWHVu+xHD0ljXiPzOEA/F1Z7wCpXhADVnmOCoS9zssjnAevzJ7jVqo2ezr4hiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910738;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=rol3At8KU/jDNp9m4kI6DJPjKkKj82D0nOJ0+LPdoVg=;
	b=ibmjYlbPYKU0+gS4f1medoGGdLvx8zD+DgFfHAPpfuqCCA0jqcdiNiHpSkYL49X9MP05
	 O7/NrNCVwuIspGdhgF9AoBNExqydF8FbTTbhmF9X4JTBDpsKgnXYaj5E+RddSNju2eBqJ
	 To55/F4PYnbK0tz02FjOAOEvTMxfTlq0XFzrH7lS+IfA+kXgiGMk7ZrhgtWVylRpe3iAG
	 vZYjECjIijgB2OCJQ8QjAV63aCDY4uGAZQQPuZf+Du4YME/1nYVrzGd1jtWua3rDlMpnS
	 3EdPYRGW1I61QOyDJDfRTX6C2+mZ53goj4d4uwB2kU+q52J3dDC4+7oJRkhy3buozzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Q+bPwBLo;
	arc=none smtp.remote-ip=45.157.188.10
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA6606A88B
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CA6606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=Q+bPwBLo
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLL22V73z3R8;
	Tue, 17 Nov 2026 11:18:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910730;
	bh=rol3At8KU/jDNp9m4kI6DJPjKkKj82D0nOJ0+LPdoVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+bPwBLozqUc0jVZI5QS/RzU3PpVa/V/j6GRdt3/LNJdqK6Oncn+BVz3S0PkffJuu
	 LBeJZ9g9ZKI71dUGmyltYW2joYtH2YcdsOuKShqmQHxANveEIRm0Py45ZVGtsNRZ5b
	 Hc2dtwJ4sBJwEUl6yTG7/oItTyAg6MaBOXJm5b04=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jTLL05xLXzKG6;
	Tue, 17 Nov 2026 11:18:48 +0100 (CET)
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
Subject: [PATCH v2 1/6] lsm: Add a capable_lsm hook for capabilities guarding an LSM's policy
Date: Tue, 17 Nov 2026 11:18:38 +0100
Message-ID: <20261117101845.2523770-2-mic@digikod.net>
In-Reply-To: <20261117101845.2523770-1-mic@digikod.net>
References: <20261117101845.2523770-1-mic@digikod.net>
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

AppArmor, Smack and SELinux check the capabilities that guard their own
policy (e.g. CAP_MAC_ADMIN, CAP_MAC_OVERRIDE, or CAP_SYS_PTRACE for
Smack's ptrace rule) with cap_capable(), usually followed by their own
internal check.  They use cap_capable() instead of capable() on purpose:
other stacked LSMs should not have to authorize these capabilities,
which may mean something else for their security model.  This also hides
these capability uses from LSMs that restrict capability use in general:
a Landlock domain that denies CAP_MAC_ADMIN does not prevent a process
from managing AppArmor policy.

Add security_capable_lsm() for these checks, and a capable_lsm hook that
it calls after cap_capable().  Only LSMs that implement this new hook
see these checks, so LSMs that only implement the capable hook are still
not asked about another LSM's policy, and the calling LSM's own capable
hook is not called.  The hook gets the LSM_ID_* of the LSM whose policy
the capability guards, so that BPF LSM programs can tell these checks
apart, and so that an LSM calling the helper can recognize its own
checks.  Landlock implements this hook in the next commit.

The new hook changes nothing for current users of the capable hook, and
only adds a new BPF LSM attach point.  Calling every capable hook except
the caller's would not keep this property: BPF LSM programs attached to
the capable hook would start seeing, and could deny, these checks after
a kernel update, and the other MAC LSMs would be asked about another
LSM's policy again.  A new CAP_OPT_* flag for these checks would have
the same effect on BPF LSM programs, and would require every MAC LSM to
explicitly ignore the flagged checks.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Günther Noack <gnoack@google.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Matt Bobrowski <matt@bobrowski.net>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  9 +++++++
 security/security.c           | 47 +++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 87d9d06710cb..dc24e19f7eea 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -43,6 +43,8 @@ LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
 	 const kernel_cap_t *permitted)
 LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
 	 int cap, unsigned int opts)
+LSM_HOOK(int, 0, capable_lsm, const struct cred *cred,
+	 struct user_namespace *ns, int cap, unsigned int opts, u64 lsm_id)
 LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
 LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab5470..1e89bc1fec17 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -352,6 +352,8 @@ int security_capable(const struct cred *cred,
 		       struct user_namespace *ns,
 		       int cap,
 		       unsigned int opts);
+int security_capable_lsm(const struct cred *cred, struct user_namespace *ns,
+			 int cap, unsigned int opts, u64 lsm_id);
 int security_quotactl(int cmds, int type, int id, const struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
@@ -710,6 +712,13 @@ static inline int security_capable(const struct cred *cred,
 	return cap_capable(cred, ns, cap, opts);
 }
 
+static inline int security_capable_lsm(const struct cred *cred,
+				       struct user_namespace *ns, int cap,
+				       unsigned int opts, u64 lsm_id)
+{
+	return cap_capable(cred, ns, cap, opts);
+}
+
 static inline int security_quotactl(int cmds, int type, int id,
 				     const struct super_block *sb)
 {
diff --git a/security/security.c b/security/security.c
index 4727b8347fc4..36365fac5801 100644
--- a/security/security.c
+++ b/security/security.c
@@ -664,6 +664,9 @@ int security_capset(struct cred *new, const struct cred *old,
  * credentials.  @cap contains the capability <include/linux/capability.h>.
  * @opts contains options for the capable check <include/linux/security.h>.
  *
+ * An LSM checking a capability that guards its own policy uses
+ * security_capable_lsm() instead.
+ *
  * Return: Returns 0 if the capability is granted.
  */
 int security_capable(const struct cred *cred,
@@ -674,6 +677,50 @@ int security_capable(const struct cred *cred,
 	return call_int_hook(capable, cred, ns, cap, opts);
 }
 
+/**
+ * security_capable_lsm() - Check a capability that guards an LSM's policy
+ * @cred: credentials to examine
+ * @ns: user namespace
+ * @cap: capability requested
+ * @opts: capability check options
+ * @lsm_id: LSM_ID_* of the LSM whose policy the capability guards
+ *
+ * Check whether @cred has the @cap capability, when @cap guards the policy of
+ * the LSM identified by @lsm_id (e.g. CAP_MAC_ADMIN to manage this policy).
+ * @cap is first checked with commoncap, and then the LSMs implementing the
+ * capable_lsm hook may restrict this use of @cap.  LSMs that only implement the
+ * capable hook are not asked, so they do not have to authorize capabilities
+ * that guard another LSM's policy.
+ *
+ * Callers: An LSM uses this function instead of cap_capable() or capable() for
+ * a capability that guards its own policy, with its own LSM_ID_* as @lsm_id,
+ * and then makes its own decision, without calling its own capable hook.  This
+ * function must not be used for other capability checks.
+ *
+ * Implementations: A capable_lsm hook can only deny a capability that commoncap
+ * granted.  It may be called in atomic context, including with interrupts
+ * disabled or from an interrupt handler (e.g. Smack's SIGIO check), and @cred
+ * might be another task's credentials (e.g. a ptrace tracer or a SIGIO
+ * recipient).  An LSM that restricts capability use in general should implement
+ * both the capable and the capable_lsm hooks.  This function calls every
+ * capable_lsm hook, so an LSM implementing this hook and calling this function
+ * should ignore checks for its own @lsm_id.
+ *
+ * Return: Returns 0 if the capability is granted, or a negative error code
+ * (e.g. -EPERM) otherwise.
+ */
+int security_capable_lsm(const struct cred *cred, struct user_namespace *ns,
+			 int cap, unsigned int opts, u64 lsm_id)
+{
+	int rc;
+
+	rc = cap_capable(cred, ns, cap, opts);
+	if (rc)
+		return rc;
+
+	return call_int_hook(capable_lsm, cred, ns, cap, opts, lsm_id);
+}
+
 /**
  * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
  * @cmds: commands
-- 
2.56.0

