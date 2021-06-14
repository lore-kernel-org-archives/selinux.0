Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DEDC48BE8
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 05:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57436613C2
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 05:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNGAQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:00:16 -0400
Received: from m12-11.163.com ([220.181.12.11]:53929 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhFNGAP (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 14 Jun 2021 02:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Z4muL
        ezarglMiLjJt9r3BdHgD6+DPzyRfS2OL+mOkk8=; b=detxw1SsnAQHYgA/85too
        LZ4GZ1rZY4bL2l9hcMLq6X6OMW6I+xjGzkeYbGnj5R72OuoGpe6gq3hrIcSjZ9u3
        DuObgvrKwF1jnzFRMmDO+u6Ry97Vu59KrssXypZ4cDqbWAtPulzaUOrhhpzqorW0
        3+8h8cptBh62y4On1MFcqg=
Received: from localhost.localdomain (unknown [183.159.242.32])
        by smtp7 (Coremail) with SMTP id C8CowAAXrrXs78ZgxD_zhw--.52688S2;
        Mon, 14 Jun 2021 13:58:05 +0800 (CST)
From:   HuaxinLu <luhuaxin95@163.com>
To:     selinux@vger.kernel.org
Cc:     HuaxinLu <luhuaxin95@163.com>
Subject: [PATCH] libsemanage: fix use-after-free in parse_module_store()
Date:   Mon, 14 Jun 2021 13:56:57 +0800
Message-Id: <20210614055657.3121-1-luhuaxin95@163.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAXrrXs78ZgxD_zhw--.52688S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1DWrWfCry7JF13Aw4fXwb_yoWDWrg_W3
        97XrWYqa1Ykayj9r4Y9w1fA3y29a18CF40ya97tFs8Cwn5CrWUCFW8tryrZryxAF98Ca13
        u3yDZrWjqr12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1Hmh7UUUUU==
X-Originating-IP: [183.159.242.32]
X-CM-SenderInfo: 5oxk3t50lqmki6rwjhhfrp/1tbiKRqxpFXl0zAUyAAAsp
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The passing parameter "arg" of parse_module_store will be freed after
calling. A copy of parameter should be used instead of itself.

Signed-off-by: HuaxinLu <luhuaxin95@163.com>
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

