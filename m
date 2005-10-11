Subject: Re: [ SEPOL ] Another debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1129043725.3308.157.camel@moss-spartans.epoch.ncsc.mil>
References: <434B62B8.4080309@cornell.edu>  <434B7FF2.2090306@cornell.edu>
	 <1129041930.3308.137.camel@moss-spartans.epoch.ncsc.mil>
	 <434BD63B.7020003@cornell.edu>
	 <1129043725.3308.157.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-fPM4vePF/NpV756bm9of"
Date: Tue, 11 Oct 2005 11:51:52 -0400
Message-Id: <1129045912.3308.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fPM4vePF/NpV756bm9of
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-10-11 at 11:15 -0400, Stephen Smalley wrote:
> No, we should provide ABI stability, as discussed in section 3 of
> http://people.redhat.com/drepper/dsohowto.pdf
> 
> Updated users can be limited to the new interfaces, but old binaries
> should continue to work even with the new libsepol, i.e. the libsepol
> DSO must continue to provide versions of those interfaces that are
> consistent with its previously exported ABI.

Example:  Suppose that we wanted to introduce an explicit policydb
argument to sepol_check_context() rather than requiring use of a global
policydb within libsepol for that purpose.  We might modify libsepol as
in the following patch to achieve this without disturbing existing
binaries.  Any programs rebuilt against the new libsepol will be forced
to be updated to the new interface (public interface definition changed
in the header file), but existing binaries built against the old
libsepol will continue to fallback to the old interface.  Note that this
patch isn't complete (doesn't update chkcon example utility to the new
interface, or deal with the need to also have a non-global sidtab), but
is functional (I built libsepol with this patch, and then ran an
existing setfiles binary against it with the -c option to check contexts
against a binary policy, and setfiles continued to use the old interface
and work correctly).

-- 
Stephen Smalley
National Security Agency

--=-fPM4vePF/NpV756bm9of
Content-Disposition: attachment; filename=libsepol-ex.patch
Content-Type: text/x-patch; name=libsepol-ex.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsepol/include/sepol/sepol.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/sepol.h,v
retrieving revision 1.8
diff -u -p -r1.8 sepol.h
--- libsepol/include/sepol/sepol.h	14 Sep 2005 15:18:55 -0000	1.8
+++ libsepol/include/sepol/sepol.h	11 Oct 2005 15:28:51 -0000
@@ -3,6 +3,7 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include <sepol/policydb.h>
 
 /* Given an existing binary policy (starting at 'data', with length 'len')
    and a boolean configuration file named by 'boolpath', rewrite the binary
@@ -35,7 +36,7 @@ extern void sepol_set_delusers(int on);
 extern int sepol_set_policydb_from_file(FILE *fp);
 
 /* Check context validity against currently set binary policy. */
-extern int sepol_check_context(char *context);
+extern int sepol_check_context(sepol_policydb_t *p, char *context);
 
 /* Turn on or off sepol error messages. */
 extern void sepol_debug(int on);
Index: libsepol/include/sepol/policydb/services.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb/services.h,v
retrieving revision 1.1
diff -u -p -r1.1 services.h
--- libsepol/include/sepol/policydb/services.h	7 Oct 2005 20:10:15 -0000	1.1
+++ libsepol/include/sepol/policydb/services.h	11 Oct 2005 15:29:30 -0000
@@ -108,6 +108,7 @@ extern int sepol_sid_to_context(
  * has the string representation specified by `scontext'.
  */
 extern int sepol_context_to_sid(
+	policydb_t *p,
 	sepol_security_context_t scontext,		/* IN */
 	size_t  scontext_len,			/* IN */
 	sepol_security_id_t *out_sid);		/* OUT */
Index: libsepol/src/libsepol.map
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/libsepol.map,v
retrieving revision 1.6
diff -u -p -r1.6 libsepol.map
--- libsepol/src/libsepol.map	7 Oct 2005 20:10:15 -0000	1.6
+++ libsepol/src/libsepol.map	11 Oct 2005 15:27:05 -0000
@@ -1,4 +1,11 @@
-{
+LIBSEPOL_1.0 {
+  global: 
+	sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;
+ local: 
+	*;
+};
+
+LIBSEPOL_1.1 {
   global: 
 	sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;
 	sepol_policy_file_create; sepol_policy_file_free;
@@ -17,5 +24,4 @@
 	sepol_bool*; sepol_context*; sepol_disable_debug; sepol_enable_debug;
 	sepol_iface*; sepol_port*; sepol_user*; sepol_clear_unused_users;
 	sepol_role_is_valid; sepol_set_delusers;
-  local: *;
-};
+} LIBSEPOL_1.0;
Index: libsepol/src/services.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/services.c,v
retrieving revision 1.23
diff -u -p -r1.23 services.c
--- libsepol/src/services.c	7 Oct 2005 20:10:16 -0000	1.23
+++ libsepol/src/services.c	11 Oct 2005 15:24:21 -0000
@@ -538,7 +538,8 @@ out:
  * Return a SID associated with the security context that
  * has the string representation specified by `scontext'.
  */
-int sepol_context_to_sid(sepol_security_context_t scontext,
+int sepol_context_to_sid(policydb_t *policydb,
+	                    sepol_security_context_t scontext,
 			    size_t scontext_len,
 			    sepol_security_id_t * sid)
 {
@@ -566,10 +567,17 @@ int sepol_context_to_sid(sepol_security_
 	return STATUS_ERR;
 }
 
-int sepol_check_context(char *context) 
+int sepol_check_context1__ (char *context) 
 {
-	return sepol_context_to_sid(context, strlen(context)+1, NULL);
+	return sepol_context_to_sid(policydb, context, strlen(context)+1, NULL);
 }
+asm(".symver sepol_check_context1__,sepol_check_context@LIBSEPOL_1.0");
+
+int sepol_check_context2__ (sepol_policydb_t *p, char *context) 
+{
+	return sepol_context_to_sid(&p->p, context, strlen(context)+1, NULL);
+}
+asm(".symver sepol_check_context2__,sepol_check_context@@LIBSEPOL_1.1");
 
 static inline int compute_sid_handle_invalid_context(
 	context_struct_t *scontext,

--=-fPM4vePF/NpV756bm9of--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
