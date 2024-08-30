Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337818C22
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978157; cv=none; b=T4BlONjG/rxq6cqvVhl9j3wx6wH5+tUUNVjj7ATVwLdFvUbK4eQevrFyocRAAPE2AT6UuFeCIMosDuGh1YsxS9QD7kxKLCeyktDC1tICrXFOUJniTJw1YlWvLZp0XEhk3Os3ONol/B2IAejk17SDfNyFNESQqzgLkU/FidhWNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978157; c=relaxed/simple;
	bh=EZUDxoCQrzm9VGnrEbahDMcaHF1LFwaiWE8p5L/BFNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9jzOA3Mwc2ii39Z6d5YTiBPWAvJNXsvTFv2EbJwaZRBA40+oPebBnYEN6HELJ/m+h7Bu2s2ueu9LWs3y3p4Bog0EcHTdK/NvD3K1aQYN+7e7lVE00x61YZ5BRgYL6ofcGQPlDBsOUk7+p2GzXp3OHZbcIjqMK7CvmVBb5cQOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kpSuxjGu; arc=none smtp.client-ip=66.163.187.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kpSuxjGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978153; bh=XDwO5eCdnCbant6watoaEBsfpZtEzGaW1rexfAGzvhc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kpSuxjGufVDm2nlH9mfpDR76l1bn4s97+1CavGyNyUWJTo0cWwxYvXppEMetULtWyU1TKNr+QeZpGHa+Ie/hMZNXAlWtihGmF7FSfSRgFkTPM5dtcPXBc7TV/vnegNVxpMREXKrPlspUxWoHExBdGLKhSXpIFjRLxY0+l+PJj4ozf/a0gwCwIN9ZNdiAY8AebWqaerJkC9OVDNKTku6UaRhhA7qHyAd1iuWdNJjZnp7zUH3SR0qE/W94cs+Qp7ZiMWIwvBgIJUt4PtYnjcKZcrpf/2htjGdO7/1+44D0I3ejhbKmPpA/gGOYP0M9J/w5vuwbHYEk9ASdWyhuuD2viw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978153; bh=XkmAKqfT6XlDHHBGB7EKonHSrSOEmhbhalOzo7dN/GT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AKso5P3wwsoK3w582ei1G9jdvdcIduQ40HToFFbKHS9xpKw1IKW0oYJYJA95C6AwokzfJYhDvGAz4CE5Be0QldZ1wgxM3Vej+lrlZ4+WhVzpoR8qTEIfA3taHFeWbXl9svyU5Z0nqCS5O04QXOt1y6PmEBiBf6Ne24fCwbgqjpM/WmSGmEMOEXF8YOHx6fhn+y/S6kcvvU7No2Ck0+2/bZvQ/pWm5LiafYDQ3R4A6LKP/zVVlF/gK3BD59miGGrxfR7MYFOtEkLS441RvvfibTRrolMcq8JkmDxdCa8w46BfgszL1g8+sWOlelKkqNf/zZAGIoovvJF6TXLNGCBoDQ==
X-YMail-OSG: C4CLAycVM1kdywleGFVQP42Baxlbobp9SomyIYcSvc8GxCfSUla9fQOYiX9D0Qk
 _a9l0OnUU0DZwQVfME_yfwu9sH_QCGm1BAYcofcqNs1b76Hcix8ZvZCehbcsW7Cwl4XOYeirvYlk
 fqiFg8x0g4WlDpOHkutG5qN0uJ0Koj_uuXbOrmR4JHYz8.UoIfqC_N7u9d1USuDB0dyrvc7LILO_
 Jpo_wo9yGAWkiry2BdvkWW45bNcaIM6ucSQDmZHpxFsbGBkHWOL5ogjgbAm.PeP7zW5yx5oQID1s
 gNzr4QIKNSQfQjj8pWscRSOQFZEsvYaR_uv8ZwOKJ5msIO8BelfDfAHavCyhbqXKInRFcu_nGKx0
 j67uALZmap0WNRx.gRfDl8.Q6sQTNVCalzX4acVtYVeP2eU4vrrxXrrtcOTeBxuaw83U6T2yBTti
 otr_rnFJd.BcTlpLfcUMlS_A3N84AA40fxEZaN.ibsCwj7cyYFtIU7wy6ZJMZH.c9ZKp6XcahFkI
 oPxZtukq8D8ol5x0yDxXKRKbdAvBrtB9AYctnVTtHX7_Gxdomwjn5Hi0OHadUqBS7bZNEc_LDr2Z
 5Js9pWazH0oJT250lTAPIefZA9JJeIsilzQ3a.heUg1mrsfBdMSUTgnYHzydNSFLfMfFtoiPiXpq
 TPAm9tOPkoOsPn4fFRYLlPhmg4qpsEemk.QjoFrZzFGsdgpC8i7KWWRY9sqDVxr5Mopr8Opc03RP
 6bwL8bK_oWgaTagamZb32O4CaldYNoXcPEMwSoTNu9vF9iNM8SmhuZmLqv1dlp_PVoZizqW6mNzl
 TogJAAnjtouuSIZA2rnR0hL4r.064c73krDH0Jpe3lE255hAeH1fHIkxP4XwbqpSRT3QtFxUDTNl
 Vr5SIG.e_ZK8Ju33H5vHXBtjTtmQwJMVHHx.x1TiXueP3QSaUhlBXwJG0ZWx07l7hwm1wzA1Mgy.
 ud2X6taKxqTUl3YxAiOjhqJnIwq_43_MRyXOYKE.e27hjkmaNy9b_tg7tFIi6LaJEQnnX5RdWac4
 D_bAKssTSoRbMAgMyUouO01hdBkhTZneFTdSF6v1hyAwl7YYkVzKz53ZIfEfcpXbeO8nSZLP2w18
 m.HSjmgYpMK92qv0hvVPQVhXnIM86EQvt9yp2YoK14Ub0eDSJ6igif87AZ9VzXFIlAFwDR0StIdT
 7rf2Ah2OIyZbQHy3abhtn3tN5KFMLSzfag6wm0NVimoD3fykBYUEZHSEkIEz1wMTfJmZdlT_EwFW
 pjNCotQPNSG2flDekTDN6QEgYMhxOcH5pXoQX.OObqVZ6a9jXLXCfvCwuC3BWkOJYV8G0p21Pg1.
 ob1TCbJdCh3x5fEIZLWvhfCeae5LuD97RCgGl0d2BWK8XDCBYtyAW2xCdTmtl86XT.lPbmKRy3tY
 wMjozufnA_V5d9BDhvsBL9v5i6ny2ajtUd0xaJToIlDBJ1.P.wPu41nEvz1ERuaQ0q6Ahvu9KAku
 VUb66r5_CiHGL7w1aQ_gfvQk9_k5KXkSlUgQWTzIy.Utgp4oRU9v7JM9_B7t4vlBRpAQ3BPQ60JT
 evIXxv2_xMUcRqMrjtkvbr4RAiGxuRHipEj9fiRxPwQErfOcMrSdLClxkgbMlVMp_fKhqjnKSBoN
 0Qo4tT30OD4zVae3H83afqRhFR0QVQCyyl8jhdWmg4ym3.hweAJ.LqWB0T7p_chsusn.FtX7YIvs
 zZgGpEMCE5O5.HLwL7o3zB.AlqCtsmSd1PkGeyDhrcGNzQa9gO0anTH5i1gjk6WER8cWQF1OGLIP
 5EovHKTPjeaXPPDwAReGHlfdvfZkxldGJ3RIa57qQaIDLKH5rvjy7Kih3o0Bce7Yqf1K6CPfy2AF
 FsZIdDyeZS7_4lvnKDnWwquZFr.d4KDfEAU5oUtGiOqCyKjbj3HWDrSI_Nc2UfOzI_ceg.25CB.i
 AR15qF156zTs95w6cymTVxkIO0e.erRFM8NEEuaj2oZEv2PwQVJrpEbctc0oHKaHPk3kNFTlyZrp
 O1GhugPTyD.3dvHsggCls2HfQ6cryV0MtyJshZVcXw6sR5krS2NU36eCbbrrlidpJiXJR1BSZaGK
 3s.WKCm4LIWsWsoRvuzIO7oc8kFNs2lD6qh4Magry9lA4lPMihWyPmJQwp4iRanOzCUdddCo7VLL
 8eZNNJYpOd.CTe2zQ7zP89zflwYt3UsBxFk5kwXYiCOmei217f._WE61VgmqVtzp8CTzL6oUR9oK
 mdr5QSXkg1QFOTmYCwu4tf1HZRJTCuRubB.HuDs0Qm_SPIFecvVuWupvJGngXI7.Ifp1wWIfWMBn
 EhAVop95UxSLnmAqHyuZBY426JdpCpT8Pnuw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1a08c073-917d-4015-abff-2c1f0f4a5b6c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:35:53 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dffbd785ee8ecfc4db9f25ae20a43d90;
          Fri, 30 Aug 2024 00:35:51 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v2 03/13] LSM: Add lsmblob_to_secctx hook
Date: Thu, 29 Aug 2024 17:34:01 -0700
Message-ID: <20240830003411.16818-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new hook security_lsmblob_to_secctx() and its LSM specific
implementations. The LSM specific code will use the lsmblob element
allocated for that module. This allows for the possibility that more
than one module may be called upon to translate a secid to a string,
as can occur in the audit code.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  2 ++
 include/linux/security.h          | 11 ++++++++++-
 security/apparmor/include/secid.h |  2 ++
 security/apparmor/lsm.c           |  1 +
 security/apparmor/secid.c         | 25 +++++++++++++++++++++++--
 security/security.c               | 30 ++++++++++++++++++++++++++++++
 security/selinux/hooks.c          | 16 ++++++++++++++--
 security/smack/smack_lsm.c        | 31 ++++++++++++++++++++++++++-----
 8 files changed, 108 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 1d3bdf71109e..3e5f6baa7b9f 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -291,6 +291,8 @@ LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
 LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
 	 u32 *seclen)
+LSM_HOOK(int, -EOPNOTSUPP, lsmblob_to_secctx, struct lsmblob *blob,
+	 char **secdata, u32 *seclen)
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
diff --git a/include/linux/security.h b/include/linux/security.h
index c0ed2119a622..457fafc32fb0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -520,6 +520,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1461,7 +1463,14 @@ static inline int security_ismaclabel(const char *name)
 	return 0;
 }
 
-static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static inline int security_secid_to_secctx(u32 secid, char **secdata,
+					   u32 *seclen)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int security_lsmblob_to_secctx(struct lsmblob *blob,
+					     char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/apparmor/include/secid.h b/security/apparmor/include/secid.h
index a912a5d5d04f..816a425e2023 100644
--- a/security/apparmor/include/secid.h
+++ b/security/apparmor/include/secid.h
@@ -26,6 +26,8 @@ extern int apparmor_display_secid_mode;
 
 struct aa_label *aa_secid_to_label(u32 secid);
 int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen);
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void apparmor_release_secctx(char *secdata, u32 seclen);
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 808060f9effb..050d103f5ca5 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1532,6 +1532,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 #endif
 
 	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, apparmor_lsmblob_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
 	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
 
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 83d3d1e6d9dc..7ba48d0b3ee8 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -61,10 +61,10 @@ struct aa_label *aa_secid_to_label(u32 secid)
 	return xa_load(&aa_secids, secid);
 }
 
-int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+static int apparmor_label_to_secctx(struct aa_label *label, char **secdata,
+				    u32 *seclen)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
-	struct aa_label *label = aa_secid_to_label(secid);
 	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED | FLAG_ABS_ROOT;
 	int len;
 
@@ -90,6 +90,27 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+{
+	struct aa_label *label = aa_secid_to_label(secid);
+
+	return apparmor_label_to_secctx(label, secdata, seclen);
+}
+
+int apparmor_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen)
+{
+	struct aa_label *label;
+
+	/* scaffolding */
+	if (!blob->apparmor.label && blob->scaffold.secid)
+		label = aa_secid_to_label(blob->scaffold.secid);
+	else
+		label = blob->apparmor.label;
+
+	return apparmor_label_to_secctx(label, secdata, seclen);
+}
+
 int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	struct aa_label *label;
diff --git a/security/security.c b/security/security.c
index 64a6d6bbd1f4..bb541a3be410 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4192,6 +4192,36 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
+/**
+ * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
+ * @blob: lsm specific information
+ * @secdata: secctx
+ * @seclen: secctx length
+ *
+ * Convert a @blob entry to security context.  If @secdata is NULL the
+ * length of the result will be returned in @seclen, but no @secdata
+ * will be returned.  This does mean that the length could change between
+ * calls to check the length and the next call which actually allocates
+ * and returns the @secdata.
+ *
+ * Return: Return 0 on success, error on failure.
+ */
+int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+			       u32 *seclen)
+{
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
+		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
+			return rc;
+	}
+
+	return LSM_RET_DEFAULT(secid_to_secctx);
+}
+EXPORT_SYMBOL(security_lsmblob_to_secctx);
+
 /**
  * security_secctx_to_secid() - Convert a secctx to a secid
  * @secdata: secctx
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..102489e6d579 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name)
 
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_sid_to_context(secid,
-				       secdata, seclen);
+	return security_sid_to_context(secid, secdata, seclen);
+}
+
+static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+				     u32 *seclen)
+{
+	u32 secid = blob->selinux.secid;
+
+	/* scaffolding */
+	if (!secid)
+		secid = blob->scaffold.secid;
+
+	return security_sid_to_context(secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
@@ -7388,6 +7399,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, selinux_lsmblob_to_secctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 	LSM_HOOK_INIT(sk_alloc_security, selinux_sk_alloc_security),
 	LSM_HOOK_INIT(tun_dev_alloc_security, selinux_tun_dev_alloc_security),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 52d5ef986db8..5d74d8590862 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4787,7 +4787,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 				  void *vrule)
 {
-	struct smack_known *skp;
+	struct smack_known *skp = blob->smack.skp;
 	char *rule = vrule;
 
 	if (unlikely(!rule)) {
@@ -4799,10 +4799,8 @@ static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
 		return 0;
 
 	/* scaffolding */
-	if (!blob->smack.skp && blob->scaffold.secid)
+	if (!skp && blob->scaffold.secid)
 		skp = smack_from_secid(blob->scaffold.secid);
-	else
-		skp = blob->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
@@ -4833,7 +4831,6 @@ static int smack_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
 }
 
-
 /**
  * smack_secid_to_secctx - return the smack label for a secid
  * @secid: incoming integer
@@ -4852,6 +4849,29 @@ static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 	return 0;
 }
 
+/**
+ * smack_lsmblob_to_secctx - return the smack label
+ * @blob: includes incoming Smack data
+ * @secdata: destination
+ * @seclen: how long it is
+ *
+ * Exists for audit code.
+ */
+static int smack_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
+				   u32 *seclen)
+{
+	struct smack_known *skp = blob->smack.skp;
+
+	/* scaffolding */
+	if (!skp && blob->scaffold.secid)
+		skp = smack_from_secid(blob->scaffold.secid);
+
+	if (secdata)
+		*secdata = skp->smk_known;
+	*seclen = strlen(skp->smk_known);
+	return 0;
+}
+
 /**
  * smack_secctx_to_secid - return the secid for a smack label
  * @secdata: smack label
@@ -5208,6 +5228,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
+	LSM_HOOK_INIT(lsmblob_to_secctx, smack_lsmblob_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
-- 
2.46.0

