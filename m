Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EMJM7C022211
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 18:19:22 -0400 (EDT)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3EMCnIT005727
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 22:12:49 GMT
Subject: Updates to yam [patch]
From: David Hampton <hampton-rh@rainbolthampton.net>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-CvvEWLA1PvU375bihS86"
Date: Thu, 14 Apr 2005 18:15:36 -0400
Message-Id: <1113516936.6056.45.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-CvvEWLA1PvU375bihS86
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch updates the (unused) yam policy to work with the
changes in the FC strict/1.23.10-2 policy.   It also fixes httpd access
the the files yam distributes, and suppresses an access denied error
message when webalizer runs.

David


--=-CvvEWLA1PvU375bihS86
Content-Disposition: attachment; filename=UDiffs.yam
Content-Type: text/x-patch; name=UDiffs.yam; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/unused/yam.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/unused/yam.te,v
retrieving revision 1.1
diff -u -r1.1 yam.te
--- domains/program/unused/yam.te	31 Mar 2005 15:50:47 -0000	1.1
+++ domains/program/unused/yam.te	14 Apr 2005 21:12:19 -0000
@@ -57,7 +57,9 @@
 # Rsync and lftp need to network.  They also set files attributes to
 # match whats on the remote server.
 can_network_client($1_t)
+allow $1_t { http_port_t rsync_port_t }:tcp_socket name_connect;
 allow $1_t self:capability { chown fowner fsetid dac_override };
+allow $1_t self:process execmem;
 
 # access to sysctl_kernel_t ( proc/sys/kernel/* )
 read_sysctl($1_t)
@@ -94,9 +96,10 @@
 allow yam_t sysadm_devpts_t:chr_file { getattr ioctl read write };
 
 # Reading dotfiles...
-dontaudit yam_t staff_home_dir_t:dir search;		# /root
+allow yam_t sysadm_home_dir_t:dir search;		# /root
+allow yam_t sysadm_home_t:dir search;			# /root/xxx
 allow yam_t home_root_t:dir search;			# /home
-allow yam_t user_home_dir_t:dir { getattr search };	# /home/user
+allow yam_t user_home_dir_t:dir r_dir_perms;		# /home/user
 
 
 ##########
@@ -131,9 +134,11 @@
 # The whole point of this program is to make updates available on a
 # local web server.  Allow apache access to these files.
 ifdef(`apache.te', `
-allow httpd_t yam_content_t:dir { getattr search };
-allow httpd_t yam_content_t:file { getattr read };
-allow httpd_t yam_content_t:lnk_file { getattr read };
+r_dir_file(httpd_t, yam_content_t)
+')
+
+ifdef(`webalizer.te', `
+dontaudit webalizer_t yam_content_t:dir search;
 ')
 
 # Mount needs access to the yam directories in order to mount the ISO

--=-CvvEWLA1PvU375bihS86--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
