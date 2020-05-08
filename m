Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D1C38A2A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 19:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462AB2184D
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 19:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC/MftHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgEHTho (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 15:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHThn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 15:37:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECC0C061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 12:37:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o10so2363000qtr.6
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZiMyPY+6fJBElANaz5vO+mWQ0hLPw3IqEJDxgBykdI=;
        b=kC/MftHmunTm5JQKpPDIoaHjcxzGQFRORbqksCtRQtazTSOVU7KDbtlgW768fZxLqf
         VbxeYKAMu2JRl1b6Yb5HfPVRT78xkOk9qkBfP7VhPPBjEFiM8OYtX4+HFNLCAJHcsYyC
         r5ANwACXjXt7kTkYCfgRSkF3cgpg7cx+AbUFUvSoA/TEt20aMxv3GP24MHz8qapKp5n4
         b67bmJ4p9pVFTY/Ge8HWqaVJXo6Foq1+NeT7QkPbXiLsc6v93tNKZARmVPGynnCnja2Z
         nwHOuEtUUcihDGq5+acOoNUH/i2InmqTI1z1Mq0P7Vx8mT6Ryb/Xm6WSbiGeEVEMy8uj
         +6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZiMyPY+6fJBElANaz5vO+mWQ0hLPw3IqEJDxgBykdI=;
        b=JgciZ0q8KDGsJmIN9HmUaZ/vi8Nq7fzQV85MNnsmViIo5+m69CqeNAcPfSlJ6aD6fD
         8VuMcGcazOCPR6uyzDx+7E0iGeN52cork+wVDgNDRJP+Q4KVmIU+Gz8vnjtp2R/UtZW8
         gsS6bPNScYevhpYUPHaU32xnF1mfeDrix6ZWEaLv/peL6FUen1RIHP79W6YMfBW0GSc0
         ec4WR9vovJdPrwo9ErAHW9HjnWZ3MYrXwz/+S6UZEplAmKK9/kiIWVrnC7BgbdMxntvO
         GmuxtQQVlnXiScNgRCA/BA5BmHw79X1ImWr2yrIOuow9xow+/35fzuUNNzuarHfu3nqy
         uPzg==
X-Gm-Message-State: AGi0PuaODnZZXoockMZMNetPGrc4hRYWISmgi/dCsXG65ndNntsNS0HO
        1GDfftkanHYv4EKzzmL3grZjdW6x
X-Google-Smtp-Source: APiQypJhn6ZX7qdAUo3//NO7S69ssRVfRKRgTVU/21JfyUxYjtnUNqaH2KR0nf2b6z9BkwFVM/V9JQ==
X-Received: by 2002:ac8:6f07:: with SMTP id g7mr4745143qtv.250.1588966662681;
        Fri, 08 May 2020 12:37:42 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id b198sm1014106qkg.37.2020.05.08.12.37.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 12:37:42 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] tests/filesystem: fix quotas_test
Date:   Fri,  8 May 2020 15:37:21 -0400
Message-Id: <20200508193721.29283-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As per the man page, quotactl(2) expects to be passed a pointer to
a 4-byte buffer for Q_GETFMT.  The kernel copies a single u32 value.
On Ubuntu, this was detected as a stack smash when running the test.
Fix the test program.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/filesystem/quotas_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/filesystem/quotas_test.c b/tests/filesystem/quotas_test.c
index 8359811..1424362 100644
--- a/tests/filesystem/quotas_test.c
+++ b/tests/filesystem/quotas_test.c
@@ -33,7 +33,7 @@ int main(int argc, char *argv[])
 	int opt, result, qcmd, save_err, test_id = geteuid();
 	char *context, *src = NULL, *tgt = NULL;
 	bool verbose = false;
-	char fmt_buf[2];
+	unsigned int fmtval;
 
 	while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
 		switch (opt) {
@@ -77,7 +77,7 @@ int main(int argc, char *argv[])
 			printf("User Quota - ON\n");
 
 		qcmd = QCMD(Q_GETFMT, USRQUOTA);
-		result = quotactl(qcmd, src, test_id, fmt_buf);
+		result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
 		save_err = errno;
 		if (result < 0) {
 			fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA) Failed: %s\n",
@@ -85,7 +85,7 @@ int main(int argc, char *argv[])
 			return save_err;
 		}
 		if (verbose)
-			printf("User Format: 0x%x\n", fmt_buf[0]);
+			printf("User Format: 0x%x\n", fmtval);
 
 		qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
 		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
@@ -113,7 +113,7 @@ int main(int argc, char *argv[])
 			printf("Group Quota - ON\n");
 
 		qcmd = QCMD(Q_GETFMT, GRPQUOTA);
-		result = quotactl(qcmd, src, test_id, fmt_buf);
+		result = quotactl(qcmd, src, test_id, (caddr_t)&fmtval);
 		save_err = errno;
 		if (result < 0) {
 			fprintf(stderr, "quotactl(Q_GETFMT, GRPQUOTA) Failed: %s\n",
@@ -121,7 +121,7 @@ int main(int argc, char *argv[])
 			return save_err;
 		}
 		if (verbose)
-			printf("Group Format: 0x%x\n", fmt_buf[0]);
+			printf("Group Format: 0x%x\n", fmtval);
 
 		qcmd = QCMD(Q_QUOTAOFF, GRPQUOTA);
 		result = quotactl(qcmd, src, QFMT_VFS_V0, tgt);
-- 
2.23.1

