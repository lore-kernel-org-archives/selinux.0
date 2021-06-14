Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F8C48BE6
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 04:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590A06128E
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 04:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhFNEyb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 00:54:31 -0400
Received: from out203-205-221-164.mail.qq.com ([203.205.221.164]:59423 "EHLO
        out203-205-221-164.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhFNEy3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 00:54:29 -0400
X-Greylist: delayed 1042 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jun 2021 00:54:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1623646343;
        bh=YdeU23glHrYquRVQkrs8atoOD10GFe8sMjqlMjFAijg=;
        h=From:To:Cc:Subject:Date;
        b=HtsKUgLC49G7/fMpXGHNew9fYdTbSTGvAyoQu/9XyAZR1iSv3zAe9wcPQaUko0fL9
         R763sPsewxiEWBttp07T6MJ7izXlWrof6jTKJKIEUuqyziQQpe5c2hGRIMsVRxa4al
         qNiiguHTjsx/nzNIbiwSCvMhvP5OZ/oZaD5YZcLs=
Received: from localhost.localdomain ([240e:390:a39:3df0:9e2:baa9:3614:79fe])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 54B36AD5; Mon, 14 Jun 2021 12:21:11 +0800
X-QQ-mid: xmsmtpt1623644471tej7o5ax0
Message-ID: <tencent_90BF03402499B510C39EB8BC137D04294607@qq.com>
X-QQ-XMAILINFO: MoiCBUY3VLu8YVMkSzWhzwDbNd4pDYind/vBIpHbYAMl4LyLwyi804hpDtaysN
         K55VqHeN6zPc1CTsUvVe/aFius8lW+QLCqLggZlLL+lZW7NYXMNkn5c4nBPJJt3IvMORR/eJ4hFw
         54OmBjSA0HjF8lC2PLVYVSp3DyhTI3OePpjxc514HHIcEtMnp8WUbJvPRc/Spft/e9kBYa8KoRWU
         V4B92KRA+UXvySP0ahLSOZwpXq81IheJn+3YfIsVajV/OJXNOABkGIfOGOuvRU3kp6lPf/LBbZR9
         acOSbhguhFmmHKZexYHUDhbxGagqsGmqvtPp2fjasCMJoddDSmfdlGALvTIHx0GiQVMToYKDEzIM
         10DfX9ee8cYjuOEZT7am7UL1MQ+dAjO2wz9YJh0ZGPMFhaelZPiXLJ3qm6gDLEQJmphDugQLQPkI
         pa+5d+UPFCcoAkcYosTnkkWnZzW3tbvjcswQYfwCp9rx+XTnd9tnPF3PvgWbPCmH3hcqGf7QV5ZN
         PsjJp0O08pNn54d+Yr/Z9wmetE6V9tWARetcuTXvAUALvs3gwTr1suH07vw3am3/ZFfDd3LI3IXt
         BV8GhJNU5gMpl7ZV13+v66opJXnhF/7ngj2X0/ymoTPlqxCUJ95+9p/W62ojy4LzaUSKs/+whRkP
         ROjxKCRiqf6RgTfEXBLfMBFAp5dfZo2hRTWc2a+SwT5wBDokg2SpnM7gBrlx+tXLFxYXg9mpP6Tg
         lMOlHE2vZPOb/rCdJ6E6GPlilMc9tidbxcxMHdBxYg5GBfM84X1jRxihYxCVneBi8dUsuo8JJkdV
         ZddytfElSk+hTXr1fVwTMaaFjfKijgyyCw+0B4h62r3NwRdSwZAXIZ/BzZkVZOKiWk++Rn3tC7ds
         LKhxwVfrD3JbUtUNm+QPSwO8jx4vnJOlIKxdMOiReox3KeOw3pmOcX/eO6ZFsf1QD5Mtc61+UH
From:   HuaxinLu <luhuaxin1@foxmail.com>
To:     selinux@vger.kernel.org
Cc:     HuaxinLu <luhuaxin1@foxmail.com>
Subject: [PATCH] libsemanage: fix use-after-free in parse_module_store()
Date:   Mon, 14 Jun 2021 12:21:26 +0800
X-OQ-MSGID: <20210614042126.2148-1-luhuaxin1@foxmail.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The passing parameter "arg" of parse_module_store will be freed after
calling. A copy of parameter should be used instead of itself.

Signed-off-by: HuaxinLu <luhuaxin1@foxmail.com>
---
 libsemanage/src/conf-parse.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 9bf9364a..eac91344 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -516,12 +516,12 @@ static int parse_module_store(char *arg)
 		char *s;
 		current_conf->store_type = SEMANAGE_CON_POLSERV_REMOTE;
 		if ((s = strchr(arg, ':')) == NULL) {
-			current_conf->store_path = arg;
+			current_conf->store_path = strdup(arg);
 			current_conf->server_port = 4242;
 		} else {
 			char *endptr;
 			*s = '\0';
-			current_conf->store_path = arg;
+			current_conf->store_path = strdup(arg);
 			current_conf->server_port = strtol(s + 1, &endptr, 10);
 			if (*(s + 1) == '\0' || *endptr != '\0') {
 				return -2;
-- 
2.26.0

