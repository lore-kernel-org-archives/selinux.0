Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1EA7E77B
	for <selinux@vger.kernel.org>; Wed,  7 Feb 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318013; cv=none; b=mdce8mOLToTc7k8D8sFgAuPI5KgLL4PMrVt+abPwvIAICQDfQ+P2unl06jO7La7YK0uvSkPi4J0QSqmZ81VJobn/U51nb6U47sQU4d7LzgV9gscmJ5mfisnE5FPZoMO5YL9wkpJBnT6Pic+oE/kUb1HLPx6XvCeypCZyyBj4B2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318013; c=relaxed/simple;
	bh=DY/mrStOHGW+fHjOHvriCucdKsutI+Jg+5TAmC+mymY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NmZvYgk7S5VdeYWuz3qafamoc1x3IwDEw0GQkcz2RcWy4AllQwbOA7dyi7Go4dGh7Nc9vdU+fZ2lOZyt0yVox2xSjIBefRjkhgvvikVm3KC/ZYxrPpVZ9f4Bgj86QZ3QBcV+FlCCCyqWLo0A2F8lvvYySKmIEBx0xhc6QSJ+iuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajlRiE+k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajlRiE+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707318010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EVhLcaa8TG78Kz48PNlh/yYFXjfEmKuv+E0PY5F0pPo=;
	b=ajlRiE+kNxZRk2D5IlEhYPRajJcbUChHwGfJ5uXJkkcEeBBaA15kIfD1/J4RSc52Z2KRaE
	hwi7Zhmm2JwBIsrXO3GiQfmyn51uOek5YDwYKmI5l1GS8E9Azuej3+EHo9e34mhYh+bBOA
	9m91j28+SgBF4lUycz7RQNsTk1iKpVE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-wOoquvl5MMSoAkE8xxv1wg-1; Wed, 07 Feb 2024 10:00:08 -0500
X-MC-Unique: wOoquvl5MMSoAkE8xxv1wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F07C811E81
	for <selinux@vger.kernel.org>; Wed,  7 Feb 2024 15:00:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 26DDD1103A
	for <selinux@vger.kernel.org>; Wed,  7 Feb 2024 15:00:08 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] python/semanage: Do not sort local fcontext definitions
Date: Wed,  7 Feb 2024 15:46:23 +0100
Message-ID: <20240207150003.174701-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Entries in file_contexts.local are processed from the most recent one to
the oldest, with first match being used. Therefore it is important to
preserve their order when listing (semanage fcontext -lC) and exporting
(semanage export).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
Not sure if this is the best solution since the local file context
customizations are still sorted in the output of "semanage fcontext -l".
Adding a new section for "Local file context changes" would make it
clear that such changes are treated differently, but it would make it
harder to find context definitions affecting specific path.
The most important part of this patch is the change to "customized"
since that stops "semanage export | semanage import" from reordering the
local customizations.

Note: The order of dictionary.keys() is only guaranteed in python 3.6+.

Note2: The change to fcontextPage can only be seen when the user
disables ordering by "File specification" column, which is enabled by
defalut.

 gui/fcontextPage.py         | 6 +++++-
 python/semanage/seobject.py | 9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
index 767664f2..c88df580 100644
--- a/gui/fcontextPage.py
+++ b/gui/fcontextPage.py
@@ -133,7 +133,11 @@ class fcontextPage(semanagePage):
         self.fcontext = seobject.fcontextRecords()
         self.store.clear()
         fcon_dict = self.fcontext.get_all(self.local)
-        for k in sorted(fcon_dict.keys()):
+        if self.local:
+            fkeys = fcon_dict.keys()
+        else:
+            fkeys = sorted(fcon_dict.keys())
+        for k in fkeys:
             if not self.match(fcon_dict, k, filter):
                 continue
             iter = self.store.append()
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index dfb15b1d..25ec4315 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2735,7 +2735,7 @@ class fcontextRecords(semanageRecords):
     def customized(self):
         l = []
         fcon_dict = self.get_all(True)
-        for k in sorted(fcon_dict.keys()):
+        for k in fcon_dict.keys():
             if fcon_dict[k]:
                 if fcon_dict[k][3]:
                     l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
@@ -2752,7 +2752,12 @@ class fcontextRecords(semanageRecords):
         if len(fcon_dict) != 0:
             if heading:
                 print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _("type"), _("Context")))
-            for k in sorted(fcon_dict.keys()):
+            # do not sort local customizations since they are evaluated based on the order they where added in
+            if locallist:
+                fkeys = fcon_dict.keys()
+            else:
+                fkeys = sorted(fcon_dict.keys())
+            for k in fkeys:
                 if fcon_dict[k]:
                     if is_mls_enabled:
                         print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3], False)))
-- 
2.43.0

