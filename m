Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j1021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:06 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 20928AED77
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:05 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 04/11] sepolgen: Use sort function with key parameter.
Date: Thu, 16 Jul 2015 13:48:14 +0200
Message-Id: <1437047301-17672-5-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since Python 2.4 .sort() as well as the new sorted() function
take a key parameter which should be a function that returns
a sorting key.

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/src/sepolgen/lex.py  | 4 ++--
 sepolgen/src/sepolgen/yacc.py | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sepolgen/src/sepolgen/lex.py b/sepolgen/src/sepolgen/lex.py
index 7f12e26..3f5904b 100644
--- a/sepolgen/src/sepolgen/lex.py
+++ b/sepolgen/src/sepolgen/lex.py
@@ -635,11 +635,11 @@ def lex(module=None,object=None,debug=0,optimize=0,lextab="lextab",reflags=0,now
 
     # Sort the functions by line number
     for f in funcsym.values():
-        f.sort(lambda x,y: cmp(x[1].__code__.co_firstlineno,y[1].__code__.co_firstlineno))
+        f.sort(key=lambda x: x[1].__code__.co_firstlineno)
 
     # Sort the strings by regular expression length
     for s in strsym.values():
-        s.sort(lambda x,y: (len(x[1]) < len(y[1])) - (len(x[1]) > len(y[1])))
+        s.sort(key=lambda x: len(x[1]))
 
     regexs = { }
 
diff --git a/sepolgen/src/sepolgen/yacc.py b/sepolgen/src/sepolgen/yacc.py
index d821940..cd113fc 100644
--- a/sepolgen/src/sepolgen/yacc.py
+++ b/sepolgen/src/sepolgen/yacc.py
@@ -2100,7 +2100,7 @@ def yacc(method=default_lr, debug=yaccdebug, module=None, tabmodule=tab_module,
             raise YaccError,"no rules of the form p_rulename are defined."
     
         # Sort the symbols by line number
-        symbols.sort(lambda x,y: cmp(x.__code__.co_firstlineno,y.__code__.co_firstlineno))
+        symbols.sort(key=lambda x: x.__code__.co_firstlineno)
 
         # Add all of the symbols to the grammar
         for f in symbols:
-- 
2.4.3
