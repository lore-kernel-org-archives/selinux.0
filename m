Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUrfK029545
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12CF580468
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:54 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 05/19] policycoreutils/sepolicy: boolean.png is in help/
Date: Wed,  3 May 2017 12:30:22 +0200
Message-Id: <20170503103036.17514-6-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes:
(sepolicy:2183): Gtk-WARNING **: Could not load image 'images/booleans.png': Failed to open file '/usr/lib64/python3.4/site-packages/sepolicy/images/booleans.png': No such file or directory

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/sepolicy.glade | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/sepolicy.glade b/python/sepolicy/sepolicy/sepolicy.glade
index e7d96f98..8f6ad650 100644
--- a/python/sepolicy/sepolicy/sepolicy.glade
+++ b/python/sepolicy/sepolicy/sepolicy.glade
@@ -1043,7 +1043,7 @@
               <object class="GtkImage" id="help_image">
                 <property name="visible">True</property>
                 <property name="can_focus">False</property>
-                <property name="pixbuf">images/booleans.png</property>
+                <property name="pixbuf">help/booleans.png</property>
               </object>
               <packing>
                 <property name="expand">False</property>
-- 
2.12.2
