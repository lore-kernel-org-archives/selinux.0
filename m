Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1129061117.3308.227.camel@moss-spartans.epoch.ncsc.mil>
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
	 <1129061117.3308.227.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-SKGgZ4lOo8cCvn8/dI/r"
Date: Tue, 11 Oct 2005 16:17:42 -0400
Message-Id: <1129061862.3308.231.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-SKGgZ4lOo8cCvn8/dI/r
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-10-11 at 16:05 -0400, Stephen Smalley wrote:
> Patch for libselinux is below.  The real cases are:
> 1) kernel policyvers falls within the libsepol supported range, in which
> case libsemanage and libselinux will use the kernel policyvers for
> generation and loading, or
> 2) kernel policyvers is higher than libsepol max, in which case
> libsemanage and libselinux will use the libsepol max for generation and
> loading (which the kernel will still accept),
> 3) kernel policyvers is less than libsepol min.  If this truly happens,
> it is fatal, as it means that we cannot generate policy for the kernel.
> However, it should never happen as libsepol provides backward
> compatibility starting with the first policyvers ever supported by a 2.6
> kernel.  At present, this also falls back to the libsepol max for
> generation and loading as in (2); I suppose it should be altered to just
> fail immediately.  I was originally thinking that we should still try
> the libsepol max as a fallback in this case, as security_policyvers()
> might return -1 due to a permission denial on /selinux/policyvers, but
> immediate failure likely is more sensible.

Ok, so further patches for libsemanage and libselinux below.  Now it
treats case (3) as an immediate error, and also drops any use of the
conf value, since it is useless and won't be honored by libselinux for
loading anyway.

-- 
Stephen Smalley
National Security Agency

--=-SKGgZ4lOo8cCvn8/dI/r
Content-Disposition: attachment; filename=libsemanage-vers2.patch
Content-Type: text/x-patch; name=libsemanage-vers2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.5
diff -u -p -r1.5 semanage_store.c
--- libsemanage/src/semanage_store.c	11 Oct 2005 19:11:46 -0000	1.5
+++ libsemanage/src/semanage_store.c	11 Oct 2005 20:01:07 -0000
@@ -828,9 +828,10 @@ static int semanage_install_active(seman
 	int retval = -3, r;
 	int policyvers = security_policyvers();
 
-	if (policyvers < sepol_policy_kern_vers_min() || 
-	    policyvers > sepol_policy_kern_vers_max())
-		policyvers = sh->conf->policyvers;
+	if (policyvers < sepol_policy_kern_vers_min())
+		return retval;
+	if (policyvers > sepol_policy_kern_vers_max())
+		policyvers = sepol_policy_kern_vers_max();
 
 	snprintf(running_policy, PATH_MAX, "%s.%d",
 		 selinux_binary_policy_path(), policyvers);
@@ -1177,9 +1178,10 @@ int semanage_expand_sandbox(semanage_han
 	int policyvers = security_policyvers();
 	FILE *outfile = NULL;
 
-	if (policyvers < sepol_policy_kern_vers_min() || 
-	    policyvers > sepol_policy_kern_vers_max())
-		policyvers = sh->conf->policyvers;
+	if (policyvers < sepol_policy_kern_vers_min())
+		return retval;
+	if (policyvers > sepol_policy_kern_vers_max())
+		policyvers = sepol_policy_kern_vers_max();
 
 	if (sepol_policydb_create(&out)) {
 		return -1;
@@ -1189,7 +1191,7 @@ int semanage_expand_sandbox(semanage_han
 		goto cleanup;
 	}
 	if (sepol_policydb_set_vers(out, policyvers)) {
-		semanage_write_error(sh, "Unknown/Invalid policy version %d.", sh->conf->policyvers);
+		semanage_write_error(sh, "Unknown/Invalid policy version %d.", policyvers);
 		goto cleanup;
 	}
 	if ((kernel_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {

--=-SKGgZ4lOo8cCvn8/dI/r
Content-Disposition: attachment; filename=libselinux-vers2.patch
Content-Type: text/x-patch; name=libselinux-vers2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.9
diff -u -p -r1.9 load_policy.c
--- libselinux/src/load_policy.c	11 Oct 2005 19:38:17 -0000	1.9
+++ libselinux/src/load_policy.c	11 Oct 2005 20:01:50 -0000
@@ -44,7 +44,9 @@ int selinux_mkload_policy(int preservebo
 	void *map, *data;
 	int fd, rc = -1, *values, len, i, prot;
 
-	if (vers < sepol_policy_kern_vers_min() || vers > sepol_policy_kern_vers_max())
+	if (vers < sepol_policy_kern_vers_min())
+		return -1;
+	if (vers > sepol_policy_kern_vers_max())
 		vers = sepol_policy_kern_vers_max();
 
 	snprintf(path, sizeof(path), "%s.%d", 

--=-SKGgZ4lOo8cCvn8/dI/r--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
