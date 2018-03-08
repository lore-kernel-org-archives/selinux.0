From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: pebenito@ieee.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu,  8 Mar 2018 15:19:26 -0500
Message-Id: <20180308201926.28435-1-sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: Export sepol_polcap_getnum/name functions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Export the sepol_polcap_getnum/name() functions to users of
the shared library.  This will enable SETools to stop depending
on the static library.

Note that we may want to move polcaps.h up one level since
the convention is that headers directly under include/sepol are
shared library APIs while headers under include/sepol/policydb
are limited to static users.  However, this will unnecessarily
break the build for existing static users so it is deferred.

Suggested-by: Chris PeBenito <pebenito@ieee.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/libsepol.map.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 2a9996f7..d879016c 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -56,4 +56,6 @@ LIBSEPOL_1.1 {
 	sepol_module_policydb_to_cil;
 	sepol_kernel_policydb_to_cil;
 	sepol_kernel_policydb_to_conf;
+	sepol_polcap_getnum;
+	sepol_polcap_getname;
 } LIBSEPOL_1.0;
-- 
2.14.3
