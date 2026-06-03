Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71677374E60
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479507; cv=none; b=DtrdxfaWVzpYa0DeB0FnuLiUfiLXK1BwEVprrZGoSPRn5xy3aKKvhyklbghbExDZDNj/W+nn+vKOJg7xRYo1kk0O0APVy7W+rA890WYJLkWbjoISE2UcT3lJlhgDpAbVBg7xU9Q2ikHE0NG5/kuo8ZCnTKH2tajtAU4Gi1zzTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479507; c=relaxed/simple;
	bh=AKH7Iv3RkUNcsZVQxEoGDuFjHLKQip6wFORjcq1UeWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ok5U4Wz+gB/6v58APRrjLdllB2POchj46UE8dPjFXCnlOWqBR6awV4R0vwxX6/uliY5lARnHMz7/bJ52gR5OiHGLJ8W8st3MryaPRcwO5sK6gp07fxI/FPZYBwJmqj/+TH06w1SAEYs6SLTxoN+1qNjZuzXMah6WoRGGxp9E3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lb7O1tO5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb7O1tO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780479505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXqni3DIiiBOpChzwGrqnqufjrq2ErbpWEXMdZXOeU8=;
	b=Lb7O1tO5gP+R9G00VWbAgYctfM/XYn0R4fbY+y9SM4LYOnuZBgnHVrA3Ag9Dh+TewJ79vp
	Eotql2R4L+8tlHEUaJnO0wmGsLZ701n0Ms+ZuLsAipQwllp2MuIjEN5zSdrAhLOXkQYDRb
	LMUiBvXmzKIu/fAtySoSjkoHXB3m4A4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-SFIsRLraPNeVyI3CBRiq9Q-1; Wed,
 03 Jun 2026 05:38:23 -0400
X-MC-Unique: SFIsRLraPNeVyI3CBRiq9Q-1
X-Mimecast-MFC-AGG-ID: SFIsRLraPNeVyI3CBRiq9Q_1780479503
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 279C418003FC
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 09:38:23 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.201])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23E1E30001A1;
	Wed,  3 Jun 2026 09:38:21 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/2] Add check_format Github CI job
Date: Wed,  3 Jun 2026 11:33:29 +0200
Message-ID: <20260603093801.1070705-2-lautrbach@redhat.com>
In-Reply-To: <20260603093801.1070705-1-lautrbach@redhat.com>
References: <20260603093801.1070705-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Run `make check-format` on PRs and pushes

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

There's a test run available at https://github.com/SELinuxProject/selinux/pull/520

https://github.com/SELinuxProject/selinux/actions/runs/26875462663/job/79261408494?pr=520

 .github/workflows/check_format.yml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 .github/workflows/check_format.yml

diff --git a/.github/workflows/check_format.yml b/.github/workflows/check_format.yml
new file mode 100644
index 000000000000..bb44e60a5507
--- /dev/null
+++ b/.github/workflows/check_format.yml
@@ -0,0 +1,21 @@
+name: Check format
+
+on:
+  push:
+    branches:
+      - main
+  pull_request:
+    branches:
+      - main
+
+jobs:
+  check-format:
+    runs-on: ubuntu-latest
+    container:
+      image: fedora:latest
+    steps:
+      - uses: actions/checkout@v4
+      - name: Install tools
+        run: dnf install -y make clang-tools-extra
+      - name: Check format
+        run: make check-format
-- 
2.54.0

