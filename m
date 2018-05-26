Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIis6l004303
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:44:54 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 15D8E56069F
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:47 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:08 +0200
Message-Id: <20180526184213.4896-3-nicolas.iooss@m4x.org>
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/7] libsepol: do not leak memory if list_prepend
 fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When list_prepend() returns an error, it always means it failed to
allocate some memory and does not hold any reference to its argument
data. This argument needs to be freed by the caller in order to prevent
a memory leak.

While reviewing list_prepend() callers, I spend quite some time
understanding why typealiases_gather_map() does not need to strdup(key)
or free(key) when calling list_prepend(..., key) even though "key" comes
from pdb->p_types.table: because typealias_list_destroy() does not free
the inserted items. Add a comment to make this clearer in the code.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index c6f1659c84ef..ba8311ea7c75 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -298,6 +298,8 @@ static int roles_gather_map(char *key, void *data, void *args)
 	role_node->role = role;
 
 	rc = list_prepend((struct list *)args, role_node);
+	if (rc != 0)
+		free(role_node);
 	return rc;
 }
 
@@ -344,6 +346,11 @@ static int typealiases_gather_map(char *key, void *data, void *arg)
 					goto exit;
 				}
 			}
+			/* As typealias_lists[scope_id] does not hold the
+			 * ownership of its items (typealias_list_destroy does
+			 * not free the list items), "key" does not need to be
+			 * strdup'ed before it is inserted in the list.
+			 */
 			list_prepend(typealias_lists[scope_id], key);
 		}
 	}
-- 
2.17.0
