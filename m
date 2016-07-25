Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6PGc4Cs026453
 for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2016 12:38:05 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B3627F744
 for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2016 16:37:11 +0000 (UTC)
From: Miroslav Vadkerti <mvadkert@redhat.com>
To: selinux@tycho.nsa.gov
Cc: linux-audit@redhat.com, Miroslav Vadkerti <mvadkert@redhat.com>
Subject: [PATCH 1/2] semanage: add auditing of changes in records
Date: Mon, 25 Jul 2016 18:37:06 +0200
Message-Id: <1469464627-2159-1-git-send-email-mvadkert@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Common Criteria requirement FMT_MSA.1 needs any configuration change
that affect enforcement of policy to be audited. This patch adds
auditing of changes in security context mappings for network ports,
interfaces, nodes and file contexts.

A new function log_change is introduced that audits additions,
modification and removal of the mappings via the USER_MAC_CONFIG_CHANGE
audit event.

The format of the audit events was discussed with the audit userspace
maintainer.

This patch resolves: https://bugzilla.redhat.com/show_bug.cgi?id=829175

Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
---
 policycoreutils/semanage/seobject.py | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 3b0b108..799ce24 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -82,6 +82,21 @@ file_type_str_to_option = {"all files": "a",
                            "socket file": "s",
                            "symbolic link": "l",
                            "named pipe": "p"}
+
+proto_to_audit = {"tcp": 17,
+                  "udp": 6,
+                  "ipv4": 4,
+                  "ipv6": 41}
+
+ftype_to_audit = {"": "any",
+                  "b": "block",
+                  "c": "char",
+                  "d": "dir",
+                  "f": "file",
+                  "l": "symlink",
+                  "p": "pipe",
+                  "s": "socket"}
+
 try:
     import audit
 
@@ -90,6 +105,7 @@ try:
         def __init__(self):
             self.audit_fd = audit.audit_open()
             self.log_list = []
+            self.log_change_list = []
 
         def log(self, msg, name="", sename="", serole="", serange="", oldsename="", oldserole="", oldserange=""):
 
@@ -109,10 +125,17 @@ try:
         def log_remove(self, msg, name="", sename="", serole="", serange="", oldsename="", oldserole="", oldserange=""):
             self.log_list.append([self.audit_fd, audit.AUDIT_ROLE_REMOVE, sys.argv[0], str(msg), name, 0, sename, serole, serange, oldsename, oldserole, oldserange, "", "", ""])
 
+        def log_change(self, msg, hostname="", addr="", tty=""):
+            self.log_change_list.append([self.audit_fd, audit.AUDIT_USER_MAC_CONFIG_CHANGE, str(msg), "semanage", hostname, addr, tty])
+
         def commit(self, success):
             for l in self.log_list:
                 audit.audit_log_semanage_message(*(l + [success]))
+            for l in self.log_change_list:
+                audit.audit_log_user_comm_message(*(l + [success]))
+
             self.log_list = []
+            self.log_change_list = []
 except:
     class logger:
 
@@ -138,6 +161,9 @@ except:
         def log_remove(self, msg, name="", sename="", serole="", serange="", oldsename="", oldserole="", oldserange=""):
             self.log(msg, name, sename, serole, serange, oldsename, oldserole, oldserange)
 
+        def log_change(self, msg, hostname="", addr="", tty=""):
+            self.log_list.append(" %s" % msg)
+
         def commit(self, success):
             if success == 1:
                 message = "Successful: "
@@ -155,6 +181,9 @@ class nulllogger:
     def log_remove(self, msg, name="", sename="", serole="", serange="", oldsename="", oldserole="", oldserange=""):
         pass
 
+    def log_change(self, msg, hostname="", addr="", tty=""):
+        pass
+
     def commit(self, success):
         pass
 
@@ -1109,6 +1138,8 @@ class portRecords(semanageRecords):
         semanage_port_key_free(k)
         semanage_port_free(p)
 
+        self.mylog.log_change("resrc=port op=add lport=%s proto=%s tcontext=%s:%s:%s:%s" % (port, proto_to_audit[proto], "system_u", "object_r", type, serange))
+
     def add(self, port, proto, serange, type):
         self.begin()
         self.__add(port, proto, serange, type)
@@ -1150,6 +1181,8 @@ class portRecords(semanageRecords):
         semanage_port_key_free(k)
         semanage_port_free(p)
 
+        self.mylog.log_change("resrc=port op=modify lport=%s proto=%s tcontext=%s:%s:%s:%s" % (port, proto_to_audit[proto], "system_u", "object_r", setype, serange))
+
     def modify(self, port, proto, serange, setype):
         self.begin()
         self.__modify(port, proto, serange, setype)
@@ -1168,6 +1201,7 @@ class portRecords(semanageRecords):
             low = semanage_port_get_low(port)
             high = semanage_port_get_high(port)
             port_str = "%s-%s" % (low, high)
+
             (k, proto_d, low, high) = self.__genkey(port_str, proto_str)
             if rc < 0:
                 raise ValueError(_("Could not create a key for %s") % port_str)
@@ -1177,6 +1211,11 @@ class portRecords(semanageRecords):
                 raise ValueError(_("Could not delete the port %s") % port_str)
             semanage_port_key_free(k)
 
+            if low == high:
+                port_str = low
+
+            self.mylog.log_change("resrc=port op=delete lport=%s proto=%s" % (port_str, proto_to_audit[proto_str]))
+
         self.commit()
 
     def __delete(self, port, proto):
@@ -1199,6 +1238,8 @@ class portRecords(semanageRecords):
 
         semanage_port_key_free(k)
 
+        self.mylog.log_change("resrc=port op=delete lport=%s proto=%s" % (port, proto_to_audit[proto]))
+
     def delete(self, port, proto):
         self.begin()
         self.__delete(port, proto)
@@ -1380,6 +1421,8 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
+        self.mylog.log_change("resrc=node op=add laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, proto_to_audit[self.protocol[proto]], "system_u", "object_r", ctype, serange))
+
     def add(self, addr, mask, proto, serange, ctype):
         self.begin()
         self.__add(addr, mask, proto, serange, ctype)
@@ -1421,6 +1464,8 @@ class nodeRecords(semanageRecords):
         semanage_node_key_free(k)
         semanage_node_free(node)
 
+        self.mylog.log_change("resrc=node op=modify laddr=%s netmask=%s proto=%s tcontext=%s:%s:%s:%s" % (addr, mask, proto_to_audit[self.protocol[proto]], "system_u", "object_r", setype, serange))
+
     def modify(self, addr, mask, proto, serange, setype):
         self.begin()
         self.__modify(addr, mask, proto, serange, setype)
@@ -1452,6 +1497,8 @@ class nodeRecords(semanageRecords):
 
         semanage_node_key_free(k)
 
+        self.mylog.log_change("resrc=node op=delete laddr=%s netmask=%s proto=%s" % (addr, mask, proto_to_audit[self.protocol[proto]]))
+
     def delete(self, addr, mask, proto):
         self.begin()
         self.__delete(addr, mask, proto)
@@ -1581,6 +1628,8 @@ class interfaceRecords(semanageRecords):
         semanage_iface_key_free(k)
         semanage_iface_free(iface)
 
+        self.mylog.log_change("resrc=interface op=add netif=%s tcontext=%s:%s:%s:%s" % (interface, "system_u", "object_r", ctype, serange))
+
     def add(self, interface, serange, ctype):
         self.begin()
         self.__add(interface, serange, ctype)
@@ -1618,6 +1667,8 @@ class interfaceRecords(semanageRecords):
         semanage_iface_key_free(k)
         semanage_iface_free(iface)
 
+        self.mylog.log_change("resrc=interface op=modify netif=%s tcontext=%s:%s:%s:%s" % (interface, "system_u", "object_r", setype, serange))
+
     def modify(self, interface, serange, setype):
         self.begin()
         self.__modify(interface, serange, setype)
@@ -1646,6 +1697,8 @@ class interfaceRecords(semanageRecords):
 
         semanage_iface_key_free(k)
 
+        self.mylog.log_change("resrc=interface op=delete netif=%s" % interface)
+
     def delete(self, interface):
         self.begin()
         self.__delete(interface)
@@ -1775,6 +1828,8 @@ class fcontextRecords(semanageRecords):
                 if i.startswith(target + "/"):
                     raise ValueError(_("File spec %s conflicts with equivalency rule '%s %s'") % (target, i, fdict[i]))
 
+        self.mylog.log_change("resrc=fcontext op=add-equal %s %s" % (audit.audit_encode_nv_string("sglob", target, 0), audit.audit_encode_nv_string("tglob", substitute, 0)))
+
         self.equiv[target] = substitute
         self.equal_ind = True
         self.commit()
@@ -1785,6 +1840,9 @@ class fcontextRecords(semanageRecords):
             raise ValueError(_("Equivalence class for %s does not exists") % target)
         self.equiv[target] = substitute
         self.equal_ind = True
+
+        self.mylog.log_change("resrc=fcontext op=modify-equal %s %s" % (audit.audit_encode_nv_string("sglob", target, 0), audit.audit_encode_nv_string("tglob", substitute, 0)))
+
         self.commit()
 
     def createcon(self, target, seuser="system_u"):
@@ -1879,6 +1937,11 @@ class fcontextRecords(semanageRecords):
         semanage_fcontext_key_free(k)
         semanage_fcontext_free(fcontext)
 
+        if not seuser:
+            seuser = "system_u"
+
+        self.mylog.log_change("resrc=fcontext op=add %s ftype=%s tcontext=%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype], seuser, "object_r", type, serange))
+
     def add(self, target, type, ftype="", serange="", seuser="system_u"):
         self.begin()
         self.__add(target, type, ftype, serange, seuser)
@@ -1939,6 +2002,11 @@ class fcontextRecords(semanageRecords):
         semanage_fcontext_key_free(k)
         semanage_fcontext_free(fcontext)
 
+        if not seuser:
+            seuser = "system_u"
+
+        self.mylog.log_change("resrc=fcontext op=modify %s ftype=%s tcontext=%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype], seuser, "object_r", type, serange))
+
     def modify(self, target, setype, ftype, serange, seuser):
         self.begin()
         self.__modify(target, setype, ftype, serange, seuser)
@@ -1964,6 +2032,8 @@ class fcontextRecords(semanageRecords):
                 raise ValueError(_("Could not delete the file context %s") % target)
             semanage_fcontext_key_free(k)
 
+            self.mylog.log_change("resrc=fcontext op=delete %s ftype=%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype_str]))
+
         self.equiv = {}
         self.equal_ind = True
         self.commit()
@@ -1972,6 +2042,9 @@ class fcontextRecords(semanageRecords):
         if target in self.equiv.keys():
             self.equiv.pop(target)
             self.equal_ind = True
+
+            self.mylog.log_change("resrc=fcontext op=delete-equal %s ftype=%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype]))
+
             return
 
         (rc, k) = semanage_fcontext_key_create(self.sh, target, file_types[ftype])
@@ -1996,6 +2069,8 @@ class fcontextRecords(semanageRecords):
 
         semanage_fcontext_key_free(k)
 
+        self.mylog.log_change("resrc=fcontext op=delete %s ftype=%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype_to_audit[ftype]))
+
     def delete(self, target, ftype):
         self.begin()
         self.__delete(target, ftype)
-- 
1.8.3.1
