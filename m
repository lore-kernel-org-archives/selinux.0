Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5R8kpVb023116
 for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2016 04:46:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3EE8804E3
 for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2016 08:46:18 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Change the location of _selinux.so
Date: Mon, 27 Jun 2016 10:46:13 +0200
Message-Id: <1467017173-25285-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There was a change in swig-3.10 to use importlib instead of imp. While
the implementation with imp looked for _selinux.so also into the same directory
as __init__.py is, a new module with importlib searchs only standard paths.
It means that we need to move _selinux.so from $(PYLIBDIR)/site-packages/selinux/
to $(PYLIBDIR)/site-packages/.

Fixes:
>>> import selinux
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/lib64/python2.7/site-packages/selinux/__init__.py", line 21, in <module>
    _selinux = swig_import_helper()
  File "/usr/lib64/python2.7/site-packages/selinux/__init__.py", line 20, in swig_import_helper
    return importlib.import_module('_selinux')
  File "/usr/lib64/python2.7/importlib/__init__.py", line 37, in import_module
    __import__(name)
ImportError: No module named _selinux

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index d94163e..37d01af 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -156,7 +156,7 @@ install: all
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
-	install -m 755 $(SWIGSO) $(PYLIBDIR)/site-packages/selinux/_selinux.so
+	install -m 755 $(SWIGSO) $(PYLIBDIR)/site-packages/_selinux.so
 	install -m 755 $(AUDIT2WHYSO) $(PYLIBDIR)/site-packages/selinux/audit2why.so
 	install -m 644 $(SWIGPYOUT) $(PYLIBDIR)/site-packages/selinux/__init__.py
 
-- 
2.7.4
