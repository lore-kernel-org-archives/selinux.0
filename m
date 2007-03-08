Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FL5I5006592
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:21:05 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FL4Y3011580
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:21:04 GMT
Message-ID: <45F029DE.2060103@redhat.com>
Date: Thu, 08 Mar 2007 10:21:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: netutils needs to read sysfs
Content-Type: multipart/mixed;
 boundary="------------070005040803070701070702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070005040803070701070702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070005040803070701070702
Content-Type: text/x-patch;
 name="netutils.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netutils.patch"

--- nsaserefpolicy/policy/modules/admin/netutils.te	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/admin/netutils.te	2007-03-08 08:42:36.000000000 -0500
@@ -41,6 +42,8 @@
 manage_files_pattern(netutils_t,netutils_tmp_t,netutils_tmp_t)
 files_tmp_filetrans(netutils_t, netutils_tmp_t, { file dir })
 
+dev_read_sysfs(netutils_t)
+
 kernel_search_proc(netutils_t)
 
 corenet_non_ipsec_sendrecv(netutils_t)

--------------070005040803070701070702--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
