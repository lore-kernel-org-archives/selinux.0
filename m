Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i42HHQRb001305
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 13:17:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i42HHOYW024904
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 17:17:24 GMT
Received: from dns1.outlandz.net (dns1.outlandz.net [66.132.132.24])
        by jazzband.ncsc.mil  with ESMTP id i42HHKBf024901 for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 17:17:24 GMT
Subject: Tinydns Policy Files
From: "Matthew J. Fanto" <mattjf@uncompiled.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-lEdTT484AQUBYO6hL09A"
Message-Id: <1083518249.543.9.camel@ares>
Mime-Version: 1.0
Date: Sun, 02 May 2004 13:17:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-lEdTT484AQUBYO6hL09A
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here are updated policy files for tinydns. This is the first policy file
I've written, so I'd appreciate any feedback. This was written for
Debian stable.

-Matthew J. Fanto

--=-lEdTT484AQUBYO6hL09A
Content-Disposition: attachment; filename=tinydns.fc
Content-Type: text/plain; name=tinydns.fc; charset=us-ascii
Content-Transfer-Encoding: 7bit

# tinydns
/etc/tinydns?			system_u:object_r:tinydns_conf_t
/etc/tinydns/root(/.*)?		system_u:object_r:tinydns_conf_t
/etc/tinydns/env(/.*)?		system_u:object_r:tinydns_conf_t
/etc/tinydns/root/data* --      system_u:object_r:tinydns_zone_t
/etc/tinydns/run*	--	system_u:object_r:tinydns_exec_t
/etc/tinydns/log/run*	--	system_u:object_r:tinydns_exec_t
/usr/bin/tinydns*	--	system_u:object_r:tinydns_exec_t


--=-lEdTT484AQUBYO6hL09A
Content-Disposition: attachment; filename=tinydns.te
Content-Type: text/plain; name=tinydns.te; charset=us-ascii
Content-Transfer-Encoding: 7bit

#DESC TINYDNS - Policy file for the tinydns authoritative nameserver
#
# Author:  Matthew J. Fanto <mattjf@uncompiled.com>
# 
#   Based off Named policy file written by
# 	Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>,
# 	Russell Coker <russell@coker.com.au>
#
# X-Debian-Packages: djbdns-installer djbdns

# we only define tinydns_port_t if we aren't
# using named or nsd, as it would conflict
ifdef(`named.te', `', `
ifdef(`nsd.te', `', `
type tinydns_port_t, port_type;
')dnl end if nsd.te
')dnl end if named.te

daemon_domain(tinydns)

# allow programs in the tinydns_t domain to execute tinydns_exec_t binaries
can_exec(tinydns_t, tinydns_exec_t)

# type for tinydns config files (/etc/tinydns(/.*)?) but does not
# include zone files
type tinydns_conf_t, file_type, sysadmfile;

# for primary zone files (/etc/selinux/root/data)
type tinydns_zone_t, file_type, sysadmfile;

# allow tinydns access to a few files it needs
allow tinydns_t etc_t:file { getattr read };
allow tinydns_t etc_runtime_t:{ file lnk_file } { getattr read };
allow tinydns_t resolv_conf_t:file { getattr read };
allow tinydns_t sbin_t:dir search;

# tinydns can use the network
can_network(tinydns_t)
allow tinydns_t tinydns_port_t:{ udp_socket } name_bind;
can_udp_send(domain, tinydns_t)
can_udp_send(tinydns_t, domain)
allow tinydns_t self:unix_dgram_socket create_socket_perms;

# read configuration files and zone files
r_dir_file(tinydns_t, tinydns_conf_t)
r_dir_file(tinydns_t, tinydns_zone_t)

# tinydns writes to a fifo and multilog reads it
# this is used for logging
ifdef(`daemontools.te', `
allow tinydns_t svc_start_t:fd { use };
allow tinydns_t svc_start_t:fifo_file { write };
')	

# allow tinydns to read /proc/meminfo
allow tinydns_t proc_t:file { getattr read };

# allow tinydns to search /etc/tinydns/log
allow tinydns_t svc_log_t:dir { getattr search };

# allow tinydns to search /bin
allow tinydns_t bin_t:dir { search };

# allow tinydns to gettar svc_run_exec_t files
ifdef(`daemontools.te', `
can_exec(tinydns_t, svc_run_exec_t)
domain_auto_trans(tinydns_t, svc_run_exec_t, svc_run_t)
')

# Set capabilites
allow tinydns_t self:capability { sys_tty_config net_bind_service sys_chroot setgid setuid };

--=-lEdTT484AQUBYO6hL09A--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
