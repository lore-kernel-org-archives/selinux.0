Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MMMR8D018037
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 17:22:27 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1MMNiWA004459
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 22:23:44 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1MMNiuW025996
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 17:23:44 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1MMNhgB009516
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 17:23:44 -0500
Received: from [10.11.14.28] (vpn-14-28.rdu.redhat.com [10.11.14.28])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l1MMNhTj000422
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 17:23:43 -0500
Message-ID: <45DE17E7.1070000@mentalrootkit.com>
Date: Thu, 22 Feb 2007 17:23:35 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] sepolgen: optionally generate debugging information during
 parsing
Content-Type: multipart/mixed;
 boundary="------------090102070400050703040808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090102070400050703040808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch allows a caller to request the output of debugging 
information from the parser. This is mainly useful for development / 
debugging of the parser.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--------------090102070400050703040808
Content-Type: text/x-patch;
 name="sepolgen-parser-debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sepolgen-parser-debug.diff"

diff -r af054201710a sepolgen/src/sepolgen/refparser.py
--- a/sepolgen/src/sepolgen/refparser.py	Thu Feb 22 15:42:47 2007 -0500
+++ b/sepolgen/src/sepolgen/refparser.py	Thu Feb 22 17:07:44 2007 -0500
@@ -611,11 +611,11 @@ def prep_spt(spt):
 
 parser = None
 lexer = None
-def create_globals(module, support):
+def create_globals(module, support, debug):
     global parser, lexer, m, spt
     if not parser:
         lexer = lex.lex()
-        parser = yacc.yacc(method="LALR", debug=0, write_tables=0)
+        parser = yacc.yacc(method="LALR", debug=debug, write_tables=0)
 
     if module is not None:
         m = module
@@ -627,13 +627,13 @@ def create_globals(module, support):
     else:
         spt = support
 
-def parse(text, module=None, support=None):
-    create_globals(module, support)
+def parse(text, module=None, support=None, debug=False):
+    create_globals(module, support, debug)
     lexer.lexdata = []
     lexer.lexpos = 0
 
     try:
-        parser.parse(text, debug=0)
+        parser.parse(text, debug=debug)
     except Exception, e:
         global error
         error = "internal parser error: %s" % str(e)
@@ -670,7 +670,7 @@ def list_headers(root):
     return (modules, support_macros)
 
 
-def parse_headers(root, output=None, expand=True):
+def parse_headers(root, output=None, expand=True, debug=False):
     import util
 
     headers = refpolicy.Headers()
@@ -696,11 +696,13 @@ def parse_headers(root, output=None, exp
             output.write(msg)
 
     def parse_file(f, module, spt=None):
+        if debug:
+            o("parsing file %s\n" % f)
         try:
             fd = open(f)
             txt = fd.read()
             fd.close()
-            parse(txt, module, spt)
+            parse(txt, module, spt, debug)
         except IOError, e:
             return
         except ValueError, e:
@@ -726,7 +728,7 @@ def parse_headers(root, output=None, exp
 
         o("done.\n")
 
-    if output:
+    if output and not debug:
         status = util.ConsoleProgressBar(sys.stdout, steps=len(modules))
         status.start("Parsing interface files")
 
@@ -744,7 +746,7 @@ def parse_headers(root, output=None, exp
             continue
 
         headers.children.append(m)
-        if output:
+        if output and not debug:
             status.step()
 
     if len(failures):

--------------090102070400050703040808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
