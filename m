Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232E2594B5
	for <selinux@vger.kernel.org>; Fri, 20 Dec 2024 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734668774; cv=none; b=PSsAoddQ79WSOVydDnQerGM3SG0tOwBY0IsrKtM2xTtMMWkP9Dj5SZNxk4ULUK6sIJ7+DntfQu61WoHC9YrHDsWzhX98dh/z+Pxu0XMjserE5dydm6iKHczX4IjpTf5XE4eHe8IAf0PEqluEaSEH6NgaAeZ3m3NTGN1RNsDHqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734668774; c=relaxed/simple;
	bh=ziAbDm3ottY7TQldHtGjV63ackVEtsGaoBgp2u36nnk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=omb+7gKoeqeSlkOvVPsN/lpfSgkMJPgQyNk6/YzYYUrbhQ25VIkcyqhgNaHzCmqLq2o963LJKbK+UBkyyzJviNIt9L2GWtHHMNeXoduyfc8AFMVoCl/gFfJYh++8ZSQF/SSWGionmeJC/y84BulplrjvCSVcO/3cW9CYjamX++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlV9UrVd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlV9UrVd"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so1392749a91.2
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2024 20:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734668771; x=1735273571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+gXlpbIh40qS9LHsePfu5FzeEITci3Lx269Cw17APA=;
        b=TlV9UrVdEwqCMsFy079VdxT+NWDnEU1oq6/rHHYgbGytTbDfTjMU5vDh0nBMBsIv8v
         IBmg/34x4UnJsUJNCfEQ/46xyYl/hhhEpJY4erKU20a3GiUspuNss4UxlBLivsH4Wt9k
         97n1ve9YNNdK7dd6SZnv+soqlXHSSq39f6ESFvKMWDCL/EUqDrN1wZmJ8gMtuqW0Z3RV
         l2iUZ3GkUe+hplDePKmSH+L4XnsMjKrqk0FMlgeZWWuwsIS7UjBAhL2YAAQ5O7LERqK5
         qNmFF2f5wkViqNSQE0z0Q2jkmi4Bd5zMxw2n6+yfU555vtvzBMQprt+dmmcntq4khO5y
         UPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734668771; x=1735273571;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+gXlpbIh40qS9LHsePfu5FzeEITci3Lx269Cw17APA=;
        b=dBtmy/hZ8vqvmwxgIjQxlrUAmRbG0SEbmtYxEJGp9N8gfpy3nz1oelYNcE/X6qbBiF
         q/4pEOxLtrHpVOCe9ctpWxrO1qcMO5ofEn9cIQX0VZZAVfC1r5jm0qVCWzxP1a6aSv9d
         xVdpGCMe88ESkHwOb5yuGzyAjOPSvemwi13mvsUlE51a2+vEZhXZzbdpVXYwDfi6lmFG
         iBSyPk3jMxejrKzYUMhpVWa06ZSKh0RIM9Pq9os9Lp9ELYqkrxXxEEljC4My97t8NQeR
         L+eYBpPgT9urHV5RwnAb6kuuIs6WQdQjTg3I6y9C8kQmpV0/aqswoxIctJ2k8pVKYwzF
         iWhg==
X-Forwarded-Encrypted: i=1; AJvYcCU0+VHrmun3J2SwtUd3zBdRyvZxcmcgPFtvV7Eyx7MGjWuzlABK7B7K3XVYsWRw8hDla698CmP1@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuyaQMsy6R/ZJsSaEZPC3oxHuvE4lO62q0bqePrLJC+RvJfN/
	qqLPnBi/C3+xDUWghKOtr0oDUg9xF6/7B2Iikt7YDVf6Ocpr49HlbX/+MsAVFOnAyfJMEhRyXw=
	=
X-Google-Smtp-Source: AGHT+IHzuuCx3GW3C21jwvolLs5SfJt1dESC3eNlrbqNN8hv/cqdgnTACS2ryPnj96o78j/0dbNNzScG3g==
X-Received: from pjbsb11.prod.google.com ([2002:a17:90b:50cb:b0:2ea:61ba:b8f7])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d64e:b0:2ee:a4f2:b311
 with SMTP id 98e67ed59e1d1-2f452dfae72mr2646743a91.8.1734668771626; Thu, 19
 Dec 2024 20:26:11 -0800 (PST)
Date: Fri, 20 Dec 2024 15:25:58 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220042558.862915-1-tweek@google.com>
Subject: [PATCH v2] selinux: match extended permissions to their base permissions
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In commit d1d991efaf34 ("selinux: Add netlink xperm support") a new
extended permission was added ("nlmsg"). This was the second extended
permission implemented in selinux ("ioctl" being the first one).

Extended permissions are associated with a base permission. It was found
that, in the access vector cache (avc), the extended permission did not
keep track of its base permission. This is an issue for a domain that is
using both extended permissions (i.e., a domain calling ioctl() on a
netlink socket). In this case, the extended permissions were
overlapping.

Keep track of the base permission in the cache. A new field "base_perm"
is added to struct extended_perms_decision to make sure that the
extended permission refers to the correct policy permission. A new field
"base_perms" is added to struct extended_perms to quickly decide if
extended permissions apply.

While it is in theory possible to retrieve the base permission from the
access vector, the same base permission may not be mapped to the same
bit for each class (e.g., "nlmsg" is mapped to a different bit for
"netlink_route_socket" and "netlink_audit_socket"). Instead, use a
constant (AVC_EXT_IOCTL or AVC_EXT_NLMSG) provided by the caller.

Fixes: d1d991efaf34 ("selinux: Add netlink xperm support")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2:
Based on Paul's feedback:
 - Move base_perms to the second field in struct extended_perms.
 - In context_struct_compute_av, memset the whole structure (instead of
   each field individually).
 - In services_compute_xperms_decision, merge the "if" blocks.

 security/selinux/avc.c              | 61 ++++++++++++++++-------------
 security/selinux/hooks.c            |  6 +--
 security/selinux/include/avc.h      |  5 ++-
 security/selinux/include/security.h |  3 ++
 security/selinux/ss/services.c      | 28 +++++++++----
 5 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index cc0b0af20296..1f2680bcc43a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -174,13 +174,15 @@ int avc_get_hash_stats(char *page)
  * using a linked list for extended_perms_decision lookup because the list=
 is
  * always small. i.e. less than 5, typically 1
  */
-static struct extended_perms_decision *avc_xperms_decision_lookup(u8 drive=
r,
-					struct avc_xperms_node *xp_node)
+static struct extended_perms_decision *
+avc_xperms_decision_lookup(u8 driver, u8 base_perm,
+			   struct avc_xperms_node *xp_node)
 {
 	struct avc_xperms_decision_node *xpd_node;
=20
 	list_for_each_entry(xpd_node, &xp_node->xpd_head, xpd_list) {
-		if (xpd_node->xpd.driver =3D=3D driver)
+		if (xpd_node->xpd.driver =3D=3D driver &&
+		    xpd_node->xpd.base_perm =3D=3D base_perm)
 			return &xpd_node->xpd;
 	}
 	return NULL;
@@ -205,11 +207,12 @@ avc_xperms_has_perm(struct extended_perms_decision *x=
pd,
 }
=20
 static void avc_xperms_allow_perm(struct avc_xperms_node *xp_node,
-				u8 driver, u8 perm)
+				  u8 driver, u8 base_perm, u8 perm)
 {
 	struct extended_perms_decision *xpd;
 	security_xperm_set(xp_node->xp.drivers.p, driver);
-	xpd =3D avc_xperms_decision_lookup(driver, xp_node);
+	xp_node->xp.base_perms |=3D base_perm;
+	xpd =3D avc_xperms_decision_lookup(driver, base_perm, xp_node);
 	if (xpd && xpd->allowed)
 		security_xperm_set(xpd->allowed->p, perm);
 }
@@ -245,6 +248,7 @@ static void avc_xperms_free(struct avc_xperms_node *xp_=
node)
 static void avc_copy_xperms_decision(struct extended_perms_decision *dest,
 					struct extended_perms_decision *src)
 {
+	dest->base_perm =3D src->base_perm;
 	dest->driver =3D src->driver;
 	dest->used =3D src->used;
 	if (dest->used & XPERMS_ALLOWED)
@@ -272,6 +276,7 @@ static inline void avc_quick_copy_xperms_decision(u8 pe=
rm,
 	 */
 	u8 i =3D perm >> 5;
=20
+	dest->base_perm =3D src->base_perm;
 	dest->used =3D src->used;
 	if (dest->used & XPERMS_ALLOWED)
 		dest->allowed->p[i] =3D src->allowed->p[i];
@@ -357,6 +362,7 @@ static int avc_xperms_populate(struct avc_node *node,
=20
 	memcpy(dest->xp.drivers.p, src->xp.drivers.p, sizeof(dest->xp.drivers.p))=
;
 	dest->xp.len =3D src->xp.len;
+	dest->xp.base_perms =3D src->xp.base_perms;
=20
 	/* for each source xpd allocate a destination xpd and copy */
 	list_for_each_entry(src_xpd, &src->xpd_head, xpd_list) {
@@ -807,6 +813,7 @@ int __init avc_add_callback(int (*callback)(u32 event),=
 u32 events)
  * @event : Updating event
  * @perms : Permission mask bits
  * @driver: xperm driver information
+ * @base_perm: the base permission associated with the extended permission
  * @xperm: xperm permissions
  * @ssid: AVC entry source sid
  * @tsid: AVC entry target sid
@@ -820,10 +827,9 @@ int __init avc_add_callback(int (*callback)(u32 event)=
, u32 events)
  * otherwise, this function updates the AVC entry. The original AVC-entry =
object
  * will release later by RCU.
  */
-static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 =
ssid,
-			   u32 tsid, u16 tclass, u32 seqno,
-			   struct extended_perms_decision *xpd,
-			   u32 flags)
+static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
+			   u8 xperm, u32 ssid, u32 tsid, u16 tclass, u32 seqno,
+			   struct extended_perms_decision *xpd, u32 flags)
 {
 	u32 hvalue;
 	int rc =3D 0;
@@ -880,7 +886,7 @@ static int avc_update_node(u32 event, u32 perms, u8 dri=
ver, u8 xperm, u32 ssid,
 	case AVC_CALLBACK_GRANT:
 		node->ae.avd.allowed |=3D perms;
 		if (node->ae.xp_node && (flags & AVC_EXTENDED_PERMS))
-			avc_xperms_allow_perm(node->ae.xp_node, driver, xperm);
+			avc_xperms_allow_perm(node->ae.xp_node, driver, base_perm, xperm);
 		break;
 	case AVC_CALLBACK_TRY_REVOKE:
 	case AVC_CALLBACK_REVOKE:
@@ -987,10 +993,9 @@ static noinline void avc_compute_av(u32 ssid, u32 tsid=
, u16 tclass,
 	avc_insert(ssid, tsid, tclass, avd, xp_node);
 }
=20
-static noinline int avc_denied(u32 ssid, u32 tsid,
-			       u16 tclass, u32 requested,
-			       u8 driver, u8 xperm, unsigned int flags,
-			       struct av_decision *avd)
+static noinline int avc_denied(u32 ssid, u32 tsid, u16 tclass, u32 request=
ed,
+			       u8 driver, u8 base_perm, u8 xperm,
+			       unsigned int flags, struct av_decision *avd)
 {
 	if (flags & AVC_STRICT)
 		return -EACCES;
@@ -999,7 +1004,7 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
 	    !(avd->flags & AVD_FLAGS_PERMISSIVE))
 		return -EACCES;
=20
-	avc_update_node(AVC_CALLBACK_GRANT, requested, driver,
+	avc_update_node(AVC_CALLBACK_GRANT, requested, driver, base_perm,
 			xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
 	return 0;
 }
@@ -1012,7 +1017,8 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
  * driver field is used to specify which set contains the permission.
  */
 int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
-			   u8 driver, u8 xperm, struct common_audit_data *ad)
+			   u8 driver, u8 base_perm, u8 xperm,
+			   struct common_audit_data *ad)
 {
 	struct avc_node *node;
 	struct av_decision avd;
@@ -1047,22 +1053,23 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 =
tclass, u32 requested,
 	local_xpd.auditallow =3D &auditallow;
 	local_xpd.dontaudit =3D &dontaudit;
=20
-	xpd =3D avc_xperms_decision_lookup(driver, xp_node);
+	xpd =3D avc_xperms_decision_lookup(driver, base_perm, xp_node);
 	if (unlikely(!xpd)) {
 		/*
 		 * Compute the extended_perms_decision only if the driver
-		 * is flagged
+		 * is flagged and the base permission is known.
 		 */
-		if (!security_xperm_test(xp_node->xp.drivers.p, driver)) {
+		if (!security_xperm_test(xp_node->xp.drivers.p, driver) ||
+		    !(xp_node->xp.base_perms & base_perm)) {
 			avd.allowed &=3D ~requested;
 			goto decision;
 		}
 		rcu_read_unlock();
-		security_compute_xperms_decision(ssid, tsid, tclass,
-						 driver, &local_xpd);
+		security_compute_xperms_decision(ssid, tsid, tclass, driver,
+						 base_perm, &local_xpd);
 		rcu_read_lock();
-		avc_update_node(AVC_CALLBACK_ADD_XPERMS, requested,
-				driver, xperm, ssid, tsid, tclass, avd.seqno,
+		avc_update_node(AVC_CALLBACK_ADD_XPERMS, requested, driver,
+				base_perm, xperm, ssid, tsid, tclass, avd.seqno,
 				&local_xpd, 0);
 	} else {
 		avc_quick_copy_xperms_decision(xperm, &local_xpd, xpd);
@@ -1075,8 +1082,8 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tc=
lass, u32 requested,
 decision:
 	denied =3D requested & ~(avd.allowed);
 	if (unlikely(denied))
-		rc =3D avc_denied(ssid, tsid, tclass, requested,
-				driver, xperm, AVC_EXTENDED_PERMS, &avd);
+		rc =3D avc_denied(ssid, tsid, tclass, requested, driver,
+				base_perm, xperm, AVC_EXTENDED_PERMS, &avd);
=20
 	rcu_read_unlock();
=20
@@ -1110,7 +1117,7 @@ static noinline int avc_perm_nonode(u32 ssid, u32 tsi=
d, u16 tclass,
 	avc_compute_av(ssid, tsid, tclass, avd, &xp_node);
 	denied =3D requested & ~(avd->allowed);
 	if (unlikely(denied))
-		return avc_denied(ssid, tsid, tclass, requested, 0, 0,
+		return avc_denied(ssid, tsid, tclass, requested, 0, 0, 0,
 				  flags, avd);
 	return 0;
 }
@@ -1158,7 +1165,7 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	rcu_read_unlock();
=20
 	if (unlikely(denied))
-		return avc_denied(ssid, tsid, tclass, requested, 0, 0,
+		return avc_denied(ssid, tsid, tclass, requested, 0, 0, 0,
 				  flags, avd);
 	return 0;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 366c87a40bd1..171dd7fceac5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3688,8 +3688,8 @@ static int ioctl_has_perm(const struct cred *cred, st=
ruct file *file,
 		return 0;
=20
 	isec =3D inode_security(inode);
-	rc =3D avc_has_extended_perms(ssid, isec->sid, isec->sclass,
-				    requested, driver, xperm, &ad);
+	rc =3D avc_has_extended_perms(ssid, isec->sid, isec->sclass, requested,
+				    driver, AVC_EXT_IOCTL, xperm, &ad);
 out:
 	return rc;
 }
@@ -5952,7 +5952,7 @@ static int nlmsg_sock_has_extended_perms(struct sock =
*sk, u32 perms, u16 nlmsg_t
 	xperm =3D nlmsg_type & 0xff;
=20
 	return avc_has_extended_perms(current_sid(), sksec->sid, sksec->sclass,
-			perms, driver, xperm, &ad);
+				      perms, driver, AVC_EXT_NLMSG, xperm, &ad);
 }
=20
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.=
h
index 96a614d47df8..281f40103663 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -136,8 +136,11 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid, u16 tclas=
s, u32 requested,
 int avc_has_perm(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
=20
+#define AVC_EXT_IOCTL	(1 << 0) /* Cache entry for an ioctl extended permis=
sion */
+#define AVC_EXT_NLMSG	(1 << 1) /* Cache entry for an nlmsg extended permis=
sion */
 int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
-			   u8 driver, u8 perm, struct common_audit_data *ad);
+			   u8 driver, u8 base_perm, u8 perm,
+			   struct common_audit_data *ad);
=20
 u32 avc_policy_seqno(void);
=20
diff --git a/security/selinux/include/security.h b/security/selinux/include=
/security.h
index c7f2731abd03..700bd6c8bb38 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -239,6 +239,7 @@ struct extended_perms_data {
 struct extended_perms_decision {
 	u8 used;
 	u8 driver;
+	u8 base_perm;
 	struct extended_perms_data *allowed;
 	struct extended_perms_data *auditallow;
 	struct extended_perms_data *dontaudit;
@@ -246,6 +247,7 @@ struct extended_perms_decision {
=20
 struct extended_perms {
 	u16 len; /* length associated decision chain */
+	u8 base_perms; /* which base permissions are covered */
 	struct extended_perms_data drivers; /* flag drivers that are used */
 };
=20
@@ -257,6 +259,7 @@ void security_compute_av(u32 ssid, u32 tsid, u16 tclass=
,
 			 struct extended_perms *xperms);
=20
 void security_compute_xperms_decision(u32 ssid, u32 tsid, u16 tclass, u8 d=
river,
+				      u8 base_perm,
 				      struct extended_perms_decision *xpermd);
=20
 void security_compute_av_user(u32 ssid, u32 tsid, u16 tclass,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 3d5c563cfc4c..d9f58b5d0f49 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -582,7 +582,7 @@ static void type_attribute_bounds_av(struct policydb *p=
olicydb,
 }
=20
 /*
- * Flag which drivers have permissions.
+ * Flag which drivers have permissions and which base permissions are cove=
red.
  */
 void services_compute_xperms_drivers(
 		struct extended_perms *xperms,
@@ -592,12 +592,19 @@ void services_compute_xperms_drivers(
=20
 	switch (node->datum.u.xperms->specified) {
 	case AVTAB_XPERMS_IOCTLDRIVER:
+		xperms->base_perms |=3D AVC_EXT_IOCTL;
 		/* if one or more driver has all permissions allowed */
 		for (i =3D 0; i < ARRAY_SIZE(xperms->drivers.p); i++)
 			xperms->drivers.p[i] |=3D node->datum.u.xperms->perms.p[i];
 		break;
 	case AVTAB_XPERMS_IOCTLFUNCTION:
+		xperms->base_perms |=3D AVC_EXT_IOCTL;
+		/* if allowing permissions within a driver */
+		security_xperm_set(xperms->drivers.p,
+					node->datum.u.xperms->driver);
+		break;
 	case AVTAB_XPERMS_NLMSG:
+		xperms->base_perms |=3D AVC_EXT_NLMSG;
 		/* if allowing permissions within a driver */
 		security_xperm_set(xperms->drivers.p,
 					node->datum.u.xperms->driver);
@@ -631,8 +638,7 @@ static void context_struct_compute_av(struct policydb *=
policydb,
 	avd->auditallow =3D 0;
 	avd->auditdeny =3D 0xffffffff;
 	if (xperms) {
-		memset(&xperms->drivers, 0, sizeof(xperms->drivers));
-		xperms->len =3D 0;
+		memset(xperms, 0, sizeof(*xperms));
 	}
=20
 	if (unlikely(!tclass || tclass > policydb->p_classes.nprim)) {
@@ -969,13 +975,19 @@ void services_compute_xperms_decision(struct extended=
_perms_decision *xpermd,
 {
 	switch (node->datum.u.xperms->specified) {
 	case AVTAB_XPERMS_IOCTLFUNCTION:
-	case AVTAB_XPERMS_NLMSG:
-		if (xpermd->driver !=3D node->datum.u.xperms->driver)
+		if (xpermd->base_perm !=3D AVC_EXT_IOCTL ||
+		    xpermd->driver !=3D node->datum.u.xperms->driver)
 			return;
 		break;
 	case AVTAB_XPERMS_IOCTLDRIVER:
-		if (!security_xperm_test(node->datum.u.xperms->perms.p,
-					xpermd->driver))
+		if (xpermd->base_perm !=3D AVC_EXT_IOCTL ||
+		    !security_xperm_test(node->datum.u.xperms->perms.p,
+					 xpermd->driver))
+			return;
+		break;
+	case AVTAB_XPERMS_NLMSG:
+		if (xpermd->base_perm !=3D AVC_EXT_NLMSG ||
+		    xpermd->driver !=3D node->datum.u.xperms->driver)
 			return;
 		break;
 	default:
@@ -1010,6 +1022,7 @@ void security_compute_xperms_decision(u32 ssid,
 				      u32 tsid,
 				      u16 orig_tclass,
 				      u8 driver,
+				      u8 base_perm,
 				      struct extended_perms_decision *xpermd)
 {
 	struct selinux_policy *policy;
@@ -1023,6 +1036,7 @@ void security_compute_xperms_decision(u32 ssid,
 	struct ebitmap_node *snode, *tnode;
 	unsigned int i, j;
=20
+	xpermd->base_perm =3D base_perm;
 	xpermd->driver =3D driver;
 	xpermd->used =3D 0;
 	memset(xpermd->allowed->p, 0, sizeof(xpermd->allowed->p));
--=20
2.47.1.613.gc27f4b7a9f-goog

