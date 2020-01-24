Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C0C35242
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 06:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A608E2072C
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 06:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgAXGdq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 01:33:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:52194 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgAXGdq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 24 Jan 2020 01:33:46 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iusW0-0007wV-8G; Fri, 24 Jan 2020 09:32:24 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/1] sel_avc_get_stat_idx should increase position index
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Message-ID: <dc87965f-e3e8-f9d0-ee1f-07ba14ac3575@virtuozzo.com>
Date:   Fri, 24 Jan 2020 09:32:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 security/selinux/selinuxfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ee94fa4..ad5530e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1504,6 +1504,7 @@ static struct avc_cache_stats *sel_avc_get_stat_idx(loff_t *idx)
 		*idx = cpu + 1;
 		return &per_cpu(avc_cache_stats, cpu);
 	}
+	(*idx)++;
 	return NULL;
 }
 
-- 
1.8.3.1

