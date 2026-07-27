Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDE3EC684
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191570; cv=none; b=jZM7dObHLmPrDoDbYyEKpizyFai6lfWwBDurQvBq+QRd38UdUyMV9HfOSWIE232o1giBfhVNt/PGlTtprGpg1kU7g0NTWOWFDWViy1F2kWVCai9ODdEKsR585xtR+VTxDMpn/EWAZx1ByBWcqgSQrJ1+WEf7bS2NgvQCVTL9CTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191570; c=relaxed/simple;
	bh=mBRBKWLI+qVuODZC9sKTg1Ul+T7rGzC47DdfCguvS54=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mTCz+cUefdrPDhbfpRDA/Kk5oQXGcNyhcFM+ZMN9bSI824U918m1js2Hi9zKe/bXTk2auQpxDSVp8KF83WQrvfG2+kYbaYDKGzj7Fb74pIfUHzWgMru+9cL8zfcQ+WbFuO09nxFg1Bg/GGyfjfMAvHuuPpkxnBXpvYLauG2fvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V45s3y4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V45s3y4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785191567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dSOstToXW5mYsue1dWRF3tmWIVp+ALKcpUbM4dtXOwI=;
	b=V45s3y4fpL7c7DDoojK1veHgO+d+UBOdxrGM4SjrhGaqCJP/6A/b9B0VDSHqfOh1T9sVdu
	x7aE1hy8IyTD/JVYSql6kXKa70074hY551oQjTZ4nwT/U/Rm8ARjMFR3noB9hJ0XJoL+jA
	DSOAcDaRvxrzB4vZcI3LHcMvsQ6O5KE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-ooeGMMp1Nhu-88-5hpUVaA-1; Mon,
 27 Jul 2026 18:32:46 -0400
X-MC-Unique: ooeGMMp1Nhu-88-5hpUVaA-1
X-Mimecast-MFC-AGG-ID: ooeGMMp1Nhu-88-5hpUVaA_1785191565
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44CB71956056
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 22:32:45 +0000 (UTC)
Received: from akkohli-thinkpadt14sgen2i.rmtde.csb (unknown [10.44.33.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6829E30010D1
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 22:32:44 +0000 (UTC)
From: Akhil Kohli <akkohli@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 0/2] checkpolicy: extend bad-data and robustness tests
Date: Tue, 28 Jul 2026 00:32:40 +0200
Message-ID: <20260727223242.2507658-1-akkohli@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Changes since v1:
- Fix non-root CI BASEDIR resolution when cd to the script dir fails
  under /home/runner/work (Actions failure).
- Treat exit 137 (SIGKILL, including OOM-kill) as a crash in
  expect_robust.
- Drop internal section/PDF markers from comments and test labels.
- Keep both semodule-utils and checkpolicy non-root CI blocks in
  run_tests.yml when applying onto current main.

Tested with:
  cd checkpolicy
  make checkmodule checkpolicy LIBSEPOLA=../libsepol/src/libsepol.a \
    CPPFLAGS='-I../libsepol/include'
  make test LIBSEPOLA=../libsepol/src/libsepol.a \
    CPPFLAGS='-I../libsepol/include'

Result: roundtrip tests pass; checkmodule negative tests:
25 passed, 0 failed.

Also verified via GitHub Actions on the fork branch (full matrix green),
including the checkpolicy bad-data (non-root) step.

Akhil Kohli (2):
  checkpolicy: extend bad-data tests for type, role, and user errors
  checkpolicy: add robustness tests for large policy inputs

 .github/workflows/run_tests.yml               |  11 +
 checkpolicy/tests/negative/bad_role.te        |  12 +
 checkpolicy/tests/negative/bad_user.te        |   3 +
 checkpolicy/tests/negative/dup_attribute.te   |  13 ++
 checkpolicy/tests/negative/dup_type.te        |  11 +
 .../tests/negative/invalid_type_name.te       |   9 +
 .../tests/negative/type_attr_conflict.te      |  10 +
 .../tests/test_checkmodule_negative.sh        | 205 +++++++++++++++++-
 8 files changed, 263 insertions(+), 11 deletions(-)
 create mode 100644 checkpolicy/tests/negative/bad_role.te
 create mode 100644 checkpolicy/tests/negative/bad_user.te
 create mode 100644 checkpolicy/tests/negative/dup_attribute.te
 create mode 100644 checkpolicy/tests/negative/dup_type.te
 create mode 100644 checkpolicy/tests/negative/invalid_type_name.te
 create mode 100644 checkpolicy/tests/negative/type_attr_conflict.te

-- 
2.55.0

