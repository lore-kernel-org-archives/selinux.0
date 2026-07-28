Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49B38AC72
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257160; cv=none; b=VBMJwNGmKMs/v5aw7vW1zP8gNnM4jXPdk+8WIg5hWiPvQY0IuqXU66xQ/LPWk6mvduaqe2vFWRuBJ8btXNnuWXqVcfU9HnOiHj0hHFMWdeKxWRgNLbuvK++owHhfQBkykKXf4OGq7iFr8zDJxMx0SMlOnQm/JP67ZGSEK2RPcss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257160; c=relaxed/simple;
	bh=vnb0Cjfp8j7IkYWtNvtLBuMi7SdZPfatILPDA7n7Wtg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NjpuzwSFQ6JGdEhXDM7Ed+eFl6pBUtJh+Kny0mk4bB52X4v7pc90W7FP7IrU/eJdmPjzQSOYGFtRVwUExvX/v0/HUjYP3ALHq2hwQTF439D9m7YzpRhbXPMLmT2SKZSYf264I4O6tWS2/eQabBZSWYD0nZqDGlU18WI7m9Pu4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DX5iXUHJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DX5iXUHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785257157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gGGGj3/D/lIjE4TWuFXw5AL7t4YJsan7+tjkfL3txhk=;
	b=DX5iXUHJSysWFDeUylN3jdMuEx8sWBJjGl0U6/2s4YmiH3w+CeysI9/xE1Ai8vSmvDwdPC
	UMyaP9jia4JsFU0XzkVJKv1nqwu4/JDpv2rUiwxGLPq2c3dGd9TB6bQ7zOHhMbyV8p4Wm9
	6lMUuB0STrQENc/BOlAdMJQ3lbNb9U0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-aFxES7ylPxuY2r_pOMMN3g-1; Tue,
 28 Jul 2026 12:45:56 -0400
X-MC-Unique: aFxES7ylPxuY2r_pOMMN3g-1
X-Mimecast-MFC-AGG-ID: aFxES7ylPxuY2r_pOMMN3g_1785257155
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42D3D195609F
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 16:45:55 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EA34180049F
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 16:45:54 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v3 0/2] checkpolicy: extend bad-data and robustness tests
Date: Tue, 28 Jul 2026 18:45:50 +0200
Message-ID: <20260728164552.2646227-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is a follow-up to the checkmodule bad-data harness already merged:
  checkpolicy: add bad data protection tests
  https://lore.kernel.org/selinux/20260710102906.3059833-1-akkohli@redhat.com/
Patch 1 adds negative .te fixtures for duplicate type/attribute
declarations, type/attribute name conflicts, invalid type names, and
malformed role/user stanzas. It also runs the negative suite as
non-root in CI so the unreadable .te case is exercised (root can still
read mode 000 files).
Patch 2 adds expect_robust coverage for oversized generated .te/.conf
inputs and a large attribute membership set, with tunable sizes. It
also fixes expect_* helpers to return 0 after counting a failure so
set -e does not abort the suite early; the script exit status is still
non-zero when FAIL != 0.
Together these bring the harness from 16 to 25 tests
(1 positive + 21 negative + 3 robust).
Changes since v2:
- bad_user.te: add a require block and scaffolding so checkmodule fails
  on garbage_token rather than on the bare "user" keyword (missing
  avrule_decls / require).
- Move non-root CI BASEDIR soft-resolve into patch 1 so each patch
  passes CI on its own.
- Brief comments on bad_user.te / bad_role.te clarifying the intended
  failure.
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

