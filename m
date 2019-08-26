Return-Path: <SRS0=L6MV=WW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6D8C3A59F
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 15:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D735F2173E
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KGcwh+31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfHZPLd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:11:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41091 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfHZPLd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Aug 2019 11:11:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so18155751qtj.8
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2019 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xqciGcZR7aK+Xw96dQtk7QoqxbhbNSseWFSeob7nLTk=;
        b=KGcwh+31qt42PMbWZC/BmG7sN7cmFJxiEtmzdlGvCf5Qe9JX89tYwNwaDi+PTPiZug
         bmj0ZlhaC+CLQsV96A3vqJpS92IIa1B1mJ9TdxEpd2EDc7wfeDjgMh/3cNPUedI8YNtY
         iIEqyzTdoz2zsFi0IO1oOXwAk0lkn6R/PlewpAPbzKtCbsL0o65admEa1DMjoSBHOD0g
         rtUjFjEzI809uEk11w7QCTIEHhdiwUgIQIPJkevCI4bsMrAlTk9nMDU/4CcD4kmjc3u0
         Mn0L1bjl/oZXLjjpNeIReWL+PP9qOqxFt45FJ0cKLBfzkySWzYooHGDFA0OL1enzvJVY
         i5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=xqciGcZR7aK+Xw96dQtk7QoqxbhbNSseWFSeob7nLTk=;
        b=eDF2uIdXGOjILjcpVwmCo5Hnk/ZZzbeOGZTnHOkFnU+Ac5PexHVF2D5AIh5jfdJFRD
         eQAp3lZwNET/eRBb+5BRKEuMlH65WFZH2SFAJ59b6r4m77vfn0zWMoOg1Lv7eexEi0Bj
         uqY5icod4AomcF/ZViqxDIasNny2WaUOJFnLuzuf30xJjY6U6O0wqXv/rdDeACEP07zI
         daVAOq88PkkgWyCKFnKLtZTcfIGmrbwNri1/tSAzoOrZM6uDWaupQtUB0o5uQbBfwpER
         T93QtM7BpnMT/9gR5FsUNHAcnnylYJLxIpWCQGOABdC6qMg7w1AzCVqAhB7+oRgKucbk
         ooVQ==
X-Gm-Message-State: APjAAAXKjEDAN/6DywUrj0TX+wSsoLkfNjKPJdi45Jl5LcVG0txsqDGQ
        0daT+wnuUVTDDsMHb0mroRPn/EV79g==
X-Google-Smtp-Source: APXvYqyMBttNmh9xK3PjlUTy9J6y+VIqA/L1guZoKWpFzV6AAJe4Emu6NyJwj71NvWmnZDKP9pSShQ==
X-Received: by 2002:ad4:420f:: with SMTP id k15mr15360456qvp.187.1566832292019;
        Mon, 26 Aug 2019 08:11:32 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id h66sm6696569qke.61.2019.08.26.08.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:11:31 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] selinux-testsuite: fix the cgroups_label test
To:     selinux@vger.kernel.org
Date:   Mon, 26 Aug 2019 11:11:30 -0400
Message-ID: <156683229042.27016.12674072161480134335.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

We can't rely on /sys/fs/cgroups/unified anymore, use our own directory.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/cgroupfs_label/test |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tests/cgroupfs_label/test b/tests/cgroupfs_label/test
index 127e802..385b953 100755
--- a/tests/cgroupfs_label/test
+++ b/tests/cgroupfs_label/test
@@ -5,24 +5,23 @@ BEGIN { plan tests => 2 }
 
 my $ret;
 
+my $dir = "/sys/fs/cgroup/selinuxtest";
+
 # Create a new cgroupfs directory and relabel it.
-mkdir("/sys/fs/cgroup/unified/test");
-system("chcon -R -t test_cgroup_t /sys/fs/cgroup/unified/test");
+mkdir("$dir");
+system("chcon -R -t test_cgroup_t $dir");
 
 # Create a subdirectory in it.
-mkdir("/sys/fs/cgroup/unified/test/subdir");
+mkdir("$dir/subdir");
 
-$ret =
-  system("test `secon -tf /sys/fs/cgroup/unified/test/subdir` = test_cgroup_t");
+$ret = system("secon -tf $dir/subdir | grep -q '^test_cgroup_t\$'");
 ok( $ret, 0 );    # Did the subdirectory inherit the parent's label?
 
-$ret = system(
-"test `secon -tf /sys/fs/cgroup/unified/test/subdir/cgroup.type` = test_cgroup_t"
-);
+$ret = system("secon -tf $dir/subdir/cgroup.type | grep -q '^test_cgroup_t\$'");
 ok( $ret, 0 );    # Did also files in the subdirectory inherit the label?
 
 # Cleanup.
-rmdir("/sys/fs/cgroup/unified/test/subdir");
-rmdir("/sys/fs/cgroup/unified/test");
+rmdir("$dir/subdir");
+rmdir("$dir");
 
 exit;

