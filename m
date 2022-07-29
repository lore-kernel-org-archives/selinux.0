Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294CC19F2B
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbiG2MDM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiG2MDL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 299F0863E0
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MITRSNKuPb1vWt0LZiXyGZgE8zuzgaQAgHwdhsgWlSk=;
        b=YxdDYGOrWb7gptoR8CHmijz0mIMfw3d74USXaAN++Ry7V8kLXk290aFhRxgDXWRx/0AIWo
        qMZ+aoYtdTZB3ld4FWpyZRn1wTtvZdhmTI0L9qfsfIj9DkEadW3dJNYD3oDX7zGoAeBkSn
        18QNnuA67xGJ9mZNJ9E2JXSsd+qW6Cg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-983pvsL7OemsK9zu3iO86g-1; Fri, 29 Jul 2022 08:03:08 -0400
X-MC-Unique: 983pvsL7OemsK9zu3iO86g-1
Received: by mail-wr1-f69.google.com with SMTP id h9-20020adfa4c9000000b0021ee4a48ea7so1143914wrb.10
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=MITRSNKuPb1vWt0LZiXyGZgE8zuzgaQAgHwdhsgWlSk=;
        b=bMorE99cOLiZPcy889nOcyXoWZb/Gmlbs6kqNL57uhgl8VKL1RgyvZ0X9dk/jNZaMU
         YPUZkFoCWCjjR8qBeHZ7fBV43W6qomkaj4dFVomUcXN+GYB1q/lvRUObe4dQU6U8GfRh
         MrbILwLGHIYsV4Y2C7yaGily214QEAx4aCqoWG+plxOhZKEz50Hg+Jn0cyNkmdM+Cjlq
         q9RNTPPEy8ni2xdp0gT/5TRAlTc7UXns/UKPg2PZC+f9XhSIvTk91IGch6b9db8WzMiG
         8Y/e3Qxvw0QpmtftBg4NUJ/1xcpzc6IuCjcUjzpbA0nJHTlfF7RKUIaCzJsSbvYo5Tek
         ZKUQ==
X-Gm-Message-State: ACgBeo3IF1mZ3mf5PcaMFk9EsnJ5qSzgSdLcNqezg7vlNadiSV8GbhsE
        M9YJZPAzStDVzDudCSmjgFAPecz0UjVTVaUuOO9RbycKHumx/UB5sQqDQanHD1Tck+rIKXhFoB+
        lmPEwb2D6f7VEhD4Hfuoz4RFPtacLgWJ91k0Rhcb7ktAxGV70Seb4XcWsAxr62AJ+N//qDA==
X-Received: by 2002:a05:6000:1841:b0:21e:fa04:61f4 with SMTP id c1-20020a056000184100b0021efa0461f4mr2180531wri.491.1659096187346;
        Fri, 29 Jul 2022 05:03:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR40BDgtE/6MV9fG/1HxdXVbn5aR0sHo8248j7Wf2Q0QSkw+QDr1Rg4xnqanOg0Bdo5s1giNJQ==
X-Received: by 2002:a05:6000:1841:b0:21e:fa04:61f4 with SMTP id c1-20020a056000184100b0021efa0461f4mr2180510wri.491.1659096187002;
        Fri, 29 Jul 2022 05:03:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.03.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:03:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 23/24] tests/vsock_socket: use modprobe to check vsock availability
Date:   Fri, 29 Jul 2022 14:02:28 +0200
Message-Id: <20220729120229.207584-24-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fedora sysadm_t is not allowed to create vsock sockets, so the check
would fail. Since modprobing the relevant kernel modules is also a
reliable way to check the general vsock support, use that instead of the
more direct check.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/vsock_socket/.gitignore    |  1 -
 tests/vsock_socket/Makefile      |  2 +-
 tests/vsock_socket/check_vsock.c | 47 --------------------------------
 tests/vsock_socket/test          | 11 ++------
 4 files changed, 4 insertions(+), 57 deletions(-)
 delete mode 100644 tests/vsock_socket/check_vsock.c

diff --git a/tests/vsock_socket/.gitignore b/tests/vsock_socket/.gitignore
index 13eeb1b..f2ad853 100644
--- a/tests/vsock_socket/.gitignore
+++ b/tests/vsock_socket/.gitignore
@@ -1,3 +1,2 @@
 client
 server
-check_vsock
diff --git a/tests/vsock_socket/Makefile b/tests/vsock_socket/Makefile
index bf6ec7b..5266096 100644
--- a/tests/vsock_socket/Makefile
+++ b/tests/vsock_socket/Makefile
@@ -1,4 +1,4 @@
-TARGETS=client server check_vsock
+TARGETS=client server
 
 LDLIBS+= -lselinux
 
diff --git a/tests/vsock_socket/check_vsock.c b/tests/vsock_socket/check_vsock.c
deleted file mode 100644
index 6eecd62..0000000
--- a/tests/vsock_socket/check_vsock.c
+++ /dev/null
@@ -1,47 +0,0 @@
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-
-// Must be included after sys/socket.h
-#include <linux/vm_sockets.h>
-
-int main(int argc, char **argv)
-{
-	int sock;
-	struct sockaddr_vm svm;
-
-	sock = socket(AF_VSOCK, SOCK_STREAM, 0);
-	if (sock < 0) {
-		if (errno == EAFNOSUPPORT) {
-			// AF_VSOCK not supported
-			exit(2);
-		} else {
-			perror("socket");
-			exit(1);
-		}
-	}
-
-	bzero(&svm, sizeof(svm));
-	svm.svm_family = AF_VSOCK;
-	svm.svm_port = VMADDR_PORT_ANY;
-	svm.svm_cid = VMADDR_CID_LOCAL;
-
-	if (bind(sock, (struct sockaddr *)&svm, sizeof(svm)) < 0) {
-		if (errno == EADDRNOTAVAIL) {
-			// vsock_loopback not supported
-			close(sock);
-			exit(3);
-		} else {
-			perror("bind");
-			close(sock);
-			exit(1);
-		}
-	}
-
-	close(sock);
-	exit(0);
-}
diff --git a/tests/vsock_socket/test b/tests/vsock_socket/test
index f05b972..9a0d72c 100755
--- a/tests/vsock_socket/test
+++ b/tests/vsock_socket/test
@@ -6,19 +6,14 @@ BEGIN {
     $basedir =~ s|(.*)/[^/]*|$1|;
 
     # check if vsock and vsock_loopback are available
-    $rc = system("$basedir/check_vsock");
-
-    if ( $rc eq 0 ) {
-        plan tests => 12;
-    }
-    elsif ( $rc eq 2 << 8 ) {
+    if ( system("modprobe vsock 2>/dev/null") ne 0 ) {
         plan skip_all => "vsock socket family not supported";
     }
-    elsif ( $rc eq 3 << 8 ) {
+    elsif ( system("modprobe vsock_loopback 2>/dev/null") ne 0 ) {
         plan skip_all => "vsock_loopback transport not supported";
     }
     else {
-        plan skip_all => "unexpected error when checking vsock support";
+        plan tests => 12;
     }
 }
 
-- 
2.37.1

