Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AE54782
	for <selinux@vger.kernel.org>; Thu,  5 Dec 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361676; cv=none; b=RV7Azm+18+ezKg9hvl0ES1gu5TSS55lJtPI6J8f3qBwBWRt5ecBw0IprdKNbZApJHaeOc6uW3qeC59iwB5man2DfX+vm2dKOYLb+inURhjPdj8oJ6FGFxVfFTbVT6Q6JM1lUqBhySkpiMRZj10NL4YJ8ZPHQwIlwObuqhL0g5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361676; c=relaxed/simple;
	bh=QAUSZr5sMexbLGF1a3CWnbthU4i2QKDKJZqdAcKn1V4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EZDVMovYmzG8hNPqdow4GiSrD0frYuAbRvqfUTAqk/mVGSfuOYGbYZgPdtwd555oKe5qgvTOtOtKt0GawqjiAhWrg31cIveIF0WgF5cwzpwY5jKgH0hY4gIWHyVbUnfntJB9aLrUn1vZq1u2YdeXYKziDTxxR0IlH+UqfmvUpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE25EF/r; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE25EF/r"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7259416fcafso494648b3a.0
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 17:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733361674; x=1733966474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RROloAIWalRmty0a5tDFay0PYPS/R6qF6CeXIe0k4T0=;
        b=qE25EF/rXN407/Dh97IZ4aW6PpbIndj5cWkkkec8nUrXwfJtMERUUylrsJL3CFzk4z
         ia+MyI3bzUKPrzGsZLOToNbFZRQSwNqlW3df/7BL3UNqyjc4Mi0VKC/AU4+qkUNq1Mb/
         EZwTeCa3S3P84mIDZC1CoXGzmnJ/Y4ebqRxMqDs5jnuSVlbPHlSijzREoj7Tea5O/0kM
         of49Rho97en1580dPaOfLExMIjeJ3+Fg62DNqoNW2HM2iEI10PiyIzQj0R28+Ikr+vHD
         a2ySr9HCyv/BgzRXj1MCADUn4JL7fiXPd+HtXcSxBN6VKZq++ToeHxuncVAvlcq4YEXX
         YGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733361674; x=1733966474;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RROloAIWalRmty0a5tDFay0PYPS/R6qF6CeXIe0k4T0=;
        b=uDwZFjbOl4SsOSXxHogzPQipPQE9eicppmYamuHUHY/9tYxAXBAUvHM2j1uZKJj2An
         1LlFb0Yptv+dC9NfsarLLP7dzwt3pdqiMofZdeSxcXl6yfDoRb+7GZaF1fXS5DOD6Mw5
         R/cs6EcD+0kWDvUziwSv8MHSWN1+10UHXrBiBafPeqHv1sw4/PvofKkPCGa1SUZE6DtO
         a2YBhNSOJ4yw0Li9/a6X2R7Fa9dov8pQ5exIhvqYlsJiEGJtnz07oAw8LkFWG5JaNavm
         98QE1VJy5bdKA1WzCP9azsG8Z0OYUQYV0PC3i9innenOlK1a+G/EmbiOVui6TWVspoK/
         SMYg==
X-Forwarded-Encrypted: i=1; AJvYcCXtX885Jeupm9tn2GWPcOrVO5V1JXUfDdEsNUhv8ODa74faPtzuWt7atG4WAR2cCvpLUIGXqi8R@vger.kernel.org
X-Gm-Message-State: AOJu0YxIL2SR+8CSEJnyxmNuc9T0Qo597KB03QkX3nk9mhsx0iJNN7/k
	t4nrR6m8+rbodBGegt3tqbc9/OFH0ojXLU3J/DmKsOcY5NOcO6ZGCee+90tsMqP1bR8J8RVIgA=
	=
X-Google-Smtp-Source: AGHT+IEtmcF8u2L2ZVXY9fRimJky3XvibRi3VR6BDoBDgU0uTSMXwfALrFHcGDAdpLZyM69Tu0G7IO+MlA==
X-Received: from pfbbe26.prod.google.com ([2002:a05:6a00:1f1a:b0:725:2893:5917])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c86:b0:725:9a7f:cce0
 with SMTP id d2e1a72fcca58-7259a7fd298mr3190043b3a.17.1733361673613; Wed, 04
 Dec 2024 17:21:13 -0800 (PST)
Date: Thu,  5 Dec 2024 12:21:00 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205012100.1444702-1-tweek@google.com>
Subject: [PATCH v2] selinux: add netlink nlmsg_type audit message
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a new audit message type to capture nlmsg-related information. This
is similar to LSM_AUDIT_DATA_IOCTL_OP which was added for the other
SELinux extended permission (ioctl).

Adding a new type is preferred to adding to the existing
lsm_network_audit structure which contains irrelevant information for
the netlink sockets (i.e., dport, sport).

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2: Change printed field name from nlmsg_type to nlnk-msgtype

 include/linux/lsm_audit.h | 2 ++
 security/lsm_audit.c      | 3 +++
 security/selinux/hooks.c  | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 97a8b21eb033..69d2b7bc00ed 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -77,6 +77,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_LOCKDOWN 15
 #define LSM_AUDIT_DATA_NOTIFICATION 16
 #define LSM_AUDIT_DATA_ANONINODE	17
+#define LSM_AUDIT_DATA_NLMSGTYPE	18
 	union 	{
 		struct path path;
 		struct dentry *dentry;
@@ -98,6 +99,7 @@ struct common_audit_data {
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
 		const char *anonclass;
+		u16 nlmsg_type;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 9a8352972086..70444230e56f 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_buffer =
*ab,
 	case LSM_AUDIT_DATA_ANONINODE:
 		audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);
 		break;
+	case LSM_AUDIT_DATA_NLMSGTYPE:
+		audit_log_format(ab, " nlnk-msgtype=3D%hu", a->u.nlmsg_type);
+		break;
 	} /* switch (a->type) */
 }
=20
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5a08f94e094..20ccd6ed5a75 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5939,14 +5939,14 @@ static int nlmsg_sock_has_extended_perms(struct soc=
k *sk, u32 perms, u16 nlmsg_t
 {
 	struct sk_security_struct *sksec =3D sk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net;
 	u8 driver;
 	u8 xperm;
=20
 	if (sock_skip_has_perm(sksec->sid))
 		return 0;
=20
-	ad_net_init_from_sk(&ad, &net, sk);
+	ad.type =3D LSM_AUDIT_DATA_NLMSGTYPE;
+	ad.u.nlmsg_type =3D nlmsg_type;
=20
 	driver =3D nlmsg_type >> 8;
 	xperm =3D nlmsg_type & 0xff;
--=20
2.47.0.338.g60cca15819-goog

