Return-Path: <SRS0=H24+=VF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78032C606AC
	for <selinux@archiver.kernel.org>; Mon,  8 Jul 2019 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2039120665
	for <selinux@archiver.kernel.org>; Mon,  8 Jul 2019 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="b7h+loiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGHNhG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:37:06 -0400
Received: from rgout0704.bt.lon5.cpcloud.co.uk ([65.20.0.144]:15958 "EHLO
        rgout0704.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728461AbfGHNhG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jul 2019 09:37:06 -0400
X-OWM-Source-IP: 86.134.3.56 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrgedtgdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdefrdehieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrfedrheeipdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeonhhitgholhgrshdrihhoohhsshesmheggidrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (86.134.3.56) by rgout07.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C6509360D55CFD6; Mon, 8 Jul 2019 14:37:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1562593026; 
        bh=38YCKTfvramK7QZgjVqKHtJZVMj23XATMB5g1pmsPHQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=b7h+loiKTGZzuz5M5cLoc45BEdzuPHIi1QMK1gIE1NvfNYD1EZUTmRxBy5/C0RefzBBBVJD5689OJsFSXfORU08ltPl8hUaCBWqmZXsHVEQC/58lGJlfpKL02JDkmEfUWfbS2ULiUYUo4nKvV+3eLsaK3Y3MIaUYDkRsfq6E9Dg=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, nicolas.iooss@m4x.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] libselinux: Fix security_get_boolean_names build error
Date:   Mon,  8 Jul 2019 14:37:01 +0100
Message-Id: <20190708133701.32317-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When running 'make' from libselinux on Fedora 30 (gcc 9.1.1) the
following error is reported:

bute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wstrict-overflow=5
-I../include -D_GNU_SOURCE  -DNO_ANDROID_BACKEND  -c -o booleans.o
booleans.c
booleans.c: In function ‘security_get_boolean_names’:
booleans.c:39:5: error: assuming signed overflow does not occur when
changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
  39 | int security_get_boolean_names(char ***names, int *len)
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [Makefile:171: booleans.o] Error 1

This is caused by the '--i' in the: 'for (--i; i >= 0; --i)' loop.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change: Simplify the free loop.

 libselinux/src/booleans.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ab1e0754..a9154ce8 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -81,8 +81,10 @@ int security_get_boolean_names(char ***names, int *len)
 	free(namelist);
 	return rc;
       bad_freen:
-	for (--i; i >= 0; --i)
-		free(n[i]);
+	if (i > 0) {
+		while (i >= 1)
+			free(n[--i]);
+	}
 	free(n);
       bad:
 	goto out;
-- 
2.21.0

