Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, SELinux-dev@tresys.com,
   Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <1129147889.26188.84.camel@moss-spartans.epoch.ncsc.mil>
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
	 <434C41D9.7010206@tresys.com>
	 <1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>
	 <434D2CFB.5040208@tresys.com>
	 <1129131866.3308.282.camel@moss-spartans.epoch.ncsc.mil>
	 <434D3792.7020606@tresys.com>
	 <1129134362.3308.316.camel@moss-spartans.epoch.ncsc.mil>
	 <434D5097.5060007@tresys.com>
	 <1129146727.26188.77.camel@moss-spartans.epoch.ncsc.mil>
	 <1129147889.26188.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-ywvDJmdmynSGNtX3bCXp"
Date: Thu, 13 Oct 2005 12:43:57 -0400
Message-Id: <1129221837.26188.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ywvDJmdmynSGNtX3bCXp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-10-12 at 16:11 -0400, Stephen Smalley wrote:
> On Wed, 2005-10-12 at 15:52 -0400, Stephen Smalley wrote:
> > - libsemanage always generates the latest policy version supported by
> > libsepol (the default), writing it to a versioned policy pathname with
> > that version number.  It doesn't use the kernel's policy version at all.
> > 
> > - libselinux always searches for a versioned filename with the highest
> > version <= the sepol max, opens and mmaps that file, uses the version
> > suffix to determine whether a downgrade is required, and downgrades if
> > necessary to the kernel's version.  This same logic applies both for the
> > managed case and the unmanaged case.
> 
> And, if the downgrade fails, libselinux keeps searching for a lower
> versioned filename until it finds one that can be downgraded or it finds
> one that doesn't need a downgrade (i.e. already at or below the kernel's
> version) or it passes the libsepol min (in which case it will just
> fail).  That provides the fallback case for incompatible changes.

Patches below for libsemanage and libselinux (after merging Ivan's
diffs).  libsemanage goes back to always using sh->conf->policyvers,
which is initialized to sepol_policy_kern_vers_max() but can be changed
in the config file, and libselinux tries to automatically downgrade.


-- 
Stephen Smalley
National Security Agency

--=-ywvDJmdmynSGNtX3bCXp
Content-Disposition: attachment; filename=libsemanage-confvers.patch
Content-Type: text/x-patch; name=libsemanage-confvers.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.7
diff -u -p -r1.7 semanage_store.c
--- libsemanage/src/semanage_store.c	13 Oct 2005 15:56:30 -0000	1.7
+++ libsemanage/src/semanage_store.c	13 Oct 2005 15:59:51 -0000
@@ -826,12 +826,7 @@ static int semanage_install_active(seman
 	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
 	const char *running_fc = selinux_file_context_path();
 	int retval = -3, r;
-	int policyvers = security_policyvers();
-
-	if (policyvers < sepol_policy_kern_vers_min())
-		return retval;
-	if (policyvers > sepol_policy_kern_vers_max())
-		policyvers = sepol_policy_kern_vers_max();
+	int policyvers = sh->conf->policyvers;
 
 	snprintf(running_policy, PATH_MAX, "%s.%d",
 		 selinux_binary_policy_path(), policyvers);
@@ -1186,7 +1181,7 @@ int semanage_expand_sandbox(semanage_han
 	int retval = -1;
 	const char *kernel_filename = NULL;
 	struct sepol_policy_file *pf = NULL;
-	int policyvers = security_policyvers();
+	int policyvers = sh->conf->policyvers;
 	FILE *outfile = NULL;
 
  	/* FIXME: deprecated - replace with callback debugging
@@ -1194,11 +1189,6 @@ int semanage_expand_sandbox(semanage_han
  	char buffer[1024];
  	buffer[0] = '\0';
 
-	if (policyvers < sepol_policy_kern_vers_min())
-		return retval;
-	if (policyvers > sepol_policy_kern_vers_max())
-		policyvers = sepol_policy_kern_vers_max();
-
 	if (sepol_policydb_create(&out)) {
 		return -1;
 	}

--=-ywvDJmdmynSGNtX3bCXp
Content-Disposition: attachment; filename=libselinux-load.patch
Content-Type: text/x-patch; name=libselinux-load.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.10
diff -u -p -r1.10 load_policy.c
--- libselinux/src/load_policy.c	11 Oct 2005 20:09:53 -0000	1.10
+++ libselinux/src/load_policy.c	13 Oct 2005 16:32:23 -0000
@@ -37,18 +37,17 @@ int load_setlocaldefs hidden = 1;
 
 int selinux_mkload_policy(int preservebools)
 {
-	int vers = security_policyvers();
+	int vers = sepol_policy_kern_vers_max();
+	int kernvers = security_policyvers();
 	char path[PATH_MAX], **names;
 	struct stat sb;
 	size_t size;
 	void *map, *data;
 	int fd, rc = -1, *values, len, i, prot;
+	sepol_policydb_t *policydb;
+	sepol_policy_file_t *pf;
 
-	if (vers < sepol_policy_kern_vers_min())
-		return -1;
-	if (vers > sepol_policy_kern_vers_max())
-		vers = sepol_policy_kern_vers_max();
-
+search:
 	snprintf(path, sizeof(path), "%s.%d", 
 		 selinux_binary_policy_path(), vers);
 	fd = open(path, O_RDONLY);
@@ -73,13 +72,46 @@ int selinux_mkload_policy(int preservebo
 	if (map == MAP_FAILED) 
 		goto close;
 
+	if (vers > kernvers) {
+		/* Need to downgrade to kernel-supported version. */
+		if (sepol_policy_file_create(&pf))
+			goto unmap;
+		if (sepol_policydb_create(&policydb)) {
+			sepol_policy_file_free(pf);
+			goto unmap;
+		}
+		sepol_policy_file_set_mem(pf, data, size);
+		if (sepol_policydb_read(policydb, pf)) {
+			sepol_policy_file_free(pf);
+			sepol_policydb_free(policydb);
+			goto unmap;
+		}
+		if (sepol_policydb_set_vers(policydb, kernvers) ||
+		    sepol_policydb_to_image(policydb, &data, &size)) {
+			/* Downgrade failed, keep searching. */
+			sepol_policy_file_free(pf);
+			sepol_policydb_free(policydb);
+			munmap(map, sb.st_size);
+			close(fd);			
+			vers--;
+			goto search;
+		}
+		sepol_policy_file_free(pf);
+		sepol_policydb_free(policydb);
+	}
+
 	if (load_setlocaldefs) {
-		rc = sepol_genusers(data, size, selinux_users_path(), &data, &size);
+		void *olddata = data;
+		size_t oldsize = size;
+		rc = sepol_genusers(olddata, oldsize, selinux_users_path(), &data, &size);
 		if (rc < 0) {
-			/* Fall back to the base image if genusers failed. */
-			data = map;
-			size = sb.st_size;
+			/* Fall back to the prior image if genusers failed. */
+			data = olddata;
+			size = oldsize;
 			rc = 0;
+		} else {
+			if (olddata != map)
+				free(olddata);
 		}
 	}
 

--=-ywvDJmdmynSGNtX3bCXp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
