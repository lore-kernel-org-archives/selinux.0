Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F34EBAC2
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617631; cv=none; b=JAJzqDeqcnRMa0eUxa84kRRDzkqDoyIXSZ7lIL+mPzKXsFJX4Y7ofrEaqTng9KmqKdS5KeVxdh7U7/933MWJCLAm1SdSQW5jC4+Ql8WT8azjt3ykp6M+MC4DlT9P7JiC716IXGhVBanbkVoAbzOscn2dXgx1MW4JDWmqDwNZxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617631; c=relaxed/simple;
	bh=AdTXqmbMXCBRSyV0hRYPwJw665NmbrsQxo3jT/8khc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFbCQrBvZRuqFE2YyF8yy79rpMGKeAgi/R/yUfRxCON9ak45kNL3y8w6rAfpatCLVDiB+wBfx4RzOsp33WafdQD4L0reyRMJ2FhJ/FDXzzh6CP1h1jAAu5Md/hePgxlPPENANuku/CD9s+f9GTCFj6FLnivhZYrwUGcCmHd/AW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=nIeMELbK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="nIeMELbK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617627;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHJCF5xZzuEs9D6mYFMP9guvUULIsYFQkoSgPcfxm0E=;
	b=nIeMELbKZ+VyVHoA+9t0Hoy3eUrRIhVK6PxE3b3ABsWy4KphPwDu068BBfHZm9Y6hiKuYd
	n38bLEIiQmijKNfU5YBv1/VSzdFrzZf2FY7uhOfcov9SFviXYczX0XL2pXuLQ17eIImc7t
	mxOpvk07MSSLvrYxWSEAwNs/NjYSLAq5lL+rKmiI2TWMOZ7m/ugNQTB3Keke1+6FgOIoya
	ImD9+VvTelpM6jwW/gJs2Xt452nn3qL2RR/Im+1/twx7ASo7ERTGGUclBb+IBuEggP+qIw
	0cuJxt+zZO9EQ9RNVHQw5DFdcVzIXnJ9L3piX5m6wQHfhXICcKHqZV4aKHrvcg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 32/32] selinux: drop unused policydb parameter of context_write()
Date: Mon, 28 Sep 2026 19:46:42 +0200
Message-ID: <20260928174643.2458710-31-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
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

context_write() never uses its policydb argument.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 5230c24d46c3..5c3bf5bcbe47 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -3317,7 +3317,7 @@ static int role_allow_write(struct role_allow *r, struct policy_file *fp)
  * Write a security context structure
  * to a policydb binary representation file.
  */
-static int context_write(struct policydb *p, struct context *c, struct policy_file *fp)
+static int context_write(struct context *c, struct policy_file *fp)
 {
 	int rc;
 	__le32 buf[3];
@@ -3705,7 +3705,7 @@ static int ocontext_write(struct policydb *p,
 				rc = put_entry(buf, sizeof(u32), 1, fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3719,10 +3719,10 @@ static int ocontext_write(struct policydb *p,
 				rc = put_entry(c->u.name, 1, len, fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[1], fp);
+				rc = context_write(&c->context[1], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3733,7 +3733,7 @@ static int ocontext_write(struct policydb *p,
 				rc = put_entry(buf, sizeof(u32), 3, fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3743,7 +3743,7 @@ static int ocontext_write(struct policydb *p,
 				rc = put_entry(nodebuf, sizeof(u32), 2, fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3757,7 +3757,7 @@ static int ocontext_write(struct policydb *p,
 				rc = put_entry(c->u.name, 1, len, fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3773,7 +3773,7 @@ static int ocontext_write(struct policydb *p,
 				rc = put_entry(nodebuf, sizeof(u32), 8, fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3792,7 +3792,7 @@ static int ocontext_write(struct policydb *p,
 				rc = put_entry(buf, sizeof(u32), 2, fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3807,7 +3807,7 @@ static int ocontext_write(struct policydb *p,
 					       fp);
 				if (rc)
 					return rc;
-				rc = context_write(p, &c->context[0], fp);
+				rc = context_write(&c->context[0], fp);
 				if (rc)
 					return rc;
 				break;
@@ -3861,7 +3861,7 @@ static int genfs_write(struct policydb *p, struct policy_file *fp)
 			rc = put_entry(buf, sizeof(u32), 1, fp);
 			if (rc)
 				return rc;
-			rc = context_write(p, &c->context[0], fp);
+			rc = context_write(&c->context[0], fp);
 			if (rc)
 				return rc;
 		}
-- 
2.55.0

