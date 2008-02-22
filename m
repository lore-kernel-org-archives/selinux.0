Message-ID: <47BF5DCA.60601@tycho.nsa.gov>
Date: Fri, 22 Feb 2008 18:42:02 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: save errno value in avc_has_perm()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The errno value set by avc_has_perm_noaudit() is being lost somewhere in 
the bowels of avc_audit().  This patch saves it off so it doesn't get lost.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 libselinux/src/avc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2811)
+++ libselinux/src/avc.c	(working copy)
@@ -874,10 +874,12 @@
 		 struct avc_entry_ref *aeref, void *auditdata)
 {
 	struct av_decision avd = { 0, 0, 0, 0, 0 };
-	int rc;
+	int errsave, rc;
 
 	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
+	errsave = errno;
 	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
+	errno = errsave;
 	return rc;
 }
 

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
