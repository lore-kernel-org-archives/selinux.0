Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A163C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4DB21874
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sFR9WGQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfH2Xa0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:30:26 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:44838
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728309AbfH2Xa0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121424; bh=EnzNGHlcb8dD+COQswLoSdxn1ohm9DzwqGsef/TOs/k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sFR9WGQgCuaMkXt4aj3ocQjQJ/K8beVcMOJzQgTHlANYlw9TFWdy6RBjqGJuZlcXoEmgdwbX1JBfLi0zYHbsfZYbRp9tpgnRtxWj68oZp8P+NF1rz6/0kB1k70E641LBznfga8yiIhmrjtOqg6nQJ1rp5LSeDhIHWZ+Ku1qNjtFm0cs/FPbvd5q7FhwCIQ+u/Ber145epFkTUcwE/H4OCo8Y6SwIjTa5shVlw4wU2o4s2pPHv5j6Lykp/CLAzWdv6bgp+0n/Jh9Y1hZy/gwVV7ZgtQoig6QkoSuhlvmbZ40oE+KKNbNuhufTIEo8C/MU42G9SbPdkjdx2aY7aiDwiQ==
X-YMail-OSG: zXyIcH4VM1mbyx2rvidqdSrgRkvB9xD4BQbrkhBmIkatyzyP7syxQvM7eIdQymR
 0W1WppExH8Fi336sTAbN.0cEiiLTehqyOtC1xnz.mhYAXvJEnyHEzA5sPdKJq6pGYNijEh3hSv6R
 n699mvmnfeFlklE7gglgrvuLcsO9KCJaGziTbD_SZJQxg8XmpOwwWhGTYaOwYoKfRFpcbGNonXby
 dn3WvdVHitrm4p_PBLYw1_TxmfEvQyq4wc6v9uBf_0iKhWnTaunKfjId1VOSC8WQ.AT4p4ECBj9U
 HmYXi.uCMmMsiP8RJBDH2x.h4HOiKcLzSvdHL.h6qtcw1RaCrGEhT0RfNNPmZ6sFLTzrt7oVyDjD
 .so8XRyG9BXBmRuKsMz7ypP40xj5_0aIexjlH6N.BdtvkvWs07XcVnylkNtU9Au7AZlqnBwTydmn
 kJrNH0Ny9cZwvBmSrJHytOb0ok04dhSj65BnlHab5P4vvlMgbZIWCbL6Ki7nv8khItDVD5lY6NkC
 EO3Ci2RzHwTZ9AzqO.YV04hRzUVhfbE9SxOcWwk1EL0ClS4mAVtDkapruLgIBnQ67XhWkzjRKB0P
 A6kgIHKJGiGooZ7es3JcS.t0DgpJPz7fuH_4dQjldaJsgA6NYVGrremet1WqrsbrFvwQl1x1tlgv
 2LN4TmoaTeUnl77aE5Zpi7Qo5xs_NQoN.TUGC4tj5E8rp4CiL74AhDBBY6rwyFKlQLRgpqjU61Ob
 YRvzxesHc2SjK5J_yQvFFHOLMKW3N953PMhdr4E1aYWvceJiVnw6Kg1TRxS2elRAOvYj9fljwR7j
 T660jMECjbdljqxdNlvm_CocQCCuOAY5LGGe1FqXAkm3agXtnnAsmRJjFiyJcDb9jsxbN7v8Slnd
 x7.5kgoUHQPyjmAhcAtJK0OUdJJitQ6tEclXauAPUIpAhS3hQWKdlQZw0v4h0XuPh8F_QJGo5Tgl
 5Ro_UZbKEOmED5gaYdTu1mpJNdssS4GpIiGz53KqfJ0H9Q1HPJqLbsypmMmbnfe.uyaEehFwdVSY
 tj_xsGR01AVOzcnigDn6zI9Srztz6eyQiWQdGrMatep6vRdMjTFQRIpubDgr3.w9TUrl0Xjs._u8
 7pWzcwaYiwUMwYBgm0YwVLQ7.SrkQwEtfw6R4.dCr03cnhH9dOV8NzGJ3i_pZyqTkrRvaClJmdZU
 KTVcqQRuGjWnyBkdFexJoEUP_lKDjBookYurkVVkPoj3HeOHj33VmZulAOOq_PuJSs3mftkJu0XP
 8n9GlMdIDzB4d8iIOhTfUxXjFdcC0n6NdMl_XgMz96r63XMCmyBFJLpJXgQ6TAsVoBQDFohUyY7q
 IN8eWUjJFxYyjMIo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:30:24 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d0dbf8f29a1f39b20bf1052e42e06980;
          Thu, 29 Aug 2019 23:30:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 27/28] LSM: Add /proc attr entry for full LSM context
Date:   Thu, 29 Aug 2019 16:29:34 -0700
Message-Id: <20190829232935.7099-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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
---
 fs/proc/base.c      |  1 +
 security/security.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7bf70e041315..79600df5f7a2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2619,6 +2619,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 8cb91f33c166..d151ac4a398b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2082,6 +2082,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2099,6 +2103,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
2.20.1

