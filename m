Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF4C433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 08:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA5921775
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 08:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcrzperF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHTIpH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgHTIo7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 04:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597913097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcUBATCRJiYnNMlPKV4JFjDwk+9Rl7SbYwmWwCzBlWQ=;
        b=GcrzperFCpQkZzwKJvVE8Me5WRW290+e+Wl/Yh4yIXGC36WVLjmNLlDrZZdiaEgmwOc5oF
        GZKID4NuDv0zoj1jKWWLZmjOIe9wkC4Mpg96P7arpmFY/T+ZC3kaRlimClUcX7jvLAR2IY
        9FOsovRPTuTNTh7//a97/RmqFl27/2c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ESVVHSmsMaKqxaJ5lGlhjw-1; Thu, 20 Aug 2020 04:44:52 -0400
X-MC-Unique: ESVVHSmsMaKqxaJ5lGlhjw-1
Received: by mail-wr1-f71.google.com with SMTP id t12so403078wrp.0
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 01:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gcUBATCRJiYnNMlPKV4JFjDwk+9Rl7SbYwmWwCzBlWQ=;
        b=N1Rf1k9bsPYIRwoLkNwn5Wy2z6+fB9ySpUNU0CDeWeHmyfATt+Di43DIMKOuSw65Zu
         c0aMYIE1NAejpTQpfqb6qHlLtXEkGfzd+fgbUn2MP/TBaFiCbjziBdo4YUv8sh6W2nlw
         tBlkRGMSvDyfaA3DEqIgmV0qxNyp9/0YI+Ty+J6IaNtGriI70nW3j+wl7BXAmJ0R8FsV
         VB6/bm921aLWeukEFZAiWQTA1NcvzIXRLd7mtpTdWCu8WB1q0FrVCuuko/LmKqz/4pWl
         t+h1TbI6IkxD57jmkP/aOO/zijnbd4nVeULCcJy5PkTiXnratopsp9m7fDwiPEAAUUPq
         M6uA==
X-Gm-Message-State: AOAM530DJTpwnGQzmT1HzTGFah/77+X1dxb0UE/+e2RCiM5q40+bxknx
        JU/XHaTBI6ikojqS97rt5EX5EM5v2ISSei1LzCP6UakpWbaLkC/3ynKTCj3UnI3uVxkyc7aKqtE
        c3Ra+VxWeTf7WFGe+DQ==
X-Received: by 2002:adf:f806:: with SMTP id s6mr2167757wrp.252.1597913090839;
        Thu, 20 Aug 2020 01:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd4Qz9mq53U82qkC8uhvkm7Q02w2UXrS/lbOH+PiFY5kuIqiDTIURQ9mvOZ6YjSlvVCDJ5vg==
X-Received: by 2002:adf:f806:: with SMTP id s6mr2167745wrp.252.1597913090641;
        Thu, 20 Aug 2020 01:44:50 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id o66sm3110856wmb.27.2020.08.20.01.44.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 01:44:50 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v3 1/2] README: add perl-lib as a dependency
Date:   Thu, 20 Aug 2020 10:44:46 +0200
Message-Id: <20200820084447.1030353-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820084447.1030353-1-omosnace@redhat.com>
References: <20200820084447.1030353-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The `lib` perl module has been split out of the `perl-interpreter`
package in Fedora 33 into `perl-lib`. It is needed for the filesystem
tests. Add it to the dependencies.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 README.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index ff0a0dc..838a082 100644
--- a/README.md
+++ b/README.md
@@ -45,6 +45,7 @@ similar dependencies):
 * perl-Test  _(test harness used by the testsuite)_
 * perl-Test-Harness _(test harness used by the testsuite)_
 * perl-Test-Simple _(for `Test::More`)_
+* perl-lib _(for `lib`; split out from `perl-interpreter` since Fedora 33)_
 * selinux-policy-devel _(to build the test policy)_
 * gcc _(to build the test programs)_
 * libselinux-devel _(to build some of the test programs)_
@@ -60,11 +61,13 @@ similar dependencies):
 * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 
 On a modern Fedora system you can install these dependencies with the
-following command:
+following command (NOTE: On Fedora 32 and below you need to remove
+`perl-lib` from the package list):
 
 	# dnf install perl-Test \
 		perl-Test-Harness \
 		perl-Test-Simple \
+		perl-lib \
 		selinux-policy-devel \
 		gcc \
 		libselinux-devel \
-- 
2.26.2

