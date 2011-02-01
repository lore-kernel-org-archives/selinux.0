Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p12EuIVH010947
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2011 09:56:18 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p11Mbree010244
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2011 22:37:53 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p11MbqFn006490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2011 17:37:52 -0500
Received: from localhost.localdomain (vpn-8-85.rdu.redhat.com [10.11.8.85])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p11MbpTG020036
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2011 17:37:52 -0500
Message-ID: <4D488B3F.8030203@redhat.com>
Date: Tue, 01 Feb 2011 17:37:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: selinux man page fixes
Content-Type: multipart/mixed;
 boundary="------------040900000104000802030503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040900000104000802030503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------040900000104000802030503
Content-Type: text/plain;
 name="libselinux-man.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-man.patch"

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 5caa592..1fc5b95 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -1,7 +1,7 @@
 .TH  "selinux"  "8"  "29 Apr 2005" "dwalsh@redhat.com" "SELinux Command Line documentation"
 
 .SH "NAME"
-selinux \- NSA Security-Enhanced Linux (SELinux)
+SELinux \- NSA Security-Enhanced Linux (SELinux)
 
 .SH "DESCRIPTION"
 
@@ -62,12 +62,12 @@ compile-time tunable options and a set of runtime policy booleans.
 .B system-config-securitylevel
 allows customization of these booleans and tunables.
 
-Many domains that are protected by SELinux also include selinux man pages explainging how to customize their policy.  
+Many domains that are protected by SELinux also include SELinux man pages explaining how to customize their policy.  
 
 .SH FILE LABELING
 
 All files, directories, devices ... have a security context/label associated with them.  These context are stored in the extended attributes of the file system.
-Problems with SELinux often arise from the file system being mislabeled. This can be caused by booting the machine with a non selinux kernel.  If you see an error message containing file_t, that is usually a good indicator that you have a serious problem with file system labeling.  
+Problems with SELinux often arise from the file system being mislabeled. This can be caused by booting the machine with a non SELinux kernel.  If you see an error message containing file_t, that is usually a good indicator that you have a serious problem with file system labeling.  
 
 The best way to relabel the file system is to create the flag file /.autorelabel and reboot.  system-config-securitylevel, also has this capability.  The restorcon/fixfiles commands are also available for relabeling files. 
   

--------------040900000104000802030503
Content-Type: application/pgp-signature;
 name="libselinux-man.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-man.patch.sig"

iEYEABECAAYFAk1Iiz8ACgkQrlYvE4MpobN3TQCgrOngeK8q38PhSaVci4ZgqwqiXO4AoJEh
r/n3FF0Y0x37qDgL75hgy5T+
--------------040900000104000802030503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
