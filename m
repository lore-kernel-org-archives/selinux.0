Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99722CBE6
	for <selinux@vger.kernel.org>; Thu, 11 Dec 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765411288; cv=none; b=iXh0Vy/jtRj0Q+Sto/uVRBZVAaFO8PhZ4oqfBaVVIQb0qLjsS43TmpdXONScF+ePs/lxJfr8z+wgMynF/Kms8J2BzsaVUY/qvjjZ4BtR6hbWQOf4TDTXsghT6PSBbYIS+KEn/8VMBRdwCm4ffyuBV/7CriGUAa0i+2pekHDYMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765411288; c=relaxed/simple;
	bh=GNDKGqZrsh3cUgcoqHXYPQ8B4kklYDWGv22V8osEAqE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b6bAp5jqjipoaZbXJFsMZzUrIBBX2Cv3af2AW32DJJxlJ5S2gB+SxG9mYtuKkx5rB0uuz5n6V4KugpsrWSoIVz8pzVau8Bd+CkQ1KkBRv8VGRikP0TKs4wE0pFEI+Jbt/pdKJnbD7jIJeSWZqdCCVG3F5UbBgYsUSeuBqTfBilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMv9y1GW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMv9y1GW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765411282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d6Xmf5Jivc/6h5UGBXnMNZdINprcUOpigr+GkFue7Xc=;
	b=XMv9y1GWMQ5SiYb2rZ4eX/tSX7smdphnHfVI24ed60ScCF1PSCW330EuSymQHOgeTnHlb5
	iQwaYU0phbQVc3hK4Kf1fwwBCKUv9LCkybPQhahiXxo4x/dkKcgQQ3MUGl5HUdnLbr88xc
	fgURClMwFVVufGT1sk/o8eyOZ9PaQtU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-Okpg0KbxMwG0Qma3-Iyc8Q-1; Wed,
 10 Dec 2025 19:01:21 -0500
X-MC-Unique: Okpg0KbxMwG0Qma3-Iyc8Q-1
X-Mimecast-MFC-AGG-ID: Okpg0KbxMwG0Qma3-Iyc8Q_1765411280
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F3A81800378
	for <selinux@vger.kernel.org>; Thu, 11 Dec 2025 00:01:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7319619560AD
	for <selinux@vger.kernel.org>; Thu, 11 Dec 2025 00:01:19 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] python/sepolicy: Add support for DNF5
Date: Thu, 11 Dec 2025 01:00:52 +0100
Message-ID: <20251211000115.43983-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This allows policycoreutils-devel to drop the dependency on python3-dnf
in favor of python3-libdnf5.

Requires: (python3-libdnf5 if dnf5 else python3-dnf)

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/sepolicy/sepolicy/generate.py | 57 ++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index adf65f27..780a56b2 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1262,6 +1262,63 @@ allow %s_t %s_t:%s_socket name_%s;
         return fcfile
 
     def __extract_rpms(self):
+        # Try dnf5 first, fall back to dnf4
+        try:
+            import libdnf5
+            self.__extract_rpms_dnf5()
+        except ImportError:
+            try:
+                import dnf
+                self.__extract_rpms_dnf4()
+            except ImportError:
+                pass
+
+    def __extract_rpms_dnf5(self):
+        import libdnf5
+
+        base = libdnf5.base.Base()
+        base.load_config()
+        base.setup()
+
+        repo_sack = base.get_repo_sack()
+        repo_sack.create_repos_from_system_configuration()
+
+        repo_sack.load_repos()
+
+        query = libdnf5.rpm.PackageQuery(base)
+        query.filter_file([self.program])
+        query.filter_available()
+
+        for pkg in query:
+            self.rpms.append(pkg.get_name())
+            files = pkg.get_files()
+            for fname in files:
+                for b in self.DEFAULT_DIRS:
+                    if b == "/etc":
+                        continue
+                    if fname.startswith(b):
+                        if os.path.isfile(fname):
+                            self.add_file(fname)
+                        else:
+                            self.add_dir(fname)
+
+            # Query for source package
+            src_query = libdnf5.rpm.PackageQuery(base)
+            src_query.filter_provides([pkg.get_source_name()])
+            src_query.filter_available()
+            for bpkg in src_query:
+                files = bpkg.get_files()
+                for fname in files:
+                    for b in self.DEFAULT_DIRS:
+                        if b == "/etc":
+                            continue
+                        if fname.startswith(b):
+                            if os.path.isfile(fname):
+                                self.add_file(fname)
+                            else:
+                                self.add_dir(fname)
+
+    def __extract_rpms_dnf4(self):
         import dnf
 
         with dnf.Base() as base:
-- 
2.52.0

