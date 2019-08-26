Return-Path: <SRS0=L6MV=WW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC17C3A59F
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 21:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBFC217F5
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 21:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qIFm8eJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfHZVkO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:40:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44546 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfHZVkO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Aug 2019 17:40:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so15295968qke.11
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2019 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=V7XOdOKacI4Mf/XoA3kfgf9bQJ6AEMYwao0ky1qNBPM=;
        b=qIFm8eJHe6qH34x2jIw54vAlhHbWZ0c1MYfGyomkA11Ncz+Tnwd8zDLuzN+Azaa2gi
         30u1Z3G52SYiiFVsnW+bEfuvjJvUeoGDPknrvolgC/yCqSYsTp4MM9vn3uyX+nLiIcm/
         +mKPv91ZcKPYAwvdK2tpXEvRzyKXDzIkOzONyhbZsI6C3mWo/UJbh1gnG82/xbwVrE8Z
         oFmAMhUCaasc6fqcLQvHMagd7O1TplTmGEnSdWII55JZUqMHfZB5S/dYJdkPBPEaPQd2
         GJgmVIdCWp/EFAyEZFavnOqXwOzl08HWWnJPixH+4LKb1oN9N5/Chktnlf/bsAyTCpGX
         QM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=V7XOdOKacI4Mf/XoA3kfgf9bQJ6AEMYwao0ky1qNBPM=;
        b=uCVEeWOIY0J3MW2saD6YCAWDlCKzQFB+XgE3JOujFaqDQgysGxg8huiiQxIt9qYAS+
         UB/Jpm+mo+Mh3w22iQ0KfFi4PR7ox/CuoSm+aO/bH8/tb3M+aK0Fm1xAyC9NSEJWHkAH
         XSPY1N0rDy5hUbxvE0X0aP883E0R0en6V6+TaAepDWTD2GMpl79/WuFh9NrYqcbsLbnW
         Otawk3I7qcBDihZBp/TjAszhcbTcnNhBLKEBRPjPtZ2Cxq16bUzZusovsxbGEYk3Hvbi
         uivwZ3KNltf2C1SGfjCXYa9fOiG92xVMmZKUwVYtbrghEPmUCOQv51q1+3F6s9ZnKOcZ
         x6CQ==
X-Gm-Message-State: APjAAAVHorudxk68VfyGXSoxTHHmBhhwIHJWV0tA1+jgAVcBM8YwPp9X
        zsEP44VPdtkDx7proQMeeyvUwfkvTg==
X-Google-Smtp-Source: APXvYqy8sDaAjQrZUYJXz4pXRM8HDoPA0PmZozgGAH/OmSdqJfW64/95Rgzeo5Fd8svUTNZ5/kMd/Q==
X-Received: by 2002:a37:7082:: with SMTP id l124mr17725771qkc.377.1566855612254;
        Mon, 26 Aug 2019 14:40:12 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id z187sm7386450qke.99.2019.08.26.14.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 14:40:11 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] selinux-testsuite: ensure the cgroups_label tests works on
 old and new systems
To:     selinux@vger.kernel.org
Date:   Mon, 26 Aug 2019 17:40:10 -0400
Message-ID: <156685561015.29917.5393176418461343562.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

Commit 697efc910393 ("selinux-testsuite: fix the cgroups_label test")
fixed the cgroups_label test on new systems, but it broke old systems.
Try to use /sys/fs/cgroup/unified first and if that doesn't exist go
with the new approach introduced in the commit above.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/cgroupfs_label/test |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/cgroupfs_label/test b/tests/cgroupfs_label/test
index 385b953..91517b4 100755
--- a/tests/cgroupfs_label/test
+++ b/tests/cgroupfs_label/test
@@ -5,7 +5,11 @@ BEGIN { plan tests => 2 }
 
 my $ret;
 
-my $dir = "/sys/fs/cgroup/selinuxtest";
+# Older systems use /sys/fs/cgroup/unified, newer use /sys/fs/cgroup.
+my $dir = "/sys/fs/cgroup/unified";
+if (! -d $dir) {
+	$dir = "/sys/fs/cgroup/selinuxtest";
+}
 
 # Create a new cgroupfs directory and relabel it.
 mkdir("$dir");

