Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFEF4EC642
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617631; cv=none; b=HLS0SHYyjMUDJ3zkScBj1DDkSfWaJJkqLduybciSIuh4u86LUKemxS8wNytBV72lJNkzdWEUdv2c9wAhk9v4jBxsDM+/zV6XW68XaR8xw3MGFnhGCIz3go/xYsdzR0NZBp9Bajb7LpEUNi2N+xGkx382GkzbPGEEScHIRxzVxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617631; c=relaxed/simple;
	bh=G7nFtRgVv5RtHP14wBaZ1LwrkL/otp7+zAm6Ligr5uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+JY3pNKyxKXdXulGZ/QWn/vUwrllHJjVuKQtm9BtThjGj9qlUWRy1aLY5iEVGgixpd2jnWoEnHp34fcTmhi3lM+ALmjQ1PJfPnzCgmf+V6i8kXVSa9teIj15a4OIK5wudNVrZDgr5aHgO8RiFB3+Be7lfsCWbGGVwVKm4b3B0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=siSUPvPi; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="siSUPvPi"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617623;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8WWM9/G4wZhw2d7ML2ciijMwu2hIqlKZdYpyZPG6bk=;
	b=siSUPvPiFfyIOTQJ0XfyeLO7TvTHdyPwJ79VhNcGJx74T8eCIVSNAIP4OIW5LtSQba3vJa
	4NTqiMY/uP5YSTrS/zjLDWdGz3o0hDaAIkavW0BaLC1DTAVIpIxetfg/3ywdHniWejcJ2q
	wXzMkgMq98Z1Jox6bWBEsXewvNV6JCOLjLa5/++hEauGysV6JgCNsbDeGUtsrAlO96/vKy
	Zx2buSNfFHecOK/wQglG/JkFxoXjzK387NdwNhGJl9gGr2xyS4MwD8YUHoClgKIO09NnVq
	LkFDlFklYeC9eL/4bfiO7zRJElYpVzR636vokZx534fduZAFju/3O+7u9Dg6RQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 24/32] selinux: factor out sel_sid_to_payload()
Date: Mon, 28 Sep 2026 19:46:34 +0200
Message-ID: <20260928174643.2458710-23-cgoettsche@seltendoof.de>
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

The context, create, relabel and member transaction handlers all end
by converting the resulting SID to a context string, rejecting it with
-ERANGE if it does not fit into the transaction buffer, and copying it
into the buffer as the response.

Move that tail into a common helper. The values returned to userspace
are unchanged. As a side effect an oversized context is now also
logged for relabel, which previously was the only handler to fail
silently, and the logged function name is that of the helper.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 90 ++++++++++++------------------------
 1 file changed, 30 insertions(+), 60 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d86babad998c..d1815cb88840 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -576,22 +576,17 @@ static const struct file_operations sel_load_ops = {
 	.llseek		= generic_file_llseek,
 };
 
-static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
+/*
+ * Store the context of @sid as the response of a transaction based
+ * write method in @buf and return its length.
+ */
+static ssize_t sel_sid_to_payload(u32 sid, char *buf)
 {
-	char *canon = NULL;
-	u32 sid, len;
+	char *con = NULL;
+	u32 len;
 	ssize_t length;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
-			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
-	if (length)
-		goto out;
-
-	length = security_context_to_sid(buf, size, &sid, GFP_KERNEL);
-	if (length)
-		goto out;
-
-	length = security_sid_to_context(sid, &canon, &len);
+	length = security_sid_to_context(sid, &con, &len);
 	if (length)
 		goto out;
 
@@ -602,13 +597,30 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 		goto out;
 	}
 
-	memcpy(buf, canon, len);
+	memcpy(buf, con, len);
 	length = len;
 out:
-	kfree(canon);
+	kfree(con);
 	return length;
 }
 
+static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
+{
+	u32 sid;
+	ssize_t length;
+
+	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
+	if (length)
+		return length;
+
+	length = security_context_to_sid(buf, size, &sid, GFP_KERNEL);
+	if (length)
+		return length;
+
+	return sel_sid_to_payload(sid, buf);
+}
+
 static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 				     size_t count, loff_t *ppos)
 {
@@ -820,8 +832,6 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon = NULL;
-	u32 len;
 	int nargs;
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
@@ -893,21 +903,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(newsid, &newcon, &len);
-	if (length)
-		goto out;
-
-	length = -ERANGE;
-	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		pr_err("SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
-		goto out;
-	}
-
-	memcpy(buf, newcon, len);
-	length = len;
+	length = sel_sid_to_payload(newsid, buf);
 out:
-	kfree(newcon);
 	kfree(namebuf);
 	kfree(tcon);
 	kfree(scon);
@@ -920,8 +917,6 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon = NULL;
-	u32 len;
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
@@ -955,18 +950,8 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(newsid, &newcon, &len);
-	if (length)
-		goto out;
-
-	length = -ERANGE;
-	if (len > SIMPLE_TRANSACTION_LIMIT)
-		goto out;
-
-	memcpy(buf, newcon, len);
-	length = len;
+	length = sel_sid_to_payload(newsid, buf);
 out:
-	kfree(newcon);
 	kfree(tcon);
 	kfree(scon);
 	return length;
@@ -987,8 +972,6 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	u32 ssid, tsid, newsid;
 	u16 tclass;
 	ssize_t length;
-	char *newcon = NULL;
-	u32 len;
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
@@ -1022,21 +1005,8 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	if (length)
 		goto out;
 
-	length = security_sid_to_context(newsid, &newcon, &len);
-	if (length)
-		goto out;
-
-	length = -ERANGE;
-	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		pr_err("SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
-		goto out;
-	}
-
-	memcpy(buf, newcon, len);
-	length = len;
+	length = sel_sid_to_payload(newsid, buf);
 out:
-	kfree(newcon);
 	kfree(tcon);
 	kfree(scon);
 	return length;
-- 
2.55.0

