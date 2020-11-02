Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE301C388F9
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52685206DC
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 08:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxVu0Szd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgKBIf0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727902AbgKBIfZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 03:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604306124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEdhfquk6SyWWkHPzszNFtJfFb9gTGHgZXx6x23uqg0=;
        b=QxVu0SzdoH/RsFfxlaa+FuWs6XIsXK4B+POA9mUSvNVx2FBd5rdHjKhL1XFLDkxtnVkksW
        FdF5bxcYCKYenvfY2oSAN+3vLMHxN1tJw2xiEfci+3BDIBHIi2e6V2qCSNM77omKA9K7HU
        HhkmX9i6prcgliKXxBGerS0ObCaAdso=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-6KwYg4svPgKdH5LoBdFbsg-1; Mon, 02 Nov 2020 03:35:23 -0500
X-MC-Unique: 6KwYg4svPgKdH5LoBdFbsg-1
Received: by mail-ej1-f71.google.com with SMTP id z25so4037113ejd.2
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 00:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEdhfquk6SyWWkHPzszNFtJfFb9gTGHgZXx6x23uqg0=;
        b=EkI9vvKGK1ufz5sNfHSjKywfYpo6TbBcT++tQh4Nu65sbbSqRJg82CvCbJpGLYkSsz
         1X8eX24uXcFV5OOlWRXiPD2ThfEdavSmpF3E3aPiPABPWVHG1qSTf1lCyqkpxutBdWuI
         ZjInajSu83HV8PEc9ceWLzroEr6BMIJxmt8Yn2I1GBh5/smmY5N14GhCtUsAiQK8LTNb
         DlY47kqs7daXMF70CBQYNbCZOGFTqXA8OwOWioOOKCh5vpETMbfkQ4OyfwYx2k2FwSMl
         G2tmlah9HiHiBkU4hQcYteVKOELS1NgsK9fRYIlNbYUoudSznmYzQWZ5uRMVYxFyDFy+
         JA3Q==
X-Gm-Message-State: AOAM531QYlxhekM70Y8yXVT5t4MeZcAtMqvpP3579AlB1bLS/CXKsKIz
        mcFtyKrAO4AObArzBewv9UYp2/qMQxGwGrqRE0akVXUp5Bb2Rbv/Mm7au7X2EAXH2LPoalji0s0
        1lI1yBAxOfiyDhcd7RQ==
X-Received: by 2002:a17:906:f752:: with SMTP id jp18mr12401762ejb.331.1604306121593;
        Mon, 02 Nov 2020 00:35:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPDxWlepDS3vSJD8asPC+8T0F8QgFMTqKzwm2kbgaKOxzX0ZesCC6BqQYOQt50XfDfVhFqDw==
X-Received: by 2002:a17:906:f752:: with SMTP id jp18mr12401752ejb.331.1604306121409;
        Mon, 02 Nov 2020 00:35:21 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id bk13sm9293716ejb.58.2020.11.02.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:35:20 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite v2 2/4] tests/filesystem: pipe "yes" to mkfs.* to fix jfs test
Date:   Mon,  2 Nov 2020 09:35:14 +0100
Message-Id: <20201102083516.477149-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102083516.477149-1-omosnace@redhat.com>
References: <20201102083516.477149-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

mkfs.jfs is reluctant to overwrite the device without the user's
consent, so shout a stream of y's on it to avoid the test getting stuck.
We can't universally pass -q to mkfs.*, because not all mkfs.* tools
support it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/filesystem/Filesystem.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index 2365ce8..c14e760 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -133,7 +133,7 @@ sub make_fs {
     attach_dev( $mk_dev, $mk_dir );
 
     print "Make $mk_type filesystem on $mk_dev\n";
-    $result = system("mkfs.$mk_type $mk_dev >& /dev/null");
+    $result = system("yes | mkfs.$mk_type $mk_dev >& /dev/null");
     if ( $result != 0 ) {
         system("losetup -d $mk_dev 2>/dev/null");
         print "mkfs.$mk_type failed to create filesystem on $mk_dev\n";
-- 
2.26.2

