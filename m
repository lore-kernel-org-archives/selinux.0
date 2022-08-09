Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62819C19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 22:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiHIWOf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiHIWNw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 18:13:52 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A032B26AE8
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 15:13:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y11so9662215qvn.3
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 15:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc;
        bh=apr/FQQru3R+3gD7PBv8e+glm6uH51FeBMk6AQjIcL4=;
        b=UG989TiaOr5zltkQx/W154eGkQj36pMRZpd1tTUyRVXgH7WJ5kEAAZbty+NY3khpgR
         zJORpfGAQ1iFefKWXqSTVGFRtBhv4+S8xmRTUTQA5vR1RK6Fhh+mP23zctRCT0XykaGj
         yBb75CzbJ0s9WifklWb3xP/WBNKohSi8aI8yyBJ8z8D2rjXSuCQFVRvR9O1VkghE9OS/
         4hN1VZajGOhIL6b+F4eiY5NMSJDTmPXraDsK4bUDhkZ6fz9uUvH+UiU1N6IzQrfDyMNv
         mKrJfe8HFpwlcTcGSegZAE80vZCSSlehJI8bZpTHJ8VWB0+XQP9GWJYJCcKtHiqMrKh0
         EALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc;
        bh=apr/FQQru3R+3gD7PBv8e+glm6uH51FeBMk6AQjIcL4=;
        b=tCSvZm4A6Pcs69hSwEGAlVeI2bEgaWewHvjUJL1w9u2zuvXvXQ9dX2qOayKgeEbKX1
         vlFkLThYS/kTc5AIka51bp1K7S2jiYkuBGHg2ik/UdWG71r6A6a/5fNalcnp9ejybUGE
         Sjqd7YKVj7yHpOvNqyJPFYYj0a9r/N978BNBf8TD5nR+QgTkrPTxtb1Kii8rBwUqHzUP
         YwXlOdCoWtxq1OcCKb4mUnbbn1inYSJQ9r+YF6AQgYYNbh9ZUoDDF3VPuP2WVOoCojgz
         RQe/Md8uNw+7UJsPfwxRFU/qfetLQQY11wAWricmwiTlt9CKgne5y8cU3lctqehnHG/K
         pHUQ==
X-Gm-Message-State: ACgBeo0J/3XhqryH5Ai/1kE+lSd5nGH22LwImESYCB9mTTsMQ8LKIeqN
        W9r3YbK6lEgOyvqajdpePtWRBaHu51qj
X-Google-Smtp-Source: AA6agR6SsXjn+e9xtDQmFrho2MO/uAy+/xHWfBIRQJAxN5V+QVdo09i6sLQHkHK7pnEomX0PTH2RXA==
X-Received: by 2002:a0c:b31a:0:b0:473:8062:b1b4 with SMTP id s26-20020a0cb31a000000b004738062b1b4mr22243882qve.85.1660083208418;
        Tue, 09 Aug 2022 15:13:28 -0700 (PDT)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id ff6-20020a05622a4d8600b0033fc75c3469sm6650907qtb.27.2022.08.09.15.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:13:27 -0700 (PDT)
Subject: [PATCH] tests/sctp: reenable the SCTP ASCONF tests
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Tue, 09 Aug 2022 18:13:27 -0400
Message-ID: <166008320753.448099.17904645029315213248.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch reenables the SCTP ASCONF tests and makes them conditional
on the newly created sctp_socket/asconf_connect permission.  This
ensures that the ASCONF tests will only be run on systems which have
both a properly patched kernel and a policy which enables the new,
correct behavior.

This patch also adds the sctp_socket/bind permission to the
sctp_asconf_deny_param_add_client_t test domain as this is necessary
on patched kernels.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/test_sctp.te |    5 +----
 tests/sctp/test     |   12 ++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 363e3c5..5aec2d3 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -223,14 +223,11 @@ domain_type(sctp_asconf_deny_param_add_client_t)
 unconfined_runs_test(sctp_asconf_deny_param_add_client_t)
 typeattribute sctp_asconf_deny_param_add_client_t testdomain;
 typeattribute sctp_asconf_deny_param_add_client_t sctpsocketdomain;
-allow sctp_asconf_deny_param_add_client_t self:sctp_socket { create connect ioctl read getattr write getopt setopt };
+allow sctp_asconf_deny_param_add_client_t self:sctp_socket { create bind connect ioctl read getattr write getopt setopt };
 corenet_sctp_bind_all_nodes(sctp_asconf_deny_param_add_client_t)
 corenet_inout_generic_node(sctp_asconf_deny_param_add_client_t)
 corenet_inout_generic_if(sctp_asconf_deny_param_add_client_t)
 
-# net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
-# neverallow sctp_asconf_params_server_t sctp_asconf_deny_param_add_client_t:sctp_socket { connect };
-
 #
 ######################### SECMARK-specific policy ############################
 #
diff --git a/tests/sctp/test b/tests/sctp/test
index 5626ab8..4eefbea 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -56,12 +56,12 @@ BEGIN {
             }
         }
 
-        if ( $ipaddress[1] ne 0 and $ipaddress[0] ne $ipaddress[1] ) {
-
-# Disable ASCONF tests for now due to a known issue:
-# https://lore.kernel.org/selinux/CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com/T/
-#$test_count += 3;
-#$test_asconf = 1;
+        if (    $ipaddress[1] ne 0
+            and $ipaddress[0] ne $ipaddress[1]
+            and -e "/sys/fs/selinux/class/sctp_socket/perms/asconf_connect" )
+        {
+            $test_count += 3;
+            $test_asconf = 1;
         }
 
         # SCTP client peeloff has been fixed in kernel 5.18+

