Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96425207DF2;
	Mon, 16 Dec 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367304; cv=none; b=S+P6XOosmiCxff7pbvzrKn+UlV9aVWYmrpNruKEjL6nORQr2YvC/JG28b4AtaNJVlXWVEzCsG8tyZJgW4qwGhqyFdHoAtsR31FJHcZj4EwHdodCGvGZRDZ9wNeXOvQz4CRGfeF8oGgBItns0f6GOpaLa+uW9NicgtdYbmZta2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367304; c=relaxed/simple;
	bh=hNg/Qz11syzvghERYrwvFPfLZLkPxl3br+J2LfisMUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brKN3jo3dnw1BLdqfH/zliLTEv0Y0FaOq+GE49mf9y8HvxNZ3BUeluJ7Vj+Ozyx0S7GTyycXa9JZpMvw5mrqaQjY5+KdXXqQiu/WwrL4/0TRP0kCagfhPK2aaXPNt2bwSYXeTqWf0JtTVnFmgEKuHvYRg2jwQVn9LxDWcgUrzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WXtxhAhr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WXtxhAhr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367300;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9iSryDRZBI2nIdATwcGjmOxgO8ipbyS67pGtNdHMA+I=;
	b=WXtxhAhrq8LmwncAwX2BbenE6KE/Z6fLiIzE3kHsTled2zGByvM7U9LaYGzbEZtXhJVwsj
	I8+eUZBY4fb1VN8FZfZn5oDMlpA7RVi5rX/Ip0kjD70Ste5ZUcQRhhsJJXoiFGHJdsRKxi
	D9c/Moa+CndUUcm097MQ5WRcbY2BMCIKT0xe2ST+IrYa2OxqngWLiN8JQxrDDBFso7mNQk
	BESrMsskzANVcm2SF817D+v11xl/+O17dunM4u9iabjutOShBiQsOI41piNmW/t5PlYuff
	b2oRCliXZjcWsn+eaqSe2dSW07v0pQojUj2C3/VJtvUwSsSR2clKUpVh2oxCbQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 09/22] selinux: make use of str_read()
Date: Mon, 16 Dec 2024 17:40:07 +0100
Message-ID: <20241216164055.96267-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Simplify the call sites, and enable future string validation in a single
place.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 10 ++--------
 security/selinux/ss/policydb.c    | 22 ++++++++--------------
 security/selinux/ss/policydb.h    |  2 ++
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index d8dcaf2ca88f..1bebfcb9c6a1 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -230,17 +230,11 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 		goto err;
 
 	len = le32_to_cpu(buf[2]);
-	if (((len == 0) || (len == (u32)-1)))
-		goto err;
 
-	rc = -ENOMEM;
-	key = kmalloc(len + 1, GFP_KERNEL);
-	if (!key)
-		goto err;
-	rc = next_entry(key, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto err;
-	key[len] = '\0';
+
 	rc = symtab_insert(s, key, booldatum);
 	if (rc)
 		goto err;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f7d0867428f5..2408c3e8ae39 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1095,7 +1095,7 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -2475,24 +2475,18 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	}
 
-	rc = -ENOMEM;
-	policydb_str = kmalloc(len + 1, GFP_KERNEL);
-	if (!policydb_str) {
-		pr_err("SELinux:  unable to allocate memory for policydb "
-		       "string of length %d\n",
-		       len);
-		goto bad;
-	}
-
-	rc = next_entry(policydb_str, fp, len);
+	rc = str_read(&policydb_str, GFP_KERNEL, fp, len);
 	if (rc) {
-		pr_err("SELinux:  truncated policydb string identifier\n");
-		kfree(policydb_str);
+		if (rc == -ENOMEM) {
+			pr_err("SELinux:  unable to allocate memory for policydb string of length %d\n",
+			       len);
+		} else {
+			pr_err("SELinux:  truncated policydb string identifier\n");
+		}
 		goto bad;
 	}
 
 	rc = -EINVAL;
-	policydb_str[len] = '\0';
 	if (strcmp(policydb_str, POLICYDB_STRING)) {
 		pr_err("SELinux:  policydb string %s does not match "
 		       "my string %s\n",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 80d1fa7e4995..25650224b6e7 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -386,6 +386,8 @@ static inline char *sym_name(struct policydb *p, unsigned int sym_num,
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
+extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
+
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
-- 
2.45.2

