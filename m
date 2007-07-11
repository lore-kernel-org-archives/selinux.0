Message-ID: <4694EE2F.5040204@redhat.com>
Date: Wed, 11 Jul 2007 10:50:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Add swigify directive to makefile in libselinux to allow rebuild
 of swigfiles in spec file.
Content-Type: multipart/mixed;
 boundary="------------000901000906050908010503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000901000906050908010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000901000906050908010503
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/Makefile libselinux-2.0.23/Makefile
--- nsalibselinux/Makefile	2007-06-01 10:44:08.000000000 -0400
+++ libselinux-2.0.23/Makefile	2007-06-26 05:11:37.000000000 -0400
@@ -20,6 +20,9 @@
 	$(MAKE) -C src 
 	$(MAKE) -C utils
 
+swigify: all
+	$(MAKE) -C src swigify
+
 pywrap: 
 	$(MAKE) -C src pywrap
 

--------------000901000906050908010503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
