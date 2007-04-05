Message-ID: <461541E2.8000402@tycho.nsa.gov>
Date: Thu, 05 Apr 2007 14:37:22 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: grant permissions on deny in permissive mode
References: <4615339A.1060700@tycho.nsa.gov>	 <1175794555.5711.78.camel@moss-spartans.epoch.ncsc.mil>	 <461538F3.1000905@tycho.nsa.gov> <1175795917.5711.97.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1175795917.5711.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch duplicates the kernel behavior of granting permissions
after a denial to avoid repeated AVC's, including flushing the cache
on a switch to enforcing mode.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---

 avc.c          |    9 ++++++---
 avc_internal.c |   12 ++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

Index: src/avc_internal.c
===================================================================
--- src/avc_internal.c	(revision 2318)
+++ src/avc_internal.c	(working copy)
@@ -163,6 +163,12 @@
 				    ("%s:  received setenforce notice (enforcing=%d)\n",
 				     avc_prefix, msg->val);
 				avc_enforcing = msg->val;
+				if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
+					avc_log
+					    ("%s:  cache reset returned %d (errno %d)\n",
+					     avc_prefix, rc, errno);
+					goto out;
+				}
 				break;
 			}
 
@@ -263,6 +269,12 @@
 				    ("%s:  received setenforce notice (enforcing=%d)\n",
 				     avc_prefix, msg->val);
 				avc_enforcing = msg->val;
+				if (avc_enforcing && (ret = avc_ss_reset(0)) < 0) {
+					avc_log
+					    ("%s:  cache reset returned %d (errno %d)\n",
+					     avc_prefix, ret, errno);
+					goto out;
+				}
 				break;
 			}
 
Index: src/avc.c
===================================================================
--- src/avc.c	(revision 2318)
+++ src/avc.c	(working copy)
@@ -982,9 +982,12 @@
 
 	denied = requested & ~(ae->avd.allowed);
 
-	if ((!requested || denied) && avc_enforcing) {
-		errno = EACCES;
-		rc = -1;
+	if (!requested || denied) {
+		if (avc_enforcing) {
+			errno = EACCES;
+			rc = -1;
+		} else
+			ae->avd.allowed |= requested;
 	}
 
       out:



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
