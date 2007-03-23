Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NJoMqv007545
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 15:50:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NJoKU1007295
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 19:50:21 GMT
Message-ID: <46042F76.4010909@redhat.com>
Date: Fri, 23 Mar 2007 15:50:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: networkmanager now setpgid
Content-Type: multipart/mixed;
 boundary="------------020902020104040400050507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020902020104040400050507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020902020104040400050507
Content-Type: text/x-patch;
 name="networkmanager.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="networkmanager.patch"

--- nsaserefpolicy/policy/modules/services/networkmanager.te	2007-03-20 23:38:16.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/networkmanager.te	2007-03-22 15:06:59.000000000 -0400
@@ -22,7 +22,7 @@
 # and it receives a unexpected signal (rh bug #204161) 
 allow NetworkManager_t self:capability { kill setgid setuid sys_nice dac_override net_admin net_raw net_bind_service ipc_lock };
 dontaudit NetworkManager_t self:capability { sys_tty_config sys_ptrace };
-allow NetworkManager_t self:process { ptrace setcap getsched signal_perms };
+allow NetworkManager_t self:process { ptrace setcap setpgid getsched signal_perms };
 allow NetworkManager_t self:fifo_file rw_fifo_file_perms;
 allow NetworkManager_t self:unix_dgram_socket { sendto create_socket_perms };
 allow NetworkManager_t self:unix_stream_socket create_stream_socket_perms;

--------------020902020104040400050507--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
