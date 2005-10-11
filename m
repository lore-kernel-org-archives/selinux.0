Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4346DD70.1070806@tresys.com>
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
Content-Type: multipart/mixed; boundary="=-Vs1OCopGz5pmWtjmol0z"
Date: Tue, 11 Oct 2005 15:15:40 -0400
Message-Id: <1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Vs1OCopGz5pmWtjmol0z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-10-07 at 16:41 -0400, Joshua Brindle wrote:
> Sure, setting the policy version is probably not useful for most users, 
> it's more of a development/debugging option than anything.
> 
> What if the user wants to build a policy for the new kernel he just 
> installed? I guess a rebuild/reload after booting the kernel isn't bad, 
> although we don't provide a way to do that without starting a 
> transaction in the store.

libsemanage doesn't appear to support just building a policy without
loading it AFAICS.  And load_policy no longer honors the path argument,
so it will always load a version <= security_policyvers() for the
current kernel.

Also, I just noticed that:
1) semanage_install_active() blindly uses security_policyvers() as the
version suffix for the running policy path even prior to my changes,
without considering sh->conf->policyvers at all, and
2) semanage_install_sandbox() similarly constructs a running policy path
based solely on security_policyvers(), but never uses it.

Patch below fixes this logic to make (1) consistent with the version
selection in semanage_expand_sandbox (i.e. use security_policyvers() if
it is in the range supported by the shared libsepol, otherwise use the
sh->conf->policyvers, which will be sepol_policy_kern_vers_max() by
default), and drops the dead code from (2).  But note that in the case
where semanage.conf sets the policy version to anything other than the
default, load_policy won't know about it, and no longer honors the path
argument, so it won't load that policy.  I think I'll change
selinux_mkload_policy to also check whether security_policyvers() falls
outside of the libsepol supported range and fall back to
sepol_policy_kern_vers_max() in that case.  But the policy version
setting in semanage.conf is still useless.

-- 
Stephen Smalley
National Security Agency

--=-Vs1OCopGz5pmWtjmol0z
Content-Disposition: attachment; filename=libsemanage-fixvers.patch
Content-Type: text/x-patch; name=libsemanage-fixvers.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.4
diff -u -p -r1.4 semanage_store.c
--- libsemanage/src/semanage_store.c	7 Oct 2005 20:22:39 -0000	1.4
+++ libsemanage/src/semanage_store.c	11 Oct 2005 18:51:09 -0000
@@ -826,8 +826,14 @@ static int semanage_install_active(seman
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
 	const char *running_fc = selinux_file_context_path();
 	int retval = -3, r;
+	int policyvers = security_policyvers();
+
+	if (policyvers < sepol_policy_kern_vers_min() || 
+	    policyvers > sepol_policy_kern_vers_max())
+		policyvers = sh->conf->policyvers;
+
 	snprintf(running_policy, PATH_MAX, "%s.%d",
-		 selinux_binary_policy_path(), security_policyvers());
+		 selinux_binary_policy_path(), policyvers);
 	if (semanage_copy_file(active_kernel, running_policy) == -1) {
 		semanage_write_error(sh, "Could not copy %s to %s.", active_kernel, running_policy);
 		goto cleanup;
@@ -857,7 +863,6 @@ static int semanage_install_active(seman
  * atomically.	Returns 0 on success, -1 on error.
  */
 int semanage_install_sandbox(semanage_handle_t *sh) {
-	char running_policy[PATH_MAX];
 	int retval = -1, new_commit_number;
 
 	if (sh->conf->load_policy == NULL) {
@@ -869,9 +874,6 @@ int semanage_install_sandbox(semanage_ha
 		goto cleanup;
 	}
 
-	snprintf(running_policy, PATH_MAX, "%s.%d",
-		 selinux_binary_policy_path(), security_policyvers());
-
 	if ((new_commit_number = semanage_commit_sandbox(sh)) < 0) {
 		goto cleanup;
 	}

--=-Vs1OCopGz5pmWtjmol0z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
