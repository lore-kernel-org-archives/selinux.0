Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F991A0721
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334644; cv=none; b=SpdR9VsscKJzDJ1iSma7kMNUFi6JqcHSU5giL+BigZn23kstQDSYIz4zR+9G0iSYxKXD4PxC1KehGqnvE5zfpeoYGLB/NoiYA5bww9wPhpdGJPMUwof/x6ER7keLBsZTo614APNMY+GIgI9s6WGW1yyqcMWK4MfgiAB6Xec46Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334644; c=relaxed/simple;
	bh=Gc/1q3VKbWRM/C3IwC9jUGDHohr3fYVYRU1NvUQtmB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrGxShc3VQvIBPfWt6TyKbCVTaJy2fKa5a+EGTr85DKo2lvLzPk7umuO4Rpm+3Vq0aQ5oFqsEprHJL6RO2ibaSxxtF6qUqkEIdT2SeOb1B6BLrX+QlUbe2L9BzFarl34m3RA0MGYnuvZSW96vMmfNgYxlaVkNQ8TDn8sgPCWknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rpy6TzVe; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rpy6TzVe"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZpBwwbly1+1nfkmJzE4u7V79GtAviKmPHPtUFNfR3Y=;
	b=rpy6TzVeoCWqVfDqtZAQiXpx9sCdHmrxlkaiY+LFvp0/XS9LUy2TUiYcp1m1HUS4kZO48s
	Pu70B9AdwqggBEqmMoz9+uti1g4Tjv+5hu4Icbf8CfdnJTo+Twa7GIr4kcceMiflyizWLr
	7AVtYspIag+zEngD/X62cu74yEidaIEFuodKeRtDxahm1L7/QLZdgdr8Xq3+dlgFEwx6SX
	wr/9ncG3iUPHQTGwZVGfSrygu9K7FbnJByQe1NneS8SUFWsdcuzdfLILqu+Cbrwz8/wueS
	7LWXX//Nmhpr5qfxSc9mwNfjpO64wvCkhlCScda8T0R+5au2EroSsW8mM83gHg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 22/47] libsemanage: free ibdev names in semanage_ibendport_validate_local()
Date: Mon, 11 Nov 2024 15:16:41 +0100
Message-ID: <20241111141706.38039-22-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/ibendports_local.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/ibendports_local.c b/libsemanage/src/ibendports_local.c
index e696fdca..feebfa63 100644
--- a/libsemanage/src/ibendports_local.c
+++ b/libsemanage/src/ibendports_local.c
@@ -80,8 +80,8 @@ int semanage_ibendport_validate_local(semanage_handle_t *handle)
 	semanage_ibendport_t **ibendports = NULL;
 	unsigned int nibendports = 0;
 	unsigned int i = 0, j = 0;
-	char *ibdev_name;
-	char *ibdev_name2;
+	char *ibdev_name = NULL;
+	char *ibdev_name2 = NULL;
 	int port;
 	int port2;
 
@@ -97,6 +97,8 @@ int semanage_ibendport_validate_local(semanage_handle_t *handle)
 	while (i < nibendports) {
 		int stop = 0;
 
+		free(ibdev_name);
+		ibdev_name = NULL;
 		if (STATUS_SUCCESS !=
 				semanage_ibendport_get_ibdev_name(handle,
 								  ibendports[i],
@@ -114,6 +116,8 @@ int semanage_ibendport_validate_local(semanage_handle_t *handle)
 			if (j == nibendports - 1)
 				goto next;
 			j++;
+			free(ibdev_name2);
+			ibdev_name2 = NULL;
 			if (STATUS_SUCCESS !=
 				semanage_ibendport_get_ibdev_name(handle,
 								  ibendports[j],
@@ -136,6 +140,8 @@ next:
 		j = i;
 	}
 
+	free(ibdev_name);
+	free(ibdev_name2);
 	for (i = 0; i < nibendports; i++)
 		semanage_ibendport_free(ibendports[i]);
 	free(ibendports);
@@ -145,6 +151,8 @@ err:
 	ERR(handle, "could not complete ibendports validity check");
 
 invalid:
+	free(ibdev_name);
+	free(ibdev_name2);
 	for (i = 0; i < nibendports; i++)
 		semanage_ibendport_free(ibendports[i]);
 	free(ibendports);
-- 
2.45.2

