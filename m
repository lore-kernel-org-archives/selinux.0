Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4BKPOgk027815
 for <selinux@tycho.nsa.gov>; Fri, 11 May 2018 16:25:25 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e9e6a58e-e5f2-381d-fb5b-11178239cc48@schaufler-ca.com>
Date: Fri, 11 May 2018 13:25:16 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 24/23] LSM: Functions for dealing with struct secids
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 11 May 2018 13:18:11 -0700
Subject: [PATCH 24/23] LSM: Functions for deling with struct secids

These are the functions that mainipulate the collection
of secids.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/stacking.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 security/stacking.c

diff --git a/security/stacking.c b/security/stacking.c
new file mode 100644
index 000000000000..7c9643323a1e
--- /dev/null
+++ b/security/stacking.c
@@ -0,0 +1,119 @@
+/*
+ * Security secid functions
+ *
+ * Copyright (C) 2018 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2018 Intel
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ */
+#include <linux/security.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <net/netlabel.h>
+
+/*
+ * A secids structure contains all of the modules specific
+ * secids and the secmark used to represent the combination
+ * of module specific secids. Code that uses secmarks won't
+ * know or care about module specific secids, and won't have
+ * set them in the secids nor will it look at the module specific
+ * values. Modules won't care about the secmark. If there's only
+ * one module that uses secids the mapping is one-to-one. The
+ * general case is not so simple.
+ */
+
+void secid_from_skb(struct secids *secid, const struct sk_buff *skb)
+{
+	struct secids *se;
+
+	se = skb->sk->sk_security;
+	if (se)
+		*secid = *se;
+}
+EXPORT_SYMBOL(secid_from_skb);
+
+void secid_to_skb(struct secids *secid, struct sk_buff *skb)
+{
+	struct secids *se;
+
+	se = skb->sk->sk_security;
+	if (se)
+		*se = *secid;
+}
+EXPORT_SYMBOL(secid_to_skb);
+
+bool secid_valid(const struct secids *secid)
+{
+#ifdef CONFIG_SECURITY_SELINUX
+	if (secid->selinux)
+		return true;
+#endif
+#ifdef CONFIG_SECURITY_SMACK
+	if (secid->smack)
+		return true;
+#endif
+	return false;
+}
+
+#ifdef CONFIG_NETLABEL
+/**
+ * lsm_sock_vet_attr - does the netlabel agree with what other LSMs want
+ * @sk: the socket in question
+ * @secattr: the desired netlabel security attributes
+ * @flags: which LSM is making the request
+ *
+ * Determine whether the calling LSM can set the security attributes
+ * on the socket without interferring with what has already been set
+ * by other LSMs. The first LSM calling will always be allowed. An
+ * LSM that resets itself will also be allowed. It will require careful
+ * configuration for any other case to succeed.
+ *
+ * If @secattr is NULL the check is for deleting the attribute.
+ *
+ * Returns 0 if there is agreement, -EACCES if there is conflict,
+ * and any error from the netlabel system.
+ */
+int lsm_sock_vet_attr(struct sock *sk, struct netlbl_lsm_secattr *secattr,
+		      u32 flags)
+{
+	struct secids *se = sk->sk_security;
+	struct netlbl_lsm_secattr asis;
+	int rc;
+
+	/*
+	 * First in always shows as allowed.
+	 * Changing what this module has set is OK, too.
+	 */
+	if (se->flags == 0 || se->flags == flags) {
+		se->flags = flags;
+		return 0;
+	}
+
+	netlbl_secattr_init(&asis);
+	rc = netlbl_sock_getattr(sk, &asis);
+
+	switch (rc) {
+	case 0:
+		/*
+		 * Can't delete another modules's attributes or
+		 * change them if they don't match well enough.
+		 */
+		if (secattr == NULL || !netlbl_secattr_equal(secattr, &asis))
+			rc = -EACCES;
+		else
+			se->flags = flags;
+		break;
+	case -ENOMSG:
+		se->flags = flags;
+		rc = 0;
+		break;
+	default:
+		break;
+	}
+	netlbl_secattr_destroy(&asis);
+	return rc;
+}
+#endif /* CONFIG_NETLABEL */
-- 
2.14.3
