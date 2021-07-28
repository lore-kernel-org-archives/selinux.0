Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A24FC4338F
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 14:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8A60F59
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 14:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhG1ODT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 10:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235349AbhG1ODT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 10:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627480997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=k1T8FvVf1bGNRCXnkmrwuQnXC3l92UC8QleT2b5ye5k=;
        b=BNkyf1Fh3uT4ydLC6F2E+QONWt11FMK//1aG8RtSg+hkgN5JXUUr5xl43rBTOg2UdwV0Ub
        XWL/qM5IfMKDF5st1HiOdpF4VqDyANKOEDv84UOahLP8xZwInTKc0WU3lT5pmFRnYzSXHu
        8yhygutk9hStbhfxoDbFCca+/TVcgb8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-3SlMpxqMOeut9OH_w5CnSQ-1; Wed, 28 Jul 2021 10:03:16 -0400
X-MC-Unique: 3SlMpxqMOeut9OH_w5CnSQ-1
Received: by mail-wm1-f70.google.com with SMTP id q188-20020a1ca7c50000b0290241f054d92aso252873wme.5
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 07:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1T8FvVf1bGNRCXnkmrwuQnXC3l92UC8QleT2b5ye5k=;
        b=SMeQBL84iMr+PcEVYzbdeIGY5voYxGQh7Zo69GW8r0JejgkaoI5eWJeABGDib8/kSr
         5+mm86KGfLEnk80WXS+6PTWgPu4Vu0banHWVymLw8bouXG6BheCZ+rwUQ1+WF8uxJ8ou
         QK0vvZdsdRA/wZsCSLDODHvtzNhz6xzFug1WUVURPWjQt6BNwQSVjMVz8ETkB2GLn8NR
         of8QYYiw+w33JHR+YQOVA715W6JMUsQoonnq8CeUdq/UOnEdX87zBFkQGQTwmtaxWIMk
         GLpZGcaf6mJQ1XMCtweNbjPCet0mHEEdfrWpDptnbGWfWg36MAIVmWzsj1jvOKc+0mTr
         yavw==
X-Gm-Message-State: AOAM5320r+Ok1r64SfjW2P0t+Q+cf+LF/RMZijQ5cIglMxxkcQ17TG+s
        n9MfcdzTitudbGlxTKpvBcdba2KjZm1SPphjPY9eBabjRxuqYsto8BNhhlNS9BOEt1P0YEe7HrG
        R3dXRgdaQ9owDBgjaqQ==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr4717151wrs.387.1627480995013;
        Wed, 28 Jul 2021 07:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz58WNoAMt6rv/d00iccVyXF30nHZ5WyCm0dchht+6g3ZhTjvsvkviJSouZPzzBtBoKsxYgFQ==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr4717131wrs.387.1627480994786;
        Wed, 28 Jul 2021 07:03:14 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z6sm128753wmp.1.2021.07.28.07.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:03:14 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Subject: [PATCH] selinux: fix race condition when computing ocontext SIDs
Date:   Wed, 28 Jul 2021 16:03:13 +0200
Message-Id: <20210728140313.68096-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Current code contains a lot of racy patterns when converting an
ocontext's context structure to an SID. This is being done in a "lazy"
fashion, such that the SID is looked up in the SID table only when it's
first needed and then cached in the "sid" field of the ocontext
structure. However, this is done without any locking or memory barriers
and is thus unsafe.

Between commits 24ed7fdae669 ("selinux: use separate table for initial
SID lookup") and 66f8e2f03c02 ("selinux: sidtab reverse lookup hash
table"), this race condition lead to an actual observable bug, because a
pointer to the shared sid field was passed directly to
sidtab_context_to_sid(), which was using this location to also store an
intermediate value, which could have been read by other threads and
interpreted as an SID. In practice this caused e.g. new mounts to get a
wrong (seemingly random) filesystem context, leading to strange denials.
This bug has been spotted in the wild at least twice, see [1] and [2].

Fix the race condition by making all the racy functions use a common
helper that ensures the ocontext::sid accesses are made safely using the
appropriate SMP constructs.

Note that security_netif_sid() was populating the sid field of both
contexts stored in the ocontext, but only the first one was actually
used. The SELinux wiki's documentation on the "netifcon" policy
statement [3] suggests that using only the first context is intentional.
I kept only the handling of the first context here, as there is really
no point in doing the SID lookup for the unused one.

I wasn't able to reproduce the bug mentioned above on any kernel that
includes commit 66f8e2f03c02, even though it has been reported that the
issue occurs with that commit, too, just less frequently. Thus, I wasn't
able to verify that this patch fixes the issue, but it makes sense to
avoid the race condition regardless.

[1] https://github.com/containers/container-selinux/issues/89
[2] https://lists.fedoraproject.org/archives/list/selinux@lists.fedoraproject.org/thread/6DMTAMHIOAOEMUAVTULJD45JZU7IBAFM/
[3] https://selinuxproject.org/page/NetworkStatements#netifcon

Reported-by: Sujithra Periasamy <sujithra@google.com>
Cc: Xinjie Zheng <xinjie@google.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 162 ++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 85 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 0a5ce001609b..c8db8a3432e4 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2369,6 +2369,43 @@ err_policy:
 	return rc;
 }
 
+/**
+ * ocontext_to_sid - Helper to safely get sid for an ocontext
+ * @sidtab: SID table
+ * @c: ocontext structure
+ * @index: index of the context entry (0 or 1)
+ * @out_sid: pointer to the resulting SID value
+ *
+ * For all ocontexts except OCON_ISID the SID fields are populated
+ * on-demand when needed. Since updating the SID value is an SMP-sensitive
+ * operation, this helper must be used to do that safely.
+ *
+ * WARNING: This function may return -ESTALE, indicating that the caller
+ * must retry the operation after re-acquiring the policy pointer!
+ */
+static int ocontext_to_sid(struct sidtab *sidtab, struct ocontext *c,
+			   size_t index, u32 *out_sid)
+{
+	int rc;
+	u32 sid;
+
+	/* Ensure the associated sidtab entry is visible to this thread. */
+	sid = smp_load_acquire(&c->sid[index]);
+	if (!sid) {
+		rc = sidtab_context_to_sid(sidtab, &c->context[index], &sid);
+		if (rc)
+			return rc;
+
+		/*
+		 * Ensure the new sidtab entry is visible to other threads
+		 * when they see the SID.
+		 */
+		smp_store_release(&c->sid[index], sid);
+	}
+	*out_sid = sid;
+	return 0;
+}
+
 /**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number
@@ -2406,17 +2443,13 @@ retry:
 	}
 
 	if (c) {
-		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab, &c->context[0],
-						   &c->sid[0]);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out;
+		rc = ocontext_to_sid(sidtab, c, 0, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
 		}
-		*out_sid = c->sid[0];
+		if (rc)
+			goto out;
 	} else {
 		*out_sid = SECINITSID_PORT;
 	}
@@ -2464,18 +2497,13 @@ retry:
 	}
 
 	if (c) {
-		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[0],
-						   &c->sid[0]);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out;
+		rc = ocontext_to_sid(sidtab, c, 0, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
 		}
-		*out_sid = c->sid[0];
+		if (rc)
+			goto out;
 	} else
 		*out_sid = SECINITSID_UNLABELED;
 
@@ -2523,17 +2551,13 @@ retry:
 	}
 
 	if (c) {
-		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab, &c->context[0],
-						   &c->sid[0]);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out;
+		rc = ocontext_to_sid(sidtab, c, 0, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
 		}
-		*out_sid = c->sid[0];
+		if (rc)
+			goto out;
 	} else
 		*out_sid = SECINITSID_UNLABELED;
 
@@ -2576,25 +2600,13 @@ retry:
 	}
 
 	if (c) {
-		if (!c->sid[0] || !c->sid[1]) {
-			rc = sidtab_context_to_sid(sidtab, &c->context[0],
-						   &c->sid[0]);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out;
-			rc = sidtab_context_to_sid(sidtab, &c->context[1],
-						   &c->sid[1]);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out;
+		rc = ocontext_to_sid(sidtab, c, 0, if_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
 		}
-		*if_sid = c->sid[0];
+		if (rc)
+			goto out;
 	} else
 		*if_sid = SECINITSID_NETIF;
 
@@ -2685,18 +2697,13 @@ retry:
 	}
 
 	if (c) {
-		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab,
-						   &c->context[0],
-						   &c->sid[0]);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out;
+		rc = ocontext_to_sid(sidtab, c, 0, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
 		}
-		*out_sid = c->sid[0];
+		if (rc)
+			goto out;
 	} else {
 		*out_sid = SECINITSID_NODE;
 	}
@@ -2860,7 +2867,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
-	int rc, cmp = 0;
+	int cmp = 0;
 
 	while (path[0] == '/' && path[1] == '/')
 		path++;
@@ -2874,9 +2881,8 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 			break;
 	}
 
-	rc = -ENOENT;
 	if (!genfs || cmp)
-		goto out;
+		return -ENOENT;
 
 	for (c = genfs->head; c; c = c->next) {
 		len = strlen(c->u.name);
@@ -2885,20 +2891,10 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 			break;
 	}
 
-	rc = -ENOENT;
 	if (!c)
-		goto out;
-
-	if (!c->sid[0]) {
-		rc = sidtab_context_to_sid(sidtab, &c->context[0], &c->sid[0]);
-		if (rc)
-			goto out;
-	}
+		return -ENOENT;
 
-	*sid = c->sid[0];
-	rc = 0;
-out:
-	return rc;
+	return ocontext_to_sid(sidtab, c, 0, sid);
 }
 
 /**
@@ -2981,17 +2977,13 @@ retry:
 
 	if (c) {
 		sbsec->behavior = c->v.behavior;
-		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(sidtab, &c->context[0],
-						   &c->sid[0]);
-			if (rc == -ESTALE) {
-				rcu_read_unlock();
-				goto retry;
-			}
-			if (rc)
-				goto out;
+		rc = ocontext_to_sid(sidtab, c, 0, &sbsec->sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			goto retry;
 		}
-		sbsec->sid = c->sid[0];
+		if (rc)
+			goto out;
 	} else {
 		rc = __security_genfs_sid(policy, fstype, "/",
 					SECCLASS_DIR, &sbsec->sid);
-- 
2.31.1

