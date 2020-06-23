Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9140EC433E0
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729F02072E
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 12:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBKNhUrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732620AbgFWMhP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:37:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43765 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729611AbgFWMhO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 08:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592915833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vz3a8vvv+EnpRx4Om9TtvGKqCz8jGEWgzHEej5jXIAo=;
        b=LBKNhUrKATLGErJIWX53uMjKrVLuTgd+7oqc6xZKNfvQfXpHQolaKrXsngy91LAeNW9ehr
        Jo+XJ7a/XswEX+AkWpX/xV6xwPwPSFt6RplFkuxWpd12b0+3TdRvC83lmRb69UIEIbiKd4
        NxTGhCjyEfvTqF181eERu9kIKqWT9HQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-tqZpzhsGP4unlKhDOWaW0w-1; Tue, 23 Jun 2020 08:37:10 -0400
X-MC-Unique: tqZpzhsGP4unlKhDOWaW0w-1
Received: by mail-wr1-f69.google.com with SMTP id g14so8640925wrp.8
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 05:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vz3a8vvv+EnpRx4Om9TtvGKqCz8jGEWgzHEej5jXIAo=;
        b=WJ7dh6nSqQYEJc9gvRhGT/bYW+duq4hiNDw975r6IhcsaH//C82rHqOIbZ9a579j54
         /H2vPOY+6eckCbPA/XkrboGPIHuVDjgqquhCEVP9nINjXfBi/2fToPrtaDSYNwAL5DPY
         I577573VHfqilw0MJKl2WoNyFjy/A3FutZFy1SLsIn+PvwwOfMs9AqhHsGJpMb/hnBbH
         N5zVunApzaba663nHSUyqCAoH1XuddX+xkPb8A24yJONicwRgWUwWFkVZXyRpg+p+UUV
         gKvJFRa7Uzu1wfGFGxgKqd+jhdymWwM9OOK610l1JWg46xK+vnIQa95ZeaKLd4dzaq95
         r53g==
X-Gm-Message-State: AOAM531sKb4kg2fW5SURS/nHlQm8TlViqyglgjsscn+iGkcOfRnOs06G
        TNDQtjj9REPmSm3I9CuTtmh/+7Ryo1rOF9h3Nm3B2C4G7M3pbAHWSa+CgbCrsapJNwZxPfyjFn0
        3ABsNkD8l45NILAaViQ==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr17954570wrt.209.1592915829137;
        Tue, 23 Jun 2020 05:37:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLe5ah8PmJqWhDb39c+LXCkt2PJ9Yks+utwQhwLeRZPcjo4JC1iTy3c1SgmSQbFHOizHdagQ==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr17954542wrt.209.1592915828831;
        Tue, 23 Jun 2020 05:37:08 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id p9sm3449729wma.48.2020.06.23.05.37.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:37:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 4/4] tests: stop using deprecated security_context_t
Date:   Tue, 23 Jun 2020 14:37:02 +0200
Message-Id: <20200623123702.401338-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623123702.401338-1-omosnace@redhat.com>
References: <20200623123702.401338-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In Travis CI, GCC reports in several places:

gcc -g -O0 -Wall -D_GNU_SOURCE -DHAVE_BPF    parent.c  -lselinux -o parent
parent.c: In function ‘main’:
parent.c:25:2: warning: ‘security_context_t’ is deprecated [-Wdeprecated-declarations]
  security_context_t context_s;
  ^~~~~~~~~~~~~~~~~~

Fix this by using plain char * instead of security_context_t.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/bounds/thread.c    | 4 ++--
 tests/dyntrace/parent.c  | 2 +-
 tests/dyntrans/parent.c  | 2 +-
 tests/execshare/parent.c | 2 +-
 tests/exectrace/parent.c | 2 +-
 tests/inherit/parent.c   | 2 +-
 tests/prlimit/parent.c   | 2 +-
 tests/setnice/parent.c   | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/bounds/thread.c b/tests/bounds/thread.c
index d09a634..acb976f 100644
--- a/tests/bounds/thread.c
+++ b/tests/bounds/thread.c
@@ -19,7 +19,7 @@ static int thread_status = 0;
 
 static void *worker(void *datap)
 {
-	security_context_t security_context = datap;
+	char *security_context = datap;
 	int rc;
 
 	rc = setcon(security_context);
@@ -31,7 +31,7 @@ static void *worker(void *datap)
 
 int main(int argc, char *argv[])
 {
-	security_context_t security_context;
+	char *security_context;
 	context_t context;
 	pthread_t thread;
 	int rc;
diff --git a/tests/dyntrace/parent.c b/tests/dyntrace/parent.c
index a3a644e..63cbd76 100644
--- a/tests/dyntrace/parent.c
+++ b/tests/dyntrace/parent.c
@@ -12,7 +12,7 @@
 int main(int argc, char **argv)
 {
 	int pid, rc, status;
-	security_context_t context_s;
+	char *context_s;
 	context_t context;
 	char *child_argv[3];
 
diff --git a/tests/dyntrans/parent.c b/tests/dyntrans/parent.c
index 660a1d5..c8320cc 100644
--- a/tests/dyntrans/parent.c
+++ b/tests/dyntrans/parent.c
@@ -11,7 +11,7 @@
 int main(int argc, char **argv)
 {
 	int rc;
-	security_context_t context_s;
+	char *context_s;
 	context_t context;
 
 	if (argc != 2) {
diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
index 2357265..5b9bd80 100644
--- a/tests/execshare/parent.c
+++ b/tests/execshare/parent.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
 	int pagesize;
 	void *clone_stack, *page;
 	int pid, rc, status, cloneflags;
-	security_context_t context_s;
+	char *context_s;
 	context_t context;
 
 	if (argc != 4) {
diff --git a/tests/exectrace/parent.c b/tests/exectrace/parent.c
index 88adb56..6906ee9 100644
--- a/tests/exectrace/parent.c
+++ b/tests/exectrace/parent.c
@@ -11,7 +11,7 @@
 int main(int argc, char **argv)
 {
 	int pid, rc, status;
-	security_context_t context_s;
+	char *context_s;
 	context_t context;
 
 	if (argc != 3) {
diff --git a/tests/inherit/parent.c b/tests/inherit/parent.c
index be48b79..10b59b4 100644
--- a/tests/inherit/parent.c
+++ b/tests/inherit/parent.c
@@ -9,7 +9,7 @@
 int main(int argc, char **argv)
 {
 	char **childargv;
-	security_context_t context_s;
+	char *context_s;
 	context_t context;
 	int rc, fd;
 
diff --git a/tests/prlimit/parent.c b/tests/prlimit/parent.c
index 11c0c25..b735445 100644
--- a/tests/prlimit/parent.c
+++ b/tests/prlimit/parent.c
@@ -26,7 +26,7 @@ int main(int argc, char **argv)
 {
 	char buf[1];
 	int pid, rc, fd[2], fd2[2], opt;
-	security_context_t context_s;
+	char *context_s;
 	context_t context;
 	struct rlimit newrlim, oldrlim, *newrlimp = NULL, *oldrlimp = NULL;
 	bool get = false, set = false, soft = false;
diff --git a/tests/setnice/parent.c b/tests/setnice/parent.c
index b010aa0..bbb0c7f 100644
--- a/tests/setnice/parent.c
+++ b/tests/setnice/parent.c
@@ -14,7 +14,7 @@ int main(int argc, char **argv)
 {
 	char buf[1];
 	int pid, rc, rc2, fd[2], fd2[2];
-	security_context_t context_s;
+	char *context_s;
 	context_t context;
 
 	if (argc != 3) {
-- 
2.26.2

