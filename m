Return-Path: <SRS0=plOs=3V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E414C33C9E
	for <selinux@archiver.kernel.org>; Sat,  1 Feb 2020 07:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E006206D3
	for <selinux@archiver.kernel.org>; Sat,  1 Feb 2020 07:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgBAHtW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:49:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:55308 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgBAHtW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 1 Feb 2020 02:49:22 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ixnVM-000678-EE; Sat, 01 Feb 2020 10:47:48 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] selinux: sel_avc_get_stat_idx should increase position
 index
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
References: <CAHC9VhR3oV=d7S+PELcCg+Qt7hjV_GJYGmqMdCNvsxAWCJYfHA@mail.gmail.com>
Message-ID: <441c893b-5cfa-1675-c568-2c04b3bb841a@virtuozzo.com>
Date:   Sat, 1 Feb 2020 10:47:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR3oV=d7S+PELcCg+Qt7hjV_GJYGmqMdCNvsxAWCJYfHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If seq_file .next function does not change position index,
read after some lseek can generate unexpected output.

$ dd if=/sys/fs/selinux/avc/cache_stats # usual output
lookups hits misses allocations reclaims frees
817223 810034 7189 7189 6992 7037
1934894 1926896 7998 7998 7632 7683
1322812 1317176 5636 5636 5456 5507
1560571 1551548 9023 9023 9056 9115
0+1 records in
0+1 records out
189 bytes copied, 5,1564e-05 s, 3,7 MB/s

$# read after lseek to midle of last line
$ dd if=/sys/fs/selinux/avc/cache_stats bs=180 skip=1
dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
056 9115   <<<< end of last line
1560571 1551548 9023 9023 9056 9115  <<< whole last line once again
0+1 records in
0+1 records out
45 bytes copied, 8,7221e-05 s, 516 kB/s

$# read after lseek beyond  end of of file
$ dd if=/sys/fs/selinux/avc/cache_stats bs=1000 skip=1
dd: /sys/fs/selinux/avc/cache_stats: cannot skip to specified offset
1560571 1551548 9023 9023 9056 9115  <<<< generates whole last line
0+1 records in
0+1 records out
36 bytes copied, 9,0934e-05 s, 396 kB/s

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

