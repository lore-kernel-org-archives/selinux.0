Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034D2494ED
	for <selinux@vger.kernel.org>; Wed,  1 Oct 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339821; cv=none; b=biHwDVwR3oA8d2Rxr0ybgBQIfgo8aOsom+VPrFpvWiDTK+t9ksp4lPJ6WFz0DyjYkHFF7sS8SJIHeFZGWxDVuiZmUYMpr02em6D/BEdHrqKr6MThVdsH5AeR9JQYGfXFaY+OmqU+1vWLJTkArxQkzVX8TimBmE9LD4ZBmXV1Zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339821; c=relaxed/simple;
	bh=Y7Dh7tWsHdBtbCh0j+euq2nIQlrer/twAPaZO/akT9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjfjwLQaiCCDqER+ALac8qMFrfVzCgb/ScvFEXDfsJRRioJbkXJcY+EYnUY1b1x0GiLfVs/nxruQrn1hav+Gr+YBoTABDA4AA7osB9FhXz/sOHpty7sK2jfhY/pQTqacJuoLaxUYqqb61tHBv7M0xj75sJOWGrl8TeN4lOy9XCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nic+wvmj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nic+wvmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759339818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f0bAMFHWHpe7EudOZUfA8EYk7xOR2QVFgDJKAAzVHdY=;
	b=Nic+wvmjtycZEtTIjChkuFInvz8vSR8gs9Sd8FlEvU6DJuHIIuWghlb9SIomK/q2mpOHBE
	MeWqYY7qb+JMUu6vOR5ED5wdyoQzlxEP95c2Zwv0y2BSjywZmZgWUvuiy0aj3AUZIN4b+M
	FV9VujfxHIAZdstSyb4OX4fHJLTgtzw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-jbHmS1D0PE2nWerfkonsCg-1; Wed,
 01 Oct 2025 13:30:17 -0400
X-MC-Unique: jbHmS1D0PE2nWerfkonsCg-1
X-Mimecast-MFC-AGG-ID: jbHmS1D0PE2nWerfkonsCg_1759339816
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 800DF19774DD;
	Wed,  1 Oct 2025 17:30:16 +0000 (UTC)
Received: from plawate-thinkpadp1gen4i.pnq.csb (unknown [10.74.80.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B05819560B8;
	Wed,  1 Oct 2025 17:30:14 +0000 (UTC)
From: Pranav Lawate <plawate@redhat.com>
To: selinux@vger.kernel.org
Cc: pran.lawate@gmail.com,
	vmojzis@redhat.com
Subject: [PATCH] improve semanage man pages: Add examples for -r RANGE flag usage
Date: Wed,  1 Oct 2025 22:52:59 +0530
Message-ID: <20251001172938.206904-1-plawate@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Pranav Lawate <pran.lawate@gmail.com>

Hello,
 I tried to send an email on Sept 12 and waited for 20 days. Today I got
to know it didn't really reach properly. So now retrying with 'git
send-email' instead of using gmail with plain text.

 This patch adds missing examples to the semanage-port and
semanage-fcontext man pages showing the correct usage of the -r RANGE
flag for MLS/MCS systems. Currently, users who try to use the -r flag
without proper examples often encounter unclear error messages when
they provide invalid range formats.

For example, Here is a command with wrong range string value:
~~~
# semanage fcontext -a -t admin_home_t -r s0.c0 /root/test
libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or directory).
libsepol.mls_from_string: could not construct mls context structure
(No such file or directory).
libsepol.context_from_record: could not create context structure
(Invalid argument).
libsemanage.validate_handler: invalid context
system_u:object_r:admin_home_t:s0.c0 specified for /root/test [all
files] (Invalid argument).
libsemanage.dbase_llist_iterate: could not iterate over records
(Invalid argument).
OSError: Invalid argument
~~~
Similarly for port
~~~
# semanage port -a -t http_port_t -p tcp -r s0.c0 8888
libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or directory).
libsepol.mls_from_string: could not construct mls context structure
(No such file or directory).
libsepol.context_from_record: could not create context structure
(Invalid argument).
libsepol.port_from_record: could not create port structure for range
8888:8888 (tcp) (Invalid argument).
libsepol.sepol_port_modify: could not load port range 8888 - 8888
(tcp) (Invalid argument).
libsemanage.dbase_policydb_modify: could not modify record value
(Invalid argument).
libsemanage.semanage_base_merge_components: could not merge local
modifications into policy (Invalid argument).
OSError: Invalid argument
~~~

My main motive is to come up with a logic to handle this error better
but before undertaking that big of a change I wanted to push a small
improvement to the code and so I have added correct example strings of
MLS range into man pages for semanage-fcontext and semanage-port which
I have tested to work properly on my RHEL 9.5 VM.

This is my first contribution to the SELinux project.

  The added examples demonstrate:
  - Correct MLS range format: s0:c0.c255
  - Complete command syntax with the -r flag for both port and
fcontext operations
  - Clear indication that this is for MLS/MCS systems only
  - Practical use cases (HTTPS port and secure directory)

  This should help users avoid common mistakes with range formatting
and reduce support requests related to unclear error messages.
* Here is my Patch: 

Signed-off-by: Pranav Lawate <pran.lawate@gmail.com>
---
 python/semanage/semanage-fcontext.8 | 4 ++++
 python/semanage/semanage-port.8     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index 3a96c62f..3e7a1d8b 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -100,6 +100,10 @@ execute the following commands.
 # semanage fcontext \-a \-e /home /disk6/home
 # restorecon \-R \-v /disk6
 
+Add file-context with MLS range s0:c0.c255 for /secure directory (MLS/MCS systems only)
+# semanage fcontext \-a \-t admin_home_t \-r s0:c0.c255 "/secure(/.*)?"
+# restorecon \-R \-v /secure
+
 .SH "SEE ALSO"
 .BR selinux (8),
 .BR semanage (8),
diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-port.8
index c6048660..217fa398 100644
--- a/python/semanage/semanage-port.8
+++ b/python/semanage/semanage-port.8
@@ -61,6 +61,8 @@ Allow Apache to listen on tcp port 81 (i.e. assign tcp port 81 label http_port_t
 # semanage port \-a \-t http_port_t \-p tcp 81
 Allow sshd to listen on tcp port 8991 (i.e. assign tcp port 8991 label ssh_port_t, which sshd is allowed to listen on)
 # semanage port \-a \-t ssh_port_t \-p tcp 8991
+Allow Apache to listen on tcp port 443 with MLS range s0:c0.c255 (MLS/MCS systems only)
+# semanage port \-a \-t http_port_t \-p tcp \-r s0:c0.c255 443
 
 .SH "SEE ALSO"
 .BR selinux (8),
-- 
2.51.0

