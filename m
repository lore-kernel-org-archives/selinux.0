Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1NHvOA9007907
	for <selinux@tycho.nsa.gov>; Sat, 23 Feb 2008 12:57:24 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1NHvKLr029418
	for <selinux@tycho.nsa.gov>; Sat, 23 Feb 2008 17:57:21 GMT
Subject: [refpolicy] storage.if addition
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-NfnXwQLUXtrH7KyOzfKx"
Date: Sat, 23 Feb 2008 18:57:12 +0100
Message-Id: <1203789432.2668.2.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-NfnXwQLUXtrH7KyOzfKx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There is already a read and write interface to access
fixed_disk_device_t but I also need a read/write interface.

Attached patch should provide that.

--=-NfnXwQLUXtrH7KyOzfKx
Content-Disposition: attachment; filename=storage.if.patch
Content-Type: text/x-patch; name=storage.if.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20071214/policy/modules/kernel/storage.if	2007-10-29 19:35:32.000000000 +0100
+++ policy/modules/kernel/storage.if	2008-02-23 18:36:05.000000000 +0100
@@ -171,6 +171,37 @@
 
 ########################################
 ## <summary>
+##      Allow the caller to directly read and write to a fixed disk.
+##      This is extremly dangerous as it can bypass the
+##      SELinux protections for filesystem objects, and
+##      should only be used by trusted domains.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      The type of the process performing this action.
+##      </summary>
+## </param>
+#
+interface(`storage_raw_rw_fixed_disk',`
+	gen_require(`
+		attribute fixed_disk_raw_read;
+		attribute fixed_disk_raw_write;
+		type fixed_disk_device_t;
+	')
+
+	dev_list_all_dev_nodes($1)
+
+	allow $1 fixed_disk_device_t:blk_file read_blk_file_perms;
+	allow $1 fixed_disk_device_t:chr_file read_chr_file_perms;
+	typeattribute $1 fixed_disk_raw_read;
+
+	allow $1 fixed_disk_device_t:blk_file write_blk_file_perms;
+	allow $1 fixed_disk_device_t:chr_file write_chr_file_perms;
+	typeattribute $1 fixed_disk_raw_write;
+')
+
+########################################
+## <summary>
 ##	Create, read, write, and delete fixed disk device nodes.
 ## </summary>
 ## <param name="domain">

--=-NfnXwQLUXtrH7KyOzfKx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
