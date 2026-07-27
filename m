Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061738B122
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785165927; cv=none; b=bQHkXTHeC5snIUYV6iEkZRPTYTGvCfgwFOTXrOPFTdjF7vAIF7ZR6UTKbYN0DGWv0XJU4/UVtQyr19Py0VYmRzE4jlvgJL3y8zN1c1iywNIZl45luiV5hBy/ucyAwt2aK1qrbRYc4MBLOT7DuIUETddviSGl1pQUZy3I8lCLEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785165927; c=relaxed/simple;
	bh=Me09VHypfDMh2Nc+gNHe2wJnP8AEHYpXn+Mpo886Mc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YgKTNnCmwNpLUmgwNIskkGrAlHnTiJQ7pjcBfkuZoscSNxvcAgNwioU9lGbXC04nCLS2uBeZzrEOhDnTlu6aLPxLq9IkjokVJieusDqBKUbXH+GVn6C0urbNNkaj6kVUe/0208AlXRuOTHGDoZrBaPvvOkuYHK98XrIYBNUSvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5LTuPa9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5LTuPa9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785165924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VUmba2rYOgReU+rpGBtlAZx8J1sF5Ymx7OI/GXYPqgA=;
	b=h5LTuPa9YNlogcDmDbA/Dz56C96ZeH9eWtGizWt4pqYo1hbEDACNusK0DaqtIowDtlNa2s
	9Gj3OAfq3PAJnq4xA5LoahUshKXx/EpA9LzL7TfaQLQz2R7IRLz4kkeR5MBThDti0SHW1T
	04mBHNYT7BzeikjJJ8vgMVj0TRoU9rA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-8bg6ICeoMtOlyonJA5EYVg-1; Mon,
 27 Jul 2026 11:25:23 -0400
X-MC-Unique: 8bg6ICeoMtOlyonJA5EYVg-1
X-Mimecast-MFC-AGG-ID: 8bg6ICeoMtOlyonJA5EYVg_1785165922
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30BC41955F30
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 15:25:22 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C3CB18001E1
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 15:25:21 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH 0/2] checkpolicy: extend bad-data and robustness tests
Date: Mon, 27 Jul 2026 17:25:15 +0200
Message-ID: <20260727152518.2495266-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

 .github/workflows/run_tests.yml               |  11 ++
 checkpolicy/tests/negative/bad_role.te        |  12 ++
 checkpolicy/tests/negative/bad_user.te        |   3 +
 checkpolicy/tests/negative/dup_attribute.te   |  13 ++
 checkpolicy/tests/negative/dup_type.te        |  11 ++
 .../tests/negative/invalid_type_name.te       |   9 +
 .../tests/negative/type_attr_conflict.te      |  10 +
 .../tests/test_checkmodule_negative.sh        | 187 +++++++++++++++++-
 8 files changed, 248 insertions(+), 8 deletions(-)
 create mode 100644 checkpolicy/tests/negative/bad_role.te
 create mode 100644 checkpolicy/tests/negative/bad_user.te
 create mode 100644 checkpolicy/tests/negative/dup_attribute.te
 create mode 100644 checkpolicy/tests/negative/dup_type.te
 create mode 100644 checkpolicy/tests/negative/invalid_type_name.te
 create mode 100644 checkpolicy/tests/negative/type_attr_conflict.te

-- 
2.55.0

