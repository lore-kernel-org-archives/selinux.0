Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A12472B6
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658783; cv=none; b=UW7eWq4tfzDk6GwJL5awRtbmAsmno9AHtzbN7NDwUoSfRPAQOMvVvyv6qE9LxSQh1LeorIzQN/DBXbHvdK5Hpcr0SrnFh8uRXhKGSW3WaZPMDpOdH5WX98Y0Crmofv5jz6Mu8qYiqCuA3DCUagmcOX/k+bLCU0BOV5bZDj5FrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658783; c=relaxed/simple;
	bh=f6ln64qHyA9tcf3HBSxoJcLdlS92/PwWLD8GXmvSPUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=UHpR7HFUBGIAETbovxR+HXbkL377b4ipkWY/+QMuFWBaI/UwlegE2Pxf0JAkJnFjglC7B7V3lWxFbg+sVHp9E9QlwQ0HkEpSpD1u+cRseDbKknXECca93AvSnEQDkanLLVgP/vUimubftOlQADG2LBrlUjfPr67pqBhDFXBjLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6pXh79u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6pXh79u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780658781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OfU+crlpRyt/q2dUYj3BNmsXUIFN8AxrUPXrpnS4xq8=;
	b=e6pXh79un8LNt/C+oiHYIPYfXSuKrsAUsq8BhfCVgqUQTAuTUaJRHpQnBhcCRL4IxdADuL
	LiF7hoJ/gEHSqGfqzX+By333cvBAy9vTgEP8eCssGhtNScEwWhG7d1RW6aqm3pLZf8HlCu
	k6s4gjN95ANmgddGgyvUvBUwRxxxMZo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-Nur7-5RpMpGE5g2W_f5VUA-1; Fri,
 05 Jun 2026 07:26:19 -0400
X-MC-Unique: Nur7-5RpMpGE5g2W_f5VUA-1
X-Mimecast-MFC-AGG-ID: Nur7-5RpMpGE5g2W_f5VUA_1780658779
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23C0D1956094
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:26:19 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0F993000210;
	Fri,  5 Jun 2026 11:26:17 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 1/2] ci: install necessary build python module
Date: Fri,  5 Jun 2026 13:25:26 +0200
Message-ID: <20260605112614.2397757-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
v2 - add python3-build dependency also to tf testsuite

 .github/workflows/run_tests.yml | 2 +-
 tmt/plans.fmf                   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

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
diff --git a/tmt/plans.fmf b/tmt/plans.fmf
index 89f041f2630a..8f9f96f46290 100644
--- a/tmt/plans.fmf
+++ b/tmt/plans.fmf
@@ -30,6 +30,7 @@
             - python3-pip
             - python3-setuptools
             - python3-wheel
+            - python3-build
             - swig
             - xmlto
           test: |
-- 
2.54.0

