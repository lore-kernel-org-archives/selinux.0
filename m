Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B73D3B8
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702022; cv=none; b=sPNxNRMiTEgByGG5uSwdnR1ZbUM/rSw3naCYXk5SA2LZ5hJ2sJEI5g7ZDPoSP4vVmfgptgQg6iFyLIA8qWtvH4fB55kXefoyCSvv0N1B0mFg/PAkx40OahG6Hr/Q+fn6Tcpsk44B6Z9ICj6kadXVIcJ3DPNxQXwjKzBEX1uGSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702022; c=relaxed/simple;
	bh=sCd/6VKf/LWBKEYx8itsPl01KwMsjYHjBYu/Ddh6/Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Zv2H0KnY01f2Pmqp7B3qtBYrpjrrklhfHOhEKR6iX8A2K8cOKrn9JKqfRp6SsU54Oq+N9GGkFqnSWs4R+HP2qAhiN0Au9BsyzcNGrgHPqAfoYLDEX+i6v+e96pqN1tgyYvn63jooC4/ZIERTv79LE/mFqqAI4VWWKP1obNVGeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JoO1rt/T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoO1rt/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750702019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OKd94FRh4xzfywQ+2VviqQBJDM2f2IDnWQh+EoaccHo=;
	b=JoO1rt/T9x2G1HrtQ+2NC2a1l0ODFA9s7KPNw26O8eSVXSiiDa+Rnxq05kSHIbgzauDWAl
	BuHMwbb9ZvFW2kkv4NlmaqLlLsxoAvq2wJK8h460p002jEy2glNwTIHQ/iCWV96HhtdEF9
	e7YgUNVRTI580wsPalR0N8C8JpasiYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-t1_vPP0hNSCPdgCBVdf7EA-1; Mon,
 23 Jun 2025 14:06:57 -0400
X-MC-Unique: t1_vPP0hNSCPdgCBVdf7EA-1
X-Mimecast-MFC-AGG-ID: t1_vPP0hNSCPdgCBVdf7EA_1750702017
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CB45180029E
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:06:57 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E877230001A1;
	Mon, 23 Jun 2025 18:06:55 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2] policycoreutils: make `-laudit -lbz2` conditional
Date: Mon, 23 Jun 2025 20:06:11 +0200
Message-ID: <20250623180645.232680-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit da6cd3d8d7600 ("Support static-only builds") introduced possibility
to build static-only toolchain. For static builds of `semodule` and
`setsebool` seems to be necessary to use `-laudit -lbz2`. As an side
effect, when policycoreutils is built without other components, the
buildroot requires libaudit.so and libbz2.so to be available. For shared
builds this is not necessary and had not been required before.

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

v2: fixed indentation, I was inspired by the wrong file :/

 policycoreutils/semodule/Makefile  | 2 ++
 policycoreutils/setsebool/Makefile | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 7c45831fcd4e..52a68dfcac10 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -12,7 +12,9 @@ SEMODULE_OBJS = semodule.o
 
 all: semodule genhomedircon
 
+ifeq ($(DISABLE_SHARED),y)
 semodule: LDLIBS += -laudit -lbz2
+endif
 semodule: $(SEMODULE_OBJS)
 
 genhomedircon:
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index 1d5148469f01..f68440f90df7 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -15,7 +15,9 @@ BASHCOMPLETIONS=setsebool-bash-completion.sh
 
 all: setsebool
 
+ifeq ($(DISABLE_SHARED),y)
 setsebool: LDLIBS += -laudit -lbz2
+endif
 setsebool: $(SETSEBOOL_OBJS)
 
 install: all
-- 
2.49.0

