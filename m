Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205C1CEAB4;
	Fri, 15 Nov 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677820; cv=none; b=P6y94dhh5E/mo8/bUNQbwlhkp7KIBtY9aLBND714bjM6tlxHnzC9Kvm2JAblVv1DhfYB01Vz7tnUyYFkaxvaELCwhSn58uIlKwujiTY4m/c9OeStmc+DtFv1vhHm7QMmU62RiZm+v1uNr1mKeYhyj/jMjPjojYamp1QXsi1bpFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677820; c=relaxed/simple;
	bh=ffxrxr7qPmUbgC7lC3LwH3ac+lH96Q/iSqCGO1yM0v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx6aVVaMLDilyL/Dmr4GAk50MJXH82bPBtaBXWAd29HpHCa9m15x910UU0ip2FZT3mLnOR301xhn7rxfWuZ9CQzgmuzdpMUdMyi/BFIUspXeTDu5kz5mCqRlELA1QLaMttackgnkkAwtLiwC3zGmqwY8WQPUGF7UfmmqrMQa++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KGS+QCnn; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KGS+QCnn"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677810;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3JzznMMw/gwe65tEnRbepACU+g1T67oOzbJIczUasU=;
	b=KGS+QCnnAFDeeSfFZmEsXAeseHlA1As8gi+xKJw5N1zOqmW7MaaSFcGxV4Mdgx7gnp0qkY
	i1L5t9vNUfe8QCjV1Y9W5DoiU5zVV7r+nh/gugnmtGgaIYBodUmfdCaCcCSo8qRIibf18o
	auuutq68qUM151f/ntba0KCPEFNpMMZ1j614ZnAGouiOJXwWVoRsi9KoaM7vsH82Forpjp
	b791gaCuAYY1C0Fte1IOoiMCA8Mxfdls2K0y4nVMpMBq6GFuyKQIZ6lJ3Cw/ZUsGNaMg1E
	my5Pvmta3plEIhqp5k7mwNidKyqAok7k3oYfJ6i8zLMkc9ld/tjJwEMe87KKyw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	GUO Zihua <guozihua@huawei.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/22] selinux: align and constify functions
Date: Fri, 15 Nov 2024 14:35:22 +0100
Message-ID: <20241115133619.114393-3-cgoettsche@seltendoof.de>
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
index c7f2731abd03..576fec17c0e0 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -289,7 +289,7 @@ int security_context_to_sid_default(const char *scontext, u32 scontext_len,
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid);
 
-int security_get_user_sids(u32 callsid, char *username, u32 **sids, u32 *nel);
+int security_get_user_sids(u32 fromsid, const char *username, u32 **sids, u32 *nel);
 
 int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
 
@@ -307,7 +307,7 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 int security_validate_transition_user(u32 oldsid, u32 newsid, u32 tasksid,
 				      u16 tclass);
 
-int security_bounded_transition(u32 oldsid, u32 newsid);
+int security_bounded_transition(u32 old_sid, u32 new_sid);
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index f4407185401c..e10b78e61611 100644
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
index 9652aec400cb..b7ef8ab06185 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2708,7 +2708,7 @@ int security_node_sid(u16 domain,
  */
 
 int security_get_user_sids(u32 fromsid,
-			   char *username,
+			   const char *username,
 			   u32 **sids,
 			   u32 *nel)
 {
@@ -3030,7 +3030,7 @@ int security_get_bools(struct selinux_policy *policy,
 }
 
 
-int security_set_bools(u32 len, int *values)
+int security_set_bools(u32 len, const int *values)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *newpolicy, *oldpolicy;
-- 
2.45.2

