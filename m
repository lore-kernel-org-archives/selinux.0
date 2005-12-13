Message-ID: <439E1745.9050508@cornell.edu>
Date: Mon, 12 Dec 2005 19:35:17 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE] Fix memory leak in clear_obsolete
Content-Type: multipart/mixed;
 boundary="------------030606000109050001090009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030606000109050001090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------030606000109050001090009
Content-Type: text/x-patch;
 name="libsemanage.components_memory_leak.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.components_memory_leak.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-11-16 09:32:34.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-12-12 18:55:28.000000000 -0500
@@ -44,12 +44,13 @@ static int clear_obsolete(
 			/* FIXME: notice to user */	
                         /* INFO(handle, "boolean %s is obsolete, unsetting configured value..."); */
 		}
+
+		rtable->key_free(key);
 	}
 
 	for (i=0; i < nrecords; i++)	
 		rtable->free(records[i]);
 	free(records);
-	rtable->key_free(key);
 	return STATUS_SUCCESS;
 
 	err:

--------------030606000109050001090009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
