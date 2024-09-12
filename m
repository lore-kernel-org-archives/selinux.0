Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4086FBF
	for <selinux@vger.kernel.org>; Thu, 12 Sep 2024 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105532; cv=none; b=pFQHbh5tZTSyifDAx87u8NHN8iXrXbAQ9GdVHkfaVHKsxzZvLG4XI8Spn7xlbh3hNQ4SySmNWVEKQMnXxr8xwYL0yH86mZVyN7aTSyQySS0nfBZgWzpgkBzVlCmcoTS6flnhDHTJn6dYTVfyIAgYNkOPbJKJVqs4GLo8HHUPJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105532; c=relaxed/simple;
	bh=8jsr7U1VGQ82P/PAJdIdCPq2DI6FYh/5rInJaS3pdh0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nifZNMbcxRzp+E3ID2sE0goq/AFQtilRTArRZr1RIXqizhZKx2wSIuUeIVIxrgw2HjmjNZXT/95uhkeASwKIXQUvgnPDF7ZvoVnpXZWby5vIWOgML+qTz00LbNWUgUz22EmFQkCOU2QXltIiEnSMtWO4U+M8tL4/p52VntmHYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qoLsotyY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoLsotyY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d34c57a88eso18158507b3.0
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2024 18:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726105529; x=1726710329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYcK0mfdx/dSeam4Sc4ONeHnqkGTjVlw/h+xmG07ho4=;
        b=qoLsotyYLlwC32ihRbAxKsmLrTOIbjfZnoPUcPZajBfKG1N37i4bN9W7qUw2Ur5fSG
         mB3nlI+GpDeOhPDx8V8Gg8xLhTEhl6JMSSis9BDC+PKUlz4wsltmQMX2CujP/16qBRkl
         oKiJbNBxNZuAjIAHKRoDlZvQ8yjQ6Q7hlt+re8ee6ofAZbpA2jBHu5/BE5uwo7HHISfp
         gGQi3UbQ4lxsSP6u0JsL7fYfsy2VpX/xvTe7cdQJeRtXa7ZyWStTT3JO5XlEnRwPCR08
         8+cmHYo2LsV5+1MxWEm7jRE4BJxLvSOUnX9i3X3D7n2Al8IoCbQpu5+R2jEwnbsv/IyC
         mNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726105529; x=1726710329;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYcK0mfdx/dSeam4Sc4ONeHnqkGTjVlw/h+xmG07ho4=;
        b=tzkLIOdn86RDxWcAWPrZNXkNMJKm/zjQ0uA5yqEBHrfcdqiCqr8QjGsdwucmRHnpM+
         yDbUswkfgqlI4Z1YUrrneaZeBsU/sNUFRDjg3lEv6J9pfj34UQWFiE1/yze8Z30YCuHJ
         Zlpa4BtwSjjTUbcrzRMAO5SQrA5PaznlDRQrpEJzYaMHoaTVKiqMNAbHtyPUfeLX+/Zq
         r92SmhkBptlYkyaYaLXjRPfIqKXVOIIkTFUnPp6fMIPcQII4V8fZb6U0GG+T7080G296
         C3oCL+NQERNC9WGXhltZvgyIK7TUoBo8Hkjg7299D/itzIsI12oy9ix/JCmiNpSY8Wyh
         V0MA==
X-Forwarded-Encrypted: i=1; AJvYcCV9mpGlI0WBmFydXybc+BiVYX2FEh2VtLV3wtzicJRpOJQCYHzsAXdJNKdbT4Yy/W5oe0Jmtc0u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tbHSem5eYu6TYm1LH6mFVsO4uQcARJk8trB+/c5JIUIqdXK+
	a/6KWWA6Lp2qaszggLfQ+11prPbBLdIQAfWJzKdmznoLu1EpaGlo8N8kGL8tXZb5UcAH1Q/JDg=
	=
X-Google-Smtp-Source: AGHT+IEBbg0dTc0JoXpSRbCDOuWvt67vJZr0WB7+perxnq4LMgDrRo5vgBcblPycwE4JcHBcEPfkuXx9tg==
X-Received: from tweek-syd.c.googlers.com ([fda3:e722:ac3:cc00:b7:3870:c0a8:26])
 (user=tweek job=sendgmr) by 2002:a81:a982:0:b0:62d:1142:83a5 with SMTP id
 00721157ae682-6dbb6bb982amr336777b3.8.1726105529049; Wed, 11 Sep 2024
 18:45:29 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:45:03 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912014503.835759-1-tweek@google.com>
Subject: [PATCH v3] selinux: Add netlink xperm support
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: paul@paul-moore.com
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reuse the existing extended permissions infrastructure to support
policies based on the netlink message types.

A new policy capability "netlink_xperm" is introduced. When disabled,
the previous behaviour is preserved. That is, netlink_send will rely on
the permission mappings defined in nlmsgtab.c (e.g, nlmsg_read for
RTM_GETADDR on NETLINK_ROUTE). When enabled, the mappings are ignored
and the generic "nlmsg" permission is used instead.

The new "nlmsg" permission is an extended permission. The 16 bits of the
extended permission are mapped to the nlmsg_type field.

Example policy on Android, preventing regular apps from accessing the
device's MAC address and ARP table, but allowing this access to
privileged apps, looks as follows:

allow netdomain self:netlink_route_socket {
	create read getattr write setattr lock append connect getopt
	setopt shutdown nlmsg
};
allowxperm netdomain self:netlink_route_socket nlmsg ~{
	RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
};
allowxperm priv_app self:netlink_route_socket nlmsg {
	RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
};

The constants in the example above (e.g., RTM_GETLINK) are explicitly
defined in the policy.

It is possible to generate policies to support kernels that may or
may not have the capability enabled by generating a rule for each
scenario. For instance:

allow domain self:netlink_audit_socket nlmsg_read;
allow domain self:netlink_audit_socket nlmsg;
allowxperm domain self:netlink_audit_socket nlmsg { AUDIT_GET };

The approach of defining a new permission ("nlmsg") instead of relying
on the existing permissions (e.g., "nlmsg_read", "nlmsg_readpriv" or
"nlmsg_tty_audit") has been preferred because:
  1. This is similar to the other extended permission ("ioctl");
  2. With the new extended permission, the coarse-grained mapping is not
     necessary anymore. It could eventually be removed, which would be
     impossible if the extended permission was defined below these.
  3. Having a single extra extended permission considerably simplifies
     the implementation here and in libselinux.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Signed-off-by: Bram Bonn=C3=A9 <brambonne@google.com>
---
v3:
  - Remove condition on SECCLASS_NETLINK_GENERIC_SOCKET in
    selinux_netlink_send.
  - Remove comment in selinux_netlink_send.
  - Add comment in selinux_nlmsg_lookup.
  - Update commit message.
v2: Reorder classmap.h to keep the new permission "nlmsg" at the end.

 security/selinux/hooks.c                   | 51 +++++++++++---
 security/selinux/include/classmap.h        |  8 +--
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  6 ++
 security/selinux/nlmsgtab.c                | 27 ++++++++
 security/selinux/ss/avtab.h                |  5 +-
 security/selinux/ss/services.c             | 78 ++++++++++++----------
 8 files changed, 126 insertions(+), 51 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 400eca4ad0fb..a9abad82c098 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4592,14 +4592,10 @@ static int socket_sockcreate_sid(const struct task_=
security_struct *tsec,
 				       secclass, NULL, socksid);
 }
=20
-static int sock_has_perm(struct sock *sk, u32 perms)
+static bool sock_skip_has_perm(u32 sid)
 {
-	struct sk_security_struct *sksec =3D sk->sk_security;
-	struct common_audit_data ad;
-	struct lsm_network_audit net;
-
-	if (sksec->sid =3D=3D SECINITSID_KERNEL)
-		return 0;
+	if (sid =3D=3D SECINITSID_KERNEL)
+		return true;
=20
 	/*
 	 * Before POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT, sockets that
@@ -4613,7 +4609,19 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 	 * setting.
 	 */
 	if (!selinux_policycap_userspace_initial_context() &&
-	    sksec->sid =3D=3D SECINITSID_INIT)
+	    sid =3D=3D SECINITSID_INIT)
+		return true;
+	return false;
+}
+
+
+static int sock_has_perm(struct sock *sk, u32 perms)
+{
+	struct sk_security_struct *sksec =3D sk->sk_security;
+	struct common_audit_data ad;
+	struct lsm_network_audit net;
+
+	if (sock_skip_has_perm(sksec->sid))
 		return 0;
=20
 	ad_net_init_from_sk(&ad, &net, sk);
@@ -5939,6 +5947,26 @@ static unsigned int selinux_ip_postroute(void *priv,
 }
 #endif	/* CONFIG_NETFILTER */
=20
+static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 n=
lmsg_type)
+{
+	struct sk_security_struct *sksec =3D sk->sk_security;
+	struct common_audit_data ad;
+	struct lsm_network_audit net;
+	u8 driver;
+	u8 xperm;
+
+	if (sock_skip_has_perm(sksec->sid))
+		return 0;
+
+	ad_net_init_from_sk(&ad, &net, sk);
+
+	driver =3D nlmsg_type >> 8;
+	xperm =3D nlmsg_type & 0xff;
+
+	return avc_has_extended_perms(current_sid(), sksec->sid, sksec->sclass,
+			perms, driver, xperm, &ad);
+}
+
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	int rc =3D 0;
@@ -5964,7 +5992,12 @@ static int selinux_netlink_send(struct sock *sk, str=
uct sk_buff *skb)
=20
 		rc =3D selinux_nlmsg_lookup(sclass, nlh->nlmsg_type, &perm);
 		if (rc =3D=3D 0) {
-			rc =3D sock_has_perm(sk, perm);
+			if (selinux_policycap_netlink_xperm()) {
+				rc =3D nlmsg_sock_has_extended_perms(
+					sk, perm, nlh->nlmsg_type);
+			} else {
+				rc =3D sock_has_perm(sk, perm);
+			}
 			if (rc)
 				return rc;
 		} else if (rc =3D=3D -EINVAL) {
diff --git a/security/selinux/include/classmap.h b/security/selinux/include=
/classmap.h
index 7229c9bf6c27..cb2a52dcf0d7 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -96,17 +96,17 @@ const struct security_class_mapping secclass_map[] =3D =
{
 	{ "shm", { COMMON_IPC_PERMS, "lock", NULL } },
 	{ "ipc", { COMMON_IPC_PERMS, NULL } },
 	{ "netlink_route_socket",
-	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
+	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg", NULL } },
 	{ "netlink_tcpdiag_socket",
-	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
+	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg", NULL } },
 	{ "netlink_nflog_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "netlink_xfrm_socket",
-	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
+	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg", NULL } },
 	{ "netlink_selinux_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "netlink_iscsi_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "netlink_audit_socket",
 	  { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg_relay",
-	    "nlmsg_readpriv", "nlmsg_tty_audit", NULL } },
+	    "nlmsg_readpriv", "nlmsg_tty_audit", "nlmsg", NULL } },
 	{ "netlink_fib_lookup_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "netlink_connector_socket", { COMMON_SOCK_PERMS, NULL } },
 	{ "netlink_netfilter_socket", { COMMON_SOCK_PERMS, NULL } },
diff --git a/security/selinux/include/policycap.h b/security/selinux/includ=
e/policycap.h
index dc3674eb29c1..079679fe7254 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -14,6 +14,7 @@ enum {
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
+	POLICYDB_CAP_NETLINK_XPERM,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/=
include/policycap_names.h
index 2cffcc1ce851..e080827408c4 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -17,6 +17,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_=
MAX] =3D {
 	"genfs_seclabel_symlinks",
 	"ioctl_skip_cloexec",
 	"userspace_initial_context",
+	"netlink_xperm",
 };
 /* clang-format on */
=20
diff --git a/security/selinux/include/security.h b/security/selinux/include=
/security.h
index 289bf9233f71..c7f2731abd03 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -195,6 +195,12 @@ static inline bool selinux_policycap_userspace_initial=
_context(void)
 		selinux_state.policycap[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]);
 }
=20
+static inline bool selinux_policycap_netlink_xperm(void)
+{
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
+}
+
 struct selinux_policy_convert_data;
=20
 struct selinux_load_state {
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 8ff670cf1ee5..acc7d74b99d5 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -170,6 +170,33 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u=
32 *perm)
 {
 	int err =3D 0;
=20
+	if (selinux_policycap_netlink_xperm()) {
+		switch (sclass) {
+		case SECCLASS_NETLINK_ROUTE_SOCKET:
+			*perm =3D NETLINK_ROUTE_SOCKET__NLMSG;
+			break;
+		case SECCLASS_NETLINK_TCPDIAG_SOCKET:
+			*perm =3D NETLINK_TCPDIAG_SOCKET__NLMSG;
+			break;
+		case SECCLASS_NETLINK_XFRM_SOCKET:
+			*perm =3D NETLINK_XFRM_SOCKET__NLMSG;
+			break;
+		case SECCLASS_NETLINK_AUDIT_SOCKET:
+			*perm =3D NETLINK_AUDIT_SOCKET__NLMSG;
+			break;
+		/* While it is possible to add a similar permission to other
+		 * netlink classes, note that the extended permission value is
+		 * matched against the nlmsg_type field. Notably,
+		 * SECCLASS_NETLINK_GENERIC_SOCKET uses dynamic values for this
+		 * field, which means that it cannot be added as-is.
+		 */
+		default:
+			err =3D -ENOENT;
+			break;
+		}
+		return err;
+	}
+
 	switch (sclass) {
 	case SECCLASS_NETLINK_ROUTE_SOCKET:
 		/* RTM_MAX always points to RTM_SETxxxx, ie RTM_NEWxxx + 3.
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 8e8820484c55..f4407185401c 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -53,8 +53,9 @@ struct avtab_key {
  */
 struct avtab_extended_perms {
 /* These are not flags. All 256 values may be used */
-#define AVTAB_XPERMS_IOCTLFUNCTION 0x01
-#define AVTAB_XPERMS_IOCTLDRIVER   0x02
+#define AVTAB_XPERMS_IOCTLFUNCTION	0x01
+#define AVTAB_XPERMS_IOCTLDRIVER	0x02
+#define AVTAB_XPERMS_NLMSG		0x03
 	/* extension of the avtab_key specified */
 	u8 specified; /* ioctl, netfilter, ... */
 	/*
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index e33e55384b75..48d5748f03da 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -582,8 +582,7 @@ static void type_attribute_bounds_av(struct policydb *p=
olicydb,
 }
=20
 /*
- * flag which drivers have permissions
- * only looking for ioctl based extended permissions
+ * Flag which drivers have permissions.
  */
 void services_compute_xperms_drivers(
 		struct extended_perms *xperms,
@@ -591,14 +590,18 @@ void services_compute_xperms_drivers(
 {
 	unsigned int i;
=20
-	if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVER) {
+	switch (node->datum.u.xperms->specified) {
+	case AVTAB_XPERMS_IOCTLDRIVER:
 		/* if one or more driver has all permissions allowed */
 		for (i =3D 0; i < ARRAY_SIZE(xperms->drivers.p); i++)
 			xperms->drivers.p[i] |=3D node->datum.u.xperms->perms.p[i];
-	} else if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLFUNCT=
ION) {
+		break;
+	case AVTAB_XPERMS_IOCTLFUNCTION:
+	case AVTAB_XPERMS_NLMSG:
 		/* if allowing permissions within a driver */
 		security_xperm_set(xperms->drivers.p,
 					node->datum.u.xperms->driver);
+		break;
 	}
=20
 	xperms->len =3D 1;
@@ -942,55 +945,58 @@ static void avd_init(struct selinux_policy *policy, s=
truct av_decision *avd)
 	avd->flags =3D 0;
 }
=20
-void services_compute_xperms_decision(struct extended_perms_decision *xper=
md,
-					struct avtab_node *node)
+static void update_xperms_extended_data(u8 specified,
+					struct extended_perms_data *from,
+					struct extended_perms_data *xp_data)
 {
 	unsigned int i;
=20
-	if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLFUNCTION) {
+	switch (specified) {
+	case AVTAB_XPERMS_IOCTLDRIVER:
+		memset(xp_data->p, 0xff, sizeof(xp_data->p));
+		break;
+	case AVTAB_XPERMS_IOCTLFUNCTION:
+	case AVTAB_XPERMS_NLMSG:
+		for (i =3D 0; i < ARRAY_SIZE(xp_data->p); i++)
+			xp_data->p[i] |=3D from->p[i];
+		break;
+	}
+
+}
+
+void services_compute_xperms_decision(struct extended_perms_decision *xper=
md,
+					struct avtab_node *node)
+{
+	switch (node->datum.u.xperms->specified) {
+	case AVTAB_XPERMS_IOCTLFUNCTION:
+	case AVTAB_XPERMS_NLMSG:
 		if (xpermd->driver !=3D node->datum.u.xperms->driver)
 			return;
-	} else if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVE=
R) {
+		break;
+	case AVTAB_XPERMS_IOCTLDRIVER:
 		if (!security_xperm_test(node->datum.u.xperms->perms.p,
 					xpermd->driver))
 			return;
-	} else {
+		break;
+	default:
 		BUG();
 	}
=20
 	if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
 		xpermd->used |=3D XPERMS_ALLOWED;
-		if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVER) {
-			memset(xpermd->allowed->p, 0xff,
-					sizeof(xpermd->allowed->p));
-		}
-		if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLFUNCTION) {
-			for (i =3D 0; i < ARRAY_SIZE(xpermd->allowed->p); i++)
-				xpermd->allowed->p[i] |=3D
-					node->datum.u.xperms->perms.p[i];
-		}
+		update_xperms_extended_data(node->datum.u.xperms->specified,
+					    &node->datum.u.xperms->perms,
+					    xpermd->allowed);
 	} else if (node->key.specified =3D=3D AVTAB_XPERMS_AUDITALLOW) {
 		xpermd->used |=3D XPERMS_AUDITALLOW;
-		if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVER) {
-			memset(xpermd->auditallow->p, 0xff,
-					sizeof(xpermd->auditallow->p));
-		}
-		if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLFUNCTION) {
-			for (i =3D 0; i < ARRAY_SIZE(xpermd->auditallow->p); i++)
-				xpermd->auditallow->p[i] |=3D
-					node->datum.u.xperms->perms.p[i];
-		}
+		update_xperms_extended_data(node->datum.u.xperms->specified,
+					    &node->datum.u.xperms->perms,
+					    xpermd->auditallow);
 	} else if (node->key.specified =3D=3D AVTAB_XPERMS_DONTAUDIT) {
 		xpermd->used |=3D XPERMS_DONTAUDIT;
-		if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLDRIVER) {
-			memset(xpermd->dontaudit->p, 0xff,
-					sizeof(xpermd->dontaudit->p));
-		}
-		if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLFUNCTION) {
-			for (i =3D 0; i < ARRAY_SIZE(xpermd->dontaudit->p); i++)
-				xpermd->dontaudit->p[i] |=3D
-					node->datum.u.xperms->perms.p[i];
-		}
+		update_xperms_extended_data(node->datum.u.xperms->specified,
+					    &node->datum.u.xperms->perms,
+					    xpermd->dontaudit);
 	} else {
 		BUG();
 	}
--=20
2.46.0.662.g92d0881bb0-goog

