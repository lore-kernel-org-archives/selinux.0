From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH] libselinux: drop usage of _D_ALLOC_NAMLEN
Date: Fri, 23 Sep 2016 11:02:53 -0700
Message-Id: <1474653773-10575-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

_D_ALLOC_NAMLEN is not very portable. Currently, the code
mallocs based on _D_ALLOC_NAMLEN() and then strcpy's dirent
d_name into the buffer. Instead, just use strdup.

Change-Id: I5c8ca47da2c593ea2726caba5781f5e9d9d910ae
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/booleans.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index 4b39a28..c438af1 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -63,12 +63,11 @@ int security_get_boolean_names(char ***names, int *len)
 	}
 
 	for (i = 0; i < *len; i++) {
-		n[i] = (char *)malloc(_D_ALLOC_NAMLEN(namelist[i]));
+		n[i] = strdup(namelist[i]->d_name);
 		if (!n[i]) {
 			rc = -1;
 			goto bad_freen;
 		}
-		strcpy(n[i], namelist[i]->d_name);
 	}
 	rc = 0;
 	*names = n;
-- 
1.9.1
