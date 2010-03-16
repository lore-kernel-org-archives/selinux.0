Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2GGZPem028586
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2010 12:35:25 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2GGZwuc029665
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2010 16:35:58 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2GGZNGf012256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2010 12:35:23 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2GGZMcY013312
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2010 12:35:22 -0400
Message-ID: <4B9FB34A.7020706@redhat.com>
Date: Tue, 16 Mar 2010 12:35:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Small patch to fix is_selinux_enabled man page.
Content-Type: multipart/mixed;
 boundary="------------020104090008080104030400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020104090008080104030400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020104090008080104030400
Content-Type: text/plain;
 name="libselinux-man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-man.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/is_selinux_enabled.3 libselinux-2.0.92/man/man3/is_selinux_enabled.3
--- nsalibselinux/man/man3/is_selinux_enabled.3	2009-03-06 14:41:45.000000000 -0500
+++ libselinux-2.0.92/man/man3/is_selinux_enabled.3	2010-03-15 15:00:16.000000000 -0400
@@ -1,4 +1,4 @@
-.TH "is_selinux_enabled" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
+.TH "is_selinux_enabled" "3" "7 Mar 2010" "russell@coker.com.au" "SELinux API documentation"
 .SH "NAME"
 is_selinux_enabled \- check whether SELinux is enabled
 
@@ -14,6 +14,7 @@
 .SH "DESCRIPTION"
 .B is_selinux_enabled
 returns 1 if SELinux is running or 0 if it is not. 
+On error, \-1 is returned.
 
 .B is_selinux_mls_enabled
 returns 1 if SELinux is running in MLS mode or 0 if it is not. 

--------------020104090008080104030400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
