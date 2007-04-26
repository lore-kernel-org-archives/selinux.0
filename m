Subject: [PATCH 6/6] setsebool:  Update for interface change to libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:57:44 -0400
Message-Id: <1177595864.24282.341.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update setsebool for the interface change to
security_set_boolean_list (removal of permanent flag).

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 policycoreutils/setsebool/setsebool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: policyrep/policycoreutils/setsebool/setsebool.c
===================================================================
--- policyrep/policycoreutils/setsebool/setsebool.c	(revision 2382)
+++ policyrep/policycoreutils/setsebool/setsebool.c	(working copy)
@@ -78,7 +78,7 @@
 				    SELboolean * boollist)
 {
 
-	if (security_set_boolean_list(boolcnt, boollist, 0)) {
+	if (security_set_boolean_list(boolcnt, boollist)) {
 		if (errno == ENOENT)
 			fprintf(stderr, "Could not change active booleans: "
 				"Invalid boolean\n");

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
