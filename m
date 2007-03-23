Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NKc1BM010081
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:38:01 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NKc0sr023729
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:38:00 GMT
Message-ID: <46043AA2.3080203@redhat.com>
Date: Fri, 23 Mar 2007 16:37:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: dontaudit using firstboot fifo_file
Content-Type: multipart/mixed;
 boundary="------------090802040204030806020507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090802040204030806020507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

firstboot starts certain daemons (ntp) which attempt to access its fifo_file


--------------090802040204030806020507
Content-Type: text/x-patch;
 name="firstboot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="firstboot.patch"

--- nsaserefpolicy/policy/modules/admin/firstboot.if	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/admin/firstboot.if	2007-03-22 15:06:58.000000000 -0400
@@ -124,3 +124,21 @@
 
 	allow $1 firstboot_t:fifo_file { read write };
 ')
+
+########################################
+## <summary>
+##	dontaudit Read and Write to a firstboot unnamed pipe.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`firstboot_dontaudit_rw_pipes',`
+	gen_require(`
+		type firstboot_t;
+	')
+
+	dontaudit $1 firstboot_t:fifo_file { read write };
+')
--- nsaserefpolicy/policy/modules/services/ntp.te	2007-03-20 23:38:08.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/ntp.te	2007-03-22 15:06:59.000000000 -0400
@@ -131,6 +131,7 @@
 
 optional_policy(`
 	firstboot_dontaudit_use_fds(ntpd_t)
+	firstboot_dontaudit_rw_pipes(ntpd_t)
 ')
 
 optional_policy(`


--------------090802040204030806020507--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
