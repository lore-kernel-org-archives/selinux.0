From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: udev policy
Date: Wed, 13 Oct 2004 19:47:26 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_umPbBRWoTO1+MM2"
Message-Id: <200410131947.26149.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_umPbBRWoTO1+MM2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed with the latest version of udev.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_umPbBRWoTO1+MM2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- /usr/src/se/policy/file_contexts/program/udev.fc	2004-10-07 16:14:49.000000000 +1000
+++ file_contexts/program/udev.fc	2004-10-13 15:35:31.000000000 +1000
@@ -9,3 +9,4 @@
 /etc/hotplug.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb --	system_u:object_r:udev_tbl_t
+/sbin/wait_for_sysfs -- system_u:object_r:udev_exec_t

--Boundary-00=_umPbBRWoTO1+MM2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
