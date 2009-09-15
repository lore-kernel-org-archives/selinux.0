Subject: [PATCH 3/3] sepolgen: Add support for multiple target OSes
From: pjnuzzi <pjnuzzi@tycho.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1253032632.3209.118.camel@moss-stripedbass.epoch.ncsc.mil>
References: <1253031316.3209.116.camel@moss-stripedbass.epoch.ncsc.mil>
	 <1253032632.3209.118.camel@moss-stripedbass.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 12:40:52 -0400
Message-Id: <1253032852.3209.120.camel@moss-stripedbass.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add support to sepolgen for new Xen ocontext identifiers.

Signed-off-by: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>

---
sepolgen/src/sepolgen/refparser.py |   54
+++++++++++++++++++++++++++++++++++++
sepolgen/src/sepolgen/refpolicy.py |   35 +++++++++++++++++++++++
2 files changed, 89 insertions(+)

diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index 65d1d90..23beb39 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -83,6 +83,10 @@ tokens = (
     'PORTCON',
     'NODECON',
     'NETIFCON',
+    'PIRQCON',
+    'IOMEMCON',
+    'IOPORTCON',
+    'PCIDEVICECON',
     #   object classes
     'CLASS',
     #   types and attributes
@@ -140,6 +144,10 @@ reserved = {
     'portcon' : 'PORTCON',
     'nodecon' : 'NODECON',
     'netifcon' : 'NETIFCON',
+    'pirqcon' : 'PIRQCON',
+    'iomemcon' : 'IOMEMCON',
+    'ioportcon' : 'IOPORTCON',
+    'pcidevicecon' : 'PCIDEVICECON',
     # object classes
     'class' : 'CLASS',
     # types and attributes
@@ -495,6 +503,10 @@ def p_policy_stmt(p):
                    | portcon
                    | nodecon
                    | netifcon
+                   | pirqcon
+                   | iomemcon
+                   | ioportcon
+                   | pcidevicecon
     '''
     if p[1]:
         p[0] = [p[1]]
@@ -631,6 +643,48 @@ def p_netifcon(p):
 
     p[0] = n
 
+def p_pirqcon(p):
+    'pirqcon : PIRQCON NUMBER context'
+    c = refpolicy.PirqCon()
+    c.pirq_number = p[2]
+    c.context = p[3]
+
+    p[0] = c
+
+def p_iomemcon(p):
+    '''iomemcon : IOMEMCON NUMBER context
+                | IOMEMCON NUMBER MINUS NUMBER context'''
+    c = refpolicy.IomemCon()
+    if len(p) == 4:
+        c.device_mem = p[2]
+        c.context = p[3]
+    else:
+        c.device_mem = p[2] + "-" + p[3]
+        c.context = p[4]
+
+    p[0] = c
+
+def p_ioportcon(p):
+    '''ioportcon : IOPORTCON NUMBER context
+                | IOPORTCON NUMBER MINUS NUMBER context'''
+    c = refpolicy.IoportCon()
+    if len(p) == 4:
+        c.ioport = p[2]
+        c.context = p[3]
+    else:
+        c.ioport = p[2] + "-" + p[3]
+        c.context = p[4]
+
+    p[0] = c
+
+def p_pcidevicecon(p):
+    'pcidevicecon : PCIDEVICECON NUMBER context'
+    c = refpolicy.PciDeviceCon()
+    c.device = p[2]
+    c.context = p[3]
+
+    p[0] = c
+
 def p_mls_range_def(p):
     '''mls_range_def : mls_level_def MINUS mls_level_def
                      | mls_level_def
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index 724b870..b138e3d 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -618,6 +618,41 @@ class NetifCon(Leaf):
     def to_string(self):
         return "netifcon %s %s %s" % (self.interface, str(self.interface_context),
                                    str(self.packet_context))
+class PirqCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.pirq_number = ""
+        self.context = None
+
+    def to_string(self):
+        return "pirqcon %s %s" % (self.pirq_number, str(self.context))
+
+class IomemCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.device_mem = ""
+        self.context = None
+
+    def to_string(self):
+        return "iomemcon %s %s" % (self.device_mem, str(self.context))
+
+class IoportCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.ioport = ""
+        self.context = None
+
+    def to_string(self):
+        return "ioportcon %s %s" % (self.ioport, str(self.context))
+
+class PciDeviceCon(Leaf):
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.device = ""
+        self.context = None
+
+    def to_string(self):
+        return "pcidevicecon %s %s" % (self.device, str(self.context))
 
 # Reference policy specific types
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
