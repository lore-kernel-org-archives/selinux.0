Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB342ECD00;
	Fri, 20 Jun 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441537; cv=none; b=pd4g/mCP7fzyzfkwsjfYbVedn8UdCegWFQgSklsN8Q5xIGqv7L6xyXEDMqEExfJiKMjsG52fVC556u8N3fsJSYxeUVNiBEGvkFxrN0jwxeOEF9cwjM/wSzm7D7OwtghcNo5iFqG5VRYz3ZNcRYUXMDDjCoogtwgFKm658Ue3eys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441537; c=relaxed/simple;
	bh=cNUuqaPpvc81kKLcN9PmV+sQyDM9u+R7zFqOpBFW6Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxpA26CsE9PV17fFXMmgziMdZBJTpcfzRU8pj/IKxzR+uMSEXQuVf1GmcjlDWYngLxk8DqnKb56WChk2ZvtxMjFoxtbak037MhUVi/eagwgNmaNZ0LfbVqQDxINRAk64DQhj1SjPRaL18UzmlB4i6n9NJA5M2UgaZjRyKCklZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bch/t6Be; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bch/t6Be"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d20f799fe9so255062585a.2;
        Fri, 20 Jun 2025 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441533; x=1751046333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENDQWy1ZUtYUWV3oPCfwl7LKYKj5w605BvfCO2LQPio=;
        b=Bch/t6BeVsLuMBY0ro74xojQtSFujUg6GXd6vyB300vHTWQ3xvzQ3r0PRb/xBqLSlX
         Poub6sqlavM9ZHqNyffIDvkJ0OcgZmjX43Dpfpvu+WxMhpVjwqoUcdAzQFVjFS5a6HLg
         /kJ08V+8Y31GlMcGuFojoHMcgGkDgnAfRhDEkZU0j5n8MLQlOwbWIsazZ5oGdnLP6oLC
         JkCnNQAIJ+qvA/+m6kzFTaMA5FZnMallDydbWm2aGzFlqjFjJclFkzQlzk4i/SR3MyE1
         +dnR0FgzdJr5PAxrBBehvzAZfOl6ycSVRog2a3pJfFCFjVenf+6YXnIz0rX37muvj4CD
         6EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441533; x=1751046333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENDQWy1ZUtYUWV3oPCfwl7LKYKj5w605BvfCO2LQPio=;
        b=gKAIWFhs7ZTYzQDk55ctNeE8HOyHmLMmdfQSS0iR+khaXujOCJTSRMlu8BmwzuBYsw
         xKzJh1GNO6f/CjRPP0bKB8XuPyy4ukwAjq7J+aOXPFe08JJoPrENJa1r+w/AuMvps1zJ
         Uw688VunyCVZwPxOVF8Ln/4YmwOchHkpntgN1rP3d9plJ3VxiOpNmAQCy4xo8Qi3aJaD
         2fb1J9/oXk5q16XROAHz0Zm4+fTyW9H987WoVT3Z+q0F36ZnDMNIwqO1P/i+FA3sR9xT
         zg7depLXacbQenWPIjDaKPChnaVG2iXAD0U4bU2F5B4CjM5O9xn3cu8XTjsYVF3mpj/L
         6TTg==
X-Forwarded-Encrypted: i=1; AJvYcCXdmfEC5Kvg76tUqwyM8wCQqDPSDhfr8Y0aXvWgk6npY1bMCKJw76AJA7CYz6mADXZO6e9Gnrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk68NfIF9PpQ4PW2CpcrUoDd9HNIxZ+f6JYAe23WQq6Z+xmBY/
	ZQCNvEtJJ2DxJ66q0LiuGYPVJmGOIVZ++gNp39Y7iThIghXqkpIja0ddLnXz0A==
X-Gm-Gg: ASbGnctW9Vlf8Egv6KzXPuZAEqb/NjpufWmFxFGWBBehCRfMOIH0hyvosE3miQfbXBE
	poWGzHkETsqx1+CrHo8cbI3xJ0dV9g31QRt/Gc46PGxX8UztbW9xLrkHgBXXGiSLqQYJPsIJqEr
	BLZVH0gmk9WgxXeWxgD5n5KME/ZT2pWqAVkMLH5aDGyoTgW9G7kmRdRVOv7eDCtkl7xZaV7EpI6
	U6aYT/Z2ZohnPWUDYNyVLB9zUN6ykHaG4sUzdEojc94+fiWHXNs11TAOjgMlzdEkbJDZZs6MLJx
	RgJDewsylWoPFPkpkJI6kWoxI+KeFoBVYIpX6kimaZts8U/uWE/rK9jW98wIf1k4Q27uYAUT2Yp
	GGwBJ6FcMNfZ5zabaZHqp38HMaof1pGNy+5wL4qDyi5wvAdQxby6md7o93DJQLyEemA==
X-Google-Smtp-Source: AGHT+IGvD1ulKtwt9XLeaUjvzti+LGR/OJ5beNQhPlxzNt05HCjHaJAjwaaz7H33UW2S9V9utoxJLA==
X-Received: by 2002:a05:620a:3191:b0:7d3:8a1a:9a03 with SMTP id af79cd13be357-7d3f98c9769mr490121185a.14.1750441532672;
        Fri, 20 Jun 2025 10:45:32 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:32 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 16/42] selinux: introduce a global SID table
Date: Fri, 20 Jun 2025 13:44:28 -0400
Message-ID: <20250620174502.1838-17-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index e091b1c12189..3d6c6d04b42a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -104,6 +104,7 @@
 #include "netlabel.h"
 #include "audit.h"
 #include "avc_ss.h"
+#include "global_sidtab.h"
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
@@ -7897,6 +7898,9 @@ static __init int selinux_init(void)
 
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

