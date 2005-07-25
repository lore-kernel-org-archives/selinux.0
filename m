Message-ID: <42E4EB74.2060202@redhat.com>
Date: Mon, 25 Jul 2005 09:39:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <SELinux@tycho.nsa.gov>
Subject: Unitialized variable in libsepol
Content-Type: multipart/mixed;
 boundary="------------050005070105050803000804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050005070105050803000804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 



--------------050005070105050803000804
Content-Type: text/x-patch;
 name="libsepol-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol-rhat.patch"

--- libsepol-1.7.5/src/policydb.c~	2005-07-18 15:05:31.000000000 -0400
+++ libsepol-1.7.5/src/policydb.c	2005-07-25 09:36:04.000000000 -0400
@@ -2428,7 +2428,7 @@
 
         len = buf[1];
         if (len != strlen(target_str)) {
-                printf("security:  policydb string length %zu does not match expected length %zu\n", len, strlen(policydb_str));
+                printf("security:  policydb string length %zu does not match expected length %zu\n", len, strlen(target_str));
                 return -1;
         }
 

--------------050005070105050803000804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
