Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3F2066F2;
	Mon, 16 Dec 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367298; cv=none; b=eBoYo79RnPnJjcmytuPudUTjOSWw6OgzQaezILB5VWV9hLp5gj1iMemc1FI6/fDWWlC4sFs1D4KQHmwX5PSPXtUHDgWgB1vnoNDzEylE44SGTwIntZ/jkN1EV3zlIFmOas6Ithzw6SnIKlV9/siRMk2a6Md3ylaE54pJ3lZ/J+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367298; c=relaxed/simple;
	bh=olpjHUpdwoGt/2BDkxgfOZVu99AqVRSIaa/pByLDSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIgpaFw+U+2dN1Ec4HxGNoH8v+mjNEEzC2GGl1O/viIMq7ZkkzyaLQ7syAJX+I7eC7Nq1qZch1moRF62Al0ScnosTbxHqotOlOGcIvRRT8Lpr9+3GavA+YACnlgPUMGHyWFLDI6bfxaCf5HzKJoITuLPjejYbMDpTTppsHoXxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=umizmjjA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="umizmjjA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367288;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XExxUJMx2whlaYdcdok2BEmZkUsYJteYCdG7aVNDCGY=;
	b=umizmjjA3gR+8GD1L1lzuRCJ+t2np4uoKvEDq1kw3iz2BpPIE7lpBYH49gNUYOuKZVAsJR
	smkPp4nkXCEYccaXuJ8tAvWHhTfbPJqSwSnaWSkTJJlSGgfX6Xum0HMaY1AyuwC/RnDmIg
	ug9TglHjN+RlAHuKQG1bGcTnLOsNRzU0ab4J3AlaF8pIJBxuaPKj6Ym+RjpBHAiVbh7Xtq
	BZ6EPqR2Sx7sKDxZYIA3jhdaGAUi3Yoo5PlRRdSA8KJRDKEyl76Ht3XEPcsyU0OiCIA37C
	R+zT01+mgyGyZpeFhUC2RHfAQ2fPfsYmzCCktLG/OHVgBRSDSfflp/AkH3fzAg==
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
	llvm@lists.linux.dev,
	Casey Schaufler <casey@schaufler-ca.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>
Subject: [RFC PATCH v2 03/22] selinux: align and constify functions
Date: Mon, 16 Dec 2024 17:40:01 +0100
Message-ID: <20241216164055.96267-3-cgoettsche@seltendoof.de>
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

Align the parameter names between declarations and definitions, and
constify read-only parameters.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/conditional.h | 2 +-
 security/selinux/include/security.h    | 4 ++--
 security/selinux/ss/avtab.h            | 2 +-
 security/selinux/ss/services.c         | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index 5910bb7c2eca..060833e2dba2 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -16,7 +16,7 @@
 int security_get_bools(struct selinux_policy *policy, u32 *len, char ***names,
 		       int **values);
 
-int security_set_bools(u32 len, int *values);
+int security_set_bools(u32 len, const int *values);
 
 int security_get_bool_value(u32 index);
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 10949df22fa4..1d47850fff45 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -290,7 +290,7 @@ int security_context_to_sid_default(const char *scontext, u32 scontext_len,
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid);
 
-int security_get_user_sids(u32 callsid, char *username, u32 **sids, u32 *nel);
+int security_get_user_sids(u32 fromsid, const char *username, u32 **sids, u32 *nel);
 
 int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
 
@@ -308,7 +308,7 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 int security_validate_transition_user(u32 oldsid, u32 newsid, u32 tasksid,
 				      u16 tclass);
 
-int security_bounded_transition(u32 oldsid, u32 newsid);
+int security_bounded_transition(u32 old_sid, u32 new_sid);
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index a7cbb80a11eb..32b8335cf93e 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -89,7 +89,7 @@ struct avtab {
 };
 
 void avtab_init(struct avtab *h);
-int avtab_alloc(struct avtab *, u32);
+int avtab_alloc(struct avtab *h, u32 nrules);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
 void avtab_destroy(struct avtab *h);
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 55fdc7ca232b..1c4ac392df2a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2712,7 +2712,7 @@ int security_node_sid(u16 domain,
  */
 
 int security_get_user_sids(u32 fromsid,
-			   char *username,
+			   const char *username,
 			   u32 **sids,
 			   u32 *nel)
 {
@@ -3034,7 +3034,7 @@ int security_get_bools(struct selinux_policy *policy,
 }
 
 
-int security_set_bools(u32 len, int *values)
+int security_set_bools(u32 len, const int *values)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *newpolicy, *oldpolicy;
-- 
2.45.2

