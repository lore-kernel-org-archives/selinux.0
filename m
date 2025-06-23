Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E613C23ABB7
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674461; cv=none; b=Zuf4GZexpbqbovCWq+GIz+5fAvG+j+mE6f2yizoBmBst0mEP0aFIRS56mmfC+N1yPdUYA7c7ybdVz8e+97vJay8GdO0maCppa94ke8Z0aZtTMukZG65Ra/CsJbTMSr2Faqo0LUS0mybewext+FXS3ZHsLpQo0XvJ73jPZbIaX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674461; c=relaxed/simple;
	bh=iTFDtXiaTnh8pimCULOBuhpb94K7x5lPkxv8BRw0sng=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CO7DNYIkU5m0MKDmrUmzikDmBXJ7Fz/jcXTt3ANYG3XAFYUTspacajNZ6XdTVvvcLIORvu2KWipaYCozTj3Mz7WWjKMWzNk58ee7Y/aGm5JBWVfybilX44wrEjBoBvhvaaAofpwTXk+3K26+kSt+XiK6/miEv39aC5rBis7cg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJrjfJsC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJrjfJsC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750674458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ExQiT6qXoK7A98FAcybxJaWBtThQlooW1qNrUeEvFRA=;
	b=JJrjfJsCcxuO9VU10lCUonkUjnx05bPdjF2X+aU9VzPMwHkA/NTy/sQCcf48asA0ANg0rv
	6u4XjQ2zJbkKsm8C3H7UXmojckU7arRb2Rz5QyaSNlVqxc79f0O0JWs37kTw4VPDp8Yls7
	y6Poo5SIf8/btVj4u29YCGBQf0w20+8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-eorDf4qqMmuQWZK8n72bcA-1; Mon,
 23 Jun 2025 06:27:37 -0400
X-MC-Unique: eorDf4qqMmuQWZK8n72bcA-1
X-Mimecast-MFC-AGG-ID: eorDf4qqMmuQWZK8n72bcA_1750674456
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92E52180028D
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 10:27:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6F9218003FC
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 10:27:35 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] checkpolicy: Allow attribute assignment to attributes
Date: Mon, 23 Jun 2025 12:25:32 +0200
Message-ID: <20250623102726.3818713-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Allow "typeattribute <attribute> <attribute>" to pass checkpolicy,
since (typeattributeset <attribute> <attribute>) is valid in CIL.

Fixes:
  $ cat myattributetest.te
  policy_module(attributetest, 1.0.0)

  gen_require(`
  	attribute domain;
  ')

  attribute myattribute;

  typeattribute myattribute domain;

  $ make -f /usr/share/selinux/devel/Makefile attributetest.pp                                                                                                                            2 ↵
  Compiling targeted attributetest module
  attributetest.te:9:ERROR 'unknown type myattribute' at token ';' on line 3418:
  typeattribute myattribute domain;

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
After some simple tests with CIL policies, it seems that attribute
assignment works as expected. Is there a reason checkpolicy does not
recognise it?

$ cat a.cil
(typeattribute a)
(typeattribute b)
(typeattribute c)
(type mytype_t)
(typeattributeset a b)
(typeattributeset b c)
(typeattributeset c mytype_t)
(allow a user_home_t (dir (getattr open search)))
(allow b tmp_t (dir (getattr open search)))
(allow c etc_t (dir (getattr open search)))

$semodule -i a.cil

$sesearch -A -s mytype_t
allow a user_home_t:dir { getattr open search };
allow b tmp_t:dir { getattr open search };
allow c etc_t:dir { getattr open search };

$seinfo -xa a                       

Type Attributes: 1
   attribute a;
	mytype_t


 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4e0ddcc6..be788e8e 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1440,7 +1440,7 @@ int define_typeattribute(void)
 		return -1;
 	}
 	t = hashtab_search(policydbp->p_types.table, id);
-	if (!t || t->flavor == TYPE_ATTRIB) {
+	if (!t) {
 		yyerror2("unknown type %s", id);
 		free(id);
 		return -1;
-- 
2.49.0

