Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE9BC432C0
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 15:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918CC2071E
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 15:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHIW09RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfKZPsW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:48:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727538AbfKZPsW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 10:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574783300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+ZUsOWzUVwwCxxPzuDgMPrlLBYI8zqo0bAItWLxRrew=;
        b=bHIW09RZoC3eDeEnzT8CKWUh4MqNYT9woZ57M51Yq7xz/3byT7+veQq19OSso7Azlz7nDw
        b8MeJ0GEVQD4/rwZ9P9PwDPe/thh2gJQY+Nqg+E3fTpS5zfPzUcRmWAIdLkQZLUjAQJj1W
        HbIJValpqRT4eTGUP5HJGFuDmVeJQZ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-hRHBvirPN3OOcZuBEpxZww-1; Tue, 26 Nov 2019 10:48:16 -0500
Received: by mail-wr1-f72.google.com with SMTP id l20so898056wrc.13
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2019 07:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bJgcYZDe4hw29LlJ+VFgeTuKElI3/SyODCMncW6QrAY=;
        b=BYuSJt6mQ73vB/QnipDLUzwT0KaxcTUnEewASW4heHJbiGZfTGXYZO/9DWNDyDFuu8
         ESOmVzmu/ATztmB91Dav0QxVVoHtUXVQf0ndtLPBgQmen/BEtxq7ZXPMS1INx/jTWG5x
         voYrfetnApAwMomX9XW15SzPBOt7b9d2cXMW1ii3ib9DfKfH5XVLcIC8lwemf9msFRKM
         nH/4LeK6KT05Aw2REXz8TRA7j25VwKseTm27EkyV9stgXy8+UJ4Ti77TggSqMi8n2McG
         mziqqpzPCv8upIw3Xjh+1qtUsZU5+Mn9UBJf/odqS3QQ/FhcceFegtfamJo68wuPhQna
         rfnA==
X-Gm-Message-State: APjAAAXHYNivfcDhYCGFWXwt1wTs4ducEBctya+5tpE3VpyVjn4e5S0e
        r/1ENQ13JUwmeKZG1ri40fP5jZwCB9PvIetoYe8SyY1RDzQU+j8FkFKZLNYsQdpVQ0RSBBFG7Yl
        5kZIG96TqL/ElTMsGBQ==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr5209704wmb.40.1574783295136;
        Tue, 26 Nov 2019 07:48:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJxvSzyTi9jOIx3IryDZjXB9CKAXje3MQz0Kra1Ix2dzNFuDFzpnzC5OY6Hxsvvg3e687CNQ==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr5209687wmb.40.1574783294862;
        Tue, 26 Nov 2019 07:48:14 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l10sm16764644wrg.90.2019.11.26.07.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 07:48:14 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH testsuite v4] policy: use the kernel_request_load_module() interface
Date:   Tue, 26 Nov 2019 16:48:25 +0100
Message-Id: <20191126154825.754108-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: hRHBvirPN3OOcZuBEpxZww-1
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
Change in v4: fix copy-paste mistakes spotted by Richard
Change in v3: use different approach as suggested by Stephen
Change in v2: update also tests/Makefile for consistency

 policy/test_key_socket.te | 8 ++++----
 policy/test_policy.if     | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
index cde426b..7be8ac0 100644
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
+kernel_request_load_module(test_key_sock_no_net_admin_t)
=20
 ####################### Deny key_socket { create } #######################=
###
 type test_key_sock_no_create_t;
@@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t keysockdomain;
=20
 allow test_key_sock_no_write_t self:capability { net_admin };
 allow test_key_sock_no_write_t self:key_socket { create read setopt };
-allow test_key_sock_no_write_t kernel_t:system { module_request };
+kernel_request_load_module(test_key_sock_no_write_t)
=20
 ####################### Deny key_socket { read } #########################=
#
 type test_key_sock_no_read_t;
@@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t keysockdomain;
=20
 allow test_key_sock_no_read_t self:capability { net_admin };
 allow test_key_sock_no_read_t self:key_socket { create write setopt };
-allow test_key_sock_no_read_t kernel_t:system { module_request };
+kernel_request_load_module(test_key_sock_no_read_t)
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

