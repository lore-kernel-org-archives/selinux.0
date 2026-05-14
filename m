Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E68314B96
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775584; cv=none; b=PHAwlNAaGEbEcdXhF40CPJ40HusAGpECUPnZH6YwVr+7/UxINE6o1w1jEfsLv3tcXQeFeo2sF8H8m9yViEyEQr4IP/YfaANrnhZFCIHw3quHiRWga2iTtMhZEm0tb40R93XRbfTGhE71sNgzowO+pGlGGS324TlEPBcsD3cCN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775584; c=relaxed/simple;
	bh=SgUs475W2v4Bxa5pe9ZSI7wcEjOarVTThzZ/57fY3Go=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TNsalaM2LSQU+cKyX/Bm8UdhxObxwCYT7ULKrjkbx81Lazz2kopeT8TaSSoc8FdjInHIR2y/hwSNr7sw4zLQ3SByg/d9tWlhBs+meaIRIxG2ZOl3RZcORMLD2UuZM7bJ7bVbkRujEQXApnFvIN5pfTLpa3/mwsoPr8bh7upGmtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVX0ysx1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVX0ysx1"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50faf8ed9c5so43657491cf.2
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778775582; x=1779380382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTiTc5KyiDWx6I10v9VLx7hOleHrJm/FMRrmxOISxM0=;
        b=AVX0ysx1/QhJTFauZP3iQEzsywWHXz7mKgojBUhLq5Nw+4/yaqPXQPesvsNSrxp+zq
         AYTnoc7N9ycqSWRVXVSqDiPEB6/tlUoSJPk538w89HmRwLmWDw445d+oB+SreIc6SZ9o
         BcF2/G+lDy/LIiUTYSpdrvTQakYRwAxA0Pk/JRXFUkYJ8C/9gGhUzl8jgBIsLPk5FBEe
         qnPoivnb6oXfIWNU23IJ4hpH5JqfDiDlX+kCV5idj2H/vONdVk4lJIn+meINtFqlI5Yc
         F92zkmUea6S1bkcLlsUYO8InEtj6n/q1+2x1JjRQ74bdeKj7olDPHhPjsXB0wD/ItWEQ
         thTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778775582; x=1779380382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTiTc5KyiDWx6I10v9VLx7hOleHrJm/FMRrmxOISxM0=;
        b=silSpfXJGgI3ItXAwyDr41rNwhUTuQIZqdT3BE8P1oNcfa5vn82wfYVUbvn6yFl9rn
         8xDz9Fc0xLXoqdUZYM09WtiW/KMAiSKD7pCBIB7heeUVdeEr7vlL2DFTnQrFek/Bqg0U
         hp+FIUCf8U63tpgdW8fpUwA1uFQp/uYR3ZHNU6ineYXoHU3jJIc68D5jIfUFkhmjjH7L
         upUA8fRCXLKDRwjy55djbx7BctWn/1PAT4DB8rcZOPzUkDYoeIyKHfIsfsTBI54FpDxs
         aXAQx1IYE6Kmf/MsG0YX1aiLHZ8L3DwocoKfSgQoaF2fnAHhPjgxffcTRfJAJwk0hIdb
         Nm0w==
X-Gm-Message-State: AOJu0Yw8NzN0SPfrDi54huvI4jUL90ywl+Elc0UKjVb8HX2u3bHK399J
	HPY2OROA6cKwhamY/ta0Yd1s9kQJbNOYRHBXJg6jXAD5c5Oo98WKFcc5ZhQWlA==
X-Gm-Gg: Acq92OEtp1rdgAKqdqwZq0c+lsIa4BCpNRL5pbhcbkpFHA6SFg9zQUnlyttVH9237n2
	70DUJMUY7wSzWRK04CKWQki9//PGR1HhDj3BIZ4bo73+AemBQVTnJY50t2DM2cL72tcNEaJZX/3
	AuiZ4geb3SYW5K7AuDJZgDkoH4ciN8GHokU6iiGd8eCQvZBB+I5pIsgKEa9WGvf5FNB3oLNiWSu
	xsMz4W1mm0PiJH7xWPLbJZGOPNavNehZxX+cflZcuZbJuXzore1NPfC9f4hIsJA8JPx6i+T4bVX
	A6h9tkqkjsSGO2qrKJWm8aIVu65PbI7tSWqLRfAcbrqV/bW1trOdgtU0B0paNnvm386AEEFbQzX
	zcNT24q5xA3BkdEhWfGd7AHbDfVi08b21JMHSe0gCt0zi2mHNZly9ya2rXTaysXUR+HRgQ5ymYL
	kSgWV80lpns322xxX214zz1952cAfQmRLBgFGSLo21MtskuVrnia+5J/LEvRXXan0b7gOdmbE9d
	ZtyXdxM7lHVx1O7dDWnQl0=
X-Received: by 2002:a05:622a:22a3:b0:50e:6054:bc with SMTP id d75a77b69052e-5162fe7e727mr107311371cf.16.1778775581086;
        Thu, 14 May 2026 09:19:41 -0700 (PDT)
Received: from localhost.localdomain (mvlab.jcdx.org. [128.177.73.38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d0bd6sm20939081cf.11.2026.05.14.09.19.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 May 2026 09:19:40 -0700 (PDT)
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH v1] Improve sepolicy audit log parsing.
Date: Thu, 14 May 2026 12:19:36 -0400
Message-ID: <20260514161936.55432-1-karlwmacmillan@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves audit log parsing to include more information in the
audit messages. This is restoring functionality in some ways, as it
appears that the audit message formats subtly shifted over the years
(though this is solely based on the test_audit.py messages - Google is
not yielding any information on those old PATH messages).

This is really to make the -v (verbose) output useful for policy
development by including the original audit ids (so that you can lookup
the actual audit messages if needed) and include path, exe, comm, and
other information in many more cases.

This also includes a fix for when you are running audit2allow without a
standard tty / pty (e.g., `ssh host "sudo audit2allow -al"`). Before
ausearch would assume that you were trying to read from stdin and no
output would be produced. Now we are explicit that we want to read from
the audit log.
---
 python/sepolgen/src/sepolgen/access.py    |   6 +-
 python/sepolgen/src/sepolgen/audit.py     | 344 ++++++++++++++++------
 python/sepolgen/src/sepolgen/policygen.py |  22 +-
 python/sepolgen/src/sepolgen/refparser.py |   2 +-
 python/sepolgen/tests/test_audit.py       |  15 +-
 5 files changed, 273 insertions(+), 116 deletions(-)

diff --git a/python/sepolgen/src/sepolgen/access.py b/python/sepolgen/src/sepolgen/access.py
index 791b9e85..06f2f495 100644
--- a/python/sepolgen/src/sepolgen/access.py
+++ b/python/sepolgen/src/sepolgen/access.py
@@ -163,7 +163,6 @@ class AccessVector(util.Comparison):
             # trying to compare to foreign type
             return NotImplemented
 
-
 def avrule_to_access_vectors(avrule):
     """Convert an avrule into a list of access vectors.
 
@@ -292,8 +291,7 @@ class AccessVectorSet:
         else:
             cls[av.obj_class, av.type] = av
 
-        if audit_msg:
-            cls[av.obj_class, av.type].audit_msgs.append(audit_msg)
+        cls[av.obj_class, av.type].audit_msgs.append(audit_msg)
 
 def avs_extract_types(avs):
     types = refpolicy.IdSet()
@@ -314,6 +312,8 @@ def avs_extract_obj_perms(avs):
         s.update(av.perms)
     return perms
 
+
+
 class RoleTypeSet:
     """A non-overlapping set of role type statements.
 
diff --git a/python/sepolgen/src/sepolgen/audit.py b/python/sepolgen/src/sepolgen/audit.py
index 4adb851f..386241af 100644
--- a/python/sepolgen/src/sepolgen/audit.py
+++ b/python/sepolgen/src/sepolgen/audit.py
@@ -16,7 +16,7 @@
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
-
+import binascii
 import re
 import sys
 
@@ -41,7 +41,7 @@ def get_audit_boot_msgs():
     s = time.localtime(time.time() - off)
     bootdate = time.strftime("%x", s)
     boottime = time.strftime("%X", s)
-    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START,SELINUX_ERR", "-ts", bootdate, boottime],
+    output = subprocess.Popen(["/sbin/ausearch", "--input-logs", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,MAC_CONFIG_CHANGE,PROCTITLE,CWD,DAEMON_START,SELINUX_ERR", "-ts", bootdate, boottime],
                               stdout=subprocess.PIPE).communicate()[0]
     if util.PY3:
         output = util.decode_input(output)
@@ -56,7 +56,7 @@ def get_audit_msgs():
        string contain all of the audit messages returned by ausearch.
     """
     import subprocess
-    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START,SELINUX_ERR"],
+    output = subprocess.Popen(["/sbin/ausearch", "--input-logs", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,MAC_CONFIG_CHANGE,PROCTITLE,CWD,DAEMON_START,SELINUX_ERR"],
                               stdout=subprocess.PIPE).communicate()[0]
     if util.PY3:
         output = util.decode_input(output)
@@ -84,9 +84,51 @@ class AuditMessage:
     provides storage for the raw message (as a string) and a
     parsing function that does nothing.
     """
+    AUDIT_ID_RE = re.compile(r"audit\([0-9]+\.[0-9]+:(\d+)\):")
+
     def __init__(self, message):
         self.message = message
         self.header = ""
+        self.audit_id = None
+        self.name = ""
+        self.names = []
+        self.comm = ""
+        self.cwd = ""
+        self.exe = ""
+        self.proctitle = ""
+        # This is a pointer to a list of related audit messages
+        self.related = None
+
+    def pretty_print(self):
+        """Format audit message fields into a human readable string.
+
+        Returns:
+            str: Formatted string containing non-empty message fields
+        """
+        output = []
+        for attr, value in vars(self).items():
+            if value and (attr != "message" and attr != "related"):
+                if isinstance(value, list):
+                    if value:
+                        output.append(f"{attr}: {', '.join(str(x) for x in value)}")
+                else:
+                    output.append(f"{attr}: {value}")
+        return "\n".join(output)
+
+    def __str__(self):
+        return self.pretty_print()
+
+    def __repr__(self):
+        return self.pretty_print()
+
+    def parse_header(self):
+        """Parse the audit message header and store the audit_id
+        """
+        m = AuditMessage.AUDIT_ID_RE.search(self.header)
+        if m is None:
+            return
+        self.audit_id = m.group(1)
+
 
     def from_split_string(self, recs):
         """Parse a string that has been split into records by space into
@@ -100,14 +142,35 @@ class AuditMessage:
             if len(fields) != 2:
                 if msg[:6] == "audit(":
                     self.header = msg
+                    self.parse_header()
                     return
                 else:
                     continue
             
             if fields[0] == "msg":
                 self.header = fields[1]
+                self.parse_header()
                 return
 
+    def assign_field_from_rec(self, rec, substitutions=None):
+        """Assign a field from a record to this object."""
+        fields = rec.split("=")
+        if len(fields) != 2:
+            return
+        name = fields[0]
+        if substitutions is not None and name in substitutions:
+            name = substitutions[name]
+
+        value = fields[1]
+        if value[0] == '"':
+            value = value[1:-1]
+        if hasattr(self, name):
+            setattr(self, name, value)
+
+    def assign_fields_from_recs(self, recs, substitutions=None):
+        """Assign fields from a list of records to this object."""
+        for msg in recs:
+            self.assign_field_from_rec(msg, substitutions)
 
 class InvalidMessage(AuditMessage):
     """Class representing invalid audit messages. This is used to differentiate
@@ -122,18 +185,49 @@ class PathMessage(AuditMessage):
     """Class representing a path message"""
     def __init__(self, message):
         AuditMessage.__init__(self, message)
-        self.path = ""
+        self.inode = ""
+        self.dev = ""
+        self.mode = ""
+        self.ouid = ""
+        self.ogid = ""
+        self.rdev = ""
+        self.nametype = ""
 
     def from_split_string(self, recs):
         AuditMessage.from_split_string(self, recs)
-        
-        for msg in recs:
-            fields = msg.split("=")
-            if len(fields) != 2:
-                continue
-            if fields[0] == "path":
-                self.path = fields[1][1:-1]
-                return
+        self.assign_fields_from_recs(recs, substitutions={"path":"name"})
+
+
+class SyscallMessage(AuditMessage):
+    """Class representing a syscall message"""
+    def __init__(self, message):
+        AuditMessage.__init__(self, message)
+        self.arch = ""
+        self.syscall = ""
+        self.success = ""
+        self.exit = ""
+        self.a0 = ""
+        self.a1 = ""
+        self.a2 = ""
+        self.a3 = ""
+        self.items = ""
+        self.ppid = ""
+        self.pid = ""
+        self.auid = ""
+        self.uid = ""
+        self.gid = ""
+        self.euid = ""
+        self.suid = ""
+        self.fsuid = ""
+        self.tty = ""
+        self.ses = ""
+        self.key = ""
+
+    def from_split_string(self, recs):
+        AuditMessage.from_split_string(self, recs)
+        self.assign_fields_from_recs(recs)
+
+
 import selinux.audit2why as audit2why
 
 avcdict = {}
@@ -170,14 +264,11 @@ class AVCMessage(AuditMessage):
     """
     def __init__(self, message):
         AuditMessage.__init__(self, message)
-        self.scontext = refpolicy.SecurityContext()
-        self.tcontext = refpolicy.SecurityContext()
-        self.tclass = ""
+        self.scontext = None
+        self.tcontext = None
+        self.tclass = None
         self.comm = ""
-        self.exe = ""
-        self.path = ""
-        self.name = ""
-        self.accesses = []
+        self.accesses = None
         self.denial = True
         self.ioctlcmd = None
         self.type = audit2why.TERULE
@@ -189,6 +280,7 @@ class AVCMessage(AuditMessage):
         # position one beyond the open brace. It then adds the accesses until it finds
         # the close brace or the end of the list (which is an error if reached without
         # seeing a close brace).
+        self.accesses = []
         found_close = False
         i = start
         if i == (len(recs) - 1):
@@ -208,18 +300,14 @@ class AVCMessage(AuditMessage):
         AuditMessage.from_split_string(self, recs)        
         # FUTURE - fully parse avc messages and store all possible fields
         # Required fields
-        found_src = False
-        found_tgt = False
-        found_class = False
-        found_access = False
-        
+
         for i in range(len(recs)):
             if recs[i] == "{":
                 i = self.__parse_access(recs, i + 1)
-                found_access = True
                 continue
             elif recs[i] == "granted":
                 self.denial = False
+                continue
             
             fields = recs[i].split("=")
             if len(fields) != 2:
@@ -230,22 +318,15 @@ class AVCMessage(AuditMessage):
             elif fields[0] == "tcontext":
                 self.tcontext = refpolicy.SecurityContext(fields[1])
                 found_tgt = True
-            elif fields[0] == "tclass":
-                self.tclass = fields[1]
-                found_class = True
-            elif fields[0] == "comm":
-                self.comm = fields[1][1:-1]
-            elif fields[0] == "exe":
-                self.exe = fields[1][1:-1]
-            elif fields[0] == "name":
-                self.name = fields[1][1:-1]
             elif fields[0] == "ioctlcmd":
                 try:
                     self.ioctlcmd = int(fields[1], 16)
                 except ValueError:
                     pass
+            else:
+                self.assign_field_from_rec(recs[i], substitutions={"path":"name"})
 
-        if not found_src or not found_tgt or not found_class or not found_access:
+        if not self.scontext or not self.tcontext or not self.tclass or not self.accesses:
             raise ValueError("AVC message in invalid format [%s]\n" % self.message)
         self.analyze()
 
@@ -284,9 +365,22 @@ class AVCMessage(AuditMessage):
             avcdict[(scontext, tcontext, self.tclass, access_tuple)] = (self.type, self.data)
 
 class PolicyLoadMessage(AuditMessage):
-    """Audit message indicating that the policy was reloaded."""
+    """Audit message indicating that the policy was reloaded. Also used for MAC_CONFIG_CHANGE."""
     def __init__(self, message):
         AuditMessage.__init__(self, message)
+        self.auid = ""
+        self.old_enforcing = ""
+        self.new_enforcing = ""
+        self.op = ""
+        self.old_policyload = ""
+        self.new_policyload = ""
+        self.old_bool = ""
+        self.new_bool = ""
+        self.old_value = ""
+        self.new_value = ""
+        self.key = ""
+        self.subj = ""
+
 
 class DaemonStartMessage(AuditMessage):
     """Audit message indicating that a daemon was started."""
@@ -331,7 +425,33 @@ class ComputeSidMessage(AuditMessage):
             raise ValueError("Split string does not represent a valid compute sid message")
     def output(self):
         return "role %s types %s;\n" % (self.role, self.type)
-        
+
+class Proctitle(AuditMessage):
+    def __init__(self, message):
+        AuditMessage.__init__(self, message)
+
+    def decode_proctitle(self, hexstr):
+        data = binascii.unhexlify(hexstr)
+        parts = data.split(b'\x00')
+        args = [p.decode('utf-8', errors='replace') for p in parts if p]
+        return " ".join(args)
+
+    def from_split_string(self, recs):
+        AuditMessage.from_split_string(self, recs)
+        for i in range(len(recs)):
+            rec = recs[i]
+            if rec.startswith("proctitle="):
+                self.proctitle = self.decode_proctitle(rec.split("=")[1])
+                break
+
+class CWD(AuditMessage):
+    def __init__(self, message):
+        AuditMessage.__init__(self, message)
+
+    def from_split_string(self, recs):
+        AuditMessage.from_split_string(self, recs)
+        self.assign_fields_from_recs(recs)
+
 # Parser for audit messages
 
 class AuditParser:
@@ -362,11 +482,16 @@ class AuditParser:
 
     def __initialize(self):
         self.avc_msgs = []
+        self.all_msgs = []
         self.compute_sid_msgs = []
         self.invalid_msgs = []
         self.policy_load_msgs = []
         self.path_msgs = []
-        self.by_header = { }
+        self.proctitle_msgs = []
+        self.cwd_msgs = []
+        self.daemon_start_msgs = []
+        self.syscall_msgs = []
+        self.by_audit_id = { }
         self.check_input_file = False
                 
     # Low-level parsing function - tries to determine if this audit
@@ -385,33 +510,60 @@ class AuditParser:
     def __parse_line(self, line):
         # strip("\x1c\x1d\x1e\x85") is only needed for python2
         # since str.split() in python3 already does this
-        rec = [x.strip("\x1c\x1d\x1e\x85") for x in line.split()]
-        for i in rec:
-            found = False
-            if i == "avc:" or i == "message=avc:" or i == "msg='avc:":
-                msg = AVCMessage(line)
-                found = True
-            elif i == "security_compute_sid:":
-                msg = ComputeSidMessage(line)
-                found = True
-            elif i == "type=MAC_POLICY_LOAD" or i == "type=1403":
-                msg = PolicyLoadMessage(line)
-                found = True
-            elif i == "type=AVC_PATH":
-                msg = PathMessage(line)
-                found = True
-            elif i == "type=DAEMON_START":
-                msg = DaemonStartMessage(list)
-                found = True
-                
-            if found:
-                self.check_input_file = True
-                try:
-                    msg.from_split_string(rec)
-                except ValueError:
-                    msg = InvalidMessage(line)
-                return msg
-        return None
+        recs = [x.strip("\x1c\x1d\x1e\x85") for x in line.split()]
+        try:
+            msg = None
+            for rec in recs:
+                if rec == "----" or rec.startswith("time->"):
+                    return None
+                elif rec == "type=AVC" or rec == "avc:" or rec == "message=avc:" or rec == "msg='avc:":
+                    msg = AVCMessage(line)
+                    msg.from_split_string(recs)
+                    self.avc_msgs.append(msg)
+                elif rec == "security_compute_sid:":
+                    msg = ComputeSidMessage(line)
+                    msg.from_split_string(recs)
+                    self.compute_sid_msgs.append(msg)
+                elif rec == "type=MAC_POLICY_LOAD" or rec == "type=1403" or rec == "MAC_CONFIG_CHANGE":
+                    msg = PolicyLoadMessage(line)
+                    msg.from_split_string(recs)
+                    if self.last_load_only:
+                        self.__initialize()
+                    self.policy_load_msgs.append(msg)
+                elif rec == "type=AVC_PATH" or rec == "type=PATH":
+                    msg = PathMessage(line)
+                    msg.from_split_string(recs)
+                    self.path_msgs.append(msg)
+                elif rec == "type=DAEMON_START":
+                    msg = DaemonStartMessage(line)
+                    msg.from_split_string(recs)
+                    if self.last_load_only and msg.auditd:
+                        self.__initialize()
+                    self.daemon_start_msgs.append(msg)
+                elif rec == "type=PROCTITLE":
+                    msg = Proctitle(line)
+                    msg.from_split_string(recs)
+                    self.proctitle_msgs.append(msg)
+                elif rec == "type=CWD":
+                    msg = CWD(line)
+                    msg.from_split_string(recs)
+                    self.cwd_msgs.append(msg)
+                elif rec == "type=SYSCALL":
+                    msg = SyscallMessage(line)
+                    msg.from_split_string(recs)
+                    self.syscall_msgs.append(msg)
+
+                if msg is not None:
+                    self.check_input_file = True
+                    break
+
+            if msg is None:
+                msg = AuditMessage(line)
+        except ValueError:
+            msg = InvalidMessage(line)
+
+        return msg
+
 
     # Higher-level parse function - take a line, parse it into an
     # AuditMessage object, and store it in the appropriate list.
@@ -422,51 +574,45 @@ class AuditParser:
         msg = self.__parse_line(line)
         if msg is None:
             return
-
-        # Append to the correct list
-        if isinstance(msg, PolicyLoadMessage):
-            if self.last_load_only:
-                self.__initialize()
-        elif isinstance(msg, DaemonStartMessage):
-            # We initialize every time the auditd is started. This
-            # is less than ideal, but unfortunately it is the only
-            # way to catch reboots since the initial policy load
-            # by init is not stored in the audit log.
-            if msg.auditd and self.last_load_only:
-                self.__initialize()
-            self.policy_load_msgs.append(msg)
-        elif isinstance(msg, AVCMessage):
-            self.avc_msgs.append(msg)
-        elif isinstance(msg, ComputeSidMessage):
-            self.compute_sid_msgs.append(msg)
-        elif isinstance(msg, InvalidMessage):
-            self.invalid_msgs.append(msg)
-        elif isinstance(msg, PathMessage):
-            self.path_msgs.append(msg)
+        self.all_msgs.append(msg)
 
         # Group by audit header
-        if msg.header != "":
-            if msg.header in self.by_header:
-                self.by_header[msg.header].append(msg)
+        if msg.audit_id != "":
+            if msg.audit_id in self.by_audit_id:
+                self.by_audit_id[msg.audit_id].append(msg)
             else:
-                self.by_header[msg.header] = [msg]
+                self.by_audit_id[msg.audit_id] = [msg]
             
 
     # Post processing will add additional information from AVC messages
     # from related messages - only works on messages generated by
     # the audit system.
     def __post_process(self):
-        for value in self.by_header.values():
+        for value in self.by_audit_id.values():
             avc = []
-            path = None
+            names = []
+            comm = ""
+            proctitle = ""
             for msg in value:
-                if isinstance(msg, PathMessage):
-                    path = msg
-                elif isinstance(msg, AVCMessage):
+                msg.related = value
+                if msg.name != "":
+                    names.append(msg.name)
+                if msg.comm != "":
+                    comm = msg.comm
+                if msg.proctitle != "":
+                    proctitle = msg.proctitle
+                if isinstance(msg, AVCMessage):
                     avc.append(msg)
-            if len(avc) > 0 and path:
+            if len(names):
+                longest_name = sorted(names, key=len)[-1]
+            else:
+                longest_name = ""
+            if len(avc) > 0:
                 for a in avc:
-                    a.path = path.path
+                    a.name = longest_name
+                    a.names = names
+                    a.comm = comm
+                    a.proctitle = proctitle
 
     def parse_file(self, input):
         """Parse the contents of a file object. This method can be called
@@ -509,7 +655,7 @@ class AuditParser:
         return role_types
 
     def to_access(self, avc_filter=None, only_denials=True):
-        """Convert the audit logs access into a an access vector set.
+        """Convert the audit logs access into an access vector set.
 
         Convert the audit logs into an access vector set, optionally
         filtering the restults with the passed in filter object.
@@ -543,6 +689,8 @@ class AuditParser:
 
                 av_set.add_av(av, audit_msg=avc)
 
+
+
         return av_set
 
 class AVCTypeFilter:
diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/src/sepolgen/policygen.py
index 7715bed5..f8ba6f85 100644
--- a/python/sepolgen/src/sepolgen/policygen.py
+++ b/python/sepolgen/src/sepolgen/policygen.py
@@ -301,19 +301,29 @@ def explain_access(av, ml=None, verbosity=SHORT_EXPLANATION):
                      (str(msg.scontext), str(msg.tcontext)))
             s.append('  class="%s" perms="%s"' %
                      (msg.tclass, refpolicy.list_to_space_str(msg.accesses)))
-            s.append('  comm="%s" exe="%s" path="%s"' % (msg.comm, msg.exe, msg.path))
+            s.append('  comm="%s" exe="%s" path="%s"' % (msg.comm, msg.exe, msg.name))
             s.extend(textwrap.wrap('message="' + msg.message + '"', 80, initial_indent="  ",
                                    subsequent_indent="   "))
         explain_interfaces()
     elif verbosity:
         s.append(' src="%s" tgt="%s" class="%s", perms="%s"' %
                  (av.src_type, av.tgt_type, av.obj_class, av.perms.to_space_str()))
-        # For the short display we are only going to use the additional information
-        # from the first audit message. For the vast majority of cases this info
-        # will always be the same anyway.
+        # For the short display just summarize and get the audit ids in there so that
+        # the user can look it up later if they want.
         if len(av.audit_msgs) > 0:
-            msg = av.audit_msgs[0]
-            s.append(' comm="%s" exe="%s" path="%s"' % (msg.comm, msg.exe, msg.path))
+            msgs = set()
+            for msg in av.audit_msgs:
+                msgs.add(msg)
+                if msg.related:
+                    msgs.update(msg.related)
+
+            exes = {x.exe for x in msgs if x.exe != ""}
+            cwds = {x.cwd for x in msgs if x.cwd != ""}
+            comms = {x.comm for x in msgs if x.comm != ""}
+            names = {x.name for x in msgs if x.name != ""}
+            proctitles = {x.proctitle for x in msgs if x.proctitle != ""}
+            audit_ids = {x.audit_id for x in msgs}
+            s.append(' ids="%s" comms="%s" exes="%s" paths="%s" cwds="%s" proctitles="%s"' % (",".join(audit_ids), ",".join(comms), ",".join(exes), ",".join(names), ",".join(cwds), ",".join(proctitles)))
         explain_interfaces()
     return s
 
diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index 01a322ca..db479e8b 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -747,7 +747,7 @@ def p_pcidevicecon(p):
 def p_devicetreecon(p):
     'devicetreecon : DEVICETREECON NUMBER context'
     c = refpolicy.DevicetTeeCon()
-    c.path = p[2]
+    c.name = p[2]
     c.context = p[3]
 
     p[0] = c
diff --git a/python/sepolgen/tests/test_audit.py b/python/sepolgen/tests/test_audit.py
index b659bf3b..81cab473 100644
--- a/python/sepolgen/tests/test_audit.py
+++ b/python/sepolgen/tests/test_audit.py
@@ -71,11 +71,10 @@ xperms_without = """type=AVC msg=audit(1516626657.910:4461): avc:  denied  { ioc
 class TestAVCMessage(unittest.TestCase):
     def test_defs(self):
         avc = sepolgen.audit.AVCMessage(audit1)
-        sc = sepolgen.refpolicy.SecurityContext()
-        self.assertEqual(avc.scontext, sc)
-        self.assertEqual(avc.tcontext, sc)
-        self.assertEqual(avc.tclass, "")
-        self.assertEqual(avc.accesses, [])
+        self.assertEqual(avc.scontext, None)
+        self.assertEqual(avc.tcontext, None)
+        self.assertEqual(avc.tclass, None)
+        self.assertEqual(avc.accesses, None)
         self.assertEqual(avc.ioctlcmd, None)
 
     def test_granted(self):
@@ -174,7 +173,7 @@ class TestPathMessage(unittest.TestCase):
         path = sepolgen.audit.PathMessage(path1)
         recs = path1.split()
         path.from_split_string(recs)
-        self.assertEqual(path.path, "/usr/lib/sa/sa1")
+        self.assertEqual(path.name, "/usr/lib/sa/sa1")
 
 # TODO - add tests for the other message types
 
@@ -195,8 +194,8 @@ class TestAuditParser(unittest.TestCase):
         a = sepolgen.audit.AuditParser()
         a.parse_string(log2)
         self.assertEqual(len(a.avc_msgs), 2)
-        self.assertEqual(a.avc_msgs[0].path, "/usr/lib/sa/sa1")
-        self.assertEqual(a.avc_msgs[1].path, "/usr/lib/sa/sa1")
+        self.assertEqual(a.avc_msgs[0].name, "/usr/lib/sa/sa1")
+        self.assertEqual(a.avc_msgs[1].name, "/usr/lib/sa/sa1")
 
     def test_parse_file(self):
         f = open("audit.txt")
-- 
2.50.1 (Apple Git-155)

