Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i42HJ9Rb001329
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 13:19:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i42HJ7YW024928
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 17:19:07 GMT
Received: from dns1.outlandz.net (dns1.outlandz.net [66.132.132.24])
        by jazzband.ncsc.mil  with ESMTP id i42HJ6Bf024925 for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 17:19:07 GMT
Subject: Dnscache Policy Files
From: "Matthew J. Fanto" <mattjf@uncompiled.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-LOEsmpEiqzzm6EV2CoaI"
Message-Id: <1083518357.543.12.camel@ares>
Mime-Version: 1.0
Date: Sun, 02 May 2004 13:19:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LOEsmpEiqzzm6EV2CoaI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here are policy files for Dnscache (the caching nameserver portion of
djbdns).

-Matthew J. Fanto

--=-LOEsmpEiqzzm6EV2CoaI
Content-Disposition: attachment; filename=dnscache.fc
Content-Type: text/plain; name=dnscache.fc; charset=us-ascii
Content-Transfer-Encoding: 7bit

# dnscache
/etc/dnscache?			system_u:object_r:dnscache_conf_t
/etc/dnscache/root(/.*)?	system_u:object_r:dnscache_conf_t
/etc/dnscache/env(/.*)?		system_u:object_r:dnscache_conf_t
/etc/dnscache/seed		system_u:object_r:dnscache_conf_t
/etc/dnscache/run*	--	system_u:object_r:dnscache_exec_t
/etc/dnscache/log/run*	--	system_u:object_r:dnscache_exec_t
/usr/bin/dnscache*	--	system_u:object_r:dnscache_exec_t

--=-LOEsmpEiqzzm6EV2CoaI
Content-Disposition: attachment; filename=dnscache.te
Content-Type: text/plain; name=dnscache.te; charset=us-ascii
Content-Transfer-Encoding: 7bit

#DESC DNSCACHE - Policy file for the dnscache recursive resolver
#
# Author:  Matthew J. Fanto <mattjf@uncompiled.com>
# 
#   Based off Named policy file written by
#	Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>,
#	Russell Coker <russell@coker.com.au>
#   
# X-Debian-Packages: djbdns-installer djbdns


# we only define dnscache_port_t if we aren't
# using named or nsd, as it would conflict
ifdef(`named.te', `', `
ifdef(`nsd.te', `', ` 
type dnscache_port_t, port_type;
')dnl end if nsd.te
')dnl end if named.te

daemon_domain(dnscache)

# allow programs in the dnscache_t domain to execute dnscache_exec_t binaries
can_exec(dnscache_t, dnscache_exec_t)

# type for dnscache config files (/etc/dnscache(/.*)?)
type dnscache_conf_t, file_type, sysadmfile;

# need to allow dnscache to access a few files
allow dnscache_t etc_t:file { getattr read };
allow dnscache_t etc_runtime_t:{ file lnk_file } { getattr read };
allow dnscache_t resolv_conf_t:file { getattr read };
allow dnscache_t sbin_t:dir search;

#dnscache can use the network
can_network(dnscache_t)
allow dnscache_t dnscache_port_t:{ udp_socket tcp_socket } name_bind;
can_udp_send(domain, dnscache_t)
can_udp_send(dnscache_t, domain)
can_tcp_connect(domain, dnscache_t)
allow dnscache_t self:unix_dgram_socket create_socket_perms;

#read configuration files
r_dir_file(dnscache_t, dnscache_conf_t)

# allow dnscache to read /dev/random
allow dnscache_t device_t:dir r_dir_perms;
allow dnscache_t random_device_t:chr_file r_file_perms;

# dnscache writes to a fifo and multilog reads it
# this is used for logging
ifdef(`daemontools.te', `
allow dnscache_t svc_start_t:fd { use };
allow dnscache_t svc_start_t:fifo_file { write };
')

--=-LOEsmpEiqzzm6EV2CoaI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
