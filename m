Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29197C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 15:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiLPPsp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiLPPs3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 10:48:29 -0500
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Dec 2022 07:48:23 PST
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B65B36A764
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 07:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5U+qu
        ego+lYm+HQrPT63MAHVQYv+jnIoBDH8oCaCcGY=; b=iUnXMDRb3RjRrrJDkBcgt
        c4goUv5vPNN/EKsZs6Gmxgnm7sIGCRC56Eq/Vsnepiox4r7MTQTwna/3FjnphZmh
        DTCPOeronhrY8op4nT/QEhQv8e1uZlMiAelR7FrRuBoCxv6L8mmB/KMpYmVBUZ6p
        WqVZZiorDll0TGsj8+HGV4=
Received: from localhost.localdomain (unknown [113.200.76.118])
        by smtp16 (Coremail) with SMTP id MNxpCgA3P0fKj5xj_Eu3BQ--.6975S2;
        Fri, 16 Dec 2022 23:33:30 +0800 (CST)
From:   zhaoshuang <izhaoshuang@163.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] sepolicy: fix a spelling mistake
Date:   Fri, 16 Dec 2022 23:33:11 +0800
Message-Id: <20221216153311.17638-1-izhaoshuang@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: MNxpCgA3P0fKj5xj_Eu3BQ--.6975S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF15Jw4fZF4UWr18ArW5Wrg_yoW3ZwbEkw
        4vq3ZF9rW5JF18K3WrCa9rJF1Fq3s09F1Fvry3Krn0vrnxtr9akFyDXF18JF42kF4UCrW3
        ZrZ5uF4DAr1YvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUAwIJUUUUU==
X-Originating-IP: [113.200.76.118]
X-CM-SenderInfo: 5l2kt0pvkxt0rj6rljoofrz/xtbB3xLZuGBHNWdkQwAAs+
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: kkz <zhaoshuang@uniontech.com>

Signed-off-by: zhaoshuang <zhaoshuang@uniontech.com>
Signed-off-by: zhaoshuang <izhaoshuang@163.com>
---
 python/sepolicy/sepolicy/templates/script.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/templates/script.py b/python/sepolicy/sepolicy/templates/script.py
index c79738b8..564a6b38 100644
--- a/python/sepolicy/sepolicy/templates/script.py
+++ b/python/sepolicy/sepolicy/templates/script.py
@@ -75,7 +75,7 @@ rpmbuild --define "_sourcedir ${pwd}" --define "_specdir ${pwd}" --define "_buil
 """
 
 manpage="""\
-# Generate a man page off the installed module
+# Generate a man page of the installed module
 sepolicy manpage -p . -d DOMAINTYPE_t
 """
 
-- 
2.20.1

