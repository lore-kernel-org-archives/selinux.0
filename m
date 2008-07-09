Subject: [patch] libselinux:  eliminate shadowed variables from audit2why
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <method@manicmethod.com>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 11:03:29 -0400
Message-Id: <1215615809.24864.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

audit2why doesn't build with the default build options (-Werror) due to
shadowed variables.  In the first case, there isn't much point in
passing an avc argument when the rest of the file uses a static global
variable for the same object; in the second case, we are dealing with a
separate object returned to the caller and should name it accordingly.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

--- 

 libselinux/src/audit2why.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: trunk/libselinux/src/audit2why.c
===================================================================
--- trunk/libselinux/src/audit2why.c	(revision 2924)
+++ trunk/libselinux/src/audit2why.c	(working copy)
@@ -55,7 +55,7 @@
 	return 0;
 }
 
-static int check_booleans(struct avc_t *avc, struct boolean_t **bools)
+static int check_booleans(struct boolean_t **bools)
 {
 	char errormsg[PATH_MAX];
 	struct sepol_av_decision avd;
@@ -376,7 +376,7 @@
 		avc->tsid = tsid;
 		avc->tclass = tclass;
 		avc->av = av;
-		if (check_booleans(avc, &bools) == 0) {
+		if (check_booleans(&bools) == 0) {
 			if (av & ~avd.auditdeny) {
 				RETURN(DONTAUDIT)
 			} else {
@@ -390,15 +390,15 @@
 				len++; b++;
 			}
 			b = bools;
-			PyObject *boollist = PyTuple_New(len);
+			PyObject *outboollist = PyTuple_New(len);
 			len=0;
 			while(b->name) {
 				PyObject *bool = Py_BuildValue("(si)", b->name, b->active);
-				PyTuple_SetItem(boollist, len++, bool);
+				PyTuple_SetItem(outboollist, len++, bool);
 				b++;
 			}
 			free(bools);
-			PyTuple_SetItem(result, 1, boollist);
+			PyTuple_SetItem(result, 1, outboollist);
 			return result;
 		}
 	}


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
