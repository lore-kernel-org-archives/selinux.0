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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D8C33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 19:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCCF20684
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 19:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXLxJ3tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAPTpi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:45:38 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:33058 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgAPTpi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 14:45:38 -0500
Received: by mail-wr1-f74.google.com with SMTP id z15so9663017wrw.0
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 11:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MjlradkhgW/WhCpGKP6RzSNuXJD3H7VvDoLSidFiaFo=;
        b=wXLxJ3tVYZ2kNGp0NIcwdFsktOyXRyNxwy0CLTc8cIK7jl1/ih+DWFPbtifeVKPoYb
         YbygvLyhGzcZP/bjVJiv/7dJDZIhUKTczwM2eCJU+Yk1h9kP9H3eZquUqp9SxK9VIR1D
         Tw7BAWMFhnZPxqOC9UbDhkjzUEwdMWI4zJFoXGBpiAYVU8Ue+1UJYRqB7POx7YEO9eS0
         h4Cm2cFAGf2cud5sPVT6pHslUgoWpqA+EniPLgMVbjSLRa6dsUzDYg83Ne7dxEamjOMS
         urkio0sNeyEJ1oEc2glFXeOdD3qZUBdf3WPoNFaTT048YgEAl3cxdTIVSkCrlcWt6p+8
         D7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MjlradkhgW/WhCpGKP6RzSNuXJD3H7VvDoLSidFiaFo=;
        b=M0QSg6irxnklcCnHMj6KKTapJkTIzk51jGqN/uc50NOOWqC2ihw3Ndqq7AaVCg/ooq
         OyVSW/pIUfXiJQWnyHVahyvF5F7qQj3ba4C81MOznduwg2lJ5vf71YMWfKA0Nk/Jzb1X
         2QJ+dirnV6AXyE+8+MHpGChqzRyeAIdY7G0g+ck4Vo4QBfwmig1nZFarfNoOK5ugvIoT
         GP7Oz16sSIUuk8FjFehUHnPh8/PY2WcJt8N1sUiyG5SG6Tp5qrpFnvM/cab65dgkIfIg
         OrksH2CcTz9+YKV95PLiWaoI6b8fEff77ROI2eWOTXnh5+ia7ZmCbeU6wBcJh+zqTx/w
         ZRmw==
X-Gm-Message-State: APjAAAWa+k7pgtDxCMmIsAj6T+Xi8heJbdc1dx/BzjbNVkw7uTYcr2IR
        BOdFWAglzURIflPUsR8Q5F7KgHK4TO6T6SVknFYuha+VE+kenbFfmk/Rde1NJcJOLvdPeIBLblo
        hRChLO+77XXrco9To4a8d1n5RtfpxGgaTw3dY+2I131N1CpAxq1GXz4hxUaCY
X-Google-Smtp-Source: APXvYqz1bHrirHNq33PuRv3Tud8ov5MKNLUWVffxvxHR1kJgNw53gQPyE49vUQDnBHSlqp2u3etN2oNzOQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr4851655wrv.86.1579203935134;
 Thu, 16 Jan 2020 11:45:35 -0800 (PST)
Date:   Thu, 16 Jan 2020 20:45:30 +0100
Message-Id: <20200116194530.8696-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v2] selinux: map RTM_GETLINK to a privileged permission
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

v2:
-Fix comment.
-Use ARRAY_SIZE instead of sizeof/sizeof.
-Call selinux_nlmsg_init() after both instances of
selinux_load_policycaps().
Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 security/selinux/include/classmap.h |  2 +-
 security/selinux/include/security.h |  9 +++++++++
 security/selinux/nlmsgtab.c         | 26 +++++++++++++++++++++++++-
 security/selinux/ss/services.c      |  5 ++++-
 4 files changed, 39 insertions(+), 3 deletions(-)

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
index c97fdae8f71b..3992f4894cf7 100644
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
+	for (i = 0; i < ARRAY_SIZE(nlmsg_route_perms); i++) {
+		if (nlmsg_route_perms[i].nlmsg_type == RTM_GETLINK) {
+			nlmsg_route_perms[i].perm = perm;
+			break;
+		}
+	}
+}
+
+/**
+ * Use nlmsg_readpriv as the permission for RTM_GETLINK messages if the
+ * netlink_route_getlink policy capability is set. Otherwise use nlmsg_read.
+ */
+void selinux_nlmsg_init(void)
+{
+	if (selinux_policycap_nlroute_getlink())
+		nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READPRIV);
+	else
+		nlmsg_set_getlink_perm(NETLINK_ROUTE_SOCKET__NLMSG_READ);
+}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 0e8b94e8e156..64c18875c19a 100644
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
@@ -2295,6 +2297,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	memcpy(policydb, newpolicydb, sizeof(*policydb));
 	state->ss->sidtab = newsidtab;
 	security_load_policycaps(state);
+	selinux_nlmsg_init();
 	oldmapping = state->ss->map.mapping;
 	state->ss->map.mapping = newmap.mapping;
 	state->ss->map.size = newmap.size;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

