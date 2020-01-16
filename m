Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC63AC33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17492051A
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDK8N5dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPO1F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:27:05 -0500
Received: from mail-ed1-f73.google.com ([209.85.208.73]:54426 "EHLO
        mail-ed1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAPO1F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 09:27:05 -0500
Received: by mail-ed1-f73.google.com with SMTP id j6so14026389edt.21
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jELZmjm3Hsw2JLNnK8wUTgICrgnjKlBSPiGBrTpDNpc=;
        b=HDK8N5dmp14dBTCbzADZ/1Gh7XVvRWskVM8EylCtq6M2SKUWplc1ayqi2qmydgRHec
         JPQcig5hGlOlcJBOJbP70XubovB/eZ9dsOGLYoos2cNXYEb+j3xzGmgWmWkeBm/F5pdq
         N4Ae/+AtikAYgb+Y0jQBZFkE4b4BIpxcQEuG+TM3I5BSLmmgyqoEIChIePWXp9f593sP
         xnvafPGVFcd1HWJgguxhf/vaEnjqX4bmwMFK7Qw9bCuC9RsthbpmovEX+uAaiwUZGLG1
         9vnrPD054I0yFoAwcf5DZWxML05kf5dPbAuPLK9PVWoFuVZDiYC3fskY27IjlNj1CvvI
         KdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jELZmjm3Hsw2JLNnK8wUTgICrgnjKlBSPiGBrTpDNpc=;
        b=nUAj4Wgboe4oq3WqOsuHVDy/cNNaxl9mdukfue8V18oT+IRHgLpsLIMTZAd91Lw8vC
         G5El7DD1beF5cQmOx4fc2GtvFgqaYWjXrBLEsj2YopN4dc1f53CSW9j50WnUI4TIhuug
         jFXZqwSuq7s1baut6NF424JR/7zgdg7+oBzhKW2JvrkJxb2+t2Vu5Oo2T7X5IXD3crno
         AkcUMFuGtnaGCd2oMjbhvjXtsZWgTOMdkz7XCLzYSr2QA5Ls25jddpF7V4OyiF2K/Yc1
         Cy61LXTpN0d4t01118faYJJnsvvTB8OHyF0jkkWx3mj8/wIQfD9v+B+AMgT+mLwkuUZt
         W96g==
X-Gm-Message-State: APjAAAVveTvpW7BEMtlnrgvVkFbIi9eCdB/oH8b6miudDJbTSH23tutP
        XZgZBYG4qdjPlkIcGw+djntnC996+9p6EanU7lWSDcce0B2wndYtfO6m/ZGng9lGEq7snnfupKd
        SsTWXYeJP+1XLN1prUkN+pFLL/xrSNStbR38kjK+zy39ZYtl88BEB6C6Y6dJc
X-Google-Smtp-Source: APXvYqzHjrh9ZWaI2A7HQiqUskQ9FeUI5YjWpyRMIeqZVCfu7h38G/hrVLAr5/0RBoqSPas1jZH6GaSMOg==
X-Received: by 2002:a05:6402:22d4:: with SMTP id dm20mr33012061edb.353.1579184822328;
 Thu, 16 Jan 2020 06:27:02 -0800 (PST)
Date:   Thu, 16 Jan 2020 15:26:53 +0100
Message-Id: <20200116142653.61738-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH] selinux: map RTM_GETLINK to a privileged permission
From:   Jeff Vander Stoep <jeffv@google.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, sds@tycho.nsa.gov,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Persistent device identifiers like MAC addresses are sensitive
because they are (usually) unique and can be used to
identify/track a device or user [1]. The MAC address is
accessible via the RTM_GETLINK request message type of a netlink
route socket[2] which returns the RTM_NEWLINK message.
Mapping RTM_GETLINK to a separate permission enables restricting
access to the MAC address without changing the behavior for
other RTM_GET* message types.

[1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
[2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
by existing LSM hooks.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 security/selinux/include/classmap.h |  2 +-
 security/selinux/include/security.h |  9 +++++++++
 security/selinux/nlmsgtab.c         | 26 +++++++++++++++++++++++++-
 security/selinux/ss/services.c      |  4 +++-
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..77ccd558890a 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -116,7 +116,7 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_IPC_PERMS, NULL } },
 	{ "netlink_route_socket",
 	  { COMMON_SOCK_PERMS,
-	    "nlmsg_read", "nlmsg_write", NULL } },
+	    "nlmsg_read", "nlmsg_write", "nlmsg_readpriv", NULL } },
 	{ "netlink_tcpdiag_socket",
 	  { COMMON_SOCK_PERMS,
 	    "nlmsg_read", "nlmsg_write", NULL } },
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a39f9565d80b..1671b418ddcb 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -79,6 +79,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_NETLINK_ROUTE_GETLINK,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
@@ -209,6 +210,13 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
 	return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
 }
 
+static inline bool selinux_policycap_nlroute_getlink(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return state->policycap[POLICYDB_CAPABILITY_NETLINK_ROUTE_GETLINK];
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			 void *data, size_t len);
@@ -422,6 +430,7 @@ extern struct vfsmount *selinuxfs_mount;
 extern void selnl_notify_setenforce(int val);
 extern void selnl_notify_policyload(u32 seqno);
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
+extern void selinux_nlmsg_init(void);
 
 extern void avtab_cache_init(void);
 extern void ebitmap_cache_init(void);
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index c97fdae8f71b..aa7064a629a0 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -25,7 +25,7 @@ struct nlmsg_perm {
 	u32	perm;
 };
 
-static const struct nlmsg_perm nlmsg_route_perms[] =
+static struct nlmsg_perm nlmsg_route_perms[] =
 {
 	{ RTM_NEWLINK,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELLINK,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
@@ -208,3 +208,27 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 
 	return err;
 }
+
+static void nlmsg_set_getlink_perm(u32 perm)
+{
+	int i;
+
+	for (i = 0; i < sizeof(nlmsg_route_perms)/sizeof(nlmsg_perm); i++) {
+		if (nlmsg_route_perms[i].nlmsg_type == RTM_GETLINK) {
+			nlmsg_route_perms[i].perm = perm;
+			break;
+		}
+	}
+}
+
+/**
+ * The value permission guarding RTM_GETLINK changes if nlroute_getlink
+ * policy capability is set.
+ */
+void selinux_nlmsg_init(void)
+{
+	if (selinux_policycap_nlroute_getlink())
+		nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READPRIV);
+	else
+		nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READ);
+}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 0e8b94e8e156..910b924fa715 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"extended_socket_class",
 	"always_check_network",
 	"cgroup_seclabel",
-	"nnp_nosuid_transition"
+	"nnp_nosuid_transition",
+	"netlink_route_getlink"
 };
 
 static struct selinux_ss selinux_ss;
@@ -2223,6 +2224,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 
 		state->ss->sidtab = newsidtab;
 		security_load_policycaps(state);
+		selinux_nlmsg_init();
 		selinux_mark_initialized(state);
 		seqno = ++state->ss->latest_granting;
 		selinux_complete_init();
-- 
2.25.0.rc1.283.g88dfdc4193-goog

