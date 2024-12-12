Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770A1D8DFB
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029738; cv=none; b=KSj6Tt2zYr8MS4CAqqqkrhDi7+AtQWYi8BHU6n9+MMDh/QoVjtl8mXTIZCNJfMKS1rcoQ47maD4BdcGAenGmZ1Q9dkn1hj3+LnzdUjPZj4uvI+ZuI8hX3gs64piH4Ravmfg1vTMVVdKZdB/TYENjUotgOAG2hFn/9kLrCOXR5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029738; c=relaxed/simple;
	bh=xQtDpg0LFesHeujM8hlUi0Y4yzLq1nmTJOwR8mOxi6E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PIaSrU8Rf9mBzH0fUID+jM/ifBWfzXpRj0/18VfgF7nz+fFa7p+Hzc/WoJUkvYxqaWlMeP/2YjNheDhMFFdKBMkqVuPe17iGqnotBtK8SJITwU+OhxNqJk/oeM+je9T4yL11KkjBeYlO/QKKfv8c6CzUMC7FO80elTn/jfWBjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMMjHjz9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMMjHjz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734029734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=biqGD2Dw3UDvWdWPMjXl7fAtpV2ddbmSrBWi95IpofU=;
	b=JMMjHjz9Mi8MxgHSUFtQ4qsBb2L7GJXOx/z3MrGf2LShjTIwF1ygBcJaaanK6l/iMwR5du
	qIi8XSZfsjoVZ3ArsoEyWuh8GskXLiTDF4t+uGkKHJSG4t2FioMFqWulSPvql9T6HEfGmI
	EbLlVC9BlZLLYjN2fCr9l7VXuE0VxZE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-4UrMkijFNaK_5NU0RAWIgA-1; Thu,
 12 Dec 2024 13:55:32 -0500
X-MC-Unique: 4UrMkijFNaK_5NU0RAWIgA-1
X-Mimecast-MFC-AGG-ID: 4UrMkijFNaK_5NU0RAWIgA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E42621944B18
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 18:55:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.227])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42FA1195394B
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 18:55:28 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsemanage: Mute error messages from selinux_restorecon
Date: Thu, 12 Dec 2024 19:44:25 +0100
Message-ID: <20241212185416.2187747-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Mute error messages produced by selinux_restorecon when rebuilding the
policy store to avoid error messages in containers, image mode, etc.

Fixes:
 #podman build --security-opt=label=disable --cap-add=all --device /dev/fuse -t quay.io/jlebon/fedora-bootc:tier-x . --build-arg MANIFEST=fedora-tier-x.yaml --from quay.io/fedora/fedora:rawhide
...
Could not set context for /etc/selinux/targeted/tmp/modules/100/rtas/lang_ext:  Operation not supported
Could not set context for /etc/selinux/targeted/tmp/modules/100/rtas:  Operation not supported
Could not set context for /etc/selinux/targeted/tmp/modules/100/rtkit/cil:  Operation not supported
Could not set context for /etc/selinux/targeted/tmp/modules/100/rtkit/hll:  Operation not supported
...

https://bugzilla.redhat.com/show_bug.cgi?id=2326348

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
I feel like this is probably not the best solution, so feel free to
suggest a better way.
The logs are all the more annoying because there is so many at once and
they clog up the logs and terminals so I am wonering about removing
the ERR after a failed fchown as well.

 libsemanage/src/semanage_store.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index e44efc16..2ca2e900 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -3000,15 +3000,29 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	return 0;
 }
 
+/* log_callback muting all logs */
+static int __attribute__ ((format(printf, 2, 3)))
+log_callback_mute(__attribute__((unused)) int type, __attribute__((unused)) const char *fmt, ...)
+{
+	return 0;
+}
+
 /* Make sure the file context and ownership of files in the policy
  * store does not change */
 void semanage_setfiles(semanage_handle_t * sh, const char *path){
 	struct stat sb;
 	int fd;
+	union selinux_callback cb_orig = selinux_get_callback(SELINUX_CB_LOG);
+	union selinux_callback cb = { .func_log = log_callback_mute };
+
+	/* Mute all logs */
+	selinux_set_callback(SELINUX_CB_LOG, cb);
+
 	/* Fix the user and role portions of the context, ignore errors
 	 * since this is not a critical operation */
 	selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SELINUX_RESTORECON_IGNORE_NOENTRY);
-
+	/* restore log_logging */
+	selinux_set_callback(SELINUX_CB_LOG, cb_orig);
 	/* Make sure "path" is owned by root */
 	if ((geteuid() != 0 || getegid() != 0) &&
 	    ((fd = open(path, O_RDONLY | O_CLOEXEC)) != -1)){
-- 
2.47.0

