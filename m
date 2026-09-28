Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A064E73D1
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617630; cv=none; b=mUOF4yPhrAnj0tqjyot7BFJ+SbG8M2EVWJ6QFWoFfdsyQfzXRhfAB28FjJsI0/+4d57PcUwHlxxLxgpQUwvXnP+KEnqBB6im8BFmszujzoON0hQIek2Kc9QfDKjReWpMjdDe98Ggc/03jVZVF/GPJKa9MkOSHM7YHb5CGAbitJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617630; c=relaxed/simple;
	bh=hH4a3MIy2lR3Qjm2tb/iYxsup9exp/7qzlKdzk8Yubs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCDdEeHVQsvCVjyzDYcHLy/M3NbCm0j+YIaoP+2LDlPyko+eLIgzEPgpX2xBQkWg1CtXLrKJ6mAQ1BuOyyawl3Qg4SwsVJYpjM0l5uCpqQdjayTcPAQMno/P6e6Cfqr7tfTih+RUmFoqjnhoY7RbdqR36okxogfJbD+GGSQ5pjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=hDfzrWud; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="hDfzrWud"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617624;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEoOgQTrwzSJIGZQL3Oqo04nfi5foH95HVrA2LIYYYQ=;
	b=hDfzrWud1PkQLOMDaMk6qkEAS69nEFzOZCJROIpUA9mq8Jk+Le5/zIbnVaouS4x0AAjv22
	LazxFvreJxXwmlCSrNWwPG+aYwT1BRSq2/2hKetKJ3pWyKFBquDgbTIzP1xrgYA5r1quok
	91CkoMi7nKgQd3xMj97bvmCipeGs0x7EjgttjYeHy9NciI+YJmvbCj6AiUZARS1PKXFksT
	czryd5CToXS+QRw8uYNSgWkRu+YwOE3ifmFKgHA4XR6+nzDGaFa5D43ki8NIcOQskEuTfk
	5DPbKSSYqL5zNptWsd++eDSfRxUtr6eg1nRwRqnnLiZBSast+lXKyfgRX3zYAQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 25/32] selinux: share implementation of relabel and member transactions
Date: Mon, 28 Sep 2026 19:46:35 +0200
Message-ID: <20260928174643.2458710-24-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

sel_write_relabel() and sel_write_member() are identical except for
the permission checked and the security server function computing the
new SID. Implement both via a common helper taking these two as
arguments.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 60 +++++++++---------------------------
 1 file changed, 14 insertions(+), 46 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d1815cb88840..595f9fabbc0b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -911,7 +911,10 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	return length;
 }
 
-static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
+static ssize_t sel_write_compute_sid(char *buf, size_t size, u32 perm,
+				     int (*compute_sid)(u32 ssid, u32 tsid,
+							u16 tclass,
+							u32 *out_sid))
 {
 	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
@@ -919,8 +922,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	ssize_t length;
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
-			      NULL);
+			      SECCLASS_SECURITY, perm, NULL);
 	if (length)
 		goto out;
 
@@ -946,7 +948,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
-	length = security_change_sid(ssid, tsid, tclass, &newsid);
+	length = compute_sid(ssid, tsid, tclass, &newsid);
 	if (length)
 		goto out;
 
@@ -957,6 +959,12 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	return length;
 }
 
+static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
+{
+	return sel_write_compute_sid(buf, size, SECURITY__COMPUTE_RELABEL,
+				     security_change_sid);
+}
+
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 {
 	pr_err_once("SELinux: %s (%d) wrote to user. This is no longer supported.\n",
@@ -968,48 +976,8 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 {
-	char *scon = NULL, *tcon = NULL;
-	u32 ssid, tsid, newsid;
-	u16 tclass;
-	ssize_t length;
-
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
-			      NULL);
-	if (length)
-		goto out;
-
-	length = -ENOMEM;
-	scon = kzalloc(size + 1, GFP_KERNEL);
-	if (!scon)
-		goto out;
-
-	length = -ENOMEM;
-	tcon = kzalloc(size + 1, GFP_KERNEL);
-	if (!tcon)
-		goto out;
-
-	length = -EINVAL;
-	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
-		goto out;
-
-	length = security_context_str_to_sid(scon, &ssid, GFP_KERNEL);
-	if (length)
-		goto out;
-
-	length = security_context_str_to_sid(tcon, &tsid, GFP_KERNEL);
-	if (length)
-		goto out;
-
-	length = security_member_sid(ssid, tsid, tclass, &newsid);
-	if (length)
-		goto out;
-
-	length = sel_sid_to_payload(newsid, buf);
-out:
-	kfree(tcon);
-	kfree(scon);
-	return length;
+	return sel_write_compute_sid(buf, size, SECURITY__COMPUTE_MEMBER,
+				     security_member_sid);
 }
 
 static struct inode *sel_make_inode(struct super_block *sb, umode_t mode)
-- 
2.55.0

