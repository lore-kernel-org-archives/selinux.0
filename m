Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4173C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76715206C2
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jSfy/5ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfIRMw4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:52:56 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:5875 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfIRMwz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 08:52:55 -0400
X-EEMSG-check-017: 24012108|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="24012108"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 12:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568811175; x=1600347175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FGPxBs7ahVSyGmhQjO6Xf6j0VNzkcOjhqyxb2bBAsc0=;
  b=jSfy/5eji+3l5btJuT/rFerlNwXu14EfX9V/WhBVezUSW7yRTRCGXiXE
   SdGEpaQVS5P/P1bq36PQQLUUyGlW24x5zmV2Wvu3bowL9w1HE/Pv17+hd
   FI5tPsJ7KddfjFYL22zqvN0VBcrUUbl4NWWNm2ZgLaDXgn9YJ8BIf3cmV
   T+MUZmPhDayPWxK8ndqiSe8W+7GLNO74LzQCyAa73fu7GbZcKc2SCONiw
   Qs0+TTz3Mb1nKLTeP21p65iq57GTWpQO/zx+pRfjVxSwEv1St0Kn+Fbo4
   Gp5pLWKVAlxt2oEXK7D/gQ27LvmewFKM+b1T+REv7d7ROECBrUYKlh+dn
   A==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="28040577"
IronPort-PHdr: =?us-ascii?q?9a23=3Aw7e7+hBgeyRyVVayXusJUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPTzocbcNUDSrc9gkEXOFd2Cra4d0KyP4+u9ByRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLs9xx?=
 =?us-ascii?q?jGrnZIeuld2GdkKU6Okxrm6cq84YBv/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4USm?=
 =?us-ascii?q?pbWsZaSjJPDIWyYYASC+YNJOZVoo34q1YIsBCwBxSjBPn3xzFImHH4wKM03e?=
 =?us-ascii?q?cmHw7J0wItBM4CvXfOodnpLqoeTfy5wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0lzdrwvfGPqbnAprXMnfMjqzsfa?=
 =?us-ascii?q?xj5EFByAo818xf64hIBbEGJfL5QlXxu8DADh8lLwy0xP7qCM5j2YMaWGKPBL?=
 =?us-ascii?q?KZMazJvF+W6eIgPfOMaJUWuDnjMfgl4eDhjXsjlV8aZ6mp0oMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88ZEWgQowo+SPfniEWYXj5OY3a+Rqc85jY8CIK8E4jPXJyigLuE3H?=
 =?us-ascii?q?TzIpoDfmlbDniUGGrsMoCDXO0BLimVJ5xPiDsBAIO9Rpch2Bfmjwrzz75qP6?=
 =?us-ascii?q?KA4SEDnY7y39hyoevInFc98iIiXJfV6H2EU2whxjBAfDQxxq0q5BEsxw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2BiAABWKIJd/wHyM5BmHAEBAQQBAQcEAQGBVQUBAQsBg?=
 =?us-ascii?q?W0qgUAyKpQAAQEBBosqjy2BewkBAQEBAQEBAQEbGQECAQGEP4MFIzYHDgIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFOYI6KYMgAUaBUYJjP4F3FLF3hUyDL4FJgTQBhy+EW?=
 =?us-ascii?q?Rh4gQeEYYEOhAOEdCIEjEmgL4Isgi6SSQwbmR8BqRkIKYFYKwgCGAghD4MnU?=
 =?us-ascii?q?BAUkC8kAzCBBgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 12:52:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ICqqXf013433;
        Wed, 18 Sep 2019 08:52:52 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: fix test/file to avoid noise in test output
Date:   Wed, 18 Sep 2019 08:52:51 -0400
Message-Id: <20190918125251.10646-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit ec3ea0fcf3742cba319 ("tests/file: use getfattr instead of ls -Z")
introduced noise in the test output for the file tests because the
context value returned by getfattr includes the terminating NUL and
this caused the command lines to be truncated, omitting the stderr
redirection.  Use the same technique we already use in overlay/test
by chop()'ing off the terminating NUL.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/file/test | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/file/test b/tests/file/test
index 8fe98f6a5b4a..5e080fc6d4e9 100755
--- a/tests/file/test
+++ b/tests/file/test
@@ -51,6 +51,7 @@ system "chcon -t fileop_exec_t $basedir/wait_io 2>&1 > /dev/null";
 #
 $good_file_sid =
   `getfattr --only-values -n security.selinux $basedir/temp_file`;
+chop($good_file_sid);
 
 #
 # Attempt to access a restricted file as the 'good' domain.  The first test
-- 
2.21.0

