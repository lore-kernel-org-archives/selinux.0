Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F983C00140
	for <selinux@archiver.kernel.org>; Wed, 24 Aug 2022 16:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiHXQsa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Aug 2022 12:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiHXQs3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Aug 2022 12:48:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D34E635
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 09:48:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b9so13129071qka.2
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc;
        bh=aoU49BBprQ6LhvvTH5nB2KDudCsVrjVudMfltBHTWSI=;
        b=JdRvShc5R9dYzECP3W0Fb18m2HVTCGsLHFbQGco0OOQWgXxSk1vT5jBXNFnk1cYmBc
         YOwKqHVdAgpBN/ohp/zCPuA+d7PqSm+GMBeKQ52Ca6+z++bbyASm6jJI5/Fum5Flvxeu
         O/152kz3Om9eKxpusvn5rYdlOgTPlNowkJePkZSMdrTUxlLwxQotAeDX3pw7VUPhThD9
         Hhjwx5Qxo0buoiQh0Bv7s9MP+fGxW2Weu8H2nRCZisotGPXZTd/6vuQIhv11sg5J/nz7
         ukWMag++VVohWR2IRczfW1IHVgsFf5cV0y5u5MFa0GMWPqWPFAYgcHyPA3sQ2O1LYZuV
         l10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc;
        bh=aoU49BBprQ6LhvvTH5nB2KDudCsVrjVudMfltBHTWSI=;
        b=FtI+jZ+JwCzc7XclKD8tbX2/Csx6Tt/teF/XWCz28/NB6MSUjqqXx9bjK9UzGUn8Vr
         nDAbZn1DpSbpuju1zLmGwEq6NtxmU+qFu+LdJSYAGh31+4AgYZTp0tJbAFCyCKx8VDly
         m+6Yd9nhXTRUTjQrmWvcSZ3WboIxrOwjU17pkf7OB1TgXrjMDqNnSEBpEe28gNrfg7bz
         yRGSrAYpwewPEPkJvvnzzDqD2CC9VxbCrDP1C2RFfg0S+VDSte7Ot66YcgH/2n/6G2TX
         bhEGmFoVTclaU/62wmBN1jqN3vDE6P74z3QBoTn3bEfnvWI4jfmdm07Lx9Dz4Tpsmx/q
         RbSg==
X-Gm-Message-State: ACgBeo3xm7JrYJLk9awJO0cEbmPwr1z7mBdD6rXffq6rh8g60qtmS+da
        ANPyP/OAEy24bbTozNcIxZ3WhGR7zA4V
X-Google-Smtp-Source: AA6agR6b3or6AX0lIvjX+1znV8/el+OC1Pbf93Yen4te4gGu+JVSJYZmfVxOik/LLkfaNey1Z8DiiQ==
X-Received: by 2002:a05:620a:1393:b0:6bb:2b7c:5901 with SMTP id k19-20020a05620a139300b006bb2b7c5901mr58475qki.783.1661359705978;
        Wed, 24 Aug 2022 09:48:25 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id t13-20020a05622a01cd00b00342f8143599sm13267609qtw.13.2022.08.24.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:48:25 -0700 (PDT)
Subject: [PATCH] tests/filesystem/xfs: use a 300M xfs filesystem image
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Wed, 24 Aug 2022 12:48:25 -0400
Message-ID: <166135970524.184778.17486058814645360372.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Recent versions of mkfs.xfs require at least a 300M image to work
properly which unfortunately causes a large number of xfs test
failures as the test suite only allocates 16M for a filesystem
image.  This patch increases the xfs image size to 300M while
leaving the existing 16M image size for all other filesystem types.

This was first noticed with xfsprogs v5.19.0 but it is possible
earlier versions are also affected.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/filesystem/Filesystem.pm |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index e3cd8ee..bd91a11 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -122,10 +122,14 @@ sub attach_dev {
 
 sub make_fs {
     my ( $mk_type, $mk_dev, $mk_dir ) = @_;
+    my $mk_size = 16;
+    if ( $mk_type eq "xfs" ) {
+        $mk_size = 300;
+    }
     print "Create $mk_dir/fstest with dd\n";
     $result =
       system(
-        "dd if=/dev/zero of=$mk_dir/fstest bs=4096 count=4096 2>/dev/null");
+        "dd if=/dev/zero of=$mk_dir/fstest bs=1M count=$mk_size 2>/dev/null");
     if ( $result != 0 ) {
         print "dd failed to create $mk_dir/fstest\n";
     }

