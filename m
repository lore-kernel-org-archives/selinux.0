Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2913C761A8
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A825F21994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QV9f3sZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfGZXkF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:40:05 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:44743
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728080AbfGZXkE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184403; bh=k9N3chrEZiO+tPYw01Y1AA3KVSgvFnK+7jxWKSFUapg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QV9f3sZa/b/6UNo2wfj5ZUHu6+Y9xZMVRBr4Wsg4Y80oX3i3uvZ72x1AweL6n6uXtA3eLQYT8hp8JfSKz4lEc9/rZczeV+jHserd/4oQe0KDNnZbt9OZxb9GlytLMPiJKPwtXPKPKBE5Fb6OCpy25/ziYRsfAUmj4cG5uos7mRNzoyDYqHFebzBwvpn4LKyG0JKqC+5p1/f1Nln//KUSmvRuhO5lYNwoC5QxelPvNHijleOy62A0fkKf+aWZRScMOJOnEo98rGUes/pVXcd1/Zj8kp7joLBg4GKGovSsbyGaykR65Npn0QQti8GmTOBVFZjx130mmkf8yU2ZSBO/9w==
X-YMail-OSG: oKcsqNwVM1n6kNw.Km9cG9dTe1kQzFvVD0pcZko_3uP0kKIYqM9ptHBmumtRn7x
 bYYVP7_wFbj3Lvkfp9FSoj84SOWL4iI0P6UGeb_gmeNILPChQcsoVsDKGIOJC4nLqqebp7GmeaMz
 7zk.dEEgLBtnOtHgdYyDzzaf3i.Ko72l0GzXcHhEUcNvxF37oy4Ud56t_KVm.j9LqXiVNqpbBV51
 kCpjJGQ6YpYFcenQrn8c7XHQgwDRU_7B__VQvRLuQNaksPiugsWcDeidUTTiLOC74471yBDeeSWP
 t9mYOfi3h9vXVk67l9W_2div9Km.z4SmL_ycc3GXqzZXG54wfB2O5N8vA3P7Zm_KXxiijREW9BiT
 A2.x_MJyjVNo5oOt_AdNw_GsRzKGd8E_jWLo35BAr6ra6Y0BZcSb4nQZXb8pcoFsv5z00Jnk.kKm
 pUc.8nwn39LZSX2dmTx_sLW0NCn.4D5UvnRNaiSd2zOvqKGpQyRhz98aGQWaWKXCrc2DY0UbDh8O
 TBQV.YnOyoTTTd.3.6wj7xPesRFL3Be5ru48dDBEiMJXuZWJ_f4UqzQYj9U2lJpmP8NuEnAaAPIB
 50xKMGoQSv_0zRyCsZu14sm3bWVFIz_7CnAGip3FVKwYerolxJoRvAP.6UPNOVQFBOcAuveKq.Xa
 WZ2uJPmhP39dqMyveu87iwwkAzUxWenxg9Leg9n5IplltOX1rqN506XcMxQh1oNJOfs5tdIeU0Hj
 87ryN2b.PYwGPo_ILC5Ngfb1c0FibWtHGYd96dMYMmaBDn4dqTrXz4kiU5EeC4PGtgW3MUEZ4Tt0
 mF30qMKUPrQObmdYezMBQp35UgEC7KBVcmJFonGlk7auRJY2XuVmLEoF93rmbI6XycqUd7_CLZKB
 BlSWQVs8j6nxjYOD.OExwMGQ.E4fCSmQFY1vAXP1S.NH0PVMMx4aH2SPEcDPyUh5H5TlvfcSP8.o
 s7ATUJ2XCopTTqZBGqLFWVXZAVspD82.b.VyH6Owj4e.rquxJIAJVCccpQHDF5cBH_RQAcwF.atb
 BgPxUSkMA9SRBNedRBrzuXZw1KLZiL7rIjB7geLHKkcG55UyE.xI55E6YU52tgeNN9aGVJlNOdfy
 6UM.c4cO86yNF.wrCFPuGfYNO4AeMR35AjGRz9.NLqH5CPT1R0DbsYXMNKJJbLZ3LnYCAFilVgaq
 Wu0TR68cOON62B.D3SUOEo14kmbX1fdwZvQBEWeXjQTo9WOIyb69UFBGKGZhkWn0vZ8FoYmtVKBj
 _sJ64bUQ172Vs_hjWXkGMO9OZgbIrfnL2RZq2wtlpKgKW8ZvQE4gnxA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:40:03 +0000
Received: by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 18e1fd6e499df9a683528f197f9ab77d;
          Fri, 26 Jul 2019 23:40:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 24/27] LSM: Provide an user space interface for the default display
Date:   Fri, 26 Jul 2019 16:39:20 -0700
Message-Id: <20190726233923.2570-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create /sys/kernel/security/lsm_display_default which contains
the name of the security module used when no display value
has been set.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/inode.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index b7772a9b315e..538a4d6796da 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -321,6 +321,22 @@ static const struct file_operations lsm_ops = {
 	.read = lsm_read,
 	.llseek = generic_file_llseek,
 };
+
+static struct dentry *lsm_display_default_dentry;
+static ssize_t lsm_display_default_read(struct file *filp, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	const char *name = security_lsm_slot_name(0);
+
+	if (name == NULL)
+		return 0;
+	return simple_read_from_buffer(buf, count, ppos, name, strlen(name));
+}
+
+static const struct file_operations lsm_display_default_ops = {
+	.read = lsm_display_default_read,
+	.llseek = generic_file_llseek,
+};
 #endif
 
 static int __init securityfs_init(void)
@@ -337,8 +353,10 @@ static int __init securityfs_init(void)
 		return retval;
 	}
 #ifdef CONFIG_SECURITY
-	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL,
-						&lsm_ops);
+	lsm_dentry = securityfs_create_file("lsm", 0444, NULL, NULL, &lsm_ops);
+	lsm_display_default_dentry = securityfs_create_file(
+					"lsm_display_default", 0444, NULL,
+					NULL, &lsm_display_default_ops);
 #endif
 	return 0;
 }
-- 
2.20.1

