Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CEC432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717C52075C
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 12:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FisBO44M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0MdO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:33:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32355 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbfK0MdN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 07:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574857992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HfGjttgUyrVStfX02cc07hk2yg+7gpsLknYcexO1U34=;
        b=FisBO44MFtWjdgmF3Rs0Olqi/ZwCBUVmH+LBvfOT0yzgEbOdepcVDtpInJFRx8WJmbxfL5
        imWHHe3x6Q3diZKOePpkMWR+bpgZsZJM0CgzJdt4YMMPzaZ5p6Wb1Jq7KN977PAnTWDKHo
        0FwURL+wIwbxl2SIGYTGqubPsmzXriE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-8eBqMCFENsqiYfmOuLqX9A-1; Wed, 27 Nov 2019 07:33:10 -0500
Received: by mail-wm1-f72.google.com with SMTP id m68so2443076wme.7
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 04:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RE1IF45MOBYv5HaB6pEpTCBYHR+5Jfqlrou1w5Kn/u8=;
        b=sSS5Glvmx+SHm0c6rGewy0YCffJ+7pKnhIaAMJcyQ+PKSiG7EnvxlP9cTzLu25k5ie
         w7S6frCvoGxVRmQqmk+6k7+i34zsKGHVcMCBx2t10kjdjDBXVdWNVY5QfOVI6a3ogMUf
         Ioqtd6ATuAFMp3Zbg+CR29vaiC9JdrAvS8BxxBHMfbvVWaluIeY0Cw/MkqNYjDO+rtpE
         YNZzJPeVMAViyOjJjVEoSW328KzewZYPIN5HL7phAiwPAoarObal/3TcUr+6obprY9wG
         uZRrcA5f/Ivu5eJxNsbvnVxSk0RaGBB8zCZwlC+ktCQ3Zkr89OsYQsFGy9OGG9rNloRW
         dhdg==
X-Gm-Message-State: APjAAAXTbv947LjZhi7FyFNtudrW84NVQzK9aOvfInsAmBevAI6tqy68
        Kv9v36N1cCn/91b7vSfqb1HCXBrLQuWmHTnrLdia44o6SfBHYo1vBa2ztI0d9ppY0oSi5CmVIpT
        Kei/xBjKsrzYgCPXTKg==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr4094046wmk.18.1574857989107;
        Wed, 27 Nov 2019 04:33:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLS/7bMRKNRkWOdVTxYITr6CW7q2Hqea4Nki9w+SyYn6t2Nyvp5eyPYgS/O/fKoz1KZWHp3Q==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr4094020wmk.18.1574857988841;
        Wed, 27 Nov 2019 04:33:08 -0800 (PST)
Received: from localhost.localdomain.com ([2a02:8308:b13e:ee00:435d:e8f:90ca:755e])
        by smtp.gmail.com with ESMTPSA id m13sm6777973wmc.41.2019.11.27.04.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 04:33:08 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH testsuite v5] policy: use the kernel_request_load_module() interface
Date:   Wed, 27 Nov 2019 13:33:19 +0100
Message-Id: <20191127123319.814863-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: 8eBqMCFENsqiYfmOuLqX9A-1
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

Change in v5: call the macro only once for the whole domain
Change in v4: fix copy-paste mistakes spotted by Richard
Change in v3: use different approach as suggested by Stephen
Change in v2: update also tests/Makefile for consistency

 policy/test_key_socket.te | 8 +++-----
 policy/test_policy.if     | 6 ++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
index cde426b..64d2cee 100644
--- a/policy/test_key_socket.te
+++ b/policy/test_key_socket.te
@@ -12,8 +12,6 @@ typeattribute test_key_sock_t keysockdomain;
 # key_socket rules:
 allow test_key_sock_t self:capability { net_admin };
 allow test_key_sock_t self:key_socket { create write read setopt };
-# For CONFIG_NET_KEY=3Dm
-allow test_key_sock_t kernel_t:system { module_request };
=20
 ################## Deny capability { net_admin } #########################=
#
 #
@@ -29,7 +27,6 @@ typeattribute test_key_sock_no_net_admin_t testdomain;
 typeattribute test_key_sock_no_net_admin_t keysockdomain;
=20
 allow test_key_sock_no_net_admin_t self:key_socket { create write read set=
opt };
-allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
=20
 ####################### Deny key_socket { create } #######################=
###
 type test_key_sock_no_create_t;
@@ -50,7 +47,6 @@ typeattribute test_key_sock_no_write_t keysockdomain;
=20
 allow test_key_sock_no_write_t self:capability { net_admin };
 allow test_key_sock_no_write_t self:key_socket { create read setopt };
-allow test_key_sock_no_write_t kernel_t:system { module_request };
=20
 ####################### Deny key_socket { read } #########################=
#
 type test_key_sock_no_read_t;
@@ -61,10 +57,12 @@ typeattribute test_key_sock_no_read_t keysockdomain;
=20
 allow test_key_sock_no_read_t self:capability { net_admin };
 allow test_key_sock_no_read_t self:key_socket { create write setopt };
-allow test_key_sock_no_read_t kernel_t:system { module_request };
=20
 #
 ########### Allow these domains to be entered from sysadm domain #########=
###
 #
 miscfiles_domain_entry_test_files(keysockdomain)
 userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
+
+# For CONFIG_NET_KEY=3Dm
+kernel_request_load_module(keysockdomain)
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

