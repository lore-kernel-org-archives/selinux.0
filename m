Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238710;
	b=TG9JyuRqo3da5UiE3sPfXrDu5ij382/Oj+DeOemvgPngmD7Lh2ZCgLkAx8pyFbtkIVeH
	 Zh7GTeqKiNxcrrx6tD0jC3eur0XqbHosrHWlzUWGzZjZEMPaQ1Gy6pJW9GrAuAGcD5GsT
	 XJr6p0lm88JgL87sZDtp054yXWfHBsOyryfXid1HvgeMb2Z80+OpUGnq5AUNyLLEGy4eH
	 8CEyx2lEx2mGR3xy7GBqWTdOQEU09pePiUawYf0HLFNv3LvP/CIS62u2+sMnfLPkw0GaL
	 bKl0McDW3niGSjxKBWa1vKLXwvbfIqVTmGOfF1d5rO1p2l3wlNoMGW76IJbCyJ6dw0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238710;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QYHfWIZAbLD7CTQkiCFylQrP52hNN0avwWJVgDpG7BQ=;
	b=fiEf1/ZoAokcA3A7AJKqqEZ+ROyNUAKajsu8GS9PZffAhMpx9ResNyWs0uFL5zsgSjSG
	 dtS3bc5Kh1mT+INVo3L23njVfQQvwofCwrRWi1+jWfTwhvM2Vds0R5DAW4pXEhiE16tYh
	 ipfll0v7CiYsyWNQdIPA2g7UGVHRsjA5UmaQiYINyQ3s7nd22olflc5JCGRZw8+vSQc0B
	 38mv/gIJBdQukipow79o+tqqqdSzeYs9bacVka3EyArUWvYRqr2u8rlZU26BE28MskoqK
	 py01/7mkKZuE7lnzcoiO2SVs5xLP07ylkb+6px7dKBa5v/dwvRn03uO0LzDbcNnws0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Cr8Akaj2;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0AD606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB0AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Cr8Akaj2
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794238700;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYHfWIZAbLD7CTQkiCFylQrP52hNN0avwWJVgDpG7BQ=;
	b=Cr8Akaj27FZ89I97uALLeY49ivQsFsB0ZPfYJ0kVFg8rz8HcEPQGUmxwg6mH6cW3uwfVyx
	erqbXs5b74fSREeQ6a5sCh0X3e0WsiVdktDxKBxaSJ+nMCYkdCQ92MHbfcebl7hEdhhJ5h
	/+bTBjRLuwGvEFTc6O+L4pl+BATsxq3KYfQ9U6CupQWiDUlE52vWtAzK5t+VRzzsOY8pBo
	CIFvJFOZVQcJXNORXzNCHOwFELJPwK5Y1DXnpRec48FrPSlTV+JfkL39Fv9AmhzlgJIXhy
	JMq45VuC737687i6XJN9qz3WieYMIFK5A8fziKoKOCYTbjKdrvjs9Ydgjurw5A==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 4/5] selinux: keep pending boolean values across policy loads
Date: Mon,  9 Nov 2026 16:38:00 +0100
Message-ID: <20261109153802.76176-3-cgoettsche@seltendoof.de>
In-Reply-To: <20261109153802.76176-1-cgoettsche@seltendoof.de>
References: <20261109153802.76176-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Setting a boolean via selinuxfs takes two steps: writing the pending
value to /sys/fs/selinux/booleans/<name> and then committing all pending
values via /sys/fs/selinux/commit_pending_bools.  A policy load in
between recreates the pending values from the committed ones of the new
policy, so the subsequent commit silently drops the change, while both
writes report success.  With concurrent policy loads, setsebool(8)
therefore occasionally loses updates.

Carry over the pending values of the booleans present in both the old
and the new policy.  For booleans without a pending change this is a
no-op, since security_preserve_bools() already transfers the committed
values to the new policy.  Both the pending values and the policy load
are serialized by the policy mutex.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2: drop Fixes tag since Stephen mentioned this was not an API guarantee
---
 security/selinux/include/conditional.h |  2 ++
 security/selinux/selinuxfs.c           | 23 +++++++++++++++++++++++
 security/selinux/ss/services.c         | 16 ++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index 060833e2dba2..aa29189179fa 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -20,4 +20,6 @@ int security_set_bools(u32 len, const int *values);
 
 int security_get_bool_value(u32 index);
 
+int security_get_bool_index(struct selinux_policy *policy, const char *name);
+
 #endif
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 310e19efff1d..96a33b7d2b7b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -447,6 +447,27 @@ static void sel_remove_old_bool_data(unsigned int bool_num, char **bool_names,
 	kfree(bool_values);
 }
 
+/*
+ * The pending boolean values of a new policy start out as its committed
+ * values.  Carry over the pending values of the booleans that exist in both
+ * policies, so a value written but not yet committed is not silently lost
+ * if a policy load happens in between.
+ */
+static void sel_keep_pending_bools(const struct selinux_fs_info *fsi,
+				   struct selinux_policy *newpolicy,
+				   int *bool_values)
+{
+	unsigned int i;
+	int index;
+
+	for (i = 0; i < fsi->bool_num; i++) {
+		index = security_get_bool_index(newpolicy,
+						fsi->bool_pending_names[i]);
+		if (index >= 0)
+			bool_values[index] = fsi->bool_pending_values[i];
+	}
+}
+
 static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 				struct selinux_policy *newpolicy)
 {
@@ -481,6 +502,8 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	if (ret)
 		goto out;
 
+	sel_keep_pending_bools(fsi, newpolicy, bool_values);
+
 	ret = sel_make_classes(newpolicy, tmp_class_dir,
 			       &fsi->last_class_ino);
 	if (ret)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 79b24500ca7b..19acbb1ee436 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3077,6 +3077,22 @@ int security_get_bool_value(u32 index)
 	return rc;
 }
 
+/*
+ * security_get_bool_index() - look up the index of a boolean by name in the
+ * given policy, e.g. one not yet committed.  Returns -ENOENT if the policy
+ * does not define the boolean.
+ */
+int security_get_bool_index(struct selinux_policy *policy, const char *name)
+{
+	struct cond_bool_datum *booldatum;
+
+	booldatum = symtab_search(&policy->policydb.p_bools, name);
+	if (!booldatum)
+		return -ENOENT;
+
+	return booldatum->value - 1;
+}
+
 static int security_preserve_bools(struct selinux_policy *oldpolicy,
 				struct selinux_policy *newpolicy)
 {
-- 
2.55.0

