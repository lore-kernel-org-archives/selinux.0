Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC513FAE0D
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656259; cv=none; b=UnHj9Y/dA08bRw6QqWhlwO6JRj1sDCQ5WueAIKkSf08VqOzgCHRUCxFbkK8pV5GJJgZeoC/gxjYt2chTwMGNVLD+gcwd4k6/fqfkc4jF3vXt/lb9jkcNcSdyPA7743nkph70kOCJHy6BgEP7XpmW46nt0E3bixpMYcG9mKfnWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656259; c=relaxed/simple;
	bh=1vhWqb2pXDeVJFRUPQ263FV7fFXtzEdXozNbsZShnac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=N2j4dMzXGdwKvYMduQUWJP1GsTvZKMu3LJBpVsvcUIIace0WR+htzz8GPZmojI9MAeNVIVmEcZ0cE4+1a8IBeqx2MYV6fIeTX3C/DGZYZj96HXes3BQu+58/bluGhZsTtpVHyqq1vaATNcEC/xz+2n4CdwoOkkQ8MiAnvVMS0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqGpT42q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqGpT42q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780656256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=duz0gQHhwW9I0H5dwyHL+R6eS/faAPeo+zrJFWxFs6w=;
	b=iqGpT42q3LpkD6nIOfTGVkBCiB95uI4OKm45/dI2tW7HhbXYvN4Bm+03gXhdidaYluPpYK
	CEBHbNHn4Fg/rZW15+yHtjscKmUu9ZONYehe09tO/vG4AnXMYDTbWz36/dO/8YEtBEkiJp
	nrZ59nHUmbqeEDVJ5wJ96GHequ0ONhM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-o9HXdrpONJy5jv8gysMzpA-1; Fri,
 05 Jun 2026 06:44:14 -0400
X-MC-Unique: o9HXdrpONJy5jv8gysMzpA-1
X-Mimecast-MFC-AGG-ID: o9HXdrpONJy5jv8gysMzpA_1780656254
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBF23195608F
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:44:13 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C16821800348;
	Fri,  5 Jun 2026 10:44:12 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 1/2] ci: install necessary build python module
Date: Fri,  5 Jun 2026 12:43:45 +0200
Message-ID: <20260605104408.2378497-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 .github/workflows/run_tests.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index ed60921acfb7..82c44fccb521 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -71,7 +71,7 @@ jobs:
             swig \
             xmlto
 
-        pip install flake8 setuptools
+        pip install flake8 setuptools build wheel
 
     - name: Install Clang
       if: ${{ matrix.compiler == 'clang' }}
-- 
2.54.0

