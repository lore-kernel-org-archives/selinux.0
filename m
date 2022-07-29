Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5CCC00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiG2MDB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiG2MDA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BBA1863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cocu316jVRhoeyTW9cWYvYQslMZseX7yCYpwaa9v45w=;
        b=ZsU74dsL5WTjgovQnOXPBTGZKpLVeXpq84RERAPxZGIqF/+FD9AHBLJstEGu8tV77VOIr1
        91kcTK3YWYgWQtbRdD334++xxJp8dgr5jJik/hkJlKjYr21tiR8U1Cbmn5+TEc6MXzzjxV
        rWOU1rCVMu51Ocg0Hnq6VAT0Z+4907Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-5bDkV_AnMSSOpwGMOq7IMQ-1; Fri, 29 Jul 2022 08:02:56 -0400
X-MC-Unique: 5bDkV_AnMSSOpwGMOq7IMQ-1
Received: by mail-wr1-f70.google.com with SMTP id m2-20020adfc582000000b0021e28acded7so1141298wrg.13
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=Cocu316jVRhoeyTW9cWYvYQslMZseX7yCYpwaa9v45w=;
        b=Z6fmh1wCwG2v69F0VM47SFmYKIeQkIl0VRNJGUEcMDwlveDpBl6W/0JjMgCU7bdQ4q
         rJlHGc0upxr+KS7/+EnylK/6gY5oqEDIfv7nnZLPoEh4azI+/FHZ9IdnLzRIAzTvJuVc
         +HK5WU6HEzRIyXNHZNpqYcf4ldgNHNkKy8pbwCg9y1zWqJicj/l1f/5DZWpmdT54I3Vb
         lvVCeQ9+bNoDZk512oOKBCwHhuFGsYggwUzE4VgcoVfvWo7ivO7zvb70OFECEVEG2yki
         9OtaPg3tKmSWS2AFR+O2lMSCP8PRDTrBcvmC+dM8KvptMKEMgnfi6Mx4uRrqOXyjom4b
         230A==
X-Gm-Message-State: ACgBeo3DGtw12xxm5f0XzvopRsTr3/+kuBlAyFXUHRyPWcyZfziWD1yI
        83BsDhDADbxh704yj6OVHcXtlrY7dB+10IOkDH6pH5BXeOybjpm3DxW4xJi19jmQEcduW2Gr1FJ
        UYhwYhzYhZnILwvg8pFDrmf/N2SohArNO7l3PTcQ1BhWlSUckTd2Tq87pDI9cIyioKhwzUQ==
X-Received: by 2002:a5d:4704:0:b0:21e:c011:c7ce with SMTP id y4-20020a5d4704000000b0021ec011c7cemr2194231wrq.197.1659096175123;
        Fri, 29 Jul 2022 05:02:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ljWnZBlNYNv+cZjyfmdoQSjWF1+Q97vld4Aac8+Gmno4kSMPjghlAnwyEzESl37T214J11Q==
X-Received: by 2002:a5d:4704:0:b0:21e:c011:c7ce with SMTP id y4-20020a5d4704000000b0021ec011c7cemr2194191wrq.197.1659096174496;
        Fri, 29 Jul 2022 05:02:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:53 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 14/24] tests/nnp_nosuid: avoid hardcoding unconfined_t in the policy
Date:   Fri, 29 Jul 2022 14:02:19 +0200
Message-Id: <20220729120229.207584-15-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an intermediate domain which is entered first to avoid the need to
reference the calling domain in the policy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_nnp_nosuid.te | 26 +++++++++++++---------
 tests/nnp_nosuid/test     | 45 +++++++++++++++++++++++----------------
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/policy/test_nnp_nosuid.te b/policy/test_nnp_nosuid.te
index ad5f742..8d5a1c6 100644
--- a/policy/test_nnp_nosuid.te
+++ b/policy/test_nnp_nosuid.te
@@ -3,19 +3,25 @@
 # Policy for testing NO_NEW_PRIVS and nosuid transitions.
 #
 
+# An intermediate domain to avoid referencing the caller domain.
+type test_intermediate_t;
+testsuite_domain_type(test_intermediate_t)
+# executes runcon
+corecmd_exec_bin(test_intermediate_t)
+
 # A domain bounded by the unconfined domain.
 type test_bounded_t;
 testsuite_domain_type(test_bounded_t)
-typebounds unconfined_t test_bounded_t;
+typebounds test_intermediate_t test_bounded_t;
 
 # The entrypoint type for this domain.
 type test_bounded_exec_t;
 files_type(test_bounded_exec_t)
 domain_entry_file(test_bounded_t, test_bounded_exec_t)
-domain_entry_file(unconfined_t, test_bounded_exec_t)
+domain_entry_file(test_intermediate_t, test_bounded_exec_t)
 
 # Run it!  This should succeed on v3.18 or later, fail on older kernels.
-unconfined_run_to(test_bounded_t, test_bounded_exec_t)
+domtrans_pattern(test_intermediate_t, test_bounded_exec_t, test_bounded_t)
 
 # A domain that is not bounded by the unconfined domain.
 type test_notbounded_t;
@@ -27,7 +33,7 @@ files_type(test_notbounded_exec_t)
 domain_entry_file(test_notbounded_t, test_notbounded_exec_t)
 
 # Run it!  This should fail always.
-unconfined_run_to(test_notbounded_t, test_notbounded_exec_t)
+domtrans_pattern(test_intermediate_t, test_notbounded_exec_t, test_notbounded_t)
 
 # A domain to which the unconfined domain is allowed nnp_transition.
 type test_nnptransition_t;
@@ -39,9 +45,9 @@ files_type(test_nnptransition_exec_t)
 domain_entry_file(test_nnptransition_t, test_nnptransition_exec_t)
 
 # Run it!  This should succeed on v4.14 or later.
-unconfined_run_to(test_nnptransition_t, test_nnptransition_exec_t)
+domtrans_pattern(test_intermediate_t, test_nnptransition_exec_t, test_nnptransition_t)
 ifdef(`nnp_nosuid_transition_permission_defined', `
-allow unconfined_t test_nnptransition_t:process2 nnp_transition;
+allow test_intermediate_t test_nnptransition_t:process2 nnp_transition;
 ')
 
 # A domain to which the unconfined domain is allowed nosuid_transition.
@@ -54,9 +60,9 @@ files_type(test_nosuidtransition_exec_t)
 domain_entry_file(test_nosuidtransition_t, test_nosuidtransition_exec_t)
 
 # Run it!  This should succeed on v4.14 or later.
-unconfined_run_to(test_nosuidtransition_t, test_nosuidtransition_exec_t)
+domtrans_pattern(test_intermediate_t, test_nosuidtransition_exec_t, test_nosuidtransition_t)
 ifdef(`nnp_nosuid_transition_permission_defined', `
-allow unconfined_t test_nosuidtransition_t:process2 nosuid_transition;
+allow test_intermediate_t test_nosuidtransition_t:process2 nosuid_transition;
 ')
 
 # A domain to which the unconfined domain is allowed both nosuid_transition and nnp_transition.
@@ -69,7 +75,7 @@ files_type(test_nosuidtransition_exec_t)
 domain_entry_file(test_nnpnosuidtransition_t, test_nnpnosuidtransition_exec_t)
 
 # Run it!  This should succeed on v4.14 or later.
-unconfined_run_to(test_nnpnosuidtransition_t, test_nnpnosuidtransition_exec_t)
+domtrans_pattern(test_intermediate_t, test_nnpnosuidtransition_exec_t, test_nnpnosuidtransition_t)
 ifdef(`nnp_nosuid_transition_permission_defined', `
-allow unconfined_t test_nnpnosuidtransition_t:process2 { nnp_transition nosuid_transition };
+allow test_intermediate_t test_nnpnosuidtransition_t:process2 { nnp_transition nosuid_transition };
 ')
diff --git a/tests/nnp_nosuid/test b/tests/nnp_nosuid/test
index 4e13927..bebe575 100755
--- a/tests/nnp_nosuid/test
+++ b/tests/nnp_nosuid/test
@@ -31,31 +31,36 @@ system("chcon -t test_bounded_exec_t $basedir/checkcon");
 # Create nosuid mount.
 system("mkdir -p $basedir/testdir");
 system("mount -t tmpfs -o nosuid none $basedir/testdir");
+system("chcon -t test_file_t $basedir/testdir");
 
 # Set entrypoint type for bounded domain under nosuid.
 system("cp $basedir/checkcon $basedir/testdir");
 system("chcon -t test_bounded_exec_t $basedir/testdir/checkcon");
 
+# Run everything from test_intermediate_t (to simplify the policy)
+$run = "runcon -t test_intermediate_t --";
+
 # Transition under NNP to bounded type via setexec.
 $result = system(
-"$basedir/execnnp -n -- runcon -t test_bounded_t $basedir/checkcon test_bounded_t 2>&1"
+"$run $basedir/execnnp -n -- runcon -t test_bounded_t $basedir/checkcon test_bounded_t 2>&1"
 );
 ok( $result, 0 );    #this should pass
 
 # Transition on nosuid to bounded type via setexec.
 $result = system(
-"$basedir/execnnp -- runcon -t test_bounded_t $basedir/testdir/checkcon test_bounded_t 2>&1"
+"$run $basedir/execnnp -- runcon -t test_bounded_t $basedir/testdir/checkcon test_bounded_t 2>&1"
 );
 ok( $result, 0 );    #this should pass
 
 # Automatic transition under NNP to bounded domain via exec.
 $result =
-  system("$basedir/execnnp -n -- $basedir/checkcon test_bounded_t 2>&1");
+  system("$run $basedir/execnnp -n -- $basedir/checkcon test_bounded_t 2>&1");
 ok( $result, 0 );    #this should pass
 
 # Automatic transition on nosuid to bounded domain via exec.
 $result =
-  system("$basedir/execnnp -- $basedir/testdir/checkcon test_bounded_t 2>&1");
+  system(
+    "$run $basedir/execnnp -- $basedir/testdir/checkcon test_bounded_t 2>&1");
 ok( $result, 0 );    #this should pass
 
 # Use true as an entrypoint program to test ability to exec at all.
@@ -71,25 +76,28 @@ system(
 # Transition under NNP to notbounded domain via setexec.
 $result =
   system(
-    "$basedir/execnnp -n -- runcon -t test_notbounded_t $basedir/true 2>&1");
+    "$run $basedir/execnnp -n -- runcon -t test_notbounded_t $basedir/true 2>&1"
+  );
 ok($result);    #this should fail
 
 # Transition on nosuid to notbounded domain via setexec.
 $result =
   system(
-    "$basedir/execnnp -- runcon -t test_notbounded_t $basedir/testdir/true 2>&1"
+"$run $basedir/execnnp -- runcon -t test_notbounded_t $basedir/testdir/true 2>&1"
   );
 ok($result);    #this should fail
 
 # Automatic transition under NNP to notbounded domain via exec.
 $result =
-  system("$basedir/execnnp -n -- $basedir/checkcon test_notbounded_t 2>&1");
+  system(
+    "$run $basedir/execnnp -n -- $basedir/checkcon test_notbounded_t 2>&1");
 ok($result);    #this should fail
 
 # Automatic transition on nosuid to notbounded domain via exec.
 $result =
   system(
-    "$basedir/execnnp -- $basedir/testdir/checkcon test_notbounded_t 2>&1");
+    "$run $basedir/execnnp -- $basedir/testdir/checkcon test_notbounded_t 2>&1"
+  );
 ok($result);    #this should fail
 
 if ($test_nnp_nosuid_transition) {
@@ -104,27 +112,28 @@ if ($test_nnp_nosuid_transition) {
     # Transition under NNP to nnptransition domain via setexec.
     $result =
       system(
-"$basedir/execnnp -n -- runcon -t test_nnptransition_t $basedir/true 2>&1"
+"$run $basedir/execnnp -n -- runcon -t test_nnptransition_t $basedir/true 2>&1"
       );
     ok( $result, 0 );    #this should succeed
 
     # Transition under NNP+nosuid to nnptransition domain via setexec.
     $result =
       system(
-"$basedir/execnnp -n -- runcon -t test_nnptransition_t $basedir/testdir/true 2>&1"
+"$run $basedir/execnnp -n -- runcon -t test_nnptransition_t $basedir/testdir/true 2>&1"
       );
     ok($result);         #this should fail
 
     # Automatic transition under NNP to nnptransition domain via exec.
     $result =
       system(
-        "$basedir/execnnp -n -- $basedir/checkcon test_nnptransition_t 2>&1");
+"$run $basedir/execnnp -n -- $basedir/checkcon test_nnptransition_t 2>&1"
+      );
     ok( $result, 0 );    #this should succeed
 
     # Automatic transition under NNP+nosuid to nnptransition domain via exec.
     $result =
       system(
-"$basedir/execnnp -n -- $basedir/testdir/checkcon test_nnptransition_t 2>&1"
+"$run $basedir/execnnp -n -- $basedir/testdir/checkcon test_nnptransition_t 2>&1"
       );
     ok($result);         #this should fail
 
@@ -136,28 +145,28 @@ if ($test_nnp_nosuid_transition) {
     # Transition under nosuid to nosuidtransition domain via setexec.
     $result =
       system(
-"$basedir/execnnp -- runcon -t test_nosuidtransition_t $basedir/testdir/true 2>&1"
+"$run $basedir/execnnp -- runcon -t test_nosuidtransition_t $basedir/testdir/true 2>&1"
       );
     ok( $result, 0 );    #this should succeed
 
     # Transition under NNP+nosuid to nosuidtransition domain via setexec.
     $result =
       system(
-"$basedir/execnnp -n -- runcon -t test_nosuidtransition_t $basedir/testdir/true 2>&1"
+"$run $basedir/execnnp -n -- runcon -t test_nosuidtransition_t $basedir/testdir/true 2>&1"
       );
     ok($result);         #this should fail
 
     # Automatic transition under nosuid to nosuidtransition domain via exec.
     $result =
       system(
-"$basedir/execnnp -- $basedir/testdir/checkcon test_nosuidtransition_t 2>&1"
+"$run $basedir/execnnp -- $basedir/testdir/checkcon test_nosuidtransition_t 2>&1"
       );
     ok( $result, 0 );    #this should succeed
 
     # Automatic transition under NNP+nosuid to nosuidtransition domain via exec.
     $result =
       system(
-"$basedir/execnnp -n -- $basedir/testdir/checkcon test_nosuidtransition_t 2>&1"
+"$run $basedir/execnnp -n -- $basedir/testdir/checkcon test_nosuidtransition_t 2>&1"
       );
     ok($result);         #this should fail
 
@@ -169,14 +178,14 @@ if ($test_nnp_nosuid_transition) {
     # Transition under NNP+nosuid to nnpnosuidtransition domain via setexec.
     $result =
       system(
-"$basedir/execnnp -n -- runcon -t test_nnpnosuidtransition_t $basedir/testdir/true 2>&1"
+"$run $basedir/execnnp -n -- runcon -t test_nnpnosuidtransition_t $basedir/testdir/true 2>&1"
       );
     ok( $result, 0 );    #this should succeed
 
  # Automatic transition under NNP+nosuid to nnpnosuidtransition domain via exec.
     $result =
       system(
-"$basedir/execnnp -n -- $basedir/testdir/checkcon test_nnpnosuidtransition_t 2>&1"
+"$run $basedir/execnnp -n -- $basedir/testdir/checkcon test_nnpnosuidtransition_t 2>&1"
       );
     ok( $result, 0 );    #this should succeed
 }
-- 
2.37.1

