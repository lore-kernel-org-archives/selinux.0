Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F44CA26B
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658785; cv=none; b=dtfI2AZafOujwIGTrFwzhXaOVlq54sRrm2f4cJ416ekh6MunEPvcETRnCyHcbPoFRGD5qhQXyhpeoxZYc1LVIX+xjt/cISTiti8TowDo8CfUVaulnpfdOpFkM2i/TyxJ0XzhXYX4aAiEFaa5a/mPSbN591nPrpGQRNv+0TzMNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658785; c=relaxed/simple;
	bh=bC3S+cbw/abk/4/Fadnmho2dbcru01iAa80w99Z215U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=PGx9FppXztTgUjyzd45fjc4cQ4bcsNc0i+yOps7KLA0K7rgvCVPAHy2oNs+eVlozQjgBLtOLQotgwksGp2WpSDCA+UiPZ852yuGw1a/9qPFRLyr0VY1XQERMOrD/Scvdk5MjZo8IbFbx5DY0DVvTiRtyL3Up6xMATxPgycyEZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNvJN7J0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNvJN7J0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780658783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLgRz/XBj/bOx/+NWj9oIyonhyIgnIWHpDFzSJMGkK0=;
	b=eNvJN7J0eLMwduRYOLIWYJGbOlIuys366N4zda19zKBYs2EHK21SIuvtCoj7RUSBkARHtT
	KXQ3sBvlXTk0TWdAt3J54EpqVz5ZSi+hjrf0XKqAIqNHEfAjz1Ld12QnSqXFNoClukLr4/
	gaIqjM26Qhi7wVl+RfAvTJMh3zWJ0HA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-4LyM2Ak8ODqQPbknwC_Y8A-1; Fri,
 05 Jun 2026 07:26:21 -0400
X-MC-Unique: 4LyM2Ak8ODqQPbknwC_Y8A-1
X-Mimecast-MFC-AGG-ID: 4LyM2Ak8ODqQPbknwC_Y8A_1780658781
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00BA919560AA
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:26:21 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 126A33000210;
	Fri,  5 Jun 2026 11:26:19 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 2/2] libselinux,python: Use system Python3 build module
Date: Fri,  5 Jun 2026 13:25:27 +0200
Message-ID: <20260605112614.2397757-2-lautrbach@redhat.com>
In-Reply-To: <20260605112614.2397757-1-lautrbach@redhat.com>
References: <20260605112614.2397757-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Commit dfedefffbbdde609a7aacb1ef570c7ca1bb70915 ("libselinux: update
pywrap targets for modern python builds") added `pip install build`
command. This fails on build systems without network.

Revert the install part and add python3-build to packages necessary to
build Python bindings in README.md

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 README.md                | 2 ++
 libselinux/src/Makefile  | 1 -
 python/sepolicy/Makefile | 1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index ece18c394ee0..5e65a0495e39 100644
--- a/README.md
+++ b/README.md
@@ -64,6 +64,7 @@ dnf install \
 
 # For Python and Ruby bindings
 dnf install \
+    python3-build \
     python3-devel \
     python3-pip \
     python3-setuptools \
@@ -97,6 +98,7 @@ apt-get install --no-install-recommends --no-install-suggests \
 
 # For Python and Ruby bindings
 apt-get install --no-install-recommends --no-install-suggests \
+    python3-build \
     python3-dev \
     python3-pip \
     python3-setuptools \
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c62ad1edda58..52b2c621c042 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -151,7 +151,6 @@ all: $(LIBSO)
 endif
 
 pywrap: all selinuxswig_python_exception.i
-	$(PYTHON) -m pip install build wheel
 	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m build --no-isolation --wheel .
 
 rubywrap: all $(SWIGRUBYSO)
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 4a4a351219be..518129805fca 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -14,7 +14,6 @@ BASHCOMPLETIONS=sepolicy-bash-completion.sh
 all: python-build
 
 python-build:
-	$(PYTHON) -m pip install build wheel setuptools
 	$(PYTHON) -m build --no-isolation --wheel .
 
 clean:
-- 
2.54.0

