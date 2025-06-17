Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56DB2ECD20;
	Tue, 17 Jun 2025 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169201; cv=none; b=IjSt1muYbA2HlL3mFZKzj0ySH6SE2lalUJfBCzHFPqyPG5kfsmxUuhlm2+a7iLzEQJntZLIz8vEqDJy1jtOSTXBWaF2iKJmbjLOKb27y4NBgnByISMyNd0sTNLV60dgcGrQolo/R760kLcy1l3CXTxSkUPligDa4xC/5t0xU/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169201; c=relaxed/simple;
	bh=72JbdzzZW9tjszqmTY2ww4QYlvnV5WjEx6DSuoStcNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4wPnEWPruxaalPatSkHCWao9jsT2UXhoT1WJcOkGrTso8U+H6qwOYGk9UQdRDi6TL4mD7/95lzRG3oRyNQWQXIqUuWUIt461K0tYuqi+I5VLD2uEvngGegKELcAJ94FL91t4W1A5WLTJMaeTT4+4lBTh9HBnEqO6C0quN0qs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp8Lnc8o; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp8Lnc8o"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d38cfa9773so603268185a.2;
        Tue, 17 Jun 2025 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169199; x=1750773999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtfL23sc+yu21D6JEAzA4bRtjKjP0qZismcprxC1iY4=;
        b=Gp8Lnc8oLAmIc963cW4o/oXBQ8dv+boZJuh69H9QbbUERn7XFnvTPI8j0b9TqyetTf
         Yj3tSQy77+x6dp5NxPHIJmhkjjDF093St6jldOByuBLOrFBs5v5fR0gIN7uIKjYP6ugy
         KcxaTl/OfB3BKH4GmQNBdlOpamAUT+Me1ZyQAfDtiNq2j99Dv/TrgPh94Q0ctswuCGt8
         sWwgO3UeZPeUTi81KOIqbqTF9HT+GatTocP9JH7aSnB8nCs0gPIw0Mtud8zrPE0HKBZg
         y15nG3CoANcAiSDxTwFUdlou55vGZDbAs4Z3uMyyPVVKbxzr+kWhupDvGjvD7QoLg/rM
         32qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169199; x=1750773999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtfL23sc+yu21D6JEAzA4bRtjKjP0qZismcprxC1iY4=;
        b=H/Rd+YacyQrFkLRnNVZpvMx4zJsVNqjuyKRi3mEF1zRkoT4d+vqDvsQphZRCce8UiY
         Zv7RyXItF2RlA8NoqjK5W8ROP2mWAgaZAL4yyNhqLCLdhBCNGjlEIYZslMhK4U3BZiOr
         EauNolbvhIV9VSFjIVceuM2CinMtRVet9BLhpBe0QhCrz0k3kbskjM1atavKoMYy9VRo
         Z8QKhp32hGWs9y5Ep9hYl9kw6RYZ7qkII07oAH1M8UOK9CvQfGQiWlNp88vkyQ5zMgJ4
         NtK64eMqhYpi4+h6kCem3Ff2hN0R4cxw95Fp8Pb2L29yqcXWEl93YTKxAVoYS0j5SEI7
         Borw==
X-Forwarded-Encrypted: i=1; AJvYcCX75NT/LTEcLw8FbrxXMFINP1Iusw32AWR1OU1WVYgb4RHDh5Oyje7lXeTmSy7BSzPqn/UaJxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRS/KQQz8RorKLsOyoAEKnLOiCXtIupTDBnAuvk3IFWdqzs4P
	i6emTDcGTgzoQuK+XDRGcHJLWVxOJtDLWi0fDyPAl10CqMFa8l2KUhxeNVmZ5Q==
X-Gm-Gg: ASbGncsnve3y1CONOHw9/G3X3PgfBnRI1XlMV29Nn+8EsdodzmMU/qg7kQK9BvLAUUT
	1hu/ozkeT+t+1zeBQ/Nus4MIG6bEIQbnCzRvv+aESc/m40Z5a6wVxV75dI1KGFAAq3crvkOBVw0
	TaeSQl8fzimA+tpG+OOVvHF9TN+2SmgnDvRLiJArZTp30SGOhHfErqOKcRO3UUBL8E+d1nqZfRO
	Opn3579FaZl4iuPvxBanhAsK2eIi95/QH5+40DU8fCYxwYiAOPiEhbWHmyqnwG2X6NLKLArVCet
	FOPr1RHt9IRY1pJWZ6/9ERXaWMQQyk7RQT2555A+jKhs7IHirExUMccUaT8JZERMCCzzkoQ7KOj
	yNs5okiEkt5bDDXYASgw+/6KcoAB79kRs90BC46Zo/LdWi7OCo2GEZV3rOhe4Oo5Y9w==
X-Google-Smtp-Source: AGHT+IHBdanqNB0MPN1EN2qSMeblJqRQadshBX0N9sU3kfiQrU1wkbUkfVuP9GuJk9WlhPEoHXcy0w==
X-Received: by 2002:a05:620a:2a11:b0:7d0:99dc:d026 with SMTP id af79cd13be357-7d3c6c0c737mr1958145785a.12.1750169198743;
        Tue, 17 Jun 2025 07:06:38 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 27/42] selinux: introduce task_obj_has_perm()
Date: Tue, 17 Jun 2025 10:05:14 -0400
Message-ID: <20250617140531.2036-28-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce task_obj_has_perm() for namespace-aware permission checking
between two tasks using the objective SID for both tasks and
without assuming that either task is current.

Convert the permission checks of this form in the hook functions
to use this new helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c         | 57 ++++++++++++++++++++++++++++++++++
 security/selinux/hooks.c       |  5 ++-
 security/selinux/include/avc.h |  3 ++
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9385dcd84eee..0c79f40d70af 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1291,6 +1291,63 @@ int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 	return 0;
 }
 
+static const struct task_security_struct *task_security(
+	const struct task_struct *p)
+{
+	const struct task_security_struct *tsec;
+
+	tsec = selinux_cred(__task_cred(p));
+	while (tsec->state != current_selinux_state && tsec->parent_cred)
+		tsec = selinux_cred(tsec->parent_cred);
+	if (tsec->state != current_selinux_state)
+		return NULL;
+	return tsec;
+}
+
+int task_obj_has_perm(const struct task_struct *s,
+		      const struct task_struct *t,
+		      u16 tclass, u32 requested,
+		      struct common_audit_data *ad)
+{
+	const struct cred *cred;
+	const struct task_security_struct *tsec;
+	struct selinux_state *state;
+	u32 ssid;
+	u32 tsid;
+	int rc;
+
+	state = current_selinux_state;
+	rcu_read_lock();
+	tsec = task_security(s);
+	if (tsec)
+		ssid = tsec->sid;
+	else
+		ssid = SECINITSID_UNLABELED;
+
+	do {
+		tsid = task_sid_obj_for_state(t, state);
+
+		rc = avc_has_perm(state, ssid, tsid, tclass, requested, ad);
+		if (rc)
+			break;
+
+		if (!tsec)
+			break;
+
+		cred = tsec->parent_cred;
+		if (!cred)
+			break;
+
+		tsec = selinux_cred(cred);
+		ssid = tsec->sid;
+		state = tsec->state;
+	} while (cred);
+
+	rcu_read_unlock();
+	return rc;
+}
+
+
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 base_perm, u8 xperm,
 			    struct common_audit_data *ad)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 426c8efd612c..860f1ff2231f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2126,9 +2126,8 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return avc_has_perm(current_selinux_state,
-			    task_sid_obj(parent), task_sid_obj(current),
-			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
+	return task_obj_has_perm(parent, current, SECCLASS_PROCESS,
+				 PROCESS__PTRACE, NULL);
 }
 
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 1631f6cdbefd..2c2268249b44 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -173,6 +173,9 @@ int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 			u16 tclass, u32 requested,
 			struct common_audit_data *ad);
 
+int task_obj_has_perm(const struct task_struct *s, const struct task_struct *t,
+		      u16 tclass, u32 requested, struct common_audit_data *ad);
+
 u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
-- 
2.49.0

