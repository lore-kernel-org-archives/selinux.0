Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1242C433FE
	for <selinux@archiver.kernel.org>; Tue, 18 Oct 2022 20:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJRUhe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJRUhe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Oct 2022 16:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137A61715
        for <selinux@vger.kernel.org>; Tue, 18 Oct 2022 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666125452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f6fxyZdfS047uTz48PhzQltTrY1dFmbKmcqy9rU9HoQ=;
        b=Vq34CQ5uyqMZ6wbngTFtuOZkYYr2t5dYRwDVc0bBJAQlIYEaSn3cmd04teY5TItctABK2y
        /bP96xANgNCE3OL+dLQLXE4dujJ/x3YyJuJLOtqPw3drSt12pCsw7kKrK/zsPhXSjeVawY
        oQeB7yj2M8K9aotcUmh5EgFdXQeYNYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-zzSOada0Me6Wqk5fqDhT5A-1; Tue, 18 Oct 2022 16:37:30 -0400
X-MC-Unique: zzSOada0Me6Wqk5fqDhT5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A8D4833AF9
        for <selinux@vger.kernel.org>; Tue, 18 Oct 2022 20:37:15 +0000 (UTC)
Received: from ovpn-194-44.brq.redhat.com (ovpn-194-44.brq.redhat.com [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 573A82028DC1
        for <selinux@vger.kernel.org>; Tue, 18 Oct 2022 20:37:13 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python: Harden tools against "rogue" modules
Date:   Tue, 18 Oct 2022 22:36:59 +0200
Message-Id: <20221018203659.2329808-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Python scripts present in "/usr/sbin" override regular modules.
Make sure /usr/sbin is not present in PYTHONPATH.

Fixes:
  #cat > /usr/sbin/audit.py <<EOF
  import sys
  print("BAD GUY!", file=sys.stderr)
  sys.exit(1)
  EOF
  #semanage boolean -l
  BAD GUY!

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 python/audit2allow/audit2allow    | 2 +-
 python/audit2allow/sepolgen-ifgen | 2 +-
 python/chcat/chcat                | 2 +-
 python/semanage/semanage          | 2 +-
 python/sepolicy/sepolicy.py       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
index 09b06f66..eafeea88 100644
--- a/python/audit2allow/audit2allow
+++ b/python/audit2allow/audit2allow
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
 # Authors: Dan Walsh <dwalsh@redhat.com>
 #
diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
index b7a04c71..f2cc0c32 100644
--- a/python/audit2allow/sepolgen-ifgen
+++ b/python/audit2allow/sepolgen-ifgen
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 #
 # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
 #
diff --git a/python/chcat/chcat b/python/chcat/chcat
index 952cb818..68718ec5 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 # Copyright (C) 2005 Red Hat
 # see file 'COPYING' for use and warranty information
 #
diff --git a/python/semanage/semanage b/python/semanage/semanage
index 10ab3fa6..b21d1484 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 # Copyright (C) 2012-2013 Red Hat
 # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
 # AUTHOR: David Quigley <selinux@davequigley.com>
diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
index c7a70e09..733d4048 100755
--- a/python/sepolicy/sepolicy.py
+++ b/python/sepolicy/sepolicy.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 # Copyright (C) 2012 Red Hat
 # AUTHOR: Dan Walsh <dwalsh@redhat.com>
 # see file 'COPYING' for use and warranty information
-- 
2.37.3

