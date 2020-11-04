Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313EC388F9
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FC42224E
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0UkZJxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKDHfE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727651AbgKDHfE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 02:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604475302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SLShKMcJzL7rqv9pMSFRJc/jOsYORgD5oeIpxpWVUxg=;
        b=A0UkZJxuHSs9JacnlqJqc/DhBvzFpBcd0sqXy4XZO8DntEN8dwE9SqQjt52HQ0nhquf7Q0
        E95ui+pfYg28UZU8lv5FcnFjLqh1ZX93NDbsaoqOu5C+Ojz0En3W69dGtcvugtdolu1BqZ
        LB+YZhwhmiNC9fXsO+goc/JtAvGDsTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-fCENgi7TPO-4BdV8vH7_ew-1; Wed, 04 Nov 2020 02:35:00 -0500
X-MC-Unique: fCENgi7TPO-4BdV8vH7_ew-1
Received: by mail-wr1-f70.google.com with SMTP id h11so5925537wrq.20
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 23:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLShKMcJzL7rqv9pMSFRJc/jOsYORgD5oeIpxpWVUxg=;
        b=i5PPHfK2vJYQnwX9VXF+/Wo2I2QP+C3xz1+LgX4oW1AU/YsN6k9ucLRUYkv5zuiqEm
         dGvV+rq8z9f7sBQoysGfdTK7AKGqvu39peDMw4Yr3oxR25whVTrFG1AaPQRHcEoKbHBE
         o3NQCNCOyFiW367h/93erwk7Oit/rpD7JcOnre2coDlkk1+o1PYnhKC6qLnXV2OtMEfi
         Y2NybBao26R2+MFsolyDF7flOc3AszzixzKD4EsaiYWtr3YggspJBLI9xAqqQf1sCU1w
         xNSuDnWk7of27iLkrKL7ztXU6yCb3UAfgrL+MCcLqyIMAPmzT8IA0pVxzxE0aTNnSy8o
         ViSw==
X-Gm-Message-State: AOAM530kNO8Nh55fA7oJCrpsbtJicMHM73ARdLmUZTqHL5vD35nOJt9b
        jHTMCfAdPSKakTGtpe0gQbxq+85LH99MNFobBPajfDA9+JNuf5g6EUMvu1VR8leTZVtHOjPoeHy
        IYxZZhvzbNXmqNltd4A==
X-Received: by 2002:a5d:660a:: with SMTP id n10mr31081604wru.59.1604475298811;
        Tue, 03 Nov 2020 23:34:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUvON7z6RLHWdc9wihMumht2OayXspQ1kjRzmzw5KOOGC52T24oQ6jIk1GX9jyFiSJ9b11gA==
X-Received: by 2002:a5d:660a:: with SMTP id n10mr31081581wru.59.1604475298586;
        Tue, 03 Nov 2020 23:34:58 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id w4sm1322504wrk.28.2020.11.03.23.34.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 23:34:58 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/overlay: replace Python script with a C program
Date:   Wed,  4 Nov 2020 08:34:56 +0100
Message-Id: <20201104073456.820079-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was the only Python script in the whole testsuite. No need to
depend on Python just for access(2)...

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/overlay/.gitignore |  1 +
 tests/overlay/Makefile   |  4 +++-
 tests/overlay/access     |  7 -------
 tests/overlay/access.c   | 16 ++++++++++++++++
 tests/overlay/test       | 26 +++++++++++++-------------
 5 files changed, 33 insertions(+), 21 deletions(-)
 create mode 100644 tests/overlay/.gitignore
 delete mode 100755 tests/overlay/access
 create mode 100644 tests/overlay/access.c

diff --git a/tests/overlay/.gitignore b/tests/overlay/.gitignore
new file mode 100644
index 0000000..73bc322
--- /dev/null
+++ b/tests/overlay/.gitignore
@@ -0,0 +1 @@
+access
diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
index e7c006f..8dce555 100644
--- a/tests/overlay/Makefile
+++ b/tests/overlay/Makefile
@@ -1,2 +1,4 @@
-all:
+TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+all: $(TARGETS)
 clean:
+	rm -f $(TARGETS)
diff --git a/tests/overlay/access b/tests/overlay/access
deleted file mode 100755
index e50d5b4..0000000
--- a/tests/overlay/access
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/usr/bin/python3
-import os, sys
-try:
-        acc=eval("os.%s" % sys.argv[2])
-        print(os.access(sys.argv[1], acc))
-except AttributeError as e:
-        print(e)
diff --git a/tests/overlay/access.c b/tests/overlay/access.c
new file mode 100644
index 0000000..f968dc6
--- /dev/null
+++ b/tests/overlay/access.c
@@ -0,0 +1,16 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+int main(int argc, const char **argv)
+{
+	if (argc != 3 || (strcmp(argv[2], "R_OK") && strcmp(argv[2], "W_OK"))) {
+		fprintf(stderr, "Usage %s <file> R_OK|W_OK\n", argv[0]);
+		return EINVAL;
+	}
+
+	errno = 0;
+	access(argv[1], strcmp(argv[2], "R_OK") == 0 ? R_OK : W_OK);
+	return errno;
+}
diff --git a/tests/overlay/test b/tests/overlay/test
index 72affdf..2b28c47 100755
--- a/tests/overlay/test
+++ b/tests/overlay/test
@@ -34,10 +34,10 @@ sub getfilecon {
 
 sub access {
     my ( $filename, $accesstype ) = @_;
-    $output =
-`runcon -t test_overlay_client_t -l s0:c10,c20 $basedir/access $filename $accesstype`;
-    $output =~ s/\n//g;
-    return $output;
+    $result = system(
+"runcon -t test_overlay_client_t -l s0:c10,c20 $basedir/access $filename $accesstype"
+    );
+    return $result >> 8;
 }
 
 sub xattr_test_setup {
@@ -496,63 +496,63 @@ sub test_52 {
 sub test_60 {
     print "Check read access on readfile, should succeed.\n";
     $result = access( "$basedir/container1/merged/readfile", "R_OK" );
-    ok( $result eq "True" );
+    ok( $result eq 0 );
     return;
 }
 
 sub test_61 {
     print "Check read access on writefile, should succeed.\n";
     $result = access( "$basedir/container1/merged/writefile", "R_OK" );
-    ok( $result eq "True" );
+    ok( $result eq 0 );
     return;
 }
 
 sub test_62 {
     print "Check read access on noaccessfile, should fail.\n";
     $result = access( "$basedir/container1/merged/noaccessfile", "R_OK" );
-    ok( $result eq "False" );
+    ok( $result eq 13 );
     return;
 }
 
 sub test_63 {
     print "Check write access on readfile, should fail.\n";
     $result = access( "$basedir/container1/merged/readfile", "W_OK" );
-    ok( $result eq "False" );
+    ok( $result eq 13 );
     return;
 }
 
 sub test_63_ctx {
     print "Check write access on readfile, should succeed.\n";
     $result = access( "$basedir/container1/merged/readfile", "W_OK" );
-    ok( $result eq "True" );
+    ok( $result eq 0 );
     return;
 }
 
 sub test_64 {
     print "Check write access on writefile, should succeed.\n";
     $result = access( "$basedir/container1/merged/writefile", "W_OK" );
-    ok( $result eq "True" );
+    ok( $result eq 0 );
     return;
 }
 
 sub test_65 {
     print "Check write access on noaccessfile, should fail.\n";
     $result = access( "$basedir/container1/merged/noaccessfile", "W_OK" );
-    ok( $result eq "False" );
+    ok( $result eq 13 );
     return;
 }
 
 sub test_66 {
     print "Check read to read null device should fail\n";
     $result = access( "$basedir/container1/merged/null_read", "R_OK" );
-    ok( $result eq "True" );
+    ok( $result eq 0 );
     return;
 }
 
 sub test_67 {
     print "Check write to read null device should fail\n";
     $result = access( "$basedir/container1/merged/null_read", "W_OK" );
-    ok( $result eq "False" );
+    ok( $result eq 13 );
     return;
 }
 
-- 
2.26.2

