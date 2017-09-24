Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8OH8ElX023536
 for <selinux@tycho.nsa.gov>; Sun, 24 Sep 2017 13:08:14 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3E7A5564806
 for <selinux@tycho.nsa.gov>; Sun, 24 Sep 2017 19:05:32 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 24 Sep 2017 19:04:55 +0200
Message-Id: <20170924170456.5531-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/2] sepolicy: ignore comments and empty lines in
 file_contexts.subs_dist
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In refpolicy, file_contexts.subs_dist begins with comments:

    # This file can is used to configure base path aliases as in:
    #
    # /aliased_path /original_path_as_configured_in_file_contexts
    #

The first line gets parsed in read_file_equiv even though it is not a
valid path substitution and the second line triggers an exception when
accessing f[1]:

    IndexError: list index out of range

Parse substitutions only for lines which are not comment.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index d41fc6ae1543..bf2494a813c8 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -526,10 +526,10 @@ def find_entrypoint_path(exe, exclude_list=[]):
 def read_file_equiv(edict, fc_path, modify):
     try:
         with open(fc_path, "r") as fd:
-            fc = fd.readlines()
-            for e in fc:
+            for e in fd:
                 f = e.split()
-                edict[f[0]] = {"equiv": f[1], "modify": modify}
+                if f and not f[0].startswith('#'):
+                    edict[f[0]] = {"equiv": f[1], "modify": modify}
     except OSError as e:
         if e.errno != errno.ENOENT:
             raise
-- 
2.14.1
