Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j2021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:07 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 077543812BD
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:06 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 05/11] sepolgen: Unicode-objects must be encoded before
 hashing.
Date: Thu, 16 Jul 2015 13:48:15 +0200
Message-Id: <1437047301-17672-6-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sha256 hash operates with bytes and in Python3 all strings are unicode
by default, we must encode the data before hashing to ensure they
are bytes in Python3

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/util.py | 14 ++++++++++++++
 sepolgen/src/sepolgen/yacc.py | 10 ++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/sepolgen/src/sepolgen/util.py b/sepolgen/src/sepolgen/util.py
index 74a11f5..2edbf8c 100644
--- a/sepolgen/src/sepolgen/util.py
+++ b/sepolgen/src/sepolgen/util.py
@@ -76,6 +76,20 @@ def first(s, sorted=False):
         for x in s:
             return x
 
+def encode_input(text):
+    import locale
+    """Encode given text via preferred system encoding"""
+    # locale will often find out the correct encoding
+    encoding = locale.getpreferredencoding()
+    try:
+        encoded_text = text.encode(encoding)
+    except UnicodeError:
+    # if it fails to find correct encoding then ascii is used
+    # which may lead to UnicodeError if `text` contains non ascii signs
+    # utf-8 is our guess to fix the situation
+        encoded_text = text.encode('utf-8')
+    return encoded_text 
+
 if __name__ == "__main__":
     import sys
     import time
diff --git a/sepolgen/src/sepolgen/yacc.py b/sepolgen/src/sepolgen/yacc.py
index cd113fc..b681785 100644
--- a/sepolgen/src/sepolgen/yacc.py
+++ b/sepolgen/src/sepolgen/yacc.py
@@ -69,6 +69,8 @@ error_count = 3                # Number of symbols that must be shifted to leave
 
 import re, types, sys, cStringIO, hashlib, os.path
 
+from . import util
+
 # Exception raised for yacc-related errors
 class YaccError(Exception):   pass
 
@@ -1962,7 +1964,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
 
 
     # Add parsing method to signature
-    Signature.update(method)
+    Signature.update(util.encode_input(method))
     
     # If a "module" parameter was supplied, extract its dictionary.
     # Note: a module may in fact be an instance as well.
@@ -1995,7 +1997,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
     if not start:
         start = ldict.get("start",None)
     if start:
-        Signature.update(start)
+        Signature.update(util.encode_input(start))
 
     # If running in optimized mode.  We're going to
 
@@ -2064,7 +2066,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             if not (isinstance(prec,types.ListType) or isinstance(prec,types.TupleType)):
                 raise YaccError,"precedence must be a list or tuple."
             add_precedence(prec)
-            Signature.update(repr(prec))
+            Signature.update(util.encode_input(repr(prec)))
 
         for n in tokens:
             if not Precedence.has_key(n):
@@ -2112,7 +2114,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
         # Make a signature of the docstrings
         for f in symbols:
             if f.__doc__:
-                Signature.update(f.__doc__)
+                Signature.update(util.encode_input(f.__doc__))
     
         lr_init_vars()
 
-- 
2.4.3
