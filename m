Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7E88jYR022447
 for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2015 04:08:46 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t7E88gTn018070
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2015 01:08:43 -0700 (PDT)
From: <wenzong.fan@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH] libselinux: get pywrap depends on selinux.py
Date: Fri, 14 Aug 2015 16:08:41 +0800
Message-ID: <1439539721-25847-1-git-send-email-wenzong.fan@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Wenzong Fan <wenzong.fan@windriver.com>

The selinux.py is generated at compile-time and will be installed as
python module "selinux/__init__.py", just make sure that it has been
generated completely while starting "make install-pywrap".

This fixes below errors that caused by an empty "selinux/__init__.py":

  $ /usr/sbin/semanage -h

  Traceback (most recent call last):
  File "/usr/sbin/semanage", line 30, in <module>
    import seobject
  File "/usr/lib64/python2.7/site-packages/seobject.py", line 27, in <module>
    import sepolicy
  File "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 226, in <module>
    def get_file_equiv_modified(fc_path = selinux.selinux_file_context_path()):
  AttributeError: 'module' object has no attribute 'selinux_file_context_path'

Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ac25c1f..a81acc7 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -90,7 +90,7 @@ SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
-pywrap: all $(SWIGSO) $(AUDIT2WHYSO)
+pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)
 
 rubywrap: all $(SWIGRUBYSO)
 
-- 
1.9.1
