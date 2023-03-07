Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D2CC6FA99
	for <selinux@archiver.kernel.org>; Tue,  7 Mar 2023 20:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCGUpa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Mar 2023 15:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCGUp3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Mar 2023 15:45:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F43CE03
        for <selinux@vger.kernel.org>; Tue,  7 Mar 2023 12:45:27 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d7so15872257qtr.12
        for <selinux@vger.kernel.org>; Tue, 07 Mar 2023 12:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678221926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gsSvtG89zfbPEha0g+XZg66pe7nqD+2wbbLAn3241Jk=;
        b=Orev/IlFKfK5DMkoesHMvyr3U8kiJlsiNNtDfxas1ESBWyAC1LuFJ81Vr3rMdbvsNc
         E2WiauRsc2MrEQCi4Y6BYDtGD+sEz/aL4XfdASntSZ5Da4zO4H9PqO7vKyd+FNgZ7uiy
         22dqX6g3HMfj67d1XeTrZaLcFIH9P3luRGSqr3e5usQuhENiqX6i/3C2S9k/z0YOD9Wt
         ckp+rITmNd4k8RE6+pm3ILvn5SRfaBoGLF+83hptG9kkOHKNl5iiU3UiucLVo8COOsEu
         DMEqGvmQr8+uqYl+qNPo98bW1WA+QM629cKnN8+zIgC1eD5JKRBiVgquzsHnZozNK/jI
         dUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678221926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsSvtG89zfbPEha0g+XZg66pe7nqD+2wbbLAn3241Jk=;
        b=E3ar/zl9Kf42A2nALZC322+OC+ncET1hjBjVLDzoXebf+2uHo/Z2qzVIVN2TE4GNic
         DVYfCPXs9F+uxUesZKe7+j/UalBELnYQPmEd1jpGQSOZt6TNNOqqDhL2ycD/JBArmmZG
         4bI/lQN7IHsMemQxcp9NKFGDUKzGkm6iVQ5/n69oy/8BCXvMInbqo7uZztF+NaXqspoK
         37Y/ApaLlpDS1oehyyI8/E/WuTSxhutSJcF4dgBFNswca42ysEKEPzQWTslSmt+L/lQw
         9lKxLh/GzxVnBw43hiVLot5BfUiSxt8H63WgXPS5BQXxPAc8bkv60luFJ6oPIKCk0+BY
         ThkQ==
X-Gm-Message-State: AO0yUKVQ7XPF/3LfZvmBBsCU7PbX1ADCbc1wXppfpqcfQGD6nFofA8sd
        o4r6UhA/B2ZFM9LOD0eF9SzsiWonEXx4MOZwMg==
X-Google-Smtp-Source: AK7set9vCai5QNFZXQUAQC4z4qrVMr6uVvAp5go6BTStqjR1IkAe5ZV8vBMrleMVTxVW5T4eUfJRDA==
X-Received: by 2002:ac8:5a85:0:b0:3b6:35a2:bb04 with SMTP id c5-20020ac85a85000000b003b635a2bb04mr28897524qtc.7.1678221925940;
        Tue, 07 Mar 2023 12:45:25 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id 6-20020ac856e6000000b003bd01b232dbsm10262593qtu.43.2023.03.07.12.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 12:45:25 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] selinux: uninline unlikely parts of avc_has_perm_noaudit()
Date:   Tue,  7 Mar 2023 15:45:24 -0500
Message-Id: <20230307204524.214983-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is based on earlier patch posted to the list by Linus, his
commit description read:

 "avc_has_perm_noaudit()is one of those hot functions that end up
  being used by almost all filesystem operations (through
  "avc_has_perm()") and it's intended to be cheap enough to inline.

  However, it turns out that the unlikely parts of it (where it
  doesn't find an existing avc node) need a fair amount of stack
  space for the automatic replacement node, so if it were to be
  inlined (at least clang does not) it would just use stack space
  unnecessarily.

  So split the unlikely part out of it, and mark that part noinline.
  That improves the actual likely part."

The basic idea behind the patch was reasonable, but there were minor
nits (double indenting, etc.) and the RCU read lock unlock/re-lock in
avc_compute_av() began to look even more ugly.  This patch builds on
Linus' first effort by cleaning things up a bit and removing the RCU
unlock/lock dance in avc_compute_av().

Removing the RCU lock dance in avc_compute_av() is safe as there are
currently two callers of avc_compute_av(): avc_has_perm_noaudit() and
avc_has_extended_perms().  The first caller in avc_has_perm_noaudit()
does not require a RCU lock as there is no avc_node to protect so the
RCU lock can be dropped before calling avc_compute_av().  The second
caller, avc_has_extended_perms(), is similar in that there is no
avc_node that requires RCU protection, but the code is simplified by
holding the RCU look around the avc_compute_av() call, and given that
we enter a RCU critical section in security_compute_av() (called from
av_compute_av()) the impact will likely be unnoticeable.  It is also
worth noting that avc_has_extended_perms() is only called from the
SELinux ioctl() access control hook at the moment.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/avc.c | 85 ++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..5ce3ad451665 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -988,25 +988,26 @@ int avc_ss_reset(struct selinux_avc *avc, u32 seqno)
 	return rc;
 }
 
-/*
- * Slow-path helper function for avc_has_perm_noaudit,
- * when the avc_node lookup fails. We get called with
- * the RCU read lock held, and need to return with it
- * still held, but drop if for the security compute.
+/**
+ * avc_compute_av - Add an entry to the AVC based on the security policy
+ * @state: SELinux state pointer
+ * @ssid: subject
+ * @tsid: object/target
+ * @tclass: object class
+ * @avd: access vector decision
+ * @xp_node: AVC extended permissions node
  *
- * Don't inline this, since it's the slow-path and just
- * results in a bigger stack frame.
+ * Slow-path helper function for avc_has_perm_noaudit, when the avc_node lookup
+ * fails.  Don't inline this, since it's the slow-path and just results in a
+ * bigger stack frame.
  */
-static noinline
-struct avc_node *avc_compute_av(struct selinux_state *state,
-				u32 ssid, u32 tsid,
-				u16 tclass, struct av_decision *avd,
-				struct avc_xperms_node *xp_node)
+static noinline struct avc_node *avc_compute_av(struct selinux_state *state,
+						u32 ssid, u32 tsid, u16 tclass,
+						struct av_decision *avd,
+						struct avc_xperms_node *xp_node)
 {
-	rcu_read_unlock();
 	INIT_LIST_HEAD(&xp_node->xpd_head);
 	security_compute_av(state, ssid, tsid, tclass, avd, &xp_node->xp);
-	rcu_read_lock();
 	return avc_insert(state->avc, ssid, tsid, tclass, avd, xp_node);
 }
 
@@ -1112,6 +1113,36 @@ int avc_has_extended_perms(struct selinux_state *state,
 	return rc;
 }
 
+/**
+ * avc_perm_nonode - Add an entry to the AVC
+ * @state: SELinux state pointer
+ * @ssid: subject
+ * @tsid: object/target
+ * @tclass: object class
+ * @requested: requested permissions
+ * @flags: AVC flags
+ * @avd: access vector decision
+ *
+ * This is the "we have no node" part of avc_has_perm_noaudit(), which is
+ * unlikely and needs extra stack space for the new node that we generate, so
+ * don't inline it.
+ */
+static noinline int avc_perm_nonode(struct selinux_state *state,
+				    u32 ssid, u32 tsid, u16 tclass,
+				    u32 requested, unsigned int flags,
+				    struct av_decision *avd)
+{
+	u32 denied;
+	struct avc_xperms_node xp_node;
+
+	avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
+	denied = requested & ~(avd->allowed);
+	if (unlikely(denied))
+		return avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
+				  flags, avd);
+	return 0;
+}
+
 /**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
  * @state: SELinux state
@@ -1139,29 +1170,27 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 				unsigned int flags,
 				struct av_decision *avd)
 {
-	struct avc_node *node;
-	struct avc_xperms_node xp_node;
-	int rc = 0;
 	u32 denied;
+	struct avc_node *node;
 
 	if (WARN_ON(!requested))
 		return -EACCES;
 
 	rcu_read_lock();
-
 	node = avc_lookup(state->avc, ssid, tsid, tclass);
-	if (unlikely(!node))
-		avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
-	else
-		memcpy(avd, &node->ae.avd, sizeof(*avd));
+	if (unlikely(!node)) {
+		rcu_read_unlock();
+		return avc_perm_nonode(state, ssid, tsid, tclass, requested,
+				       flags, avd);
+	}
+	denied = requested & ~node->ae.avd.allowed;
+	memcpy(avd, &node->ae.avd, sizeof(*avd));
+	rcu_read_unlock();
 
-	denied = requested & ~(avd->allowed);
 	if (unlikely(denied))
-		rc = avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
-				flags, avd);
-
-	rcu_read_unlock();
-	return rc;
+		return avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
+				  flags, avd);
+	return 0;
 }
 
 /**
-- 
2.39.2

