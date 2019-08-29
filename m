Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6DC3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248142173E
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fHVydRV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfH2XaX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:30:23 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:40981
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbfH2XaX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121422; bh=k9N3chrEZiO+tPYw01Y1AA3KVSgvFnK+7jxWKSFUapg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fHVydRV2VNy+v91wJCvWJuLoXOsHWDEP7xbVgY1/ixWovAHlaSq72QERaa+gJKzRjAhIcCE7yzBfGGSiyG/8j4ua2KTYZFWHLZdhpArrhmv/2vWtVoam6bKs9HO3gYE9b/YUNd7Mqo8FCJrC3jGkYLn9BDOtS/HIRdSOub4R83Kp7zfdLsF+07lfaQt3f5wTW0P74FQ7MMcvpdORrZlB9ZOlLTlHSAXpuOBqvTxc6EUvm1DKsZXC/1qOKGeVIKHv6m6ocHe7A06tL5uuMxcfwxv8J9iSkzG2x/xicCFDtWWN/72Uc4vmOMKDHxTvfncD6cHRya6UXgao3Fs61IuGtg==
X-YMail-OSG: .kH9KnYVM1kLaOSw89s.zr8K8GC9mJqjhBi_ckPK7oPcyFeO0oF94f9EoTNMFVZ
 80KxYv4Fpgol4AIrowdnmz7TV_UWd0q9PHnPBRgx4DN79TudJb5FUc2wVv4UZO4tsnsJTRIwRdhg
 E37DTkvunuSDZhwInadEC6xFtGf1Yy1KSe7iRiPXQXNLBR4lqoqLgWPnL.Gy1S1YV6x2rJ4.d7go
 3F0gLllFZx1jEzVKQKunPnh8bn870T2Aidlvanfk1zQrM86UjDOyRg5UGcnXhJ991uGKlW7_3DDx
 R10ymCURjsey3FoR0xgQ_LSAwXM56J6nhoVSr.f8479dwqHPrEi2PB4s8ySd0Roc4lMMAzlfk79c
 Q_phi5B3qr7LHYxcoD7zw.UrVFcpz2K3SkTfyEtlTrAM5VyplfrhUbXsa1E69dVuTENeg22GknRY
 aJ5GJF1c5AqmzzLNJX7WBt2SNW47bmf0GP6zyzfOOgy0AooVhqOOD.iYi1UMANlSFIZ7uYGEW7XJ
 s7HR8C1rOXfqERHZzr1Xxn8I2Xse.Pa_0tXKJw_46pw_7pr6WuxYdgFLGf3jQqv17K1Vi44YLLgh
 TTq2jPlRuOYK9gQ0_mfVPeOKCaU.MEejg2LMYBk8LCmOnJHVmdh44qUYST_lVzJ8T2tIJyVNDRjG
 Gud_E0TqXCYDGk2NISU9oxk4cDOR1KinAHXt8i7D9byL002DgdqeH7.KYx.cYBWD2lluQZhWbDuB
 5moE4YsgC3l9815sf1.vvNyayV29E4wMcljV6UT8BBnLzoUdscbzU0hEHpsqx2d8DaCpOgRv3g6j
 90KVPJesdlsPR6WDb1vs1gHehQZOcYG0NkvNA5MEZmC8SGrTsOvk6S4Ed5MuFU0YqGXL6YyqWjUl
 Hs9EhPEFEl5u3UORTR2VOdVHQMCrT9bwG6ZygIlC7pTIlyImenlbPlhL8CBmr2XNwVwKWJZwHGO6
 PFVLJBySLIc6YMOVXBPWWcITCc6OD._k0knO2LJInjNOH6xoohAY3TcMcC2wmaQ_Rtk5xtg99ZMh
 8HlqsW6TANdV1nRfCx8w4SRVOqKw9u7GhYxPbJbUJMYjd8em352p6GmiovXhLEjgZguxqQvrFoFr
 364CRUFYlEvO6Tq_XqtKSjfrHtMRMpO7iOoPIospLQ5KL1PXA4vsgErgQl3eZe5Dpnr316ejq8qK
 A42vdidce_HoJ9vOS9gH2Gvn6SRmSn5JMYXOAVWREyfdaFM32htnaXT321_2LwESC90AzfTh6rlL
 RpATQ22ZfH3eMJGd8buK.vYjqVKlG77ClxvtzVP153UojoSdS8GYNP02QXY2d8XJm2QsVFqceW6Y
 fbMvHWHzUpCwUvnpq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:30:22 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d0dbf8f29a1f39b20bf1052e42e06980;
          Thu, 29 Aug 2019 23:30:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 25/28] LSM: Provide an user space interface for the default display
Date:   Thu, 29 Aug 2019 16:29:32 -0700
Message-Id: <20190829232935.7099-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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

