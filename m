Subject: [ libsepol 10 ] Bugfixes for 0-9
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1122396106.4470.76.camel@moss-spartans.epoch.ncsc.mil>
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>
	 <1122386595.4470.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1122387393.4470.54.camel@moss-spartans.epoch.ncsc.mil>
	 <1122393674.4470.73.camel@moss-spartans.epoch.ncsc.mil>
	 <1122393858.2812.5.camel@celtics.boston.redhat.com>
	 <1122395431.2812.13.camel@celtics.boston.redhat.com>
	 <1122396106.4470.76.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-G/1/jFFmEvtJQ0+4rdvV"
Date: Tue, 26 Jul 2005 12:52:59 -0400
Message-Id: <1122396779.2812.32.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-G/1/jFFmEvtJQ0+4rdvV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-07-26 at 12:41 -0400, Stephen Smalley wrote:
> On Tue, 2005-07-26 at 12:30 -0400, Ivan Gyurdiev wrote:
> > Attached fix...applies on top of everything else.
> 
> Hmm...doesn't seem to be relative - looks like a complete replacement
> for the original diff?

You're right, I need to do this properly, and post the relative
patch on list - attached.

Depends on: 

libsepol-1.1-context.diff 
libsepol-1.2-ports.diff               
libsepol-1.2-interfaces.diff 
libsepol-1.2-fix_memory_leaks.diff 
libsepol-3.1-write_services_printf.diff


--=-G/1/jFFmEvtJQ0+4rdvV
Content-Disposition: attachment; filename=libsepol-1.3-3.2-bugfixes.diff
Content-Type: text/x-patch; name=libsepol-1.3-3.2-bugfixes.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsepol.work/src/context.c libsepol-1.3-3.2-bugfixes/src/context.c
--- libsepol.work/src/context.c	2005-07-26 12:48:26.000000000 -0400
+++ libsepol-1.3-3.2-bugfixes/src/context.c	2005-07-26 12:48:25.000000000 -0400
@@ -75,13 +75,17 @@ int sepol_context_to_string(
 	/* Compute the size of the context. */
 	scontext_len += strlen(policydb->p_user_val_to_name[context->user-1])+1;
 	scontext_len += strlen(policydb->p_role_val_to_name[context->role-1])+1;
-	scontext_len += strlen(policydb->p_type_val_to_name[context->type-1])+1;
+	scontext_len += strlen(policydb->p_type_val_to_name[context->type-1]);
 	scontext_len += mls_compute_context_len(policydb, context);
+	
+	/* We must null terminate the string */
+	scontext_len += 1;
 
 	/* Allocate space for the context; caller must free this space. */
 	scontext = malloc(scontext_len);
 	if (!scontext) 
 		goto omem;
+	scontext[scontext_len-1] = '\0';
 
 	/*
 	 * Copy the user name, role name and type name into the context.
@@ -99,6 +103,9 @@ int sepol_context_to_string(
 
 	mls_sid_to_context(policydb, context, &ptr);
 
+	/* MLS may not null terminate the string */
+	*ptr = '\0';
+
 	*result = scontext;
 	*result_len = scontext_len;
 	return STATUS_SUCCESS;
diff -p -aru libsepol.work/src/interfaces.c libsepol-1.3-3.2-bugfixes/src/interfaces.c
--- libsepol.work/src/interfaces.c	2005-07-26 12:48:26.000000000 -0400
+++ libsepol-1.3-3.2-bugfixes/src/interfaces.c	2005-07-26 12:16:31.000000000 -0400
@@ -107,8 +107,6 @@ int sepol_iface_load(
 	if (rc < 0) 
 		goto err;
 
-#warning Is dup_match null terminated ??
-#warning if so, what's the purpose of dup_size
 	else if (rc != STATUS_NODATA) {
 		DEBUG(__FUNCTION__, "interface %s is already mapped to " 
 			"context %s with message context %s\n", 
diff -p -aru libsepol.work/src/ports.c libsepol-1.3-3.2-bugfixes/src/ports.c
--- libsepol.work/src/ports.c	2005-07-26 12:48:26.000000000 -0400
+++ libsepol-1.3-3.2-bugfixes/src/ports.c	2005-07-26 12:16:27.000000000 -0400
@@ -143,8 +143,6 @@ int sepol_port_load(
 	if (rc < 0) 
 		goto err;
 
-#warning Is dup_match null terminated ??
-#warning if so, what's the purpose of dup_size
 	else if (rc != STATUS_NODATA) {
 		DEBUG(__FUNCTION__, "port entry for %s %d-%d "
 			"is already mapped to context %s\n",
diff -p -aru libsepol.work/src/services.c libsepol-1.3-3.2-bugfixes/src/services.c
--- libsepol.work/src/services.c	2005-07-26 12:48:27.000000000 -0400
+++ libsepol-1.3-3.2-bugfixes/src/services.c	2005-07-26 12:16:18.000000000 -0400
@@ -502,7 +502,7 @@ int sepol_sid_to_context(sepol_security_
 
 	context = sepol_sidtab_search(sidtab, sid);
 	if (!context) {
-		DEBUG("unrecognized SID %d\n", sid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", sid);
 		rc = -EINVAL;
 		goto out;
 	}
diff -p -aru libsepol.work/src/write.c libsepol-1.3-3.2-bugfixes/src/write.c
--- libsepol.work/src/write.c	2005-07-26 12:48:27.000000000 -0400
+++ libsepol-1.3-3.2-bugfixes/src/write.c	2005-07-26 12:16:23.000000000 -0400
@@ -40,6 +40,7 @@
 #include <sepol/policydb.h>
 #include <sepol/conditional.h>
 
+#include "debug.h"
 #include "private.h"
 
 static unsigned int policyvers = POLICYDB_VERSION_MAX;

--=-G/1/jFFmEvtJQ0+4rdvV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
