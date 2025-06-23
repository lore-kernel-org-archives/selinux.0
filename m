Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDC2581
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686710; cv=none; b=fGNsinG1Mv6LaBf6dZX3bzk5uTxRPcmDrUEvSbrYsZx6geH3UgXW7Z3HPQ5IbxMxIFa9LZqN3Ps+yW5Hry/dCjKMuRRtxdGYO/i0diOGaZxWP/nhmJ/LgaXAfgGrodj64nyiRvqmVivYljQUYWKosUwgMLK0ZBgo9elErXFjjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686710; c=relaxed/simple;
	bh=6mbWcWZ7/tP2uB1z5LVTFdiJKo5ttzQ04Qt1AAxf/vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=LfrxqKJuNR0Bw/L3hu7q3kAY0JNykDLQdLlnE2IpJQcS29ZXfi9Idr8kdIzc/ND+nS4xNyUZTl7bNWNx1lrY3KES65hGI6ALzIFfgBRvXhQFa5J6R5oavEvq6+X0MebBVlBRLve+syS2+UzrbTOvb//9QTbiGy8+9rR7RJFyaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwssAMuJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwssAMuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750686708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dLjVQ98TveHu70JGbphhvu3a/QkY8n027K+dYdGfa8Y=;
	b=hwssAMuJdfRqil4fb4HbfcRsEhU0OqZPQP3Br8PFBnr/gSlu0gtax2lRdim2Kw2Y69Ikau
	pn77VIPV8tXlfT0h+w6JeITaCwjzZySOviFic2UNuOKYkBCotjfh7KxbXKV6V3ou2yfxZd
	+gvNz8yAsIg0dM9jy4QbPg3JUR61QSQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-x_IQEsOqNM6WXlEucHAiXA-1; Mon,
 23 Jun 2025 09:51:44 -0400
X-MC-Unique: x_IQEsOqNM6WXlEucHAiXA-1
X-Mimecast-MFC-AGG-ID: x_IQEsOqNM6WXlEucHAiXA_1750686704
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F04D31800289
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 13:51:43 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.182])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9368195608D;
	Mon, 23 Jun 2025 13:51:42 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] policycoreutils: make `-laudit -lbz2` conditional
Date: Mon, 23 Jun 2025 15:51:33 +0200
Message-ID: <20250623135133.217270-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit da6cd3d8d7600 ("Support static-only builds") introduced possibility
to build static-only toolchain. For static builds of `semodule` and
`setsebool` seems to be necessary to use `-laudit -lbz2`. As an side
effect, when policycoreutils is built without other components, the
buildroot requires libaudit.so and libbz2.so to be available. For shared
builds this is not necessary and had not been required before.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 policycoreutils/semodule/Makefile  | 4 +++-
 policycoreutils/setsebool/Makefile | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 7c45831fcd4e..e5e5a3086224 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -12,7 +12,9 @@ SEMODULE_OBJS = semodule.o
 
 all: semodule genhomedircon
 
-semodule: LDLIBS += -laudit -lbz2
+ifeq ($(DISABLE_SHARED),y)
+	semodule: LDLIBS += -laudit -lbz2
+endif
 semodule: $(SEMODULE_OBJS)
 
 genhomedircon:
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 1d5148469f01..03b8b67a5cb3 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -15,7 +15,9 @@ BASHCOMPLETIONS=setsebool-bash-completion.sh
 
 all: setsebool
 
-setsebool: LDLIBS += -laudit -lbz2
+ifeq ($(DISABLE_SHARED),y)
+	setsebool: LDLIBS += -laudit -lbz2
+endif
 setsebool: $(SETSEBOOL_OBJS)
 
 install: all
-- 
2.49.0

