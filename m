Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8062C432C1
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 22:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DE52064A
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 22:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vV21aCtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391241AbfIWWQO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:16:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41690 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388785AbfIWWQO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 18:16:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so19103977qtq.8
        for <selinux@vger.kernel.org>; Mon, 23 Sep 2019 15:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=c74PYu95r/CDmhWWbpoa5GV4Oi1++gyHA+WdVS6AAEc=;
        b=vV21aCtqjff2MBX8aA/YFr2M5QSo04xoqH4Kn4+tMlEiLKMiA0xOKeWTtgQihwDBcS
         vCwyhQyaG7+2sy/gaKf/9OgIs6mr+79g2sBcSeL5a675FIHozCGPzVICjTZJP7zolEkR
         fpc7E+C9fFlgMVior1bnM8Zo8Wye2dqD1jGxxJCHSie16xQMJHXOunz55MjCDeWVKKBO
         23/T6qsrECOzt2kfSsv2XvprI3eiPEVvjXVdjXqMomgS6p4H9dR3D9rGqTlGh2cFUntT
         t4RB7AJ993j8jRxy9gJGruM3GZUEaE2hjVnqHJ2yW3pwmYsbUxe4uwFEOWOl3tzxswuo
         6b/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=c74PYu95r/CDmhWWbpoa5GV4Oi1++gyHA+WdVS6AAEc=;
        b=J2G3IThBYxfoCDbwNafQzN049BsBV1ADLzb+2uAeOsaTpoZ2FTvJDMRKm5FCjQQpdO
         A1QlZuRXGfOTQrlwBpA/8anK/mJDm/BycqaLze2D/4EBtCAdVeuXBcO16cOwQV+zVsVY
         /uPZcGRk4YrnBCMkKE0nPHtMF2j2wASOCZGfP1jE19Ofx/0smFmzja1p8+QO8iy42QGy
         cXRme2SRn53jKkezQCHjLU/HXH1GarSPNIhs8Efd8VvBBWzrKjLpLbsDEPYSDktu3Msm
         y4IUqYYB9HC790J1TMWTlbgDjjQDxGDVedAZMpTc7GlnkCTF5f6N5ZGdCWuvOZvu23np
         dWWw==
X-Gm-Message-State: APjAAAVWIwBx4q67IrZUWolycqioCdCsarshyF4cn3OtoF2OZxHc2pMI
        /2OrzAHJj7+wJ/mxgKlRv2LUwT4Lfg==
X-Google-Smtp-Source: APXvYqylKM5kjFMXIxQQFjjq95Cl7TQ/VcDYALw62bNzisEXClzo5VWTXnMul1q/HaJYNDjZoI95dg==
X-Received: by 2002:ac8:474c:: with SMTP id k12mr2552645qtp.319.1569276971186;
        Mon, 23 Sep 2019 15:16:11 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id t65sm6176266qkh.23.2019.09.23.15.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 15:16:10 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH 2/2] selinux-testsuite: apply perltidy fixes
To:     selinux@vger.kernel.org
Date:   Mon, 23 Sep 2019 18:16:09 -0400
Message-ID: <156927696982.621177.16733723208101241175.stgit@chester>
In-Reply-To: <156927687193.621177.11371002337716273956.stgit@chester>
References: <156927687193.621177.11371002337716273956.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/infiniband_endport/test |    2 +-
 tests/infiniband_pkey/test    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/infiniband_endport/test b/tests/infiniband_endport/test
index 0021e0d..f071fbc 100755
--- a/tests/infiniband_endport/test
+++ b/tests/infiniband_endport/test
@@ -40,7 +40,7 @@ ok( $result, 0 );
 
 foreach (@denied_device_port) {
     @dev_port_pair = split( / /, $_ );
-    $result = system
+    $result        = system
 "runcon -t test_ibendport_manage_subnet_t smpquery PKeyTable -C $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
 
     if ( $result >> 8 eq 0 ) {
diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
index 3ee4d13..382c259 100755
--- a/tests/infiniband_pkey/test
+++ b/tests/infiniband_pkey/test
@@ -32,7 +32,7 @@ close($f);
 
 # The gid sysfs shows a fully expanded ipv6 address, just take the
 # top half.
-@tmp = unpack( '(a20)*', $gid );
+@tmp           = unpack( '(a20)*', $gid );
 $subnet_prefix = $tmp[0] . ":";
 
 @labeled_pkeys = split( /,/, $conf{SELINUX_INFINIBAND_TEST_LABELED_PKEYS} );

