Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D112DF159
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747146; cv=none; b=T9QghhLK+QzlXNAABiIhVf2NNYUsDwinHcz4axnaF28bPYyEs4f17Re35RXdQXKnoGIqTAOni5OCzR6IRydK+vA2h4msuHl5brFSemE5hgYkpuKfk4pPFoc142FgOTyfzol6YcxOHTV2v4Jm6RSr4+Z9+h9jROe4aWIyqNyoXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747146; c=relaxed/simple;
	bh=x7lE3EZEvA6O8YyeIPsPs6XPVyDCMrZJ0tWHcoNBU5g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m/XiHD4U9U5nRLVWXUP8/x3Dz4cDQ/MPmpJnsWGsxEZPqqqCXU8W4BVXGCG7D+auSNgn34ufneVGNZxP8J1QfdsduqPwHS4YCIF9LP3fuIzTUwfiZ/xRt9SmXCGmIbVhVMMK2bFV6cdhjsSZAc2p2x0N3+2JEOEYCMnxYvAEjjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPLUX6C7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPLUX6C7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756747142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LGtsxN02qCN52A4inHJiGvMMojnSU1NaYgTIAW+8so4=;
	b=MPLUX6C7dJTfGrmi3Fve21QFSwoCthSI0yJ4eK6Nl3UkcpxPbzgXoGjkHv2Epj8lx5Oovq
	jNRJruxIuuynawsIIjoZakf18uUhbzL3Yjm8t+Z9pS8CyXt1TsAr8U5Pip9IyW2ZTOJ0Bq
	tGo7Gr1ly1IvQuIOOujAf0C5IgVxlwg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-IPCirWxsOyqU5dXL679VRw-1; Mon,
 01 Sep 2025 13:19:01 -0400
X-MC-Unique: IPCirWxsOyqU5dXL679VRw-1
X-Mimecast-MFC-AGG-ID: IPCirWxsOyqU5dXL679VRw_1756747140
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64FFC195C278
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 17:19:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.124])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A24F11955EA4
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 17:18:59 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] semanage: Reset active value when deleting boolean customizations
Date: Mon,  1 Sep 2025 19:18:34 +0200
Message-ID: <20250901171852.2216823-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fixes:
  # getsebool smbd_anon_write
  smbd_anon_write --> off
  # semanage boolean -m1 smbd_anon_write
  # semanage boolean -D
  # getsebool smbd_anon_write
  smbd_anon_write --> on
  # manage boolean -l isemanage boolean --list | grep smbd_anon_write
  smbd_anon_write                (on   ,  off)  Allow smbd to anon write

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/semanage/seobject.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 10963e81..9e790d8c 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2886,7 +2886,12 @@ class booleanRecords(semanageRecords):
         self.__delete(name)
         self.commit()
 
+        self.begin()
+        self.__reset_value(name)
+        self.commit()
+
     def deleteall(self):
+        deleted = []
         (rc, self.blist) = semanage_bool_list_local(self.sh)
         if rc < 0:
             raise ValueError(_("Could not list booleans"))
@@ -2895,10 +2900,40 @@ class booleanRecords(semanageRecords):
 
         for boolean in self.blist:
             name = semanage_bool_get_name(boolean)
+            deleted.append(name)
             self.__delete(name)
 
         self.commit()
 
+        # New transaction to reset all deleted booleans to default values
+        self.begin()
+
+        for boolean in deleted:
+            self.__reset_value(boolean)
+
+        self.commit()
+
+    # Set active value to default
+    def __reset_value(self, name):
+        name = selinux.selinux_boolean_sub(name)
+
+        (rc, k) = semanage_bool_key_create(self.sh, name)
+        if rc < 0:
+            raise ValueError(_("Could not create a key for %s") % name)
+
+        (rc, b) = semanage_bool_query(self.sh, k)
+        if rc < 0:
+            raise ValueError(_("Could not query boolean %s") % name)
+
+        semanage_bool_set_value(b, semanage_bool_get_value(b))
+
+        rc = semanage_bool_set_active(self.sh, k, b)
+        if rc < 0:
+            raise ValueError(_("Could not set active value of boolean %s") % name)
+
+        semanage_bool_key_free(k)
+        semanage_bool_free(b)
+
     def get_all(self, locallist=0):
         ddict = {}
         if locallist:
-- 
2.49.0

