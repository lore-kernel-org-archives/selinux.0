Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB481C3A59E
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 22:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55B2070C
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 22:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0vSjj43G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfIDWDM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:03:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37977 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfIDWDL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 18:03:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id x5so183119qkh.5
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2019 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bHAQRp0hrIgO+agLfjL/lOTMUPYOlxTKUmkd5OsuEVs=;
        b=0vSjj43GAMadgNTFa0vlNxj9rs2yFVeI/Rzx+6pmUVPd8x287PVuI8XrL0nLuvRBmq
         GYq/CF3cu7c+AR1IodQ82XAnjtpRDVusXA0vvU5Hks01Zi8WyXKB/Wp1jSMxpGI5z1EA
         xSf1OjO1PN+VuWC5LhqwA5KVdu+CIBsc6oc9mQW03A2EiZ3JDQqq1skTpq6jQiUcUst0
         EKvi7len8hMW1bCLPmgFM72qaUVt2AURz2hkRfzIBVNyP0xicxjA5gP4Y6QmuQ84xIUa
         CczCu92WBpNfCH66y9q7r8ZrrkFDbAckOf4jjfuJH9ZeDq7LmoS9utt9i01ZvjDozhs+
         hT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=bHAQRp0hrIgO+agLfjL/lOTMUPYOlxTKUmkd5OsuEVs=;
        b=rtra05yPuBQOGhjHMa7m/aniVMCnvVCOCAtRj4H3bwdpTONETEStJ4a9w8bfx0arka
         DUCwdVibN3YtfgX/7v1y8K5PBrJIyIsw/dgwUv0hMmRMmUersS4GgXEFdzuIfcx3WpGW
         2OfB4MRVM/SACtUNiErW7GmYZLvwTHUqeJnFe/RSRYpk9n17yf4IOA2+quihsxMFFZNz
         Muyi49FJiSJS4VKJkHKQW9VdGH7V7qDVEiiDvr0R5SCrVbbg/PL0Q8qFUo4f1MKi3hZR
         mnol9jkzYh/gLMz+1jl/rOX76K82x6Md+pE1TLhm5004MBY2Nx6sdALMFnFwToekyxEH
         xW0w==
X-Gm-Message-State: APjAAAXT1/efMzjW/wuJDLjTabXhl9r+2+1uljYmyzhOQ6neMPT2VKhE
        J6hYzQjdlxCh4rrELOPixsO/bEboIw==
X-Google-Smtp-Source: APXvYqyWgpjDLKHoHO1WMmU8nlUWasro6v+s5LeZuZblDyQJ0Tdjg/z32vzAu1Vzd6XJ1AGA6aWKLg==
X-Received: by 2002:a37:4ac8:: with SMTP id x191mr42394200qka.400.1567634590439;
        Wed, 04 Sep 2019 15:03:10 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id q5sm237685qte.38.2019.09.04.15.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 15:03:09 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] selinux-testsuite: don't break the system after running the
 cgroups_label tests
To:     selinux@vger.kernel.org
Date:   Wed, 04 Sep 2019 18:03:08 -0400
Message-ID: <156763458867.12445.11356660144461085311.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

Commit be0ca8feeb9b ("selinux-testsuite: ensure the cgroups_label
tests works on old and new systems"), and perhaps an earlier related
commit, broke systems after the tests were run by operating on
/sys/fs/cgroup/unified directly and not a sub-directory.  Fix this
by restoring the old (sub-directory) behavior.

Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 0 files changed

diff --git a/tests/cgroupfs_label/test b/tests/cgroupfs_label/test
index 13f0434..3accca0 100755
--- a/tests/cgroupfs_label/test
+++ b/tests/cgroupfs_label/test
@@ -6,8 +6,11 @@ BEGIN { plan tests => 2 }
 my $ret;
 
 # Older systems use /sys/fs/cgroup/unified, newer use /sys/fs/cgroup.
-my $dir = "/sys/fs/cgroup/unified";
-if ( !-d $dir ) {
+my $dir;
+if ( -d "/sys/fs/cgroup/unified" ) {
+    $dir = "/sys/fs/cgroup/unified/selinuxtest";
+}
+else {
     $dir = "/sys/fs/cgroup/selinuxtest";
 }
 

