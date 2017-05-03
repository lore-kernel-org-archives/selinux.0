Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AVJBp029812
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:31:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19A3CC04B320
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:31:19 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 19/19] sepolicy/gui: Update text strings to use better gettext
 templates
Date: Wed,  3 May 2017 12:30:36 +0200
Message-Id: <20170503103036.17514-20-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/gui.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 7f84b6f9..007c94a7 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -1378,8 +1378,8 @@ class SELinuxGui():
                 self.treeview = self.network_in_treeview
                 category = _("listen for inbound connections")
 
-            self.add_button.set_tooltip_text(_("Add new port definition to which the '%(APP)s' domain is allowed to %s.") % {"APP": self.application, "PERM": category})
-            self.delete_button.set_tooltip_text(_("Delete modified port definitions to which the '%(APP)s' domain is allowed to %s.") % {"APP": self.application, "PERM": category})
+            self.add_button.set_tooltip_text(_("Add new port definition to which the '%(APP)s' domain is allowed to %(PERM)s.") % {"APP": self.application, "PERM": category})
+            self.delete_button.set_tooltip_text(_("Delete modified port definitions to which the '%(APP)s' domain is allowed to %(PERM)s.") % {"APP": self.application, "PERM": category})
             self.modify_button.set_tooltip_text(_("Modify port definitions to which the '%(APP)s' domain is allowed to %(PERM)s.") % {"APP": self.application, "PERM": category})
 
         if self.transitions_radio_button.get_active():
@@ -1599,8 +1599,8 @@ class SELinuxGui():
             self.show_popup(self.login_popup_window)
 
         if self.opage == FILE_EQUIV_PAGE:
-            self.file_equiv_source_entry.set_text(self.file_equiv_liststore.get_value(iter, 0))
-            self.file_equiv_dest_entry.set_text(self.file_equiv_liststore.get_value(iter, 1))
+            self.file_equiv_source_entry.set_text(self.unmarkup(self.file_equiv_liststore.get_value(iter, 0)))
+            self.file_equiv_dest_entry.set_text(self.unmarkup(self.file_equiv_liststore.get_value(iter, 1)))
             self.file_equiv_label.set_text((_("Modify File Equivalency Mapping. Mapping will be created when update is applied.")))
             self.file_equiv_popup_window.set_title(_("Modify SELinux File Equivalency"))
             self.clear_entry = True
-- 
2.12.2
