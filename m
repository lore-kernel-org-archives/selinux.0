Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E593F5BC5
	for <selinux@vger.kernel.org>; Mon, 25 May 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725835; cv=none; b=FydOAvZFxp7ZyoMH51DfrHUt1GTia9Ir/eH1airAzXTXiLs2cCEp34bMKDPoPPBy5P+Ap/4C5dwu0x99aX4BPgy+u2n2tmCCEpKUznt07G0YQfPRSb/oHb52m/NaQchlyMwblTNV3xlZJLksHvcz+7z1n0Hc3txgHnsenRhMbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725835; c=relaxed/simple;
	bh=m0Ornl7ujYcxexqyAdqhxLnJWNF7m4DctVY2dPYg4lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=HazD/j6omE+LsGjH5HyCuzuyS8L8zRGYXRiZRY1w+UJPGQm26RiirxYjsEu66l8yL8NojJTOibrdbK1Ao+gnv9DMd18nfkWHY/tVvIwCqpP0y8zE20jFm42T6jsYshgcL0M+V9PbAcUjhL2ErXSgQQ+MAwfnBRJiYVVPTJDzsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OE1zWRrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OE1zWRrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779725832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HBYVnja8KyOs94zT70CrfwsPJIiqdQ0cxB1UhyhEQO0=;
	b=OE1zWRrSQyWrzB8iBz+TsxDcO3cA+FARMfZm+/xDG9YUVmlSWOJ5Zg9qV+f4UxOUmql+Fw
	9AxzYApCHKzRyyrvh1rOiR8BXm0Mu1SeSxkD69xOl0NvjCdyzz7oUlMPZxzFsvT7fH1qzv
	ODe9Urc3Cpxf2k9zGDaROaELykeUNPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-OZjwvr_5PgK8qDdM13Ne2A-1; Mon,
 25 May 2026 12:17:11 -0400
X-MC-Unique: OZjwvr_5PgK8qDdM13Ne2A-1
X-Mimecast-MFC-AGG-ID: OZjwvr_5PgK8qDdM13Ne2A_1779725830
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E79819560BB
	for <selinux@vger.kernel.org>; Mon, 25 May 2026 16:17:10 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.48.73])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F5C71956053;
	Mon, 25 May 2026 16:17:08 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] restorecond: Do not unlink pidfile if not used
Date: Mon, 25 May 2026 18:16:56 +0200
Message-ID: <20260525161704.228092-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With -F or -d, restorecond does not create nor use pidfile and therefore
it should not try to remove it.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 restorecond/restorecond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 36f82ae5e9cb..6353b3b72798 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -217,6 +217,8 @@ int main(int argc, char **argv)
 		if (daemon(0, 0) < 0)
 			exitApp("daemon");
 		write_pid_file();
+	} else {
+		pidfile = 0;
 	}
 
 	while (watch(master_fd, watch_file) == 0) {
-- 
2.54.0

