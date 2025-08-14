Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2A302CC9;
	Thu, 14 Aug 2025 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178043; cv=none; b=gguYAjsEIosjTeim0efa0+wY8K+5ZWx4eFWdx2PqCLoLlXylOBubDt5IUjEh3z1oAiIxivLwGoTkp+krfJCuGNas/RPfuY5LIqKaLi7Q8XFabKfVrCC8mUIQhHLomeKbFQPSEwo7obp39J/r4PYe+vzQMHdc+/PYe4US6TgeYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178043; c=relaxed/simple;
	bh=KN0/S+8rpLesvBfi+mtPBpI5Z6d3xfDto121NMdjASE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8m7jKoKaFeG8HKInKXcdFlxw2wyjSw1SPeupvIZua1etNVYG8h0sa1Ax8qOHo2HlqDoAYyaFgeORisc6/CHl8J7djFG7CXNCmbfaAbWZQ/52XRU8/sJ5gfGdgORUGTsETuOmf5X72NKDI1MwRtS2qZU0nIIX0Fdo6TVl4+L+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7S8cgJG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7S8cgJG"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109a95f09so6545451cf.1;
        Thu, 14 Aug 2025 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178040; x=1755782840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRSvOFPs/2RHCnOkkG6JYaD2YABtGfmjzG/bNAI2lk8=;
        b=I7S8cgJG2lapz3ro8Z0B01E45AuFMuhHfZRy82GOvWVoTKhOPrCg0vZbDeSGHTfO7B
         hgn7DamYKnctY1J47KZACCmPCHvvBVKs3unbx/nLX5n3Q/56nF+8j5oLCikRJ28kc8WV
         NlR6Xi4QOoVUhg0iSqtflgAc0StQX3Hukg/zATwrXC65FC5eR2gzz7BFxB7XN1G06pc3
         Aim6P7uCweaWrWjHz13glrUdQWx9Yy7+F0t3ipONf+UtpFJIpxBD9FCQM2K55YKLcWvS
         MrMfC6NlLg0OL/Wd+fIMx7bcVmm8xThcdqeUG9g7b3rVzu+RFUTpUcTybJryBac1n/lD
         cz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178040; x=1755782840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRSvOFPs/2RHCnOkkG6JYaD2YABtGfmjzG/bNAI2lk8=;
        b=FnT7Dpc7MqABmfSe1+cutJe8GEBcG7mdvNv63e0OxOjgQ/2wuBeIQxeY8M2fB8cn7f
         YKT/u1Sq2J1g1mGieodfRIVHKcAgJFHlVTl1l+ByzAuKJQNupg4VH1WxuBfxFvic9C2J
         OR6UkwhXSKKjvMehP/E+X9qYpNEFS2YAPfkbOV46sM/fJR0F9LeE+heWA/sNx1czmOXk
         x+ZG/mwONDaeONZONkr2lW4wZ3/H8ec99EHsacGv83pAjUiPF6rdvS7YUGAxCdU45c7R
         tOZ75z8JbK10Yk/ktEZUh7piYjeZfEfNrsUIrBOrUhYyIjPvcaEbwUQlk2N3VSjmkxp9
         PMdg==
X-Forwarded-Encrypted: i=1; AJvYcCWAW1Uhle/drItVeoHtoeFCeU152eX7GAzAO0yIgi5UZEdMPEa77XWr6q48M06Ns6UVTH9ljE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgjZPkSdg99GR86Tgju3EeJByzc3tkgWm24iArNkmCVEWZ8UO
	hJEfPowIpWLdCKRUH9TI9pPwyQGLGKLGIK3KotR6hYF0KmLyRwBnpHpOkCRSCg==
X-Gm-Gg: ASbGnctH3U7PHC3EsATKrwy9QPulEhMWc1i/8oIFjNdjQTa6qXTvQEra4CkKDA7xnQY
	B2zdtXE0rhqgGiNfG6fFltNnZvBDWnq4Ddc8ftZli401yl13NqvNm4PVoYzSKtn7ThAwlRJCzSV
	getqwpZius7TSakSxszXP1wfRM7izzJ7qEaaq8K8e4nPghEwKaVbIwJzRhTj8aS9jx77Ncx18mD
	AyVmnPIAvlXphX2H+gHqTllI0L+5B5aS+FSiuzwCblASmSpA0jbppklAGOTvSgKBeIzqe1HMvU1
	EhLZaC6ylHaVyTVbsNWgvC7SzomK+iBwfwsE3bMJAm35KZqmYJD0zs1+XRixeVADtK4onUkv1OX
	9WKQpAHHzYSAIZ9viCAnRq97ztNx24DzicDKPtVlNPmMS/0GYfWAqfwhzgw2cEub2kBnpJogVy7
	79BqX/RzRQNprcXNMHCJXgb3AcGg==
X-Google-Smtp-Source: AGHT+IH7ghfUxfxTpz+nQg1yqdQgiPqlhH87P9M5/YKk68mCrS61/3D6bLW4Dwuu5GU/F4l7T8Af9w==
X-Received: by 2002:a05:622a:52:b0:4b0:761a:6c2a with SMTP id d75a77b69052e-4b10a917c5cmr43510071cf.11.1755178039681;
        Thu, 14 Aug 2025 06:27:19 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 16/42] selinux: introduce a global SID table
Date: Thu, 14 Aug 2025 09:26:07 -0400
Message-ID: <20250814132637.1659-17-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 145432020575..e84f3a1e3e12 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -104,6 +104,7 @@
 #include "netlabel.h"
 #include "audit.h"
 #include "avc_ss.h"
+#include "global_sidtab.h"
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
@@ -7911,6 +7912,9 @@ static __init int selinux_init(void)
 
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
2.50.1

