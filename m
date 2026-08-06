Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4F494821
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045299; cv=none; b=SxU7e45VK/BO1hW6HnEa7TWEKIhJOo3Rivnj/hQdwrrRaDCSqB2Y+CeI5nVljMO81AykoJjXLSHqNV2qSWjyqMQiGqwBKLxkRMXio3VTZK0/Vp5ZamHwc2Pdh+wEwNCRynI3R09Vq3elHJhc7wD74m9akmA+6A6/q+owp8ngJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045299; c=relaxed/simple;
	bh=kpJvYdWzAvw7Zp24i0YQohIzrSofV+GPKH/HOYhselA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Jm6Ii9wdAF4tDAPzklhy1uiezu9ZJ5uZ8sM/mY44F44jxAZ7zWymlGgYbq43WGWnRMfqHDv21wP85kGFlZeCQLwJdxeSqOk7SkVKqO05H5SaxRYPhlUFE0xFPF/rOvAdoivlenST46ukGUE0NlsQo/G8DYnry+rHXEM8idm+qaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hd1V2Tkb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hd1V2Tkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786045296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+t3uqJ9oLNR3QYZCYgYjX63SbvTvT6MlLLGQ/kH3hY=;
	b=hd1V2TkbBqG3dG4vESiWKwnUlEa6ba3CdtKaRosXi9ritNHGjtOt4ekSAhGQPaMNI8zvto
	wEPeCY1c/fbD0jPkfKnnM7fI6hjqT7zfvSgCmWfUBDCtX3IpKAyGlZFgsHD+LV5RH0OoPk
	TpNzIG/sU28d4RaMn/3uSWDBRYVq8tY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-uTDsWrFWNRq5OnVQoAIWUw-1; Thu,
 06 Aug 2026 15:41:30 -0400
X-MC-Unique: uTDsWrFWNRq5OnVQoAIWUw-1
X-Mimecast-MFC-AGG-ID: uTDsWrFWNRq5OnVQoAIWUw_1786045289
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47FD718001E2
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 19:41:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 931F8180059E
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 19:41:28 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libselinux: restorecon_xattr: reset dir_xattr_list on every call
Date: Thu,  6 Aug 2026 21:37:35 +0200
Message-ID: <20260806194125.371718-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

selinux_restorecon_xattr(3) documents that "xattr_list must be set to
NULL before calling selinux_restorecon_xattr(3). The caller is
responsible for freeing the returned xattr_list entries." Commit
b5a23d7f30c1 ("libselinux: restorecon_xattr: clear dir_xattr_* after
freeing") reset the dir_xattr_list/dir_xattr_last statics after
freeing them on the internal error-cleanup path of the recursive
walk, but not on the normal success path.

After a successful call, dir_xattr_list/dir_xattr_last are left
pointing at the just-returned, now caller-owned list. Once the caller
frees it as required and calls the function again, add_xattr_entry()
finds dir_xattr_list non-NULL and appends the next entry through
dir_xattr_last->next, a dangling pointer into memory the caller has
already freed - a use-after-free write.

Reset both pointers to NULL at the top of every call instead of only
in the error path: by the API description, any list from a prior call
is not valid.

Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---

Verified with an AddressSanitizer harness that calls 
selinux_restorecon_xattr() on one directory, frees the result,
then calls it again on a second directory: reliably crashes
with a heap-use-after-free (when compiled with -fsanitize=address)
before this fix (reproduced on libselinux-3.10 and libselinux-3.11)
and runs clean after rebuilding with this change applied.

https://github.com/vmojzis/selinuxproject_selinux/blob/libselinux_AISLE/reproducers/RHEL-217622/reproduce.c



 libselinux/src/selinux_restorecon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 4233ba65..49b8ff7e 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1968,6 +1968,18 @@ int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
 	if (!fc_sehandle)
 		return -1;
 
+	/*
+	 * The API contract requires the caller to have already freed any
+	 * xattr_list returned by a previous call before calling again.
+	 * Forget our own head/tail pointers to that now caller-owned memory
+	 * here instead of carrying them over: leaving them set would make
+	 * the next add_xattr_entry() append a new entry through
+	 * dir_xattr_last, which would be dangling once the caller has freed
+	 * it, resulting in a use-after-free.
+	 */
+	dir_xattr_list = NULL;
+	dir_xattr_last = NULL;
+
 	if (lstat(pathname, &sb) < 0) {
 		if (errno == ENOENT)
 			return 0;
-- 
2.53.0

