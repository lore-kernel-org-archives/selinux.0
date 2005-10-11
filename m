Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>
References: <43454A61.8010907@cornell.edu>
	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>
	 <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
	 <4346CE4C.1030201@tresys.com>
	 <1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>
	 <4346D745.6080203@tresys.com>
	 <1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>
	 <4346DD70.1070806@tresys.com>
	 <1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-/QU4RXT5iaV5PCAIhmm/"
Date: Tue, 11 Oct 2005 16:05:17 -0400
Message-Id: <1129061117.3308.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/QU4RXT5iaV5PCAIhmm/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-10-11 at 15:15 -0400, Stephen Smalley wrote:
> Patch below fixes this logic to make (1) consistent with the version
> selection in semanage_expand_sandbox (i.e. use security_policyvers() if
> it is in the range supported by the shared libsepol, otherwise use the
> sh->conf->policyvers, which will be sepol_policy_kern_vers_max() by
> default), and drops the dead code from (2).  But note that in the case
> where semanage.conf sets the policy version to anything other than the
> default, load_policy won't know about it, and no longer honors the path
> argument, so it won't load that policy.  I think I'll change
> selinux_mkload_policy to also check whether security_policyvers() falls
> outside of the libsepol supported range and fall back to
> sepol_policy_kern_vers_max() in that case.  But the policy version
> setting in semanage.conf is still useless.

Patch for libselinux is below.  The real cases are:
1) kernel policyvers falls within the libsepol supported range, in which
case libsemanage and libselinux will use the kernel policyvers for
generation and loading, or
2) kernel policyvers is higher than libsepol max, in which case
libsemanage and libselinux will use the libsepol max for generation and
loading (which the kernel will still accept),
3) kernel policyvers is less than libsepol min.  If this truly happens,
it is fatal, as it means that we cannot generate policy for the kernel.
However, it should never happen as libsepol provides backward
compatibility starting with the first policyvers ever supported by a 2.6
kernel.  At present, this also falls back to the libsepol max for
generation and loading as in (2); I suppose it should be altered to just
fail immediately.  I was originally thinking that we should still try
the libsepol max as a fallback in this case, as security_policyvers()
might return -1 due to a permission denial on /selinux/policyvers, but
immediate failure likely is more sensible.
 
-- 
Stephen Smalley
National Security Agency

--=-/QU4RXT5iaV5PCAIhmm/
Content-Disposition: attachment; filename=libselinux-1.27.8.diff
Content-Type: text/x-patch; name=libselinux-1.27.8.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/ChangeLog
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/ChangeLog,v
retrieving revision 1.149
retrieving revision 1.150
diff -u -p -r1.149 -r1.150
--- libselinux/ChangeLog	6 Oct 2005 18:19:32 -0000	1.149
+++ libselinux/ChangeLog	11 Oct 2005 19:38:16 -0000	1.150
@@ -1,3 +1,8 @@
+1.27.8 2005-10-11
+	* Changed selinux_mkload_policy to fall back to the maximum
+	policy version supported by libsepol if the kernel policy version
+	falls outside of the supported range.
+
 1.27.7 2005-10-06
 	* Changed getseuserbyname to fall back to the Linux username and
 	NULL level if seusers config file doesn't exist unless 
Index: libselinux/VERSION
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/VERSION,v
retrieving revision 1.67
retrieving revision 1.68
diff -u -p -r1.67 -r1.68
--- libselinux/VERSION	6 Oct 2005 18:19:32 -0000	1.67
+++ libselinux/VERSION	11 Oct 2005 19:38:16 -0000	1.68
@@ -1 +1 @@
-1.27.7
+1.27.8
Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -p -r1.8 -r1.9
--- libselinux/src/load_policy.c	6 Oct 2005 16:18:13 -0000	1.8
+++ libselinux/src/load_policy.c	11 Oct 2005 19:38:17 -0000	1.9
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include "selinux_internal.h"
 #include <sepol/sepol.h>
+#include <sepol/policydb.h>
 #include "policy.h"
 #include <limits.h>
 
@@ -43,13 +44,13 @@ int selinux_mkload_policy(int preservebo
 	void *map, *data;
 	int fd, rc = -1, *values, len, i, prot;
 
-	if (vers < 0)
-		return -1;
+	if (vers < sepol_policy_kern_vers_min() || vers > sepol_policy_kern_vers_max())
+		vers = sepol_policy_kern_vers_max();
 
 	snprintf(path, sizeof(path), "%s.%d", 
 		 selinux_binary_policy_path(), vers);
 	fd = open(path, O_RDONLY);
-	while (fd < 0 && errno == ENOENT && --vers > 0) {
+	while (fd < 0 && errno == ENOENT && --vers >= sepol_policy_kern_vers_min()) {
 		/* Check prior versions to see if old policy is available */
 		snprintf(path, sizeof(path), "%s.%d", 
 			 selinux_binary_policy_path(), vers);

--=-/QU4RXT5iaV5PCAIhmm/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
