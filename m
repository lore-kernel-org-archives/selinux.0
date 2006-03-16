Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2G0Y1gB005094
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 19:34:01 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2G0XwS2008033
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 00:33:58 GMT
Subject: one line fix for tor module
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 16 Mar 2006 01:33:19 +0100
Message-Id: <1142469199.16360.23.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Seems like I missed one statement for tor.
--- policy/modules/services/tor.te      (Revision 60)
+++ policy/modules/services/tor.te      (Arbeitskopie)
@@ -34,7 +34,7 @@
 allow tor_t self:fifo_file { read write };
 allow tor_t self:unix_stream_socket create_stream_socket_perms;
 allow tor_t self:netlink_route_socket r_netlink_socket_perms;
-allow tor_t self:tcp_socket create_socket_perms;
+allow tor_t self:tcp_socket { create_socket_perms accept };

 # configuration files
 allow tor_t tor_etc_t:dir r_dir_perms;


best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
      Which is worse: ignorance or apathy? Who knows? Who cares?      //\
 Jemanden zu lieben heißt glücklich zu sein, ihn glücklich zu sehen.  V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
