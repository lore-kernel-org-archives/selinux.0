Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03531C43333
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 04:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C9423715
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 04:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbhAHEIq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Jan 2021 23:08:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59246 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbhAHEIp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Jan 2021 23:08:45 -0500
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 892ED20B6C45;
        Thu,  7 Jan 2021 20:07:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 892ED20B6C45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610078846;
        bh=VIKMJbFu3cOL+5bOVp1iBn5J7QnndlyqYVvuPWOMxHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nozqnuyNEh353Q4nxQavHSSiQ7vXvceqoXSVyr1uAummB94jPOYtDT6U5SsYsyeaK
         L7hvDb5jVEPaaWRENLP21XYYk66eUAKBJUxwwEnNHQKTyR5hi+0easlQIBDT1QZs0P
         fa89vIZd83MUi/1rBkXMn1dGQ+Qg6ViohLZd1g8E=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v10 6/8] IMA: extend critical data hook to limit the measurement based on a label
Date:   Thu,  7 Jan 2021 20:07:06 -0800
Message-Id: <20210108040708.8389-7-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The IMA hook ima_measure_critical_data() does not support a way to
specify the source of the critical data provider.  Thus, the data
measurement cannot be constrained based on the data source label
in the IMA policy.

Extend the IMA hook ima_measure_critical_data() to support passing 
the data source label as an input parameter, so that the policy rule can
be used to limit the measurements based on the label.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 include/linux/ima.h               | 7 +++++--
 security/integrity/ima/ima_main.c | 8 +++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 37a0727c1c31..6d00542de135 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -30,7 +30,8 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
-extern void ima_measure_critical_data(const char *event_name,
+extern void ima_measure_critical_data(const char *event_label,
+				      const char *event_name,
 				      const void *buf, size_t buf_len,
 				      bool hash);
 
@@ -126,9 +127,11 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
 
-static inline void ima_measure_critical_data(const char *event_name,
+static inline void ima_measure_critical_data(const char *event_label,
+					     const char *event_name,
 					     const void *buf, size_t buf_len,
 					     bool hash) {}
+
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ef37307e79dd..edfb1367a11d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -915,6 +915,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 
 /**
  * ima_measure_critical_data - measure kernel integrity critical data
+ * @event_label: unique event label for grouping and limiting critical data
  * @event_name: event name for the record in the IMA measurement list
  * @buf: pointer to buffer data
  * @buf_len: length of buffer data (in bytes)
@@ -925,15 +926,16 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * structures, policies, and states stored in kernel memory that can
  * impact the integrity of the system.
  */
-void ima_measure_critical_data(const char *event_name,
+void ima_measure_critical_data(const char *event_label,
+			       const char *event_name,
 			       const void *buf, size_t buf_len,
 			       bool hash)
 {
-	if (!event_name || !buf || !buf_len)
+	if (!event_name || !event_label || !buf || !buf_len)
 		return;
 
 	process_buffer_measurement(NULL, buf, buf_len, event_name,
-				   CRITICAL_DATA, 0, NULL,
+				   CRITICAL_DATA, 0, event_label,
 				   hash);
 }
 
-- 
2.17.1

