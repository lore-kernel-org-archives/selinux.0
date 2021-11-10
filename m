Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5AAC433F5
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B49610CB
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 11:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhKJLQT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 06:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJLQT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 06:16:19 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE1C061764
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 03:13:31 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id a186-20020a1c7fc3000000b00332f1a308e7so2941088wmd.3
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 03:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HxDJsmB/zR09rAoDYMR2fKuOte2x1uIK1M6o1dfnzuw=;
        b=ImfinXKPxM5OdgsrtqjTUmjTbEygN1/p3YYwUy+s2tfGkbD9ruaBPx1Qx3yGuBwg4O
         QcxVxMfAMxUtr0yKRUV4j2aOInBy2oy72nGDtBnvhtVR/WaaJd+DaOTJlRU2u9XS/eRO
         /Re4s6qNqDTKxDqBsX/pfkZ9FySig5T2iqs6nGquKaqfpYMLke8U3DL59LAudvDTEIKP
         OLt/uiVoBlCOWOk8z6qnpHIRC6YQTpYN5dlPz33H1zvKPBpzz0URCtpYRT1xiEVSeJ+D
         BRvnONZwGS/03bHGjCRp9CLHQlDCjp4xgbgS8YptFMCztUOb1pd/z5sD+6evK1kZt3Ti
         THJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HxDJsmB/zR09rAoDYMR2fKuOte2x1uIK1M6o1dfnzuw=;
        b=d5w6gmHETVfF2QJ2sHJWoaFjhtbegB7OlrpXKTmQyXx0UJyAGASXdnTAm7Zi8oJl7J
         nDVAJmKsYc/S9DCE7gJ64s77gc9ZGwXdWj1LImMO/xLwdPhJ71Za7lvtK6v0QrN/1ci/
         8hAoLPs3UuLCNPt8qgVwvOnbzTx6DLUWlOy7PRc7vkLrJK7xVGgk1hrwNFFhQU3whgEO
         0FYVrI7EXfeSMTIGN7m466IsLrP1UKPfmAC5SdSj4Ly499BNNbpBLBWmxiYZsu5DaYuy
         qsZXXTjC0kF20SS5W96RC0os7uIJGHtfYKJgBTCCsm+e/xYCEE9F0SrHfj+cI73auDnj
         dUoA==
X-Gm-Message-State: AOAM53240cyXXbMHUaud8DpIyiY1M3J9xjb9CfYgSnfKoxz1Am8qmuoT
        HWIGOJIBQqWWQSfRdxw6OnEWWWYg752/KeXg9aKklaDkO/FeiJKHiXCjxRZzY4l/mm44KBEv+LN
        x42LTEPz3REFwOk8Sj/3+KkSrXiMdj7ery1wtDhKqPo83qXehnvwBBwJa7furjtnXpObtnA4=
X-Google-Smtp-Source: ABdhPJzEX631pu16XYOenxe2vnlVFQHCAnUGPjnZqyREBotAr9aTPu8Av2cYTFEpqqWKDbnUPlthKO2WA3nSgBE=
X-Received: from bram1.zrh.corp.google.com ([2a00:79e0:61:301:5d20:cb30:3da8:7932])
 (user=brambonne job=sendgmr) by 2002:a5d:6c63:: with SMTP id
 r3mr18506337wrz.213.1636542810435; Wed, 10 Nov 2021 03:13:30 -0800 (PST)
Date:   Wed, 10 Nov 2021 12:13:09 +0100
Message-Id: <20211110111308.3463879-1-brambonne@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH] selinux: Add netlink xperm support
From:   Bram Bonne <brambonne@google.com>
To:     selinux@vger.kernel.org
Cc:     jeffv@google.com, paul@paul-moore.com, sds@tycho.nsa.gov,
        Bram Bonne <brambonne@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reuse the existing extended permissions infrastructure to support
sepolicy for different netlink message types.

When individual netlink message types are omitted only the existing
permissions are checked. As is the case for ioctl xperms, this feature
is intended to provide finer granularity for nlmsg_read and nlmsg_write
permissions, as they may be too imprecise. For example, a single
NETLINK_ROUTE socket may provide access to both an interface's IP
address and to its ARP table, which might have different privacy
implications. In addition, the set of message types has grown over time,
so even if the current list is acceptable, future additions might not be.
It was suggested before on the mailing list [1] that extended permissions
would be a good fit for this purpose.

Existing policy using the nlmsg_read and nlmsg_write permissions will
continue to work as-is. Similar to ioctl xperms, netlink xperms allow
for a more fine-grained policy where needed.

Example policy on Android, preventing regular apps from accessing the
device's MAC address and ARP table, but allowing this access to
privileged apps, looks as follows:

allow netdomain self:netlink_route_socket {
	create read getattr write setattr lock append connect getopt
	setopt shutdown nlmsg_read
};
allowxperm netdomain self:netlink_route_socket nlmsg ~{
	RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
};
allowxperm priv_app self:netlink_route_socket nlmsg {
	RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
};

Android currently uses code similar to [1] as a temporary workaround to
limit access to certain netlink message types; our hope is that this patch
will allow us to move back to upstream code with an approach that works for
everyone.

[1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com/

Signed-off-by: Bram Bonne <brambonne@google.com>
---
 security/selinux/hooks.c       | 24 +++++++++++++++++++++++-
 security/selinux/ss/avtab.h    |  1 +
 security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7ebd45ca345..a503865fabed 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4662,6 +4662,28 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 			    &ad);
 }
 
+static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
+{
+	struct sk_security_struct *sksec = sk->sk_security;
+	struct common_audit_data ad;
+	struct lsm_network_audit net = {0,};
+	u8 xperm;
+
+	if (sksec->sid == SECINITSID_KERNEL)
+		return 0;
+
+	ad.type = LSM_AUDIT_DATA_NET;
+	ad.u.net = &net;
+	ad.u.net->sk = sk;
+
+	// nlmsg_types comfortably fit into a single driver, see RTM_MAX in uapi/linux/rtnetlink.h
+	xperm = nlmsg_type & 0xff;
+
+	return avc_has_extended_perms(&selinux_state,
+			    current_sid(), sksec->sid, sksec->sclass, perms, 0, xperm,
+			    &ad);
+}
+
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
@@ -6037,7 +6059,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 
 		rc = selinux_nlmsg_lookup(sclass, nlh->nlmsg_type, &perm);
 		if (rc == 0) {
-			rc = sock_has_perm(sk, perm);
+			rc = nlmsg_sock_has_extended_perms(sk, perm, nlh->nlmsg_type);
 			if (rc)
 				return rc;
 		} else if (rc == -EINVAL) {
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d3ebea8d146f..f69aa7bc3dc3 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -55,6 +55,7 @@ struct avtab_extended_perms {
 /* These are not flags. All 256 values may be used */
 #define AVTAB_XPERMS_IOCTLFUNCTION	0x01
 #define AVTAB_XPERMS_IOCTLDRIVER	0x02
+#define AVTAB_XPERMS_NLMSG		0x03
 	/* extension of the avtab_key specified */
 	u8 specified; /* ioctl, netfilter, ... */
 	/*
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e5f1b2757a83..7bbb070e9ff5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -591,7 +591,7 @@ static void type_attribute_bounds_av(struct policydb *policydb,
 
 /*
  * flag which drivers have permissions
- * only looking for ioctl based extended permssions
+ * only looking for ioctl/netlink based extended permissions
  */
 void services_compute_xperms_drivers(
 		struct extended_perms *xperms,
@@ -607,6 +607,9 @@ void services_compute_xperms_drivers(
 		/* if allowing permissions within a driver */
 		security_xperm_set(xperms->drivers.p,
 					node->datum.u.xperms->driver);
+	} else if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
+		/* all netlink permissions are included in driver 0 */
+		xperms->drivers.p[0] |= 1;
 	}
 
 	xperms->len = 1;
@@ -970,6 +973,9 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 		if (!security_xperm_test(node->datum.u.xperms->perms.p,
 					xpermd->driver))
 			return;
+	} else if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
+		if (xpermd->driver != node->datum.u.xperms->driver)
+			return;
 	} else {
 		BUG();
 	}
@@ -985,6 +991,11 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 				xpermd->allowed->p[i] |=
 					node->datum.u.xperms->perms.p[i];
 		}
+		if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
+			for (i = 0; i < ARRAY_SIZE(xpermd->allowed->p); i++)
+				xpermd->allowed->p[i] |=
+					node->datum.u.xperms->perms.p[i];
+		}
 	} else if (node->key.specified == AVTAB_XPERMS_AUDITALLOW) {
 		xpermd->used |= XPERMS_AUDITALLOW;
 		if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLDRIVER) {
@@ -996,6 +1007,11 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 				xpermd->auditallow->p[i] |=
 					node->datum.u.xperms->perms.p[i];
 		}
+		if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
+			for (i = 0; i < ARRAY_SIZE(xpermd->auditallow->p); i++)
+				xpermd->auditallow->p[i] |=
+					node->datum.u.xperms->perms.p[i];
+		}
 	} else if (node->key.specified == AVTAB_XPERMS_DONTAUDIT) {
 		xpermd->used |= XPERMS_DONTAUDIT;
 		if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLDRIVER) {
@@ -1007,6 +1023,11 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 				xpermd->dontaudit->p[i] |=
 					node->datum.u.xperms->perms.p[i];
 		}
+		if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
+			for (i = 0; i < ARRAY_SIZE(xpermd->dontaudit->p); i++)
+				xpermd->dontaudit->p[i] |=
+					node->datum.u.xperms->perms.p[i];
+		}
 	} else {
 		BUG();
 	}
-- 
2.34.0.rc0.344.g81b53c2807-goog

