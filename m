Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CD280038
	for <selinux@vger.kernel.org>; Mon,  9 Jun 2025 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452330; cv=none; b=FAbMUQXSvmhQJnvCsJ8tprUeoXyjg8SWHaNNFvfc6Lx1m5AtMmrcsPVbYDii0cXLt3l6rKRCknyXH2pMpX7DjLLYYIQhraz3aPbFaOwAEgcrjWp6kBz0YxGycRf+LzhyB/KD1qEDTlrWsXTnWu3UJ4mhyY+5V8Lm0zSopM9DdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452330; c=relaxed/simple;
	bh=RjVG2qxZQspQ4b/4/bUOGNZWHdXL6+zh1WDNfKtH8I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZdXxoxBqvFHXybU053q6qcyaDVgS8HrmiE6KO8I7XqW9/Ct3MI1Wi/g2LC3/YefT6dWlXNNWnYhbCZCOvp0bczH8DwXTG1YFjxRaGJ/huRJZr2Eb6a5am/SePEMn7ru+yAX+zwzqmxyT11Jb8L7ZQ0Klek43oUFeymN9T4j2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLPgHvt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLPgHvt/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749452327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z8hl/ruVgICviL04lvYkR9bW9QI2CEpUaRLGViyUeLA=;
	b=cLPgHvt/1tBMpS2pSkcNGDKnGE05W5tjCCn41g3xrfx7H9XgyMjJ+DQKHr9csSIOqCD92K
	tKVqB3k/nU6i8XJW0uv1EDSB6r42ahj/VOi60gXOEetttWu864naYCPxypE1ORivL20T/S
	hK2LSDe8ZBh7thBaM1Jxt71uP86m3MI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-iewtcnarMAeN0ZlEq_imcw-1; Mon, 09 Jun 2025 02:58:46 -0400
X-MC-Unique: iewtcnarMAeN0ZlEq_imcw-1
X-Mimecast-MFC-AGG-ID: iewtcnarMAeN0ZlEq_imcw_1749452325
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5232c6ae8so1457231f8f.3
        for <selinux@vger.kernel.org>; Sun, 08 Jun 2025 23:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749452325; x=1750057125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8hl/ruVgICviL04lvYkR9bW9QI2CEpUaRLGViyUeLA=;
        b=XLu8jIgcaCB3KLDJsUq3qvtebUHwOuOkT/gkyMBOQsI6Vjt6LdELFQpztAzydH/h7l
         p43j3+/T3pb6sotxw6DFXZGvcB064LfYCmnMrIU29yKQEWQ1IX/mYgcVT20XmSi1yDIh
         iFqoN2NQ7JMUr/UVmU8RiEnCY5hZHamUK+IKnFyI9vI7UT9K8JGoO4TUVLvsyKP6yhmZ
         Io3UE+lCA3MTSdx1TxXStZNZ4Nf3zjEfa4+j286XLPO4TpPFuJp0v12ZyFZNFMTS05H0
         /6F89boUwXTgGijzL6Zz5/ejHRZJocWG5KL+xg/ebFWhnoHGxXqPHED9T8dGLhJRn1Y+
         oJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCUnWn6iCv+qZrE2nw5fx76UWoO8eKTeY1Evdck+C5JGHCjjKGWkxg3KunaYajruec9v6QXueZbO@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiZk7+JrCss5gytyUb7tAxta7FlP6e59muzuoAiOv2gGz6vAQ
	h9D8LSmeI9hS34FzC8PZzEgF5juUAIoqU4E4EtbbOwl79oKnSD4+EYzmv7q2Z/Dz5T8tp/pR9qM
	ULPKKrZGyQeFZfH+V2J89bBghwm7pBozs8MjF/XbmjUh9jeWcAofJuW1zSNM=
X-Gm-Gg: ASbGnctinuH16O18kL+0mTBMxyh4hrmyqQtq3jLNNXWE9bwIzrLK68pLdUKW99UEepD
	j5JSkqaTzVHHkCVdgt1SCQC6SBIVzQ7OYsB/3AR3O2Jkn/d3WFTMLJL/5kitZyQpz7c4L9A5iJ6
	LiJyvPgJVxws0i4EwKQHG+VuhSux81nKqdcD8qSDxBUpX1oElM+izzHk1WBu4C//PpM14uU0CUP
	IR2ZkTh2sfqUlAPSiQqMIcSgZKsMxxfILfRAfsHPP9f5MNvf3hLfni7l4X7eCPjtuDhAnHyeWR/
	1So0PiozRrpVrEVUaSiIscjzMTP4Tf5Z
X-Received: by 2002:a5d:5f86:0:b0:3a3:64fb:304d with SMTP id ffacd0b85a97d-3a5319ba166mr8966032f8f.12.1749452324884;
        Sun, 08 Jun 2025 23:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwQo0mLtbt9O3oY/zZvh0LCzYNyGVfqPm5qzwl3EExO8neZRpy8U78Dy/8j/qpK7NP5bpGvg==
X-Received: by 2002:a5d:5f86:0:b0:3a3:64fb:304d with SMTP id ffacd0b85a97d-3a5319ba166mr8966018f8f.12.1749452324499;
        Sun, 08 Jun 2025 23:58:44 -0700 (PDT)
Received: from localhost.localdomain ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c73d2sm100296345e9.30.2025.06.08.23.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 23:58:42 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org,
	Guido Trentalancia <guido@trentalancia.com>
Subject: [PATCH] selinux: fix security context comparison on execve(2)
Date: Mon,  9 Jun 2025 08:58:41 +0200
Message-ID: <20250609065841.1164578-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinux_bprm_creds_for_exec() needs to compare the old and new SIDs to
determine if the execve(2) operation is transitioning into a new context
(where process { transition } and file { entrypoint } permissions would
be checked) or not (file { execute_no_trans } would be checked). It does
so by just comparing their numeric values.

However, after ae254858ce07 ("selinux: introduce an initial SID for
early boot processes"), we can now easily get into a situation where the
SID numbers differ, but the context is the same for both. Specifically
when the policy assigns the same context for SECINITSID_KERNEL and
SECINITSID_INIT - in this case when a process labeled with
SECINITSID_INIT does execve(2) without a transition,
security_transition_sid() will translate the unchanged context to the
first matching SID number, which is SECINITSID_KERNEL, not
SECINITSID_INIT. Thus the kernel thinks that a transition has happened
and unexpectedly tests for the file { entrypoint } permission.

Fix this by checking the SID equality more carefully, trying
context_equal() on the underlying contexts when it is necessary - in the
rare case that the SIDs differ, but both are "initial" SIDs.

Reported-by: Guido Trentalancia <guido@trentalancia.com>
Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot processes")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c            |  2 +-
 security/selinux/include/security.h |  2 ++
 security/selinux/ss/services.c      | 35 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8115df536abd..be95e6e83f1d0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2369,7 +2369,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	ad.type = LSM_AUDIT_DATA_FILE;
 	ad.u.file = bprm->file;
 
-	if (new_tsec->sid == old_tsec->sid) {
+	if (security_sids_equal(new_tsec->sid, old_tsec->sid)) {
 		rc = avc_has_perm(old_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 278c144c22d60..c3ed350718d1d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -299,6 +299,8 @@ int security_context_to_sid_default(const char *scontext, u32 scontext_len,
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid);
 
+bool security_sids_equal(u32 sid1, u32 sid2);
+
 int security_get_user_sids(u32 fromsid, const char *username, u32 **sids, u32 *nel);
 
 int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7becf3808818a..297317763f6d4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1448,6 +1448,41 @@ int security_sid_to_context_inval(u32 sid,
 					    scontext_len, 1, 1);
 }
 
+/**
+ * security_sids_equal - Determine if two SIDs map to the same context.
+ * @sid1: first SID
+ * @sid2: second SID
+ */
+bool security_sids_equal(u32 sid1, u32 sid2)
+{
+	struct context *c1, *c2;
+	struct selinux_policy *policy;
+	struct sidtab *sidtab;
+	bool res;
+
+	if (!selinux_initialized())
+		return sid1 == sid2;
+
+	if (sid1 == sid2)
+		return true;
+
+	if (sid1 > SECINITSID_NUM || sid2 > SECINITSID_NUM)
+		return false;
+
+	/* Initial SIDs may map to the same context, so do a full comparison */
+	rcu_read_lock();
+	policy = rcu_dereference(selinux_state.policy);
+	sidtab = policy->sidtab;
+	c1 = sidtab_search(sidtab, sid1);
+	c2 = sidtab_search(sidtab, sid2);
+	if (!c1 || !c2)
+		res = false;
+	else
+		res = context_equal(c1, c2);
+	rcu_read_unlock();
+	return res;
+}
+
 /*
  * Caveat:  Mutates scontext.
  */
-- 
2.49.0

