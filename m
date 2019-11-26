Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E0C43215
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 12:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28AC2073F
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 12:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFlGOtcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKZMGS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 07:06:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29621 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727547AbfKZMGR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 07:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574769975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vUKVXsi/5KPMvVWCy2HjQaPKJpGMOZOoNGzfqZhUzfw=;
        b=cFlGOtcN7Q6qdhJwiXsu2PyiGwFDeNrZzkd22VMnSysIlHBFKtIygacWga6yEFCIZJ8FNu
        A+A2t9XUMTsHfVaessvNfnO1ziFmfFoT1LXAxziuxP/F89eWi4lnjWGMPNLsLB+TmsISkM
        4Lua1cgJi3/HKrtLnWPmwgW4J2rW4q4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-A8MBW5vQPLaGVg6Mp7nviA-1; Tue, 26 Nov 2019 07:06:14 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so6496886wrq.12
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2019 04:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mUnRrij6h+Hyr+V9iSImgUTHsQp/ahjwqYM9txApq7M=;
        b=gN+NpGb5LtQ4kv4dx0BevSw3POuhiwRz/1awFhJoCUrV4B5lThdeW7pTqkEMwP2Xyd
         0ylPPRQ/RpPOrMVFK31NElezMvNsAwS0LsB0gZ8B9qWXW7qek0z8IH82qVxC2xilFAvR
         YKnzerJZULOmztSBoCm1FeMpgyvOiTTedF4VqM98H9k1M23iKHjRdJkALPQg0IuUqTXO
         4FvHSS/tXZeMEfnyOrLvSjv2z/DjYraHXqVkA/saBFTUApRG21qASoSgpJ8vxh9JaMpV
         +s4ZgFY6uDiwoQ4DW3mcVcyJ8d81PO81GmKIw4HOtx6ufsf0FyvcrNJUv6+yX3vDKErG
         7ZTA==
X-Gm-Message-State: APjAAAU47j/SJuVxNFyPSPSReXefvhp42YsQUEy+/bgD4q8Qpxf7+Ms0
        HPNAaE9hn3nq1y4jsSVeAm9lwPRrinnktKS2iN3LHEvcgnvYq2FVvrWa4RqYlJ5U3KlN9izjEfp
        XPDA8GmkYYxLDrOQZ1w==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr3848864wmj.32.1574769972921;
        Tue, 26 Nov 2019 04:06:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxO0u0W3CBoLNeKCs7vdIPJDeMvrxMkNPVcKX0ksVqJqsl1WXQr26eQzC0TNwiznTeTUDoFdA==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr3848827wmj.32.1574769972587;
        Tue, 26 Nov 2019 04:06:12 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g184sm3089647wma.8.2019.11.26.04.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 04:06:11 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH testsuite v3] policy: use the kernel_request_load_module() interface
Date:   Tue, 26 Nov 2019 13:06:23 +0100
Message-Id: <20191126120623.736870-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: A8MBW5vQPLaGVg6Mp7nviA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

...instead of open-coding the rules. Also define a fallback to allow the
policy to build even if the interface is not defined.

Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
Cc: Richard Haines <richard_c_haines@btinternet.com>
Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Change in v3: use different approach as suggested by Stephen
Change in v2: update also tests/Makefile for consistency

 policy/test_key_socket.te | 8 ++++----
 policy/test_policy.if     | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
index cde426b..f1c1606 100644
--- a/policy/test_key_socket.te
+++ b/policy/test_key_socket.te
@@ -13,7 +13,7 @@ typeattribute test_key_sock_t keysockdomain;
 allow test_key_sock_t self:capability { net_admin };
 allow test_key_sock_t self:key_socket { create write read setopt };
 # For CONFIG_NET_KEY=3Dm
-allow test_key_sock_t kernel_t:system { module_request };
+kernel_request_load_module(test_key_sock_t)
=20
 ################## Deny capability { net_admin } #########################=
#
 #
@@ -29,7 +29,7 @@ typeattribute test_key_sock_no_net_admin_t testdomain;
 typeattribute test_key_sock_no_net_admin_t keysockdomain;
=20
 allow test_key_sock_no_net_admin_t self:key_socket { create write read set=
opt };
-allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
+kernel_request_load_module(test_key_sock_t)
=20
 ####################### Deny key_socket { create } #######################=
###
 type test_key_sock_no_create_t;
@@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t keysockdomain;
=20
 allow test_key_sock_no_write_t self:capability { net_admin };
 allow test_key_sock_no_write_t self:key_socket { create read setopt };
-allow test_key_sock_no_write_t kernel_t:system { module_request };
+kernel_request_load_module(test_key_sock_t)
=20
 ####################### Deny key_socket { read } #########################=
#
 type test_key_sock_no_read_t;
@@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t keysockdomain;
=20
 allow test_key_sock_no_read_t self:capability { net_admin };
 allow test_key_sock_no_read_t self:key_socket { create write setopt };
-allow test_key_sock_no_read_t kernel_t:system { module_request };
+kernel_request_load_module(test_key_sock_t)
=20
 #
 ########### Allow these domains to be entered from sysadm domain #########=
###
diff --git a/policy/test_policy.if b/policy/test_policy.if
index e1175e8..3f163cb 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
     userdom_search_user_home_content($1)
 ')
 ')
+
+# If the macro isn't defined, then most probably module_request permission
+# is just not supported (and relevant operations should be just allowed).
+ifdef(`kernel_request_load_module', `', ` dnl
+interface(`kernel_request_load_module', `')
+')
--=20
2.23.0

