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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD85C4724C
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA35A21841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdMsCd9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEHPm2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgEHPm1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E903C05BD43
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s186so124185qkd.4
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNGp7buHWc+wi1QzcrQJU2o4gr6vKLi1sx5XT6PNCWo=;
        b=rdMsCd9erCCgaTRHrnq1tbAKOJ7Lai3TCfk3XR96Zrubf92ulveQhb3DBq/tTXuQRv
         +G+vmq5hKWGpcK/Z3bcYFyBg3Qf796y1USyrYqHoMJtADW2+asu23/Ilm75x2aQ4Cril
         qm0qyOrArTDvRKmJ8wz+CxuCFXv5XwBWaxwsgLiHTMkNHMB4H/Xnmu8iazqIDeEQsKyW
         B+Kt4uAVYX8fyZDY1Aoj4kOMBAni2GivkkVWTlaTpp5l+e6gvlJjL7rRz18PXyuoS9k8
         Yh4RFW77qoAJTqDHS1vTUD96eAFwlaCzN151Y4g3cMyz3WiKsl786twQk3j1+20HqqgE
         XDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNGp7buHWc+wi1QzcrQJU2o4gr6vKLi1sx5XT6PNCWo=;
        b=AKqxnfS3k6vwyU/dxQ85q3OXM1LnZjJP9yN4N196TRvrrlOQvKmWVWJq+EJlNQTT43
         lwJpnkgUj4Lm5YRQBOy5+hGQQRA2i+dp6kOZRE4TR9qvXckzCHjkatdqMkPuIG1mVvVh
         h/hiuFJdxA8Ggg7zU+QGellwcg9tEeXJgWKyFeeEXp0qv4OrD03fZe5KUlYCtK+WBXJM
         nzBFNaitDRVB8lhUIGPK61Lu+sRVqrpjaL9bavT8xVDFp98fOQUwN/F0v370SDfJhzby
         hqnlA3o3iF5KQgrniG2rg/pMEA+2FS6tgdnykPNCU3GW/GVuzT50cIQ8oum1RJ2EksMG
         6OxQ==
X-Gm-Message-State: AGi0Pub1ZCM8CPdJHpbPQLtoFBP8Q36q4bakJ+ZWwKiELDO04KCUso83
        mJAOri+rPGrnUbJDapBb5Q9bEUxk
X-Google-Smtp-Source: APiQypKPwCsDFVMfHoCP9T0bzpnllfzRdzPhk3LGVQFpN5dZK4a9V14O2hOtlK3GjgJa1zV7Nyf4Nw==
X-Received: by 2002:a37:b3c1:: with SMTP id c184mr3382136qkf.194.1588952546436;
        Fri, 08 May 2020 08:42:26 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:25 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 11/15] test_filesystem.te,tests/{fs_}filesystem: do not force user identity to system_u
Date:   Fri,  8 May 2020 11:41:34 -0400
Message-Id: <20200508154138.24217-12-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rather than forcing the process user identity to system_u in the
filesystem tests (which broke in Debian due to not being authorized
for unconfined_r), grant the test_filesystem_fscontext_t domain
the ability to create objects in other user identities.  This is
cleaner.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policy/test_filesystem.te | 1 +
 tests/filesystem/test     | 2 +-
 tests/fs_filesystem/test  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 7d73cbf..4e27134 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -350,6 +350,7 @@ allow test_filesystem_fscontext_t test_filesystem_filecon_t:file { getattr open
 allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:dir { add_name search write };
 allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:file { create getattr open relabelfrom write };
 allow test_filesystem_fscontext_t test_filesystem_fscontext_fs_t:filesystem { mount relabelto unmount };
+domain_obj_id_change_exemption(test_filesystem_fscontext_t)
 fs_relabelfrom_all_fs(test_filesystem_fscontext_t)
 files_search_all(test_filesystem_fscontext_t)
 allow test_filesystem_filecon_t test_filesystem_fscontext_fs_t:filesystem { associate };
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 149cc29..7d4654d 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -1116,7 +1116,7 @@ if ( not $nfs_enabled ) {
         #   system_u:object_r:test_filesystem_context_file_t:s0 from $test_opts
         print "Creating test file $basedir/mntpoint/mp1/test_file\n";
         $result = system(
-"runcon -u system_u -t test_filesystem_fscontext_t $basedir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
+"runcon -t test_filesystem_fscontext_t $basedir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
         );
         ok( $result eq 0 );
 
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 5dcc89d..5dedf83 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -1145,7 +1145,7 @@ if ( not $nfs_enabled ) {
         #   system_u:object_r:test_filesystem_context_file_t:s0 from $test_opts
         print "Creating test file $basedir/mntpoint/mp1/test_file\n";
         $result = system(
-"runcon -u system_u -t test_filesystem_fscontext_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
+"runcon -t test_filesystem_fscontext_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
         );
         ok( $result eq 0 );
 
-- 
2.23.1

