Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JA2srT011599
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 06:02:54 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JA2qNX002785
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 10:02:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: Additional rule files
Date: Sun, 19 Sep 2004 20:02:47 +1000
Cc: selinux@tycho.nsa.gov
References: <1094260356.29689.44.camel@wintermute.xmldesign.de> <200409052019.20060.russell@coker.com.au> <20040913225221.GA14736@wintermute.xmldesign.de>
In-Reply-To: <20040913225221.GA14736@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HlVTBpNQPiYoz0M"
Message-Id: <200409192002.47098.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_HlVTBpNQPiYoz0M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please try out the attached pptp.te and let me know how it goes.  I've put the 
necessary change to net_contexts in my tree too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_HlVTBpNQPiYoz0M
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pptp.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pptp.te"

#DESC poptop - PPTP daemon
#
# Author:  Erich Schubert
# X-Debian-Packages: pptp
#

#################################
#
# Rules for the pptpd_t domain, et al.
#
# pptpd_t is the domain for the pptpd program.
# pptpd_exec_t is the type of the pptpd executable.
#
daemon_domain(pptpd)
etc_domain(pptpd)

type pptp_port_t, port_type;
allow pptpd_t pptp_port_t:tcp_socket name_bind;

# can execute own apps (pptpctrl)
can_exec(pptpd_t, pptpd_exec_t)

# Use the network.
can_network(pptpd_t)
allow pptpd_t self:capability net_raw;
allow pptpd_t self:rawip_socket create_socket_perms;
allow pptpd_t node_t:rawip_socket node_bind;
allow pptpd_t self:unix_dgram_socket create_socket_perms;

# create pty for communication with pppd
can_create_pty(pptpd)

# find and execute pppd
allow pptpd_t sbin_t:dir { search };
domain_auto_trans(pptpd_t, pppd_exec_t, pppd_t)
allow pptpd_t pppd_t:process signal;

# allow pppd to access the pptp ptys
allow pppd_t pptpd_devpts_t:chr_file rw_file_perms;

# allow to read pppd options file
allow pptpd_t { pppd_etc_rw_t pppd_etc_t }:file { read getattr };
allow pptpd_t pppd_etc_t:dir { search };

# search /var/lib
allow pptpd_t var_lib_t:dir search;

# allow reading of nsswitch.conf etc.
allow pptpd_t etc_t:dir search;
allow pptpd_t etc_t:file { getattr read };

--Boundary-00=_HlVTBpNQPiYoz0M--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
