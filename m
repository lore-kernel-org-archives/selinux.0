Return-Path: <SRS0=hQaX=ZU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2717AC432C0
	for <selinux@archiver.kernel.org>; Thu, 28 Nov 2019 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EA821741
	for <selinux@archiver.kernel.org>; Thu, 28 Nov 2019 14:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG/+XOyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfK1OH6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:07:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbfK1OH6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Nov 2019 09:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574950077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ybiaaD+9C/5/baw8fWqpp0E82h8XZA2C6duIbbTG8fs=;
        b=OG/+XOyZriZ+nBFLFodXTwoJQCzg7e8MBP5t/x8t7ZdrJWWoYbTcoU7S6nxK9gPY5ucD5x
        ZNWTHkw5c79oQqz5Hv7wUtuTSJ8Caq0gW/2m56cQag2+mj3bICYVZZjb4UKgOdTLKLFT9M
        X4ANBxDIk4GTQbz60eOsybgtHyU41tY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-NkkX4PI-Po-l1VHNiRBYIg-1; Thu, 28 Nov 2019 09:07:55 -0500
Received: by mail-wm1-f70.google.com with SMTP id f21so3606752wmh.5
        for <selinux@vger.kernel.org>; Thu, 28 Nov 2019 06:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMxJm5RfcSBUju/dwvj36Nwm3lJkZPJRN1E0Ewq8rzE=;
        b=ctyNwfMY+aPFrGRjgIHTIGl2Zfq5Xm3wSYLlw6KGUsS0Y/Rrtbzb8SwBrk0uXBPlk+
         lpQNjMBdkh8TceyRfMzkCe1rM4ugdFQa1SKY1JOArugCV811Mfg1XJ0xy9dgU1v2rlVJ
         56rAHd4WinGS3yNzl7y5axzg0eMKnobZbRBb3sQ7uFQ0DlgXsJfzhoGvqIxOr9zgp6O2
         3UD/Mj2HkhpLp4mkMQH1GxKOGVbZ7p4eOm+vWiEwjdRyjD3ULWxIcNHklR1ofVSXZCQH
         Q23ctc4F+WDAZAWe3SFpAPTmo1Yy5DB+T9dBuFm/JUqKJAA4GvuLIPHOtC4Yadea6s1F
         jm9A==
X-Gm-Message-State: APjAAAV6GsNCTHl2keynaRBkiQjsIQN6rr6Ar5k7Zw9Nqb2Wve2SaWhq
        VaG93baUK70u8VlqpgZiz0ifYvKcRgn3rx9wilslGxZI9snlL1TkECx4y418w4zLjJhKaLeZwWV
        q51ayDV2WL81PjFRNAw==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr9876765wmj.126.1574950074426;
        Thu, 28 Nov 2019 06:07:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzjlqTGy3cv1VEqFxHi1N2jEbo1GPFLUfoz6kl+9avunGJIY3hwf4ZpmZ9B+K7KcnTz0OG4FQ==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr9876732wmj.126.1574950074065;
        Thu, 28 Nov 2019 06:07:54 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l7sm4407673wrq.61.2019.11.28.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:07:53 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH testsuite v6] policy: use the kernel_request_load_module() interface
Date:   Thu, 28 Nov 2019 15:08:07 +0100
Message-Id: <20191128140807.900061-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: NkkX4PI-Po-l1VHNiRBYIg-1
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

Change in v6: avoid apostrophes in comments
Change in v5: call the macro only once for the whole domain
Change in v4: fix copy-paste mistakes spotted by Richard
Change in v3: use different approach as suggested by Stephen
Change in v2: update also tests/Makefile for consistency

 policy/test_key_socket.te | 8 +++-----
 policy/test_policy.if     | 8 +++++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

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
index e1175e8..cefc8fb 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -76,9 +76,15 @@ interface(`mount_rw_pid_files', `
 ')
 ')
=20
-# Refpolicy doesn't have admin_home_t - assume /root will be user_home_dir=
_t.
+# Refpolicy does not have admin_home_t - assume /root will be user_home_di=
r_t.
 ifdef(`userdom_search_admin_dir', `', ` dnl
 interface(`userdom_search_admin_dir', `
     userdom_search_user_home_content($1)
 ')
 ')
+
+# If the macro is not defined, then most probably module_request permissio=
n
+# is just not supported (and relevant operations should be just allowed).
+ifdef(`kernel_request_load_module', `', ` dnl
+interface(`kernel_request_load_module', `')
+')
--=20
2.23.0

