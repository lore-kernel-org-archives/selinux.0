Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B8FC33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 09:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7520728
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 09:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpoykEOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgAQJIJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:08:09 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:35161 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQJIJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 04:08:09 -0500
Received: by mail-wm1-f74.google.com with SMTP id 18so2027096wmp.0
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YRUzknZV6240gfy51vNWEpBJ5day2/TrHf2rgkpYr1g=;
        b=tpoykEOMZDT6GZ/K+eB2T8FYxNLUjrieR2FgUeHOz7jkvxGY3FsQYhsCPRBpnSTjQp
         bK19CzXHHr4IFgenKMsdvUfQYA7iPsugdP6NxNGb7B4acEOB4UIeubTrxAa44JshC4f+
         N9PseCExCYDL77OtyGbLucIX7+EK6w08UJzuIqhQmxLcMjybP2bjmvLFNX9AV5OGTK5m
         P66CsfkBxn2JUXPqP/A0TqXY9FyzigBLFgb3TLMQfdow9Y+mOPCkzRTJm09L5yb1z5n3
         gOWq5R7Ym496FB/XVmsIuLumo4qN7o2DHpTicPuNLCu2CW7p6eSB1q5XaYCZTIRqzd7z
         qLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YRUzknZV6240gfy51vNWEpBJ5day2/TrHf2rgkpYr1g=;
        b=SadqkT6oRkM4CdkbPT1qQWf+TUfACBL1t85e/nYR+vQTidHINa4du+PYLlreS5qVcr
         YPEwTarWU3wHi0/4W04mmRxOZueNsGQAfyvQj6lH4K8WeZU4/1FLibjU1r7s/ctWuF7o
         xBLF1DJjE+Dr1AB6B4gz6ttMudVf1/KWQ+69/q1QINTiXdiUyca8mQJZeCjSlPwn6izI
         X9kjiGQiMIV+6RX3nirH1esL75P5uD0wQf2K1Hz+5AJQBk+chCYgUOzf3F6kukVoqhdk
         kKZ9JWFaKtJ9Sk/amnfru2vUMkUjaGc2CPAqVL3B1yzn5Vox8ubN0s0O4xuby4azZ5AC
         BqlQ==
X-Gm-Message-State: APjAAAX33Y3CruxRtYh4VoKBG+LDtzYO2MP084112V8wpNaWx7CQudzu
        QEbwfuGZYO7yB3G4OKrOb75nu6KqdBcAboZZSZ0SO6KqBnevoUIkK4vxsIzncZMmurDZ6rzf/Mp
        4VVpNrJi0FM/6AZPX4QAd0vpyYUTeK1FhunYnQcax62CFgU7X71mDak0stFBg
X-Google-Smtp-Source: APXvYqzm8kEzv+NoZabtjfuzOBFBn4IeVWMPSJjP2U0kRWtPDWNdtTeA83Zh3RnjzCA2kQ1kSKzz0YFLyA==
X-Received: by 2002:adf:c746:: with SMTP id b6mr1933540wrh.298.1579252085886;
 Fri, 17 Jan 2020 01:08:05 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:08:02 +0100
Message-Id: <20200117090802.36613-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3] selinux: map RTM_GETLINK to a privileged permission
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

v3:
-Add security_policycaps_init() to handle loading of policycaps,
selinux_nlmsg_init(), and future initializations resulting from
policy capabilities.

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
 security/selinux/ss/services.c      | 13 ++++++++++---
 4 files changed, 45 insertions(+), 5 deletions(-)

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
index 0e8b94e8e156..091eeafd650d 100644
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
@@ -2157,6 +2158,12 @@ static void security_load_policycaps(struct selinux_state *state)
 	}
 }
 
+static void security_policycaps_init(struct selinux_state *state)
+{
+	security_load_policycaps(state);
+	selinux_nlmsg_init();
+}
+
 static int security_preserve_bools(struct selinux_state *state,
 				   struct policydb *newpolicydb);
 
@@ -2222,7 +2229,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		}
 
 		state->ss->sidtab = newsidtab;
-		security_load_policycaps(state);
+		security_policycaps_init(state);
 		selinux_mark_initialized(state);
 		seqno = ++state->ss->latest_granting;
 		selinux_complete_init();
@@ -2294,7 +2301,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	write_lock_irq(&state->ss->policy_rwlock);
 	memcpy(policydb, newpolicydb, sizeof(*policydb));
 	state->ss->sidtab = newsidtab;
-	security_load_policycaps(state);
+	security_policycaps_init(state);
 	oldmapping = state->ss->map.mapping;
 	state->ss->map.mapping = newmap.mapping;
 	state->ss->map.size = newmap.size;
-- 
2.25.0.341.g760bfbb309-goog

