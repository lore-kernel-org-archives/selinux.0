Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B7262FE9
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677085; cv=none; b=RI70RKB+1MRfPszg7YWVV2QHyli40PymPdWnCB8c17/1HOqchMndGpywJ5GKT4OKk3rJfxXso5ykXzXwqPE7TIXCGe4eruY3IWbCZVhiaV0YuBGssZtY3Jdwn8nD9JU+4+P7da5xLoNuutP8n861SZkfCUz/eWTgLJ8zfXMnUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677085; c=relaxed/simple;
	bh=5jADHAx3myVKNtN3QvvEmiB72uaiLAbHOUV8D3FYU7g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgcMtzwV2n3bSRY3FKYbQzNGljSq+JY81aoo7N3vanYO4qNmYID26DrUQIT+nGj1OUJyR0mlgScDSbyD+5mCw8xFA6M/QdLCFCHSiDhpibUekK9L9HcUEC0VVm3arVDJzCs0RXwt9xtuEpeWiSq9mjqEdpamQB7q+PYy0BN/5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCLmnkHP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCLmnkHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752677083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IV+syq99IZJCm0nRntQoL4Kicv3ywW8NNFzJ+bKBME0=;
	b=gCLmnkHPFZpmeqYDeC+qo66EVHQ7gRD3w+4Ph5vvDGcuKsZbzWdmiujPSA54pYgxy/G8fJ
	n0/CC1RO8YXbuO8wbZ8G7DRjNTYxrn7tM5mmj936p4vLV1KOBDTs6/H5cuS2v4EnVnRKU5
	L5x+GehRb7CCKpuP0Qsq/FPB+wafwe8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-AMdZr4pCNCSKAVLeqbc3Hw-1; Wed,
 16 Jul 2025 10:44:41 -0400
X-MC-Unique: AMdZr4pCNCSKAVLeqbc3Hw-1
X-Mimecast-MFC-AGG-ID: AMdZr4pCNCSKAVLeqbc3Hw_1752677080
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBCDD1800D82
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 14:44:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1556C300019F
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 14:44:39 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] secilc: Add test for attribute assignment to attributes
Date: Wed, 16 Jul 2025 16:16:18 +0200
Message-ID: <20250716144435.1084767-1-vmojzis@redhat.com>
In-Reply-To: <bd163350-a979-4af9-97a2-80f65f123054@redhat.com>
References: <bd163350-a979-4af9-97a2-80f65f123054@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
I played around with the functionality in CIL and if setools is to be
believed, it seems like the attribute being assigned to another
attribute always gets expanded. Meaning that in the kernel binary policy
there are no attributes with attributes, just types assigned to
attributes.
The functionality overall seems robust and even corner cases like
a circular assignment, or roletype statements are handled properly.

In [1], I tried replacing types with proxy attributes in order to have a
more complex example (interface calls, transition over multiple
attributes, etc.). The policy translates properly to CIL and seems to be
enforced as expected.

Please let me know if there is a use case you'd like to see tested.

[1] https://github.com/SELinuxProject/selinux-testsuite/pull/102

 secilc/test/attribute_assignment_test.cil | 67 +++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 secilc/test/attribute_assignment_test.cil

diff --git a/secilc/test/attribute_assignment_test.cil b/secilc/test/attribute_assignment_test.cil
new file mode 100644
index 00000000..f8306cee
--- /dev/null
+++ b/secilc/test/attribute_assignment_test.cil
@@ -0,0 +1,67 @@
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
+(allow f f (dir (getattr search open)))
+(allow g g (dir (open)))
+; Expected: ta is assigned to "a" and "b", while tc is assigned to "a", "b", "c" and "g" and so are assigned permissions accordingly
+; sesearch -A -s ta
+; sesearch -A -s tc
-- 
2.49.0

