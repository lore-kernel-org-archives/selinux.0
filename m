Message-ID: <4787DE30.6090706@redhat.com>
Date: Fri, 11 Jan 2008 16:22:56 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmill@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to improve sepopolgen error reporting
Content-Type: multipart/mixed;
 boundary="------------000001020102040700020204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000001020102040700020204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Resent minus patch for blacklist.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeH3i8ACgkQrlYvE4MpobNQKwCgoJ2EgHctehpYyJSHQb5uxgud
YdoAoNV7KfTw6DopBWUlXjqjo2A5QmcS
=T56w
-----END PGP SIGNATURE-----

--------------000001020102040700020204
Content-Type: text/plain;
 name="diffsepol"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diffsepol"

diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/audit.py policycoreutils-2.0.35/sepolgen-1.0.10/src/sepolgen/audit.py
--- nsasepolgen/src/sepolgen/audit.py	2007-09-13 08:21:11.000000000 -0400
+++ policycoreutils-2.0.35/sepolgen-1.0.10/src/sepolgen/audit.py	2008-01-11 11:17:50.000000000 -0500
@@ -32,7 +32,7 @@
        string contain all of the audit messages returned by ausearch.
     """
     import subprocess
-    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START"],
+    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START,SELINUX_ERR"],
                               stdout=subprocess.PIPE).communicate()[0]
     return output
 
@@ -251,7 +251,9 @@
             self.type = refpolicy.SecurityContext(dict["tcontext"]).type
         except:
             raise ValueError("Split string does not represent a valid compute sid message")
-
+    def output(self):
+        return "role %s types %s;\n" % (self.role, self.type)
+        
 # Parser for audit messages
 
 class AuditParser:
@@ -402,6 +404,26 @@
             self.__parse(l)
         self.__post_process()
 
+    def to_role(self, role_filter=None):
+        """Return list of SELINUX_ERR messages matching the specified filter
+
+        Filter out types that match the filer, or all roles
+
+        Params:
+           role_filter - [optional] Filter object used to filter the
+              output.
+        Returns:
+           Access vector set representing the denied access in the
+           audit logs parsed by this object.
+        """
+        roles = []
+        if role_filter:
+            for selinux_err in self.compute_sid_msgs:
+                if role_filter.filter(selinux_err):
+                    roles.append(selinux_err)
+            return roles
+        return self.compute_sid_msgs
+
     def to_access(self, avc_filter=None, only_denials=True):
         """Convert the audit logs access into a an access vector set.
 
diff --exclude-from=exclude -N -u -r nsasepolgen/src/sepolgen/refparser.py policycoreutils-2.0.35/sepolgen-1.0.10/src/sepolgen/refparser.py
--- nsasepolgen/src/sepolgen/refparser.py	2007-09-13 08:21:11.000000000 -0400
+++ policycoreutils-2.0.35/sepolgen-1.0.10/src/sepolgen/refparser.py	2008-01-11 11:17:50.000000000 -0500
@@ -118,6 +118,7 @@
     'TEMPLATE',
     'GEN_CONTEXT',
     #   m4
+    'IFELSE',
     'IFDEF',
     'IFNDEF',
     'DEFINE'
@@ -174,6 +175,7 @@
     'template' : 'TEMPLATE',
     'gen_context' : 'GEN_CONTEXT',
     # M4
+    'ifelse' : 'IFELSE',
     'ifndef' : 'IFNDEF',
     'ifdef' : 'IFDEF',
     'define' : 'DEFINE'
@@ -220,6 +222,12 @@
     # Ignore all comments
     t.lexer.lineno += 1
 
+def t_refpolicywarn1(t):
+    r'define.*refpolicywarn\(.*\n'
+    # Ignore refpolicywarn statements - they sometimes
+    # contain text that we can't parse.
+    t.skip(1)
+
 def t_refpolicywarn(t):
     r'refpolicywarn\(.*\n'
     # Ignore refpolicywarn statements - they sometimes
@@ -258,10 +266,12 @@
 m = None
 #   error is either None (indicating no error) or a string error message.
 error = None
+parse_file = ""
 #   spt is the support macros (e.g., obj/perm sets) - it is an instance of
 #     refpolicy.SupportMacros and should always be present during parsing
 #     though it may not contain any macros.
 spt = None
+success=True
 
 # utilities
 def collect(stmts, parent, val=None):
@@ -382,6 +392,19 @@
         collect(p[12], x, val=False)
     p[0] = [x]
 
+def p_ifelse(p):
+    '''ifelse : IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
+    '''
+#    x = refpolicy.IfDef(p[4])
+#    v = True
+#    collect(p[8], x, val=v)
+#    if len(p) > 12:
+#        collect(p[12], x, val=False)
+#    p[0] = [x]
+    pass
+
+
 def p_ifdef(p):
     '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
              | IFNDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
@@ -446,6 +469,7 @@
               | optional_policy
               | tunable_policy
               | ifdef
+              | ifelse
               | conditional
     '''
     p[0] = p[1]
@@ -844,8 +868,11 @@
 
 def p_error(tok):
     global error
-    error = "Syntax error on line %d %s [type=%s]" % (tok.lineno, tok.value, tok.type)
+    global parse_file
+    global success
+    error = "%s: Syntax error on line %d %s [type=%s]" % (parse_file, tok.lineno, tok.value, tok.type)
     print error
+    success = False
 
 def prep_spt(spt):
     if not spt:
@@ -941,12 +968,14 @@
             output.write(msg)
 
     def parse_file(f, module, spt=None):
+        global parse_file
         if debug:
             o("parsing file %s\n" % f)
         try:
             fd = open(f)
             txt = fd.read()
             fd.close()
+            parse_file = f
             parse(txt, module, spt, debug)
         except IOError, e:
             return

--------------000001020102040700020204
Content-Type: application/octet-stream;
 name="diffsepol.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diffsepol.sig"

iEYEABECAAYFAkeH3i8ACgkQrlYvE4MpobO7GACg3kPUPY3PKIMZKUPXgCsJadUPeksAn2dR
+E5yf9xdySsL3uPeWYY7+aXW
--------------000001020102040700020204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
