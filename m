Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3390D45FFB4
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158817; cv=none; b=aU7rCFBWDJTgp839JISLqCptOnAgkZIsmSLlhwJeJGaxNJ8vsNooFLWzKym7795ZMbZLI9fYCw4pnYOEEc9T42gDoPtE/Zxw0mmzFFZ9Zdcqb4nlJXNcxE26gfgQihUW/M4MST+v9ShM5nBFMnQafJmtPIQiRHFpuudTIvdxmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158817; c=relaxed/simple;
	bh=ckjZBcK9f1bA4IbAg8aWe3bK6kggw1Il2Kpapdo8zEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OudaznOqQVcigzTvZE4lmw2zrzDftTnunXIAyT9OZmngpDusPinqjhSH8ZJtkNEKvKxcVK4VDUMNKxtIQjAuTvEQiLjtwLWzklnAgMSy0VCaIbaMlGZgyqaGo4kqhUmrJvtBR1fHjo/nTKTvFCQqtVnUaPA4znV+nD5FuyJXwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VPMXUdl8; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VPMXUdl8"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790158808;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=z6CGdvRAwAN/9Qn6lXHYiA16KDhoShYgFyWj1M6IulM=;
	b=VPMXUdl8EV/np4C+NLY6JHsFGZFzUi8lzK2uBBcto2TZSikjSxP0MQbh0g1vzS2cS3gsln
	KQEd2ErkSf4z2I2GtdztrnZDGQpptBJ6b3Xd79MhO/+zyENmuSUPVEPjHSUdXnnsZC/6NA
	HOS3wY+GDTVpWh7iqipHK5yRW0a3W8gYSJ6s62WVr/52UUheFrag7shG0xCBs1jU/paioo
	OMBI9TSnqrVqDomWnJZCiBbfJrOYfUah1NE9GIeUwh8KPyZZsFxF6ZVR1Xcxyrem/9HH/A
	9WwOqeVWW0D2GXQWGTlp+Y8rJaWhNd1EkapJwNkv5Ymkk07vzthaiVszQV2DNg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] CIL: misc doc updates
Date: Wed, 23 Sep 2026 12:19:56 +0200
Message-ID: <20260923101956.3005420-1-cgoettsche@seltendoof.de>
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

- mention self as supported target in type-transitions
- mention the special behavior of `"*"` as an object-name for
  type-transitions (means NO object-name instead of file named literal
  asterisk
- mention support of extended permissions in conditional policies
- mention requirement of at least one branch for conditional policies

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/docs/cil_conditional_statements.md | 6 +++++-
 secilc/docs/cil_type_statements.md        | 6 +++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_conditional_statements.md
index 9afd4153..ef669eff 100644
--- a/secilc/docs/cil_conditional_statements.md
+++ b/secilc/docs/cil_conditional_statements.md
@@ -46,7 +46,9 @@ booleanif
 
 Contains the run time conditional statements that are instantiated in the binary policy according to the computed boolean identifier(s) state.
 
-[`call`](cil_call_macro_statements.md#call) statements are allowed within a [`booleanif`](cil_conditional_statements.md#booleanif), however the contents of the resulting macro must be limited to those of the [`booleanif`](cil_conditional_statements.md#booleanif) statement (i.e. [`allow`](cil_access_vector_rules.md#allow), [`auditallow`](cil_access_vector_rules.md#auditallow), [`dontaudit`](cil_access_vector_rules.md#dontaudit), [`typemember`](cil_type_statements.md#typemember), [`typetransition`](cil_type_statements.md#typetransition), [`typechange`](cil_type_statements.md#typechange) and the compile time [`tunableif`](cil_conditional_statements.md#tunableif) statement)).
+[`call`](cil_call_macro_statements.md#call) statements are allowed within a [`booleanif`](cil_conditional_statements.md#booleanif), however the contents of the resulting macro must be limited to those of the [`booleanif`](cil_conditional_statements.md#booleanif) statement (i.e. [`allow`](cil_access_vector_rules.md#allow), [`auditallow`](cil_access_vector_rules.md#auditallow), [`dontaudit`](cil_access_vector_rules.md#dontaudit), [`allowx`](cil_access_vector_rules.md#allowx), [`auditallowx`](cil_access_vector_rules.md#auditallowx), [`dontauditx`](cil_access_vector_rules.md#dontauditx), [`typemember`](cil_type_statements.md#typemember), [`typetransition`](cil_type_statements.md#typetransition), [`typechange`](cil_type_statements.md#typechange) and the compile time [`tunableif`](cil_conditional_statements.md#tunableif) statement)).
+
+At least one `true` or `false` branch must be present. A branchless `(booleanif expression)` is invalid. Extended-permission rules in runtime conditionals require a target policy version that supports conditional extended permissions.
 
 **Statement definition:**
 
@@ -170,6 +172,8 @@ Compile time conditional statement that may or may not add CIL statements to be
 
 If tunables are being treated as booleans (by using the CIL compiler command line parameter `-P` or `--preserve-tunables` flag), then only the statements allowed in a [`booleanif`](cil_conditional_statements.md#booleanif) block are allowed in a [`tunableif`](cil_conditional_statements.md#tunableif) block. Otherwise, [`tunable`](cil_conditional_statements.md#tunable) statements are not allowed in a [`tunableif`](cil_conditional_statements.md#tunableif) block.
 
+At least one `true` or `false` branch must be present.
+
 **Statement definition:**
 
 ```secil
diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
index 541b9be1..704722c3 100644
--- a/secilc/docs/cil_type_statements.md
+++ b/secilc/docs/cil_type_statements.md
@@ -487,7 +487,7 @@ The type transition rule specifies the labeling and object creation allowed betw
 **Statement definition:**
 
 ```secil
-    (typetransition source_type_id target_type_id class_id [object_name] default_type_id)
+    (typetransition source_type_id target_type_id|self class_id [object_name] default_type_id)
 ```
 
 **Where:**
@@ -508,7 +508,7 @@ The type transition rule specifies the labeling and object creation allowed betw
 </tr>
 <tr class="odd">
 <td align="left"><p><code>target_type_id</code></p></td>
-<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
+<td align="left"><p>A single previously declared <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier, or <code>self</code> to use each source type as its own target.</p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>class_id</code></p></td>
@@ -516,7 +516,7 @@ The type transition rule specifies the labeling and object creation allowed betw
 </tr>
 <tr class="odd">
 <td align="left"><p><code>object_name</code></p></td>
-<td align="left"><p>A optional string within double quotes representing an object name for the 'name transition' rule. This string will be matched against the objects name (if a path then the last component of that path). If the string matches exactly, the <code>default_type_id</code> will then become the new type.</p></td>
+<td align="left"><p>A optional string within double quotes representing an object name for the 'name transition' rule. This string will be matched against the objects name (if a path then the last component of that path). If the string matches exactly, the <code>default_type_id</code> will then become the new type. The special name <code>*</code>, including the quoted form <code>"*"</code>, instead produces an unnamed transition. CIL string literals do not process escapes, so a literal asterisk filename cannot be expressed this way.</p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>default_type_id</code></p></td>
-- 
2.55.0

