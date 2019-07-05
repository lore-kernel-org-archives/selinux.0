Return-Path: <SRS0=aTel=VC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D564C46499
	for <selinux@archiver.kernel.org>; Fri,  5 Jul 2019 12:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87462082E
	for <selinux@archiver.kernel.org>; Fri,  5 Jul 2019 12:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="fq4johl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfGEMLh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:11:37 -0400
Received: from rgout0305.bt.lon5.cpcloud.co.uk ([65.20.0.211]:33960 "EHLO
        rgout03.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbfGEMLh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Jul 2019 08:11:37 -0400
X-OWM-Source-IP: 86.147.203.159 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrfeeggdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddugeejrddvtdefrdduheelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdefrdduheelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (86.147.203.159) by rgout03.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C90B6EC0A036AE4; Fri, 5 Jul 2019 13:11:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1562328697; 
        bh=Zgua94MQaA/VBicPl+gZOLDwmOLWZrCteOW1/jfNBm8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=fq4johl3R16R1l5w8I2IuyuZZ6OqgWJVDzW/PlttUIfmpG2ZIllnAXayehTO0uhwbwiQoDB/iFBGimEfRyTX04b4PIxz5IA8vDDDBMli5YXTPxVzHNaukzKARIXNz0MM9CMYZFFwK9CugWdciH+me60QPedaR2Uw/z5m2SSEWiw=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V3 2/2] setfiles: Update utilities for the new digest scheme
Date:   Fri,  5 Jul 2019 13:12:24 +0100
Message-Id: <20190705121224.5290-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update restorecon_xattr and man pages for new digest scheme
managed by selinux_restorecon(3).

Note that the Russian man pages require updating.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change
Keep restorecon(8) and setfiles(8) as they were for compatibility

 policycoreutils/setfiles/restorecon.8       | 10 +++++-----
 policycoreutils/setfiles/restorecon_xattr.8 | 20 +++++++++-----------
 policycoreutils/setfiles/restorecon_xattr.c |  2 +-
 policycoreutils/setfiles/setfiles.8         | 10 +++++-----
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 0f81db4..bbfc83f 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -100,7 +100,7 @@ section for further details.
 .B \-D
 Set or update any directory SHA1 digests. Use this option to
 enable usage of the
-.IR security.restorecon_last
+.IR security.sehash
 extended attribute.
 .TP
 .B \-m
@@ -184,10 +184,10 @@ option to
 .B restorecon
 will cause it to store a SHA1 digest of the default specfiles set in an extended
 attribute named
-.IR security.restorecon_last
-on the directory specified in each
+.IR security.sehash
+on each directory specified in
 .IR pathname \ ...
-once the relabeling has been completed successfully. This digest will be
+once the relabeling has been completed successfully. These digests will be
 checked should
 .B restorecon
 .B \-D
@@ -204,7 +204,7 @@ option will ignore the SHA1 digest from each directory specified in
 and provided the
 .B \-n
 option is NOT set and recursive mode is set, files will be relabeled as
-required with the digest then being updated provided there are no errors.
+required with the digests then being updated provided there are no errors.
 
 .SH "AUTHOR"
 This man page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/policycoreutils/setfiles/restorecon_xattr.8 b/policycoreutils/setfiles/restorecon_xattr.8
index 65b28ea..e04528e 100644
--- a/policycoreutils/setfiles/restorecon_xattr.8
+++ b/policycoreutils/setfiles/restorecon_xattr.8
@@ -1,7 +1,7 @@
 .TH "restorecon_xattr" "8" "24 Sept 2016" "" "SELinux User Command"
 .SH "NAME"
 restorecon_xattr \- manage
-.I security.restorecon_last
+.I security.sehash
 extended attribute entries added by
 .BR setfiles (8)
 or
@@ -24,7 +24,7 @@ or
 .SH "DESCRIPTION"
 .B restorecon_xattr
 will display the SHA1 digests added to extended attributes
-.I security.restorecon_last
+.I security.sehash
 or delete the attribute completely. These attributes are set by
 .BR restorecon (8)
 or
@@ -43,7 +43,7 @@ from.
 and
 .B TMPFS
 filesystems do not support the
-.I security.restorecon_last
+.I security.sehash
 extended attribute and are automatically excluded from searches.
 .sp
 By default
@@ -62,12 +62,12 @@ option.
 .TP
 .B \-d
 delete all non-matching
-.I security.restorecon_last
+.I security.sehash
 directory digest entries.
 .TP
 .B \-D
 delete all
-.I security.restorecon_last
+.I security.sehash
 directory digest entries.
 .TP
 .B \-m
@@ -87,7 +87,10 @@ Do not append "Match" or "No Match" to displayed digests.
 recursively descend directories.
 .TP
 .B \-v
-display SHA1 digest generated by specfile set.
+display SHA1 digest generated by specfile set (Note that this digest is not
+used to match the
+.I security.sehash
+directory digest entries, and is shown for reference only).
 .TP
 .B \-e
 .I directory
@@ -101,11 +104,6 @@ an optional
 .I specfile
 containing file context entries as described in
 .BR file_contexts (5).
-This will be used by
-.BR selabel_open (3)
-to retrieve the set of labeling entries, with the SHA1 digest being
-retrieved by
-.BR selabel_digest (3).
 If the option is not specified, then the default file_contexts will be used.
 
 .SH "ARGUMENTS"
diff --git a/policycoreutils/setfiles/restorecon_xattr.c b/policycoreutils/setfiles/restorecon_xattr.c
index 91c087f..59b1f74 100644
--- a/policycoreutils/setfiles/restorecon_xattr.c
+++ b/policycoreutils/setfiles/restorecon_xattr.c
@@ -27,7 +27,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 		"-D  Delete all digest entries.\n\t"
 		"-e  Directory to exclude (repeat option for more than one directory).\n\t"
 		"-f  Optional specfile for calculating the digest.\n\t"
-		"pathname  Path to search for xattr \"security.restorecon_last\" entries.\n\n",
+		"pathname  Path to search for xattr \"security.sehash\" entries.\n\n",
 		progname);
 	exit(-1);
 }
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index ccaaf4d..c9f8be0 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -90,7 +90,7 @@ section for further details.
 .B \-D
 Set or update any directory SHA1 digests. Use this option to
 enable usage of the
-.IR security.restorecon_last
+.IR security.sehash
 extended attribute.
 .TP
 .B \-l
@@ -228,10 +228,10 @@ option to
 will cause it to store a SHA1 digest of the
 .B spec_file
 set in an extended attribute named
-.IR security.restorecon_last
-on the directory specified in each
+.IR security.sehash
+on each directory specified in
 .IR pathname \ ...
-once the relabeling has been completed successfully. This digest will be
+once the relabeling has been completed successfully. These digests will be
 checked should
 .B setfiles
 .B \-D
@@ -250,7 +250,7 @@ option will ignore the SHA1 digest from each directory specified in
 .IR pathname \ ...
 and provided the
 .B \-n
-option is NOT set, files will be relabeled as required with the digest then
+option is NOT set, files will be relabeled as required with the digests then
 being updated provided there are no errors.
 
 .SH "AUTHOR"
-- 
2.21.0

