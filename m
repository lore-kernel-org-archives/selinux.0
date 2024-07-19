Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B7320E
	for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405863; cv=none; b=oYZlqEAjqbestsw99Po23Z2E2Rx3j0gbgSDzpTE+mTJgv5tEjdKMun0goL9UoW2EjCo9zFfO/PMuGoOEBoGWDRaDwl5GcA3iCFnKc1SifnC4mDkJoS3wwLCUCbJAIi5f48zkfBRsb6HQYm3m/jr6m446CjyiTmXAWhIXRqbefNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405863; c=relaxed/simple;
	bh=sqn8ikfVT3VIZ1GlfGOnP+qnKMcpKqz5Cvll1AzKfKY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gMirjvOt/mmYEc1Uiiha3L3yMyjZ2MFUUmeceytba4FqWLDzgSOwv4xwWt5vA8/DCls/KLYVyG8h/WxV0es4oi8M/X2bbqb1u8CrCl1/pTt/IO+es3J1BWD7fQPpLeygjXGbMV/K6yD9NAsu48VqNj9jl4aO/q+u1/xklzrdrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6Wk3edL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6Wk3edL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721405861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/kuDa24t6Hiw7Oo6rzK5YS0aXlynauLJucPc2a2gyXI=;
	b=i6Wk3edLYHhgh4w7Al+srN+CmMZT1jz1UEfbnrW2eXqi6F+CpqijwmyHT+uTXE2PRVOAgE
	CSGZwl67UFjCNAnSOnjsIZyqdjFjGV/GFUXMSN+B0HOXLn1KlGFDhck0i91aXtuADO31MR
	MrAdm/Oi+Cb8Abw6Q0/Hx/tlmLG9HSk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-FJ5cZNoSMiy5PhWXakytGA-1; Fri,
 19 Jul 2024 12:17:39 -0400
X-MC-Unique: FJ5cZNoSMiy5PhWXakytGA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 189831955D44
	for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 16:17:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DADFA1955F65
	for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 16:17:37 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol/sepol_compute_sid: Do not destroy uninitialized context
Date: Fri, 19 Jul 2024 18:17:13 +0200
Message-ID: <20240719161713.963130-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Avoid context_destroy() on "newcontext" before context_init() is called.

Fixes:
  libsepol-3.6/src/services.c:1335: var_decl: Declaring variable "newcontext" without initializer.
  libsepol-3.6/src/services.c:1462: uninit_use_in_call: Using uninitialized value "newcontext.range.level[0].cat.node" when calling "context_destroy".
  \# 1460|   	rc = sepol_sidtab_context_to_sid(sidtab, &newcontext, out_sid);
  \# 1461|         out:
  \# 1462|-> 	context_destroy(&newcontext);
  \# 1463|   	return rc;
  \# 1464|   }

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsepol/src/services.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 36e2368f..f3231f17 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1362,14 +1362,12 @@ static int sepol_compute_sid(sepol_security_id_t ssid,
 	scontext = sepol_sidtab_search(sidtab, ssid);
 	if (!scontext) {
 		ERR(NULL, "unrecognized SID %d", ssid);
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 	tcontext = sepol_sidtab_search(sidtab, tsid);
 	if (!tcontext) {
 		ERR(NULL, "unrecognized SID %d", tsid);
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (tclass && tclass <= policydb->p_classes.nprim)
-- 
2.43.0

