Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F7C00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 14:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbiHHOtI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243478AbiHHOtH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 10:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4410D1274D
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659970145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zm3OK/Toa986j3N5b84tZW8GXQ7LFn1yTftrmhbykps=;
        b=d5Gg/ZikxJ/Hi4pzngsCc/k6YOKqhBRyfDDvOD2I5NA+b4xcnzdzN81dzEXJpbCXB+C2ed
        ZTQap7312aCRVd934TwnhHXe13AaHCE5sgRegclSHBVng7L3o8EoWpjBOo12gJSeWqZ5Z3
        Mft2G+u65PuNDtXdFndvj+9s6z1lHJU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-S1lOG85JON-ycpvmDbeMbg-1; Mon, 08 Aug 2022 10:49:03 -0400
X-MC-Unique: S1lOG85JON-ycpvmDbeMbg-1
Received: by mail-ej1-f69.google.com with SMTP id gn23-20020a1709070d1700b0073094d0e02cso2504701ejc.20
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 07:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Zm3OK/Toa986j3N5b84tZW8GXQ7LFn1yTftrmhbykps=;
        b=IpNyLBfB0GiP55YV5sXQBQ90fM1+5IvEFZN2bcQ/ojfYmvViQ4dM/aWJ1sbne4OcKz
         1+hMbne439ddnmR1r21+WN0bqN4wmJgZK744TJ/YfG2tMG78ttQj6NhAqn0cMVJ2/W/u
         FsBF85M26uvhWPiyF77/4p5Rrdxmz0N1n8OYDh3PCRk2EocUzVmTxZXILAts7U92IaYB
         fIdxDLK8uX75qvbAgrxUBgcUmjKPMDvZTFyumJYszKgcD01e1Hm2kbYSPvexmFEMpT8n
         HCa1+fhTkDO5idFSJ9nCB848tg69U2Mc90cBGxlV18JWO1oWrtJrIYjsjudQfZKZv5rb
         adXw==
X-Gm-Message-State: ACgBeo3GqpbM6ZD6Xtctn+uZBMhxNWoW0GN0/aUGuSKHOWf5PjfgGamo
        8bvqVW1lmNwmBeLpYdDMB/5R4mmC/3DvpL59ZNsyqJD2qrr4446Yauue5UkNuuFtsERC2Zxx05J
        cTDr4m/6udUz+BP2aRg==
X-Received: by 2002:a05:6402:5516:b0:43a:42f9:24d6 with SMTP id fi22-20020a056402551600b0043a42f924d6mr18343609edb.204.1659970142413;
        Mon, 08 Aug 2022 07:49:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7qlAx7s6VGg+V8lUJp06XY14zF++0PZsUfwluoP8WBqVk2HglRVF6eAMmmuZbbvxvHheHZ+Q==
X-Received: by 2002:a05:6402:5516:b0:43a:42f9:24d6 with SMTP id fi22-20020a056402551600b0043a42f924d6mr18343596edb.204.1659970142183;
        Mon, 08 Aug 2022 07:49:02 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0071cef8bafc3sm5065970ejy.1.2022.08.08.07.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 07:49:01 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: [PATCH] selinux: add a new warn_on_audited debug flag to selinuxfs
Date:   Mon,  8 Aug 2022 16:49:00 +0200
Message-Id: <20220808144900.125242-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When debugging SELinux denials, it is often helpful to know which part
of kernel code triggered the denial. Thus, this patch adds a new
/sys/fs/selinux/warn_on_audited flag that, when set to 1, will cause any
audited AVC event to log a WARNING to the kernel console, which
naturally comes with a kernel stack trace.

While the same can be achieved via the "avc:selinux_audited" kernel
tracepoint and the perf tool, that approach has several practical
disadvantages:
1. It requires perf to be installed on the machine.
2. It requires kernel debug symbols to be available when decoding the
   stack trace.
3. It requires a perf process to be running in the background.
4. The stack traces can only be obtained at the end, after the perf
   process is terminated, not live during the capture. (Though this may
   be solved by writing a custom tool on top of libtraceevent.)

Thus, providing a simple native knob for this in selinuxfs is still
valuable.

The warn_on_audited flag is always set to 0 on boot and is expected to
be set to 1 only temporarily by system administrator in order to debug
SELinux denials. It is not intended to be used on production systems.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c              |  6 +++
 security/selinux/ima.c              | 11 +++++-
 security/selinux/include/security.h | 11 ++++++
 security/selinux/selinuxfs.c        | 61 +++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9a43af0ebd7d..0e615c9e8e79 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -736,6 +736,12 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
 
 	trace_selinux_audited(sad, scontext, tcontext, tclass);
+
+	WARN(warn_on_audited_get(sad->state),
+	     "SELinux:  AV: requested=0x%x denied=0x%x audited=0x%x result=%d scontext=%s tcontext=%s tclass=%s",
+	     sad->requested, sad->denied, sad->audited, sad->result,
+	     scontext, tcontext, tclass);
+
 	kfree(tcontext);
 	kfree(scontext);
 
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index a915b89d55b0..506e880040f5 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -26,7 +26,10 @@ static char *selinux_ima_collect_state(struct selinux_state *state)
 	char *buf;
 	int buf_len, len, i, rc;
 
-	buf_len = strlen("initialized=0;enforcing=0;checkreqprot=0;") + 1;
+	buf_len = strlen("initialized=0;"
+			 "enforcing=0;"
+			 "checkreqprot=0;"
+			 "warn_on_audited=0;") + 1;
 
 	len = strlen(on);
 	for (i = 0; i < __POLICYDB_CAP_MAX; i++)
@@ -54,6 +57,12 @@ static char *selinux_ima_collect_state(struct selinux_state *state)
 	rc = strlcat(buf, checkreqprot_get(state) ? on : off, buf_len);
 	WARN_ON(rc >= buf_len);
 
+	rc = strlcat(buf, "warn_on_audited", buf_len);
+	WARN_ON(rc >= buf_len);
+
+	rc = strlcat(buf, warn_on_audited_get(state) ? on : off, buf_len);
+	WARN_ON(rc >= buf_len);
+
 	for (i = 0; i < __POLICYDB_CAP_MAX; i++) {
 		rc = strlcat(buf, selinux_policycap_names[i], buf_len);
 		WARN_ON(rc >= buf_len);
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 393aff41d3ef..bb1f0507edb6 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -97,6 +97,7 @@ struct selinux_state {
 	bool enforcing;
 #endif
 	bool checkreqprot;
+	bool warn_on_audited;
 	bool initialized;
 	bool policycap[__POLICYDB_CAP_MAX];
 
@@ -157,6 +158,16 @@ static inline void checkreqprot_set(struct selinux_state *state, bool value)
 	WRITE_ONCE(state->checkreqprot, value);
 }
 
+static inline bool warn_on_audited_get(const struct selinux_state *state)
+{
+	return READ_ONCE(state->warn_on_audited);
+}
+
+static inline void warn_on_audited_set(struct selinux_state *state, bool value)
+{
+	WRITE_ONCE(state->warn_on_audited, value);
+}
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 static inline bool selinux_disabled(struct selinux_state *state)
 {
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 8fcdd494af27..c3774ba39cf8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -64,6 +64,7 @@ enum sel_inos {
 	SEL_STATUS,	/* export current status using mmap() */
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
+	SEL_WARN_ON_AUDITED, /* whether to WARN() when a denial is audited */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -857,6 +858,64 @@ static const struct file_operations sel_transition_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_warn_on_audited(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
+			   warn_on_audited_get(fsi->state));
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static ssize_t sel_write_warn_on_audited(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	char *page;
+	ssize_t length;
+	unsigned int new_value;
+
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__SETSECPARAM,
+			      NULL);
+	if (length)
+		return length;
+
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	length = -EINVAL;
+	if (sscanf(page, "%u", &new_value) != 1)
+		goto out;
+
+	warn_on_audited_set(fsi->state, !!new_value);
+	length = count;
+
+	selinux_ima_measure_state(fsi->state);
+
+out:
+	kfree(page);
+	return length;
+}
+
+static const struct file_operations sel_warn_on_audited_ops = {
+	.read		= sel_read_warn_on_audited,
+	.write		= sel_write_warn_on_audited,
+	.llseek		= generic_file_llseek,
+};
+
 /*
  * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
  */
@@ -2084,6 +2143,8 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+		[SEL_WARN_ON_AUDITED] = {"warn_on_audited", &sel_warn_on_audited_ops,
+					 S_IRUGO|S_IWUSR},
 		/* last one */ {""}
 	};
 
-- 
2.37.1

