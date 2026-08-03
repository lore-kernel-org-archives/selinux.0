Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EE3AFD19
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747725; cv=none; b=K5POIXU8dAnBzYjk9xkrd77/dFD074vHM6TRFki+Ac0s8faUvbyV+j6quzAKCjomeIt7KHJmR8nyDFzq5oscH0La5t3tAH2gX2UFDiF5lvJTPGCzrzdZyCbPNbd5n9QzJFowOoHlnTuXSbx2w6sZyY13PjHQ7/3QcfUiObdlqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747725; c=relaxed/simple;
	bh=NkHPkVjag0YxcBY8j4EiieUSZG0254bWoLRPU6Gz4o4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L8gn1ZwBwo4KCbwKZmZgd6VDIOoGslwlHsp3E7W/BWCdGyNqDTiTwjs8bMcP4qCN1f4PP1X4SC//WVVQYgEP8Hxy/A1bI0KUXR6zBg1MyptuIAUoTt+Pb7csbxE9ypShfPq5Vs/SuIQpoSLVMECnLyLPZI9orIwkHsVXxf45s9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8G37LGY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ov8/h2u+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8G37LGY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ov8/h2u+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785747718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZzSBCRe+WfMCg+D+LZ8/VAHYLVXu0WIoWbVlrBRM25A=;
	b=F8G37LGYUCIQDwFYl4xqHgSxkQNvQbnN6CeHaFyIScOVrbIfU6XqVizsPNX+MmucihX/LQ
	bmc8vPnsrOJ6hcZyIP6WlOQxsXMayW3ZO++LpiSK3aOW1UkVDiFSx0c+d9ZNqPPId0PPpO
	u95zguCRerLmiPKdWIajS1KbsNiIofE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-lfZNij3mNPWSam_GVhidPA-1; Mon, 03 Aug 2026 05:01:57 -0400
X-MC-Unique: lfZNij3mNPWSam_GVhidPA-1
X-Mimecast-MFC-AGG-ID: lfZNij3mNPWSam_GVhidPA_1785747716
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47162f83c75so2204830f8f.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785747716; x=1786352516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZzSBCRe+WfMCg+D+LZ8/VAHYLVXu0WIoWbVlrBRM25A=;
        b=ov8/h2u+iU/Cf19tvgKU3fI3giouEOUSXbgdllixo+gc8uVEexxLzAD6kSnOMNiaL1
         T+VxLR5VGXFCj0yelKe9F5biWDajJRhN9Ngv3zPJl1QEx1bUEBkgklzq/mx2DuVbOoKd
         hIDSOZIFJKFBA1qiD4+3wIlwXXoK5+0izM6qB0p/JSzvArpDLczbWuAjpTPh1gMEbbEZ
         a16MvaPkoPYsfclc6K5g3ae9N9mGU/Iyl4PGDX5VRHPQxtvMqtGLUwGWoMgXTMsrwrTH
         7SaH4dbBU3Ln6/XmwzWsglSj39FVExbdl0rkxQNOoytKsSOfi4JnweKZ4bW3svcGN3cA
         UJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747716; x=1786352516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZzSBCRe+WfMCg+D+LZ8/VAHYLVXu0WIoWbVlrBRM25A=;
        b=pwt2mg4DYMmV0J45PPY/WMIsksoKY0UUkTHkkUYcdawoP3LwBY8QvDEcD3rWo6/yOe
         UdAzTB6qqySZiDJyE4L/yB93FUMpDY3NAR2QZrj41r7qxkX/imYPDMPaZhOoUyCWiN2L
         Bnsle+rwyBJH6fr3ZRORH5YxOLOExTnsNB7fF1YDeaFEOHU3IxUznh2KK464q8Eh/JQa
         KFVyGuk42gfMhhdcgK2Ljicy/9jL/rRX4Nnn6NmtYQ7+IMCDxDJf0mO8iDGSfaUDtffp
         nCKmYlARVoA/qFxrdiSh8bsDnA2XyzVPbRwJ1HS9jEM/fVk7TCnCF3BGlvvAfR1Salkp
         sIyg==
X-Gm-Message-State: AOJu0Yx+RGwBDlxjk1ILw+mi1tCvUnKyR9RCNnLbGu7MpTSPAT0nkXfu
	HSqSh/LLRZExKnAWbqk+cwkaUslksNFduCxj6DNvJ//lFsd9YPmHRyMjNNXz+CyZ0yg7+kuI50W
	vQIwAyD3dIlDKE+fL1ePZbvmDx1SwGQvIqz/W+1MpkDMOQ8rB0Y+QxXf79uwfi5BAjfnQGbsWP7
	rRNSUBZIjSXOFzMyb9neY9fysjZs3OkIcvUjDaRreogjE=
X-Gm-Gg: AR+sD12YukTxxQONTtgZm+/+zWGLu8vWYWXpXmfzwDx0wEddUNRcGulYwgyUurB11y8
	/B0o877lct1EkAa2xBIqDDkkeLbbZj9mRg6uFEN5vd/X6yfmrNLMXygI1n6L9JKg/XRhsEk7Tey
	/K9ve5f9BQpLPoUpPaOqMZeodmVLFFHa2no8bj7fDQYh5XHipR86Vc1C7MU+dcEtyCtt+JABCCh
	r0SzwgkMk6dYupLUfVYRgRHmKPC1UqM40P4iyP81CwFCCaHFRZZbyjjO26yJh0AklLyWnQMS4Bj
	V91zSdVHeT3gXnyYKKQEuBtUo3I0rcAe4A6LI6E3jT37k6jcBPb32fVE/pIX/cay/CLCqhUront
	Oi/XpPp21jNFIl8VISSzLF1FUQeE=
X-Received: by 2002:a05:6000:41d3:b0:47d:f508:3364 with SMTP id ffacd0b85a97d-47fd32e1a5amr28016943f8f.15.1785747716169;
        Mon, 03 Aug 2026 02:01:56 -0700 (PDT)
X-Received: by 2002:a05:6000:41d3:b0:47d:f508:3364 with SMTP id ffacd0b85a97d-47fd32e1a5amr28016826f8f.15.1785747715634;
        Mon, 03 Aug 2026 02:01:55 -0700 (PDT)
Received: from fedora.redhat.com (109-81-82-77.rct.o2.cz. [109.81.82.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bf7csm32370263f8f.32.2026.08.03.02.01.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 02:01:54 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/inet_socket/connect.c: add missing include for bool
Date: Mon,  3 Aug 2026 11:01:52 +0200
Message-ID: <20260803090152.1456176-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The below commit added a usage of the bool type to
tests/inet_socket/connect.c, but didn't add the corresponding stdlib
include (<stdbool.h>). This problem seems to be masked on Fedora (likely
some other header file includes <stdbool.h> internally), but for example
on CentOS 10 or 9 the compilation fails because of it.

Fix it by adding the missing include.

Fixes: 433c597a6a9a ("tests/inet_socket: add tests for TCP Fast Open")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/inet_socket/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/inet_socket/connect.c b/tests/inet_socket/connect.c
index 067d196..89e85ef 100644
--- a/tests/inet_socket/connect.c
+++ b/tests/inet_socket/connect.c
@@ -3,6 +3,7 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stddef.h>
 #include <string.h>
-- 
2.55.0

