Return-Path: <SRS0=BfnB=EE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C9C2D0A3
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A1A20791
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/e75OWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJ2I2d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Oct 2020 04:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbgJ2I2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Oct 2020 04:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603960111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a7LLX3U8LJ9L+0n9HNDt/x9495V16MR6bctLlfh5KWI=;
        b=V/e75OWSzj3Kp5qiG5LTt0AHq6jlx3N0PBy5IiXc5W6ccSVJfqLGe2xsIc9R4o+xhyDTGg
        q6MJ9pL1z5+48AfvxZqoEg7kOYeA6gznegX0n3TiFs+f6wwQJ5/LWl6jKCcWlmdxpAdBms
        sPDB+0ko8s+nL7ZF/doBO6mpj3RChfU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-F_K3kZS2Nmu5a8iWSEh6mA-1; Thu, 29 Oct 2020 04:28:28 -0400
X-MC-Unique: F_K3kZS2Nmu5a8iWSEh6mA-1
Received: by mail-ed1-f70.google.com with SMTP id n16so863122edw.19
        for <selinux@vger.kernel.org>; Thu, 29 Oct 2020 01:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7LLX3U8LJ9L+0n9HNDt/x9495V16MR6bctLlfh5KWI=;
        b=msKUkxvSLWPd3vAv+FL6yWPSS8JWP4HgNBkV2L+XqsTojlJ+cXkXjrsnv0+jowk71T
         poIKaoNXVbtPhEJbr1+dtZ4yCnF1m/sE1zC+2XViut+zsSmxyB01dPoFhAYo91T3vRwb
         JiI6TXsBWE5k6212Opr9P1hEvJ3HNtTfsRsOYtvi/o9XjNA1+BPsTtxaV3D0DbXkg0iq
         nslV8T1+9SsFIcVagqkSfzYVfd3mPxKA+EKYjxuQeapmaJ4aCs3uYInyFjdHzzAUa/1b
         mFg5Ym9n28J14yhwTFbbMx3tX5EWv0dJaWrg6UtyPadbtrX1aaL8mDZBPpHUMmxQQeGH
         as0A==
X-Gm-Message-State: AOAM533fZ5iCpdAxaHKRp37DCqcwRNwsDcq8rSSXsDDJJ18Y1+YibTtv
        inzV4oVkuvzcI6s7CDBfjAqVW8D6ZLmpU6ZGSw1B5bdczdvzHjENDhWUFdwQtdDbGPLeFYs9ztH
        rmtW/UavQqdc04awUOw==
X-Received: by 2002:a17:906:d7ad:: with SMTP id pk13mr484939ejb.196.1603960107379;
        Thu, 29 Oct 2020 01:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycw/dT/pDTp5aF+TWU6gvemZyMoyGilNXC0gv+aRV4TjcdV/5CESIP8aCz5Xy7btt58JSIUQ==
X-Received: by 2002:a17:906:d7ad:: with SMTP id pk13mr484926ejb.196.1603960107162;
        Thu, 29 Oct 2020 01:28:27 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id v10sm1045717ejk.101.2020.10.29.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 01:28:26 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] test_sctp.te: avoid use of corenet_sctp_bind_generic_node()
Date:   Thu, 29 Oct 2020 09:28:24 +0100
Message-Id: <20201029082824.1328401-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

RHEL-7 policy doesn't have it and we only check for
corenet_sctp_bind_all_nodes() in the Makefile. Change the uses of
corenet_sctp_bind_generic_node() to corenet_sctp_bind_all_nodes() to
match the pattern used in the rest of the file.

Fixes: 841ccaabb366 ("selinux-testsuite: Update SCTP asconf client/server")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_sctp.te | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index 793f451..363e3c5 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -188,8 +188,8 @@ unconfined_runs_test(sctp_asconf_params_client_t)
 typeattribute sctp_asconf_params_client_t testdomain;
 typeattribute sctp_asconf_params_client_t sctpsocketdomain;
 allow sctp_asconf_params_client_t self:sctp_socket { create connect ioctl read getattr write getopt setopt };
+corenet_sctp_bind_all_nodes(sctp_asconf_params_client_t)
 corenet_inout_generic_node(sctp_asconf_params_client_t)
-corenet_sctp_bind_generic_node(sctp_asconf_params_client_t)
 corenet_inout_generic_if(sctp_asconf_params_client_t)
 
 # When running locally need this rule, else Client error 'Dynamic Address Reconfiguration'
@@ -206,8 +206,8 @@ unconfined_runs_test(sctp_asconf_deny_pri_addr_client_t)
 typeattribute sctp_asconf_deny_pri_addr_client_t testdomain;
 typeattribute sctp_asconf_deny_pri_addr_client_t sctpsocketdomain;
 allow sctp_asconf_deny_pri_addr_client_t self:sctp_socket { create connect ioctl read getattr write getopt setopt };
+corenet_sctp_bind_all_nodes(sctp_asconf_deny_pri_addr_client_t)
 corenet_inout_generic_node(sctp_asconf_deny_pri_addr_client_t)
-corenet_sctp_bind_generic_node(sctp_asconf_deny_pri_addr_client_t)
 corenet_inout_generic_if(sctp_asconf_deny_pri_addr_client_t)
 
 # net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
@@ -224,8 +224,8 @@ unconfined_runs_test(sctp_asconf_deny_param_add_client_t)
 typeattribute sctp_asconf_deny_param_add_client_t testdomain;
 typeattribute sctp_asconf_deny_param_add_client_t sctpsocketdomain;
 allow sctp_asconf_deny_param_add_client_t self:sctp_socket { create connect ioctl read getattr write getopt setopt };
+corenet_sctp_bind_all_nodes(sctp_asconf_deny_param_add_client_t)
 corenet_inout_generic_node(sctp_asconf_deny_param_add_client_t)
-corenet_sctp_bind_generic_node(sctp_asconf_deny_param_add_client_t)
 corenet_inout_generic_if(sctp_asconf_deny_param_add_client_t)
 
 # net/sctp/sm_make_chunk.c sctp_process_asconf_param() SCTP_PARAM_ADD_IP and SCTP_PARAM_SET_PRIMARY
-- 
2.26.2

