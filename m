Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8B3wULa013627
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:58:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8B3wTmw022036
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 03:58:29 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8B3wQ9d022033 for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 03:58:28 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 674C1C1B4
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 13:58:25 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31975-10 for <selinux@tycho.nsa.gov>;
 Thu, 11 Sep 2003 13:58:24 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 7FA86BF3C
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 13:58:24 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 37D5392722
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 13:58:23 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B1DFC7F06D
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 13:58:19 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: watchdog policy
Date: Thu, 11 Sep 2003 13:58:18 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aL/X/hoUBc9V8e2"
Message-Id: <200309111358.18962.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_aL/X/hoUBc9V8e2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a final version of my watchdog policy which should work fully 
and not cause your machine to lock during the reboot process.

Previous versions tended to lock machines and force a hardware reset (doing 
exactly what the watchdog is designed to prevent).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_aL/X/hoUBc9V8e2
Content-Type: text/plain;
  charset="us-ascii";
  name="watchdog.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="watchdog.te"

#DESC Watchdog - Software watchdog daemon
#
# Author:  Russell Coker <russell@coker.com.au>
# X-Debian-Packages: watchdog
#

#################################
#
# Rules for the watchdog_t domain.
#

daemon_domain(watchdog, `, privmail')
type watchdog_device_t, file_type;

log_domain(watchdog)

allow watchdog_t { etc_t }:file r_file_perms;
allow watchdog_t etc_t:lnk_file read;
allow watchdog_t self:unix_dgram_socket create_socket_perms;

allow watchdog_t proc_t:file r_file_perms;

allow watchdog_t self:capability { ipc_lock sys_nice };
allow watchdog_t self:fifo_file rw_file_perms;
allow watchdog_t self:unix_stream_socket create_socket_perms;
can_network(watchdog_t)
allow watchdog_t resolv_conf_t:file { getattr read };
allow watchdog_t self:udp_socket create_socket_perms;
allow watchdog_t bin_t:dir search;
allow watchdog_t bin_t:lnk_file read;
allow watchdog_t init_t:process signal;
allow watchdog_t kernel_t:process sigstop;

allow watchdog_t watchdog_device_t:chr_file { getattr write };

# for orderly shutdown
can_exec(watchdog_t, shell_exec_t)
allow watchdog_t domain:process { signal_perms getsession };
allow watchdog_t watchdog_t:capability { kill };
allow watchdog_t sbin_t:dir search;

# for updating mtab on umount
file_type_auto_trans(watchdog_t, etc_t, etc_runtime_t, file)

allow watchdog_t self:capability { sys_admin net_admin sys_boot };
allow watchdog_t fixed_disk_device_t:blk_file swapon;
allow watchdog_t { proc_t fs_t }:filesystem unmount;

# record the fact that we are going down
allow watchdog_t wtmp_t:file append;

# do not care about saving the random seed
dontaudit watchdog_t random_device_t:chr_file read;

--Boundary-00=_aL/X/hoUBc9V8e2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
