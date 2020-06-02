Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3621CC433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 17:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8BD206E2
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv1ahOIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFBRme (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRme (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 13:42:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D276C05BD1E
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 10:42:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c185so13358596qke.7
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3O8P/6OXsIdyGlnPhaOkYptUl/+IHA5s+1n+JttI3gk=;
        b=Bv1ahOIeamV4i7f5fOnnBaq1dc04qVO6wFfmRgm6mcJ5lECjHtyzoXcP07Qyesdjty
         /gYRDR1RC90dzrxtcHzJoBy0wAtN7jJHlqRAJBEPnT+WY9iE9xeNAhkBwsls7kmUt5nn
         D+7/QjfKPSIF+U/pyyBoylHwTf73WCy4oIOkzd0fldRqq7eOftkOJqZnHPO4EMX0Cznc
         OavhzJ/PirtSscoXlTksyJnwQtUG61Hv1PMmMts8daOAm7+l8gyQKB/jDSPVI4nhPuvl
         ywXaqxvCzJ5KaoLd0KLbHDL8azOW0m3jui/vvs2x6g3Ci1e+0ui7+1r7huLlTF+jjLLa
         Kttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3O8P/6OXsIdyGlnPhaOkYptUl/+IHA5s+1n+JttI3gk=;
        b=J84fNlTQ49VISjTIiTmyTlOr5NHDNkU/LFtyKjpeoeSTXBsCQnyNG1PCqxpm1zWre0
         aKk23wf9YkAvH/R5VNeOx5DDz0HtkOFt/gmyF3lMMArpExEkh0c9g+Asvy1HgQ6txGOg
         SjViTspoGoLy6VFulhF0Dzk4zqJeG+DsPHEzRlE7AF9jKW3woCxjPiO4LKJWCaAnKfmk
         a6ZQnuVbMut+Mal+NF4mQyRxlwqzCeaUnQEGo4ESeu30HvojTkXS5Ux+VcO4hCfu0Tcu
         V75+ppEDxtFUriuonC6YJr+AFYjimnCDNeV0tr8CgO/lGSw0v6eqRo52Y2wkfZccIOsz
         cRvQ==
X-Gm-Message-State: AOAM5309WDIc0yaUG7MwrVRrUdzVCHvzS9WAxVRpQWf2fEbWIud0evS+
        CQovP219LItUfCnYowPgfhngS22S
X-Google-Smtp-Source: ABdhPJzGqqPuV/lawk2zQkBg7VLi6G7XmmEaNDjXZrImGd5gW/U4tbAbC+HJL26LyWPfs5gBUDaWaw==
X-Received: by 2002:ae9:f811:: with SMTP id x17mr24959281qkh.71.1591119753369;
        Tue, 02 Jun 2020 10:42:33 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id h19sm2735260qkl.49.2020.06.02.10.42.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:42:32 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] policy/test_overlayfs.te: allow mounter to create whiteouts
Date:   Tue,  2 Jun 2020 13:42:20 -0400
Message-Id: <20200602174220.10210-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is required to pass the tests for kernels that include
commit a3c751a50fe6 ("vfs: allow unprivileged whiteout creation"),
which changed vfs_mknod() to permit whiteout creation without
requiring CAP_MKNOD and then switched vfs_whiteout() to use vfs_mknod()
rather than calling i_op->mknod() directly, which was originally done
to avoid such checking.  However, vfs_mknod() still calls the LSM hook
and therefore applies SELinux checks on whiteout creation.  Since
vfs_whiteout() now calls vfs_mknod(), SELinux :chr_file create permission
is now required for such whiteout creation by overlayfs.  Skipping the LSM
hook call or SELinux check entirely seems unsafe since we otherwise would
never check whether the process was allowed to create a file in that label;
even though the whiteout device cannot be read/written, it can be used as
a channel wrt its existence and attributes.

See the discussion in:
https://lore.kernel.org/linux-fsdevel/20200409212859.GH28467@miu.piliscsaba.redhat.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_overlayfs.te | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
index b29621e..c844b82 100644
--- a/policy/test_overlayfs.te
+++ b/policy/test_overlayfs.te
@@ -88,7 +88,7 @@ manage_dirs_pattern(test_overlay_mounter_t, test_overlay_mounter_files_t, test_o
 #
 # Needed to remove a transition file
 #
-allow test_overlay_mounter_t test_overlay_mounter_files_t:chr_file { getattr rename unlink };
+allow test_overlay_mounter_t test_overlay_mounter_files_t:chr_file { create getattr rename unlink };
 allow test_overlay_mounter_t test_overlay_files_rwx_t:chr_file { manage_chr_file_perms rename unlink };
 
 #
-- 
2.23.3

