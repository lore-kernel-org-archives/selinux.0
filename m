Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NKASBX008693
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:10:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NKAQsr017719
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:10:26 GMT
Message-ID: <4604342C.2020507@redhat.com>
Date: Fri, 23 Mar 2007 16:10:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: netutils reads dev_sysfs
Content-Type: multipart/mixed;
 boundary="------------040208090909030404060302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040208090909030404060302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040208090909030404060302
Content-Type: text/x-patch;
 name="netutils.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netutils.patch"

--- nsaserefpolicy/policy/modules/admin/netutils.te	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/admin/netutils.te	2007-03-22 15:06:58.000000000 -0400
@@ -41,6 +42,8 @@
 manage_files_pattern(netutils_t,netutils_tmp_t,netutils_tmp_t)
 files_tmp_filetrans(netutils_t, netutils_tmp_t, { file dir })
 
+dev_read_sysfs(netutils_t)
+
 kernel_search_proc(netutils_t)
 
 corenet_non_ipsec_sendrecv(netutils_t)

--------------040208090909030404060302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
