Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4P2uPRb015112
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 22:56:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4P2rsar016797
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 02:53:55 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4P2rXQu016744
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 02:53:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: [patch] policy for nrpe
Date: Tue, 25 May 2004 12:48:22 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040523214406.GB6147@jmh.mhn.de>
In-Reply-To: <20040523214406.GB6147@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2PrsA/zB1Vk8iJk"
Message-Id: <200405251248.23006.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_2PrsA/zB1Vk8iJk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 24 May 2004 07:44, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> The attached patch adds policy support for nrpe.
> (nrpe stands for Nagios Remote Plugin Execution and is a client called
> from inetd which performs checks on a client on behalf of a Nagios
> server)

I have made a couple of changes.  I have labeled the port as inetd_port_t, 
there seems to be no benefit in having a different type as only inetd is used 
for binding to the port.  I have added support for running directly from 
inetd without tcpd (my personal preference for such things is to run nagios 
on the internal network and use netfilter to control access).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_2PrsA/zB1Vk8iJk
Content-Type: text/plain;
  charset="iso-8859-1";
  name="nrpe.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nrpe.te"

# DESC nrpe - Nagios Remote Plugin Execution
#
# Author: Thomas Bleher <ThomasBleher@gmx.de>
#
# Depends: tcpd.te
# X-Debian-Packages: nagios-nrpe-server
#
# This policy assumes that nrpe is called from inetd

daemon_base_domain(nrpe)
ifdef(`tcpd.te', `
domain_auto_trans(tcpd_t, nrpe_exec_t, nrpe_t)
')
domain_auto_trans(inetd_t, nrpe_exec_t, nrpe_t)

allow nrpe_t urandom_device_t:chr_file { getattr ioctl read };

allow nrpe_t self:fifo_file rw_file_perms;
# use sockets inherited from inetd
allow nrpe_t inetd_t:tcp_socket { ioctl read write };
allow nrpe_t devtty_t:chr_file { read write };

allow nrpe_t self:process setpgid;

etc_domain(nrpe)

# permissions for the scripts executed by nrpe
#
# call shell programs
can_exec(nrpe_t, { bin_t shell_exec_t ls_exec_t })
allow nrpe_t { bin_t sbin_t }:dir search;
# for /bin/sh
allow nrpe_t bin_t:lnk_file read;

# read /proc/meminfo, /proc/self/mounts and /etc/mtab
allow nrpe_t { self proc_t etc_runtime_t }:file { getattr read };

# you will have to add more permissions here, depending on the scripts you call!

--Boundary-00=_2PrsA/zB1Vk8iJk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
