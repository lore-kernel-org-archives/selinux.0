Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2R6S3Do018867
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 01:28:03 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2R6RR7X024922
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 06:27:27 GMT
Subject: [ PATCH ] hal - create netlink socket
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-hrJU3tgQ6iaLaCs09wrj"
Date: Sun, 27 Mar 2005 01:32:53 -0500
Message-Id: <1111905173.3520.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-hrJU3tgQ6iaLaCs09wrj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Makes hal work again on my system....sort of

/usr/libexec/hald-probe-input denied { read } on mouse_device_t:chr_file
/usr/libexec/hald-addon-acpi denied { write } on acpid.socket
(apmd_var_run_t)
/usr/libexec/hald-add-selinux-mount-option denied { search } on /selinux
(security_t)
/usr/sbin/hald denied { getattr } on /dev/mapper/control (lvm_control_t)
/usr/sbin/dmidecode denied { read } on /dev/mem (memory_device_t)

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-hrJU3tgQ6iaLaCs09wrj
Content-Disposition: attachment; filename=hal_netlink.diff
Content-Type: text/x-patch; name=hal_netlink.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old/domains/program/hald.te policy/domains/program/hald.te
--- policy.old/domains/program/hald.te	2005-03-27 01:10:31.000000000 -0500
+++ policy/domains/program/hald.te	2005-03-27 01:25:30.000000000 -0500
@@ -31,6 +31,7 @@
 allow hald_t usr_t:file { getattr read };
 
 allow hald_t bin_t:file getattr;
+allow hald_t self:netlink_socket create_socket_perms;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
 can_network_server(hald_t)

--=-hrJU3tgQ6iaLaCs09wrj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
