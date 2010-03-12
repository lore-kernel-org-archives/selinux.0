Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2CJv6Q7012592
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 14:57:06 -0500
Received: from mail-bw0-f228.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2CJvWFp026869
	for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 19:57:33 GMT
Received: by bwz28 with SMTP id 28so1390636bwz.34
        for <selinux@tycho.nsa.gov>; Fri, 12 Mar 2010 11:57:03 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 12 Mar 2010 14:57:02 -0500
Message-ID: <10143821003121157o2ccc5c2cw2079b86d86c33ef@mail.gmail.com>
Subject: [PATCH] Sepolgen: improve parser error recovery
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sepolgen has long not recovered from parsing errors, leading to
a blacklist of none bad modules in the source. I finally tracked
down the problem (lexer state) and this patch fixes the problem
by causing the lexer to be rebuilt on error.
---
 sepolgen/src/sepolgen/refparser.py |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/sepolgen/src/sepolgen/refparser.py
b/sepolgen/src/sepolgen/refparser.py
index 23beb39..5c5093c 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -279,7 +279,7 @@ parse_file = ""
 #     refpolicy.SupportMacros and should always be present during parsing
 #     though it may not contain any macros.
 spt = None
-success=True
+success = True

 # utilities
 def collect(stmts, parent, val=None):
@@ -921,9 +921,7 @@ def p_optional_semi(p):
 #

 def p_error(tok):
-    global error
-    global parse_file
-    global success
+    global error, parse_file, success, parser
     error = "%s: Syntax error on line %d %s [type=%s]" % (parse_file,
tok.lineno, tok.value, tok.type)
     print error
     success = False
@@ -939,6 +937,7 @@ parser = None
 lexer = None
 def create_globals(module, support, debug):
     global parser, lexer, m, spt
+
     if not parser:
         lexer = lex.lex()
         parser = yacc.yacc(method="LALR", debug=debug, write_tables=0)
@@ -955,17 +954,20 @@ def create_globals(module, support, debug):

 def parse(text, module=None, support=None, debug=False):
     create_globals(module, support, debug)
-    lexer.lexdata = []
-    lexer.lexpos = 0
-    lexer.lineno = 1
+    global error, parser, lexer, success
+
+    success = True

     try:
-        parser.parse(text, debug=debug)
+        parser.parse(text, debug=debug, lexer=lexer)
     except Exception, e:
-        global error
+        parser = None
+        lexer = None
         error = "internal parser error: %s" % str(e) + "\n" +
traceback.format_exc()

-    if error is not None:
+    if not success:
+        # force the parser and lexer to be rebuilt - we have some
problems otherwise
+        parser = None
         msg = 'could not parse text: "%s"' % error
         raise ValueError(msg)
     return m
@@ -973,15 +975,9 @@ def parse(text, module=None, support=None, debug=False):
 def list_headers(root):
     modules = []
     support_macros = None
-    blacklist = ["init.if", "inetd.if", "uml.if", "thunderbird.if"]

     for dirpath, dirnames, filenames in os.walk(root):
         for name in filenames:
-            # FIXME: these make the parser barf in various
unrecoverable ways, so we must skip
-            # them.
-            if name in blacklist:
-                continue
-
             modname = os.path.splitext(name)
             filename = os.path.join(dirpath, name)

--
1.6.6

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
