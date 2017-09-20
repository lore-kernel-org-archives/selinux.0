Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8K6vjUs005718
 for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2017 02:57:46 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DFCBB56468D
 for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2017 08:57:23 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed, 20 Sep 2017 08:56:54 +0200
Message-Id: <20170920065654.6143-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 1/1] gui: port to Python 3 by migrating to PyGI
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

PyGTK has been deprecated in favor of PyGI+GTK and thus has never been
ported to python3. Using pygi-convert.sh from
https://git.gnome.org/browse/pygobject/tree/pygi-convert.sh helps
migrating most of the API but gnome-python.

The glade file has been converted to GtkBuilder using

  gtk-builder-convert system-config-selinux.glade system-config-selinux.ui

and some fixes in order to provide an application window (object
GnomeApp disappeared, GtkVBox is deprecated, etc.). The associated
Python code also needed some modifications in order to migrate to
GtkBuilder.

The result has been tested on Arch Linux with Python 3.6. There are some
bugs in the GUI itself, for which patches will be sent afterwards.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 gui/Makefile                    |    2 +-
 gui/booleansPage.py             |   56 +-
 gui/domainsPage.py              |   25 +-
 gui/fcontextPage.py             |   33 +-
 gui/loginsPage.py               |   28 +-
 gui/modulesPage.py              |   41 +-
 gui/polgengui.py                |  118 +-
 gui/portsPage.py                |   41 +-
 gui/semanagePage.py             |   52 +-
 gui/statusPage.py               |   36 +-
 gui/system-config-selinux.glade | 3005 ---------------------------------------
 gui/system-config-selinux.py    |   69 +-
 gui/system-config-selinux.ui    | 2043 ++++++++++++++++++++++++++
 gui/usersPage.py                |   24 +-
 14 files changed, 2281 insertions(+), 3292 deletions(-)
 delete mode 100644 gui/system-config-selinux.glade
 create mode 100644 gui/system-config-selinux.ui

diff --git a/gui/Makefile b/gui/Makefile
index 4fc2c1a133be..ac844b6b9198 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -17,8 +17,8 @@ polgen.glade \
 portsPage.py \
 semanagePage.py \
 statusPage.py \
-system-config-selinux.glade \
 system-config-selinux.png \
+system-config-selinux.ui \
 usersPage.py
 
 all: $(TARGETS) system-config-selinux.py polgengui.py
diff --git a/gui/booleansPage.py b/gui/booleansPage.py
index a5d04bf5b90c..7849bea26a06 100644
--- a/gui/booleansPage.py
+++ b/gui/booleansPage.py
@@ -18,13 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 #
-import string
-import gtk
-import gtk.glade
-import os
-import gobject
 import sys
-import tempfile
+from gi.repository import Gdk, GObject, Gtk
 import seobject
 import semanagePage
 
@@ -61,8 +56,6 @@ except:
         import __builtin__
         __builtin__.__dict__['_'] = unicode
 
-from glob import fnmatch
-
 
 class Modifier:
 
@@ -94,56 +87,53 @@ class booleansPage:
 
     def __init__(self, xml, doDebug=None):
         self.xml = xml
-        self.window = self.xml.get_widget("mainWindow").get_root_window()
+        self.window = self.xml.get_object("mainWindow").get_root_window()
         self.local = False
         self.types = []
         self.selinuxsupport = True
         self.typechanged = False
         self.doDebug = doDebug
-        self.busy_cursor = gtk.gdk.Cursor(gtk.gdk.WATCH)
-        self.ready_cursor = gtk.gdk.Cursor(gtk.gdk.LEFT_PTR)
+        self.busy_cursor = Gdk.Cursor.new(Gdk.CursorType.WATCH)
+        self.ready_cursor = Gdk.Cursor.new(Gdk.CursorType.LEFT_PTR)
 
         # Bring in widgets from glade file.
-        self.typeHBox = xml.get_widget("typeHBox")
-        self.booleanSW = xml.get_widget("booleanSW")
-        self.booleansFilter = xml.get_widget("booleansFilter")
+        self.booleansFilter = xml.get_object("booleansFilter")
         self.booleansFilter.connect("focus_out_event", self.filter_changed)
         self.booleansFilter.connect("activate", self.filter_changed)
+        self.booleansFilter.connect("changed", self.filter_changed)
 
-        self.booleansView = xml.get_widget("booleansView")
-        self.typeLabel = xml.get_widget("typeLabel")
-        self.modifySeparator = xml.get_widget("modifySeparator")
+        self.booleansView = xml.get_object("booleansView")
 
-        self.revertButton = xml.get_widget("booleanRevertButton")
+        self.revertButton = xml.get_object("booleanRevertButton")
         self.revertButton.set_sensitive(self.local)
         self.revertButton.connect("clicked", self.on_revert_clicked)
-        listStore = gtk.ListStore(gobject.TYPE_STRING)
-        cell = gtk.CellRendererText()
+        listStore = Gtk.ListStore(GObject.TYPE_STRING)
+        cell = Gtk.CellRendererText()
 
-        self.store = gtk.ListStore(gobject.TYPE_BOOLEAN, gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING)
-        self.store.set_sort_column_id(1, gtk.SORT_ASCENDING)
+        self.store = Gtk.ListStore(GObject.TYPE_BOOLEAN, GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING)
+        self.store.set_sort_column_id(1, Gtk.SortType.ASCENDING)
         self.booleansView.set_model(self.store)
 
-        checkbox = gtk.CellRendererToggle()
+        checkbox = Gtk.CellRendererToggle()
         checkbox.connect("toggled", self.boolean_toggled)
-        col = gtk.TreeViewColumn('Active', checkbox, active=ACTIVE)
+        col = Gtk.TreeViewColumn('Active', checkbox, active=ACTIVE)
         col.set_clickable(True)
         col.set_sort_column_id(ACTIVE)
         self.booleansView.append_column(col)
 
-        col = gtk.TreeViewColumn("Module", gtk.CellRendererText(), text=MODULE)
+        col = Gtk.TreeViewColumn("Module", Gtk.CellRendererText(), text=MODULE)
         col.set_sort_column_id(MODULE)
         col.set_resizable(True)
         self.booleansView.append_column(col)
 
-        col = gtk.TreeViewColumn("Description", gtk.CellRendererText(), text=DESC)
-        col.set_sizing(gtk.TREE_VIEW_COLUMN_FIXED)
+        col = Gtk.TreeViewColumn("Description", Gtk.CellRendererText(), text=DESC)
+        col.set_sizing(Gtk.TreeViewColumnSizing.FIXED)
         col.set_fixed_width(400)
         col.set_sort_column_id(DESC)
         col.set_resizable(True)
         self.booleansView.append_column(col)
 
-        col = gtk.TreeViewColumn("Name", gtk.CellRendererText(), text=BOOLEAN)
+        col = Gtk.TreeViewColumn("Name", Gtk.CellRendererText(), text=BOOLEAN)
         col.set_sort_column_id(BOOLEAN)
         col.set_resizable(True)
         self.booleansView.set_search_equal_func(self.__search)
@@ -152,10 +142,10 @@ class booleansPage:
         self.load(self.filter)
 
     def error(self, message):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_ERROR,
-                                gtk.BUTTONS_CLOSE,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.ERROR,
+                                Gtk.ButtonsType.CLOSE,
                                 message)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         dlg.run()
         dlg.destroy()
@@ -178,11 +168,11 @@ class booleansPage:
 
     def deleteDialog(self):
         store, iter = self.booleansView.get_selection().get_selected()
-        if iter == None:
+        if iter is None:
             return
         boolean = store.get_value(iter, BOOLEAN)
         # change cursor
-        if boolean == None:
+        if boolean is None:
             return
         try:
             self.wait()
diff --git a/gui/domainsPage.py b/gui/domainsPage.py
index 66f882a4e1b6..bad5140d8c59 100644
--- a/gui/domainsPage.py
+++ b/gui/domainsPage.py
@@ -16,19 +16,14 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
 import os
 try:
     from subprocess import getstatusoutput
 except ImportError:
     from commands import getstatusoutput
 
-import gobject
 import sys
-import seobject
-import selinux
+from gi.repository import GObject, Gtk
 import sepolicy
 from semanagePage import *
 
@@ -58,26 +53,26 @@ class domainsPage(semanagePage):
 
     def __init__(self, xml):
         semanagePage.__init__(self, xml, "domains", _("Process Domain"))
-        self.domain_filter = xml.get_widget("domainsFilterEntry")
+        self.domain_filter = xml.get_object("domainsFilterEntry")
         self.domain_filter.connect("focus_out_event", self.filter_changed)
         self.domain_filter.connect("activate", self.filter_changed)
 
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING)
         self.view.set_model(self.store)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Domain Name"), gtk.CellRendererText(), text=0)
+        self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Domain Name"), Gtk.CellRendererText(), text=0)
         col.set_sort_column_id(0)
         col.set_resizable(True)
         self.view.append_column(col)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Mode"), gtk.CellRendererText(), text=1)
+        self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Mode"), Gtk.CellRendererText(), text=1)
         col.set_sort_column_id(1)
         col.set_resizable(True)
         self.view.append_column(col)
         self.view.get_selection().connect("changed", self.itemSelected)
 
-        self.permissive_button = xml.get_widget("permissiveButton")
-        self.enforcing_button = xml.get_widget("enforcingButton")
+        self.permissive_button = xml.get_object("permissiveButton")
+        self.enforcing_button = xml.get_object("enforcingButton")
 
         self.domains = sepolicy.get_all_entrypoint_domains()
         self.load()
@@ -112,7 +107,7 @@ class domainsPage(semanagePage):
 
     def itemSelected(self, selection):
         store, iter = selection.get_selected()
-        if iter == None:
+        if iter is None:
             return
         p = store.get_value(iter, 1) == _("Permissive")
         self.permissive_button.set_sensitive(not p)
diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
index 2e26666e9049..a6577ef75faf 100644
--- a/gui/fcontextPage.py
+++ b/gui/fcontextPage.py
@@ -16,10 +16,7 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import gtk
-import gtk.glade
-import os
-import gobject
+from gi.repository import GObject, Gtk
 import seobject
 try:
     from subprocess import getstatusoutput
@@ -73,40 +70,40 @@ class fcontextPage(semanagePage):
 
     def __init__(self, xml):
         semanagePage.__init__(self, xml, "fcontext", _("File Labeling"))
-        self.fcontextFilter = xml.get_widget("fcontextFilterEntry")
+        self.fcontextFilter = xml.get_object("fcontextFilterEntry")
         self.fcontextFilter.connect("focus_out_event", self.filter_changed)
         self.fcontextFilter.connect("activate", self.filter_changed)
 
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING)
-        self.view = xml.get_widget("fcontextView")
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING)
+        self.view = xml.get_object("fcontextView")
         self.view.set_model(self.store)
         self.view.set_search_equal_func(self.search)
 
-        col = gtk.TreeViewColumn(_("File\nSpecification"), gtk.CellRendererText(), text=SPEC_COL)
-        col.set_sizing(gtk.TREE_VIEW_COLUMN_FIXED)
+        col = Gtk.TreeViewColumn(_("File\nSpecification"), Gtk.CellRendererText(), text=SPEC_COL)
+        col.set_sizing(Gtk.TreeViewColumnSizing.FIXED)
         col.set_fixed_width(250)
 
         col.set_sort_column_id(SPEC_COL)
         col.set_resizable(True)
         self.view.append_column(col)
-        col = gtk.TreeViewColumn(_("Selinux\nFile Type"), gtk.CellRendererText(), text=TYPE_COL)
+        col = Gtk.TreeViewColumn(_("Selinux\nFile Type"), Gtk.CellRendererText(), text=TYPE_COL)
 
-        col.set_sizing(gtk.TREE_VIEW_COLUMN_FIXED)
+        col.set_sizing(Gtk.TreeViewColumnSizing.FIXED)
         col.set_fixed_width(250)
         col.set_sort_column_id(TYPE_COL)
         col.set_resizable(True)
         self.view.append_column(col)
-        col = gtk.TreeViewColumn(_("File\nType"), gtk.CellRendererText(), text=2)
+        col = Gtk.TreeViewColumn(_("File\nType"), Gtk.CellRendererText(), text=2)
         col.set_sort_column_id(FTYPE_COL)
         col.set_resizable(True)
         self.view.append_column(col)
 
-        self.store.set_sort_column_id(SPEC_COL, gtk.SORT_ASCENDING)
+        self.store.set_sort_column_id(SPEC_COL, Gtk.SortType.ASCENDING)
         self.load()
-        self.fcontextEntry = xml.get_widget("fcontextEntry")
-        self.fcontextFileTypeCombo = xml.get_widget("fcontextFileTypeCombo")
-        self.fcontextTypeEntry = xml.get_widget("fcontextTypeEntry")
-        self.fcontextMLSEntry = xml.get_widget("fcontextMLSEntry")
+        self.fcontextEntry = xml.get_object("fcontextEntry")
+        self.fcontextFileTypeCombo = xml.get_object("fcontextFileTypeCombo")
+        self.fcontextTypeEntry = xml.get_object("fcontextTypeEntry")
+        self.fcontextMLSEntry = xml.get_object("fcontextMLSEntry")
 
     def match(self, fcon_dict, k, filter):
         try:
@@ -192,7 +189,7 @@ class fcontextPage(semanagePage):
         mls = self.fcontextMLSEntry.get_text().strip()
         list_model = self.fcontextFileTypeCombo.get_model()
         it = self.fcontextFileTypeCombo.get_active_iter()
-        ftype = list_model.get_value(it,0)
+        ftype = list_model.get_value(it, 0)
         self.wait()
         (rc, out) = getstatusoutput("semanage fcontext -a -t %s -r %s -f '%s' '%s'" % (type, mls, seobject.file_type_str_to_option[ftype], fspec))
         self.ready()
diff --git a/gui/loginsPage.py b/gui/loginsPage.py
index 1f35a57bc73a..b67eb8bc42af 100644
--- a/gui/loginsPage.py
+++ b/gui/loginsPage.py
@@ -16,17 +16,13 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
-import os
-import gobject
 import sys
 try:
     from subprocess import getstatusoutput
 except ImportError:
     from commands import getstatusoutput
 
+from gi.repository import GObject, Gtk
 import seobject
 from semanagePage import *
 
@@ -57,23 +53,23 @@ class loginsPage(semanagePage):
     def __init__(self, xml):
         self.firstTime = False
         semanagePage.__init__(self, xml, "logins", _("User Mapping"))
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING)
         self.view.set_model(self.store)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Login\nName"), gtk.CellRendererText(), text=0)
+        self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Login\nName"), Gtk.CellRendererText(), text=0)
         col.set_sort_column_id(0)
         col.set_resizable(True)
         self.view.append_column(col)
-        col = gtk.TreeViewColumn(_("SELinux\nUser"), gtk.CellRendererText(), text=1)
+        col = Gtk.TreeViewColumn(_("SELinux\nUser"), Gtk.CellRendererText(), text=1)
         col.set_resizable(True)
         self.view.append_column(col)
-        col = gtk.TreeViewColumn(_("MLS/\nMCS Range"), gtk.CellRendererText(), text=2)
+        col = Gtk.TreeViewColumn(_("MLS/\nMCS Range"), Gtk.CellRendererText(), text=2)
         col.set_resizable(True)
         self.view.append_column(col)
         self.load()
-        self.loginsNameEntry = xml.get_widget("loginsNameEntry")
-        self.loginsSelinuxUserCombo = xml.get_widget("loginsSelinuxUserCombo")
-        self.loginsMLSEntry = xml.get_widget("loginsMLSEntry")
+        self.loginsNameEntry = xml.get_object("loginsNameEntry")
+        self.loginsSelinuxUserCombo = xml.get_object("loginsSelinuxUserCombo")
+        self.loginsMLSEntry = xml.get_object("loginsMLSEntry")
 
     def load(self, filter=""):
         self.filter = filter
@@ -91,12 +87,12 @@ class loginsPage(semanagePage):
         self.view.get_selection().select_path((0,))
 
     def __dialogSetup(self):
-        if self.firstTime == True:
+        if self.firstTime:
             return
         self.firstTime = True
-        liststore = gtk.ListStore(gobject.TYPE_STRING)
+        liststore = Gtk.ListStore(GObject.TYPE_STRING)
         self.loginsSelinuxUserCombo.set_model(liststore)
-        cell = gtk.CellRendererText()
+        cell = Gtk.CellRendererText()
         self.loginsSelinuxUserCombo.pack_start(cell, True)
         self.loginsSelinuxUserCombo.add_attribute(cell, 'text', 0)
 
diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index 37678966866f..c7fde9ea1ef8 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -16,21 +16,16 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
-import os
+import sys
+from subprocess import Popen, PIPE
 try:
     from subprocess import getstatusoutput
 except ImportError:
     from commands import getstatusoutput
 
-import gobject
-import sys
-import seobject
+from gi.repository import GObject, Gtk
 import selinux
 from semanagePage import *
-from subprocess import Popen, PIPE
 
 ##
 ## I18N
@@ -58,23 +53,23 @@ class modulesPage(semanagePage):
 
     def __init__(self, xml):
         semanagePage.__init__(self, xml, "modules", _("Policy Module"))
-        self.module_filter = xml.get_widget("modulesFilterEntry")
+        self.module_filter = xml.get_object("modulesFilterEntry")
         self.module_filter.connect("focus_out_event", self.filter_changed)
         self.module_filter.connect("activate", self.filter_changed)
         self.audit_enabled = False
 
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING)
         self.view.set_model(self.store)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Module Name"), gtk.CellRendererText(), text=0)
+        self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Module Name"), Gtk.CellRendererText(), text=0)
         col.set_sort_column_id(0)
         col.set_resizable(True)
         self.view.append_column(col)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Version"), gtk.CellRendererText(), text=1)
-        self.enable_audit_button = xml.get_widget("enableAuditButton")
+        self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Version"), Gtk.CellRendererText(), text=1)
+        self.enable_audit_button = xml.get_object("enableAuditButton")
         self.enable_audit_button.connect("clicked", self.enable_audit)
-        self.new_button = xml.get_widget("newModuleButton")
+        self.new_button = xml.get_object("newModuleButton")
         self.new_button.connect("clicked", self.new_module)
         col.set_sort_column_id(1)
         col.set_resizable(True)
@@ -170,20 +165,20 @@ class modulesPage(semanagePage):
         return
 
     def addDialog(self):
-        dialog = gtk.FileChooserDialog(_("Load Policy Module"),
+        dialog = Gtk.FileChooserDialog(_("Load Policy Module"),
                                        None,
-                                       gtk.FILE_CHOOSER_ACTION_OPEN,
-                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,
-                                        gtk.STOCK_OPEN, gtk.RESPONSE_OK))
-        dialog.set_default_response(gtk.RESPONSE_OK)
+                                       Gtk.FileChooserAction.OPEN,
+                                       (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
+                                        Gtk.STOCK_OPEN, Gtk.ResponseType.OK))
+        dialog.set_default_response(Gtk.ResponseType.OK)
 
-        filter = gtk.FileFilter()
+        filter = Gtk.FileFilter()
         filter.set_name("Policy Files")
         filter.add_pattern("*.pp")
         dialog.add_filter(filter)
 
         response = dialog.run()
-        if response == gtk.RESPONSE_OK:
+        if response == Gtk.ResponseType.OK:
             self.add(dialog.get_filename())
         dialog.destroy()
 
diff --git a/gui/polgengui.py b/gui/polgengui.py
index 7460cce2911c..af6b822b86b8 100644
--- a/gui/polgengui.py
+++ b/gui/polgengui.py
@@ -22,11 +22,11 @@
 #
 import signal
 import string
-import gtk
-import gtk.glade
+import gi
+gi.require_version('Gtk', '3.0')
+from gi.repository import Gtk
 import os
-import gobject
-import gnome
+from gi.repository import GObject
 import sys
 try:
     import sepolicy
@@ -79,8 +79,6 @@ except:
         import __builtin__
         __builtin__.__dict__['_'] = unicode
 
-gnome.program_init("SELinux Policy Generation Tool", "5")
-
 version = "1.0"
 
 sys.path.append('/usr/share/system-config-selinux')
@@ -95,10 +93,12 @@ def foreach(model, path, iter, selected):
 ##
 ## Pull in the Glade file
 ##
+xml = Gtk.Builder()
+xml.set_translation_domain(PROGNAME)
 if os.access("polgen.glade", os.F_OK):
-    xml = gtk.glade.XML("polgen.glade", domain=PROGNAME)
+    xml.add_from_file("polgen.glade")
 else:
-    xml = gtk.glade.XML("/usr/share/system-config-selinux/polgen.glade", domain=PROGNAME)
+    xml.add_from_file("/usr/share/system-config-selinux/polgen.glade")
 
 FILE = 1
 DIR = 2
@@ -277,27 +277,27 @@ class childWindow:
             b.connect("clicked", self.network_all_clicked)
 
         self.boolean_treeview = self.xml.get_widget("boolean_treeview")
-        self.boolean_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING)
+        self.boolean_store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING)
         self.boolean_treeview.set_model(self.boolean_store)
-        self.boolean_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Name"), gtk.CellRendererText(), text=0)
+        self.boolean_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Name"), Gtk.CellRendererText(), text=0)
         self.boolean_treeview.append_column(col)
-        col = gtk.TreeViewColumn(_("Description"), gtk.CellRendererText(), text=1)
+        col = Gtk.TreeViewColumn(_("Description"), Gtk.CellRendererText(), text=1)
         self.boolean_treeview.append_column(col)
 
         self.role_treeview = self.xml.get_widget("role_treeview")
-        self.role_store = gtk.ListStore(gobject.TYPE_STRING)
+        self.role_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.role_treeview.set_model(self.role_store)
-        self.role_treeview.get_selection().set_mode(gtk.SELECTION_MULTIPLE)
-        self.role_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Role"), gtk.CellRendererText(), text=0)
+        self.role_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
+        self.role_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Role"), Gtk.CellRendererText(), text=0)
         self.role_treeview.append_column(col)
 
         self.existing_user_treeview = self.xml.get_widget("existing_user_treeview")
-        self.existing_user_store = gtk.ListStore(gobject.TYPE_STRING)
+        self.existing_user_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.existing_user_treeview.set_model(self.existing_user_store)
-        self.existing_user_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Existing_User"), gtk.CellRendererText(), text=0)
+        self.existing_user_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Existing_User"), Gtk.CellRendererText(), text=0)
         self.existing_user_treeview.append_column(col)
 
         for i in self.all_roles:
@@ -307,19 +307,19 @@ class childWindow:
         self.in_tcp_reserved_checkbutton = xml.get_widget("in_tcp_reserved_checkbutton")
 
         self.transition_treeview = self.xml.get_widget("transition_treeview")
-        self.transition_store = gtk.ListStore(gobject.TYPE_STRING)
+        self.transition_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.transition_treeview.set_model(self.transition_store)
-        self.transition_treeview.get_selection().set_mode(gtk.SELECTION_MULTIPLE)
-        self.transition_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Application"), gtk.CellRendererText(), text=0)
+        self.transition_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
+        self.transition_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Application"), Gtk.CellRendererText(), text=0)
         self.transition_treeview.append_column(col)
 
         self.user_transition_treeview = self.xml.get_widget("user_transition_treeview")
-        self.user_transition_store = gtk.ListStore(gobject.TYPE_STRING)
+        self.user_transition_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.user_transition_treeview.set_model(self.user_transition_store)
-        self.user_transition_treeview.get_selection().set_mode(gtk.SELECTION_MULTIPLE)
-        self.user_transition_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Application"), gtk.CellRendererText(), text=0)
+        self.user_transition_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
+        self.user_transition_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Application"), Gtk.CellRendererText(), text=0)
         self.user_transition_treeview.append_column(col)
 
         for i in self.all_users:
@@ -329,11 +329,11 @@ class childWindow:
             self.existing_user_store.set_value(iter, 0, i[:-2])
 
         self.admin_treeview = self.xml.get_widget("admin_treeview")
-        self.admin_store = gtk.ListStore(gobject.TYPE_STRING)
+        self.admin_store = Gtk.ListStore(GObject.TYPE_STRING)
         self.admin_treeview.set_model(self.admin_store)
-        self.admin_treeview.get_selection().set_mode(gtk.SELECTION_MULTIPLE)
-        self.admin_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-        col = gtk.TreeViewColumn(_("Application"), gtk.CellRendererText(), text=0)
+        self.admin_treeview.get_selection().set_mode(Gtk.SelectionMode.MULTIPLE)
+        self.admin_store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Application"), Gtk.CellRendererText(), text=0)
         self.admin_treeview.append_column(col)
 
         try:
@@ -383,17 +383,17 @@ class childWindow:
 
         if self.pages[type][self.current_page] == self.FINISH_PAGE:
             self.generate_policy()
-            self.xml.get_widget("cancel_button").set_label(gtk.STOCK_CLOSE)
+            self.xml.get_widget("cancel_button").set_label(Gtk.STOCK_CLOSE)
         else:
             self.current_page = self.current_page + 1
             self.notebook.set_current_page(self.pages[type][self.current_page])
             if self.pages[type][self.current_page] == self.FINISH_PAGE:
-                self.forward_button.set_label(gtk.STOCK_APPLY)
+                self.forward_button.set_label(Gtk.STOCK_APPLY)
 
     def back(self, arg):
         type = self.get_type()
         if self.pages[type][self.current_page] == self.FINISH_PAGE:
-            self.forward_button.set_label(gtk.STOCK_GO_FORWARD)
+            self.forward_button.set_label(Gtk.STOCK_GO_FORWARD)
 
         self.current_page = self.current_page - 1
         self.notebook.set_current_page(self.pages[type][self.current_page])
@@ -406,30 +406,30 @@ class childWindow:
             b.set_sensitive(not active)
 
     def verify(self, message, title=""):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
-                                gtk.BUTTONS_YES_NO,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.INFO,
+                                Gtk.ButtonsType.YES_NO,
                                 message)
         dlg.set_title(title)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         rc = dlg.run()
         dlg.destroy()
         return rc
 
     def info(self, message):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
-                                gtk.BUTTONS_OK,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.INFO,
+                                Gtk.ButtonsType.OK,
                                 message)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         dlg.run()
         dlg.destroy()
 
     def error(self, message):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_ERROR,
-                                gtk.BUTTONS_CLOSE,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.ERROR,
+                                Gtk.ButtonsType.CLOSE,
                                 message)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         dlg.run()
         dlg.destroy()
@@ -550,7 +550,7 @@ class childWindow:
         self.boolean_description_entry.set_text("")
         rc = self.boolean_dialog.run()
         self.boolean_dialog.hide()
-        if rc == gtk.RESPONSE_CANCEL:
+        if rc == Gtk.ResponseType.CANCEL:
             return
         iter = self.boolean_store.append()
         self.boolean_store.set_value(iter, 0, self.boolean_name_entry.get_text())
@@ -559,7 +559,7 @@ class childWindow:
     def __add(self, type):
         rc = self.file_dialog.run()
         self.file_dialog.hide()
-        if rc == gtk.RESPONSE_CANCEL:
+        if rc == Gtk.ResponseType.CANCEL:
             return
         for i in self.file_dialog.get_filenames():
             iter = self.store.append()
@@ -569,29 +569,29 @@ class childWindow:
     def exec_select(self, args):
         self.file_dialog.set_select_multiple(0)
         self.file_dialog.set_title(_("Select executable file to be confined."))
-        self.file_dialog.set_action(gtk.FILE_CHOOSER_ACTION_OPEN)
+        self.file_dialog.set_action(Gtk.FileChooserAction.OPEN)
         self.file_dialog.set_current_folder("/usr/sbin")
         rc = self.file_dialog.run()
         self.file_dialog.hide()
-        if rc == gtk.RESPONSE_CANCEL:
+        if rc == Gtk.ResponseType.CANCEL:
             return
         self.exec_entry.set_text(self.file_dialog.get_filename())
 
     def init_script_select(self, args):
         self.file_dialog.set_select_multiple(0)
         self.file_dialog.set_title(_("Select init script file to be confined."))
-        self.file_dialog.set_action(gtk.FILE_CHOOSER_ACTION_OPEN)
+        self.file_dialog.set_action(Gtk.FileChooserAction.OPEN)
         self.file_dialog.set_current_folder("/etc/rc.d/init.d")
         rc = self.file_dialog.run()
         self.file_dialog.hide()
-        if rc == gtk.RESPONSE_CANCEL:
+        if rc == Gtk.ResponseType.CANCEL:
             return
         self.init_script_entry.set_text(self.file_dialog.get_filename())
 
     def add(self, args):
         self.file_dialog.set_title(_("Select file(s) that confined application creates or writes"))
         self.file_dialog.set_current_folder("/")
-        self.file_dialog.set_action(gtk.FILE_CHOOSER_ACTION_OPEN)
+        self.file_dialog.set_action(Gtk.FileChooserAction.OPEN)
         self.file_dialog.set_select_multiple(1)
         self.__add(FILE)
 
@@ -599,7 +599,7 @@ class childWindow:
         self.file_dialog.set_title(_("Select directory(s) that the confined application owns and writes into"))
         self.file_dialog.set_current_folder("/")
         self.file_dialog.set_select_multiple(1)
-        self.file_dialog.set_action(gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        self.file_dialog.set_action(Gtk.FileChooserAction.SELECT_FOLDER)
         self.__add(DIR)
 
     def on_about_clicked(self, args):
@@ -608,7 +608,7 @@ class childWindow:
         dlg.hide()
 
     def quit(self, args):
-        gtk.main_quit()
+        Gtk.main_quit()
 
     def setupScreen(self):
         # Bring in widgets from glade file.
@@ -650,20 +650,20 @@ class childWindow:
         self.view = self.xml.get_widget("write_treeview")
         self.file_dialog = self.xml.get_widget("filechooserdialog")
 
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_INT)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_INT)
         self.view.set_model(self.store)
-        col = gtk.TreeViewColumn("", gtk.CellRendererText(), text=0)
+        col = Gtk.TreeViewColumn("", Gtk.CellRendererText(), text=0)
         col.set_resizable(True)
         self.view.append_column(col)
         self.view.get_selection().select_path((0,))
 
     def output_button_clicked(self, *args):
         self.file_dialog.set_title(_("Select directory to generate policy files in"))
-        self.file_dialog.set_action(gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        self.file_dialog.set_action(Gtk.FileChooserAction.SELECT_FOLDER)
         self.file_dialog.set_select_multiple(0)
         rc = self.file_dialog.run()
         self.file_dialog.hide()
-        if rc == gtk.RESPONSE_CANCEL:
+        if rc == Gtk.ResponseType.CANCEL:
             return
         self.output_entry.set_text(self.file_dialog.get_filename())
 
@@ -675,11 +675,11 @@ class childWindow:
         name = entry.get_text()
         if self.name != name:
             if name in self.all_types:
-                if self.verify(_("Type %s_t already defined in current policy.\nDo you want to continue?") % name, _("Verify Name")) == gtk.RESPONSE_NO:
+                if self.verify(_("Type %s_t already defined in current policy.\nDo you want to continue?") % name, _("Verify Name")) == Gtk.ResponseType.NO:
                     entry.set_text("")
                     return False
             if name in self.all_modules:
-                if self.verify(_("Module %s already loaded in current policy.\nDo you want to continue?") % name, _("Verify Name")) == gtk.RESPONSE_NO:
+                if self.verify(_("Module %s already loaded in current policy.\nDo you want to continue?") % name, _("Verify Name")) == Gtk.ResponseType.NO:
                     entry.set_text("")
                     return False
 
@@ -770,7 +770,7 @@ class childWindow:
         self.mainWindow.connect("destroy", self.quit)
 
         self.mainWindow.show_all()
-        gtk.main()
+        Gtk.main()
 
 if __name__ == "__main__":
     signal.signal(signal.SIGINT, signal.SIG_DFL)
diff --git a/gui/portsPage.py b/gui/portsPage.py
index b8fdaad3e9bd..30f58383bc1d 100644
--- a/gui/portsPage.py
+++ b/gui/portsPage.py
@@ -16,12 +16,8 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
-import os
-import gobject
 import sys
+from gi.repository import GObject, Gtk
 import seobject
 
 TYPE_COL = 0
@@ -62,18 +58,19 @@ class portsPage(semanagePage):
 
     def __init__(self, xml):
         semanagePage.__init__(self, xml, "ports", _("Network Port"))
-        xml.signal_connect("on_group_clicked", self.on_group_clicked)
+        group_listview = xml.get_object("listViewButton")
+        group_listview.connect("clicked", self.on_group_clicked)
         self.group = False
-        self.ports_filter = xml.get_widget("portsFilterEntry")
+        self.ports_filter = xml.get_object("portsFilterEntry")
         self.ports_filter.connect("focus_out_event", self.filter_changed)
         self.ports_filter.connect("activate", self.filter_changed)
-        self.ports_name_entry = xml.get_widget("portsNameEntry")
-        self.ports_protocol_combo = xml.get_widget("portsProtocolCombo")
-        self.ports_number_entry = xml.get_widget("portsNumberEntry")
-        self.ports_mls_entry = xml.get_widget("portsMLSEntry")
-        self.ports_add_button = xml.get_widget("portsAddButton")
-        self.ports_properties_button = xml.get_widget("portsPropertiesButton")
-        self.ports_delete_button = xml.get_widget("portsDeleteButton")
+        self.ports_name_entry = xml.get_object("portsNameEntry")
+        self.ports_protocol_combo = xml.get_object("portsProtocolCombo")
+        self.ports_number_entry = xml.get_object("portsNumberEntry")
+        self.ports_mls_entry = xml.get_object("portsMLSEntry")
+        self.ports_add_button = xml.get_object("portsAddButton")
+        self.ports_properties_button = xml.get_object("portsPropertiesButton")
+        self.ports_delete_button = xml.get_object("portsDeleteButton")
         liststore = self.ports_protocol_combo.get_model()
         iter = liststore.get_iter_first()
         self.ports_protocol_combo.set_active_iter(iter)
@@ -90,28 +87,28 @@ class portsPage(semanagePage):
                 self.group_load(filter)
 
     def init_store(self):
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING)
         self.view.set_model(self.store)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
+        self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
 
         self.view.set_search_equal_func(self.search)
-        col = gtk.TreeViewColumn(_("SELinux Port\nType"), gtk.CellRendererText(), text=TYPE_COL)
+        col = Gtk.TreeViewColumn(_("SELinux Port\nType"), Gtk.CellRendererText(), text=TYPE_COL)
         col.set_sort_column_id(TYPE_COL)
         col.set_resizable(True)
         self.view.append_column(col)
-        self.store.set_sort_column_id(TYPE_COL, gtk.SORT_ASCENDING)
+        self.store.set_sort_column_id(TYPE_COL, Gtk.SortType.ASCENDING)
 
-        col = gtk.TreeViewColumn(_("Protocol"), gtk.CellRendererText(), text=PROTOCOL_COL)
+        col = Gtk.TreeViewColumn(_("Protocol"), Gtk.CellRendererText(), text=PROTOCOL_COL)
         col.set_sort_column_id(PROTOCOL_COL)
         col.set_resizable(True)
         self.view.append_column(col)
 
-        self.mls_col = gtk.TreeViewColumn(_("MLS/MCS\nLevel"), gtk.CellRendererText(), text=MLS_COL)
+        self.mls_col = Gtk.TreeViewColumn(_("MLS/MCS\nLevel"), Gtk.CellRendererText(), text=MLS_COL)
         self.mls_col.set_resizable(True)
         self.mls_col.set_sort_column_id(MLS_COL)
         self.view.append_column(self.mls_col)
 
-        col = gtk.TreeViewColumn(_("Port"), gtk.CellRendererText(), text=PORT_COL)
+        col = Gtk.TreeViewColumn(_("Port"), Gtk.CellRendererText(), text=PORT_COL)
         col.set_sort_column_id(PORT_COL)
         col.set_resizable(True)
         self.view.append_column(col)
@@ -139,7 +136,7 @@ class portsPage(semanagePage):
                 continue
             iter = self.store.append()
             if k[0] == k[1]:
-                self.store.set_value(iter, PORT_COL, k[0])
+                self.store.set_value(iter, PORT_COL, str(k[0]))
             else:
                 rec = "%s-%s" % k[:2]
                 self.store.set_value(iter, PORT_COL, rec)
diff --git a/gui/semanagePage.py b/gui/semanagePage.py
index 27367f333e29..560ec077f023 100644
--- a/gui/semanagePage.py
+++ b/gui/semanagePage.py
@@ -16,13 +16,8 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
-import os
-import gobject
 import sys
-import seobject
+from gi.repository import Gdk, Gtk
 
 ##
 ## I18N
@@ -47,24 +42,25 @@ except:
 
 
 def idle_func():
-    while gtk.events_pending():
-        gtk.main_iteration()
+    while Gtk.events_pending():
+        Gtk.main_iteration()
 
 
 class semanagePage:
 
     def __init__(self, xml, name, description):
         self.xml = xml
-        self.window = self.xml.get_widget("mainWindow").get_root_window()
-        self.busy_cursor = gtk.gdk.Cursor(gtk.gdk.WATCH)
-        self.ready_cursor = gtk.gdk.Cursor(gtk.gdk.LEFT_PTR)
+        self.window = self.xml.get_object("mainWindow").get_root_window()
+        self.busy_cursor = Gdk.Cursor.new(Gdk.CursorType.WATCH)
+        self.ready_cursor = Gdk.Cursor.new(Gdk.CursorType.LEFT_PTR)
 
         self.local = False
-        self.view = xml.get_widget("%sView" % name)
-        self.dialog = xml.get_widget("%sDialog" % name)
-        self.filter_entry = xml.get_widget("%sFilterEntry" % name)
+        self.view = xml.get_object("%sView" % name)
+        self.dialog = xml.get_object("%sDialog" % name)
+        self.filter_entry = xml.get_object("%sFilterEntry" % name)
         self.filter_entry.connect("focus_out_event", self.filter_changed)
         self.filter_entry.connect("activate", self.filter_changed)
+        self.filter_entry.connect("changed", self.filter_changed)
 
         self.view.connect("row_activated", self.rowActivated)
         self.view.get_selection().connect("changed", self.itemSelected)
@@ -81,7 +77,7 @@ class semanagePage:
     def get_description(self):
         return self.description
 
-    def itemSelected(self, args):
+    def itemSelected(self, selection):
         return
 
     def filter_changed(self, *arg):
@@ -110,28 +106,28 @@ class semanagePage:
         self.propertiesDialog()
 
     def verify(self, message, title=""):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
-                                gtk.BUTTONS_YES_NO,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.INFO,
+                                Gtk.ButtonsType.YES_NO,
                                 message)
         dlg.set_title(title)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         rc = dlg.run()
         dlg.destroy()
         return rc
 
     def error(self, message):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_ERROR,
-                                gtk.BUTTONS_CLOSE,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.ERROR,
+                                Gtk.ButtonsType.CLOSE,
                                 message)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         dlg.run()
         dlg.destroy()
 
     def deleteDialog(self):
         store, it = self.view.get_selection().get_selected()
-        if (it is not None) and (self.verify(_("Are you sure you want to delete %s '%s'?" % (self.description, store.get_value(it, 0))), _("Delete %s" % self.description)) == gtk.RESPONSE_YES):
+        if (it is not None) and (self.verify(_("Are you sure you want to delete %s '%s'?" % (self.description, store.get_value(it, 0))), _("Delete %s" % self.description)) == Gtk.ResponseType.YES):
             self.delete()
 
     def use_menus(self):
@@ -140,11 +136,11 @@ class semanagePage:
     def addDialog(self):
         self.dialogClear()
         self.dialog.set_title(_("Add %s" % self.description))
-        self.dialog.set_position(gtk.WIN_POS_MOUSE)
+        self.dialog.set_position(Gtk.WindowPosition.MOUSE)
 
-        while self.dialog.run() == gtk.RESPONSE_OK:
+        while self.dialog.run() == Gtk.ResponseType.OK:
             try:
-                if self.add() == False:
+                if not self.add():
                     continue
                 break
             except ValueError as e:
@@ -154,10 +150,10 @@ class semanagePage:
     def propertiesDialog(self):
         self.dialogInit()
         self.dialog.set_title(_("Modify %s" % self.description))
-        self.dialog.set_position(gtk.WIN_POS_MOUSE)
-        while self.dialog.run() == gtk.RESPONSE_OK:
+        self.dialog.set_position(Gtk.WindowPosition.MOUSE)
+        while self.dialog.run() == Gtk.ResponseType.OK:
             try:
-                if self.modify() == False:
+                if not self.modify():
                     continue
                 break
             except ValueError as e:
diff --git a/gui/statusPage.py b/gui/statusPage.py
index 23d0d0f6121e..766854b19cba 100644
--- a/gui/statusPage.py
+++ b/gui/statusPage.py
@@ -16,23 +16,14 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
 import os
-import gobject
 import sys
-import tempfile
+from gi.repository import Gtk
 import selinux
 
 INSTALLPATH = '/usr/share/system-config-selinux'
 sys.path.append(INSTALLPATH)
 
-try:
-    from subprocess import getstatusoutput
-except ImportError:
-    from commands import getstatusoutput
-
 ENFORCING = 1
 PERMISSIVE = 0
 DISABLED = -1
@@ -71,12 +62,11 @@ class statusPage:
 
         self.type = selinux.selinux_getpolicytype()
         # Bring in widgets from glade file.
-        self.typeHBox = xml.get_widget("typeHBox")
-        self.selinuxTypeOptionMenu = xml.get_widget("selinuxTypeOptionMenu")
-        self.typeLabel = xml.get_widget("typeLabel")
-        self.enabledOptionMenu = xml.get_widget("enabledOptionMenu")
-        self.currentOptionMenu = xml.get_widget("currentOptionMenu")
-        self.relabel_checkbutton = xml.get_widget("relabelCheckbutton")
+        self.selinuxTypeOptionMenu = xml.get_object("selinuxTypeOptionMenu")
+        self.typeLabel = xml.get_object("typeLabel")
+        self.enabledOptionMenu = xml.get_object("enabledOptionMenu")
+        self.currentOptionMenu = xml.get_object("currentOptionMenu")
+        self.relabel_checkbutton = xml.get_object("relabelCheckbutton")
         self.relabel_checkbutton.set_active(self.is_relabel())
         self.relabel_checkbutton.connect("toggled", self.on_relabel_toggle)
         if self.get_current_mode() == ENFORCING or self.get_current_mode() == PERMISSIVE:
@@ -90,7 +80,7 @@ class statusPage:
             self.currentOptionMenu.set_active(0)
             self.currentOptionMenu.set_sensitive(False)
 
-        if self.read_selinux_config() == None:
+        if self.read_selinux_config() is None:
             self.selinuxsupport = False
         else:
             self.enabledOptionMenu.connect("changed", self.enabled_changed)
@@ -131,10 +121,10 @@ class statusPage:
                 os.unlink(RELABELFILE)
 
     def verify(self, message):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
-                                gtk.BUTTONS_YES_NO,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.INFO,
+                                Gtk.ButtonsType.YES_NO,
                                 message)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         rc = dlg.run()
         dlg.destroy()
@@ -144,7 +134,7 @@ class statusPage:
         type = self.get_type()
         enabled = self.enabledOptionMenu.get_active()
         if self.initialtype != type:
-            if self.verify(_("Changing the policy type will cause a relabel of the entire file system on the next boot. Relabeling takes a long time depending on the size of the file system.  Do you wish to continue?")) == gtk.RESPONSE_NO:
+            if self.verify(_("Changing the policy type will cause a relabel of the entire file system on the next boot. Relabeling takes a long time depending on the size of the file system.  Do you wish to continue?")) == Gtk.ResponseType.NO:
                 menu.set_active(self.typeHistory)
                 return None
 
@@ -158,12 +148,12 @@ class statusPage:
         type = self.get_type()
 
         if self.initEnabled != DISABLED and enabled == DISABLED:
-            if self.verify(_("Changing to SELinux disabled requires a reboot.  It is not recommended.  If you later decide to turn SELinux back on, the system will be required to relabel.  If you just want to see if SELinux is causing a problem on your system, you can go to permissive mode which will only log errors and not enforce SELinux policy.  Permissive mode does not require a reboot    Do you wish to continue?")) == gtk.RESPONSE_NO:
+            if self.verify(_("Changing to SELinux disabled requires a reboot.  It is not recommended.  If you later decide to turn SELinux back on, the system will be required to relabel.  If you just want to see if SELinux is causing a problem on your system, you can go to permissive mode which will only log errors and not enforce SELinux policy.  Permissive mode does not require a reboot    Do you wish to continue?")) == Gtk.ResponseType.NO:
                 combo.set_active(self.enabled)
                 return None
 
         if self.initEnabled == DISABLED and enabled < 2:
-            if self.verify(_("Changing to SELinux enabled will cause a relabel of the entire file system on the next boot. Relabeling takes a long time depending on the size of the file system.  Do you wish to continue?")) == gtk.RESPONSE_NO:
+            if self.verify(_("Changing to SELinux enabled will cause a relabel of the entire file system on the next boot. Relabeling takes a long time depending on the size of the file system.  Do you wish to continue?")) == Gtk.ResponseType.NO:
                 combo.set_active(self.enabled)
                 return None
             self.relabel_checkbutton.set_active(True)
diff --git a/gui/system-config-selinux.glade b/gui/system-config-selinux.glade
deleted file mode 100644
index 4547b3fd669c..000000000000
--- a/gui/system-config-selinux.glade
+++ /dev/null
@@ -1,3005 +0,0 @@
-<?xml version="1.0" standalone="no"?> <!--*- mode: xml -*-->
-<!DOCTYPE glade-interface SYSTEM "http://glade.gnome.org/glade-2.0.dtd">
-
-<glade-interface>
-<requires lib="gnome"/>
-<requires lib="bonobo"/>
-
-<widget class="GtkAboutDialog" id="aboutWindow">
-  <property name="border_width">5</property>
-  <property name="destroy_with_parent">False</property>
-  <property name="name" translatable="yes">system-config-selinux</property>
-  <property name="copyright" translatable="yes">Copyright (c)2006 Red Hat, Inc.
-Copyright (c) 2006 Dan Walsh &lt;dwalsh@redhat.com&gt;</property>
-  <property name="wrap_license">False</property>
-  <property name="authors">Daniel Walsh &lt;dwalsh@redhat.com&gt;
-</property>
-  <property name="translator_credits" translatable="yes" comments="TRANSLATORS: Replace this string with your names, one name per line.">translator-credits</property>
-  <property name="logo">system-config-selinux.png</property>
-</widget>
-
-<widget class="GtkDialog" id="loginsDialog">
-  <property name="title" translatable="yes">Add SELinux Login Mapping</property>
-  <property name="type">GTK_WINDOW_TOPLEVEL</property>
-  <property name="window_position">GTK_WIN_POS_NONE</property>
-  <property name="modal">False</property>
-  <property name="resizable">True</property>
-  <property name="destroy_with_parent">False</property>
-  <property name="decorated">True</property>
-  <property name="skip_taskbar_hint">False</property>
-  <property name="skip_pager_hint">False</property>
-  <property name="type_hint">GDK_WINDOW_TYPE_HINT_DIALOG</property>
-  <property name="gravity">GDK_GRAVITY_NORTH_WEST</property>
-  <property name="focus_on_map">True</property>
-  <property name="urgency_hint">False</property>
-  <property name="has_separator">True</property>
-
-  <child internal-child="vbox">
-    <widget class="GtkVBox" id="dialog-vbox1">
-      <property name="visible">True</property>
-      <property name="homogeneous">False</property>
-      <property name="spacing">0</property>
-
-      <child internal-child="action_area">
-	<widget class="GtkHButtonBox" id="dialog-action_area1">
-	  <property name="visible">True</property>
-	  <property name="layout_style">GTK_BUTTONBOX_END</property>
-
-	  <child>
-	    <widget class="GtkButton" id="cancelbutton1">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-cancel</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-6</property>
-	    </widget>
-	  </child>
-
-	  <child>
-	    <widget class="GtkButton" id="okbutton1">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-ok</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-5</property>
-	    </widget>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">False</property>
-	  <property name="fill">True</property>
-	  <property name="pack_type">GTK_PACK_END</property>
-	</packing>
-      </child>
-
-      <child>
-	<widget class="GtkVBox" id="vbox2">
-	  <property name="visible">True</property>
-	  <property name="homogeneous">False</property>
-	  <property name="spacing">0</property>
-
-	  <child>
-	    <widget class="GtkTable" id="table1">
-	      <property name="visible">True</property>
-	      <property name="n_rows">3</property>
-	      <property name="n_columns">2</property>
-	      <property name="homogeneous">False</property>
-	      <property name="row_spacing">4</property>
-	      <property name="column_spacing">6</property>
-
-	      <child>
-		<widget class="GtkLabel" id="label15">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">Login Name</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label16">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">SELinux User</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label17">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">MLS/MCS Range</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="loginsNameEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkComboBox" id="loginsSelinuxUserCombo">
-		  <property name="visible">True</property>
-		  <property name="add_tearoffs">False</property>
-		  <property name="focus_on_click">True</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options">fill</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="loginsMLSEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-	    </widget>
-	    <packing>
-	      <property name="padding">5</property>
-	      <property name="expand">True</property>
-	      <property name="fill">True</property>
-	    </packing>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">True</property>
-	  <property name="fill">True</property>
-	</packing>
-      </child>
-    </widget>
-  </child>
-</widget>
-
-<widget class="GtkDialog" id="portsDialog">
-  <property name="title" translatable="yes">Add SELinux Network Ports</property>
-  <property name="type">GTK_WINDOW_TOPLEVEL</property>
-  <property name="window_position">GTK_WIN_POS_NONE</property>
-  <property name="modal">False</property>
-  <property name="resizable">True</property>
-  <property name="destroy_with_parent">False</property>
-  <property name="decorated">True</property>
-  <property name="skip_taskbar_hint">False</property>
-  <property name="skip_pager_hint">False</property>
-  <property name="type_hint">GDK_WINDOW_TYPE_HINT_DIALOG</property>
-  <property name="gravity">GDK_GRAVITY_NORTH_WEST</property>
-  <property name="focus_on_map">True</property>
-  <property name="urgency_hint">False</property>
-  <property name="has_separator">True</property>
-
-  <child internal-child="vbox">
-    <widget class="GtkVBox" id="vbox3">
-      <property name="visible">True</property>
-      <property name="homogeneous">False</property>
-      <property name="spacing">0</property>
-
-      <child internal-child="action_area">
-	<widget class="GtkHButtonBox" id="hbuttonbox1">
-	  <property name="visible">True</property>
-	  <property name="layout_style">GTK_BUTTONBOX_END</property>
-
-	  <child>
-	    <widget class="GtkButton" id="button1">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-cancel</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-6</property>
-	    </widget>
-	  </child>
-
-	  <child>
-	    <widget class="GtkButton" id="button2">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-ok</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-5</property>
-	    </widget>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">False</property>
-	  <property name="fill">True</property>
-	  <property name="pack_type">GTK_PACK_END</property>
-	</packing>
-      </child>
-
-      <child>
-	<widget class="GtkVBox" id="vbox4">
-	  <property name="visible">True</property>
-	  <property name="homogeneous">False</property>
-	  <property name="spacing">0</property>
-
-	  <child>
-	    <widget class="GtkTable" id="table2">
-	      <property name="visible">True</property>
-	      <property name="n_rows">4</property>
-	      <property name="n_columns">2</property>
-	      <property name="homogeneous">False</property>
-	      <property name="row_spacing">4</property>
-	      <property name="column_spacing">6</property>
-
-	      <child>
-		<widget class="GtkLabel" id="label18">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">Port Number</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label19">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">Protocol</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label20">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">SELinux Type</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="portsNumberEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkComboBox" id="portsProtocolCombo">
-		  <property name="visible">True</property>
-		  <property name="items">tcp
-udp</property>
-		  <property name="add_tearoffs">False</property>
-		  <property name="focus_on_click">True</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options">fill</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="portsNameEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label21">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">MLS/MCS
-Level</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">3</property>
-		  <property name="bottom_attach">4</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="portsMLSEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">3</property>
-		  <property name="bottom_attach">4</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-	    </widget>
-	    <packing>
-	      <property name="padding">5</property>
-	      <property name="expand">True</property>
-	      <property name="fill">True</property>
-	    </packing>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">True</property>
-	  <property name="fill">True</property>
-	</packing>
-      </child>
-    </widget>
-  </child>
-</widget>
-
-<widget class="GtkDialog" id="fcontextDialog">
-  <property name="title" translatable="yes">Add SELinux Login Mapping</property>
-  <property name="type">GTK_WINDOW_TOPLEVEL</property>
-  <property name="window_position">GTK_WIN_POS_NONE</property>
-  <property name="modal">False</property>
-  <property name="resizable">True</property>
-  <property name="destroy_with_parent">False</property>
-  <property name="decorated">True</property>
-  <property name="skip_taskbar_hint">False</property>
-  <property name="skip_pager_hint">False</property>
-  <property name="type_hint">GDK_WINDOW_TYPE_HINT_DIALOG</property>
-  <property name="gravity">GDK_GRAVITY_NORTH_WEST</property>
-  <property name="focus_on_map">True</property>
-  <property name="urgency_hint">False</property>
-  <property name="has_separator">True</property>
-
-  <child internal-child="vbox">
-    <widget class="GtkVBox" id="vbox7">
-      <property name="visible">True</property>
-      <property name="homogeneous">False</property>
-      <property name="spacing">0</property>
-
-      <child internal-child="action_area">
-	<widget class="GtkHButtonBox" id="hbuttonbox3">
-	  <property name="visible">True</property>
-	  <property name="layout_style">GTK_BUTTONBOX_END</property>
-
-	  <child>
-	    <widget class="GtkButton" id="button5">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-cancel</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-6</property>
-	    </widget>
-	  </child>
-
-	  <child>
-	    <widget class="GtkButton" id="button6">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-ok</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-5</property>
-	    </widget>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">False</property>
-	  <property name="fill">True</property>
-	  <property name="pack_type">GTK_PACK_END</property>
-	</packing>
-      </child>
-
-      <child>
-	<widget class="GtkVBox" id="vbox8">
-	  <property name="visible">True</property>
-	  <property name="homogeneous">False</property>
-	  <property name="spacing">0</property>
-
-	  <child>
-	    <widget class="GtkTable" id="table4">
-	      <property name="visible">True</property>
-	      <property name="n_rows">4</property>
-	      <property name="n_columns">2</property>
-	      <property name="homogeneous">False</property>
-	      <property name="row_spacing">4</property>
-	      <property name="column_spacing">6</property>
-
-	      <child>
-		<widget class="GtkLabel" id="label25">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">File Specification</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label26">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">File Type</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label27">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">SELinux Type</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="fcontextEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkComboBox" id="fcontextFileTypeCombo">
-		  <property name="visible">True</property>
-		  <property name="items" translatable="yes">all files
-regular file
-directory
-character device
-block device
-socket file
-symbolic link
-named pipe
-</property>
-		  <property name="add_tearoffs">False</property>
-		  <property name="focus_on_click">True</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options">fill</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="fcontextTypeEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label31">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">MLS</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">3</property>
-		  <property name="bottom_attach">4</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="fcontextMLSEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">3</property>
-		  <property name="bottom_attach">4</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-	    </widget>
-	    <packing>
-	      <property name="padding">5</property>
-	      <property name="expand">True</property>
-	      <property name="fill">True</property>
-	    </packing>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">True</property>
-	  <property name="fill">True</property>
-	</packing>
-      </child>
-    </widget>
-  </child>
-</widget>
-
-<widget class="GtkDialog" id="usersDialog">
-  <property name="title" translatable="yes">Add SELinux User</property>
-  <property name="type">GTK_WINDOW_TOPLEVEL</property>
-  <property name="window_position">GTK_WIN_POS_NONE</property>
-  <property name="modal">False</property>
-  <property name="resizable">True</property>
-  <property name="destroy_with_parent">False</property>
-  <property name="decorated">True</property>
-  <property name="skip_taskbar_hint">False</property>
-  <property name="skip_pager_hint">False</property>
-  <property name="type_hint">GDK_WINDOW_TYPE_HINT_DIALOG</property>
-  <property name="gravity">GDK_GRAVITY_NORTH_WEST</property>
-  <property name="focus_on_map">True</property>
-  <property name="urgency_hint">False</property>
-  <property name="has_separator">True</property>
-
-  <child internal-child="vbox">
-    <widget class="GtkVBox" id="vbox9">
-      <property name="visible">True</property>
-      <property name="homogeneous">False</property>
-      <property name="spacing">0</property>
-
-      <child internal-child="action_area">
-	<widget class="GtkHButtonBox" id="hbuttonbox4">
-	  <property name="visible">True</property>
-	  <property name="layout_style">GTK_BUTTONBOX_END</property>
-
-	  <child>
-	    <widget class="GtkButton" id="button7">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-cancel</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-6</property>
-	    </widget>
-	  </child>
-
-	  <child>
-	    <widget class="GtkButton" id="button8">
-	      <property name="visible">True</property>
-	      <property name="can_default">True</property>
-	      <property name="can_focus">True</property>
-	      <property name="label">gtk-ok</property>
-	      <property name="use_stock">True</property>
-	      <property name="relief">GTK_RELIEF_NORMAL</property>
-	      <property name="focus_on_click">True</property>
-	      <property name="response_id">-5</property>
-	    </widget>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">False</property>
-	  <property name="fill">True</property>
-	  <property name="pack_type">GTK_PACK_END</property>
-	</packing>
-      </child>
-
-      <child>
-	<widget class="GtkVBox" id="vbox10">
-	  <property name="visible">True</property>
-	  <property name="homogeneous">False</property>
-	  <property name="spacing">0</property>
-
-	  <child>
-	    <widget class="GtkTable" id="table5">
-	      <property name="visible">True</property>
-	      <property name="n_rows">3</property>
-	      <property name="n_columns">2</property>
-	      <property name="homogeneous">False</property>
-	      <property name="row_spacing">4</property>
-	      <property name="column_spacing">6</property>
-
-	      <child>
-		<widget class="GtkLabel" id="label32">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">SELinux User</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label34">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">MLS/MCS Range</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="mlsRangeEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">1</property>
-		  <property name="bottom_attach">2</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label36">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">SELinux Roles</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">0</property>
-		  <property name="right_attach">1</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="x_options">fill</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="selinuxRolesEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">2</property>
-		  <property name="bottom_attach">3</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkEntry" id="selinuxUserEntry">
-		  <property name="visible">True</property>
-		  <property name="can_focus">True</property>
-		  <property name="editable">True</property>
-		  <property name="visibility">True</property>
-		  <property name="max_length">0</property>
-		  <property name="text" translatable="yes"></property>
-		  <property name="has_frame">True</property>
-		  <property name="invisible_char">*</property>
-		  <property name="activates_default">False</property>
-		</widget>
-		<packing>
-		  <property name="left_attach">1</property>
-		  <property name="right_attach">2</property>
-		  <property name="top_attach">0</property>
-		  <property name="bottom_attach">1</property>
-		  <property name="y_options"></property>
-		</packing>
-	      </child>
-	    </widget>
-	    <packing>
-	      <property name="padding">5</property>
-	      <property name="expand">True</property>
-	      <property name="fill">True</property>
-	    </packing>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="padding">0</property>
-	  <property name="expand">True</property>
-	  <property name="fill">True</property>
-	</packing>
-      </child>
-    </widget>
-  </child>
-</widget>
-
-<widget class="GnomeApp" id="mainWindow">
-  <property name="width_request">800</property>
-  <property name="height_request">500</property>
-  <property name="title" translatable="yes">SELinux Administration</property>
-  <property name="type">GTK_WINDOW_TOPLEVEL</property>
-  <property name="window_position">GTK_WIN_POS_NONE</property>
-  <property name="modal">False</property>
-  <property name="resizable">True</property>
-  <property name="destroy_with_parent">False</property>
-  <property name="icon">system-config-selinux.png</property>
-  <property name="decorated">True</property>
-  <property name="skip_taskbar_hint">False</property>
-  <property name="skip_pager_hint">False</property>
-  <property name="type_hint">GDK_WINDOW_TYPE_HINT_NORMAL</property>
-  <property name="gravity">GDK_GRAVITY_NORTH_WEST</property>
-  <property name="focus_on_map">True</property>
-  <property name="urgency_hint">False</property>
-  <property name="enable_layout_config">True</property>
-
-  <child internal-child="dock">
-    <widget class="BonoboDock" id="bonobodock2">
-      <property name="visible">True</property>
-      <property name="allow_floating">True</property>
-
-      <child>
-	<widget class="BonoboDockItem" id="bonobodockitem3">
-	  <property name="visible">True</property>
-	  <property name="shadow_type">GTK_SHADOW_NONE</property>
-
-	  <child>
-	    <widget class="GtkMenuBar" id="menubar1">
-	      <property name="visible">True</property>
-	      <property name="pack_direction">GTK_PACK_DIRECTION_LTR</property>
-	      <property name="child_pack_direction">GTK_PACK_DIRECTION_LTR</property>
-
-	      <child>
-		<widget class="GtkMenuItem" id="file1">
-		  <property name="visible">True</property>
-		  <property name="stock_item">GNOMEUIINFO_MENU_FILE_TREE</property>
-
-		  <child>
-		    <widget class="GtkMenu" id="file1_menu">
-
-		      <child>
-			<widget class="GtkImageMenuItem" id="add_menu_item">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Add</property>
-			  <property name="use_underline">True</property>
-			  <signal name="activate" handler="on_add_clicked" last_modification_time="Sat, 17 Mar 2007 12:21:12 GMT"/>
-			  <accelerator key="a" modifiers="GDK_CONTROL_MASK" signal="activate"/>
-
-			  <child internal-child="image">
-			    <widget class="GtkImage" id="image13">
-			      <property name="visible">True</property>
-			      <property name="stock">gtk-add</property>
-			      <property name="icon_size">1</property>
-			      <property name="xalign">0.5</property>
-			      <property name="yalign">0.5</property>
-			      <property name="xpad">0</property>
-			      <property name="ypad">0</property>
-			    </widget>
-			  </child>
-			</widget>
-		      </child>
-
-		      <child>
-			<widget class="GtkImageMenuItem" id="properties_menu_item">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">_Properties</property>
-			  <property name="use_underline">True</property>
-			  <signal name="activate" handler="on_properties_clicked" last_modification_time="Sat, 17 Mar 2007 12:21:12 GMT"/>
-			  <accelerator key="p" modifiers="GDK_CONTROL_MASK" signal="activate"/>
-
-			  <child internal-child="image">
-			    <widget class="GtkImage" id="image14">
-			      <property name="visible">True</property>
-			      <property name="stock">gtk-properties</property>
-			      <property name="icon_size">1</property>
-			      <property name="xalign">0.5</property>
-			      <property name="yalign">0.5</property>
-			      <property name="xpad">0</property>
-			      <property name="ypad">0</property>
-			    </widget>
-			  </child>
-			</widget>
-		      </child>
-
-		      <child>
-			<widget class="GtkImageMenuItem" id="delete_menu_item">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">_Delete</property>
-			  <property name="use_underline">True</property>
-			  <signal name="activate" handler="on_delete_clicked" last_modification_time="Sat, 17 Mar 2007 12:21:12 GMT"/>
-			  <accelerator key="Delete" modifiers="0" signal="activate"/>
-
-			  <child internal-child="image">
-			    <widget class="GtkImage" id="image15">
-			      <property name="visible">True</property>
-			      <property name="stock">gtk-delete</property>
-			      <property name="icon_size">1</property>
-			      <property name="xalign">0.5</property>
-			      <property name="yalign">0.5</property>
-			      <property name="xpad">0</property>
-			      <property name="ypad">0</property>
-			    </widget>
-			  </child>
-			</widget>
-		      </child>
-
-		      <child>
-			<widget class="GtkImageMenuItem" id="quit">
-			  <property name="visible">True</property>
-			  <property name="stock_item">GNOMEUIINFO_MENU_EXIT_ITEM</property>
-			  <signal name="activate" handler="on_quit_activate" last_modification_time="Fri, 06 Oct 2006 13:58:19 GMT"/>
-			</widget>
-		      </child>
-		    </widget>
-		  </child>
-		</widget>
-	      </child>
-
-	      <child>
-		<widget class="GtkMenuItem" id="help1">
-		  <property name="visible">True</property>
-		  <property name="stock_item">GNOMEUIINFO_MENU_HELP_TREE</property>
-
-		  <child>
-		    <widget class="GtkMenu" id="help1_menu">
-
-		      <child>
-			<widget class="GtkImageMenuItem" id="about">
-			  <property name="visible">True</property>
-			  <property name="stock_item">GNOMEUIINFO_MENU_ABOUT_ITEM</property>
-			  <signal name="activate" handler="on_about_activate" last_modification_time="Fri, 06 Oct 2006 13:58:02 GMT"/>
-			</widget>
-		      </child>
-		    </widget>
-		  </child>
-		</widget>
-	      </child>
-	    </widget>
-	  </child>
-	</widget>
-	<packing>
-	  <property name="placement">BONOBO_DOCK_TOP</property>
-	  <property name="band">0</property>
-	  <property name="position">0</property>
-	  <property name="offset">0</property>
-	  <property name="behavior">BONOBO_DOCK_ITEM_BEH_EXCLUSIVE|BONOBO_DOCK_ITEM_BEH_NEVER_VERTICAL|BONOBO_DOCK_ITEM_BEH_LOCKED</property>
-	</packing>
-      </child>
-
-      <child>
-	<widget class="GtkHPaned" id="hpaned1">
-	  <property name="visible">True</property>
-	  <property name="can_focus">True</property>
-
-	  <child>
-	    <widget class="GtkFrame" id="frame1">
-	      <property name="border_width">5</property>
-	      <property name="visible">True</property>
-	      <property name="label_xalign">0</property>
-	      <property name="label_yalign">0.5</property>
-	      <property name="shadow_type">GTK_SHADOW_NONE</property>
-
-	      <child>
-		<widget class="GtkAlignment" id="alignment1">
-		  <property name="visible">True</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xscale">1</property>
-		  <property name="yscale">1</property>
-		  <property name="top_padding">0</property>
-		  <property name="bottom_padding">0</property>
-		  <property name="left_padding">12</property>
-		  <property name="right_padding">0</property>
-
-		  <child>
-		    <widget class="GtkTreeView" id="selectView">
-		      <property name="visible">True</property>
-		      <property name="tooltip" translatable="yes">Select Management Object</property>
-		      <property name="can_focus">True</property>
-		      <property name="headers_visible">False</property>
-		      <property name="rules_hint">False</property>
-		      <property name="reorderable">False</property>
-		      <property name="enable_search">True</property>
-		      <property name="fixed_height_mode">False</property>
-		      <property name="hover_selection">False</property>
-		      <property name="hover_expand">False</property>
-		    </widget>
-		  </child>
-		</widget>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label45">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">&lt;b&gt;Select:&lt;/b&gt;</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">True</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">label_item</property>
-		</packing>
-	      </child>
-	    </widget>
-	    <packing>
-	      <property name="shrink">False</property>
-	      <property name="resize">True</property>
-	    </packing>
-	  </child>
-
-	  <child>
-	    <widget class="GtkNotebook" id="notebook">
-	      <property name="visible">True</property>
-	      <property name="show_tabs">False</property>
-	      <property name="show_border">True</property>
-	      <property name="tab_pos">GTK_POS_TOP</property>
-	      <property name="scrollable">False</property>
-	      <property name="enable_popup">False</property>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox1">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkTable" id="table6">
-		      <property name="visible">True</property>
-		      <property name="n_rows">4</property>
-		      <property name="n_columns">2</property>
-		      <property name="homogeneous">False</property>
-		      <property name="row_spacing">5</property>
-		      <property name="column_spacing">5</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label29">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">System Default Enforcing Mode</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="left_attach">0</property>
-			  <property name="right_attach">1</property>
-			  <property name="top_attach">0</property>
-			  <property name="bottom_attach">1</property>
-			  <property name="x_options">fill</property>
-			  <property name="y_options"></property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkComboBox" id="enabledOptionMenu">
-			  <property name="visible">True</property>
-			  <property name="items" translatable="yes">Disabled
-Permissive
-Enforcing
-</property>
-			  <property name="add_tearoffs">False</property>
-			  <property name="focus_on_click">True</property>
-			</widget>
-			<packing>
-			  <property name="left_attach">1</property>
-			  <property name="right_attach">2</property>
-			  <property name="top_attach">0</property>
-			  <property name="bottom_attach">1</property>
-			  <property name="y_options">fill</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkLabel" id="label48">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Current Enforcing Mode</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="left_attach">0</property>
-			  <property name="right_attach">1</property>
-			  <property name="top_attach">1</property>
-			  <property name="bottom_attach">2</property>
-			  <property name="x_options">fill</property>
-			  <property name="y_options"></property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkComboBox" id="currentOptionMenu">
-			  <property name="visible">True</property>
-			  <property name="items" translatable="yes"></property>
-			  <property name="add_tearoffs">False</property>
-			  <property name="focus_on_click">True</property>
-			</widget>
-			<packing>
-			  <property name="left_attach">1</property>
-			  <property name="right_attach">2</property>
-			  <property name="top_attach">1</property>
-			  <property name="bottom_attach">2</property>
-			  <property name="x_options">fill</property>
-			  <property name="y_options">fill</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkLabel" id="typeLabel">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">System Default Policy Type: </property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="left_attach">0</property>
-			  <property name="right_attach">1</property>
-			  <property name="top_attach">2</property>
-			  <property name="bottom_attach">3</property>
-			  <property name="x_options">fill</property>
-			  <property name="y_options"></property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkComboBox" id="selinuxTypeOptionMenu">
-			  <property name="visible">True</property>
-			  <property name="items" translatable="yes"></property>
-			  <property name="add_tearoffs">False</property>
-			  <property name="focus_on_click">True</property>
-			</widget>
-			<packing>
-			  <property name="left_attach">1</property>
-			  <property name="right_attach">2</property>
-			  <property name="top_attach">2</property>
-			  <property name="bottom_attach">3</property>
-			  <property name="x_options">fill</property>
-			  <property name="y_options">fill</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkCheckButton" id="relabelCheckbutton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Select if you wish to relabel then entire file system on next reboot.  Relabeling can take a very long time, depending on the size of the system.  If you are changing policy types or going from disabled to enforcing, a relabel is required.</property>
-			  <property name="can_focus">True</property>
-			  <property name="relief">GTK_RELIEF_NORMAL</property>
-			  <property name="focus_on_click">True</property>
-			  <property name="active">False</property>
-			  <property name="inconsistent">False</property>
-			  <property name="draw_indicator">True</property>
-
-			  <child>
-			    <widget class="GtkAlignment" id="alignment4">
-			      <property name="visible">True</property>
-			      <property name="xalign">0.5</property>
-			      <property name="yalign">0.5</property>
-			      <property name="xscale">0</property>
-			      <property name="yscale">0</property>
-			      <property name="top_padding">0</property>
-			      <property name="bottom_padding">0</property>
-			      <property name="left_padding">0</property>
-			      <property name="right_padding">0</property>
-
-			      <child>
-				<widget class="GtkHBox" id="hbox6">
-				  <property name="visible">True</property>
-				  <property name="homogeneous">False</property>
-				  <property name="spacing">2</property>
-
-				  <child>
-				    <widget class="GtkImage" id="image2">
-				      <property name="visible">True</property>
-				      <property name="stock">gtk-refresh</property>
-				      <property name="icon_size">4</property>
-				      <property name="xalign">0.5</property>
-				      <property name="yalign">0.5</property>
-				      <property name="xpad">0</property>
-				      <property name="ypad">0</property>
-				    </widget>
-				    <packing>
-				      <property name="padding">0</property>
-				      <property name="expand">False</property>
-				      <property name="fill">False</property>
-				    </packing>
-				  </child>
-
-				  <child>
-				    <widget class="GtkLabel" id="label49">
-				      <property name="visible">True</property>
-				      <property name="label" translatable="yes">Relabel on next reboot.</property>
-				      <property name="use_underline">True</property>
-				      <property name="use_markup">False</property>
-				      <property name="justify">GTK_JUSTIFY_LEFT</property>
-				      <property name="wrap">False</property>
-				      <property name="selectable">False</property>
-				      <property name="xalign">0.5</property>
-				      <property name="yalign">0.5</property>
-				      <property name="xpad">0</property>
-				      <property name="ypad">0</property>
-				      <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-				      <property name="width_chars">-1</property>
-				      <property name="single_line_mode">False</property>
-				      <property name="angle">0</property>
-				    </widget>
-				    <packing>
-				      <property name="padding">0</property>
-				      <property name="expand">False</property>
-				      <property name="fill">False</property>
-				    </packing>
-				  </child>
-				</widget>
-			      </child>
-			    </widget>
-			  </child>
-			</widget>
-			<packing>
-			  <property name="left_attach">0</property>
-			  <property name="right_attach">2</property>
-			  <property name="top_attach">3</property>
-			  <property name="bottom_attach">4</property>
-			  <property name="x_options">fill</property>
-			  <property name="y_options">fill</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label37">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label37</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox18">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkToolbar" id="toolbar9">
-		      <property name="visible">True</property>
-		      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
-		      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
-		      <property name="tooltips">True</property>
-		      <property name="show_arrow">True</property>
-
-		      <child>
-			<widget class="GtkToolButton" id="booleanRevertButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Revert boolean setting to system default</property>
-			  <property name="stock_id">gtk-revert-to-saved</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_delete_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton34">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Toggle between Customized and All Booleans</property>
-			  <property name="label" translatable="yes">Customized</property>
-			  <property name="use_underline">True</property>
-			  <property name="stock_id">gtk-find</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_local_clicked" last_modification_time="Wed, 19 Sep 2007 19:14:08 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkHBox" id="hbox7">
-		      <property name="visible">True</property>
-		      <property name="homogeneous">False</property>
-		      <property name="spacing">0</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label51">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Filter</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="padding">10</property>
-			  <property name="expand">False</property>
-			  <property name="fill">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkEntry" id="booleansFilter">
-			  <property name="visible">True</property>
-			  <property name="can_focus">True</property>
-			  <property name="editable">True</property>
-			  <property name="visibility">True</property>
-			  <property name="max_length">0</property>
-			  <property name="text" translatable="yes"></property>
-			  <property name="has_frame">True</property>
-			  <property name="invisible_char">•</property>
-			  <property name="activates_default">False</property>
-			  <signal name="changed" handler="on_booleansFilter_changed" last_modification_time="Fri, 06 Apr 2007 12:39:26 GMT"/>
-			</widget>
-			<packing>
-			  <property name="padding">0</property>
-			  <property name="expand">True</property>
-			  <property name="fill">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">10</property>
-		      <property name="expand">False</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkScrolledWindow" id="scrolledwindow18">
-		      <property name="visible">True</property>
-		      <property name="can_focus">True</property>
-		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="shadow_type">GTK_SHADOW_NONE</property>
-		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
-
-		      <child>
-			<widget class="GtkTreeView" id="booleansView">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Boolean</property>
-			  <property name="can_focus">True</property>
-			  <property name="headers_visible">True</property>
-			  <property name="rules_hint">False</property>
-			  <property name="reorderable">False</property>
-			  <property name="enable_search">True</property>
-			  <property name="fixed_height_mode">False</property>
-			  <property name="hover_selection">False</property>
-			  <property name="hover_expand">False</property>
-			</widget>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label50">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label50</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox11">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkToolbar" id="toolbar2">
-		      <property name="visible">True</property>
-		      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
-		      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
-		      <property name="tooltips">True</property>
-		      <property name="show_arrow">True</property>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton5">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Add File Context</property>
-			  <property name="stock_id">gtk-add</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_add_clicked" last_modification_time="Mon, 16 Jan 2006 18:27:03 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton6">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Modify File Context</property>
-			  <property name="stock_id">gtk-properties</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_properties_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:51 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton7">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Delete File Context</property>
-			  <property name="stock_id">gtk-delete</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_delete_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="customizedButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Toggle between all and customized file context</property>
-			  <property name="label" translatable="yes">Customized</property>
-			  <property name="use_underline">True</property>
-			  <property name="stock_id">gtk-find</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_local_clicked" last_modification_time="Wed, 19 Sep 2007 19:14:08 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkHBox" id="hbox14">
-		      <property name="visible">True</property>
-		      <property name="homogeneous">False</property>
-		      <property name="spacing">0</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label58">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Filter</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="padding">10</property>
-			  <property name="expand">False</property>
-			  <property name="fill">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkEntry" id="fcontextFilterEntry">
-			  <property name="visible">True</property>
-			  <property name="can_focus">True</property>
-			  <property name="editable">True</property>
-			  <property name="visibility">True</property>
-			  <property name="max_length">0</property>
-			  <property name="text" translatable="yes"></property>
-			  <property name="has_frame">True</property>
-			  <property name="invisible_char">•</property>
-			  <property name="activates_default">False</property>
-			  <signal name="changed" handler="on_fcontextFilter_changed" last_modification_time="Mon, 05 Nov 2007 21:22:11 GMT"/>
-			</widget>
-			<packing>
-			  <property name="padding">0</property>
-			  <property name="expand">True</property>
-			  <property name="fill">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkScrolledWindow" id="scrolledwindow19">
-		      <property name="visible">True</property>
-		      <property name="can_focus">True</property>
-		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="shadow_type">GTK_SHADOW_NONE</property>
-		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
-
-		      <child>
-			<widget class="GtkTreeView" id="fcontextView">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">File Labeling</property>
-			  <property name="can_focus">True</property>
-			  <property name="headers_visible">True</property>
-			  <property name="rules_hint">False</property>
-			  <property name="reorderable">False</property>
-			  <property name="enable_search">True</property>
-			  <property name="fixed_height_mode">False</property>
-			  <property name="hover_selection">False</property>
-			  <property name="hover_expand">False</property>
-			</widget>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label38">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label38</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox12">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkToolbar" id="toolbar3">
-		      <property name="visible">True</property>
-		      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
-		      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
-		      <property name="tooltips">True</property>
-		      <property name="show_arrow">True</property>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton8">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Add SELinux User Mapping</property>
-			  <property name="stock_id">gtk-add</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_add_clicked" last_modification_time="Mon, 16 Jan 2006 18:27:03 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton29">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Modify SELinux User Mapping</property>
-			  <property name="stock_id">gtk-properties</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_properties_clicked" last_modification_time="Wed, 15 Nov 2006 16:38:33 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton10">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Delete SELinux User Mapping</property>
-			  <property name="stock_id">gtk-delete</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_delete_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkHBox" id="hbox13">
-		      <property name="visible">True</property>
-		      <property name="homogeneous">False</property>
-		      <property name="spacing">0</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label57">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Filter</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="padding">10</property>
-			  <property name="expand">False</property>
-			  <property name="fill">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkEntry" id="loginsFilterEntry">
-			  <property name="visible">True</property>
-			  <property name="can_focus">True</property>
-			  <property name="editable">True</property>
-			  <property name="visibility">True</property>
-			  <property name="max_length">0</property>
-			  <property name="text" translatable="yes"></property>
-			  <property name="has_frame">True</property>
-			  <property name="invisible_char">•</property>
-			  <property name="activates_default">False</property>
-			  <signal name="changed" handler="on_booleansFilter_changed" last_modification_time="Fri, 06 Apr 2007 12:39:26 GMT"/>
-			</widget>
-			<packing>
-			  <property name="padding">0</property>
-			  <property name="expand">True</property>
-			  <property name="fill">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">5</property>
-		      <property name="expand">False</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkScrolledWindow" id="scrolledwindow16">
-		      <property name="visible">True</property>
-		      <property name="can_focus">True</property>
-		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="shadow_type">GTK_SHADOW_NONE</property>
-		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
-
-		      <child>
-			<widget class="GtkTreeView" id="loginsView">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">User Mapping</property>
-			  <property name="can_focus">True</property>
-			  <property name="headers_visible">True</property>
-			  <property name="rules_hint">False</property>
-			  <property name="reorderable">False</property>
-			  <property name="enable_search">True</property>
-			  <property name="fixed_height_mode">False</property>
-			  <property name="hover_selection">False</property>
-			  <property name="hover_expand">False</property>
-			</widget>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label39">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label39</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox14">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkToolbar" id="toolbar5">
-		      <property name="visible">True</property>
-		      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
-		      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
-		      <property name="tooltips">True</property>
-		      <property name="show_arrow">True</property>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton14">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Add User</property>
-			  <property name="stock_id">gtk-add</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_add_clicked" last_modification_time="Mon, 16 Jan 2006 18:27:03 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton15">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Modify User</property>
-			  <property name="stock_id">gtk-properties</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_properties_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:51 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton16">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Delete User</property>
-			  <property name="stock_id">gtk-delete</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_delete_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkHBox" id="hbox12">
-		      <property name="visible">True</property>
-		      <property name="homogeneous">False</property>
-		      <property name="spacing">0</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label56">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Filter</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="padding">10</property>
-			  <property name="expand">False</property>
-			  <property name="fill">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkEntry" id="usersFilterEntry">
-			  <property name="visible">True</property>
-			  <property name="can_focus">True</property>
-			  <property name="editable">True</property>
-			  <property name="visibility">True</property>
-			  <property name="max_length">0</property>
-			  <property name="text" translatable="yes"></property>
-			  <property name="has_frame">True</property>
-			  <property name="invisible_char">•</property>
-			  <property name="activates_default">False</property>
-			  <signal name="changed" handler="on_booleansFilter_changed" last_modification_time="Fri, 06 Apr 2007 12:39:26 GMT"/>
-			</widget>
-			<packing>
-			  <property name="padding">0</property>
-			  <property name="expand">True</property>
-			  <property name="fill">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">5</property>
-		      <property name="expand">False</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkScrolledWindow" id="scrolledwindow11">
-		      <property name="visible">True</property>
-		      <property name="can_focus">True</property>
-		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="shadow_type">GTK_SHADOW_NONE</property>
-		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
-
-		      <child>
-			<widget class="GtkTreeView" id="usersView">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">SELinux User</property>
-			  <property name="can_focus">True</property>
-			  <property name="headers_visible">True</property>
-			  <property name="rules_hint">False</property>
-			  <property name="reorderable">False</property>
-			  <property name="enable_search">True</property>
-			  <property name="fixed_height_mode">False</property>
-			  <property name="hover_selection">False</property>
-			  <property name="hover_expand">False</property>
-			</widget>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label41">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label41</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox15">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkToolbar" id="toolbar6">
-		      <property name="visible">True</property>
-		      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
-		      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
-		      <property name="tooltips">False</property>
-		      <property name="show_arrow">True</property>
-
-		      <child>
-			<widget class="GtkToolButton" id="portsAddButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Add Network Port</property>
-			  <property name="stock_id">gtk-add</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_add_clicked" last_modification_time="Mon, 16 Jan 2006 18:27:03 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="portsPropertiesButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Edit Network Port</property>
-			  <property name="stock_id">gtk-properties</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_properties_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:51 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="portsDeleteButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Delete Network Port</property>
-			  <property name="stock_id">gtk-delete</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_delete_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolItem" id="toolitem2">
-			  <property name="visible">True</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-
-			  <child>
-			    <widget class="GtkVSeparator" id="vseparator1">
-			      <property name="width_request">32</property>
-			      <property name="visible">True</property>
-			    </widget>
-			  </child>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="listViewButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Toggle between Customized and All Ports</property>
-			  <property name="label" translatable="yes">Group View</property>
-			  <property name="use_underline">True</property>
-			  <property name="stock_id">gtk-indent</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_group_clicked" last_modification_time="Mon, 01 Oct 2007 21:31:19 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton35">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Toggle between Customized and All Ports</property>
-			  <property name="label" translatable="yes">Customized</property>
-			  <property name="use_underline">True</property>
-			  <property name="stock_id">gtk-find</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_local_clicked" last_modification_time="Wed, 19 Sep 2007 19:14:08 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkHBox" id="hbox9">
-		      <property name="visible">True</property>
-		      <property name="homogeneous">False</property>
-		      <property name="spacing">0</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label53">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Filter</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="padding">10</property>
-			  <property name="expand">False</property>
-			  <property name="fill">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkEntry" id="portsFilterEntry">
-			  <property name="visible">True</property>
-			  <property name="can_focus">True</property>
-			  <property name="editable">True</property>
-			  <property name="visibility">True</property>
-			  <property name="max_length">0</property>
-			  <property name="text" translatable="yes"></property>
-			  <property name="has_frame">True</property>
-			  <property name="invisible_char">•</property>
-			  <property name="activates_default">False</property>
-			  <signal name="changed" handler="on_booleansFilter_changed" last_modification_time="Fri, 06 Apr 2007 12:39:26 GMT"/>
-			</widget>
-			<packing>
-			  <property name="padding">0</property>
-			  <property name="expand">True</property>
-			  <property name="fill">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">5</property>
-		      <property name="expand">False</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkScrolledWindow" id="scrolledwindow13">
-		      <property name="visible">True</property>
-		      <property name="can_focus">True</property>
-		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="shadow_type">GTK_SHADOW_NONE</property>
-		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
-
-		      <child>
-			<widget class="GtkTreeView" id="portsView">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Network Port</property>
-			  <property name="can_focus">True</property>
-			  <property name="headers_visible">True</property>
-			  <property name="rules_hint">False</property>
-			  <property name="reorderable">False</property>
-			  <property name="enable_search">True</property>
-			  <property name="fixed_height_mode">False</property>
-			  <property name="hover_selection">False</property>
-			  <property name="hover_expand">False</property>
-			</widget>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label42">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label42</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox17">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkToolbar" id="toolbar8">
-		      <property name="visible">True</property>
-		      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
-		      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
-		      <property name="tooltips">True</property>
-		      <property name="show_arrow">True</property>
-
-		      <child>
-			<widget class="GtkToolButton" id="newModuleButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Generate new policy module</property>
-			  <property name="stock_id">gtk-new</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_new_clicked" last_modification_time="Sat, 17 Mar 2007 15:53:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton23">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Load policy module</property>
-			  <property name="stock_id">gtk-add</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_add_clicked" last_modification_time="Mon, 16 Jan 2006 18:27:03 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="toolbutton25">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Remove loadable policy module</property>
-			  <property name="stock_id">gtk-remove</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_delete_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolItem" id="toolitem3">
-			  <property name="visible">True</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-
-			  <child>
-			    <widget class="GtkVSeparator" id="vseparator2">
-			      <property name="width_request">10</property>
-			      <property name="visible">True</property>
-			    </widget>
-			  </child>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="enableAuditButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Enable/Disable additional audit rules, that are normally not reported in the log files.</property>
-			  <property name="label" translatable="yes">Enable Audit</property>
-			  <property name="use_underline">True</property>
-			  <property name="stock_id">gtk-zoom-in</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_disable_audit_clicked" last_modification_time="Wed, 15 Nov 2006 16:29:34 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkHBox" id="hbox11">
-		      <property name="visible">True</property>
-		      <property name="homogeneous">False</property>
-		      <property name="spacing">0</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label55">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Filter</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="padding">10</property>
-			  <property name="expand">False</property>
-			  <property name="fill">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkEntry" id="modulesFilterEntry">
-			  <property name="visible">True</property>
-			  <property name="can_focus">True</property>
-			  <property name="editable">True</property>
-			  <property name="visibility">True</property>
-			  <property name="max_length">0</property>
-			  <property name="text" translatable="yes"></property>
-			  <property name="has_frame">True</property>
-			  <property name="invisible_char">•</property>
-			  <property name="activates_default">False</property>
-			  <signal name="changed" handler="on_booleansFilter_changed" last_modification_time="Fri, 06 Apr 2007 12:39:26 GMT"/>
-			</widget>
-			<packing>
-			  <property name="padding">0</property>
-			  <property name="expand">True</property>
-			  <property name="fill">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">5</property>
-		      <property name="expand">False</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkScrolledWindow" id="scrolledwindow15">
-		      <property name="visible">True</property>
-		      <property name="can_focus">True</property>
-		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="shadow_type">GTK_SHADOW_NONE</property>
-		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
-
-		      <child>
-			<widget class="GtkTreeView" id="modulesView">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Policy Module</property>
-			  <property name="can_focus">True</property>
-			  <property name="headers_visible">True</property>
-			  <property name="rules_hint">False</property>
-			  <property name="reorderable">False</property>
-			  <property name="enable_search">True</property>
-			  <property name="fixed_height_mode">False</property>
-			  <property name="hover_selection">False</property>
-			  <property name="hover_expand">False</property>
-			</widget>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label44">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label44</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkVBox" id="vbox19">
-		  <property name="visible">True</property>
-		  <property name="homogeneous">False</property>
-		  <property name="spacing">0</property>
-
-		  <child>
-		    <widget class="GtkToolbar" id="toolbar10">
-		      <property name="visible">True</property>
-		      <property name="orientation">GTK_ORIENTATION_HORIZONTAL</property>
-		      <property name="toolbar_style">GTK_TOOLBAR_BOTH</property>
-		      <property name="tooltips">True</property>
-		      <property name="show_arrow">True</property>
-
-		      <child>
-			<widget class="GtkToolButton" id="permissiveButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Change process mode to permissive.</property>
-			  <property name="label" translatable="yes">Permissive</property>
-			  <property name="use_underline">True</property>
-			  <property name="stock_id">gtk-dialog-warning</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_add_clicked" last_modification_time="Mon, 16 Jan 2006 18:27:03 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkToolButton" id="enforcingButton">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Change process mode to enforcing</property>
-			  <property name="label" translatable="yes">Enforcing</property>
-			  <property name="use_underline">True</property>
-			  <property name="stock_id">gtk-dialog-error</property>
-			  <property name="visible_horizontal">True</property>
-			  <property name="visible_vertical">True</property>
-			  <property name="is_important">False</property>
-			  <signal name="clicked" handler="on_delete_clicked" last_modification_time="Mon, 16 Jan 2006 18:26:29 GMT"/>
-			</widget>
-			<packing>
-			  <property name="expand">False</property>
-			  <property name="homogeneous">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">False</property>
-		      <property name="fill">False</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkHBox" id="hbox15">
-		      <property name="visible">True</property>
-		      <property name="homogeneous">False</property>
-		      <property name="spacing">0</property>
-
-		      <child>
-			<widget class="GtkLabel" id="label60">
-			  <property name="visible">True</property>
-			  <property name="label" translatable="yes">Filter</property>
-			  <property name="use_underline">False</property>
-			  <property name="use_markup">False</property>
-			  <property name="justify">GTK_JUSTIFY_LEFT</property>
-			  <property name="wrap">False</property>
-			  <property name="selectable">False</property>
-			  <property name="xalign">0.5</property>
-			  <property name="yalign">0.5</property>
-			  <property name="xpad">0</property>
-			  <property name="ypad">0</property>
-			  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-			  <property name="width_chars">-1</property>
-			  <property name="single_line_mode">False</property>
-			  <property name="angle">0</property>
-			</widget>
-			<packing>
-			  <property name="padding">10</property>
-			  <property name="expand">False</property>
-			  <property name="fill">False</property>
-			</packing>
-		      </child>
-
-		      <child>
-			<widget class="GtkEntry" id="domainsFilterEntry">
-			  <property name="visible">True</property>
-			  <property name="can_focus">True</property>
-			  <property name="editable">True</property>
-			  <property name="visibility">True</property>
-			  <property name="max_length">0</property>
-			  <property name="text" translatable="yes"></property>
-			  <property name="has_frame">True</property>
-			  <property name="invisible_char">•</property>
-			  <property name="activates_default">False</property>
-			  <signal name="changed" handler="on_booleansFilter_changed" last_modification_time="Fri, 06 Apr 2007 12:39:26 GMT"/>
-			</widget>
-			<packing>
-			  <property name="padding">0</property>
-			  <property name="expand">True</property>
-			  <property name="fill">True</property>
-			</packing>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">5</property>
-		      <property name="expand">False</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-
-		  <child>
-		    <widget class="GtkScrolledWindow" id="scrolledwindow20">
-		      <property name="visible">True</property>
-		      <property name="can_focus">True</property>
-		      <property name="hscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="vscrollbar_policy">GTK_POLICY_ALWAYS</property>
-		      <property name="shadow_type">GTK_SHADOW_NONE</property>
-		      <property name="window_placement">GTK_CORNER_TOP_LEFT</property>
-
-		      <child>
-			<widget class="GtkTreeView" id="domainsView">
-			  <property name="visible">True</property>
-			  <property name="tooltip" translatable="yes">Process Domain</property>
-			  <property name="can_focus">True</property>
-			  <property name="headers_visible">True</property>
-			  <property name="rules_hint">False</property>
-			  <property name="reorderable">False</property>
-			  <property name="enable_search">True</property>
-			  <property name="fixed_height_mode">False</property>
-			  <property name="hover_selection">False</property>
-			  <property name="hover_expand">False</property>
-			</widget>
-		      </child>
-		    </widget>
-		    <packing>
-		      <property name="padding">0</property>
-		      <property name="expand">True</property>
-		      <property name="fill">True</property>
-		    </packing>
-		  </child>
-		</widget>
-		<packing>
-		  <property name="tab_expand">False</property>
-		  <property name="tab_fill">True</property>
-		</packing>
-	      </child>
-
-	      <child>
-		<widget class="GtkLabel" id="label59">
-		  <property name="visible">True</property>
-		  <property name="label" translatable="yes">label59</property>
-		  <property name="use_underline">False</property>
-		  <property name="use_markup">False</property>
-		  <property name="justify">GTK_JUSTIFY_LEFT</property>
-		  <property name="wrap">False</property>
-		  <property name="selectable">False</property>
-		  <property name="xalign">0.5</property>
-		  <property name="yalign">0.5</property>
-		  <property name="xpad">0</property>
-		  <property name="ypad">0</property>
-		  <property name="ellipsize">PANGO_ELLIPSIZE_NONE</property>
-		  <property name="width_chars">-1</property>
-		  <property name="single_line_mode">False</property>
-		  <property name="angle">0</property>
-		</widget>
-		<packing>
-		  <property name="type">tab</property>
-		</packing>
-	      </child>
-	    </widget>
-	    <packing>
-	      <property name="shrink">True</property>
-	      <property name="resize">True</property>
-	    </packing>
-	  </child>
-	</widget>
-      </child>
-    </widget>
-    <packing>
-      <property name="padding">0</property>
-      <property name="expand">True</property>
-      <property name="fill">True</property>
-    </packing>
-  </child>
-
-  <child internal-child="appbar">
-    <widget class="GnomeAppBar" id="appbar2">
-      <property name="visible">True</property>
-      <property name="has_progress">True</property>
-      <property name="has_status">True</property>
-    </widget>
-    <packing>
-      <property name="padding">0</property>
-      <property name="expand">True</property>
-      <property name="fill">True</property>
-    </packing>
-  </child>
-</widget>
-
-</glade-interface>
diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
index ed41e981efb1..ce7c74b1333c 100644
--- a/gui/system-config-selinux.py
+++ b/gui/system-config-selinux.py
@@ -20,20 +20,19 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 #
+import os
 import signal
-import string
 import sys
+import gi
+gi.require_version('Gtk', '3.0')
 try:
-    import gtk
+    from gi.repository import Gtk
 except RuntimeError as e:
     print("system-config-selinux:", e)
     print("This is a graphical application and requires DISPLAY to be set.")
     sys.exit(1)
 
-import gtk.glade
-import os
-import gobject
-import gnome
+from gi.repository import GObject
 import statusPage
 import booleansPage
 import loginsPage
@@ -64,8 +63,6 @@ except:
         import __builtin__
         __builtin__.__dict__['_'] = unicode
 
-gnome.program_init("SELinux Management Tool", "5")
-
 version = "1.0"
 
 sys.path.append('/usr/share/system-config-selinux')
@@ -74,10 +71,12 @@ sys.path.append('/usr/share/system-config-selinux')
 ##
 ## Pull in the Glade file
 ##
-if os.access("system-config-selinux.glade", os.F_OK):
-    xml = gtk.glade.XML("system-config-selinux.glade", domain=PROGNAME)
+xml = Gtk.Builder()
+xml.set_translation_domain(PROGNAME)
+if os.access("system-config-selinux.ui", os.F_OK):
+    xml.add_from_file("system-config-selinux.ui")
 else:
-    xml = gtk.glade.XML("/usr/share/system-config-selinux/system-config-selinux.glade", domain=PROGNAME)
+    xml.add_from_file("/usr/share/system-config-selinux/system-config-selinux.ui")
 
 
 class childWindow:
@@ -85,11 +84,16 @@ class childWindow:
     def __init__(self):
         self.tabs = []
         self.xml = xml
-        xml.signal_connect("on_quit_activate", self.destroy)
-        xml.signal_connect("on_delete_clicked", self.delete)
-        xml.signal_connect("on_add_clicked", self.add)
-        xml.signal_connect("on_properties_clicked", self.properties)
-        xml.signal_connect("on_local_clicked", self.on_local_clicked)
+        xml.connect_signals({
+            "on_quit_activate": self.destroy,
+            "on_delete_clicked": self.delete,
+            "on_add_clicked": self.add,
+            "on_properties_clicked": self.properties,
+            "on_local_clicked": self.on_local_clicked,
+            "on_policy_activate": self.policy,
+            "on_logging_activate": self.logging,
+            "on_about_activate": self.on_about_activate,
+        })
         self.add_page(statusPage.statusPage(xml))
         if selinux.is_selinux_enabled() > 0:
             try:
@@ -103,20 +107,15 @@ class childWindow:
             except ValueError as e:
                 self.error(e.message)
 
-        xml.signal_connect("on_quit_activate", self.destroy)
-        xml.signal_connect("on_policy_activate", self.policy)
-        xml.signal_connect("on_logging_activate", self.logging)
-        xml.signal_connect("on_about_activate", self.on_about_activate)
-
-        self.add_menu = xml.get_widget("add_menu_item")
-        self.properties_menu = xml.get_widget("properties_menu_item")
-        self.delete_menu = xml.get_widget("delete_menu_item")
+        self.add_menu = xml.get_object("add_menu_item")
+        self.properties_menu = xml.get_object("properties_menu_item")
+        self.delete_menu = xml.get_object("delete_menu_item")
 
     def error(self, message):
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_ERROR,
-                                gtk.BUTTONS_CLOSE,
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.ERROR,
+                                Gtk.ButtonsType.CLOSE,
                                 message)
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         dlg.run()
         dlg.destroy()
@@ -143,12 +142,12 @@ class childWindow:
         self.tabs[self.notebook.get_current_page()].on_local_clicked(button)
 
     def on_about_activate(self, args):
-        dlg = xml.get_widget("aboutWindow")
+        dlg = xml.get_object("aboutWindow")
         dlg.run()
         dlg.hide()
 
     def destroy(self, args):
-        gtk.main_quit()
+        Gtk.main_quit()
 
     def use_menus(self, use_menus):
         self.add_menu.set_sensitive(use_menus)
@@ -166,13 +165,13 @@ class childWindow:
 
     def setupScreen(self):
         # Bring in widgets from glade file.
-        self.mainWindow = self.xml.get_widget("mainWindow")
-        self.notebook = self.xml.get_widget("notebook")
-        self.view = self.xml.get_widget("selectView")
+        self.mainWindow = self.xml.get_object("mainWindow")
+        self.notebook = self.xml.get_object("notebook")
+        self.view = self.xml.get_object("selectView")
         self.view.get_selection().connect("changed", self.itemSelected)
-        self.store = gtk.ListStore(gobject.TYPE_STRING)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING)
         self.view.set_model(self.store)
-        col = gtk.TreeViewColumn("", gtk.CellRendererText(), text=0)
+        col = Gtk.TreeViewColumn("", Gtk.CellRendererText(), text=0)
         col.set_resizable(True)
         self.view.append_column(col)
 
@@ -189,7 +188,7 @@ class childWindow:
         self.mainWindow.connect("destroy", self.destroy)
 
         self.mainWindow.show_all()
-        gtk.main()
+        Gtk.main()
 
 if __name__ == "__main__":
     signal.signal(signal.SIGINT, signal.SIG_DFL)
diff --git a/gui/system-config-selinux.ui b/gui/system-config-selinux.ui
new file mode 100644
index 000000000000..c3f261a10d8d
--- /dev/null
+++ b/gui/system-config-selinux.ui
@@ -0,0 +1,2043 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!-- Generated with glade 3.20.0 -->
+<!--*- mode: xml -*-->
+<interface>
+  <requires lib="gtk+" version="3.0"/>
+  <object class="GtkAboutDialog" id="aboutWindow">
+    <property name="name">system-config-selinux</property>
+    <property name="can_focus">False</property>
+    <property name="border_width">5</property>
+    <property name="type_hint">normal</property>
+    <property name="copyright" translatable="yes">Copyright (c)2006 Red Hat, Inc.
+Copyright (c) 2006 Dan Walsh &lt;dwalsh@redhat.com&gt;</property>
+    <property name="authors">Daniel Walsh &lt;dwalsh@redhat.com&gt;
+</property>
+    <property name="translator_credits" translatable="yes" comments="TRANSLATORS: Replace this string with your names, one name per line.">translator-credits</property>
+    <property name="logo">system-config-selinux.png</property>
+    <child internal-child="vbox">
+      <object class="GtkBox">
+        <property name="can_focus">False</property>
+        <child internal-child="action_area">
+          <object class="GtkButtonBox">
+            <property name="can_focus">False</property>
+          </object>
+          <packing>
+            <property name="expand">False</property>
+            <property name="fill">False</property>
+            <property name="position">0</property>
+          </packing>
+        </child>
+      </object>
+    </child>
+    <child>
+      <placeholder/>
+    </child>
+  </object>
+  <object class="GtkImage" id="image13">
+    <property name="visible">True</property>
+    <property name="can_focus">False</property>
+    <property name="stock">gtk-add</property>
+  </object>
+  <object class="GtkImage" id="image14">
+    <property name="visible">True</property>
+    <property name="can_focus">False</property>
+    <property name="stock">gtk-properties</property>
+  </object>
+  <object class="GtkImage" id="image15">
+    <property name="visible">True</property>
+    <property name="can_focus">False</property>
+    <property name="stock">gtk-delete</property>
+  </object>
+  <object class="GtkDialog" id="loginsDialog">
+    <property name="can_focus">False</property>
+    <property name="title" translatable="yes">Add SELinux Login Mapping</property>
+    <property name="type_hint">dialog</property>
+    <child internal-child="vbox">
+      <object class="GtkBox" id="dialog-vbox1">
+        <property name="visible">True</property>
+        <property name="can_focus">False</property>
+        <child internal-child="action_area">
+          <object class="GtkButtonBox" id="dialog-action_area1">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="layout_style">end</property>
+            <child>
+              <object class="GtkButton" id="cancelbutton1">
+                <property name="label">gtk-cancel</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+            <child>
+              <object class="GtkButton" id="okbutton1">
+                <property name="label">gtk-ok</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">1</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">False</property>
+            <property name="fill">True</property>
+            <property name="pack_type">end</property>
+            <property name="position">0</property>
+          </packing>
+        </child>
+        <child>
+          <object class="GtkBox" id="vbox2">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="orientation">vertical</property>
+            <child>
+              <object class="GtkGrid" id="table1">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="row_spacing">4</property>
+                <property name="column_spacing">6</property>
+                <child>
+                  <object class="GtkLabel" id="label15">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">Login Name</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label16">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">SELinux User</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label17">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">MLS/MCS Range</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="loginsNameEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkComboBoxText" id="loginsSelinuxUserCombo">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="loginsMLSEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="padding">5</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">True</property>
+            <property name="fill">True</property>
+            <property name="position">1</property>
+          </packing>
+        </child>
+      </object>
+    </child>
+    <action-widgets>
+      <action-widget response="-6">cancelbutton1</action-widget>
+      <action-widget response="-5">okbutton1</action-widget>
+    </action-widgets>
+    <child>
+      <placeholder/>
+    </child>
+  </object>
+  <object class="GtkListStore" id="model1">
+    <columns>
+      <!-- column-name gchararray -->
+      <column type="gchararray"/>
+    </columns>
+    <data>
+      <row>
+        <col id="0">tcp</col>
+      </row>
+      <row>
+        <col id="0">udp</col>
+      </row>
+    </data>
+  </object>
+  <object class="GtkDialog" id="portsDialog">
+    <property name="can_focus">False</property>
+    <property name="title" translatable="yes">Add SELinux Network Ports</property>
+    <property name="type_hint">dialog</property>
+    <child internal-child="vbox">
+      <object class="GtkBox" id="vbox3">
+        <property name="visible">True</property>
+        <property name="can_focus">False</property>
+        <child internal-child="action_area">
+          <object class="GtkButtonBox" id="hbuttonbox1">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="layout_style">end</property>
+            <child>
+              <object class="GtkButton" id="button1">
+                <property name="label">gtk-cancel</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+            <child>
+              <object class="GtkButton" id="button2">
+                <property name="label">gtk-ok</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">1</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">False</property>
+            <property name="fill">True</property>
+            <property name="pack_type">end</property>
+            <property name="position">0</property>
+          </packing>
+        </child>
+        <child>
+          <object class="GtkBox" id="vbox4">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="orientation">vertical</property>
+            <child>
+              <object class="GtkGrid" id="table2">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="row_spacing">4</property>
+                <property name="column_spacing">6</property>
+                <child>
+                  <object class="GtkLabel" id="label18">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">Port Number</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label19">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">Protocol</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label20">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">SELinux Type</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="portsNumberEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkComboBox" id="portsProtocolCombo">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="model">model1</property>
+                    <child>
+                      <object class="GtkCellRendererText" id="renderer1"/>
+                      <attributes>
+                        <attribute name="text">0</attribute>
+                      </attributes>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="portsNameEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label21">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">MLS/MCS
+Level</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">3</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="portsMLSEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">3</property>
+                  </packing>
+                </child>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="padding">5</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">True</property>
+            <property name="fill">True</property>
+            <property name="position">1</property>
+          </packing>
+        </child>
+      </object>
+    </child>
+    <action-widgets>
+      <action-widget response="-6">button1</action-widget>
+      <action-widget response="-5">button2</action-widget>
+    </action-widgets>
+    <child>
+      <placeholder/>
+    </child>
+  </object>
+  <object class="GtkListStore" id="model2">
+    <columns>
+      <!-- column-name gchararray -->
+      <column type="gchararray"/>
+    </columns>
+    <data>
+      <row>
+        <col id="0" translatable="yes">all files</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">regular file</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">directory</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">character device</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">block device</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">socket file</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">symbolic link</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">named pipe</col>
+      </row>
+    </data>
+  </object>
+  <object class="GtkDialog" id="fcontextDialog">
+    <property name="can_focus">False</property>
+    <property name="title" translatable="yes">Add SELinux Login Mapping</property>
+    <property name="type_hint">dialog</property>
+    <child internal-child="vbox">
+      <object class="GtkBox" id="vbox7">
+        <property name="visible">True</property>
+        <property name="can_focus">False</property>
+        <child internal-child="action_area">
+          <object class="GtkButtonBox" id="hbuttonbox3">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="layout_style">end</property>
+            <child>
+              <object class="GtkButton" id="button5">
+                <property name="label">gtk-cancel</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+            <child>
+              <object class="GtkButton" id="button6">
+                <property name="label">gtk-ok</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">1</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">False</property>
+            <property name="fill">True</property>
+            <property name="pack_type">end</property>
+            <property name="position">0</property>
+          </packing>
+        </child>
+        <child>
+          <object class="GtkBox" id="vbox8">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="orientation">vertical</property>
+            <child>
+              <object class="GtkGrid" id="table4">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="row_spacing">4</property>
+                <property name="column_spacing">6</property>
+                <child>
+                  <object class="GtkLabel" id="label25">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">File Specification</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label26">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">File Type</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label27">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">SELinux Type</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="fcontextEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkComboBox" id="fcontextFileTypeCombo">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="model">model2</property>
+                    <child>
+                      <object class="GtkCellRendererText" id="renderer2"/>
+                      <attributes>
+                        <attribute name="text">0</attribute>
+                      </attributes>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="fcontextTypeEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label31">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">MLS</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">3</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="fcontextMLSEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">3</property>
+                  </packing>
+                </child>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="padding">5</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">True</property>
+            <property name="fill">True</property>
+            <property name="position">1</property>
+          </packing>
+        </child>
+      </object>
+    </child>
+    <action-widgets>
+      <action-widget response="-6">button5</action-widget>
+      <action-widget response="-5">button6</action-widget>
+    </action-widgets>
+    <child>
+      <placeholder/>
+    </child>
+  </object>
+  <object class="GtkListStore" id="model3">
+    <columns>
+      <!-- column-name gchararray -->
+      <column type="gchararray"/>
+    </columns>
+    <data>
+      <row>
+        <col id="0" translatable="yes">Disabled</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">Permissive</col>
+      </row>
+      <row>
+        <col id="0" translatable="yes">Enforcing</col>
+      </row>
+    </data>
+  </object>
+  <object class="GtkApplicationWindow" id="mainWindow">
+    <property name="can_focus">False</property>
+    <property name="title" translatable="yes">SELinux Administration</property>
+    <property name="default_width">800</property>
+    <property name="default_height">500</property>
+    <property name="icon">system-config-selinux.png</property>
+    <child>
+      <object class="GtkBox">
+        <property name="visible">True</property>
+        <property name="can_focus">False</property>
+        <property name="orientation">vertical</property>
+        <child>
+          <object class="GtkMenuBar" id="menubar1">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <child>
+              <object class="GtkMenuItem" id="file1">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="label" translatable="yes">_File</property>
+                <property name="use_underline">True</property>
+                <child type="submenu">
+                  <object class="GtkMenu" id="file1_menu">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <child>
+                      <object class="GtkImageMenuItem" id="add_menu_item">
+                        <property name="label" translatable="yes">_Add</property>
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="use_underline">True</property>
+                        <property name="image">image13</property>
+                        <property name="use_stock">False</property>
+                        <signal name="activate" handler="on_add_clicked" swapped="no"/>
+                        <accelerator key="a" signal="activate" modifiers="GDK_CONTROL_MASK"/>
+                      </object>
+                    </child>
+                    <child>
+                      <object class="GtkImageMenuItem" id="properties_menu_item">
+                        <property name="label" translatable="yes">_Properties</property>
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="use_underline">True</property>
+                        <property name="image">image14</property>
+                        <property name="use_stock">False</property>
+                        <signal name="activate" handler="on_properties_clicked" swapped="no"/>
+                        <accelerator key="p" signal="activate" modifiers="GDK_CONTROL_MASK"/>
+                      </object>
+                    </child>
+                    <child>
+                      <object class="GtkImageMenuItem" id="delete_menu_item">
+                        <property name="label" translatable="yes">_Delete</property>
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="use_underline">True</property>
+                        <property name="image">image15</property>
+                        <property name="use_stock">False</property>
+                        <accelerator key="Delete" signal="activate"/>
+                      </object>
+                    </child>
+                    <child>
+                      <object class="GtkImageMenuItem" id="quit">
+                        <property name="label">gtk-quit</property>
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="use_underline">True</property>
+                        <property name="use_stock">True</property>
+                        <signal name="activate" handler="on_quit_activate" swapped="no"/>
+                      </object>
+                    </child>
+                  </object>
+                </child>
+              </object>
+            </child>
+            <child>
+              <object class="GtkMenuItem" id="help1">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="label" translatable="yes">_Help</property>
+                <property name="use_underline">True</property>
+                <child type="submenu">
+                  <object class="GtkMenu" id="help1_menu">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <child>
+                      <object class="GtkImageMenuItem" id="about">
+                        <property name="label">gtk-about</property>
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="use_underline">True</property>
+                        <property name="use_stock">True</property>
+                        <signal name="activate" handler="on_about_activate" swapped="no"/>
+                      </object>
+                    </child>
+                  </object>
+                </child>
+              </object>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">False</property>
+            <property name="fill">True</property>
+            <property name="position">0</property>
+          </packing>
+        </child>
+        <child>
+          <object class="GtkPaned" id="hpaned1">
+            <property name="visible">True</property>
+            <property name="can_focus">True</property>
+            <child>
+              <object class="GtkFrame" id="frame1">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="border_width">5</property>
+                <property name="label_xalign">0</property>
+                <property name="shadow_type">none</property>
+                <child>
+                  <object class="GtkAlignment" id="alignment1">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="left_padding">12</property>
+                    <child>
+                      <object class="GtkTreeView" id="selectView">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="tooltip_text" translatable="yes">Select Management Object</property>
+                        <property name="headers_visible">False</property>
+                        <child internal-child="selection">
+                          <object class="GtkTreeSelection"/>
+                        </child>
+                      </object>
+                    </child>
+                  </object>
+                </child>
+                <child type="label">
+                  <object class="GtkLabel" id="label45">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">&lt;b&gt;Select:&lt;/b&gt;</property>
+                    <property name="use_markup">True</property>
+                  </object>
+                </child>
+              </object>
+              <packing>
+                <property name="resize">True</property>
+                <property name="shrink">False</property>
+              </packing>
+            </child>
+            <child>
+              <object class="GtkNotebook" id="notebook">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="show_tabs">False</property>
+                <child>
+                  <object class="GtkBox" id="vbox1">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkGrid" id="table6">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="row_spacing">5</property>
+                        <property name="column_spacing">5</property>
+                        <child>
+                          <object class="GtkLabel" id="label29">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">System Default Enforcing Mode</property>
+                          </object>
+                          <packing>
+                            <property name="left_attach">0</property>
+                            <property name="top_attach">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkComboBox" id="enabledOptionMenu">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="hexpand">True</property>
+                            <property name="model">model3</property>
+                            <child>
+                              <object class="GtkCellRendererText" id="renderer3"/>
+                              <attributes>
+                                <attribute name="text">0</attribute>
+                              </attributes>
+                            </child>
+                          </object>
+                          <packing>
+                            <property name="left_attach">1</property>
+                            <property name="top_attach">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkLabel" id="label48">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Current Enforcing Mode</property>
+                          </object>
+                          <packing>
+                            <property name="left_attach">0</property>
+                            <property name="top_attach">1</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkComboBoxText" id="currentOptionMenu">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="hexpand">True</property>
+                          </object>
+                          <packing>
+                            <property name="left_attach">1</property>
+                            <property name="top_attach">1</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkLabel" id="typeLabel">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">System Default Policy Type: </property>
+                          </object>
+                          <packing>
+                            <property name="left_attach">0</property>
+                            <property name="top_attach">2</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkComboBoxText" id="selinuxTypeOptionMenu">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="hexpand">True</property>
+                          </object>
+                          <packing>
+                            <property name="left_attach">1</property>
+                            <property name="top_attach">2</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkCheckButton" id="relabelCheckbutton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="receives_default">False</property>
+                            <property name="tooltip_text" translatable="yes">Select if you wish to relabel then entire file system on next reboot.  Relabeling can take a very long time, depending on the size of the system.  If you are changing policy types or going from disabled to enforcing, a relabel is required.</property>
+                            <property name="hexpand">False</property>
+                            <property name="draw_indicator">True</property>
+                            <child>
+                              <object class="GtkAlignment" id="alignment4">
+                                <property name="visible">True</property>
+                                <property name="can_focus">False</property>
+                                <property name="hexpand">True</property>
+                                <property name="xscale">0</property>
+                                <property name="yscale">0</property>
+                                <child>
+                                  <object class="GtkBox" id="hbox6">
+                                    <property name="visible">True</property>
+                                    <property name="can_focus">False</property>
+                                    <property name="hexpand">True</property>
+                                    <property name="spacing">2</property>
+                                    <child>
+                                      <object class="GtkImage" id="image2">
+                                        <property name="visible">True</property>
+                                        <property name="can_focus">False</property>
+                                        <property name="stock">gtk-refresh</property>
+                                      </object>
+                                      <packing>
+                                        <property name="expand">False</property>
+                                        <property name="fill">False</property>
+                                        <property name="position">0</property>
+                                      </packing>
+                                    </child>
+                                    <child>
+                                      <object class="GtkLabel" id="label49">
+                                        <property name="visible">True</property>
+                                        <property name="can_focus">False</property>
+                                        <property name="label" translatable="yes">Relabel on next reboot.</property>
+                                        <property name="use_underline">True</property>
+                                      </object>
+                                      <packing>
+                                        <property name="expand">False</property>
+                                        <property name="fill">False</property>
+                                        <property name="position">1</property>
+                                      </packing>
+                                    </child>
+                                  </object>
+                                </child>
+                              </object>
+                            </child>
+                          </object>
+                          <packing>
+                            <property name="left_attach">0</property>
+                            <property name="top_attach">3</property>
+                            <property name="width">2</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="pack_type">end</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                  </object>
+                </child>
+                <child>
+                  <object class="GtkBox" id="vbox18">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkToolbar" id="toolbar9">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="toolbar_style">both</property>
+                        <child>
+                          <object class="GtkToolButton" id="booleanRevertButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Revert boolean setting to system default</property>
+                            <property name="stock_id">gtk-revert-to-saved</property>
+                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton34">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Toggle between Customized and All Booleans</property>
+                            <property name="label" translatable="yes">Customized</property>
+                            <property name="use_underline">True</property>
+                            <property name="stock_id">gtk-find</property>
+                            <signal name="clicked" handler="on_local_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkBox" id="hbox7">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <child>
+                          <object class="GtkLabel" id="label51">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Filter</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="fill">False</property>
+                            <property name="padding">10</property>
+                            <property name="position">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkEntry" id="booleansFilter">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="invisible_char">•</property>
+                          </object>
+                          <packing>
+                            <property name="expand">True</property>
+                            <property name="fill">True</property>
+                            <property name="position">1</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">True</property>
+                        <property name="padding">10</property>
+                        <property name="position">1</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkScrolledWindow" id="scrolledwindow18">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="hscrollbar_policy">always</property>
+                        <property name="vscrollbar_policy">always</property>
+                        <child>
+                          <object class="GtkTreeView" id="booleansView">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="tooltip_text" translatable="yes">Boolean</property>
+                            <child internal-child="selection">
+                              <object class="GtkTreeSelection"/>
+                            </child>
+                          </object>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="position">2</property>
+                      </packing>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="position">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkBox" id="vbox11">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkToolbar" id="toolbar2">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="toolbar_style">both</property>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton5">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Add File Context</property>
+                            <property name="stock_id">gtk-add</property>
+                            <signal name="clicked" handler="on_add_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton6">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Modify File Context</property>
+                            <property name="stock_id">gtk-properties</property>
+                            <signal name="clicked" handler="on_properties_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton7">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Delete File Context</property>
+                            <property name="stock_id">gtk-delete</property>
+                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="customizedButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Toggle between all and customized file context</property>
+                            <property name="label" translatable="yes">Customized</property>
+                            <property name="use_underline">True</property>
+                            <property name="stock_id">gtk-find</property>
+                            <signal name="clicked" handler="on_local_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkBox" id="hbox14">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <child>
+                          <object class="GtkLabel" id="label58">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Filter</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="fill">False</property>
+                            <property name="padding">10</property>
+                            <property name="position">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkEntry" id="fcontextFilterEntry">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="invisible_char">•</property>
+                          </object>
+                          <packing>
+                            <property name="expand">True</property>
+                            <property name="fill">True</property>
+                            <property name="position">1</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">1</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkScrolledWindow" id="scrolledwindow19">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="hscrollbar_policy">always</property>
+                        <property name="vscrollbar_policy">always</property>
+                        <child>
+                          <object class="GtkTreeView" id="fcontextView">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="tooltip_text" translatable="yes">File Labeling</property>
+                            <child internal-child="selection">
+                              <object class="GtkTreeSelection"/>
+                            </child>
+                          </object>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="position">2</property>
+                      </packing>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="position">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkBox" id="vbox12">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkToolbar" id="toolbar3">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="toolbar_style">both</property>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton8">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Add SELinux User Mapping</property>
+                            <property name="stock_id">gtk-add</property>
+                            <signal name="clicked" handler="on_add_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton29">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Modify SELinux User Mapping</property>
+                            <property name="stock_id">gtk-properties</property>
+                            <signal name="clicked" handler="on_properties_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton10">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Delete SELinux User Mapping</property>
+                            <property name="stock_id">gtk-delete</property>
+                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkBox" id="hbox13">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <child>
+                          <object class="GtkLabel" id="label57">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Filter</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="fill">False</property>
+                            <property name="padding">10</property>
+                            <property name="position">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkEntry" id="loginsFilterEntry">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="invisible_char">•</property>
+                          </object>
+                          <packing>
+                            <property name="expand">True</property>
+                            <property name="fill">True</property>
+                            <property name="position">1</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">True</property>
+                        <property name="padding">5</property>
+                        <property name="position">1</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkScrolledWindow" id="scrolledwindow16">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="hscrollbar_policy">always</property>
+                        <property name="vscrollbar_policy">always</property>
+                        <child>
+                          <object class="GtkTreeView" id="loginsView">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="tooltip_text" translatable="yes">User Mapping</property>
+                            <child internal-child="selection">
+                              <object class="GtkTreeSelection"/>
+                            </child>
+                          </object>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="position">2</property>
+                      </packing>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="position">3</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkBox" id="vbox14">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkToolbar" id="toolbar5">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="toolbar_style">both</property>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton14">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Add User</property>
+                            <property name="stock_id">gtk-add</property>
+                            <signal name="clicked" handler="on_add_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton15">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Modify User</property>
+                            <property name="stock_id">gtk-properties</property>
+                            <signal name="clicked" handler="on_properties_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton16">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Delete User</property>
+                            <property name="stock_id">gtk-delete</property>
+                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkBox" id="hbox12">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <child>
+                          <object class="GtkLabel" id="label56">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Filter</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="fill">False</property>
+                            <property name="padding">10</property>
+                            <property name="position">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkEntry" id="usersFilterEntry">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="invisible_char">•</property>
+                          </object>
+                          <packing>
+                            <property name="expand">True</property>
+                            <property name="fill">True</property>
+                            <property name="position">1</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">True</property>
+                        <property name="padding">5</property>
+                        <property name="position">1</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkScrolledWindow" id="scrolledwindow11">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="hscrollbar_policy">always</property>
+                        <property name="vscrollbar_policy">always</property>
+                        <child>
+                          <object class="GtkTreeView" id="usersView">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="tooltip_text" translatable="yes">SELinux User</property>
+                            <child internal-child="selection">
+                              <object class="GtkTreeSelection"/>
+                            </child>
+                          </object>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="position">2</property>
+                      </packing>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="position">4</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkBox" id="vbox15">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkToolbar" id="toolbar6">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="toolbar_style">both</property>
+                        <child>
+                          <object class="GtkToolButton" id="portsAddButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Add Network Port</property>
+                            <property name="stock_id">gtk-add</property>
+                            <signal name="clicked" handler="on_add_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="portsPropertiesButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Edit Network Port</property>
+                            <property name="stock_id">gtk-properties</property>
+                            <signal name="clicked" handler="on_properties_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="portsDeleteButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Delete Network Port</property>
+                            <property name="stock_id">gtk-delete</property>
+                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolItem" id="toolitem2">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <child>
+                              <object class="GtkSeparator" id="vseparator1">
+                                <property name="width_request">32</property>
+                                <property name="visible">True</property>
+                                <property name="can_focus">False</property>
+                                <property name="orientation">vertical</property>
+                              </object>
+                            </child>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">False</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="listViewButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Toggle between Customized and All Ports</property>
+                            <property name="label" translatable="yes">Group View</property>
+                            <property name="use_underline">True</property>
+                            <property name="stock_id">gtk-indent</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton35">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Toggle between Customized and All Ports</property>
+                            <property name="label" translatable="yes">Customized</property>
+                            <property name="use_underline">True</property>
+                            <property name="stock_id">gtk-find</property>
+                            <signal name="clicked" handler="on_local_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkBox" id="hbox9">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <child>
+                          <object class="GtkLabel" id="label53">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Filter</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="fill">False</property>
+                            <property name="padding">10</property>
+                            <property name="position">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkEntry" id="portsFilterEntry">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="invisible_char">•</property>
+                          </object>
+                          <packing>
+                            <property name="expand">True</property>
+                            <property name="fill">True</property>
+                            <property name="position">1</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">True</property>
+                        <property name="padding">5</property>
+                        <property name="position">1</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkScrolledWindow" id="scrolledwindow13">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="hscrollbar_policy">always</property>
+                        <property name="vscrollbar_policy">always</property>
+                        <child>
+                          <object class="GtkTreeView" id="portsView">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="tooltip_text" translatable="yes">Network Port</property>
+                            <child internal-child="selection">
+                              <object class="GtkTreeSelection"/>
+                            </child>
+                          </object>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="position">2</property>
+                      </packing>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="position">5</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkBox" id="vbox17">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkToolbar" id="toolbar8">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="toolbar_style">both</property>
+                        <child>
+                          <object class="GtkToolButton" id="newModuleButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Generate new policy module</property>
+                            <property name="stock_id">gtk-new</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton23">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Load policy module</property>
+                            <property name="stock_id">gtk-add</property>
+                            <signal name="clicked" handler="on_add_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="toolbutton25">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Remove loadable policy module</property>
+                            <property name="stock_id">gtk-remove</property>
+                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolItem" id="toolitem3">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <child>
+                              <object class="GtkSeparator" id="vseparator2">
+                                <property name="width_request">10</property>
+                                <property name="visible">True</property>
+                                <property name="can_focus">False</property>
+                                <property name="orientation">vertical</property>
+                              </object>
+                            </child>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">False</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="enableAuditButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Enable/Disable additional audit rules, that are normally not reported in the log files.</property>
+                            <property name="label" translatable="yes">Enable Audit</property>
+                            <property name="use_underline">True</property>
+                            <property name="stock_id">gtk-zoom-in</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkBox" id="hbox11">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <child>
+                          <object class="GtkLabel" id="label55">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Filter</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="fill">False</property>
+                            <property name="padding">10</property>
+                            <property name="position">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkEntry" id="modulesFilterEntry">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="invisible_char">•</property>
+                          </object>
+                          <packing>
+                            <property name="expand">True</property>
+                            <property name="fill">True</property>
+                            <property name="position">1</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">True</property>
+                        <property name="padding">5</property>
+                        <property name="position">1</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkScrolledWindow" id="scrolledwindow15">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="hscrollbar_policy">always</property>
+                        <property name="vscrollbar_policy">always</property>
+                        <child>
+                          <object class="GtkTreeView" id="modulesView">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="tooltip_text" translatable="yes">Policy Module</property>
+                            <child internal-child="selection">
+                              <object class="GtkTreeSelection"/>
+                            </child>
+                          </object>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="position">2</property>
+                      </packing>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="position">6</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkBox" id="vbox19">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="orientation">vertical</property>
+                    <child>
+                      <object class="GtkToolbar" id="toolbar10">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <property name="toolbar_style">both</property>
+                        <child>
+                          <object class="GtkToolButton" id="permissiveButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Change process mode to permissive.</property>
+                            <property name="label" translatable="yes">Permissive</property>
+                            <property name="use_underline">True</property>
+                            <property name="stock_id">gtk-dialog-warning</property>
+                            <signal name="clicked" handler="on_add_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkToolButton" id="enforcingButton">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="tooltip_text" translatable="yes">Change process mode to enforcing</property>
+                            <property name="label" translatable="yes">Enforcing</property>
+                            <property name="use_underline">True</property>
+                            <property name="stock_id">gtk-dialog-error</property>
+                            <signal name="clicked" handler="on_delete_clicked" swapped="no"/>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="homogeneous">True</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">False</property>
+                        <property name="position">0</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkBox" id="hbox15">
+                        <property name="visible">True</property>
+                        <property name="can_focus">False</property>
+                        <child>
+                          <object class="GtkLabel" id="label60">
+                            <property name="visible">True</property>
+                            <property name="can_focus">False</property>
+                            <property name="label" translatable="yes">Filter</property>
+                          </object>
+                          <packing>
+                            <property name="expand">False</property>
+                            <property name="fill">False</property>
+                            <property name="padding">10</property>
+                            <property name="position">0</property>
+                          </packing>
+                        </child>
+                        <child>
+                          <object class="GtkEntry" id="domainsFilterEntry">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="invisible_char">•</property>
+                          </object>
+                          <packing>
+                            <property name="expand">True</property>
+                            <property name="fill">True</property>
+                            <property name="position">1</property>
+                          </packing>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">False</property>
+                        <property name="fill">True</property>
+                        <property name="padding">5</property>
+                        <property name="position">1</property>
+                      </packing>
+                    </child>
+                    <child>
+                      <object class="GtkScrolledWindow" id="scrolledwindow20">
+                        <property name="visible">True</property>
+                        <property name="can_focus">True</property>
+                        <property name="hscrollbar_policy">always</property>
+                        <property name="vscrollbar_policy">always</property>
+                        <child>
+                          <object class="GtkTreeView" id="domainsView">
+                            <property name="visible">True</property>
+                            <property name="can_focus">True</property>
+                            <property name="tooltip_text" translatable="yes">Process Domain</property>
+                            <child internal-child="selection">
+                              <object class="GtkTreeSelection"/>
+                            </child>
+                          </object>
+                        </child>
+                      </object>
+                      <packing>
+                        <property name="expand">True</property>
+                        <property name="fill">True</property>
+                        <property name="position">2</property>
+                      </packing>
+                    </child>
+                  </object>
+                  <packing>
+                    <property name="position">7</property>
+                  </packing>
+                </child>
+              </object>
+              <packing>
+                <property name="resize">True</property>
+                <property name="shrink">True</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">True</property>
+            <property name="fill">True</property>
+            <property name="position">1</property>
+          </packing>
+        </child>
+        <child>
+          <object class="GtkStatusbar">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="margin_left">10</property>
+            <property name="margin_right">10</property>
+            <property name="margin_start">10</property>
+            <property name="margin_end">10</property>
+            <property name="margin_top">6</property>
+            <property name="margin_bottom">6</property>
+            <property name="orientation">vertical</property>
+            <property name="spacing">2</property>
+          </object>
+          <packing>
+            <property name="expand">False</property>
+            <property name="fill">False</property>
+            <property name="position">2</property>
+          </packing>
+        </child>
+      </object>
+    </child>
+    <child type="titlebar">
+      <placeholder/>
+    </child>
+  </object>
+  <object class="GtkDialog" id="usersDialog">
+    <property name="can_focus">False</property>
+    <property name="title" translatable="yes">Add SELinux User</property>
+    <property name="type_hint">dialog</property>
+    <child internal-child="vbox">
+      <object class="GtkBox" id="vbox9">
+        <property name="visible">True</property>
+        <property name="can_focus">False</property>
+        <child internal-child="action_area">
+          <object class="GtkButtonBox" id="hbuttonbox4">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="layout_style">end</property>
+            <child>
+              <object class="GtkButton" id="button7">
+                <property name="label">gtk-cancel</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+            <child>
+              <object class="GtkButton" id="button8">
+                <property name="label">gtk-ok</property>
+                <property name="visible">True</property>
+                <property name="can_focus">True</property>
+                <property name="can_default">True</property>
+                <property name="receives_default">False</property>
+                <property name="use_stock">True</property>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="position">1</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">False</property>
+            <property name="fill">True</property>
+            <property name="pack_type">end</property>
+            <property name="position">0</property>
+          </packing>
+        </child>
+        <child>
+          <object class="GtkBox" id="vbox10">
+            <property name="visible">True</property>
+            <property name="can_focus">False</property>
+            <property name="orientation">vertical</property>
+            <child>
+              <object class="GtkGrid" id="table5">
+                <property name="visible">True</property>
+                <property name="can_focus">False</property>
+                <property name="row_spacing">4</property>
+                <property name="column_spacing">6</property>
+                <child>
+                  <object class="GtkLabel" id="label32">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">SELinux User</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label34">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">MLS/MCS Range</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="mlsRangeEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">1</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkLabel" id="label36">
+                    <property name="visible">True</property>
+                    <property name="can_focus">False</property>
+                    <property name="label" translatable="yes">SELinux Roles</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">0</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="selinuxRolesEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">2</property>
+                  </packing>
+                </child>
+                <child>
+                  <object class="GtkEntry" id="selinuxUserEntry">
+                    <property name="visible">True</property>
+                    <property name="can_focus">True</property>
+                    <property name="invisible_char">*</property>
+                  </object>
+                  <packing>
+                    <property name="left_attach">1</property>
+                    <property name="top_attach">0</property>
+                  </packing>
+                </child>
+              </object>
+              <packing>
+                <property name="expand">True</property>
+                <property name="fill">True</property>
+                <property name="padding">5</property>
+                <property name="position">0</property>
+              </packing>
+            </child>
+          </object>
+          <packing>
+            <property name="expand">True</property>
+            <property name="fill">True</property>
+            <property name="position">1</property>
+          </packing>
+        </child>
+      </object>
+    </child>
+    <action-widgets>
+      <action-widget response="-6">button7</action-widget>
+      <action-widget response="-5">button8</action-widget>
+    </action-widgets>
+    <child>
+      <placeholder/>
+    </child>
+  </object>
+</interface>
diff --git a/gui/usersPage.py b/gui/usersPage.py
index 75b054737088..9d09bda2171f 100644
--- a/gui/usersPage.py
+++ b/gui/usersPage.py
@@ -16,17 +16,13 @@
 ## Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
 ## Author: Dan Walsh
-import string
-import gtk
-import gtk.glade
-import os
-import gobject
 import sys
 try:
     from subprocess import getstatusoutput
 except ImportError:
     from commands import getstatusoutput
 
+from gi.repository import GObject, Gtk
 import seobject
 from semanagePage import *
 
@@ -57,27 +53,27 @@ class usersPage(semanagePage):
     def __init__(self, xml):
         semanagePage.__init__(self, xml, "users", _("SELinux User"))
 
-        self.store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_STRING)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING, GObject.TYPE_STRING)
         self.view.set_model(self.store)
-        self.store.set_sort_column_id(0, gtk.SORT_ASCENDING)
+        self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
 
-        col = gtk.TreeViewColumn(_("SELinux\nUser"), gtk.CellRendererText(), text=0)
+        col = Gtk.TreeViewColumn(_("SELinux\nUser"), Gtk.CellRendererText(), text=0)
         col.set_sort_column_id(0)
         col.set_resizable(True)
         self.view.append_column(col)
 
-        col = gtk.TreeViewColumn(_("MLS/\nMCS Range"), gtk.CellRendererText(), text=1)
+        col = Gtk.TreeViewColumn(_("MLS/\nMCS Range"), Gtk.CellRendererText(), text=1)
         col.set_resizable(True)
         self.view.append_column(col)
 
-        col = gtk.TreeViewColumn(_("SELinux Roles"), gtk.CellRendererText(), text=2)
+        col = Gtk.TreeViewColumn(_("SELinux Roles"), Gtk.CellRendererText(), text=2)
         col.set_resizable(True)
         self.view.append_column(col)
 
         self.load()
-        self.selinuxUserEntry = xml.get_widget("selinuxUserEntry")
-        self.mlsRangeEntry = xml.get_widget("mlsRangeEntry")
-        self.selinuxRolesEntry = xml.get_widget("selinuxRolesEntry")
+        self.selinuxUserEntry = xml.get_object("selinuxUserEntry")
+        self.mlsRangeEntry = xml.get_object("mlsRangeEntry")
+        self.selinuxRolesEntry = xml.get_object("selinuxRolesEntry")
 
     def load(self, filter=""):
         self.filter = filter
@@ -96,7 +92,7 @@ class usersPage(semanagePage):
         self.view.get_selection().select_path((0,))
 
     def delete(self):
-        if semanagePage.delete(self) == gtk.RESPONSE_NO:
+        if semanagePage.delete(self) == Gtk.ResponseType.NO:
             return None
 
     def dialogInit(self):
-- 
2.14.1
