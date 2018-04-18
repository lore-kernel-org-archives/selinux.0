Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3IJf3Md007276
 for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2018 15:41:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 40RCCb3WTMz62rH
 for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2018 19:40:59 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 40RCCZ5jSkz62r8
 for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2018 19:40:58 +0000 (UTC)
To: selinux@tycho.nsa.gov
From: Jaap <jjb@xs4all.nl>
Message-ID: <10d21875-321f-28fb-3c94-92f91a06947a@xs4all.nl>
Date: Wed, 18 Apr 2018 21:40:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: selinux crashes always at startup
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


selinux crashes always at startup. problem is always reported (says 
selinux) But it does not get better.

from journalctl:


n systemd-journald[207]: Received SIGTERM from PID 1 (systemd).
Aug 15 20:43:44 localhost.localdomain kernel: systemd: 15 output lines 
suppressed due to ratelimiting
Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab hash 
slots, 107409 rules.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux: 32768 avtab hash 
slots, 107409 rules.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  8 users, 14 
roles, 5094 types, 312 bools, 1 sens, 1024 cats
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  94 classes, 
107409 rules
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
sctp_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
icmp_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
ax25_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class ipx_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
netrom_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
atmpvc_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class x25_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
rose_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
decnet_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
atmsvc_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class rds_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
irda_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
pppox_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class llc_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class can_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
tipc_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
bluetooth_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
iucv_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
rxrpc_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
isdn_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
phonet_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
ieee802154_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
caif_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class alg_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class nfc_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
vsock_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class kcm_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class 
qipcrtr_socket not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Class smc_socket 
not defined in policy.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux: the above unknown 
classes and permissions will be allowed
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Completing 
initialization.
Aug 15 20:43:44 localhost.localdomain kernel: SELinux:  Setting up 
existing superblocks.
