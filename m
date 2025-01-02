Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FF129A78
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836353; cv=none; b=rKzRyERsYht0g+HDWLe3ds55H+T3KP21+AWC6pP5oUJhNi4gmXDv7uxEPmflXvW5IMjguZOfMFD7LsjtHqatWM1kITxVs3Pna3lEGetRdVjyO8k4GDVXFFoX356cO82IfSdLqqqg8C3ZDoqGwENsp5fMdQ8ykptudryrMeYJdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836353; c=relaxed/simple;
	bh=QEMapwMDcDE+gYEdzwvVlWiyApaNAbQUE0dVPoDUuis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhfrWqx98fnHRlHWbOLX/DPE7SSmBXz3MwI4pPN9HdbaT8L4MeGcnVFvry90EQjLkDyumoQcWf7dKzDP2IjLKjA0YT00h6B+JgWuSiRoHwvJgoxxAJI0FagLjcfr8yFd9Sx8Ua+wfj+WBtIl4g1aCuvKNgZja+ROEVHXyItiFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtzFquW5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtzFquW5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46783d44db0so108077311cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836350; x=1736441150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7gt27Cr3eBW9daTYnTwObgzvnUB9vupxIyBMIES5I0=;
        b=mtzFquW58nWatJcpOsqAvhPoK8tj/mZe9GhVtN1xe4jtMGoG04Mlv1UWutPczhntke
         vng7TVNM9eEwztyl0bol2wTKhyabz0/91e6/ITIK01/5bXNicScZvv7CAiyXO3GOev1+
         qgKfM9iu0JqUAeX1/1DPdEfZ302JK9JPxDwEnacMyO7Xt7xPY6bTNYsPvYVqUPEWZ/V5
         OCEokaZUOWjoQWu7fQNNOj2Bq1EQ5wa1WiudChf2K1sarSTFhIuLplEZeFIFcSyq7XjD
         wQEFaeFEqAeiWXmg6FP3Nbc0oNqd3ZBuvb0kRsVa2hMeqf+E7WzR/cJAMKprEXQXVeZY
         tOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836350; x=1736441150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7gt27Cr3eBW9daTYnTwObgzvnUB9vupxIyBMIES5I0=;
        b=NoctIVdNexmp1OHZpAPeJPixEvTh3MqySHYziYw1zGL9DHT4QXXrz4PfboyqLnohuP
         ZFrcEMM7Yeihy1qL4RmwX6BjHD68s6KrBEu/0jR0cI1EMxVYuEbliNLKtwCNcdiVKWgs
         adJNsyjVbgHuEaVnHi/Ji/Jtyomhk+jmPgi1w/TEdAmoBKsuQ2AwOLKtj0P0GH+qXpUa
         H8Y4FCUkKqUcw5jUAZzoh2ter0VMCZXB6+tF7c+Sj3rEGsgoO4XQO8bIsmugDXrMfnym
         hqqNm2J4AxTsx1BhFd/13+Rez90d2ymnyIgNMZkpzjSBWFS2GGFoYbesORLmDFEgAziD
         E2yw==
X-Gm-Message-State: AOJu0Yyk6utdaGL8PGq/Ge0ujWqxYUhYoiYRHBCZix2B6btGn4IY1GA8
	H1ft01eSa/jPwjiD2AtpIDgRoXwZt3hIGVub9hxNoIIJEbwK/JtfNaX4LQ==
X-Gm-Gg: ASbGncu3N9HAOiKFTHm1z9ZMD5m9aNZYFiwtlbyi9ITChHm51Eyeu6D0ceMOwAsJoD0
	qZyy1FPgkW731MTtgwdKizQT/rDNG53UYTLGYuhqnoB5OKiuscatDVwN8UxxvF+WnjBIz4+jx0s
	6vpiaRhSmruYQbuznBoNj+ORFDpF9zHHt4k+RBBOre4TdHLNztyLnWdNFkJB3xNgoUEroIYteV1
	hc0LDg73ooV28V5tujAaCIc1U2k4moMlJ6MENg0u2v2Rro7+l3U7S5m3XCND/JJ+N/Xn+q+wkvO
	2L0vFZKWOiN+rbanMW70SyTJO33V+vVDZxupX1rBLQPuGSMbn1NtwZfvgV8FC6+rd+N8aA==
X-Google-Smtp-Source: AGHT+IEcMUSosKyv9vVlv7zInz/2erfN5GYNHSxrIvPVhBoGm9M8L58OS8jbwxX9T6ieMWg00vGOgw==
X-Received: by 2002:a05:622a:189f:b0:467:5414:9cf9 with SMTP id d75a77b69052e-46a4a8cc587mr781961651cf.18.1735836349758;
        Thu, 02 Jan 2025 08:45:49 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:49 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 21/44] selinux: add kerneldoc to new permission checking functions
Date: Thu,  2 Jan 2025 11:44:46 -0500
Message-Id: <20250102164509.25606-22-stephen.smalley.work@gmail.com>
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

Add kerneldoc to new namespace-aware permission checking
functions.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c | 144 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index cc64dce0f061..480ffac13c19 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1251,6 +1251,21 @@ static u32 task_sid_obj_for_state(const struct task_struct *p,
 	return sid;
 }
 
+/**
+ * cred_task_has_perm - Check and audit permissions on a (cred, task) pair
+ * @cred: subject credentials
+ * @p: target task
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and a task @p for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_task_has_perm(const struct cred *cred, const struct task_struct *p,
 		       u16 tclass, u32 requested,
 		       struct common_audit_data *ad)
@@ -1290,6 +1305,22 @@ static const struct task_security_struct *task_security(
 	return tsec;
 }
 
+/**
+ * task_obj_has_perm - Check and audit permissions on a (task, other-task) pair
+ * @s: source task
+ * @t: target task
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ *
+ * Check permissions between a task @s and a task @t for the current namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when @s is current; use cred_task_has_perm() instead.
+ */
 int task_obj_has_perm(const struct task_struct *s,
 		      const struct task_struct *t,
 		      u16 tclass, u32 requested,
@@ -1332,7 +1363,24 @@ int task_obj_has_perm(const struct task_struct *s,
 	return 0;
 }
 
-
+/**
+ * cred_has_extended_perms - Check and audit extended permissions on a (cred, tsid) pair
+ * @cred: subject credentials
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @driver: driver value
+ * @xperm: extended permission value
+ * @auditdata: auxiliary audit data
+ *
+ * Check extended permissions between a cred @cred and a target
+ * security identifier @tsid for @cred's namespace and all ancestors
+ * to determine whether the @requested permissions are granted for the
+ * specified (@driver, @xperm) pair.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if the @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 			    u32 requested, u8 driver, u8 xperm,
 			    struct common_audit_data *ad)
@@ -1358,6 +1406,20 @@ int cred_has_extended_perms(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_self_has_perm - Check and audit permissions on a (cred, self) pair
+ * @cred: subject credentials
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and itself for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
 		       struct common_audit_data *ad)
 {
@@ -1380,6 +1442,18 @@ int cred_self_has_perm(const struct cred *cred, u16 tclass, u32 requested,
 	return 0;
 }
 
+/**
+ * cred_self_has_perm_noaudit - Check permissions on a (cred, self) pair, no audit
+ * @cred: subject credentials
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ *
+ * Check permissions between a cred @cred and itself for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 			       u32 requested)
 {
@@ -1405,6 +1479,25 @@ int cred_self_has_perm_noaudit(const struct cred *cred, u16 tclass,
 	return 0;
 }
 
+
+/**
+ * cred_has_perm - Check and audit permissions on a (cred, tsid) pair
+ * @cred: subject credentials
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and a target SID @tsid for
+ * @cred's namespace and all ancestors to determine whether the
+ * @requested permissions are granted, interpreting the permissions based
+ * on @tclass.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when checking permissions between two creds (or tasks);
+ * use cred_other_has_perm() or cred_task_has_perm() instead.
+ */
 int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 		  u32 requested, struct common_audit_data *ad)
 {
@@ -1427,6 +1520,22 @@ int cred_has_perm(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_has_perm_noaudit - Check permissions on a (cred, tsid) pair, no audit
+ * @cred: subject credentials
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @avd: access vector decisions
+ *
+ * Check permissions between a cred @cred and a target SID @tsid for
+ * @cred's namespace and all ancestors to determine whether the
+ * @requested permissions are granted.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when checking permissions between two creds (or tasks);
+ * use cred_other_has_perm() or cred_task_has_perm() instead.
+ */
 int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 			  u32 requested, struct av_decision *avd)
 {
@@ -1458,6 +1567,24 @@ int cred_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 	return 0;
 }
 
+/**
+ * cred_ssid_has_perm - Check and audit permissions on a (ssid, tsid) pair
+ * @cred: subject credentials
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ *
+ * Check permissions between a source SID @ssid and a target SID @tsid for
+ * @cred's namespace and all ancestors to determine whether the
+ * @requested permissions are granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ * DO NOT USE when checking permissions involving cred/task SIDs; this
+ * helper is only for object-to-object checks.
+ */
 int cred_ssid_has_perm(const struct cred *cred, u32 ssid, u32 tsid, u16 tclass,
 		       u32 requested, struct common_audit_data *ad)
 {
@@ -1494,6 +1621,21 @@ static u32 cred_sid_for_state(const struct cred *cred,
 	return sid;
 }
 
+/**
+ * cred_other_has_perm - Check and audit permissions on a (cred, other-cred) pair
+ * @cred: subject credentials
+ * @other: other credentials
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ *
+ * Check permissions between a cred @cred and a task @p for @cred's namespace
+ * and all ancestors to determine whether the @requested permissions are
+ * granted.
+ * Audit the granting or denial of permissions in accordance with the policy.
+ * Return %0 if all @requested permissions are granted, -%EACCES if any
+ * permissions are denied, or another -errno upon other errors.
+ */
 int cred_other_has_perm(const struct cred *cred, const struct cred *other,
 			u16 tclass, u32 requested,
 			struct common_audit_data *ad)
-- 
2.47.1

