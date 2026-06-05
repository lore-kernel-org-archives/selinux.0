Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BB423156
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656262; cv=none; b=Sv5878EsSpuYDzuxdycU6MDl7YXRePiBl9SMdGzePYC3ABt76ytPTPqAAwEMtqrY5VOe9WDEJvyo2+JzX8lBoPJJVHmXSNtwvshCDqRmcIPPuZ+DdS84DbKsmWP3ET5tHrgLCoBJZq11uWc1V0Y8YAYlo5vzxRXyLocGd7YZd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656262; c=relaxed/simple;
	bh=bC3S+cbw/abk/4/Fadnmho2dbcru01iAa80w99Z215U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=sRqONKDUxgYNhZszurX+keZytrIsbK7S7CcPnlnkZDmkPJeqjBQxkYPX2zVjcr4xAbJbQ1d5UNnLaoXBBsE6Qys1dXs4cEkfcuoU+H52YuivwtbRJ+t1uI3AkH6z1W31Ub2mVoX/XFYojrYcD+M1+C3Sm9R1qro6xdojWhE2xF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvCNPyYT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvCNPyYT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780656260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLgRz/XBj/bOx/+NWj9oIyonhyIgnIWHpDFzSJMGkK0=;
	b=IvCNPyYTuc43qWRDekjmM5yf0Nl1fGxv61PmXqrdmXrfefncNbvLyhPP8BU5HuIRGmftH+
	m9uFjpHxaRmYO72DFBd2gKEVttPkdyGWvYRKK13ZRk5eWP1J/bt588QZX+UYHYHLiRbVi1
	Crt0U22pG7tEZE0fNzmgEflof48IIow=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-NrhmfqniMEuXeQBiRx-ssQ-1; Fri,
 05 Jun 2026 06:44:19 -0400
X-MC-Unique: NrhmfqniMEuXeQBiRx-ssQ-1
X-Mimecast-MFC-AGG-ID: NrhmfqniMEuXeQBiRx-ssQ_1780656258
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D6431800599
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:44:18 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EDE81800367;
	Fri,  5 Jun 2026 10:44:17 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 2/2] libselinux,python: Use system Python3 build module
Date: Fri,  5 Jun 2026 12:43:46 +0200
Message-ID: <20260605104408.2378497-2-lautrbach@redhat.com>
In-Reply-To: <20260605104408.2378497-1-lautrbach@redhat.com>
References: <20260605104408.2378497-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

