Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB96C433DB
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F8961A06
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhCXM0z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234510AbhCXM0X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Mar 2021 08:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616588781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0m3m+68BweIM99WAdr/dyJRjaGw4AFDK1qmmXKDY8Ss=;
        b=Wp/QTUjWcxce3+BUFmfIB0JtFxp1ybje4Nz7h13dc3CEA3HpfommSk3k+tJkycp2dMESIY
        0mwQ2t0PFSiMFZOmqU3etsVniUa27GRJCrBxJ+BDejo4+5HokIA6vtXbt7sOvzdIy1O8KN
        6pBXjljge03M6iF78kE7qtwsBjsNuBc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-l3x3ZG3VP_uFT_UBI1Yrug-1; Wed, 24 Mar 2021 08:26:19 -0400
X-MC-Unique: l3x3ZG3VP_uFT_UBI1Yrug-1
Received: by mail-ej1-f69.google.com with SMTP id e13so828957ejd.21
        for <selinux@vger.kernel.org>; Wed, 24 Mar 2021 05:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0m3m+68BweIM99WAdr/dyJRjaGw4AFDK1qmmXKDY8Ss=;
        b=qkpYZxr1yZrJ7acoq24BEJ2HnemRQeLV2biETkRsInbFAZMWIOUzkrGLNGXpW5iMYl
         9w/wKLNpna/AO05SYcapm5h/z9CcZ/p2UJ408JYNbZPhK7aaed5sHfKZR+sh153f/O8R
         oz1rseu7BzBm2Xg7lISEfeqvExj8N2KcwVE2hGsnT/0JFCOxr9QbmgnvDSgV7fxck6T1
         ZIYZrVOjyjSnDi6bfbuzttKQrN6pD453la4SkVPi45Cu0xuj2f8g1BkAgh49J7KElrHZ
         AB9CMFoRYE7lqK6sGxPHrh8HadiArRy9HUtoMBndQI46+OqaJaPbGbTqouoozIjDP8jI
         OKUA==
X-Gm-Message-State: AOAM530hfpWLvHnRdJm5jvDQzTFJ33ONAj8R71uSQp5L3qzSTl8v9W+B
        jjqXMmuB1f0OTykEULdUp9XcBj5jcKUcggF0iAJAWh9NpEbye+DfaenFd6tkllmbJvfDzDGw+nx
        taLawBfi1+oUzbVRQYXvKOCQ3gRgrItoyOkLpySxToNWf6CU+DCBtmOEYJ/ib6ng6d2eSFw==
X-Received: by 2002:a17:906:abcd:: with SMTP id kq13mr3457613ejb.477.1616588777698;
        Wed, 24 Mar 2021 05:26:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/oFbA9tMoc1fWjQKsxZKBcbsFHM8j0rXcnfSlEIMiHkzuOS1JN8XFJhvGcoTpzvGA1XI55A==
X-Received: by 2002:a17:906:abcd:: with SMTP id kq13mr3457597ejb.477.1616588777533;
        Wed, 24 Mar 2021 05:26:17 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id d19sm1066583edr.45.2021.03.24.05.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 05:26:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH testsuite] tests/userfaultfd: handle __NR_userfaultfd not being defined
Date:   Wed, 24 Mar 2021 13:26:16 +0100
Message-Id: <20210324122616.406572-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On some old kernels (think RHEL-7) __NR_userfaultfd may not be defined
on certain arches, even though the <linux/userfaultfd.h> header is
available. To avoid build errors in such environments, abstract the
userfaultfd syscall into a helper function and make it fail with ENOSYS
when __NR_userfaultfd is not defined.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/userfaultfd/userfaultfd.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/userfaultfd/userfaultfd.c b/tests/userfaultfd/userfaultfd.c
index a283a83..dd3a9f3 100644
--- a/tests/userfaultfd/userfaultfd.c
+++ b/tests/userfaultfd/userfaultfd.c
@@ -19,7 +19,7 @@ int page_size;
 
 void *fault_handler_thread(void *arg)
 {
-	long uffd = (long)arg;
+	int uffd = (int)(intptr_t)arg;
 	struct uffd_msg msg = {0};
 	struct uffdio_copy uffdio_copy = {0};
 	ssize_t nread;
@@ -83,6 +83,16 @@ void *fault_handler_thread(void *arg)
 	}
 }
 
+int syscall_userfaultfd(int flags)
+{
+#ifdef __NR_userfaultfd
+	return (int)syscall(__NR_userfaultfd, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
 int main (int argc, char *argv[])
 {
 	char *addr;
@@ -92,7 +102,7 @@ int main (int argc, char *argv[])
 	pthread_t thr; // ID of thread that handles page faults
 	ssize_t ret;
 
-	long uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	int uffd = syscall_userfaultfd(O_CLOEXEC | O_NONBLOCK);
 	if (uffd < 0) {
 		if (errno == ENOSYS) {
 			return 8;
@@ -159,7 +169,8 @@ int main (int argc, char *argv[])
 	}
 
 	// Create a thread that will process the userfaultfd events
-	ret = pthread_create(&thr, NULL, fault_handler_thread, (void *) uffd);
+	ret = pthread_create(&thr, NULL, fault_handler_thread,
+			     (void *)(intptr_t)uffd);
 	if (ret != 0) {
 		errno = ret;
 		perror("pthread_create");
-- 
2.30.2

