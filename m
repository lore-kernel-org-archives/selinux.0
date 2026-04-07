Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD5238C1A
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540428; cv=none; b=Jh8/aLkvfwGovsUa2GOuQ0faTdc6oyeUmmQCtud1ye4JSvwz2TA2z3cC0KdM3s2upPAr2NG34cB4yvWlo3Jp0519tUHhI/x0xUZeo2D8/FT/8EFFgLtJoNtcKsq130ZnPhpFmMUXw11yukzfrXYl+HH+ryJ9Hn0K8PzZAzqMq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540428; c=relaxed/simple;
	bh=G1oWoGPHYdSeQMfxegdGLjC/XMjaIxGp/DKMnxq0l7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=CKha5NSIYNC5P+oZzGmf2yZnAP37IGeo59eYzOLKFUJdIEsP1uw0KeFfDHOErA9GIRgnFsMJ+k89y3QZTiXU7xeBHX4P45N7iHq8m6Z4+S/3FhUXWPXp//Vfj6FPF5UonMBwVnv2XkgHKYMyR2Amh0YiBaFG1F/TnWjlWgDYwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVMQHMZL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVMQHMZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775540424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlR4WGp3jjuMDykHxchj5FrHcMgRmVePd9U8W7z/vRs=;
	b=UVMQHMZLsaoeyWUliQUU7YzKI1zTKxR91CGzwn3KxgdxMoE1ZeYTCjC77Tr3n6KUG4Dbw5
	qNoXveZyegfuCFePBZUJenptqmX487+RlvVxRaN8zkd1ih116OIWHerY/Tf/8XfypR2+NK
	1j5Q2lrapKeAb2bE+tfnZcigWcNsURU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-Fx4vrORiOoa0-lTmKz6G-Q-1; Tue,
 07 Apr 2026 01:40:20 -0400
X-MC-Unique: Fx4vrORiOoa0-lTmKz6G-Q-1
X-Mimecast-MFC-AGG-ID: Fx4vrORiOoa0-lTmKz6G-Q_1775540420
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F21DB19560B2
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 05:40:19 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AFFB1800576;
	Tue,  7 Apr 2026 05:40:18 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/2] restorecond.service: Use Type=simple
Date: Tue,  7 Apr 2026 07:39:50 +0200
Message-ID: <20260407054003.801744-2-lautrbach@redhat.com>
In-Reply-To: <20260407054003.801744-1-lautrbach@redhat.com>
References: <20260407054003.801744-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

There's a race condition when daemon() in parent process immediately
exits while pid file is not created or updated. Using Type=forking it
can confuse systemd which tries to open non-existing pid file. It's
better to run restocond in foreground and use Type=simple

Fixes:

    openat(80</run>, "restorecond.pid", O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH) = -1 ENOENT (No such file or directory) <0.000006>

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 restorecond/restorecond.service | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/restorecond/restorecond.service b/restorecond/restorecond.service
index 0e4ea72d08ae..56f970707d93 100644
--- a/restorecond/restorecond.service
+++ b/restorecond/restorecond.service
@@ -5,9 +5,8 @@ ConditionPathExists=/etc/selinux/restorecond.conf
 ConditionSecurity=selinux
 
 [Service]
-Type=forking
-ExecStart=/usr/sbin/restorecond
-PIDFile=/run/restorecond.pid
+Type=simple
+ExecStart=/usr/sbin/restorecond -F
 
 [Install]
 WantedBy=multi-user.target
-- 
2.53.0

