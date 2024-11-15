Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382611CFEB0;
	Fri, 15 Nov 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677824; cv=none; b=sBMo13YJcZ/sRknF45OuP0DqyIzy5sIrvV5ae7QnItTY7GDoJ5Pq6iSItuyZYusKuHW/PraSlgH/MAA2wZ9Fwl4EBPRxyiwBQZctlRyc+6uzWV48rnn5WcxMmJmyoFwn+vjzRZas4lXUmgWzeKjpSKDpI+RaeY6iQ5JNnUghtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677824; c=relaxed/simple;
	bh=Qi5uU9Lr32zm5lBntEXTsVXtn5mnAC+JMA003HLFpK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbLRc+/c1NvO/HBxQknfYXoa8f7vW+f0VXRjlh3PdU7A3HekJPG/QpOXgaGeiBS2wbSqjksdZaVuT+Y5HjixvkPxqHrQXL3fONI1JAOpot2WugSj+NI6w3NTSkfKvvK4sCMVPiNaghREtz42YhKQeQJq3CRoAtULn3G8ARk/8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=tpShXVzQ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="tpShXVzQ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677821;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuUoMQkq4d/vNy6ZfPDe+aWo0af6VdWRl/2f68jh3NM=;
	b=tpShXVzQcdABBlPcanCS4vLYOcY8nOuqAktIfngZ5GzZYKc9fxNKzAyd13eOlsymdTQV5K
	ct2YYnsFZutbLTm/UY/wg81uFznV4mswwUJTRXVYKtElEPDFSV9hv9g17pmURzdcMyCUxE
	eSPb+u3ZxPoTO6W69IZfIYJZ+wDu80tb4SxAF3t9g201zigUy5DENadKWBHFZmVUC0aBQt
	83wQcQTYrQ/6Z64cu9SEQRJUU/3TX51mSMUWgtoe6HZIhcMt+1IEP1ViuQtln98EnoDrjP
	plDnN4lAocjvkafzoVpw+12GjDPF9ukjni2JCud4ThwkvpwSWdSFotmhqTrXOg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/22] selinux: make use of str_read()
Date: Fri, 15 Nov 2024 14:35:28 +0100
Message-ID: <20241115133619.114393-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
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
index 244dc8279113..f8a21d10ff92 100644
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
index 5e9a54645b80..1de48cccd61a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1090,7 +1090,7 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-static int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -2470,24 +2470,18 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
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
index aa37f4eb6244..9e7ee53c996b 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -387,6 +387,8 @@ static inline char *sym_name(struct policydb *p, unsigned int sym_num,
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
+extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
+
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
-- 
2.45.2

