Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E83CAA5F
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406729; cv=none; b=fShbZnEKlB2TLkN4DWXTNC1THgdVnFnp7/TMt3r8uBz7nytfdQNxrgA27VFedM0IXrQEn79MOeea9o/+tQfmzKGnUx6++KXtzWf6/14BmWNaPLn+dsGGOeUAdftuCBCQYtQ28p212/5yLoTzsvAC/Ox4X5pT2BlMB8JeJPTBWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406729; c=relaxed/simple;
	bh=G2hysh83EqpvZeYMOmnONOvEyegenw4sWtABnvxwcKY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qN9mLenXnjiKxxX5fj4WtwsDIPdLrlUjIITUbZVtPNyu2jyS42LYEF0WWfML9Krs4A0u+cFX0VuueUmn3ij5kCOdYl/ktlcvXdIJ8ENxs7zxIRbV4w9/9omwiiiM9SmQG4qWG2LIFFZG2jFIBL9pSfMgITHgjDqzKBztKPul5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIumqaVs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIumqaVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785406726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a9Mmq/R20scI37R0PiTfpYPtnvfDGEYO4ECXqe4rwus=;
	b=gIumqaVsf0Jq3ZryHcylaw8yST+Mqhk4UJ0XguTMenY/8w5ojV0Fe8OuNoo/sVRZPsOEPk
	T47iygeyUshzGg0XSoD5ioaWqA4SDNILPcUWA8j2Ym/HF/mjHNe0c27kfyJoV7uCSRlGCd
	mJpJJ/vt2cwxtrhBHxXHogjLv3zS3+w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-ys59NKwMM2WqrnINCd5JkQ-1; Thu,
 30 Jul 2026 06:18:45 -0400
X-MC-Unique: ys59NKwMM2WqrnINCd5JkQ-1
X-Mimecast-MFC-AGG-ID: ys59NKwMM2WqrnINCd5JkQ_1785406724
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C320180034A
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:18:44 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA130423
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:18:43 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v4 0/2] checkpolicy: extend bad-data and robustness tests
Date: Thu, 30 Jul 2026 12:18:38 +0200
Message-ID: <20260730101840.3224405-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is a follow-up to the checkmodule bad-data harness already merged:
  checkpolicy: add bad data protection tests
  https://lore.kernel.org/selinux/20260710102906.3059833-1-akkohli@redhat.com/

Patch 1 adds negative .te fixtures for duplicate type/attribute
declarations, type/attribute name conflicts, invalid type names, and
malformed role/user stanzas. It also runs the negative suite as
non-root in CI so the unreadable .te case is exercised.

Patch 2 adds expect_robust coverage for oversized generated .te/.conf
inputs and a large attribute membership set, with tunable sizes.
Together these bring the harness from 16 to 25 tests
(1 positive + 21 negative + 3 robust).

Changes since v3:
- Drop trailing whitespace in run_tests.yml after the semodule-utils
  non-root block (patch 1).

Tested with:
  cd checkpolicy
  make checkmodule checkpolicy LIBSEPOLA=../libsepol/src/libsepol.a \
    CPPFLAGS='-I../libsepol/include'
  make test LIBSEPOLA=../libsepol/src/libsepol.a \
    CPPFLAGS='-I../libsepol/include'
Result: roundtrip tests pass; checkmodule negative tests:
25 passed, 0 failed.

Akhil Kohli (2):
  checkpolicy: extend bad-data tests for type, role, and user errors
  checkpolicy: add robustness tests for large policy inputs

 .github/workflows/run_tests.yml               |  11 +
 checkpolicy/tests/negative/bad_role.te        |  13 ++
 checkpolicy/tests/negative/bad_user.te        |  15 ++
 checkpolicy/tests/negative/dup_attribute.te   |  13 ++
 checkpolicy/tests/negative/dup_type.te        |  11 +
 .../tests/negative/invalid_type_name.te       |   9 +
 .../tests/negative/type_attr_conflict.te      |  10 +
 .../tests/test_checkmodule_negative.sh        | 205 +++++++++++++++++-
 8 files changed, 276 insertions(+), 11 deletions(-)
 create mode 100644 checkpolicy/tests/negative/bad_role.te
 create mode 100644 checkpolicy/tests/negative/bad_user.te
 create mode 100644 checkpolicy/tests/negative/dup_attribute.te
 create mode 100644 checkpolicy/tests/negative/dup_type.te
 create mode 100644 checkpolicy/tests/negative/invalid_type_name.te
 create mode 100644 checkpolicy/tests/negative/type_attr_conflict.te

-- 
2.55.0

