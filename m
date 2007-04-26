Subject: [PATCH 4/6] libsemanage:  update for interface change to libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:55:18 -0400
Message-Id: <1177595718.24282.337.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update libsemanage for the interface change to
security_set_boolean_list (removal of permanent flag).

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsemanage/src/booleans_activedb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: policyrep/libsemanage/src/booleans_activedb.c
===================================================================
--- policyrep/libsemanage/src/booleans_activedb.c	(revision 2382)
+++ policyrep/libsemanage/src/booleans_activedb.c	(working copy)
@@ -119,7 +119,7 @@
 	}
 
 	/* Commit */
-	if (security_set_boolean_list(bcount, blist, 0) < 0) {
+	if (security_set_boolean_list(bcount, blist) < 0) {
 		ERR(handle, "libselinux commit failed");
 		goto err;
 	}

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
