Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E944C6C
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836350; cv=none; b=FNJHEa8SRCI4xqCaNhJDu8wmV/RZ7V3mXnoztHwMusWoN7P8zDbDpI3fCOZMC3lTIJqjtxDidE+4qd2KrNfN4VuKIpiCCpxRiuLg8A2BXNVF841QQ0vYFjbFlPull7ntAqpBm4HfFH3YlUUGtRyhgaxqIBdnALnPChUmOCdb1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836350; c=relaxed/simple;
	bh=WmRHY7jFFSY5toZgnSqnZ+IqgpzyIIQlWBF/jvsnU7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfS0QRAZBpqENplASqAY16mrX0cVPHbXYnYM2tAjqXFogA0h9POtxiU/OXOfwdPeiuri5JhTPjNFCH50o38jWkYFmt0TAeJF800AHa9WYG9GnvPIi3b+XxJRYPsL/nbfvbeicRiN7n2CrmzG8OD2EtH60WNapRS5JGtYP2iyqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+YdG7Ut; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+YdG7Ut"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6eb531e13so587363685a.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836342; x=1736441142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d311B6F+n0IIKipAnq6gkdyHULVnDGILUp/0+O4Ulw0=;
        b=L+YdG7UtHIk91UhzmqryabEPzwIupIgHHn/36DzQWoaG0vzA0QStbUpb6AJoKit/Wp
         L1+3wDCdNd575KbQp0J0Uhcqw2j3Su08EW9tnTQKaKISiJ1+oOd/q2Rvw9bG6VhDBxcP
         k8qFGsvUfII8vK3YCJrQzLnziVlg4sb8dI7CyZZoO1Om83gY7IEXmimKSdubVXSnGpvc
         9u05GeB02yOfEHjVQ0wq0uXsvwR6f8xE/5+VVtDVxoTv17BvQIF0j2Nd2bqrNXci/FoP
         mm6LXu9zYu8NAmEzO3AVjWnQm0aiKat4elQGJ8VUqcu7iZgUH8PQXwPy057l54iDWWM3
         a36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836342; x=1736441142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d311B6F+n0IIKipAnq6gkdyHULVnDGILUp/0+O4Ulw0=;
        b=Ufjl95eOWWQcfTetilMlNKx+dS9RCFPcsdGF868hnvvEvYPfnj3parV3onpe9e0TW9
         uc/lGyFre9Inpf9Hcv5ehUmJbI/DjG4WynkxKEWL+zo6h+ZUT47NdpeLpSV8noOwWbWs
         DEsidboXw9h7WUsl1NTcuzqzFggmJncDJ8ZuHwQpFFTzvDUltuNdRMBEqy9xfeK7J6+B
         /ZTqFzBAobh6PKmos+6Kc3JVVDJISuovl7wMPSh5wJ/6u2cizvyWynJ9rVA8eViu2e2B
         FeuJ+jWoeUUVPlKBdBwLt+7yzM+CSqNQUAvzmK2mHr9k6E+4q1njN9WRSrUQQ2MyX5Tg
         LBHw==
X-Gm-Message-State: AOJu0YwRnc1N114VgYf93uy8ekLlmaS/tuU4Qp9g7Bqmc8lD3O+sQDpS
	aCKTupnIAGR7VGPGDJzD1yfi4Jye/M8oeqSgIgORxXceEYH3fj/QfFkbvQ==
X-Gm-Gg: ASbGnctlA0IwXSSH//93doBxNSra9iP3Jm8ZuKXaez8Ljd4ZceL6qu1sbN/eYLIlIam
	UbylPeefmCOpczegRDo4vgwTWOIxyZswbhXm4327iVYmGyhBxXvtvinAhHjjOz3x95mlp53LcsE
	4VKNaL3+qqMsLhtcS0iaPuqr90UnMb7N8xXiSWMxFQMttuE4mAgZgqmTkBVXFDHTvaKTBjAuB/h
	SWBr4kyaejATGoqUP+xCugKJalCrUk1nkKccDsed5uOeoknh7GMF/IQ/WUUguIJPLClNhuOJm9T
	BFMX15cKaLd0SYoEd/hqW2R2x0nOJXM4E9jW5o44qYh0BGUPQam4nEU/Fh+GLJJxI9C/UA==
X-Google-Smtp-Source: AGHT+IF1kUjAFxaAiFbyfI5meVXlB3MFdsj2k/BlH7JSHITMeWarOZnknEBllfDybpGy2PnqkAbC6A==
X-Received: by 2002:a05:620a:240c:b0:7b1:4327:7b63 with SMTP id af79cd13be357-7b9ba7a573bmr7927401685a.32.1735836340939;
        Thu, 02 Jan 2025 08:45:40 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:40 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 11/44] selinux: wrap security server interfaces to use the global SID table
Date: Thu,  2 Jan 2025 11:44:36 -0500
Message-Id: <20250102164509.25606-12-stephen.smalley.work@gmail.com>
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

Wrap the security server interfaces to use the global SID table,
transparently mapping between global SIDs and per-policy SIDs.
Rename the existing security server functions with a selinux_ss
prefix.

The selinuxfs implementation directly uses the underlying
selinux_ss interfaces since its functions are always acting
relative to a particular SELinux namespace. In contrast,
the hook function implementations always use the new
wrapper functions to support the use of global SIDs.

Since the global SID table always stores security context strings
unmapped, this change removes the informational printk about
unmapped contexts to avoid filling the logs with noise. If/when
we split the global SID table and per-policy SID table implementations,
this could be restored to the per-policy SID tables if desired.

The implementation leaves a lot to be desired in efficiency,
but optimizing the global SID mapping, splitting the global SID
and per-policy SID table data structures to avoid wasting unused
space in the sidtab entries of each, and/or eliminating the use
of per-policy SIDs entirely is left to future changes. It would be
good if we could further optimize for the case where there is only
a single SELinux namespace and avoid imposing extra overhead on it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/global_sidtab.c         | 655 ++++++++++++++++++++++-
 security/selinux/hooks.c                 |   2 +-
 security/selinux/include/global_sidtab.h |   5 +-
 security/selinux/include/security.h      |  23 +-
 security/selinux/include/selinux_ss.h    | 115 ++++
 security/selinux/include/sidtab.h        |   5 +
 security/selinux/selinuxfs.c             |  51 +-
 security/selinux/ss/services.c           | 138 +++--
 security/selinux/ss/sidtab.c             |  14 +-
 9 files changed, 884 insertions(+), 124 deletions(-)
 create mode 100644 security/selinux/include/selinux_ss.h

diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
index 161cf31f1ba4..983b406389cb 100644
--- a/security/selinux/global_sidtab.c
+++ b/security/selinux/global_sidtab.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "global_sidtab.h"
 #include "sidtab.h"
+#include "selinux_ss.h"
+#include "audit.h"
 
 static struct sidtab global_sidtab;
 
@@ -60,8 +62,9 @@ int global_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 	return 0;
 }
 
-int global_context_to_sid(const char *scontext, u32 scontext_len, u32 *out_sid,
-			gfp_t gfp)
+int global_context_to_sid(struct selinux_state *state, u32 ss_sid,
+			  const char *scontext, u32 scontext_len,
+			  u32 *out_sid, gfp_t gfp)
 {
 	char *str;
 	struct context ctx;
@@ -89,7 +92,8 @@ int global_context_to_sid(const char *scontext, u32 scontext_len, u32 *out_sid,
 
 retry:
 	rcu_read_lock();
-	rc = sidtab_context_to_sid(&global_sidtab, &ctx, out_sid);
+	rc = sidtab_context_ss_to_sid(&global_sidtab, &ctx, state, ss_sid,
+				      out_sid);
 	if (rc == -ESTALE) {
 		rcu_read_unlock();
 		goto retry;
@@ -98,3 +102,648 @@ int global_context_to_sid(const char *scontext, u32 scontext_len, u32 *out_sid,
 	kfree(str);
 	return rc;
 }
+
+static int map_global_sid_to_ss(struct selinux_state *state, u32 sid,
+				u32 *ss_sid, gfp_t gfp)
+{
+	struct sidtab_entry *entry;
+	int rc;
+	char *scontext;
+	u32 scontext_len;
+
+	if (sid <= SECINITSID_NUM) {
+		*ss_sid = sid;
+		return 0;
+	}
+
+	rcu_read_lock();
+	entry = sidtab_search_entry_force(&global_sidtab, sid);
+	if (!entry) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	if (entry->state == state && entry->ss_sid) {
+		*ss_sid = entry->ss_sid;
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+
+	rc = global_sid_to_context(sid, &scontext, &scontext_len);
+	if (rc)
+		return rc;
+
+	rc = selinux_ss_context_to_sid_force(state, scontext,
+					     scontext_len, ss_sid, gfp);
+	kfree(scontext);
+	return rc;
+}
+
+static int map_ss_sid_to_global(struct selinux_state *state, u32 ss_sid,
+				u32 *out_sid, gfp_t gfp)
+{
+	char *scontext;
+	u32 scontext_len;
+	int rc;
+
+	if (ss_sid <= SECINITSID_NUM) {
+		*out_sid = ss_sid;
+		return 0;
+	}
+
+	rc = selinux_ss_sid_to_context_force(state, ss_sid, &scontext,
+					     &scontext_len);
+	if (rc)
+		return rc;
+
+	rc = global_context_to_sid(state, ss_sid, scontext, scontext_len,
+				   out_sid, GFP_ATOMIC);
+	kfree(scontext);
+	return rc;
+}
+
+int security_sid_to_context(struct selinux_state *state, u32 sid,
+			    char **scontext, u32 *scontext_len)
+{
+	// initial SID contexts have to be obtained from the policy, if initialized
+	if (sid <= SECINITSID_NUM && selinux_initialized(state))
+		return selinux_ss_sid_to_context(state, sid, scontext, scontext_len);
+
+	return global_sid_to_context(sid, scontext, scontext_len);
+}
+
+int security_sid_to_context_valid(struct selinux_state *state, u32 sid,
+			    char **scontext, u32 *scontext_len)
+{
+	int rc;
+	u32 ss_sid;
+
+	// Valid SID contexts have to be obtained from the policy, if initialized
+	if (selinux_initialized(state)) {
+		rc = map_global_sid_to_ss(state, sid, &ss_sid, GFP_ATOMIC);
+		if (rc)
+			return rc;
+		return selinux_ss_sid_to_context(state, ss_sid, scontext,
+						 scontext_len);
+	}
+
+	return global_sid_to_context(sid, scontext, scontext_len);
+}
+
+int security_sid_to_context_force(struct selinux_state *state, u32 sid,
+				  char **scontext, u32 *scontext_len)
+{
+	// initial SID contexts have to be obtained from the policy, if initialized
+	if (sid <= SECINITSID_NUM && selinux_initialized(state))
+		return selinux_ss_sid_to_context_force(state, sid, scontext, scontext_len);
+
+	return global_sid_to_context(sid, scontext, scontext_len);
+}
+
+int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
+				  char **scontext, u32 *scontext_len)
+{
+	int rc;
+	u32 ss_sid;
+
+	// TODO Cache invalid bit in global SID table so we do not need
+	// to lookup in the per-policy one each time.
+	if (selinux_initialized(state)) {
+		rc = map_global_sid_to_ss(state, sid, &ss_sid, GFP_ATOMIC);
+		if (rc)
+			return rc;
+		return selinux_ss_sid_to_context_inval(state, ss_sid, scontext,
+						       scontext_len);
+	}
+	return global_sid_to_context(sid, scontext, scontext_len);
+}
+
+int security_context_to_sid(struct selinux_state *state, const char *scontext,
+			    u32 scontext_len, u32 *out_sid, gfp_t gfp)
+{
+	int rc;
+	u32 sid, ss_sid = 0;
+	char *ctx = NULL;
+
+	/*
+	 * If initialized, validate and canonicalize the context against
+	 * the policy.
+	 */
+	if (selinux_initialized(state)) {
+		rc = selinux_ss_context_to_sid(state, scontext, scontext_len,
+					       &ss_sid, gfp);
+		if (rc)
+			return rc;
+
+		rc = selinux_ss_sid_to_context(state, ss_sid, &ctx,
+					       &scontext_len);
+		if (rc)
+			return rc;
+		scontext = ctx;
+	}
+
+	// allocate or lookup a SID in the global SID table
+	rc = global_context_to_sid(state, ss_sid, scontext, scontext_len,
+				   &sid, gfp);
+	if (rc)
+		goto out;
+
+	*out_sid = sid;
+
+out:
+	kfree(ctx);
+	return rc;
+}
+
+int security_context_str_to_sid(struct selinux_state *state,
+				const char *scontext, u32 *out_sid, gfp_t gfp)
+{
+	size_t scontext_len = strlen(scontext) + 1;
+
+	return security_context_to_sid(state, scontext, scontext_len, out_sid,
+				       gfp);
+}
+
+int security_context_to_sid_default(struct selinux_state *state,
+				    const char *scontext, u32 scontext_len,
+				    u32 *out_sid, u32 def_sid, gfp_t gfp)
+{
+	int rc;
+	u32 sid, ss_sid = 0;
+	char *ctx = NULL;
+
+	/*
+	 * If initialized, validate and canonicalize the context against
+	 * the policy.
+	 */
+	if (selinux_initialized(state)) {
+		rc = selinux_ss_context_to_sid_default(state, scontext,
+						       scontext_len, &ss_sid,
+						       def_sid, gfp);
+		if (rc)
+			return rc;
+
+		rc = selinux_ss_sid_to_context(state, ss_sid, &ctx,
+					       &scontext_len);
+		if (rc)
+			return rc;
+		scontext = ctx;
+	}
+
+	// allocate or lookup a SID in the global SID table
+	rc = global_context_to_sid(state, ss_sid, scontext, scontext_len,
+				   &sid, gfp);
+	if (rc)
+		goto out;
+
+	*out_sid = sid;
+
+out:
+	kfree(ctx);
+	return rc;
+}
+
+int security_context_to_sid_force(struct selinux_state *state,
+				  const char *scontext, u32 scontext_len,
+				  u32 *out_sid)
+{
+	int rc;
+	u32 sid, ss_sid = 0;
+	char *ctx = NULL;
+
+	/*
+	 * If initialized, validate and canonicalize the context against
+	 * the policy.
+	 */
+	if (selinux_initialized(state)) {
+		rc = selinux_ss_context_to_sid_force(state, scontext,
+						     scontext_len, &ss_sid,
+						     GFP_KERNEL);
+		if (rc)
+			return rc;
+
+		rc = selinux_ss_sid_to_context_force(state, ss_sid, &ctx,
+						     &scontext_len);
+		if (rc)
+			return rc;
+		scontext = ctx;
+	}
+
+	// allocate or lookup a SID in the global SID table
+	rc = global_context_to_sid(state, ss_sid, scontext, scontext_len,
+				   &sid, GFP_KERNEL);
+	if (rc)
+		goto out;
+
+	*out_sid = sid;
+
+out:
+	kfree(ctx);
+	return rc;
+}
+
+void security_compute_av(struct selinux_state *state, u32 ssid, u32 tsid,
+			 u16 tclass, struct av_decision *avd,
+			 struct extended_perms *xperms)
+{
+	u32 ss_ssid, ss_tsid;
+	int rc;
+
+	if (!selinux_initialized(state))
+		goto allow;
+
+	rc = map_global_sid_to_ss(state, ssid, &ss_ssid, GFP_ATOMIC);
+	if (rc)
+		goto deny;
+	rc = map_global_sid_to_ss(state, tsid, &ss_tsid, GFP_ATOMIC);
+	if (rc)
+		goto deny;
+	selinux_ss_compute_av(state, ss_ssid, ss_tsid, tclass, avd, xperms);
+	return;
+allow:
+	avd->allowed = ~0U;
+	goto out;
+deny:
+	avd->allowed = 0;
+out:
+	avd->auditallow = 0;
+	avd->auditdeny = ~0U;
+	avd->seqno = 0;
+	avd->flags = 0;
+	xperms->len = 0;
+}
+
+void security_compute_xperms_decision(struct selinux_state *state, u32 ssid,
+				      u32 tsid, u16 tclass, u8 driver,
+				      struct extended_perms_decision *xpermd)
+{
+	u32 ss_ssid, ss_tsid;
+	int rc;
+
+	if (!selinux_initialized(state))
+		goto allow;
+
+	rc = map_global_sid_to_ss(state, ssid, &ss_ssid, GFP_ATOMIC);
+	if (rc)
+		goto deny;
+	rc = map_global_sid_to_ss(state, tsid, &ss_tsid, GFP_ATOMIC);
+	if (rc)
+		goto deny;
+	selinux_ss_compute_xperms_decision(state, ss_ssid, ss_tsid, tclass, driver, xpermd);
+	return;
+allow:
+	memset(xpermd->allowed->p, 0xff, sizeof(xpermd->allowed->p));
+	goto out;
+deny:
+	memset(xpermd->allowed->p, 0, sizeof(xpermd->allowed->p));
+out:
+	xpermd->driver = driver;
+	xpermd->used = 0;
+	memset(xpermd->auditallow->p, 0, sizeof(xpermd->auditallow->p));
+	memset(xpermd->dontaudit->p, 0, sizeof(xpermd->dontaudit->p));
+}
+
+int security_transition_sid(struct selinux_state *state, u32 ssid, u32 tsid,
+			    u16 tclass, const struct qstr *qstr, u32 *out_sid)
+{
+	u32 ss_ssid, ss_tsid, ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		switch (tclass) {
+		case SECCLASS_PROCESS:
+			*out_sid = ssid;
+			break;
+		default:
+			*out_sid = tsid;
+			break;
+		}
+		return 0;
+	}
+
+	rc = map_global_sid_to_ss(state, ssid, &ss_ssid, GFP_ATOMIC);
+	if (rc)
+		return rc;
+	rc = map_global_sid_to_ss(state, tsid, &ss_tsid, GFP_ATOMIC);
+	if (rc)
+		return rc;
+	rc = selinux_ss_transition_sid(state, ss_ssid, ss_tsid, tclass, qstr,
+				       &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_port_sid(struct selinux_state *state, u8 protocol, u16 port,
+		      u32 *out_sid)
+{
+	u32 ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_PORT;
+		return 0;
+	}
+
+	rc = selinux_ss_port_sid(state, protocol, port, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_ib_pkey_sid(struct selinux_state *state, u64 subnet_prefix,
+			 u16 pkey_num, u32 *out_sid)
+{
+	u32 ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
+	rc = selinux_ss_ib_pkey_sid(state, subnet_prefix, pkey_num, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_ib_endport_sid(struct selinux_state *state, const char *dev_name,
+			    u8 port_num, u32 *out_sid)
+{
+	u32 ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
+	rc = selinux_ss_ib_endport_sid(state, dev_name, port_num, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_netif_sid(struct selinux_state *state, char *name, u32 *out_sid)
+{
+	u32 ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_NETIF;
+		return 0;
+	}
+
+	rc = selinux_ss_netif_sid(state, name, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_node_sid(struct selinux_state *state, u16 domain, void *addr,
+		      u32 addrlen, u32 *out_sid)
+{
+	u32 ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_NODE;
+		return 0;
+	}
+
+	rc = selinux_ss_node_sid(state, domain, addr, addrlen, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_validate_transition(struct selinux_state *state, u32 oldsid,
+				 u32 newsid, u32 tasksid, u16 tclass)
+{
+	u32 ss_oldsid, ss_newsid, ss_tasksid;
+	int rc;
+
+	if (!selinux_initialized(state))
+		return 0;
+
+	rc = map_global_sid_to_ss(state, oldsid, &ss_oldsid, GFP_ATOMIC);
+	if (rc)
+		return -EINVAL;
+	rc = map_global_sid_to_ss(state, newsid, &ss_newsid, GFP_ATOMIC);
+	if (rc)
+		return -EINVAL;
+	rc = map_global_sid_to_ss(state, tasksid, &ss_tasksid, GFP_ATOMIC);
+	if (rc)
+		return -EINVAL;
+	return selinux_ss_validate_transition(state, ss_oldsid, ss_newsid,
+					      ss_tasksid, tclass);
+}
+
+int security_bounded_transition(struct selinux_state *state, u32 oldsid,
+				u32 newsid)
+{
+	u32 ss_oldsid, ss_newsid;
+	int rc;
+
+	if (!selinux_initialized(state))
+		return 0;
+
+	rc = map_global_sid_to_ss(state, oldsid, &ss_oldsid, GFP_ATOMIC);
+	if (rc)
+		return -EINVAL;
+	rc = map_global_sid_to_ss(state, newsid, &ss_newsid, GFP_ATOMIC);
+	if (rc)
+		return -EINVAL;
+	return selinux_ss_bounded_transition(state, ss_oldsid, ss_newsid);
+}
+
+int security_sid_mls_copy(struct selinux_state *state, u32 sid, u32 mls_sid,
+			  u32 *out_sid)
+{
+	u32 ss_sid, ss_mlssid, ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = sid;
+		return 0;
+	}
+
+	rc = map_global_sid_to_ss(state, sid, &ss_sid, GFP_ATOMIC);
+	if (rc)
+		return rc;
+	rc = map_global_sid_to_ss(state, mls_sid, &ss_mlssid, GFP_ATOMIC);
+	if (rc)
+		return rc;
+
+	rc = selinux_ss_sid_mls_copy(state, ss_sid, ss_mlssid, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_net_peersid_resolve(struct selinux_state *state, u32 nlbl_sid,
+				 u32 nlbl_type, u32 xfrm_sid, u32 *out_sid)
+{
+	u32 ss_nlblsid, ss_xfrmsid, ss_outsid;
+	int rc;
+
+	if (!selinux_initialized(state)) {
+		if (xfrm_sid == SECSID_NULL) {
+			*out_sid = nlbl_sid;
+			return 0;
+		}
+		if (nlbl_sid == SECSID_NULL || nlbl_type == NETLBL_NLTYPE_UNLABELED) {
+			*out_sid = xfrm_sid;
+			return 0;
+		}
+		*out_sid = SECSID_NULL;
+		return 0;
+	}
+
+	rc = map_global_sid_to_ss(state, nlbl_sid, &ss_nlblsid, GFP_ATOMIC);
+	if (rc)
+		return rc;
+	rc = map_global_sid_to_ss(state, xfrm_sid, &ss_xfrmsid, GFP_ATOMIC);
+	if (rc)
+		return rc;
+
+	rc = selinux_ss_net_peersid_resolve(state, ss_nlblsid, nlbl_type, ss_xfrmsid, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+// only required for (mis)use of superblock_security_struct + selinux_superblock() below.
+// TODO Remove when security_fs_use() interface is repaired
+#include "objsec.h"
+
+int security_fs_use(struct selinux_state *state, struct super_block *sb)
+{
+	int rc;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
+
+	if (!selinux_initialized(state)) {
+		sbsec->behavior = SECURITY_FS_USE_NONE;
+		sbsec->sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
+	// TODO - it was a mistake to have pushed direct access to
+	// sbsec into a security server function. Fix both that
+	// interface and here to explicitly return the behavior and
+	// SID via parameters to be set in the sbsec by the caller.
+	rc = selinux_ss_fs_use(state, sb);
+	if (rc)
+		return rc;
+
+	if (sbsec->sid <= SECINITSID_NUM)
+		return 0;
+
+	return map_ss_sid_to_global(state, sbsec->sid, &sbsec->sid, GFP_ATOMIC);
+}
+
+int security_genfs_sid(struct selinux_state *state, const char *fstype,
+		       const char *path, u16 sclass, u32 *out_sid)
+{
+	int rc;
+	u32 ss_outsid;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = SECINITSID_UNLABELED;
+		return 0;
+	}
+
+	rc = selinux_ss_genfs_sid(state, fstype, path, sclass, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int selinux_policy_genfs_sid(struct selinux_policy *policy, const char *fstype,
+			     const char *path, u16 sclass, u32 *out_sid)
+{
+	int rc;
+	u32 ss_outsid;
+
+	rc = selinux_ss_policy_genfs_sid(policy, fstype, path, sclass, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(current_selinux_state, ss_outsid, out_sid,
+				    GFP_ATOMIC);
+}
+
+int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
+{
+	int rc;
+	struct lsm_prop local_prop;
+	struct selinux_state *state = current_selinux_state;
+
+	if (!selinux_initialized(state))
+		return 0;
+
+	rc = map_global_sid_to_ss(state, prop->selinux.secid,
+				  &local_prop.selinux.secid, GFP_ATOMIC);
+	if (rc)
+		return -ENOENT;
+	return selinux_ss_audit_rule_match(&local_prop, field, op, vrule);
+}
+
+#ifdef CONFIG_NETLABEL
+int security_netlbl_secattr_to_sid(struct selinux_state *state,
+				   struct netlbl_lsm_secattr *secattr,
+				   u32 *out_sid)
+{
+	int rc;
+	u32 ss_outsid;
+
+	if (!selinux_initialized(state)) {
+		*out_sid = SECSID_NULL;
+		return 0;
+	}
+
+	// The secattr secid is a global SID
+	if (secattr->flags & NETLBL_SECATTR_SECID) {
+		*out_sid = secattr->attr.secid;
+		return 0;
+	}
+
+	rc = selinux_ss_netlbl_secattr_to_sid(state, secattr, &ss_outsid);
+	if (rc)
+		return rc;
+
+	return map_ss_sid_to_global(state, ss_outsid, out_sid, GFP_ATOMIC);
+}
+
+int security_netlbl_sid_to_secattr(struct selinux_state *state, u32 sid,
+				   struct netlbl_lsm_secattr *secattr)
+{
+	int rc;
+	u32 ss_sid;
+
+	if (!selinux_initialized(state))
+		return 0;
+
+	rc = map_global_sid_to_ss(state, sid, &ss_sid, GFP_ATOMIC);
+	if (rc)
+		return rc;
+	rc = selinux_ss_netlbl_sid_to_secattr(state, ss_sid, secattr);
+	if (rc)
+		return rc;
+
+	// The secattr secid is a global SID.
+	secattr->attr.secid = sid;
+	secattr->flags |= NETLBL_SECATTR_SECID;
+	return 0;
+}
+#endif
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3f6c49c62e96..23b5648be433 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3518,7 +3518,7 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 						      isec->sid, &context,
 						      &size);
 	else
-		error = security_sid_to_context(current_selinux_state, isec->sid,
+		error = security_sid_to_context_valid(current_selinux_state, isec->sid,
 						&context, &size);
 	if (error)
 		return error;
diff --git a/security/selinux/include/global_sidtab.h b/security/selinux/include/global_sidtab.h
index f62a9165d26a..3a7332bdff2e 100644
--- a/security/selinux/include/global_sidtab.h
+++ b/security/selinux/include/global_sidtab.h
@@ -9,11 +9,14 @@
 
 #include <linux/types.h>
 
+struct selinux_state;
+
 extern int global_sidtab_init(void);
 
 extern int global_sid_to_context(u32 sid, char **scontext, u32 *scontext_len);
 
-extern int global_context_to_sid(const char *scontext, u32 scontext_len,
+extern int global_context_to_sid(struct selinux_state *state, u32 ss_sid,
+				 const char *scontext, u32 scontext_len,
 				 u32 *out_sid, gfp_t gfp);
 
 #endif /* _GLOBAL_SIDTAB_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8f8531b80bfd..fe16bc86627d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -331,25 +331,15 @@ void security_compute_xperms_decision(struct selinux_state *state, u32 ssid,
 				      u32 tsid, u16 tclass, u8 driver,
 				      struct extended_perms_decision *xpermd);
 
-void security_compute_av_user(struct selinux_state *state, u32 ssid, u32 tsid,
-			      u16 tclass, struct av_decision *avd);
-
 int security_transition_sid(struct selinux_state *state, u32 ssid, u32 tsid,
 			    u16 tclass, const struct qstr *qstr, u32 *out_sid);
 
-int security_transition_sid_user(struct selinux_state *state, u32 ssid,
-				 u32 tsid, u16 tclass, const char *objname,
-				 u32 *out_sid);
-
-int security_member_sid(struct selinux_state *state, u32 ssid, u32 tsid,
-			u16 tclass, u32 *out_sid);
-
-int security_change_sid(struct selinux_state *state, u32 ssid, u32 tsid,
-			u16 tclass, u32 *out_sid);
-
 int security_sid_to_context(struct selinux_state *state, u32 sid,
 			    char **scontext, u32 *scontext_len);
 
+int security_sid_to_context_valid(struct selinux_state *state, u32 sid,
+				  char **scontext, u32 *scontext_len);
+
 int security_sid_to_context_force(struct selinux_state *state, u32 sid,
 				  char **scontext, u32 *scontext_len);
 
@@ -370,9 +360,6 @@ int security_context_to_sid_force(struct selinux_state *state,
 				  const char *scontext, u32 scontext_len,
 				  u32 *sid);
 
-int security_get_user_sids(struct selinux_state *state, u32 callsid,
-			   char *username, u32 **sids, u32 *nel);
-
 int security_port_sid(struct selinux_state *state, u8 protocol, u16 port,
 		      u32 *out_sid);
 
@@ -390,9 +377,6 @@ int security_node_sid(struct selinux_state *state, u16 domain, void *addr,
 int security_validate_transition(struct selinux_state *state, u32 oldsid,
 				 u32 newsid, u32 tasksid, u16 tclass);
 
-int security_validate_transition_user(struct selinux_state *state, u32 oldsid,
-				      u32 newsid, u32 tasksid, u16 tclass);
-
 int security_bounded_transition(struct selinux_state *state, u32 oldsid,
 				u32 newsid);
 
@@ -433,6 +417,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 
 int security_netlbl_sid_to_secattr(struct selinux_state *state, u32 sid,
 				   struct netlbl_lsm_secattr *secattr);
+
 #else
 static inline int
 security_netlbl_secattr_to_sid(struct selinux_state *state,
diff --git a/security/selinux/include/selinux_ss.h b/security/selinux/include/selinux_ss.h
new file mode 100644
index 000000000000..1b497f984158
--- /dev/null
+++ b/security/selinux/include/selinux_ss.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _SELINUX_SS_H_
+#define _SELINUX_SS_H_
+
+/*
+ * SELinux security server policy-dependent interfaces.
+ * Most callers should use the corresponding security_*() interfaces
+ * from security.h instead in order to transparently map to/from
+ * global SIDs.
+ */
+
+void selinux_ss_compute_av(struct selinux_state *state, u32 ssid, u32 tsid,
+			   u16 tclass, struct av_decision *avd,
+			   struct extended_perms *xperms);
+
+void selinux_ss_compute_xperms_decision(struct selinux_state *state, u32 ssid,
+					u32 tsid, u16 tclass, u8 driver,
+					struct extended_perms_decision *xpermd);
+
+void selinux_ss_compute_av_user(struct selinux_state *state, u32 ssid, u32 tsid,
+				u16 tclass, struct av_decision *avd);
+
+int selinux_ss_transition_sid(struct selinux_state *state, u32 ssid, u32 tsid,
+			      u16 tclass, const struct qstr *qstr,
+			      u32 *out_sid);
+
+int selinux_ss_transition_sid_user(struct selinux_state *state, u32 ssid,
+				   u32 tsid, u16 tclass, const char *objname,
+				   u32 *out_sid);
+
+int selinux_ss_member_sid(struct selinux_state *state, u32 ssid, u32 tsid,
+			  u16 tclass, u32 *out_sid);
+
+int selinux_ss_change_sid(struct selinux_state *state, u32 ssid, u32 tsid,
+			  u16 tclass, u32 *out_sid);
+
+int selinux_ss_sid_to_context(struct selinux_state *state, u32 sid,
+			      char **scontext, u32 *scontext_len);
+
+int selinux_ss_sid_to_context_force(struct selinux_state *state, u32 sid,
+				    char **scontext, u32 *scontext_len);
+
+int selinux_ss_sid_to_context_inval(struct selinux_state *state, u32 sid,
+				    char **scontext, u32 *scontext_len);
+
+int selinux_ss_context_to_sid(struct selinux_state *state, const char *scontext,
+			      u32 scontext_len, u32 *out_sid, gfp_t gfp);
+
+int selinux_ss_context_str_to_sid(struct selinux_state *state,
+				  const char *scontext, u32 *out_sid,
+				  gfp_t gfp);
+
+int selinux_ss_context_to_sid_default(struct selinux_state *state,
+				      const char *scontext, u32 scontext_len,
+				      u32 *out_sid, u32 def_sid,
+				      gfp_t gfp_flags);
+
+int selinux_ss_context_to_sid_force(struct selinux_state *state,
+				    const char *scontext, u32 scontext_len,
+				    u32 *sid, gfp_t gfp);
+
+int selinux_ss_get_user_sids(struct selinux_state *state, u32 callsid,
+			     char *username, u32 **sids, u32 *nel);
+
+int selinux_ss_port_sid(struct selinux_state *state, u8 protocol, u16 port,
+			u32 *out_sid);
+
+int selinux_ss_ib_pkey_sid(struct selinux_state *state, u64 subnet_prefix,
+			   u16 pkey_num, u32 *out_sid);
+
+int selinux_ss_ib_endport_sid(struct selinux_state *state, const char *dev_name,
+			      u8 port_num, u32 *out_sid);
+
+int selinux_ss_netif_sid(struct selinux_state *state, char *name, u32 *if_sid);
+
+int selinux_ss_node_sid(struct selinux_state *state, u16 domain, void *addr,
+			u32 addrlen, u32 *out_sid);
+
+int selinux_ss_validate_transition(struct selinux_state *state, u32 oldsid,
+				   u32 newsid, u32 tasksid, u16 tclass);
+
+int selinux_ss_validate_transition_user(struct selinux_state *state, u32 oldsid,
+					u32 newsid, u32 tasksid, u16 tclass);
+
+int selinux_ss_bounded_transition(struct selinux_state *state, u32 oldsid,
+				  u32 newsid);
+
+int selinux_ss_sid_mls_copy(struct selinux_state *state, u32 sid, u32 mls_sid,
+			    u32 *new_sid);
+
+int selinux_ss_net_peersid_resolve(struct selinux_state *state, u32 nlbl_sid,
+				   u32 nlbl_type, u32 xfrm_sid, u32 *peer_sid);
+
+int selinux_ss_fs_use(struct selinux_state *state, struct super_block *sb);
+
+int selinux_ss_genfs_sid(struct selinux_state *state, const char *fstype,
+			 const char *path, u16 sclass, u32 *sid);
+
+int selinux_ss_policy_genfs_sid(struct selinux_policy *policy,
+				const char *fstype, const char *path,
+				u16 sclass, u32 *sid);
+
+int selinux_ss_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *rule);
+
+#ifdef CONFIG_NETLABEL
+int selinux_ss_netlbl_secattr_to_sid(struct selinux_state *state,
+				     struct netlbl_lsm_secattr *secattr,
+				     u32 *sid);
+
+int selinux_ss_netlbl_sid_to_secattr(struct selinux_state *state, u32 sid,
+				     struct netlbl_lsm_secattr *secattr);
+#endif
+
+#endif /* _SELINUX_SS_H_ */
diff --git a/security/selinux/include/sidtab.h b/security/selinux/include/sidtab.h
index 832c85c70d83..1d40e1a7fa42 100644
--- a/security/selinux/include/sidtab.h
+++ b/security/selinux/include/sidtab.h
@@ -26,6 +26,8 @@ struct sidtab_entry {
 	struct sidtab_str_cache __rcu *cache;
 #endif
 	struct hlist_node list;
+	u32 ss_sid; // global SID table only
+	struct selinux_state *state; // global SID table only
 };
 
 union sidtab_entry_inner {
@@ -134,6 +136,9 @@ void sidtab_freeze_end(struct sidtab *s, unsigned long *flags)
 
 int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
 
+int sidtab_context_ss_to_sid(struct sidtab *s, struct context *context,
+			     struct selinux_state *state, u32 ss_sid, u32 *sid);
+
 void sidtab_destroy(struct sidtab *s);
 
 int sidtab_hash_stats(struct sidtab *sidtab, char *page);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0702aeb0c5b8..c3308a5c168d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -39,6 +39,7 @@
 #include "avc.h"
 #include "avc_ss.h"
 #include "security.h"
+#include "selinux_ss.h"
 #include "objsec.h"
 #include "conditional.h"
 #include "ima.h"
@@ -733,11 +734,11 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
-	length = security_context_to_sid(state, buf, size, &sid, GFP_KERNEL);
+	length = selinux_ss_context_to_sid(state, buf, size, &sid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(state, sid, &canon, &len);
+	length = selinux_ss_sid_to_context(state, sid, &canon, &len);
 	if (length)
 		goto out;
 
@@ -876,19 +877,19 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	if (sscanf(req, "%s %s %hu %s", oldcon, newcon, &tclass, taskcon) != 4)
 		goto out;
 
-	rc = security_context_str_to_sid(state, oldcon, &osid, GFP_KERNEL);
+	rc = selinux_ss_context_str_to_sid(state, oldcon, &osid, GFP_KERNEL);
 	if (rc)
 		goto out;
 
-	rc = security_context_str_to_sid(state, newcon, &nsid, GFP_KERNEL);
+	rc = selinux_ss_context_str_to_sid(state, newcon, &nsid, GFP_KERNEL);
 	if (rc)
 		goto out;
 
-	rc = security_context_str_to_sid(state, taskcon, &tsid, GFP_KERNEL);
+	rc = selinux_ss_context_str_to_sid(state, taskcon, &tsid, GFP_KERNEL);
 	if (rc)
 		goto out;
 
-	rc = security_validate_transition_user(state, osid, nsid, tsid, tclass);
+	rc = selinux_ss_validate_transition_user(state, osid, nsid, tsid, tclass);
 	if (!rc)
 		rc = count;
 out:
@@ -990,15 +991,15 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out;
 
-	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	security_compute_av_user(state, ssid, tsid, tclass, &avd);
+	selinux_ss_compute_av_user(state, ssid, tsid, tclass, &avd);
 
 	length = scnprintf(buf, SIMPLE_TRANSACTION_LIMIT,
 			  "%x %x %x %x %u %x",
@@ -1081,20 +1082,20 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 		objname = namebuf;
 	}
 
-	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_transition_sid_user(state, ssid, tsid, tclass,
+	length = selinux_ss_transition_sid_user(state, ssid, tsid, tclass,
 					      objname, &newsid);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(state, newsid, &newcon, &len);
+	length = selinux_ss_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
 		goto out;
 
@@ -1147,19 +1148,19 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out;
 
-	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_change_sid(state, ssid, tsid, tclass, &newsid);
+	length = selinux_ss_change_sid(state, ssid, tsid, tclass, &newsid);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(state, newsid, &newcon, &len);
+	length = selinux_ss_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
 		goto out;
 
@@ -1212,18 +1213,18 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s", con, user) != 2)
 		goto out;
 
-	length = security_context_str_to_sid(state, con, &sid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, con, &sid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_get_user_sids(state, sid, user, &sids, &nsids);
+	length = selinux_ss_get_user_sids(state, sid, user, &sids, &nsids);
 	if (length)
 		goto out;
 
 	length = sprintf(buf, "%u", nsids) + 1;
 	ptr = buf + length;
 	for (i = 0; i < nsids; i++) {
-		rc = security_sid_to_context(state, sids[i], &newcon, &len);
+		rc = selinux_ss_sid_to_context(state, sids[i], &newcon, &len);
 		if (rc) {
 			length = rc;
 			goto out;
@@ -1277,19 +1278,19 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out;
 
-	length = security_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, scon, &ssid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
+	length = selinux_ss_context_str_to_sid(state, tcon, &tsid, GFP_KERNEL);
 	if (length)
 		goto out;
 
-	length = security_member_sid(state, ssid, tsid, tclass, &newsid);
+	length = selinux_ss_member_sid(state, ssid, tsid, tclass, &newsid);
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(state, newsid, &newcon, &len);
+	length = selinux_ss_sid_to_context(state, newsid, &newcon, &len);
 	if (length)
 		goto out;
 
@@ -1801,7 +1802,7 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 	ssize_t ret;
 
 	sid = file_inode(file)->i_ino&SEL_INO_MASK;
-	ret = security_sid_to_context(fsi->state, sid, &con, &len);
+	ret = selinux_ss_sid_to_context(fsi->state, sid, &con, &len);
 	if (ret)
 		return ret;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index bbac5f3f2fd3..b5fa7165e0d2 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -54,6 +54,7 @@
 #include "avc.h"
 #include "avc_ss.h"
 #include "security.h"
+#include "selinux_ss.h"
 #include "context.h"
 #include "policydb.h"
 #include "sidtab.h"
@@ -831,7 +832,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
 	return rc;
 }
 
-int security_validate_transition_user(struct selinux_state *state,
+int selinux_ss_validate_transition_user(struct selinux_state *state,
 				      u32 oldsid, u32 newsid, u32 tasksid,
 				      u16 tclass)
 {
@@ -839,7 +840,7 @@ int security_validate_transition_user(struct selinux_state *state,
 					      tclass, true);
 }
 
-int security_validate_transition(struct selinux_state *state,
+int selinux_ss_validate_transition(struct selinux_state *state,
 				 u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 orig_tclass)
 {
@@ -848,7 +849,7 @@ int security_validate_transition(struct selinux_state *state,
 }
 
 /*
- * security_bounded_transition - check whether the given
+ * selinux_ss_bounded_transition - check whether the given
  * transition is directed to bounded, or not.
  * It returns 0, if @newsid is bounded by @oldsid.
  * Otherwise, it returns error code.
@@ -857,7 +858,7 @@ int security_validate_transition(struct selinux_state *state,
  * @oldsid : current security identifier
  * @newsid : destinated security identifier
  */
-int security_bounded_transition(struct selinux_state *state,
+int selinux_ss_bounded_transition(struct selinux_state *state,
 				u32 old_sid, u32 new_sid)
 {
 	struct selinux_policy *policy;
@@ -1013,7 +1014,7 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 	}
 }
 
-void security_compute_xperms_decision(struct selinux_state *state,
+void selinux_ss_compute_xperms_decision(struct selinux_state *state,
 				      u32 ssid,
 				      u32 tsid,
 				      u16 orig_tclass,
@@ -1099,7 +1100,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
 }
 
 /**
- * security_compute_av - Compute access vector decisions.
+ * selinux_ss_compute_av - Compute access vector decisions.
  * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1110,7 +1111,7 @@ void security_compute_xperms_decision(struct selinux_state *state,
  * Compute a set of access vector decisions based on the
  * SID pair (@ssid, @tsid) for the permissions in @tclass.
  */
-void security_compute_av(struct selinux_state *state,
+void selinux_ss_compute_av(struct selinux_state *state,
 			 u32 ssid,
 			 u32 tsid,
 			 u16 orig_tclass,
@@ -1169,7 +1170,7 @@ void security_compute_av(struct selinux_state *state,
 	goto out;
 }
 
-void security_compute_av_user(struct selinux_state *state,
+void selinux_ss_compute_av_user(struct selinux_state *state,
 			      u32 ssid,
 			      u32 tsid,
 			      u16 tclass,
@@ -1399,7 +1400,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 }
 
 /**
- * security_sid_to_context - Obtain a context for a given SID.
+ * selinux_ss_sid_to_context - Obtain a context for a given SID.
  * @state: SELinux state
  * @sid: security identifier, SID
  * @scontext: security context
@@ -1409,23 +1410,23 @@ static int security_sid_to_context_core(struct selinux_state *state,
  * into a dynamically allocated string of the correct size.  Set @scontext
  * to point to this string and set @scontext_len to the length of the string.
  */
-int security_sid_to_context(struct selinux_state *state,
-			    u32 sid, char **scontext, u32 *scontext_len)
+int selinux_ss_sid_to_context(struct selinux_state *state,
+			      u32 sid, char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
 					    scontext_len, 0, 0);
 }
 
-int security_sid_to_context_force(struct selinux_state *state, u32 sid,
-				  char **scontext, u32 *scontext_len)
+int selinux_ss_sid_to_context_force(struct selinux_state *state, u32 sid,
+				    char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
 					    scontext_len, 1, 0);
 }
 
 /**
- * security_sid_to_context_inval - Obtain a context for a given SID if it
- *                                 is invalid.
+ * selinux_ss_sid_to_context_inval - Obtain a context for a given SID if it
+ *                                   is invalid.
  * @state: SELinux state
  * @sid: security identifier, SID
  * @scontext: security context
@@ -1437,8 +1438,8 @@ int security_sid_to_context_force(struct selinux_state *state, u32 sid,
  * this string (or NULL if the context is valid) and set @scontext_len to
  * the length of the string (or 0 if the context is valid).
  */
-int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
-				  char **scontext, u32 *scontext_len)
+int selinux_ss_sid_to_context_inval(struct selinux_state *state, u32 sid,
+				    char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
 					    scontext_len, 1, 1);
@@ -1601,7 +1602,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
 }
 
 /**
- * security_context_to_sid - Obtain a SID for a given security context.
+ * selinux_ss_context_to_sid - Obtain a SID for a given security context.
  * @state: SELinux state
  * @scontext: security context
  * @scontext_len: length in bytes
@@ -1613,23 +1614,23 @@ static int security_context_to_sid_core(struct selinux_state *state,
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid(struct selinux_state *state,
-			    const char *scontext, u32 scontext_len, u32 *sid,
-			    gfp_t gfp)
+int selinux_ss_context_to_sid(struct selinux_state *state,
+			      const char *scontext, u32 scontext_len, u32 *sid,
+			      gfp_t gfp)
 {
 	return security_context_to_sid_core(state, scontext, scontext_len,
 					    sid, SECSID_NULL, gfp, 0);
 }
 
-int security_context_str_to_sid(struct selinux_state *state,
-				const char *scontext, u32 *sid, gfp_t gfp)
+int selinux_ss_context_str_to_sid(struct selinux_state *state,
+				  const char *scontext, u32 *sid, gfp_t gfp)
 {
-	return security_context_to_sid(state, scontext, strlen(scontext),
-				       sid, gfp);
+	return security_context_to_sid_core(state, scontext, strlen(scontext),
+					    sid, SECSID_NULL, gfp, 0);
 }
 
 /**
- * security_context_to_sid_default - Obtain a SID for a given security context,
+ * selinux_ss_context_to_sid_default - Obtain a SID for a given security context,
  * falling back to specified default if needed.
  *
  * @state: SELinux state
@@ -1648,20 +1649,20 @@ int security_context_str_to_sid(struct selinux_state *state,
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid_default(struct selinux_state *state,
-				    const char *scontext, u32 scontext_len,
-				    u32 *sid, u32 def_sid, gfp_t gfp_flags)
+int selinux_ss_context_to_sid_default(struct selinux_state *state,
+				      const char *scontext, u32 scontext_len,
+				      u32 *sid, u32 def_sid, gfp_t gfp_flags)
 {
 	return security_context_to_sid_core(state, scontext, scontext_len,
 					    sid, def_sid, gfp_flags, 1);
 }
 
-int security_context_to_sid_force(struct selinux_state *state,
-				  const char *scontext, u32 scontext_len,
-				  u32 *sid)
+int selinux_ss_context_to_sid_force(struct selinux_state *state,
+				    const char *scontext, u32 scontext_len,
+				    u32 *sid, gfp_t gfp)
 {
 	return security_context_to_sid_core(state, scontext, scontext_len,
-					    sid, SECSID_NULL, GFP_KERNEL, 1);
+					    sid, SECSID_NULL, gfp, 1);
 }
 
 static int compute_sid_handle_invalid_context(
@@ -1927,7 +1928,7 @@ static int security_compute_sid(struct selinux_state *state,
 }
 
 /**
- * security_transition_sid - Compute the SID for a new subject/object.
+ * selinux_ss_transition_sid - Compute the SID for a new subject/object.
  * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1941,7 +1942,7 @@ static int security_compute_sid(struct selinux_state *state,
  * if insufficient memory is available, or %0 if the new SID was
  * computed successfully.
  */
-int security_transition_sid(struct selinux_state *state,
+int selinux_ss_transition_sid(struct selinux_state *state,
 			    u32 ssid, u32 tsid, u16 tclass,
 			    const struct qstr *qstr, u32 *out_sid)
 {
@@ -1950,7 +1951,7 @@ int security_transition_sid(struct selinux_state *state,
 				    qstr ? qstr->name : NULL, out_sid, true);
 }
 
-int security_transition_sid_user(struct selinux_state *state,
+int selinux_ss_transition_sid_user(struct selinux_state *state,
 				 u32 ssid, u32 tsid, u16 tclass,
 				 const char *objname, u32 *out_sid)
 {
@@ -1960,7 +1961,7 @@ int security_transition_sid_user(struct selinux_state *state,
 }
 
 /**
- * security_member_sid - Compute the SID for member selection.
+ * selinux_ss_member_sid - Compute the SID for member selection.
  * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1973,7 +1974,7 @@ int security_transition_sid_user(struct selinux_state *state,
  * if insufficient memory is available, or %0 if the SID was
  * computed successfully.
  */
-int security_member_sid(struct selinux_state *state,
+int selinux_ss_member_sid(struct selinux_state *state,
 			u32 ssid,
 			u32 tsid,
 			u16 tclass,
@@ -1985,7 +1986,7 @@ int security_member_sid(struct selinux_state *state,
 }
 
 /**
- * security_change_sid - Compute the SID for object relabeling.
+ * selinux_ss_change_sid - Compute the SID for object relabeling.
  * @state: SELinux state
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -1998,7 +1999,7 @@ int security_member_sid(struct selinux_state *state,
  * if insufficient memory is available, or %0 if the SID was
  * computed successfully.
  */
-int security_change_sid(struct selinux_state *state,
+int selinux_ss_change_sid(struct selinux_state *state,
 			u32 ssid,
 			u32 tsid,
 			u16 tclass,
@@ -2429,13 +2430,13 @@ static int ocontext_to_sid(struct sidtab *sidtab, struct ocontext *c,
 }
 
 /**
- * security_port_sid - Obtain the SID for a port.
+ * selinux_ss_port_sid - Obtain the SID for a port.
  * @state: SELinux state
  * @protocol: protocol number
  * @port: port number
  * @out_sid: security identifier
  */
-int security_port_sid(struct selinux_state *state,
+int selinux_ss_port_sid(struct selinux_state *state,
 		      u8 protocol, u16 port, u32 *out_sid)
 {
 	struct selinux_policy *policy;
@@ -2483,13 +2484,13 @@ int security_port_sid(struct selinux_state *state,
 }
 
 /**
- * security_ib_pkey_sid - Obtain the SID for a pkey.
+ * selinux_ss_ib_pkey_sid - Obtain the SID for a pkey.
  * @state: SELinux state
  * @subnet_prefix: Subnet Prefix
  * @pkey_num: pkey number
  * @out_sid: security identifier
  */
-int security_ib_pkey_sid(struct selinux_state *state,
+int selinux_ss_ib_pkey_sid(struct selinux_state *state,
 			 u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 {
 	struct selinux_policy *policy;
@@ -2537,13 +2538,13 @@ int security_ib_pkey_sid(struct selinux_state *state,
 }
 
 /**
- * security_ib_endport_sid - Obtain the SID for a subnet management interface.
+ * selinux_ss_ib_endport_sid - Obtain the SID for a subnet management interface.
  * @state: SELinux state
  * @dev_name: device name
  * @port_num: port number
  * @out_sid: security identifier
  */
-int security_ib_endport_sid(struct selinux_state *state,
+int selinux_ss_ib_endport_sid(struct selinux_state *state,
 			    const char *dev_name, u8 port_num, u32 *out_sid)
 {
 	struct selinux_policy *policy;
@@ -2592,12 +2593,12 @@ int security_ib_endport_sid(struct selinux_state *state,
 }
 
 /**
- * security_netif_sid - Obtain the SID for a network interface.
+ * selinux_ss_netif_sid - Obtain the SID for a network interface.
  * @state: SELinux state
  * @name: interface name
  * @if_sid: interface SID
  */
-int security_netif_sid(struct selinux_state *state,
+int selinux_ss_netif_sid(struct selinux_state *state,
 		       char *name, u32 *if_sid)
 {
 	struct selinux_policy *policy;
@@ -2655,14 +2656,14 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
 }
 
 /**
- * security_node_sid - Obtain the SID for a node (host).
+ * selinux_ss_node_sid - Obtain the SID for a node (host).
  * @state: SELinux state
  * @domain: communication domain aka address family
  * @addrp: address
  * @addrlen: address length in bytes
  * @out_sid: security identifier
  */
-int security_node_sid(struct selinux_state *state,
+int selinux_ss_node_sid(struct selinux_state *state,
 		      u16 domain,
 		      void *addrp,
 		      u32 addrlen,
@@ -2744,7 +2745,7 @@ int security_node_sid(struct selinux_state *state,
 #define SIDS_NEL 25
 
 /**
- * security_get_user_sids - Obtain reachable SIDs for a user.
+ * selinux_ss_get_user_sids - Obtain reachable SIDs for a user.
  * @state: SELinux state
  * @fromsid: starting SID
  * @username: username
@@ -2758,7 +2759,7 @@ int security_node_sid(struct selinux_state *state,
  * number of elements in the array.
  */
 
-int security_get_user_sids(struct selinux_state *state,
+int selinux_ss_get_user_sids(struct selinux_state *state,
 			   u32 fromsid,
 			   char *username,
 			   u32 **sids,
@@ -2926,7 +2927,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 }
 
 /**
- * security_genfs_sid - Obtain a SID for a file in a filesystem
+ * selinux_ss_genfs_sid - Obtain a SID for a file in a filesystem
  * @state: SELinux state
  * @fstype: filesystem type
  * @path: path from root of mount
@@ -2936,7 +2937,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
  * Acquire policy_rwlock before calling __security_genfs_sid() and release
  * it afterward.
  */
-int security_genfs_sid(struct selinux_state *state,
+int selinux_ss_genfs_sid(struct selinux_state *state,
 		       const char *fstype,
 		       const char *path,
 		       u16 orig_sclass,
@@ -2960,7 +2961,7 @@ int security_genfs_sid(struct selinux_state *state,
 	return retval;
 }
 
-int selinux_policy_genfs_sid(struct selinux_policy *policy,
+int selinux_ss_policy_genfs_sid(struct selinux_policy *policy,
 			const char *fstype,
 			const char *path,
 			u16 orig_sclass,
@@ -2971,11 +2972,11 @@ int selinux_policy_genfs_sid(struct selinux_policy *policy,
 }
 
 /**
- * security_fs_use - Determine how to handle labeling for a filesystem.
+ * selinux_ss_fs_use - Determine how to handle labeling for a filesystem.
  * @state: SELinux state
  * @sb: superblock in question
  */
-int security_fs_use(struct selinux_state *state, struct super_block *sb)
+int selinux_ss_fs_use(struct selinux_state *state, struct super_block *sb)
 {
 	struct selinux_policy *policy;
 	struct policydb *policydb;
@@ -3213,10 +3214,10 @@ static int security_preserve_bools(struct selinux_policy *oldpolicy,
 }
 
 /*
- * security_sid_mls_copy() - computes a new sid based on the given
+ * selinux_ss_sid_mls_copy() - computes a new sid based on the given
  * sid and the mls portion of mls_sid.
  */
-int security_sid_mls_copy(struct selinux_state *state,
+int selinux_ss_sid_mls_copy(struct selinux_state *state,
 			  u32 sid, u32 mls_sid, u32 *new_sid)
 {
 	struct selinux_policy *policy;
@@ -3327,7 +3328,7 @@ int security_sid_mls_copy(struct selinux_state *state,
  *   multiple, inconsistent labels |    -<errno>     |    SECSID_NULL
  *
  */
-int security_net_peersid_resolve(struct selinux_state *state,
+int selinux_ss_net_peersid_resolve(struct selinux_state *state,
 				 u32 nlbl_sid, u32 nlbl_type,
 				 u32 xfrm_sid,
 				 u32 *peer_sid)
@@ -3577,7 +3578,7 @@ void selinux_audit_rule_free(void *vrule)
 }
 
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
-			    gfp_t gfp)
+			gfp_t gfp)
 {
 	struct selinux_state *state = current_selinux_state;
 	struct selinux_policy *policy;
@@ -3702,7 +3703,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
+int selinux_ss_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
 {
 	struct selinux_state *state = current_selinux_state;
 	struct selinux_policy *policy;
@@ -3868,7 +3869,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
 }
 
 /**
- * security_netlbl_secattr_to_sid - Convert a NetLabel secattr to a SELinux SID
+ * selinux_ss_netlbl_secattr_to_sid - Convert a NetLabel secattr to a SELinux SID
  * @state: SELinux state
  * @secattr: the NetLabel packet security attributes
  * @sid: the SELinux SID
@@ -3883,7 +3884,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
  * failure.
  *
  */
-int security_netlbl_secattr_to_sid(struct selinux_state *state,
+int selinux_ss_netlbl_secattr_to_sid(struct selinux_state *state,
 				   struct netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
@@ -3908,8 +3909,6 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
-	else if (secattr->flags & NETLBL_SECATTR_SECID)
-		*sid = secattr->attr.secid;
 	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		rc = -EIDRM;
 		ctx = sidtab_search(sidtab, SECINITSID_NETMSG);
@@ -3951,7 +3950,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 }
 
 /**
- * security_netlbl_sid_to_secattr - Convert a SELinux SID to a NetLabel secattr
+ * selinux_ss_netlbl_sid_to_secattr - Convert a SELinux SID to a NetLabel secattr
  * @state: SELinux state
  * @sid: the SELinux SID
  * @secattr: the NetLabel packet security attributes
@@ -3961,7 +3960,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
  * Returns zero on success, negative values on failure.
  *
  */
-int security_netlbl_sid_to_secattr(struct selinux_state *state,
+int selinux_ss_netlbl_sid_to_secattr(struct selinux_state *state,
 				   u32 sid, struct netlbl_lsm_secattr *secattr)
 {
 	struct selinux_policy *policy;
@@ -3987,8 +3986,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	if (secattr->domain == NULL)
 		goto out;
 
-	secattr->attr.secid = sid;
-	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
+	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY;
 	mls_export_netlbl_lvl(policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
 out:
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index cb7125cc7f8e..0ea4a3745adb 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -265,7 +265,8 @@ struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid)
 	return sidtab_search_core(s, sid, 1);
 }
 
-int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
+int sidtab_context_ss_to_sid(struct sidtab *s, struct context *context,
+			     struct selinux_state *state, u32 ss_sid, u32 *sid)
 {
 	unsigned long flags;
 	u32 count, hash = context_compute_hash(context);
@@ -308,6 +309,8 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
 		goto out_unlock;
 
 	dst->sid = index_to_sid(count);
+	dst->state = state;
+	dst->ss_sid = ss_sid;
 	dst->hash = hash;
 
 	rc = context_cpy(&dst->context, context);
@@ -344,10 +347,6 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
 			     dst_convert->hash);
 	}
 
-	if (context->len)
-		pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
-			context->str);
-
 	*sid = index_to_sid(count);
 
 	/* write entries before updating count */
@@ -360,6 +359,11 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
 	return rc;
 }
 
+int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
+{
+	return sidtab_context_ss_to_sid(s, context, NULL, 0, sid);
+}
+
 static void sidtab_convert_hashtable(struct sidtab *s, u32 count)
 {
 	struct sidtab_entry *entry;
-- 
2.47.1

