Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7111FC77B7C
	for <selinux@archiver.kernel.org>; Thu,  4 May 2023 14:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEDOQm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 May 2023 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjEDOQl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 May 2023 10:16:41 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 07:16:37 PDT
Received: from sender11-of-o53.zoho.eu (sender11-of-o53.zoho.eu [31.186.226.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405388687
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 07:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683209639; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Kvwx/nTWAFX8V5F15QZ+wzvdHqgmDOncBpoaYrusM6SePTvLG48TXv23YVkXBewvelA+i8EoO8Pmfyy+qwSqdt48+uwhY7zKCLCyYk1N+3vfp9kGTpJMZh7D5mQIsUHJ6w1qkFRSLxaVGyaemdT3C0GTVi9iiq9zauyC8sh/+tk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1683209639; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=A7VjTUqeY7lcEX4S7nZtCjU2soxgNwJB4MzowP5hKC8=; 
        b=Yq93YFTnzZXE3D2PDZgMzBejxHQYzU2b+c7QrO6qTEMLSBcNVapRcZA7dT2a0cCNN5U55DbaLBBaGNA4J6Kur2L2FvCKx60AuYViWcJdjaM1vVfEkYgzLoUDJ3zlm6Es12z9kxQYa1HARHLtY+txggd8V0JRwdobAlpN+PXnnQw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683209639;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=A7VjTUqeY7lcEX4S7nZtCjU2soxgNwJB4MzowP5hKC8=;
        b=eI4Ght/x6XViBIFKIWJJA8YDG6u9Bud7YBW+JbU9NVJWtyrCiUp9UloVll+PGR7W
        7wZRl+m2ng1nfbd/X7u9EqzZLuillmu9fZpVzckSVbPLfQuFLKkfAdnTl16ZgyoNG89
        pLHe7XRVn0WHhFoitgUA51qI241WelFdbMp9sUJ0=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1683209637545998.9070998817757; Thu, 4 May 2023 16:13:57 +0200 (CEST)
Received: from jmarcin-t14s-01.. (unknown [213.175.37.10])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 730612079AC0;
        Thu,  4 May 2023 14:13:56 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: [PATCH] selinux: make cleanup on error consistent
Date:   Thu,  4 May 2023 16:13:30 +0200
Message-Id: <20230504141330.1557243-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The file security.c contains two functions (security_read_policy() and
security_read_state_kernel()) that are almost identical, but their
cleanup conventions differ.

This patch unifies the behavior by adding cleanup to
security_read_policy() in case some call inside it fails instead of
relying on the caller to properly free the memory. On top of that, this
patch future-proofs both functions by adding local variables and
modifying the pointers only in case of a success.

Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 security/selinux/include/security.h |  4 +--
 security/selinux/selinuxfs.c        |  2 --
 security/selinux/ss/services.c      | 50 +++++++++++++++++++----------
 3 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
index 8746fafeb7789..2990b3d08236d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -213,8 +213,8 @@ int security_load_policy(void *data, size_t len,
 			 struct selinux_load_state *load_state);
 void selinux_policy_commit(struct selinux_load_state *load_state);
 void selinux_policy_cancel(struct selinux_load_state *load_state);
-int security_read_policy(void **data, size_t *len);
-int security_read_state_kernel(void **data, size_t *len);
+int security_read_policy(void **pdata, size_t *plen);
+int security_read_state_kernel(void **pdata, size_t *plen);
 int security_policycap_supported(unsigned int req_cap);
=20
 #define SEL_VEC_MAX 32
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 69a583b91fc57..6d4cd66360739 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -406,8 +406,6 @@ static int sel_open_policy(struct inode *inode, struc=
t file *filp)
 err:
 	mutex_unlock(&selinux_state.policy_mutex);
=20
-	if (plm)
-		vfree(plm->data);
 	kfree(plm);
 	return rc;
 }
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
index f14d1ffe54c5d..f2fd2b6510560 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3941,12 +3941,16 @@ static int __security_read_policy(struct selinux_=
policy *policy,
=20
 /**
  * security_read_policy - read the policy.
- * @data: binary policy data
- * @len: length of data in bytes
+ * @pdata: binary policy data
+ * @plen: length of data in bytes
  *
+ * In case of a failure, the pointers are not modified.
  */
-int security_read_policy(void **data, size_t *len)
+int security_read_policy(void **pdata, size_t *plen)
 {
+	int err;
+	void *data;
+	size_t len;
 	struct selinux_state *state =3D &selinux_state;
 	struct selinux_policy *policy;
=20
@@ -3955,28 +3959,39 @@ int security_read_policy(void **data, size_t *len=
)
 	if (!policy)
 		return -EINVAL;
=20
-	*len =3D policy->policydb.len;
-	*data =3D vmalloc_user(*len);
-	if (!*data)
+	len =3D policy->policydb.len;
+	data =3D vmalloc_user(len);
+	if (!data)
 		return -ENOMEM;
=20
-	return __security_read_policy(policy, *data, len);
+	err =3D __security_read_policy(policy, data, &len);
+	if (err) {
+		vfree(data);
+		return err;
+	}
+	*pdata =3D data;
+	*plen =3D len;
+	return err;
 }
=20
 /**
  * security_read_state_kernel - read the policy.
- * @data: binary policy data
- * @len: length of data in bytes
+ * @pdata: binary policy data
+ * @plen: length of data in bytes
  *
  * Allocates kernel memory for reading SELinux policy.
  * This function is for internal use only and should not
  * be used for returning data to user space.
  *
+ * In case of a failure, the pointers are not modified.
+ *
  * This function must be called with policy_mutex held.
  */
-int security_read_state_kernel(void **data, size_t *len)
+int security_read_state_kernel(void **pdata, size_t *plen)
 {
 	int err;
+	void *data;
+	size_t len;
 	struct selinux_state *state =3D &selinux_state;
 	struct selinux_policy *policy;
=20
@@ -3985,16 +4000,17 @@ int security_read_state_kernel(void **data, size_=
t *len)
 	if (!policy)
 		return -EINVAL;
=20
-	*len =3D policy->policydb.len;
-	*data =3D vmalloc(*len);
-	if (!*data)
+	len =3D policy->policydb.len;
+	data =3D vmalloc(len);
+	if (!data)
 		return -ENOMEM;
=20
-	err =3D __security_read_policy(policy, *data, len);
+	err =3D __security_read_policy(policy, data, &len);
 	if (err) {
-		vfree(*data);
-		*data =3D NULL;
-		*len =3D 0;
+		vfree(data);
+		return err;
 	}
+	*pdata =3D data;
+	*plen =3D len;
 	return err;
 }
--=20
2.39.2

