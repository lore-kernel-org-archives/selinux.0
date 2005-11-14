From: Chad Sellers <csellers@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: [PATCH] move genhomedircon call out of transaction
Date: Mon, 14 Nov 2005 17:09:43 -0500
Cc: selinux-dev@tresys.com, Stephen Smalley <sds@tycho.nsa.gov>,
   selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nsQeDqRdRbzumhj"
Message-Id: <200511141709.43445.csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_nsQeDqRdRbzumhj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch that moves the genhomedircon patch out of the libsemanage 
transaction.  This is necessary since genhomedircon now uses libsemanage, and 
enters a transaction itself.

Chad

-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com

--Boundary-00=_nsQeDqRdRbzumhj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="genhomedircon-outside-trans.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="genhomedircon-outside-trans.diff"

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.21
diff -u -r1.21 semanage_store.c
--- libsemanage/src/semanage_store.c	9 Nov 2005 14:52:55 -0000	1.21
+++ libsemanage/src/semanage_store.c	14 Nov 2005 21:43:09 -0000
@@ -950,11 +950,6 @@
 		goto cleanup;
 	}
 
-	if ((r = semanage_exec_prog(sh, sh->conf->genhomedircon, sh->conf->store_path, "")) != 0) {
-		ERR(sh, "genhomedircon returned error code %d.", r);
-		goto cleanup;
-	}
-
 	retval = 0;
 cleanup:
 	free(storepath);
@@ -1070,6 +1065,12 @@
 		goto cleanup;
 	}
 
+	if ((retval = semanage_exec_prog(sh, sh->conf->genhomedircon, sh->conf->store_path, "")) != 0) {
+		ERR(sh, "genhomedircon returned error code %d.", retval);
+		goto cleanup;
+	}
+
+
 cleanup:
 	return retval;
 

--Boundary-00=_nsQeDqRdRbzumhj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
