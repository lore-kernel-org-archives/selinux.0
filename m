Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5E7lLzt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A8D4D
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 06:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701873184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SrwfegMPsMpj7RvxetMmVirHYrP75a2T08rhT1JKE0M=;
	b=G5E7lLztYziPnsaaNizE2X5lkT6Ca5KFIF4h1UziWmH+OSRNjeF8sQJcQbhtjMNKh5wWRb
	TwMhPwY3HC3refqzcyuqx3D2vqsOmuzr327OR5pQ39ebH9xOx6H6kdo9GHOK4SVLtXFrBH
	Wpi4AhAUjif53h6cWrAnplgSz0NVtEE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-KkuVFh4rOvegJo7fJXfHbg-1; Wed,
 06 Dec 2023 09:32:09 -0500
X-MC-Unique: KkuVFh4rOvegJo7fJXfHbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B75229AA2C1
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 14:31:59 +0000 (UTC)
Received: from fedora.tail6b4d1.ts.net (unknown [10.45.226.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A7941C157C0
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 14:31:58 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] python: Harden more tools agains "rogue" modules
Date: Wed,  6 Dec 2023 15:31:51 +0100
Message-ID: <20231206143151.1047189-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Python scripts present in the same directory as the tool
override regular modules.

Fixes:
      #cat > /usr/bin/signal.py <<EOF
      import sys
      print("BAD GUY!", file=sys.stderr)
      sys.exit(1)
      EOF
      #sandbox date
      BAD GUY!

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 dbus/selinux_server.py       | 2 +-
 gui/polgengui.py             | 2 +-
 gui/system-config-selinux.py | 6 +++---
 sandbox/sandbox              | 2 +-
 sandbox/start                | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
index a969f226..469c526f 100644
--- a/dbus/selinux_server.py
+++ b/dbus/selinux_server.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/python3 -EsI
 
 import dbus
 import dbus.service
diff --git a/gui/polgengui.py b/gui/polgengui.py
index 16116ba6..9c151a11 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 #
 # polgengui.py - GUI for SELinux Config tool in system-config-selinux
 #
diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
index 9f53b7fe..0b6ba4b5 100644
--- a/gui/system-config-selinux.py
+++ b/gui/system-config-selinux.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 #
 # system-config-selinux.py - GUI for SELinux Config tool in system-config-selinux
 #
@@ -32,6 +32,8 @@ except RuntimeError as e:
     print("This is a graphical application and requires DISPLAY to be set.")
     sys.exit(1)
 
+sys.path.append('/usr/share/system-config-selinux')
+
 from gi.repository import GObject
 import statusPage
 import booleansPage
@@ -66,8 +68,6 @@ except:
 
 version = "1.0"
 
-sys.path.append('/usr/share/system-config-selinux')
-
 
 ##
 ## Pull in the Glade file
diff --git a/sandbox/sandbox b/sandbox/sandbox
index a2762a7d..fe631a92 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 # Authors: Dan Walsh <dwalsh@redhat.com>
 # Authors: Thomas Liu <tliu@fedoraproject.org>
 # Authors: Josh Cogliati
diff --git a/sandbox/start b/sandbox/start
index 4ed3cb5c..3c1a1783 100644
--- a/sandbox/start
+++ b/sandbox/start
@@ -1,4 +1,4 @@
-#!/usr/bin/python3 -Es
+#!/usr/bin/python3 -EsI
 try:
     from subprocess import getstatusoutput
 except ImportError:
-- 
2.41.0

