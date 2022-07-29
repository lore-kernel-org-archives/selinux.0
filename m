Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11450C3F6B0
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiG2MDH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiG2MDF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD7AF863E2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWJKOvpkJrei2JznaxBHJz9W3S9SUpPaJmf8AqyOHLw=;
        b=AOJ73Gzhgq1ez9tgNrA/GWcUF70z3EUcFP2xfSIbRP0WodZ7GE5A7YmpH2HPufj/ADORLj
        Kjld9JC7lLEBXM8J1DEElAGHwOzYCDQlLZeSxaca+BKOWWNDyMj1oOgZm+qtPiRN5OUSAE
        sJisFNs0U3G8bbT22574y6J8R+MpMVw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-gsIvZg_5N2-zmivjQif_kQ-1; Fri, 29 Jul 2022 08:02:58 -0400
X-MC-Unique: gsIvZg_5N2-zmivjQif_kQ-1
Received: by mail-wm1-f71.google.com with SMTP id r8-20020a1c4408000000b003a2fdeea756so3431572wma.2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=qWJKOvpkJrei2JznaxBHJz9W3S9SUpPaJmf8AqyOHLw=;
        b=U3/zmlJp7QxLOrZDAbfo9eEEL4pq3Rjq2Q3fHA0eo2Z8wHkEdqIhH3QeT9PJWDv5FI
         Ux5rCgb7K03FYbyYRPwC6P2DUYSnuuzWDSrYYwDeT6BnPZmDkaHHll7wQKUbWeIELNJ4
         EJ8HCeAr8pFjHUoZqSPNm20+GeZD+YwKzj5BJOhy4bh2Q0KSgFeQJPGuStpjoVjhnCih
         vitksw+FZSfw/inBIoQkDl408ElWDByBfmrmH0ZKfAQfXf9XXGDLZllWvfnHi5AX6F90
         KpUTtDh2Zvrtl0NSEhniyk5EskoP7qKVbd9Gh2gzZIf7vqWMaiMCbALoHDUxHHcTTbvS
         +Rzw==
X-Gm-Message-State: ACgBeo1wTqlGDmcMWZPsME3f2BIrluSH1WXqN3HRCGHzwEjY2vhl8oOq
        t3jekC4G4+LVCkDeqT008L7RO/RC2ZWiIqjesrW2zFnXDN+AcNgNylTGwvif2VAQ18Gd85bK0Pg
        frNw2aUv7IfguFwz2qB8fEzpbb6xYsgbuOH1ehd2vcbBh5wEQLMpyIL9g2CD9npa9mZWgDQ==
X-Received: by 2002:a05:6000:184f:b0:21e:8380:769a with SMTP id c15-20020a056000184f00b0021e8380769amr2276824wri.591.1659096177014;
        Fri, 29 Jul 2022 05:02:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7yJ5SgjnXmOqnYKZW1uo1w7CISduG02UzZUuG/TnCUHV5ULg8bGN89gz3YMN4Q0QmBAmLd7A==
X-Received: by 2002:a05:6000:184f:b0:21e:8380:769a with SMTP id c15-20020a056000184f00b0021e8380769amr2276799wri.591.1659096176694;
        Fri, 29 Jul 2022 05:02:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 16/24] policy: remove last hardcoded references to unconfined_t
Date:   Fri, 29 Jul 2022 14:02:21 +0200
Message-Id: <20220729120229.207584-17-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace them with generic common interfaces.

For sysdadm_t we need to allow certain stuff also to ifconfig_t and
iptables_t domains due to type transitions.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te      | 24 ++++++++++++++++++++++++
 policy/test_inet_socket.te |  8 ++------
 policy/test_policy.if      | 16 ++++++++++++++++
 policy/test_sctp.te        |  2 +-
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 3862ee7..3536fbb 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -7,6 +7,9 @@ policy_module(test_policy,1.0.0)
 #
 
 attribute testsuite_domain;
+attribute testsuite_caller_domain;
+attribute testsuite_caller_ifconfig_domain;
+attribute testsuite_caller_iptables_domain;
 
 optional_policy(`
 	gen_require(`
@@ -14,6 +17,10 @@ optional_policy(`
 		role unconfined_r;
 	')
 
+	typeattribute unconfined_t testsuite_caller_domain;
+	typeattribute unconfined_t testsuite_caller_ifconfig_domain;
+	typeattribute unconfined_t testsuite_caller_iptables_domain;
+
 	# Transition from the caller to the test domain.
 	allow unconfined_t testsuite_domain:process transition;
 	role unconfined_r types testsuite_domain;
@@ -27,9 +34,26 @@ optional_policy(`
 
 optional_policy(`
 	gen_require(`
+		type sysadm_t;
 		role sysadm_r;
 	')
 
+	typeattribute sysadm_t testsuite_caller_domain;
+	typeattribute sysadm_t testsuite_caller_ifconfig_domain;
+	typeattribute sysadm_t testsuite_caller_iptables_domain;
+	optional_policy(`
+		gen_require(`
+			type ifconfig_t;
+		')
+		typeattribute ifconfig_t testsuite_caller_ifconfig_domain;
+	')
+	optional_policy(`
+		gen_require(`
+			type iptables_t;
+		')
+		typeattribute iptables_t testsuite_caller_iptables_domain;
+	')
+
 	# Authorize sysadm_r for the test domains.
 	role sysadm_r types testsuite_domain;
 
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index 5feb801..47969fc 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -130,12 +130,8 @@ corenet_inout_generic_node(test_inet_no_name_connect_t)
 #
 
 # For ipsec-load/ipsec-flush.
-gen_require(`
-	type unconfined_t;
-')
 type test_spd_t;
-allow unconfined_t inetsocketdomain:association setcontext;
-allow unconfined_t test_spd_t:association setcontext;
+testsuite_caller_association_setcontext({ inetsocketdomain test_spd_t })
 
 # Each of the test client domains must match against the SPD entry
 # in order to use labeled IPSEC.
@@ -147,7 +143,7 @@ allow test_inet_bad_client_t test_spd_t:association polmatch;
 #
 
 type test_server_packet_t;
-allow unconfined_t test_server_packet_t:packet relabelto;
+testsuite_caller_packet_relabelto(test_server_packet_t)
 allow test_inet_server_t test_server_packet_t:packet { send recv };
 allow test_inet_client_t test_server_packet_t:packet { send recv };
 
diff --git a/policy/test_policy.if b/policy/test_policy.if
index 89ab6f7..5458f6c 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -51,6 +51,22 @@ interface(`testsuite_domain_type_minimal',`
 	dontaudit $1 setrans_var_run_t:dir search;
 ')
 
+interface(`testsuite_caller_association_setcontext',`
+	gen_require(`
+		attribute testsuite_caller_ifconfig_domain;
+	')
+
+	allow testsuite_caller_ifconfig_domain $1:association setcontext;
+')
+
+interface(`testsuite_caller_packet_relabelto',`
+	gen_require(`
+		attribute testsuite_caller_iptables_domain;
+	')
+
+	allow testsuite_caller_iptables_domain $1:packet relabelto;
+')
+
 # Workarounds for refpolicy:
 
 ifdef(`dev_rw_infiniband_dev', `', ` dnl
diff --git a/policy/test_sctp.te b/policy/test_sctp.te
index e276153..8db84a3 100644
--- a/policy/test_sctp.te
+++ b/policy/test_sctp.te
@@ -213,7 +213,7 @@ corenet_inout_generic_if(sctp_asconf_deny_param_add_client_t)
 ######################### SECMARK-specific policy ############################
 #
 type test_sctp_server_packet_t;
-allow unconfined_t test_sctp_server_packet_t:packet { relabelto };
+testsuite_caller_packet_relabelto(test_sctp_server_packet_t)
 allow test_sctp_server_t test_sctp_server_packet_t:packet { send recv };
 allow test_sctp_client_t test_sctp_server_packet_t:packet { send recv };
 
-- 
2.37.1

