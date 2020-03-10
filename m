Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C0BC10F27
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F919208E4
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 14:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O08jExDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCJOll (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:41:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37396 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgCJOll (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 10:41:41 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 80F2820B9C02
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2020 07:41:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80F2820B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1583851300;
        bh=jjxYFh5hO+vNK6XDaEkmoZ7pSXaidsoWn+LSbL01uZY=;
        h=From:To:Subject:Date:From;
        b=O08jExDZNLjHFs7rnodMoATuF0EPGRr1AHbs2yl1UBTTIuUvX5G/8YdxZ2jQsYeX5
         lK2dh9D/dWWOxoCnrR4GL9/076t+h4kuvykPb35hZvdGsXi2DWvC9D6uvcF1HRpJHH
         Z/VPurd6fz2M25Lc51Tp224zNE4ETs10PsNwWFh0=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: Treat invalid characters as an error
Date:   Tue, 10 Mar 2020 10:41:33 -0400
Message-Id: <20200310144133.381567-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Previously the behavior was to warn, discard the character and proceed. Now the build will halt upon encountering an expected character.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 checkpolicy/policy_scan.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index e2f676e4..8c100f3d 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -290,7 +290,7 @@ GLBLUB				{ return(GLBLUB); }
 "]" |
 "~" |
 "*"				{ return(yytext[0]); } 
-.                               { yywarn("unrecognized character");}
+.                               { yyerror("unrecognized character");}
 %%
 int yyerror(const char *msg)
 {
-- 
2.24.1

