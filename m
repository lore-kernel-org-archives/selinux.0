Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C4C25B06
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 22:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiHIWOD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHIWNp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 18:13:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB625EA8
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 15:13:22 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u24so2210768qku.2
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc;
        bh=c30nFcJ3ukH3Rz9VUiATBlVGcvTdhGVYgI+30nwA/6U=;
        b=0G+fd8U/Xvbu2jPodimfiP0f96hoPdpueB7hoVQf5AM3JEy0JMyDSy4t1WVzr/dLwk
         VFZkk/H98VEzNXrXcNJIXiYKJMDI2mGy9s2cc8VExqdVQpUcEVOE2IwOuLwR0G7j21we
         DJwv3JnDqYegnMiPvT3F3VxmY/oS0ICjr2FXCflI1UsAdyHUZRzFNNmkEBVKYWs35+UW
         sKrEw3n95bd53f7/+5k/GSaqfMq7dUGK12n06IbQmW75kYP1hCimfZkniRxoay+LrjOp
         V3QJQLqK6AT5syWN7Rh4Ap5p34Hu3HtyGffQ48KWNs61kUKv/pvHR4srIySNeSZnexGy
         bR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc;
        bh=c30nFcJ3ukH3Rz9VUiATBlVGcvTdhGVYgI+30nwA/6U=;
        b=xqs7uCM5Hia5W0cKLlBnUnJIJY2qhKX4S+3I1mEUaVWJVUQKe5d+AnOuekwG46DqIb
         9tA7Fh70p8FLITE7Z0T838H2EditxImaKcy825Lyrhg6pA1AGj5Fresp0gWhLYjAyF/4
         PRf/UmULo7hAyqfXC3Ds6DQcpdKQgVDJVLqy1nB47yskP/tbIUs4j80zKqzDfwMAZkGi
         xlQO5RB/nlFRqp/MKEzRlC/ukQd3PGK+xRTzjwmJHeKbX74hvprYs0uXMe3aSn/OL900
         djU9L1oGHkjOE+Qtgm0oBxsQO78frAIhEWfyUCpxRbdfIfagcWfU85EaIwdXbdBoSB/L
         kQwg==
X-Gm-Message-State: ACgBeo0rqghl2KVx4YM5ujO3AnZTFJlQ4g3V5vNJo7kXEYQ5x7a4+2te
        HMkF6nLeeYwqN6Vt8Fb3JJeIOPjn0TUQ
X-Google-Smtp-Source: AA6agR6wZcXeaGRvps5O2ciQQGJm4hhq+QLeZ0eNbn81Re0pT25wggQUDadLtFkF3XIon0GDy9Z3lg==
X-Received: by 2002:ae9:e64b:0:b0:6b9:8566:ea5b with SMTP id x11-20020ae9e64b000000b006b98566ea5bmr2780626qkl.311.1660083200758;
        Tue, 09 Aug 2022 15:13:20 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id e9-20020ac845c9000000b0031ee3449f34sm10568390qto.86.2022.08.09.15.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:13:19 -0700 (PDT)
Subject: [PATCH] tests/sctp: allow both ENOSPC and EINPROGRESS for CIPSO tag
 space errors
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 09 Aug 2022 18:13:19 -0400
Message-ID: <166008319941.447963.8509896484646848800.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If the NetLabel subsystem in the kernel is configured to apply CIPSO
packet labels directly to the packets instead of the sockets, the
kernel will return EINPROGRESS on a failed connect(2) instead of
ENOSPC.  This is due to differences in how the CIPSO labels are
applied to network traffic in the two cases and how the error
conditions are able to be propagated back to userspace.

This patch allows both error codes to the relevant SCTP test cases.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/sctp/test |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/sctp/test b/tests/sctp/test
index 69dcbef..5626ab8 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -508,7 +508,7 @@ $pid = server_start( "-t test_sctp_server_t -l s0:c20.c300",
 # TAG 1 allows categories 0 to 239 to be sent
 $result = system
 "runcon -t test_sctp_client_t -l s0:c20.c300 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
-ok( $result >> 8 eq 7 );
+ok( ( $result >> 8 eq 7 ) || ( $result >> 8 eq 6 ) );
 
 if ($test_clpeeloff) {
 
@@ -675,7 +675,7 @@ $pid = server_start( "-t test_sctp_server_t -l s0:c20.c335",
 # TAG 2 allows a maximum of 15 categories in exchange
 $result = system
 "runcon -t test_sctp_client_t -l s0:c200.c216 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
-ok( $result >> 8 eq 7 );
+ok( ( $result >> 8 eq 7 ) || ( $result >> 8 eq 6 ) );
 
 if ($test_clpeeloff) {
 
@@ -842,7 +842,7 @@ $pid = server_start( "-t test_sctp_server_t -l s0:c20.c50",
 # TAG 2 allows a maximum of 7 ranges in exchange
 $result = system
 "runcon -t test_sctp_client_t -l s0:c20,c22,c24,c30.c33,c38,c42.c45,c48,c50 -- $basedir/sctp_client $v seq 127.0.0.1 1035 2>&1";
-ok( $result >> 8 eq 7 );
+ok( ( $result >> 8 eq 7 ) || ( $result >> 8 eq 6 ) );
 
 if ($test_clpeeloff) {
 

