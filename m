Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F51CCB41
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636650; cv=none; b=kuIc70Pj41Z9SHGIeEkv0J7f6JA2KSi+g0geD6rceEhScREMMZkK16s+fIu/Sh6g4/kX3ZdhV2lNdj1DsSlVEbGrxAcbKrC1wKiHTpsV3kG9Bq7YyYNqhQw8tk/QRl7ipKo/dDbpcCH/a34WiJjwOMAOEum05VPIW9ShMq/KOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636650; c=relaxed/simple;
	bh=qyq2t/bbjYNhgYIxai9S7x1ULd/4YoID2sGCP/k9si8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XNpD8UBTPM5fM6mPbpJdmWptvQPBHtQ45C2e0XnhfnxNdp2pZaikxoK6IQINbE5w7GZukmmLnIGLL7VXonadOvlIp5bKGNf88qu9GkeXUuq5h8t1z+X+BD+HdNQjdQQtJvI4E2rsa6IxGOLrUMSsB1RSDyAwTdpr7aaEV0RRtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2R8x2l4v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2R8x2l4v"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so4537087b3.0
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729636648; x=1730241448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/Sh1lEYa0z4h2BPPPcBpKo+7EFcOZnqeALFUfsoU1E=;
        b=2R8x2l4vdWR/y9QSgFhOluIrpUEzGOCOu05+yWfbiQzWvxn8Fpu5s9TX3WJ0JI5dOv
         bq3Sr0HB3oQDfWPM44x3XC9hZNcy/aloUZnChebsE2X932vzpwVqL7DtvdYP6/0Ihs7D
         WuaSXVYF5rr9ATru1Og+hZi+nJ6gvChDm6LtWhQWZn8gM4x8U0c1vBP6TUYARBnRqRQi
         8+qg2xg1O2eghiU+5uhZsKNj1BozwpxwAiYl8fSnEj1JLS3AJgb15pP4HL5SOTvPg1Q5
         sR5GmbiKnbKvXYF9p8/zjqvin6lYS8umQGpz+8sgzS+NsZGqYlV0aqZz0qAwGx62iJRZ
         2weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729636648; x=1730241448;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/Sh1lEYa0z4h2BPPPcBpKo+7EFcOZnqeALFUfsoU1E=;
        b=jEoglcP6E0gpXdKJ/zv6gvly7OEc//qKW7XvYYAcHGo7O6sB2jo03dfXBH3ewjKR/I
         jj7ujF9kMIyMkfgL5SO5ecOkwSOwCq+i8G8RvLIqQ2txkhZetAOsTERWzVMSx1VHa60f
         dwvb2zynEbelj3Bl2dvL5bMhxZ/Is3M1LhLMstT3M63SrpDGJRS9AY0iZ05fS5tmTzdh
         xfeYtudjQMOmIQy1ttHS2LMia+uHnYMMt9jNRlhCeJyHCdJBs7VHCfdeak5GwzJrlnb1
         Ro+b36SG2qq5JwzsVsR+Jzco4wJQRqXI1VQoQ5/6qXIz4Llx0ypWEFGgpX6DMg9MReBE
         7s8w==
X-Forwarded-Encrypted: i=1; AJvYcCWZkmZoROy70WyLesEH5YnKsN5nrThh4SvJMdCxezcFClxFC4K8Yq0DvelMVQIGjDcHlkszzxzY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SgzVwy5KpzJ80ZoRp6Jn45U9sS1wchd3Y6mbfIiyuPwD1NLe
	lsu1EGgZ+9+FWycrzzKnMHdrZBQr3z9xJJv34d4+t/8AZRHuLE6eqXEUY2nESf/xQBiUCLCP8A=
	=
X-Google-Smtp-Source: AGHT+IFAd9Pn2Snwb1KlMLZP1AGFDiYqjro8lzRMQNevS6pharWgVE44y+2q6r5SlMcHuCQCIskB2pc7SA==
X-Received: from tweek-syd.c.googlers.com ([fda3:e722:ac3:cc00:b7:3870:c0a8:26])
 (user=tweek job=sendgmr) by 2002:a05:690c:6e05:b0:6be:523:af53 with SMTP id
 00721157ae682-6e7d49d4f9cmr2169157b3.3.1729636648010; Tue, 22 Oct 2024
 15:37:28 -0700 (PDT)
Date: Wed, 23 Oct 2024 09:37:11 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022223711.3066190-1-tweek@google.com>
Subject: [PATCH] selinux: add netlink nlmsg_type audit message
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: paul@paul-moore.com
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, 
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
index 849e832719e2..b6544024f688 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -425,6 +425,9 @@ static void dump_common_audit_data(struct audit_buffer =
*ab,
 	case LSM_AUDIT_DATA_ANONINODE:
 		audit_log_format(ab, " anonclass=3D%s", a->u.anonclass);
 		break;
+	case LSM_AUDIT_DATA_NLMSGTYPE:
+		audit_log_format(ab, " nlmsg_type=3D%hu", a->u.nlmsg_type);
+		break;
 	} /* switch (a->type) */
 }
=20
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad3abd48eed1..40afeba0b7de 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5932,14 +5932,14 @@ static int nlmsg_sock_has_extended_perms(struct soc=
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
2.47.0.105.g07ac214952-goog

