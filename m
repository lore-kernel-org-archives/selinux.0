Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6873C2B82
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621556; cv=none; b=gtkRtpkfiFksq4LpmhK0aQwEndCNKsShbF1FbYTOgc37fpq7fHEzB7TBVSCBxaket/C1SAUc+3eCLAaIragSwBAnm6tIZK94zF/nmaMGdj43ulD8XRFu2J9lOt2FfFG4OzLfWjI8FKNvebfdqsEi07j7sjA0f7/pjWEl6bETL08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621556; c=relaxed/simple;
	bh=Tel4DpOaQB4w+BYWjJt5hzM1pGq+lrUhJMfRtHFRRqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qG/oWMMfND3ATmTmfUZLUqwyj8stBJ9VksIzxr2twNku2c8ud6gfUnIC4A1QyFrN4C0D7j+CCE4iUAsQKj1H3q+oUe7v9pgeFD/H5KGwZv5Um9Op8zJu6jdDadBfwKtRlQnoSejxlfK9qfklIGrs5KyoVg3sF2nNTbiafwetmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Bx/0dGjL; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Bx/0dGjL"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1781621037;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tr5ZOef30jU02foHAqq1qUMPC5PGy5CLASQHK23hpCw=;
	b=Bx/0dGjLDGf7dFEdhn69u6gkz+W58VIhLSWVRMv7vzVaES3gxxHkLON2luk15JbYxc9AKg
	kgIe4d25g/3Y57esd7sx7v+K7qrWDsucdjZ1jG8m8vJV1hJErQWWgPFg//rrkuwgpBcXnQ
	BpqYomVReT13Ip8McGW0wgUJhAzJ4BL+tzf6rTW9ElVS7YWrQMnIc3YxQ+oIG0QMy+Lb3y
	u0fTNcYHwGEBqOfcxX6ZyMhnegBqIi0Tzm7DvN77Vb1ZVoRv1T+0Q2BRWhtE8UXUfSK1ez
	0c4VTimgG4y67yar4L6lci7rC331tvabOAKevuDCMKVcY6Y8jhpph2X55Qq4ow==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] secilc/docs: fix wrong CIL statements
Date: Tue, 16 Jun 2026 16:43:45 +0200
Message-ID: <20260616144345.478744-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260616144345.478744-1-cgoettsche@seltendoof.de>
References: <20260616144345.478744-1-cgoettsche@seltendoof.de>
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

- fix missing closing parenthesis
- fix enclosing of `sensitivityorder` datums
- fix typo `low_high` to `low-high`
- avoid double enclosed `((all))`, valid but particular

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/docs/cil_access_vector_rules.md       | 4 ++--
 secilc/docs/cil_default_object_statements.md | 2 +-
 secilc/docs/cil_mls_labeling_statements.md   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
index 47da60fc..b95df953 100644
--- a/secilc/docs/cil_access_vector_rules.md
+++ b/secilc/docs/cil_access_vector_rules.md
@@ -168,7 +168,7 @@ This example will not compile as `type_3` is not allowed to be a source type for
         (type type_2)
         (type type_3)
         (typeattribute all_types)
-        (typeattributeset all_types ((all)))
+        (typeattributeset all_types (all))
 
         (neverallow type_3 all_types (property_service (set)))
         ; This rule will fail compilation:
@@ -313,7 +313,7 @@ This example will not compile as `type_3` is not allowed to be a source type and
 		(type type_2)
 		(type type_3)
 		(typeattribute all_types)
-		(typeattributeset all_types ((all)))
+		(typeattributeset all_types (all))
 		(neverallowx type_3 all_types (ioctl property_service (range 0x2000 0x20FF)))
 		; This rule will fail compilation:
 		(allowx type_3 self (ioctl property_service (0x20A0)))
diff --git a/secilc/docs/cil_default_object_statements.md b/secilc/docs/cil_default_object_statements.md
index be7facaf..6f72a36e 100644
--- a/secilc/docs/cil_default_object_statements.md
+++ b/secilc/docs/cil_default_object_statements.md
@@ -195,7 +195,7 @@ Allows the default level or range to be taken from the source, target, or both c
 When creating a new `file` object, the appropriate `range` component of the new security context will be taken from the `target` context:
 
 ```secil
-    (defaultrange file target low_high)
+    (defaultrange file target low-high)
 ```
 
 MLS userspace object managers may need to compute the common parts of a range such that the object is created with the range common to the subject and containing object:
diff --git a/secilc/docs/cil_mls_labeling_statements.md b/secilc/docs/cil_mls_labeling_statements.md
index 97d1459b..65e55a7f 100644
--- a/secilc/docs/cil_mls_labeling_statements.md
+++ b/secilc/docs/cil_mls_labeling_statements.md
@@ -319,7 +319,7 @@ Define the category order. Multiple [`categoryorder`](cil_mls_labeling_statement
 This example orders one category alias and nine categories:
 
 ```secil
-    (categoryorder (documents c1 c2 c3 c4 c5 c6 c7 c8 c9)
+    (categoryorder (documents c1 c2 c3 c4 c5 c6 c7 c8 c9))
 ```
 
 categoryset
@@ -675,7 +675,7 @@ This rule will transition the range of `sshd.exec` to `s0 - s1:c0.c3` on executi
 ```secil
     (sensitivity s0)
     (sensitivity s1)
-    (sensitivityorder s0 s1)
+    (sensitivityorder (s0 s1))
     (category c0)
     ...
     (level systemlow (s0))
-- 
2.53.0

