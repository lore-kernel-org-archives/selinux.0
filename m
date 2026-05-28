Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999C2D7D47
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977496; cv=none; b=TnOAWgZZTF1bmDulzqZ21aUPkvrYBVuM9sDoNfXhg/vzbZ1rQyzZbFsgQeE6Z49Z/lBC70PCyMwF6dIiyTtSo4Zb6T/J5cUtpdmGhuOWegGQ0LH7pZBDgt4ZlkTYaVrQ86bQmkaUXYRKo4C19cCWVoLZOIB3E7wUROOWku1yUmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977496; c=relaxed/simple;
	bh=qNJpHNZDaQSRkCa9qoxQFMBdwa1ExgexzdbWsj+Ab00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=DlAgdIHXe7R0rIfBAQk714myKzdj7E5WKa/bJTGGuMauFoD7eQ6fqHVXr1OMC9pv61rOooeOOrwBhHjgx0FB9ukBWzzyaK+v97NByKfrDIjJpBSlDPPUDhKO9EBJGLhI6ebZF91BGkW/N7n51L4rWYYvQdAKyacxltqWdk0mnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJJQt7Cy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJJQt7Cy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779977493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOZrxg1ADaNl+ldYxFNTnoly6cDDll+BjDcYuTPdC8M=;
	b=eJJQt7Cyu5pRghmUinzijzorrryMKkBb7O7JlJpZfiyC1Iew5GvMq29DT+cuio0z3HCEPO
	5S6xRetKrDOnz4seuumIajHynbAZSahyy/U5LWsq62pnqN7E8DMAQVitfTsHLadahgNEZy
	Vioumx6t9qIl+QHSvD85diKEwePlW8s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-XAvVPTvfONKArn3D-gcjhg-1; Thu,
 28 May 2026 10:11:29 -0400
X-MC-Unique: XAvVPTvfONKArn3D-gcjhg-1
X-Mimecast-MFC-AGG-ID: XAvVPTvfONKArn3D-gcjhg_1779977488
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41FD21955DDD;
	Thu, 28 May 2026 14:11:28 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 116161800347;
	Thu, 28 May 2026 14:11:26 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Pepper Gray <hello@peppergray.xyz>
Subject: [PATCH] expose alias for stat64 and lstat64 on musl
Date: Thu, 28 May 2026 16:09:56 +0200
Message-ID: <20260528141117.1265999-1-lautrbach@redhat.com>
In-Reply-To: <CAHLDejyMAktQhBkfJrvz5OrS=d7WSSe4pFA33qKJALtH_nWafw@mail.gmail.com>
References: <CAHLDejyMAktQhBkfJrvz5OrS=d7WSSe4pFA33qKJALtH_nWafw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Pepper Gray <hello@peppergray.xyz>

fix: 477
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
---

This is resent of the originally mangled patch. This time taken from https://github.com/SELinuxProject/selinux/commit/0471d76499aae8f44cb21c7faa1609e0387abafb
and sent with `git send-email`


 libselinux/src/selinux_restorecon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 69a535032221..1a4cc7d12b76 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -20,7 +20,6 @@
 #include <limits.h>
 #include <stdint.h>
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/xattr.h>
 #include <sys/vfs.h>
 #include <sys/statvfs.h>
@@ -30,6 +29,10 @@
 #include <syslog.h>
 #include <assert.h>
 
+// expose alias for stat64 and lstat64 on musl
+#define _LARGEFILE64_SOURCE 1
+#include <sys/stat.h>
+
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include <selinux/label.h>
-- 
2.54.0

