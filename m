Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5E8BEC
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849670; cv=none; b=XQedKual4GJ94S0kZlMQ6vhbEUmY2cUktLfHIbY9l8SthJOaJu1jgwdJVedB5LFLLkb60bQWKzqVHSHoYxbxZOJVBKcJ1Ct4GuUFTvOA1uiYSb5W9o/ujq6rtBLXi4AE0EMKLSP4K259Bxybw8W3rU5lR7M+OKtuzMsXi6sJIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849670; c=relaxed/simple;
	bh=xCOiPFGDbXVc8tNVOx7IQ/GL1WNeGZ//TyUKMft3JUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjA8ttqM+xeFFjeSGjpbgLoCXiyMTlJawEX1b99NNheAaRgifLL/YeIZY42jhOIfMuQZ0+bOZmvc3bHYagYhzYxt6fWXXSeO5EUKAHL4ibe39n+RmOEOXeghb17Rjs462nqHNtVec1vVNryWpa81I6fPyDvynq1+oieJvv6PSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGrH7JaQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGrH7JaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759849667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpVKv8JNgg6p8X1wEamAvOsQ+IQH/AhJ1ddT8cv/7Uc=;
	b=eGrH7JaQmUs9XNF7LE9rNx7B5tWq0LtYYUYt/t/MZyauYDn/HxzHBC3gYLm34wB8ATG+VB
	SibGOvn2mAogI9ML1RgeY/kguBmRYULGf6gCNFf4nQfpJo7JtCcQupGmHJnqJ9ofuYz3u0
	vdkg85mIGcAJ3xjbCXjcp+s+4wO1X90=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-X93MlRkMPkmzKp3-L1lfKw-1; Tue,
 07 Oct 2025 11:07:42 -0400
X-MC-Unique: X93MlRkMPkmzKp3-L1lfKw-1
X-Mimecast-MFC-AGG-ID: X93MlRkMPkmzKp3-L1lfKw_1759849661
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9ED180057F;
	Tue,  7 Oct 2025 15:07:41 +0000 (UTC)
Received: from plawate-thinkpadp1gen4i.pnq.csb (unknown [10.74.64.212])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 629E919560A2;
	Tue,  7 Oct 2025 15:07:39 +0000 (UTC)
From: Pranav Lawate <plawate@redhat.com>
To: selinux@vger.kernel.org
Cc: pran.lawate@gmail.com,
	vmojzis@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/1] improve semanage man pages: Add examples for -r RANGE flag usage
Date: Tue,  7 Oct 2025 20:36:13 +0530
Message-ID: <20251007150659.33954-2-plawate@redhat.com>
In-Reply-To: <20251007150659.33954-1-plawate@redhat.com>
References: <20251007150659.33954-1-plawate@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Pranav Lawate <pran.lawate@gmail.com>

This patch adds missing examples to the semanage-port and
semanage-fcontext man pages showing the correct usage of the -r RANGE
flag for MLS/MCS systems. Currently, users who try to use the -r flag
without proper examples often encounter unclear error messages when
they provide invalid range formats.

For example, here is a command with wrong range string value:
libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or directory)
[...error output...]

The added examples demonstrate:
  - Correct MLS range format: s0:c0.c255
  - Complete command syntax with the -r flag for both port and
    fcontext operations
  - Clear indication that this is for MLS/MCS systems only
  - Verification method using seinfo for port changes (semanage port -l
    only shows type, not MLS range)
  - Use -F flag to restorecon in fcontext example (required to force
    relabeling)

Signed-off-by: Pranav Lawate <pran.lawate@gmail.com>
---
 python/semanage/semanage-fcontext.8 | 4 ++++
 python/semanage/semanage-port.8     | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index 3a96c62f..a29b7499 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -100,6 +100,10 @@ execute the following commands.
 # semanage fcontext \-a \-e /home /disk6/home
 # restorecon \-R \-v /disk6
 
+Add file-context with MLS range s0:c0.c255 for /secure directory (MLS/MCS systems only)
+# semanage fcontext \-a \-t admin_home_t \-r s0:c0.c255 "/secure(/.*)?"
+# restorecon \-R \-F \-v /secure
+
 .SH "SEE ALSO"
 .BR selinux (8),
 .BR semanage (8),
diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-port.8
index c6048660..0df44290 100644
--- a/python/semanage/semanage-port.8
+++ b/python/semanage/semanage-port.8
@@ -61,6 +61,9 @@ Allow Apache to listen on tcp port 81 (i.e. assign tcp port 81 label http_port_t
 # semanage port \-a \-t http_port_t \-p tcp 81
 Allow sshd to listen on tcp port 8991 (i.e. assign tcp port 8991 label ssh_port_t, which sshd is allowed to listen on)
 # semanage port \-a \-t ssh_port_t \-p tcp 8991
+Add a custom port 9999 with MLS range s0:c0.c255 (MLS/MCS systems only). Verify with seinfo.
+# semanage port \-a \-t http_port_t \-p tcp \-r s0:c0.c255 9999
+# seinfo \-\-portcon \-x | grep 9999
 
 .SH "SEE ALSO"
 .BR selinux (8),
-- 
2.51.0

