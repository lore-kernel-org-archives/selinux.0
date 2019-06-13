Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD9FC31E45
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5833C20679
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="h/QxzUGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfFMP75 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:59:57 -0400
Received: from 48.23.240.77.static.louhi.net ([77.240.23.48]:37850 "EHLO
        kolttonen.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbfFMP7k (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 13 Jun 2019 11:59:40 -0400
Received: from 34-41-5D-CA-59-C7 (82-203-159-32.bb.dnainternet.fi [82.203.159.32])
        (authenticated bits=0)
        by vcust561.louhi.net (8.14.7/8.14.7/0) with ESMTP id x5DFx35q030732
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 18:59:04 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 vcust561.louhi.net x5DFx35q030732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolttonen.fi;
        s=mail; t=1560441544;
        bh=6cr3IMvqiRwzVFxhQr3QxeiexnFljXbYmJGvD9nd2h4=;
        h=Date:From:To:Subject:From;
        b=h/QxzUGvu9uGgbFHCqOkAX4ic9EVh8Eik4BlvDiWYatkG/4eclv1ZwQPW6ghFRIXn
         VBMzUETrkSpSqUrxkpxE70gkbMDIi3tPPtCAmQgUjKvzuUUqjEYELPx978XQWtQsr1
         GJkKOT4iBeQ/xIqG4cuOLwUdoe4kuSTOBtFCObh8NmSFMBK4Pl5TuPeodr/brBKqsY
         1vZgFhQEWR93OP6Zqy+f2YjovNnM2KijRmXhpOsYtztiQJyefu74zYtAmhuAST3cyQ
         bx4L0NMVKDWwp3DUmYHAACh/Qwq29/faBdlkV5hxVJdwJW1JJiVmBvXJckKyJLPb5r
         lBewltJGEbfmg==
Date:   Thu, 13 Jun 2019 18:59:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jokke_H=E4m=E4l=E4inen?= 
        <jokke.hamalainen@kolttonen.fi>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] checkpolicy: remove redundant if-clause
Message-ID: <alpine.LFD.2.21.1906131859070.5703@34-41-5D-CA-59-C7>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Remove redundant if-clause because the check
already has been done earlier.

Signed-off-by: Unto Sten <sten.unto@gmail.com>
---
 checkpolicy/parse_util.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
index 9fda5b42..f2809b48 100644
--- a/checkpolicy/parse_util.c
+++ b/checkpolicy/parse_util.c
@@ -69,9 +69,6 @@ int read_source_policy(policydb_t * p, const char *file, const char *progname)
 	}
 	queue_destroy(id_queue);
 
-	if (policydb_errors)
-		return -1;
-
 	fclose(yyin);
 
 	return 0;
-- 
2.21.0

