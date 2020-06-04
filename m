Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5401C433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 19:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB64206C3
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 19:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5quO9gT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFDTOH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:14:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22983 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbgFDTOH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 15:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591298045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=92NcCPDcB6HtARPbOigwZa/Cx5kHW5gtlpfxwUv1kQ8=;
        b=R5quO9gTx2Iz38clkBV3N5uV/CSZOpuz1toUhM5N4eje08gyqXMrM7+tv8U3minARyACCa
        dgEu7zbC68MykQgt8qZfmD3wfohWoaHvoyNXXdaSkoXcfJzadWD5GRX+Awrypadzz/deg1
        r7mysI3m3UxrrNjoYiTSldbUkNVzYv0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-f8j-Qy86PAem6lMD8-J0fQ-1; Thu, 04 Jun 2020 15:14:02 -0400
X-MC-Unique: f8j-Qy86PAem6lMD8-J0fQ-1
Received: by mail-qv1-f71.google.com with SMTP id v1so5296721qvx.8
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 12:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92NcCPDcB6HtARPbOigwZa/Cx5kHW5gtlpfxwUv1kQ8=;
        b=TsYpMP4gOoNLBLoaZwS05ZLR6PgjEzhQoSAaWr/wuP1aG6VXW849uIPrSy8SsDnEMG
         W+gCUXR6DME4HhAp+hYZq1Y6g4I174cCPryvOm3COrViFlMo4ioPZC6X4JfsSkgEpm2n
         81N5hGXjZ8HV3rcwZqlM7mwRMwqfMmXHJv23CFR9CbICfcg+enz+JDDuqQjJFGo3D7aI
         ArRpuuWpaxLhkbUvwdiQTfVCAOrM25er+uM+UejLkXffWIUGVZEFVFd61o7o37wCQPZ6
         fSs9UCFEVy54OhWcSeRQoM0f3LDBZkbjAtHm3neYAHqCCxSLliOSP3HRNUfvJuYuPbe5
         vOQg==
X-Gm-Message-State: AOAM533fiPW38KZcQpYtkbEWEgVSGxqGCIsWVflmSpHmZm+vx4KJo32+
        i17H6CzWsWb1YscxMnxugb+RhWPUtfetWrb3br0QR+noJ5bm0kJ37X6mvmrLBA49VtF2zTwxMO5
        bFOxefOP4+PmmI1L4jw==
X-Received: by 2002:a05:620a:22f3:: with SMTP id p19mr6263634qki.358.1591298041651;
        Thu, 04 Jun 2020 12:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN7HuPVuFNeJzTJK8UKtitPi6Xyi16WOaau0WGg9NkQAT2p46AW9F8IhykgvUclmdqLe00vQ==
X-Received: by 2002:a05:620a:22f3:: with SMTP id p19mr6263614qki.358.1591298041436;
        Thu, 04 Jun 2020 12:14:01 -0700 (PDT)
Received: from pet.redhat.com (107-190-106-186.cpe.teksavvy.com. [107.190.106.186])
        by smtp.gmail.com with ESMTPSA id v3sm5236530qkh.130.2020.06.04.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 12:14:00 -0700 (PDT)
From:   Jonathan Lebon <jlebon@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Jonathan Lebon <jlebon@redhat.com>
Subject: [PATCH] setfiles: clarify documented path resolution behaviour
Date:   Thu,  4 Jun 2020 15:12:40 -0400
Message-Id: <20200604191240.263819-1-jlebon@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

One thing that confused me when investigating
https://github.com/SELinuxProject/selinux/issues/248 (i.e.
https://github.com/coreos/fedora-coreos-tracker/issues/512) was that the
manual page for `setfiles` seemed to imply that paths were fully
resolved. This was consistent with the issues above where `setfiles` was
failing because the target of the symbolic link didn't exist.

But in fact, the wording around symbolic links in
`setfiles`/`restorecon` refers actually to whether the parent
directories are canonicalized via `realpath(3)` before labeling.

Clarify the man pages to explain this.
---
 policycoreutils/setfiles/restorecon.8 | 4 ++--
 policycoreutils/setfiles/setfiles.8   | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index bbfc83fe..06ec5a1d 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -159,8 +159,8 @@ The pathname for the file(s) to be relabeled.
 .SH "NOTES"
 .IP "1." 4
 .B restorecon
-does not follow symbolic links and by default it does not
-operate recursively on directories.
+by default does not operate recursively on directories. Parent directories
+are fully resolved before labeling.
 .IP "2." 4
 If the
 .I pathname
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 0188a75a..12f41967 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -214,7 +214,8 @@ option is used.
 .SH "NOTES"
 .IP "1." 4
 .B setfiles
-follows symbolic links and operates recursively on directories.
+operates recursively on directories. Parent directories are not fully
+resolved before labeling.
 .IP "2." 4
 If the
 .I pathname
-- 
2.26.2

