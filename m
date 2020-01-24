Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D950EC35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D17C2087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="P5gA6Ncr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgAXA07 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:26:59 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:32963
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730121AbgAXA06 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825617; bh=tMXm8ybkTZ71dZq9bLVqDynXKZXLUzbMoItH+eZdOgc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=P5gA6NcrUTf7gxjW7G9WefIUDdVLc+GG6905sp3CLPCNc8fUw3fXSxa8HNkYLSPuDflrh9oQzvT7Brhh00lK8n0n10d0atzjrz5ldDTbUgcefetG/rQCmqgwbJaejjHCM8txGELESnX/7PWlu+MQ9Qk8WNsRPr4/Nk3SV8LXn7W76VcEjSymSSayBGZfDeT5QxOq14zWtVSdUQAZdm8kHrNEnh+OGcHYxN6zTA7kqW56FFQrjNL2CQ2EE1k8g9nIkF4TTKQArarr8MNm4//R6k1/7hIh+jsPQWA9hw0JynKr4skTTW+coVhtiZCeiTZcZS7fVHnZVIa8i265tvL+Nw==
X-YMail-OSG: K8QKojcVM1mahkppC8KlUOE1nMqQ_SkLzwruEEinvZZO9mJgjhITjsMvNLv1PHe
 g6u6eQkVeT94pCHzGN8yDxodWyAjEl5UORGoptu7c6VhtLFLjkp80Kim52RMwNwcRfiu85XfTiJB
 EzxZ7MqWaKDNd_4unyhxWtTWYw2ItlWVmianzQB61KFpJPKNtnvuK1FsnlB2E4lWYVbS2Rb8IBo0
 BzwVbBIlrRSLv4Avi8T0LM0GxhHR5zKWps7Y5AS_XdD.UjOnKsNmN6q15IoGZ5BgDC3Fw7FFmx_v
 z3xsQn2U_UpZhnc4aqJRYAM09OqsmAgZDhoFThVi4qDKkz3gRXR5CABf378LLoZRjkOcpJ8MTwqb
 sixIusx.jKgF8FNlxd.10aEIreDEn1JXfFMiHJS6rqchI7uYX_4PYRJL2mBwN0j46itEMGMdtA8r
 dvuFns8TXdTwEm5En7_PBi046oPmNgK.wHtHOeuaDPy2jQK8Rw43LwSsWZNzNex6R3qPsVy8Ip.a
 lwm6cuG7oXRQ5Fe0S1z1DHKf_0x0ia7F4dXXknbO1CN6rQL6mHc9T0GTYrhnqLKGw_OuHxkXKkrw
 fJhlYVQh7BUEWKFqTdQLWrU61_AiyInUBmxq3qORbka8D0T8FKWE5_iXmcYMqeCY8bMzBdReqrkb
 h3YaiYXL3tz5v8JLIddoDQDfddNXpWCoGdqBOwrxoyOB7WKVpQmYaNIvvED8XeLwVBnYWHNsZicN
 6Pcy2fvoQQ5dcf6kg_HTTguljBsSIg4hD4Fg4BHP_2UDMo3ekqJil6NgYzIfPOBYCi8aaZjl2PQw
 0J9WmbWfaEkKK5XbLW5S4DmnKfcVnw9mI49R.xdK3syXbA5437g2s0jktk9QdBUw52rjsu_wpEWV
 TpufMOKSpJILQgus8iNsmON5OcFm0.yKA1gcmi0t2pIQcm_vRxLbgT8efb7.fUYrzj4r8uCTFmbw
 NN0N4jinGGs6hxCIxRHIxl5vJlK3hFp8sckm2SsHFTZXGC7EiIqjsmIUEwbgxsSJ1dVGxNYdRtum
 8xplEKunqkzdwrXJUjKnOTW5s4xANNxakQiX1JyrVTIJ9i_fCgdeXmJs9cDEr1sKMOBBG31zOOlD
 hkVEpq0wTBCi8kGbceleTjO6RIVa93eoRCX.im4hhqpmaI8z8ZughcRteB_qt0SwtyLq2XajM38y
 K_t22V_RKRybottMMiVY.R96xsgsDul2N0uusWxJUDVN.78K6NSUFt_fsb4NQAY4SY45CpFZZDjZ
 g_N_bGLqb7jPwFI04W_VGTRzR37ve6sJ5D1tP_cJ4y28ygROVP72Anu8EeOp6rvG2Ql9e92NGTTf
 CgggAezBKmWfqI3DWXwWJeIOKwM1nKkuCsQMctAzdg40BxqCREIAxMJ6kwBODKaq.GlbuzzNeIq9
 cnccCkvuhcgnglxr4gD_XcHCOAX0r3f.h7thaYtrEs9iBirGORDJ0PkZHHIT4ZRWd1wH0Sw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:26:57 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 50be027cdc8c4f0f0d7e06f64510609a;
          Fri, 24 Jan 2020 00:26:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
Date:   Thu, 23 Jan 2020 16:23:05 -0800
Message-Id: <20200124002306.3552-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:'
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
---
 Documentation/security/lsm.rst | 14 ++++++++
 fs/proc/base.c                 |  1 +
 security/security.c            | 63 ++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index aadf47c808c0..a4979060f5d3 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -199,3 +199,17 @@ capability-related fields:
 -  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
 
 -  ``fs/proc/array.c``::c:func:`task_cap()`
+
+LSM External Interfaces
+=======================
+
+The LSM infrastructure does not generally provide external interfaces.
+The individual security modules provide what external interfaces they
+require. The infrastructure does provide an interface for the special
+case where multiple security modules provide a process context. This
+is provided in compound context format.
+
+-  `lsm1\0value\0lsm2\0value\0`
+
+The special file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 950c200cb9ad..d13c2cf50e4b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 6a77c8b2ffbc..fdd0c85df89e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -722,6 +722,42 @@ static void __init lsm_early_task(struct task_struct *task)
 		panic("%s: Early task alloc failed.\n", __func__);
 }
 
+/**
+ * append_ctx - append a lsm/context pair to a compound context
+ * @ctx: the existing compound context
+ * @ctxlen: size of the old context, including terminating nul byte
+ * @lsm: new lsm name, nul terminated
+ * @new: new context, possibly nul terminated
+ * @newlen: maximum size of @new
+ *
+ * replace @ctx with a new compound context, appending @newlsm and @new
+ * to @ctx. On exit the new data replaces the old, which is freed.
+ * @ctxlen is set to the new size, which includes a trailing nul byte.
+ *
+ * Returns 0 on success, -ENOMEM if no memory is available.
+ */
+static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
+		      int newlen)
+{
+	char *final;
+	int llen;
+
+	llen = strlen(lsm) + 1;
+	newlen = strnlen(new, newlen) + 1;
+
+	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
+	if (final == NULL)
+		return -ENOMEM;
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, newlen);
+	kfree(*ctx);
+	*ctx = final;
+	*ctxlen = *ctxlen + llen + newlen;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -2041,6 +2077,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2068,6 +2108,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "current", &cp);
+			if (rc == -EINVAL || rc == -ENOPROTOOPT)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
-- 
2.24.1

