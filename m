Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
References: <428368FF.2080603@redhat.com>
	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
	 <42836C4C.6010301@redhat.com>
	 <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-5QWBcRjwIELS04SY9qsn"
Date: Fri, 13 May 2005 15:30:01 -0400
Message-Id: <1116012601.3576.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5QWBcRjwIELS04SY9qsn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-13 at 11:00 -0400, Stephen Smalley wrote:
> Ok, just committed the two attached patches for libsepol and
> policycoreutils to introduce an audit2why utility.

In creating audit2why, I ran into the known namespace collision between
libsepol and libselinux; they both define the base set of Flask types,
with the one set of definitions for security-aware applications running
on SELinux and the other set of definitions for the binary policy and
the userspace security server code (the latter is only exported by the
static libsepol, not the shared library).  I worked around the collision
temporarily in audit2why.c by not including selinux.h and manually
defining function prototypes for the functions from libselinux, but I
think we should eliminate the collision by applying the attached script
to all *.[chy] files in libsepol and checkpolicy and then applying the
attached patch to audit2why.  I don't think we want to actually fold the
types together, as the libsepol definitions need to stay consistent with
the binary policy format whereas the libselinux ones don't need to be
fixed size (and in the case of security_id_t we cannot fold them since
one is an integer and the other is a struct).  Seem reasonable?

-- 
Stephen Smalley
National Security Agency

--=-5QWBcRjwIELS04SY9qsn
Content-Disposition: attachment; filename=fixnamespace
Content-Type: application/x-shellscript; name=fixnamespace
Content-Transfer-Encoding: 7bit

#!/bin/sh
sed -e "s/security_context_t/sepol_security_context_t/g" \
    -e "s/security_id_t/sepol_security_id_t/g" \
    -e "s/access_vector_t/sepol_access_vector_t/g" \
    -e "s/security_class_t/sepol_security_class_t/g" \
    -e "s/av_decision/sepol_av_decision/g" \
    -e "s/SECCLASS_NULL/SEPOL_SECCLASS_NULL/g" \
    -e "s/SECCLASS_NULL/SEPOL_SECCLASS_NULL/g" \
    -e "s/SECSID_NULL/SEPOL_SECSID_NULL/g" \
$1 > $1.new
mv $1.new $1

--=-5QWBcRjwIELS04SY9qsn
Content-Disposition: attachment; filename=audit2why-namespace.patch
Content-Type: text/x-patch; name=audit2why-namespace.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/audit2why/audit2why.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/audit2why/audit2why.c,v
retrieving revision 1.1
diff -u -p -r1.1 audit2why.c
--- policycoreutils/audit2why/audit2why.c	13 May 2005 14:42:21 -0000	1.1
+++ policycoreutils/audit2why/audit2why.c	13 May 2005 19:14:22 -0000
@@ -8,22 +8,13 @@
 #include <limits.h>
 #include <sepol/sepol.h>
 #include <sepol/services.h>
+#include <selinux/selinux.h>
 
 #define AVCPREFIX "avc:  denied  { "
 #define SCONTEXT "scontext="
 #define TCONTEXT "tcontext="
 #define TCLASS "tclass="
 
-/* Copied from selinux/selinux.h.
-   Should be replaced with #include <selinux/selinux.h>,
-   but first requires elimination of namespace collisions
-   between libselinux and libsepol. */
-extern const char *selinux_binary_policy_path(void);
-extern security_class_t string_to_security_class(const char *name);
-extern access_vector_t string_to_av_perm(security_class_t tclass, const char *name);
-extern int security_policyvers(void);
-extern int is_selinux_enabled(void);
-
 void usage(char *progname, int rc) 
 {
  	fprintf(stderr, "usage:  %s [-p policy] < /var/log/audit/audit.log\n", progname);
@@ -39,10 +30,10 @@ int main(int argc, char **argv) 
 	FILE *fp;
 	int opt, rc, set_path = 0;
 	char *p, *scon, *tcon, *tclassstr, *permstr;
-	security_id_t ssid, tsid;
-	security_class_t tclass;
-	access_vector_t perm, av;
-	struct av_decision avd;
+	sepol_security_id_t ssid, tsid;
+	sepol_security_class_t tclass;
+	sepol_access_vector_t perm, av;
+	struct sepol_av_decision avd;
 	unsigned int reason;
 	int vers = 0;
 

--=-5QWBcRjwIELS04SY9qsn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
