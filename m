Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12822
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 09:52:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA08815
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 14:50:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA08803 for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 14:50:10 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 55CDD92668
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 01:52:07 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 08EA2C32
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 15:52:00 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: nsd - the RIPE name server
Date: Tue, 19 Nov 2002 15:51:59 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_NYVTYEDIAALKNP6K2JI7"
Message-Id: <200211191551.59612.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_NYVTYEDIAALKNP6K2JI7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've been playing with nsd, the authoritative-only name server written by 
NLnet LABS under contract from the RIPE NCC.

I've attached a quick first-cut at a policy for it.

Steve, please do not put this in the CVS at this time.  There's a few things I 
will have to change.

I am sending it here so that interested people can play with it.


The person who said the following should now be happier:
> FWIW, your move to BIND9 discredits your SE-Linux efforts in my eyes...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_NYVTYEDIAALKNP6K2JI7
Content-Type: text/plain;
  charset="us-ascii";
  name="nsd.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nsd.fc"

# nsd
/etc/nsd(/.*)?       		system_u:object_r:nsd_conf_t
/usr/sbin/nsd      		system_u:object_r:nsd_exec_t
/var/run/nsd.pid		system_u:object_r:var_run_nsd_t

--------------Boundary-00=_NYVTYEDIAALKNP6K2JI7
Content-Type: text/plain;
  charset="us-ascii";
  name="nsd.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nsd.te"

#DESC Authoritative only name server
#
# Author: Russell Coker
# 
#

#################################
#
# Rules for the nsd_t domain.
#
ifdef(`named.te', `', `
type named_port_t, port_type;
')

daemon_domain(nsd)

# A type for configuration files of nsd
type nsd_conf_t, file_type, sysadmfile;
# A type for zone files
type nsd_zone_t, file_type, sysadmfile;

r_dir_file(nsd_t, { nsd_conf_t nsd_zone_t })
r_dir_file(initrc_t, nsd_conf_t)

# Use capabilities. Surplus capabilities may be allowed.
allow nsd_t self:capability { setuid setgid net_bind_service };
#allow nsd_t self:capability { setuid setgid net_bind_service chown fowner dac_override sys_nice };

allow nsd_t etc_t:{ file lnk_file } { getattr read };
#allow nsd_t etc_runtime_t:{ file lnk_file } { getattr read };
#allow nsd_t resolv_conf_t:file { getattr read };

# nsd can use network
can_network(nsd_t)
# allow UDP transfer to/from any program
ifdef(`named.te', `
can_udp_send(nsd_t, nsd_t)
can_udp_send(nsd_t, nsd_t)
can_tcp_connect(nsd_t, nsd_t)
')

#can_udp_send(domain, nsd_t)
#can_udp_send(nsd_t, domain)
#can_tcp_connect(domain, nsd_t)

# Bind to the named port.
allow nsd_t named_port_t:udp_socket name_bind;
allow nsd_t named_port_t:tcp_socket name_bind;

allow nsd_t self:unix_stream_socket create_stream_socket_perms;
allow nsd_t self:unix_dgram_socket create_socket_perms;

#allow nsd_t fs_t:filesystem getattr;

# Read sysctl kernel variables.
#allow nsd_t sysctl_t:dir r_dir_perms;
#allow nsd_t sysctl_kernel_t:dir r_dir_perms;
#allow nsd_t sysctl_kernel_t:file r_file_perms;

# Read /proc/cpuinfo.
#allow nsd_t proc_t:dir r_dir_perms;
#allow nsd_t proc_t:file r_file_perms;

# Read /dev/random.
#allow nsd_t device_t:dir r_dir_perms;
#allow nsd_t random_device_t:chr_file r_file_perms;

# Use a pipe created by self.
#allow nsd_t self:fifo_file rw_file_perms;

# Set own capabilities.
#allow nsd_t self:process setcap;


--------------Boundary-00=_NYVTYEDIAALKNP6K2JI7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
