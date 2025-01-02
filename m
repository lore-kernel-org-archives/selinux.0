Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB81547FB
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836344; cv=none; b=PypUbhSFxh6kbFjiGAaqA/DUOQk1JqkpU2eBi0+YWoHGz1XWmPPc5W43Z6qlL5VTxyaKMLUJxVVju5rmVDjXHdkk6Sb6ovQOgH7Uww/IqmXWPASeK0KFRY7LOFkNqhZYNSGRm0O2g2g5X0udoMcrzMtMBbBaTUFxnTxR/9yh9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836344; c=relaxed/simple;
	bh=+wgSUrfBNcSxnhjdhXGTQqX8dDLfMwhcw/rztHHLK6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9OivI4jVv1ACmHdPmxaRTFhlgYuHVbXrwtu0uMr3l/OSfj7TyHlX6goronwvvqH4JqP8OJokZcVqBJg+3anL3Q6OL/ZzsA9zwLS3Wp3hVdSvnHqY3NGzKNimSU9m/VKI7mgxZkREXm7SH18jm5VfaHq2N0vhRKHCVDjo9bP+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9MnNJ0X; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9MnNJ0X"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467a1ee7ff2so94757461cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836340; x=1736441140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss3+Xgf2qnfOq82Ts7mEUS75c6/pwDte5IzPghKPzB8=;
        b=K9MnNJ0XzCL2GMws+Fpn7v/imK4rFAT82y6/dA/Iqg4U7vs6mgTEzzpQETaXE+sILw
         w2Ef8kpUIb0gPlf0PVvq7pkFRt0w4iOn/5SWPd4f65zQngSm+PGoznFrP+EfYqIh5cDT
         vfPhwkFQJslVyczoAt4i+FGHzPnQ3i2mc4cr61LzKwB0HbM56V04xcsSrNEQWC0Wdo2Y
         FWiU1VWtQRF8wF/3vaqEI1pyQ0CxefVNXavS78B0R7YsX9N3Bu+bSd7CXDc+iBugsoeu
         5mvD0l3Ai7M2yZjQJQQuH0/PQV00vUFHD5t3/MWJSfAzT9jr+5J/x8jXtcPMqTVedX65
         SdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836340; x=1736441140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss3+Xgf2qnfOq82Ts7mEUS75c6/pwDte5IzPghKPzB8=;
        b=Cek0rV0GONc54T3dkGOJGT2ag1P89aZEC4tvILLICqoGY2+rBj8qfwCAU5Ab5xtTDs
         KZWJdgKTQivCCKzpl1Rs5JS8tQhC4Q3f/KCt9pU1Nw2BAf39IU24l1RkyduITa7EYatM
         zFisFDQxAIg8lqOGJ9yT+TArbBTUSVVI+WMUvSOgKjdDUewgwikfbJGHR70Uy5NQl5H0
         ZlEIfGhNA05VHBtxn5HaVEF8iackfitOprT6qEkVf3/xz7q4rw2kQNEX49YNe6WT0Hxe
         u7AV5FZR8/Znedut8fyARF4FNNFvi7vMo+hTDrM/5MXTRtv3hN1D3Bo4JHPe8T/GFlBF
         DwFQ==
X-Gm-Message-State: AOJu0Yz7U7pxVqpu2nHGrRE1CK1NERVT4o076qLxl4XbhHs2KA8omQod
	rngzs3aflviBNKvUlZCnJd5pARKhJMLUcmWxxKCh9Q1rfj/HXDqQbqR39A==
X-Gm-Gg: ASbGnctpKXfijsam9heapt7LMAoGuBFNpeLKMz9dkDgfkLN5mJbGfHwVeTEnphFavur
	g+CuDrI7op9Jk3hU16feqjFp2W0JQBKMymr5qOdilnjBIQnOH6P9fVeiX3nxnKd0WYIRYBfrgxg
	kEefgF1ayr/vd/OncBpWXK/wO0O6wjuA0UqzmjbWFxTSOqviy0hk1VF2ZRjb2SdiFr6mzNQ7UWf
	BoJKfgENfEA60P+zzqbKiHFqKr5S/oiVqyLS2yThcpx/jCXL9PcJ42HQhXFuK9pczZiw2w7toNz
	dZBDjDQVRgLUEh35lqKzYxMYr1Xa0i3f6BOAHgh6YsFuWuDfOAJn5lXERa8XTroxNz+91A==
X-Google-Smtp-Source: AGHT+IFYVzcT0DttA1ea16/WZKDKLgmk/tNsTUSN3YacHSNRLdhbXKYfcP6XBgEKQA/orVhfXqQ9nw==
X-Received: by 2002:a05:622a:28b:b0:467:63a5:fb9c with SMTP id d75a77b69052e-46a4a98a203mr862126761cf.44.1735836339962;
        Thu, 02 Jan 2025 08:45:39 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:39 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 10/44] selinux: introduce a global SID table
Date: Thu,  2 Jan 2025 11:44:35 -0500
Message-Id: <20250102164509.25606-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
 security/selinux/global_sidtab.c              | 100 ++++++++++++++++++
 security/selinux/hooks.c                      |   4 +
 security/selinux/{ss => include}/avtab.h      |   0
 security/selinux/{ss => include}/constraint.h |   0
 security/selinux/{ss => include}/context.h    |   0
 security/selinux/{ss => include}/ebitmap.h    |   0
 security/selinux/include/global_sidtab.h      |  19 ++++
 security/selinux/{ss => include}/hashtab.h    |   0
 security/selinux/{ss => include}/mls.h        |   0
 security/selinux/{ss => include}/mls_types.h  |   0
 security/selinux/{ss => include}/policydb.h   |   0
 security/selinux/{ss => include}/sidtab.h     |   0
 security/selinux/{ss => include}/symtab.h     |   0
 14 files changed, 124 insertions(+), 1 deletion(-)
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
index 000000000000..161cf31f1ba4
--- /dev/null
+++ b/security/selinux/global_sidtab.c
@@ -0,0 +1,100 @@
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
index 1aa0bb1a83ce..3f6c49c62e96 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -105,6 +105,7 @@
 #include "netlabel.h"
 #include "audit.h"
 #include "avc_ss.h"
+#include "global_sidtab.h"
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
@@ -7662,6 +7663,9 @@ static __init int selinux_init(void)
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 
+	if (global_sidtab_init())
+		panic("SELinux: Could not create global SID table\n");
+
 	/* Set the security state for the initial task. */
 	cred_init_security();
 
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
2.47.1

