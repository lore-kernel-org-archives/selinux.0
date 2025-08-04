Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD22868A5
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327407; cv=none; b=A+B9TbYAS7kxf8ugInjqb2zoFsmVg2aY8nQY5yA9BcJL5njPygkToAOFr/+UXy2xLTC1x54pHL6/NPURuGeuVl7YaZinOtT7NqO6hy+HSnpWiEz/CAWlOW+IoFmIH/kejDXID/vKna7ges+kK5PVU5c/IAg3LG1fcLyQ1SEWFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327407; c=relaxed/simple;
	bh=9YxoarysC+JlxqrEtfOESKYjngiGtIxQ0E8CEh/VmVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWCu9zZqf7oF190dod88RO08rD84JGuUYUrYxts/Fycb2uRNZW8Bsad6iUf0S9rOQYKrqV5WbppBLpcPedEiz1bQTAO92GWOUXuqthJti94zueTnf/S9vNWfvlUTbrGTpmw1HyV/80LEy2l0MMSTcQtSzl6XFi2PMh92aPooOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSvMpwOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSvMpwOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754327404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQiccqwb3852XP5PUpovlNUiTghhgWpIkmN0BxpnNbQ=;
	b=FSvMpwOwZwmYCuQ3+iDDn4OAwEjAeIdMQVSgb/t9FVvLfgb5ZE4AsWLPmyETvXnmNH88ZV
	tWMlElD/5uTnf6dgc59BPWvgBZUt33W2W6IlyPl0WNHTFkZ5MutPBXH8l+3M3g44UPCTHw
	ftnAXV0dALAzl/clfTMFU6zEXJEykng=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-pXU19TM8O9qfyZ6awo_5pg-1; Mon,
 04 Aug 2025 13:10:01 -0400
X-MC-Unique: pXU19TM8O9qfyZ6awo_5pg-1
X-Mimecast-MFC-AGG-ID: pXU19TM8O9qfyZ6awo_5pg_1754327400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E7071955D4B
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 17:10:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.228])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C6531800359
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 17:09:59 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] secilc: Add test for attribute assignment to attributes
Date: Mon,  4 Aug 2025 19:03:45 +0200
Message-ID: <20250804170953.246873-1-vmojzis@redhat.com>
In-Reply-To: <20250716144435.1084767-1-vmojzis@redhat.com>
References: <20250716144435.1084767-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
Added a deny rule to the mix, which also behaves as expected.
To be honest, I gave up on more complex examples with deny rules, since
they quickly become hard to understand (but at least never caused a
compilation error for me).

Please let me know if there is a use case you'd like to see tested.

 secilc/test/attribute_assignment_test.cil | 79 +++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 secilc/test/attribute_assignment_test.cil

diff --git a/secilc/test/attribute_assignment_test.cil b/secilc/test/attribute_assignment_test.cil
new file mode 100644
index 00000000..dde3be5e
--- /dev/null
+++ b/secilc/test/attribute_assignment_test.cil
@@ -0,0 +1,79 @@
+(typeattribute a)
+(typeattribute b)
+(typeattribute c)
+(typeattribute d)
+(typeattribute e)
+(typeattribute f)
+(typeattribute g)
+
+(type ta)
+(type tb)
+(type tc)
+(type td)
+(type te)
+(type tf)
+(type tg)
+
+(role rr)
+
+; Basic attribute assignment
+(typeattributeset a b)
+
+; Assignment with types
+(typeattributeset b (ta tb))
+(typeattributeset a b)
+; Expected: a includes both ta and tb as members via b
+; seinfo -xa a
+
+; Chained attribute assignment
+(typeattributeset a b)
+(typeattributeset c tc)
+(typeattributeset b c)
+; Expected: a includes tc via b and c
+; seinfo -xa a
+
+; roletype assignment via chained attributes (tc -> c -> b -> a)
+(typeattributeset a b)
+(typeattributeset c tc)
+(typeattributeset b c)
+(roletype rr c)
+; Expected: tc is assigned to role rr
+; seinfo -xr rr
+
+; Multiple attributes/types assigned 
+(typeattributeset d td)
+(typeattributeset e td)
+(typeattributeset f (te tf))
+(typeattributeset g (d e f tc))
+; Expected: g includes tc, td via both b and c, and te and tf via f
+; seinfo -xa g
+
+; Cyclic assignment
+(typeattributeset a b)
+(typeattributeset b c)
+; (typeattributeset c a)
+; Expected: ^^^ Should exit with error
+; Self-reference found for a at <test file>:38
+
+; Allow each attribute some access so that they don't get optimized out
+(allow a a (dir (getattr)))
+(allow b b (dir (open)))
+(allow c c (dir (search)))
+(allow d d (dir (search)))
+(allow e e (dir (search)))
+(allow f f (dir (open)))
+(allow g g (dir (getattr search open)))
+; Expected: ta is assigned to "a" and "b", while tc is assigned to "a", "b", "c" and "g" and so are assigned permissions accordingly
+; sesearch -A -s ta
+; sesearch -A -s tc
+
+; Deny rule
+(deny f g (dir (open)))
+(typeattributeset g tg)
+; Expected: tg (assigned to g) is allowed "getattr", "search" and "open" access to g,
+; while tf (assigned to both g and f) is only allowed "getattr" and "search"
+; sesearch -A -s tf
+; sesearch -A -s tg
+; ^^^ the "open" access is assigned via a new attribute deny_rule_attr_XXXX,
+; which is assigned types in "g", but not in "f" -- tc, td and tg
+; seinfo -xa deny_rule_attr_XXXX
\ No newline at end of file
-- 
2.49.0

