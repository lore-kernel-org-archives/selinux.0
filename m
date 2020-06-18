Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28702C433DF
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BD2207E8
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 18:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi6yadvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgFRSZY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:25:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727060AbgFRSZW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 14:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592504721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T0rslde0gY5v9xKrNRl1knvQyIkh3pN/KpMlNCXLMl8=;
        b=Wi6yadvvnvg1yCZ01CusqvHCIa3BRyjO6Uh/Gc6udAsbVCFDr539Sb3XaD77bZIeN3PHPX
        c5EbJOkZS+3tTtSDQuWCTjMnvEuE1MGxblSdvQDiCyR8n8VvlcvcbtMqzd+RV67D3MqL5r
        qhOfHkxm8OvczdgQFv2JEjnwIXr0i1E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Oi8e4zLlPuKmJcwST6P8iA-1; Thu, 18 Jun 2020 14:25:14 -0400
X-MC-Unique: Oi8e4zLlPuKmJcwST6P8iA-1
Received: by mail-qt1-f198.google.com with SMTP id l26so5063485qtr.14
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 11:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0rslde0gY5v9xKrNRl1knvQyIkh3pN/KpMlNCXLMl8=;
        b=nfmrgUF3rpJDdgC/cedDZIe9M42GVZJx9j/Lf7ieVQsDWxaj/JYzgqwM/aOX7mZDlN
         7R86lpUVEG5tvxd1TRM8vBg2EngM89GSe8ZEfrHjk2R8vZ23gNsrRkSPZp6CEp57CHYp
         P+1ma8IAiE7UDhFZ9qS4ekSPKJ6bQL3VosakI8KGiV/bO3xnrHIlgm4qbYdEQkwh1v9l
         3ZoUFSmjyaRs2rNWKMhnHxQeTGNQU48Nl5gjFAdBhyuGEsug1J5HNAkcNz4g1GwSIv9w
         GTImdea97qKX8EAfrY+31QdZ6RnSiITZ4FzOLWDuDjU3d6DGb4ZQTELgRZXvc1ECsSae
         Xzwg==
X-Gm-Message-State: AOAM533mWuIfet8TdN1NqlXh4J+xOmxjIkT7Z2vopPLtXpK+ITY9KrSq
        lbFkUCIZYa0MHzXHg/6MZaTmdWeqoAAqD0je0SweB/87oYg1OJ8cZaPxRuyDK1ERy1nhW/GT8DR
        on+hHph9aHT2DoEPEGw==
X-Received: by 2002:a37:d04:: with SMTP id 4mr119790qkn.377.1592504713872;
        Thu, 18 Jun 2020 11:25:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtPQNPTLqwTtvXdFWiHTx8/sQpsV60fMH6mZsuRtI3pQIX37zwN5yoi712qmmDjutxF/NKlw==
X-Received: by 2002:a37:d04:: with SMTP id 4mr119756qkn.377.1592504713481;
        Thu, 18 Jun 2020 11:25:13 -0700 (PDT)
Received: from pet.redhat.com (107-190-106-186.cpe.teksavvy.com. [107.190.106.186])
        by smtp.gmail.com with ESMTPSA id l1sm879023qtk.18.2020.06.18.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:25:12 -0700 (PDT)
From:   Jonathan Lebon <jlebon@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Jonathan Lebon <jlebon@redhat.com>
Subject: [PATCH v2] setfiles: clarify documented path resolution behaviour
Date:   Thu, 18 Jun 2020 14:22:07 -0400
Message-Id: <20200618182205.378233-1-jlebon@redhat.com>
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

Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
---
 policycoreutils/setfiles/restorecon.8 | 6 ++++--
 policycoreutils/setfiles/setfiles.8   | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index bbfc83fe..1a785258 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -159,8 +159,10 @@ The pathname for the file(s) to be relabeled.
 .SH "NOTES"
 .IP "1." 4
 .B restorecon
-does not follow symbolic links and by default it does not
-operate recursively on directories.
+by default does not operate recursively on directories. Paths leading up the
+final component of the file(s) are canonicalized using
+.BR realpath (3)
+before labeling.
 .IP "2." 4
 If the
 .I pathname
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 0188a75a..e328a562 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -214,7 +214,8 @@ option is used.
 .SH "NOTES"
 .IP "1." 4
 .B setfiles
-follows symbolic links and operates recursively on directories.
+operates recursively on directories. Paths leading up the final
+component of the file(s) are not canonicalized before labeling.
 .IP "2." 4
 If the
 .I pathname
-- 
2.26.2

