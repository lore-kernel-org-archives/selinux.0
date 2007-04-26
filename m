Subject: [PATCH 5/6] audit2why:  update for interface change to libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:56:54 -0400
Message-Id: <1177595814.24282.339.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update audit2why for the removal of sepol_gen*_policydb
from libsepol.  These are obsolete with managed policy.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 policycoreutils/audit2why/audit2why.c |   14 --------------
 1 file changed, 14 deletions(-)

Index: policyrep/policycoreutils/audit2why/audit2why.c
===================================================================
--- policyrep/policycoreutils/audit2why/audit2why.c	(revision 2382)
+++ policyrep/policycoreutils/audit2why/audit2why.c	(working copy)
@@ -111,20 +111,6 @@
 	fclose(fp);
 	sepol_set_policydb(&policydb);
 
-	if (!set_path) {
-		/* If they didn't specify a full path of a binary policy file,
-		   then also try loading any boolean settings and user
-		   definitions from the active locations.  Otherwise,
-		   they can use genpolbools and genpolusers to build a
-		   binary policy file that includes any desired settings
-		   and then apply audit2why -p to the resulting file. 
-		   Errors are non-fatal as such settings are optional. */
-		sepol_debug(0);
-		(void)sepol_genbools_policydb(&policydb,
-					      selinux_booleans_path());
-		(void)sepol_genusers_policydb(&policydb, selinux_users_path());
-	}
-
 	/* Initialize the sidtab for subsequent use by sepol_context_to_sid
 	   and sepol_compute_av_reason. */
 	rc = sepol_sidtab_init(&sidtab);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
