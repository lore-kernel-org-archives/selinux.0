Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i66083rT026812
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 20:08:04 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6607gEZ018584
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2004 00:07:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: dnsmasq policy advice
Date: Tue, 6 Jul 2004 10:06:02 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040703032852.GA23857@yggdrasil.localdomain> <20040704124436.GA3976@yggdrasil.localdomain> <20040705161325.GA7712@yggdrasil.localdomain>
In-Reply-To: <20040705161325.GA7712@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qze6AtXtjaXihdD"
Message-Id: <200407061006.02673.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_qze6AtXtjaXihdD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 6 Jul 2004 02:13, Greg Norris <haphazard@kc.rr.com> wrote:
> Based upon what you've told me, along with your network.te updates, the
> attached version ought to be the "final" incarnation.  I think the
> policy would be helpful to others as well, so I'd like to get it
> included upstream if possible.  Can you do this?  If not, can you tell
> me who I need to contact?

I've put it in my tree with a few minor changes.

I ordered the capabilities.

When only one access is allowed I removed the {}.

For the file_type_auto_trans() rule I specified that it should only apply to 
class file.

I removed an apostrophy in a comment to avoid any future problems with M4 
macros.

Steve, I think that this is ready for upstream inclusion along with the 
net_contexts changes previously discussed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_qze6AtXtjaXihdD
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dnsmasq.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dnsmasq.te"

#DESC dnsmasq - DNS forwarder and DHCP server
#
# Author: Greg Norris <adric@debian.org>
# X-Debian-Packages: dnsmasq
#

#################################
#
# Rules for the dnsmasq_t domain.
#
daemon_domain(dnsmasq);
type dnsmasq_lease_t, file_type, sysadmfile;

# misc. requirements
allow dnsmasq_t self:capability { setgid setuid net_bind_service net_raw };
allow dnsmasq_t urandom_device_t:chr_file read;

# network-related goodies
can_network(dnsmasq_t)
allow dnsmasq_t self:packet_socket create_socket_perms;
allow dnsmasq_t self:unix_dgram_socket create_socket_perms;
allow dnsmasq_t self:unix_stream_socket create_stream_socket_perms;

# UDP ports 53 and 67
allow dnsmasq_t dhcpd_port_t:udp_socket name_bind;
allow dnsmasq_t dns_port_t:udp_socket name_bind;

# By default, dnsmasq binds to the wildcard address to listen for DNS requests.
# Comment out the following entry if you do not want to allow this behaviour.
allow dnsmasq_t node_inaddr_any_t:udp_socket node_bind;

# allow access to dnsmasq.conf
allow dnsmasq_t etc_t:file r_file_perms;

# dhcp leases
file_type_auto_trans(dnsmasq_t, var_lib_t, dnsmasq_lease_t, file)

--Boundary-00=_qze6AtXtjaXihdD
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dnsmasq.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dnsmasq.fc"

# dnsmasq
/usr/sbin/dnsmasq		--	system_u:object_r:dnsmasq_exec_t
/var/lib/misc/dnsmasq\.leases	--	system_u:object_r:dnsmasq_lease_t
/var/run/dnsmasq\.pid		--	system_u:object_r:dnsmasq_var_run_t

--Boundary-00=_qze6AtXtjaXihdD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
