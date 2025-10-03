Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C2BBA3D
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509655; cv=none; b=iBs9I/HgZd9F8c3ROyGkSGQLi0Sz/mV+eZQUdlz3sSCQRE8X+sDqwLaUPq1s2H85RunMbePXRdFr9ZppZrH6ZlPg0sFsX2CcMjFZurdU/XHha9/5ohFmFj3N5xbqKydyFHWMzoIS77pmi9ht0Ht6Q4wxwjD9L/lbXlohD4jRfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509655; c=relaxed/simple;
	bh=F5QLvKVj8cE4VjUPXk6eNY0lD0xwU3NCoFIZ+tPqc5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gk197kZKaVexo48Zm/vYpY3otbDa2oIb0yPxOt/i2vDHzRZTpezJGUYnJ7EKETXuCZT4UrsNVs4KQONJZz7bwsC9E8CrWz23U2NwA81Y9NK9lDGjBYtGJ/IUWHKypTxTGll/ZT6iLvH79YRCs7dUwvBElPMP+P1mgccOFlW4zFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxv7eUiu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxv7eUiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759509652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLojo/TmGvVKv4NZisVAYCf3pyR4O42NMa1uE2dvh8U=;
	b=cxv7eUiuEBMXD1syp6NpcuBYAhAMbPMZdkY+7u3ATyVd6DWlCMt40e0bkvUGstfDYR6uPJ
	8r6q7xxgKVpaWUzfkvmadDkWuGQpJ8Iw1LcRevsWK1VzxWDg2AH9YrZJfyJ3dQF6u59yTv
	BDtvI0oJ0fdTdrOtS+3Zw/lsO0xSOmk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-m04_9oQhOZ621cvCLxog_Q-1; Fri,
 03 Oct 2025 12:40:51 -0400
X-MC-Unique: m04_9oQhOZ621cvCLxog_Q-1
X-Mimecast-MFC-AGG-ID: m04_9oQhOZ621cvCLxog_Q_1759509650
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D5C11955F29
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 16:40:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7892819560B8
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 16:40:49 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2] semanage: Reset active value when deleting boolean customizations
Date: Fri,  3 Oct 2025 18:38:42 +0200
Message-ID: <20251003164046.485103-1-vmojzis@redhat.com>
In-Reply-To: <20250901171852.2216823-1-vmojzis@redhat.com>
References: <20250901171852.2216823-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, removal of boolean local customizations leaves their current
(active) value untouched.

After the removal is complete, semanage_bool_query will return the
default value. But it needs to be called in a separate transaction.
This makes the fix a bit awkward, but I have not found a way to query
the default value before the first transation is committed.

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
I only added comments explaining the code and improved the commit
message (no code changes in v2).

 python/semanage/seobject.py | 43 +++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 10963e81..6d6188fd 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2886,7 +2886,15 @@ class booleanRecords(semanageRecords):
         self.__delete(name)
         self.commit()
 
+        # New transaction to reset the boolean to its default value.
+        # Calling __reset_value in the same transaction as the removal of
+        # local customizations does nothing
+        self.begin()
+        self.__reset_value(name)
+        self.commit()
+
     def deleteall(self):
+        deleted = []
         (rc, self.blist) = semanage_bool_list_local(self.sh)
         if rc < 0:
             raise ValueError(_("Could not list booleans"))
@@ -2895,10 +2903,45 @@ class booleanRecords(semanageRecords):
 
         for boolean in self.blist:
             name = semanage_bool_get_name(boolean)
+            deleted.append(name)
             self.__delete(name)
 
         self.commit()
 
+        # New transaction to reset all affected booleans to their default values.
+        # Calling __reset_value in the same transaction as the removal of
+        # local customizations does nothing
+        self.begin()
+
+        for boolean in deleted:
+            self.__reset_value(boolean)
+
+        self.commit()
+
+    # Set active value to default
+    # Note: this needs to be called in a new transaction after removing local customizations
+    # in order for semanage_bool_query to fetch the default value
+    # (as opposed to the current one -- set by the local customizations)
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

