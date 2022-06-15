Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8225C43334
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 12:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbiFOM1V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiFOM1V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 08:27:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C842A02
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kq6so22879060ejb.11
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8/on9opuZ920YXronzGYq3QYxz/vSqgkVDQs6K5nWz4=;
        b=f+VeU2DYuF/43+uey/jhEgyn6PDMEy8myOg2OPVat1RAgVRfu5vrNiEQDwuF3v+BTh
         ZfVyIxj7idruGbZU+TWkw5th3wSiM82Nkzh4bOODdPMxIrSgMwPBF97sVEIBzKL/4YH7
         SlO/7EIjRcDQVqa7CvMiZRtpcKGbRlCarQittUqcyqQ7JPVdY1kbtlu/+oh4F3oMASVp
         5AkDWCel24z23NfOPeG5QzOlNcBEUkJYSUTYVRT1Y+R+uVSZoMkIsUUguluP19t2Udzz
         TbKXJgp8Kdv8j86xu5dvuWQI+7G/I+oc1o0fwusGBOv3z7KgcPIFE6o9iMbgG6sBi/zf
         CShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/on9opuZ920YXronzGYq3QYxz/vSqgkVDQs6K5nWz4=;
        b=eddtaIA+Q3bRaKsFb6As8WpNIbrVBpeccKrDJ+YD57HLCWOCiUkQb4cJi9ikoJ6RKg
         iqyzvuFGjLnO4TEPkTo35ezjqD5ByDEN3+ANNo9s+6PFC9/mxgXLH0lS+VUea6SG9Kq2
         yNMs7w+UB03FOaTGuuE0ORAtflJq06/qbW34hdtLCCWcdBkXR2Uoa3ExXXohiGjXxiB/
         Ed3UfXpUjkCoRWG6kZHFg+vWJhJPkbl8mLIwiYtRlB6xyL7sYYCGSYthMisodZgaDqJr
         S26WGUiuJMEWfuGBwyAIFvoFTHVMaq0oZX88TXRSseG5053p0EXSX4qgijFgENiDqWj6
         Vcfw==
X-Gm-Message-State: AJIora87SJzAsN2azRG5JuG+lzOZ4ywtxbq4HHsFygBVjFp1J99Bqj4f
        TSgYJnYVqT0bKg6pDmhuiYmltsXztpg=
X-Google-Smtp-Source: ABdhPJxJbIxkyQp3SnByQ0rlyreKsgBc9gJHFVmQpd8A7CceXQ/S9YWTQGAlw6Oumd+QJVB8L66BTg==
X-Received: by 2002:a17:906:728f:b0:711:f680:3c83 with SMTP id b15-20020a170906728f00b00711f6803c83mr8576630ejl.122.1655296038062;
        Wed, 15 Jun 2022 05:27:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402028900b0042dd3bf1403sm9190336edv.54.2022.06.15.05.27.17
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:27:17 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/4] support perf_event_paranoid=3
Date:   Wed, 15 Jun 2022 14:27:09 +0200
Message-Id: <20220615122711.9895-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615122711.9895-1-cgzones@googlemail.com>
References: <20220614102029.13006-1-cgzones@googlemail.com>
 <20220615122711.9895-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Debian uses a downstream patch[1] to allow further restriction of
perf_event_open, which requires CAP_SYS_ADMIN for all perf_event_open(2)
operations.

Set the parameter to a value of 2 during the tests and reset afterwards.

[1]: https://salsa.debian.org/kernel-team/linux/-/blob/debian/5.17.3-1/debian/patches/features/all/security-perf-allow-further-restriction-of-perf_event_open.patch

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   set parameter to 2 instead of granting CAP_SYS_ADMIN
---
 tests/perf_event/test | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/perf_event/test b/tests/perf_event/test
index c336477..cc1247b 100755
--- a/tests/perf_event/test
+++ b/tests/perf_event/test
@@ -32,12 +32,18 @@ BEGIN {
             print "\tNot paranoid\n";
         }
         elsif ( $level eq 0 ) {
-            print "\tDisallow raw tracepoint/ftrace without CAP_SYS_ADMIN\n";
+            print
+"\tDisallow raw tracepoint/ftrace without CAP_PERFMON or CAP_SYS_ADMIN\n";
         }
         elsif ( $level eq 1 ) {
-            print "\tDisallow CPU event access without CAP_SYS_ADMIN\n";
+            print
+"\tDisallow CPU event access without CAP_PERFMON or CAP_SYS_ADMIN\n";
         }
         elsif ( $level eq 2 ) {
+            print
+"\tDisallow kernel profiling without CAP_PERFMON or CAP_SYS_ADMIN\n";
+        }
+        elsif ( $level eq 3 ) {
             print "\tDisallow kernel profiling without CAP_SYS_ADMIN\n";
         }
         else {
@@ -48,6 +54,11 @@ BEGIN {
     plan tests => $test_count;
 }
 
+# Downgrade to only require CAP_PERFMON for operations
+if ( $level eq 3 ) {
+    system("echo 2 > /proc/sys/kernel/perf_event_paranoid 2> /dev/null");
+}
+
 # find some CPU that is online
 for ( $cpu = 0 ; -e "/sys/devices/system/cpu/cpu$cpu" ; $cpu++ ) {
 
@@ -114,4 +125,9 @@ $result =
   "runcon -t test_perf_no_write_t $basedir/perf_event $v $cpu $event_id 2>&1";
 ok( $result >> 8 eq 2 );
 
+# Reset if downgraded
+if ( $level eq 3 ) {
+    system("echo 3 > /proc/sys/kernel/perf_event_paranoid 2> /dev/null");
+}
+
 exit;
-- 
2.36.1

