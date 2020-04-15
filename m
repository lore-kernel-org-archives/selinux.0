Return-Path: <SRS0=gWJv=57=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951ADC38A2C
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA42206D5
	for <selinux@archiver.kernel.org>; Wed, 15 Apr 2020 19:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="whpV6Qr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411742AbgDOTHk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416835AbgDOSh4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 14:37:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A66C061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 11:37:55 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g74so18415915qke.13
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ln//gvffMfNjbGWl0+vZdUUFWhdnOcdZ3DjxISlLwFs=;
        b=whpV6Qr3NkYRQBNI1hUluw3NXUTp5RfIpGArjcq36qaIkNJ+H3DMeU2+f6PsoA5+k+
         x0Cox61BG/H50BOhtlpaf8x+exLEZi1O3rIJUlkFj+uJbeVnne6lB3bWESHp+Z4qHQna
         4TwSBYx7QKvNqKw8TJ3SEcEjahbtbo97SNeTZtnNSpIgmEc0KVdlAuMVGjQNn3ubGapO
         HgtFEhB5ZbL3sUh8h2pbVg56GAw0jNPx72olh+1ScwW6ymieEXGk4odJbRLHiL2C6S5q
         dywvechuV3iFj96baTwCaeiE2BHBYkbnTlMZPffo8fyodqOCsm2A68dup3R3FhbFKqBX
         aWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=ln//gvffMfNjbGWl0+vZdUUFWhdnOcdZ3DjxISlLwFs=;
        b=P09GLPSy5WZCvErNv3jQ+6LpYpmAEvrE98sgzHe+nnp/MCQVuI8Mtlky81FcXXzlKa
         wo8rUTelI2K5TRQ8KjeQ0oXTd7z1ARGl17m7hyGiqNVPizCTGhc74gf6vIZDhrLT3nst
         y7NQhzgdezvt4RKuNb240n9WIiMfEM9GmJ2i6P7qVLzH53fBJVZIyPKzAkQgZnR6x4Dt
         dVAWkFt8MfAyyk7vCGrzI6XQbXXhNdCNqa6gDT/LkI3QpmFRvbsZ8BDeNKss7Du9p4Qb
         wTxfxPOTYo5kYTfi43esNtymNtSYS5tMrAZ5Ln0uflmrmZfem6s78Lt/nvW4qjwZEQA5
         qZqQ==
X-Gm-Message-State: AGi0PuaKZHJM+kejXrMGUyESuKiHzBkPX450MGqvb2RVQzC64O0Je+5p
        ZNOka3voEWM7pzzwvJpvlNDEXNN9HA==
X-Google-Smtp-Source: APiQypI70IxZVYq7hMNhhoxIc65o9yGuIujReQ/Yb7g3blnhyXt7KYAkH6Hay+mEaQ8d92x8V8LAoQ==
X-Received: by 2002:a37:4d5:: with SMTP id 204mr27986057qke.176.1586975874329;
        Wed, 15 Apr 2020 11:37:54 -0700 (PDT)
Received: from localhost (pool-71-245-238-133.bstnma.fios.verizon.net. [71.245.238.133])
        by smtp.gmail.com with ESMTPSA id g187sm12874932qkf.115.2020.04.15.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:37:53 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
X-Google-Original-From: Paul Moore <pmoore2@cisco.com>
Subject: [PATCH] selinux-testsuite: add capability:sys_admin to the bpf()
 related test domains
To:     selinux@vger.kernel.org
Date:   Wed, 15 Apr 2020 14:37:52 -0400
Message-ID: <158697587242.118532.14560996990720692395.stgit@chester>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Paul Moore <paul@paul-moore.com>

Historically the Fedora Kernels have been built with the
kernel.unprivileged_bpf_disabled set to 0, which skipped a
CAP_SYS_ADMIN check in the bpf() syscall.  However, starting
with the Fedora Rawhide v5.7-rcX kernel builds this sysctl
is now set to 1 which is triggering a CAP_SYS_ADMIN check
when performing bpf() operations.

Add the capability:sys_admin to the BPF test domains so they can
pass this newly triggered check.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/test_binder_bpf.te    |    2 +-
 policy/test_bpf.te           |   12 ++++++------
 policy/test_fdreceive_bpf.te |    6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/policy/test_binder_bpf.te b/policy/test_binder_bpf.te
index c545846..83c65b1 100644
--- a/policy/test_binder_bpf.te
+++ b/policy/test_binder_bpf.te
@@ -33,7 +33,7 @@ allow_map(test_binder_bpf_provider_t, device_t, chr_file)
 allow test_binder_bpf_provider_t test_file_t:fifo_file { rw_file_perms };
 # For testing BPF map fd transfer:
 allow test_binder_bpf_provider_t self:bpf { map_create map_read map_write prog_load prog_run };
-allow test_binder_bpf_provider_t self:capability { sys_resource };
+allow test_binder_bpf_provider_t self:capability { sys_resource sys_admin };
 allow test_binder_bpf_provider_t self:process { setrlimit };
 
 #
diff --git a/policy/test_bpf.te b/policy/test_bpf.te
index c9c0bc5..38b7729 100644
--- a/policy/test_bpf.te
+++ b/policy/test_bpf.te
@@ -12,7 +12,7 @@ typeattribute test_bpf_t testdomain;
 typeattribute test_bpf_t bpfdomain;
 
 allow test_bpf_t self:process { setrlimit };
-allow test_bpf_t self:capability { sys_resource };
+allow test_bpf_t self:capability { sys_resource sys_admin };
 allow test_bpf_t self:bpf { map_create map_read map_write prog_load prog_run };
 
 ############################## Deny map_create #############################
@@ -23,7 +23,7 @@ typeattribute test_bpf_deny_map_create_t testdomain;
 typeattribute test_bpf_deny_map_create_t bpfdomain;
 
 allow test_bpf_deny_map_create_t self:process { setrlimit };
-allow test_bpf_deny_map_create_t self:capability { sys_resource };
+allow test_bpf_deny_map_create_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_map_create_t self:bpf { map_read map_write prog_load prog_run };
 
 ############################## Deny map_read ##############################
@@ -34,7 +34,7 @@ typeattribute test_bpf_deny_map_read_t testdomain;
 typeattribute test_bpf_deny_map_read_t bpfdomain;
 
 allow test_bpf_deny_map_read_t self:process { setrlimit };
-allow test_bpf_deny_map_read_t self:capability { sys_resource };
+allow test_bpf_deny_map_read_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_map_read_t self:bpf { map_create map_write prog_load prog_run };
 
 ############################## Deny map_write ##############################
@@ -45,7 +45,7 @@ typeattribute test_bpf_deny_map_write_t testdomain;
 typeattribute test_bpf_deny_map_write_t bpfdomain;
 
 allow test_bpf_deny_map_write_t self:process { setrlimit };
-allow test_bpf_deny_map_write_t self:capability { sys_resource };
+allow test_bpf_deny_map_write_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_map_write_t self:bpf { map_create map_read prog_load prog_run };
 
 ############################## Deny prog_load ##############################
@@ -56,7 +56,7 @@ typeattribute test_bpf_deny_prog_load_t testdomain;
 typeattribute test_bpf_deny_prog_load_t bpfdomain;
 
 allow test_bpf_deny_prog_load_t self:process { setrlimit };
-allow test_bpf_deny_prog_load_t self:capability { sys_resource };
+allow test_bpf_deny_prog_load_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_prog_load_t self:bpf { map_create map_read map_write prog_run };
 
 ############################## Deny prog_run ###############################
@@ -67,7 +67,7 @@ typeattribute test_bpf_deny_prog_run_t testdomain;
 typeattribute test_bpf_deny_prog_run_t bpfdomain;
 
 allow test_bpf_deny_prog_run_t self:process { setrlimit };
-allow test_bpf_deny_prog_run_t self:capability { sys_resource };
+allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin };
 allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
 
 #
diff --git a/policy/test_fdreceive_bpf.te b/policy/test_fdreceive_bpf.te
index 961de79..39ee3e5 100644
--- a/policy/test_fdreceive_bpf.te
+++ b/policy/test_fdreceive_bpf.te
@@ -15,7 +15,7 @@ allow test_fdreceive_bpf_client_t test_fdreceive_file_t:file { rw_file_perms };
 allow test_fdreceive_bpf_client_t test_file_t:sock_file { rw_sock_file_perms };
 allow test_fdreceive_bpf_client_t test_fdreceive_server_t:unix_stream_socket { connectto };
 allow test_fdreceive_bpf_client_t self:bpf { map_create map_read map_write prog_load prog_run };
-allow test_fdreceive_bpf_client_t self:capability { sys_resource };
+allow test_fdreceive_bpf_client_t self:capability { sys_resource sys_admin };
 allow test_fdreceive_bpf_client_t self:process { setrlimit };
 # Server side rules:
 allow test_fdreceive_server_t test_fdreceive_bpf_client_t:fd { use };
@@ -33,7 +33,7 @@ allow test_fdreceive_bpf_client2_t test_fdreceive_file_t:file { rw_file_perms };
 allow test_fdreceive_bpf_client2_t test_file_t:sock_file { rw_sock_file_perms };
 allow test_fdreceive_bpf_client2_t test_fdreceive_server_t:unix_stream_socket { connectto };
 allow test_fdreceive_bpf_client2_t self:bpf { prog_load prog_run };
-allow test_fdreceive_bpf_client2_t self:capability { sys_resource };
+allow test_fdreceive_bpf_client2_t self:capability { sys_resource sys_admin };
 allow test_fdreceive_bpf_client2_t self:process { setrlimit };
 # Server side rules:
 allow test_fdreceive_server_t test_fdreceive_bpf_client2_t:fd { use };
@@ -49,7 +49,7 @@ allow test_fdreceive_bpf_client3_t test_fdreceive_file_t:file { rw_file_perms };
 allow test_fdreceive_bpf_client3_t test_file_t:sock_file { rw_sock_file_perms };
 allow test_fdreceive_bpf_client3_t test_fdreceive_server_t:unix_stream_socket { connectto };
 allow test_fdreceive_bpf_client3_t self:bpf { map_create map_read map_write };
-allow test_fdreceive_bpf_client3_t self:capability { sys_resource };
+allow test_fdreceive_bpf_client3_t self:capability { sys_resource sys_admin };
 allow test_fdreceive_bpf_client3_t self:process { setrlimit };
 # Server side rules:
 allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:fd { use };

