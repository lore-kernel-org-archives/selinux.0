Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9A27CB3D;
	Tue, 20 May 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742482; cv=none; b=pTbxrqUU2GkoDGUJjC8mVgGhf7W1/bAaZFfMgyxIU1Oi+jTK1frdR8ss/P5gHljUPN7bvVwBiUOarD5B07RYgv+Q50z2bM3oN+I/WIcYpX/rQTz0NBCEYsTFSXQ3x8JynudFgwsANA6q6O5fvAK8MeJiRtzxEYveDG8fVzZ10xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742482; c=relaxed/simple;
	bh=2kgap9yzCwoV6yH9c9SPGCNcEsGTCsmmvmRmZcu9u/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9l0B02d25OHYsEhoqU/Lr10Ybte9IrQwIKwWaCjsqW4XOXAraDL2vwFiy/1yDwV81qSntWqeB4NDg/2CwpmC6cyQ3azR7EGSZeb1kwETVYkbsBB1LxG16FD3D5jYC45RllvONZXqcivFOMLqxaoDMhuqKUNFYMyk0MpwUPbWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa6ScENH; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa6ScENH"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87bee00b392so2443055241.3;
        Tue, 20 May 2025 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742479; x=1748347279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGi38HZ+1c2qafQEvUTxg5k4bN21jwyEfv42/DfSG3k=;
        b=Sa6ScENHwhEcNOQ5Arbzz63zLo3EtSx9EIlbWpFIOdUrnFQyLdHWutSo4L+d9k61PT
         sA0Gjoy9TGCZwntzQCc6uPjqgcXxxhxuMIrx9fSSWMrsZ/2qX+UEJuOJ8DsOOQgo7ild
         OIB5r7PW38ydDTRDchjWjDVxp+Ga4AhsCbTCBLxofm/jlKtzNN+c4ZIYszt35wbRNfDc
         Gi5BgAm8ytfQnBdty+a3wXAyzYHR439Bx08XB36jRJoPl1RAhGbavF5RfLM7VhHiqP8H
         a0ngEL3GbaNY6Iz61HqGYgKWSXxyWzC41yImTOA4rss34ZDDRXuA/mjDFrz/RVwnGfb6
         ZXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742479; x=1748347279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGi38HZ+1c2qafQEvUTxg5k4bN21jwyEfv42/DfSG3k=;
        b=SzJrKGzRkPNnb1WPA7uk7t8E5FqwdtCd/4iHfpofPMh24bBk7JKJSF9e5UBMnr5F6p
         ssxUc1PTsnwHn2sJOPdhNzKXcg7WEZh7U2wBjOB8RllWM8MgV+Hx2OS/qyNrDznOs+7+
         vEb8aiDOD/qPoPTuJ87nMAiABYfp38Ho+cdHu+vo7WcrwcJrFpi5ejdmtIdC+civsAuH
         mnDhlq8MIFjMmJ+CA+olm+LcZQWDFBXYI9g2J6YeUD98DGgSSA+mS2uSKObzosMkywfq
         H5vA4iw8Zv051lcyXjAcJmFka6pHfp3IG2TScfvtXd2Ankt//NXWuI7x/u7oRSwrUUQs
         Sitw==
X-Forwarded-Encrypted: i=1; AJvYcCU4lHSA7adGugcZiMs/6NIt9esPkm4q7R9fo2OBgHd3m7+t3F4dLtOsLnmVWxtxVIcb408D26I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIEUFE04L3LXr00JTbV5HBTQuj6cXOMa/l1ndiTeLjuvfGfj56
	45VYshOW5B7O2LU0XGMJzsseqnQcnJIS+/yu2GwScZtVRRfxysXX17c5rZEK9w==
X-Gm-Gg: ASbGncvfFkQS6Vn0X7ZuiO69gl8+UF/p6OxLdVpqFnYYimMXuNZTylwsqBkUwS+GnR9
	RZfIm8w8aesyz/TTYqJCZ2hNDPKtu49Ghm185FQ6MfvnzeFwXys9IIqfXYXUsA+Sc3/PuslycJG
	0ncRZROa8NuVATwKENTtt/Y7/D0yxMkJHHgIxW+SVpZ2TQAPJWNwrKqm+MoSNvQBa8EHzV58dPc
	caqCy0ZGrf4dBg0S6+g27yuLmawbw/z7yofrhGhRC2JmMF7t+R/5Uu7d2nH2dq9MZ/exr5DzdsF
	5zgkI4syuijbt17i4I9tn7WptfzJe3o0NW8AtoZ8l1jb6XPVSJFBbf7AH7gPXKR8ORfm3jOYKQa
	iF+xdkv1n0OWeHbjWD8+hY5G0XwJXKWnqMENZdwEcqO5o5Ux+9TdqBA==
X-Google-Smtp-Source: AGHT+IFuIUZNuihkCcVu2ArYTiwy9GRomlV242kL3F+stWogSS19zogx45wo3xM7h34Ebya7dVwkJQ==
X-Received: by 2002:a05:6102:5714:b0:4c1:94df:9aea with SMTP id ada2fe7eead31-4dfa6bebe78mr14488977137.15.1747742477472;
        Tue, 20 May 2025 05:01:17 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:16 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 15/42] selinux: introduce a global SID table
Date: Tue, 20 May 2025 07:59:13 -0400
Message-ID: <20250520120000.25501-17-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a global SID table to provide stable global SID values
independent of any particular policy or namespace. This table will only
map between global SIDs and security context strings since it must
remain policy-independent. Internally each of these global SIDs can then
be mapped on a per-policy/namespace basis to per-namespace SIDs and
context structures. The LSM interfaces and blob structures will only use
the global SID values and thus remain namespace-neutral.

Note that this required moving the SID table header and its dependencies
out of the security server subdirectory. While we could re-factor it to
to reduce the scope of this change, doing so does not seem worthwhile.
The security server abstraction is largely obsoleted by LSM, no one has
contributed any other security server implementation for SELinux, and
over time there has been an increasing blurring of the boundary between the
security server and the rest of the SELinux module. Eventually, I
anticipate fully moving the security server files out of the ss
subdirectory but that is left for a future change.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/Makefile                     |   2 +-
 security/selinux/global_sidtab.c              | 109 ++++++++++++++++++
 security/selinux/hooks.c                      |   4 +
 security/selinux/{ss => include}/avtab.h      |   0
 security/selinux/{ss => include}/constraint.h |   0
 security/selinux/{ss => include}/context.h    |   0
 security/selinux/{ss => include}/ebitmap.h    |   0
 security/selinux/include/global_sidtab.h      |  19 +++
 security/selinux/{ss => include}/hashtab.h    |   0
 security/selinux/{ss => include}/mls.h        |   0
 security/selinux/{ss => include}/mls_types.h  |   0
 security/selinux/{ss => include}/policydb.h   |   0
 security/selinux/{ss => include}/sidtab.h     |   0
 security/selinux/{ss => include}/symtab.h     |   0
 14 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 security/selinux/global_sidtab.c
 rename security/selinux/{ss => include}/avtab.h (100%)
 rename security/selinux/{ss => include}/constraint.h (100%)
 rename security/selinux/{ss => include}/context.h (100%)
 rename security/selinux/{ss => include}/ebitmap.h (100%)
 create mode 100644 security/selinux/include/global_sidtab.h
 rename security/selinux/{ss => include}/hashtab.h (100%)
 rename security/selinux/{ss => include}/mls.h (100%)
 rename security/selinux/{ss => include}/mls_types.h (100%)
 rename security/selinux/{ss => include}/policydb.h (100%)
 rename security/selinux/{ss => include}/sidtab.h (100%)
 rename security/selinux/{ss => include}/symtab.h (100%)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 66e56e9011df..fe5f6f4bb0ea 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -15,7 +15,7 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 ccflags-$(CONFIG_SECURITY_SELINUX_DEBUG) += -DDEBUG
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o status.o \
+	     netnode.o netport.o status.o global_sidtab.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
 
diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
new file mode 100644
index 000000000000..57866a2d4cc2
--- /dev/null
+++ b/security/selinux/global_sidtab.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "global_sidtab.h"
+#include "sidtab.h"
+
+static struct sidtab global_sidtab;
+
+int global_sidtab_init(void)
+{
+	struct context ctx;
+	int rc, sid;
+
+	rc = sidtab_init(&global_sidtab);
+	if (rc)
+		return rc;
+
+	memset(&ctx, 0, sizeof(ctx));
+	for (sid = 1; sid <= SECINITSID_NUM; sid++) {
+		const char *str = security_get_initial_sid_context(sid);
+
+		if (!str)
+			continue;
+		/*
+		 * Before the policy is loaded, translate
+		 * SECINITSID_INIT to "kernel", because systemd and
+		 * libselinux < 2.6 take a getcon_raw() result that is
+		 * both non-null and not "kernel" to mean that a policy
+		 * is already loaded.
+		 */
+		if (sid == SECINITSID_INIT)
+			str = "kernel";
+		ctx.str = (char *)str;
+		ctx.len = strlen(str)+1;
+		rc = sidtab_set_initial(&global_sidtab, sid, &ctx);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+int global_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
+{
+	struct context *ctx;
+
+	rcu_read_lock();
+	ctx = sidtab_search_force(&global_sidtab, sid);
+	if (!ctx) {
+		rcu_read_unlock();
+		*scontext = NULL;
+		*scontext_len = 0;
+		return -EINVAL;
+	}
+	*scontext_len = ctx->len;
+	/*
+	 * Could eliminate allocation + copy if callers do not free
+	 * since the global sidtab entries are never freed.
+	 * This however would not match the current expectation
+	 * of callers of security_sid_to_context().
+	 * TODO: Update all callers and get rid of this copy.
+	 */
+	*scontext = kstrdup(ctx->str, GFP_ATOMIC);
+	if (!(*scontext)) {
+		rcu_read_unlock();
+		*scontext_len = 0;
+		return -ENOMEM;
+	}
+
+	rcu_read_unlock();
+	return 0;
+}
+
+int global_context_to_sid(const char *scontext, u32 scontext_len, u32 *out_sid,
+			gfp_t gfp)
+{
+	char *str;
+	struct context ctx;
+	int rc;
+
+	if (!scontext_len)
+		return -EINVAL;
+
+	/*
+	 * Could eliminate allocation + copy if callers were required to
+	 * pass in a NUL-terminated string or if the context_cmp/cpy()
+	 * functions did not assume that ctx.str is NUL-terminated.
+	 * This however would not match the current expectation of
+	 * callers of security_context_to_sid, particularly contexts
+	 * fetched from xattr values or provided by the xattr APIs.
+	 * TODO: Change context_cmp/cpy() or update all callers and
+	 * get rid of this copy.
+	 */
+	str = kmemdup_nul(scontext, scontext_len, gfp);
+	if (!str)
+		return -ENOMEM;
+
+	ctx.str = str;
+	ctx.len = strlen(str)+1;
+
+retry:
+	rcu_read_lock();
+	rc = sidtab_context_to_sid(&global_sidtab, &ctx, out_sid);
+	if (rc == -ESTALE) {
+		rcu_read_unlock();
+		goto retry;
+	}
+	rcu_read_unlock();
+	kfree(str);
+	return rc;
+}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 83846fdaa3ad..9531f4c31766 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -105,6 +105,7 @@
 #include "netlabel.h"
 #include "audit.h"
 #include "avc_ss.h"
+#include "global_sidtab.h"
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
@@ -7915,6 +7916,9 @@ static __init int selinux_init(void)
 
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 
+	if (global_sidtab_init())
+		panic("SELinux: Could not create global SID table\n");
+
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
 		pr_notice("SELinux:  virtual memory is executable by default\n");
diff --git a/security/selinux/ss/avtab.h b/security/selinux/include/avtab.h
similarity index 100%
rename from security/selinux/ss/avtab.h
rename to security/selinux/include/avtab.h
diff --git a/security/selinux/ss/constraint.h b/security/selinux/include/constraint.h
similarity index 100%
rename from security/selinux/ss/constraint.h
rename to security/selinux/include/constraint.h
diff --git a/security/selinux/ss/context.h b/security/selinux/include/context.h
similarity index 100%
rename from security/selinux/ss/context.h
rename to security/selinux/include/context.h
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/include/ebitmap.h
similarity index 100%
rename from security/selinux/ss/ebitmap.h
rename to security/selinux/include/ebitmap.h
diff --git a/security/selinux/include/global_sidtab.h b/security/selinux/include/global_sidtab.h
new file mode 100644
index 000000000000..f62a9165d26a
--- /dev/null
+++ b/security/selinux/include/global_sidtab.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A global security identifier table (sidtab) is a lookup table
+ * of security context strings indexed by SID value.
+ */
+
+#ifndef _GLOBAL_SIDTAB_H_
+#define _GLOBAL_SIDTAB_H_
+
+#include <linux/types.h>
+
+extern int global_sidtab_init(void);
+
+extern int global_sid_to_context(u32 sid, char **scontext, u32 *scontext_len);
+
+extern int global_context_to_sid(const char *scontext, u32 scontext_len,
+				 u32 *out_sid, gfp_t gfp);
+
+#endif /* _GLOBAL_SIDTAB_H_ */
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/include/hashtab.h
similarity index 100%
rename from security/selinux/ss/hashtab.h
rename to security/selinux/include/hashtab.h
diff --git a/security/selinux/ss/mls.h b/security/selinux/include/mls.h
similarity index 100%
rename from security/selinux/ss/mls.h
rename to security/selinux/include/mls.h
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/include/mls_types.h
similarity index 100%
rename from security/selinux/ss/mls_types.h
rename to security/selinux/include/mls_types.h
diff --git a/security/selinux/ss/policydb.h b/security/selinux/include/policydb.h
similarity index 100%
rename from security/selinux/ss/policydb.h
rename to security/selinux/include/policydb.h
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/include/sidtab.h
similarity index 100%
rename from security/selinux/ss/sidtab.h
rename to security/selinux/include/sidtab.h
diff --git a/security/selinux/ss/symtab.h b/security/selinux/include/symtab.h
similarity index 100%
rename from security/selinux/ss/symtab.h
rename to security/selinux/include/symtab.h
-- 
2.49.0

