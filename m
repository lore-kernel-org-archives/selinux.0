Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j78HHoOb016197
	for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2005 13:17:50 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j78H9EiY002725
	for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2005 17:09:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j78HASlj028326
	for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2005 13:10:28 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j78HASNj028325
	for selinux@tycho.nsa.gov; Mon, 8 Aug 2005 13:10:28 -0400
Message-ID: <42F38DA8.4090300@comcast.net>
Date: Fri, 05 Aug 2005 12:02:48 -0400
From: Daniel J Walsh <Dan-Walsh@comcast.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Category Translation patch for MCS/MLS Policy
Content-Type: multipart/mixed;
 boundary="------------080602000400070902070603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080602000400070902070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have written up a patch for libselinux to implement two functions, to 
translate the security level.

getselevelbyname
getselevelbysename
setransconlevel

These functions try to dlopen a libsetrans and call the equivalent 
functions in this library.
Currently the patch only changes the *getfilecon function calls use 
these translations.
I have also attached a libsetrans-0.1.0-src.rpm  which would be the 
translation library for MCS.

I am not sure if a similar library was proposed by TCS or not,  I can 
not find it.  This is a lot simpler than
what Ivan proposed last week. 

Manipulation of securitylevel is to be done by the provider of the 
translation library (setrans).  So that a MLS environment
can use the Mitre library to translate, while MCS can use much simpler 
algorithms.

My demo libsetrans does the following

* If Security level is S0, remove security level all together.  I don't 
want users seeing this, since it is pretty useless information.
It would be nice to get rid of "object_r" also since it takes up 
terminal space and supplies Zero information.

* If a file has a security context other than S0, strip SO: off of it 
and pass it to the translation function calls. 
    Currently these calls only take a single category.
* If there is no translation it returns the category.

The categories in MCS are currently just loaded from a flat file 
/etc/selinux/category.conf. 
c1=Medical Records
c2=Top Secret
c3=Company Confidential
Eventually this will be configurable so this data could come from an 
ldap server, maybe it could be rolled into nsswitch.


Example output  (libselinux has sensivity level s0,  install.log.syslog 
has s0:c2)

ls -lZ /root
-rw-------  root     root     root:object_r:user_home_t:Top Secret 
anaconda-ks.cfg
-rw-r--r--  root     root     root:object_r:tmp_t:Medical Records dan
-rw-r--r--  root     root     root:object_r:user_home_t:Top Secret 
install.log
-rw-r--r--  root     root     root:object_r:user_home_t:c4 
install.log.syslog
-rw-r--r--  root     root     root:object_r:user_home_t        
libselinux-1.24.2-2.src.rpm


Comments?
Did I reimplement something that others already implemented?  Is this 
what people expect?

--------------080602000400070902070603
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/setrans.h libselinux-1.24.2/include/selinux/setrans.h
--- nsalibselinux/include/selinux/setrans.h	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.24.2/include/selinux/setrans.h	2005-08-05 09:56:54.000000000 -0400
@@ -0,0 +1,27 @@
+#ifndef _SETRANS_H_
+#define _SETRANS_H_
+
+#include <selinux/selinux.h>
+
+/* Define data structures */
+typedef struct selevel {
+	char* name;
+	char* sename;
+} selevel_t;
+
+/* Category data structure */
+/* Data returned from the getselevel functions must be freed using freelevel */
+
+/* Get Security Level translation struct via internal Name */
+extern struct selevel *getselevelbyname(const char *name);
+
+/* Get Security Level translation struct via external Name */
+extern struct selevel *getselevelbysename( const char* sename);
+
+/* Function used to free data returned via getselevel functions */
+extern void freeselevel( selevel_t *level);
+
+/* Translate security context, into exernal representation */
+extern char *setransconlevel(const security_context_t con);
+
+#endif
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/selinuxenabled.8 libselinux-1.24.2/man/man8/selinuxenabled.8
--- nsalibselinux/man/man8/selinuxenabled.8	2004-11-02 14:26:19.000000000 -0500
+++ libselinux-1.24.2/man/man8/selinuxenabled.8	2005-08-05 09:47:55.000000000 -0400
@@ -7,7 +7,7 @@
 .SH "DESCRIPTION"
 .B selinuxenabled
 Indicates whether SELinux is enabled or disabled. It exits with status 0 
-if SELinux is enabled and -256 if it is not enabled.
+if SELinux is enabled and 1 if it is not enabled.
 
 .SH AUTHOR	
 Dan Walsh, <dwalsh@redhat.com>
diff --exclude-from=exclude -N -u -r nsalibselinux/src/context.c libselinux-1.24.2/src/context.c
--- nsalibselinux/src/context.c	2005-01-28 12:15:29.000000000 -0500
+++ libselinux-1.24.2/src/context.c	2005-08-05 09:47:55.000000000 -0400
@@ -134,20 +134,27 @@
 
 static int set_comp(context_private_t* n,int index, const char *str)
 {
-        char *t = (char*) malloc(strlen(str)+1);
-        const char *p;
-        if ( !t ) { return 1; }
-        for ( p = str; *p; p++ ) {
-                if ( *p == '\t' || *p == ' ' || *p == '\n' || *p == '\r' ||
-                     (*p == ':' && index != COMP_RANGE) ) {
-                        free(t);
-                        return 1;
-                }
-        }
-        conditional_free(&n->component[index]);
-        n->component[index] = t;
-        strcpy(t,str);
-        return 0;
+	char *t;
+	
+	if (str) {
+		t = (char*) malloc(strlen(str)+1);
+		const char *p;
+		if ( !t ) { return 1; }
+		for ( p = str; *p; p++ ) {
+			if ( *p == '\t' || *p == '\n' || *p == '\r' ||
+			     (*p == ':' && index != COMP_RANGE) ) {
+				free(t);
+				return 1;
+			}
+		}
+		conditional_free(&n->component[index]);
+		n->component[index] = t;
+		strcpy(t,str);
+	} else {
+		conditional_free(&n->component[index]);
+		n->component[index] = NULL;
+	}
+	return 0;
 }
 
 #define def_get(name,tag) \
diff --exclude-from=exclude -N -u -r nsalibselinux/src/fgetfilecon.c libselinux-1.24.2/src/fgetfilecon.c
--- nsalibselinux/src/fgetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.24.2/src/fgetfilecon.c	2005-08-05 09:47:55.000000000 -0400
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <sys/xattr.h>
 #include "policy.h"
+#include <selinux/setrans.h>
 
 int fgetfilecon(int fd, security_context_t *context)
 {
@@ -37,9 +38,8 @@
 		ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size-1); 
 	}
 out:			
-	if (ret < 0)
-		free(buf);
-	else
-		*context = buf;
+	if (ret >= 0)
+		*context = setransconlevel(buf);
+       free(buf);
 	return ret;
 }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getcon.c libselinux-1.24.2/src/getcon.c
--- nsalibselinux/src/getcon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.24.2/src/getcon.c	2005-08-05 09:47:55.000000000 -0400
@@ -30,7 +30,7 @@
 	if (ret < 0)
 		goto out2;
 
-	*context = strdup(buf);
+	*context = setransconlevel(buf);
 	if (!(*context)) {
 		ret = -1;
 		goto out2;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.24.2/src/getfilecon.c
--- nsalibselinux/src/getfilecon.c	2005-01-28 12:15:29.000000000 -0500
+++ libselinux-1.24.2/src/getfilecon.c	2005-08-05 09:47:55.000000000 -0400
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <sys/xattr.h>
 #include "policy.h"
+#include <selinux/setrans.h>
 
 int getfilecon(const char *path, security_context_t *context)
 {
@@ -37,10 +38,9 @@
 		ret = getxattr(path, XATTR_NAME_SELINUX, buf, size-1); 
 	}
 out:			
-	if (ret < 0)
-		free(buf);
-	else
-		*context = buf;
+	if (ret >= 0)
+		*context = setransconlevel(buf);
+	free(buf);
 	return ret;
 }
 hidden_def(getfilecon)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getpidcon.c libselinux-1.24.2/src/getpidcon.c
--- nsalibselinux/src/getpidcon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.24.2/src/getpidcon.c	2005-08-05 09:47:55.000000000 -0400
@@ -34,7 +34,7 @@
 	if (ret < 0)
 		goto out2;
 
-	*context = strdup(buf);
+	*context = setransconlevel(buf);
 	if (!(*context)) {
 		ret = -1;
 		goto out2;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lgetfilecon.c libselinux-1.24.2/src/lgetfilecon.c
--- nsalibselinux/src/lgetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.24.2/src/lgetfilecon.c	2005-08-05 09:47:55.000000000 -0400
@@ -37,9 +37,8 @@
 		ret = lgetxattr(path, XATTR_NAME_SELINUX, buf, size-1); 
 	}
 out:			
-	if (ret < 0)
-		free(buf);
-	else
-		*context = buf;
+	if (ret >= 0)
+		*context = setransconlevel(buf);
+	free(buf);
 	return ret;
 }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setrans.c libselinux-1.24.2/src/setrans.c
--- nsalibselinux/src/setrans.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.24.2/src/setrans.c	2005-08-05 09:51:03.000000000 -0400
@@ -0,0 +1,71 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <selinux/setrans.h>
+#include <selinux/context.h>
+#include <dlfcn.h>
+
+static selevel_t *(*setrans_selevelbyname)( const char* name);
+static selevel_t *(*setrans_selevelbysename)( const char* sename);
+
+void freeselevel( selevel_t *level) {
+	if (level->name) 
+		free(level->name);
+	if (level->sename) 
+		free(level->sename);
+	free(level);
+}
+
+/* Find and load the Security Level translation library */
+static int getlibsetrans(void) {
+	static void *handle = NULL;
+	char *error;
+	if (handle) {
+		return 0;
+	}
+	handle = dlopen ("libsetrans.so", RTLD_LAZY);
+	if (!handle)
+		return 1;
+	dlerror();
+	*(selevel_t **) (&setrans_selevelbyname) = dlsym(handle, "setrans_getselevelbyname");
+	if ((error = dlerror()) != NULL)  {
+		return 1;
+	}
+	*(selevel_t **) (&setrans_selevelbysename) = dlsym(handle, "setrans_getselevelbysename");
+	if ((error = dlerror()) != NULL)  {
+		return 1;
+	}
+	return 0;
+}
+
+/* Get Security Level via internal Name */
+selevel_t *getselevelbyname( const char* name) {
+	if (getlibsetrans()) return NULL;
+	return (*setrans_selevelbyname)(name);
+}
+
+/* Get Security Level via external Name */
+selevel_t *getselevelbysename( const char* sename) {
+	if (getlibsetrans()) return NULL;
+	return (*setrans_selevelbysename)(sename);
+}
+
+/* Function used to translate a security context into external representation */
+extern char *setransconlevel(const security_context_t scon) {
+	char *rcon;
+	context_t con=context_new(scon);
+	selevel_t *level;
+	if (!con) 
+		return NULL;
+	level=getselevelbyname(context_range_get(con));
+	if (level) {
+		context_range_set(con, level->sename);
+		rcon=strdup(context_str(con));
+		freeselevel(level);
+	} else {
+		rcon=strdup(scon);
+	}
+	context_free(con);
+	return rcon;
+}

--------------080602000400070902070603
Content-Type: application/x-rpm;
 name="libsetrans-0.1.0-1.src.rpm"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="libsetrans-0.1.0-1.src.rpm"

7avu2wMAAAEAAWxpYnNldHJhbnMtMC4xLjAtMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAUAAAAAAAAAAAAAAAAAAAAAjq3oAQAAAAAAAAAF
AAAAVAAAAD4AAAAHAAAARAAAABAAAAENAAAABgAAAAAAAAABAAAD6AAAAAQAAAAsAAAAAQAA
A+wAAAAHAAAAMAAAABAAAAPvAAAABAAAAEAAAAABZjE3YjMwYjQzYjExN2FlYzIwMWU1MzE5
NDIxY2FjNDZmNDg3MzgwOQAAAAAAADGBQCXD35tNICRkg6g5oV2fAwAALRgAAAA+AAAAB///
/7AAAAAQAAAAAI6t6AEAAAAAAAAAKwAABOgAAAA/AAAABwAABNgAAAAQAAAAZAAAAAgAAAAA
AAAAAQAAA+gAAAAGAAAAAgAAAAEAAAPpAAAABgAAAA0AAAABAAAD6gAAAAYAAAATAAAAAQAA
A+wAAAAJAAAAFQAAAAEAAAPtAAAACQAAADEAAAABAAAD7gAAAAQAAALwAAAAAQAAA+8AAAAG
AAAC9AAAAAEAAAPxAAAABAAAAwwAAAABAAAD9gAAAAYAAAMQAAAAAQAAA/gAAAAJAAADFQAA
AAEAAAP6AAAACAAAAzIAAAABAAAD/QAAAAYAAANHAAAAAQAAA/4AAAAGAAADTQAAAAEAAAQE
AAAABAAAA1QAAAACAAAEBgAAAAMAAANcAAAAAgAABAkAAAADAAADYAAAAAIAAAQKAAAABAAA
A2QAAAACAAAECwAAAAgAAANsAAAAAgAABAwAAAAIAAADrgAAAAIAAAQNAAAABAAAA7AAAAAC
AAAEDwAAAAgAAAO4AAAAAgAABBAAAAAIAAADxgAAAAIAAAQVAAAABAAAA9QAAAACAAAEGAAA
AAQAAAPcAAAAAgAABBkAAAAIAAAD5AAAAAIAAAQaAAAACAAABBEAAAACAAAEKAAAAAYAAAQi
AAAAAQAABDgAAAAEAAAEKAAAAAEAAAQ5AAAACAAABCwAAAABAAAEOgAAAAgAAARSAAAAAQAA
BEYAAAAGAAAEZAAAAAEAAARHAAAABAAABIgAAAACAAAESAAAAAQAAASQAAAAAgAABEkAAAAI
AAAEmAAAAAIAAARcAAAABAAABJwAAAACAAAEXQAAAAgAAASkAAAAAgAABF4AAAAIAAAEyQAA
AAEAAARkAAAABgAABMoAAAABAAAEZQAAAAYAAATPAAAAAQAABGYAAAAGAAAE1AAAAAEAAAR7
AAAACAAABNYAAAACQwBsaWJzZXRyYW5zADAuMS4wADEAU0VMaW51eCBUcmFuc2xhdGlvbiBs
aWJyYXJ5AFNlY3VyaXR5LWVuaGFuY2VkIExpbnV4IGlzIGEgcGF0Y2ggb2YgdGhlIExpbnV4
wq4ga2VybmVsIGFuZCBhIG51bWJlcgpvZiB1dGlsaXRpZXMgd2l0aCBlbmhhbmNlZCBzZWN1
cml0eSBmdW5jdGlvbmFsaXR5IGRlc2lnbmVkIHRvIGFkZAptYW5kYXRvcnkgYWNjZXNzIGNv
bnRyb2xzIHRvIExpbnV4LiAgVGhlIFNlY3VyaXR5LWVuaGFuY2VkIExpbnV4Cmtlcm5lbCBj
b250YWlucyBuZXcgYXJjaGl0ZWN0dXJhbCBjb21wb25lbnRzIG9yaWdpbmFsbHkgZGV2ZWxv
cGVkIHRvCmltcHJvdmUgdGhlIHNlY3VyaXR5IG9mIHRoZSBGbGFzayBvcGVyYXRpbmcgc3lz
dGVtLiBUaGVzZQphcmNoaXRlY3R1cmFsIGNvbXBvbmVudHMgcHJvdmlkZSBnZW5lcmFsIHN1
cHBvcnQgZm9yIHRoZSBlbmZvcmNlbWVudApvZiBtYW55IGtpbmRzIG9mIG1hbmRhdG9yeSBh
Y2Nlc3MgY29udHJvbCBwb2xpY2llcywgaW5jbHVkaW5nIHRob3NlCmJhc2VkIG9uIHRoZSBj
b25jZXB0cyBvZiBUeXBlIEVuZm9yY2VtZW50wq4sIFJvbGUtYmFzZWQgQWNjZXNzCkNvbnRy
b2wsIGFuZCBNdWx0aS1sZXZlbCBTZWN1cml0eS4KCmxpYnNldHJhbnMgcHJvdmlkZXMgYW4g
dHJhbnNsYXRpb24gbGlicmFyeSB0byB0cmFuc2xhdGUgU0VMaW51eCBjYXRlZ29yaWVzCmZy
b20gaW50ZXJuYWwgcmVwcmVzZW50YXRpb25zIHRvIHVzZXIgZGVmaW5lZCByZXByZXNlbnRh
dGlvbi4AAABC840IbG9jYWxob3N0LmxvY2FsZG9tYWluAAAAAAArlExHUEwAU3lzdGVtIEVu
dmlyb25tZW50L0xpYnJhcmllcwBsaWJzZXRyYW5zLTAuMS4wLnRnegBsaW51eABpMzg2AAAA
AAAlDwAABoWBtIG0AAAAAELzhXpC840DMGY3YWZlMTk3NThkMGZiZTM3YWRjZTRkYmQ1ODdm
MTAAOWYzYTk2ZTc5MTcxODFiNmM2ODIzNTJhYzE4ZGRjYzMAAAAAAAAAAAAAIGR3YWxzaABk
d2Fsc2gAZHdhbHNoAGR3YWxzaAD//////////wAAAAwBAABKbGlic2VsaW51eC1kZXZlbABy
cG1saWIoQ29tcHJlc3NlZEZpbGVOYW1lcykAMS4yNC4yLTIAMy4wLjQtMQA0LjQuMgBC8+Fg
RGFuIFdhbHNoIDxkd2Fsc2hAcmVkaGF0LmNvbT4gMC4xLjAtMQAtIEluaXRpYWwgVmVyc2lv
bgBsb2NhbGhvc3QubG9jYWxkb21haW4gMTEyMzI1NzYwOAAAAAAAAP0AAAD9AABdgjQAXYIU
AAAAAAAAAAAAAAAAbGlic2V0cmFucy0wLjEuMC50Z3oAbGlic2V0cmFucy5zcGVjAABjcGlv
AGd6aXAAOQAAAAAAAD8AAAAH///9UAAAABAfiwgAAAAAAAADfJRlWxMAoIXHRsco6Rod0iNG
l8CYlICEdA0QpDulUwXplmaEdEp3SEgjSCPdSCns1nO/3ee+X855zw84guKC4oJCgoKiNjBh
qIjgfwITsvrv/D8QEhFGQmGi4pb/JcKigsj/mZE2gv8vQqL/25wcrDxsPd0tnT34BPmF+AX5
Pe38AQCmeFyAf+SVIgB0bBzgsyKWNtXdu0wc6gaNTdGp34GNin39tn2X5P/Rcc9w0rN9VhOb
hZlAVPkt3sxHJOff5VtZANkcq8O35dPMhnm1rQwAP//plY9A+VxCNT9B6vLaF7lj4uazoIcp
gOxUvuxg/lQeYV6E3OPemmvtVeDtvcXewezeLXY/p1Q/5+3OLBrLTF82le81827njmaJd7vf
2vAQWk3uoP7pHWnIW7o7iYf1oBvC624pasKQWXTNhVFlyG0xU0iWjHbvlLeP+AH63vXWqBqd
+4thGj1rJ/Xtdmdj1gm9OYX2eAxB1sOqyfi6q4Stx4vlHhEiUxxu+qUnqoI4Tsh7I8v6o1Q/
Dhe5uPFBE4GJGdRohU/TYDVDwlXV3BmC/lk+u7+VMJ/qsF3ZnstToKc/d0uzV6zYeHLLIXc0
jsFwDT9/t5SEjJTzxKfXqJqrPvvac+lsJ7y6R8O+/meYkA+piDfQ7LI3wEG6XLh/nhabU4GL
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
--------------080602000400070902070603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
