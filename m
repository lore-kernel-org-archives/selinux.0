Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC94C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 15:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLPP16 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLPP1z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 10:27:55 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EB8E554DB
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 07:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5U+qu
        ego+lYm+HQrPT63MAHVQYv+jnIoBDH8oCaCcGY=; b=WGPNzVwuAIP8sOIKsJBmU
        R5sIl1Vn64JQvnxpPXe7EfEcS/hCV4HaXe1mXkyy2vK0NFAm+BopWEu2JhAj/q+x
        jUoj52j9eP8kCgDtuKoXtPVUj/xGS10+8sGI15ktAsH1ZmvWr+On7Cns4rGDWs5P
        yMdmrCiNkhFb2x/5y44YUM=
Received: from localhost.localdomain (unknown [113.200.76.118])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wB3BudqjpxjtU2OAA--.19626S2;
        Fri, 16 Dec 2022 23:27:39 +0800 (CST)
From:   zhaoshuang <izhaoshuang@163.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] sepolicy: fix a spelling mistake
Date:   Fri, 16 Dec 2022 23:27:38 +0800
Message-Id: <20221216152738.16743-1-izhaoshuang@163.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <[PATCH] sepolicy: fix a spelling mistake>
References: <[PATCH] sepolicy: fix a spelling mistake>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3BudqjpxjtU2OAA--.19626S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF15Jw4fZF4UWr18ArW5Wrg_yoW3ZwbEkw
        4vq3ZF9rW5JF18K3WrCa9rJF1Fq3s09F1Fvry3Krn0vrnxtr9akFyDXF18JF42kF4UCrW3
        ZrZ5uF4DAr1YvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUtkuDUUUUU==
X-Originating-IP: [113.200.76.118]
X-CM-SenderInfo: 5l2kt0pvkxt0rj6rljoofrz/1tbiSgnZuGI0WBnsdgABsu
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

