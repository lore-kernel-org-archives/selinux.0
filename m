Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6453BrT020567
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2004 01:03:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6452oD3013993
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2004 05:02:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: dnsmasq policy advice
Date: Sun, 4 Jul 2004 15:02:59 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040703032852.GA23857@yggdrasil.localdomain> <200407031834.02192.russell@coker.com.au> <20040703153007.GA25813@yggdrasil.localdomain>
In-Reply-To: <20040703153007.GA25813@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D+45A8IbBfwltL5"
Message-Id: <200407041502.59456.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_D+45A8IbBfwltL5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 4 Jul 2004 01:30, Greg Norris <haphazard@kc.rr.com> wrote:
> On Sat, Jul 03, 2004 at 06:34:02PM +1000, Russell Coker wrote:
> > I've attached a modified version of types/network.te to make the
> > dns_port_t declaration more sane and modified your dnsmask.te to work
> > with other policy and not multiply declare types.
>
> Actually, I made some modifications to net_contexts to handle that. I
> wasn't really thinking of that piece at the time... I guess I should
> have included it as well (it's attached, along with the diff).  I'm not
> sure if that's any better than using network.te or not, but it seemed
> to fit in fairly seamlessly.  I'd appreciate your comments, as I really
> want the final version (which I'm hoping to get included upstream) to
> be "correct".

I think that types/network.te is the best place.  Then we can have one file to 
handle all code related to multiple domains accessing the one port.

> Also, I'm not sure why the "node_inaddr_any_t:udp_socket { node_bind }"
> entry was removed.  This is definitely required in dnsmasq's default

Doesn't can_network() cover that?


I've attached a patch to the network policy to move some of the conditional 
stuff into types/network.te .  Steve, I think that this is worthy of 
including in Sourceforge.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_D+45A8IbBfwltL5
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="net.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="net.diff"

diff -ru policy-1.14/domains/program/unused/apache.te selinux-policy-default-1.14/domains/program/unused/apache.te
--- policy-1.14/domains/program/unused/apache.te	2004-06-18 02:48:04.000000000 +1000
+++ selinux-policy-default-1.14/domains/program/unused/apache.te	2004-07-04 14:42:33.000000000 +1000
@@ -20,7 +20,6 @@
 #
 ###############################################################################
 type http_port_t, port_type;
-type http_cache_port_t, port_type;
 
 #########################################################
 # Apache types
diff -ru policy-1.14/domains/program/unused/dhcpd.te selinux-policy-default-1.14/domains/program/unused/dhcpd.te
--- policy-1.14/domains/program/unused/dhcpd.te	2004-04-08 03:28:05.000000000 +1000
+++ selinux-policy-default-1.14/domains/program/unused/dhcpd.te	2004-07-04 14:44:11.000000000 +1000
@@ -17,8 +17,6 @@
 #
 daemon_domain(dhcpd)
 
-# for UDP port 67
-type dhcpd_port_t, port_type;
 allow dhcpd_t dhcpd_port_t:udp_socket name_bind;
 
 # for UDP port 4011
diff -ru policy-1.14/domains/program/unused/named.te selinux-policy-default-1.14/domains/program/unused/named.te
--- policy-1.14/domains/program/unused/named.te	2004-06-18 02:59:10.000000000 +1000
+++ selinux-policy-default-1.14/domains/program/unused/named.te	2004-07-03 18:26:38.000000000 +1000
@@ -10,7 +10,6 @@
 #
 # Rules for the named_t domain.
 #
-type dns_port_t, port_type;
 type rndc_port_t, port_type;
 
 daemon_domain(named)
diff -ru policy-1.14/domains/program/unused/nsd.te selinux-policy-default-1.14/domains/program/unused/nsd.te
--- policy-1.14/domains/program/unused/nsd.te	2004-03-18 05:22:56.000000000 +1100
+++ selinux-policy-default-1.14/domains/program/unused/nsd.te	2004-07-03 18:27:06.000000000 +1000
@@ -9,9 +9,6 @@
 #
 # Rules for the nsd_t domain.
 #
-ifdef(`named.te', `', `
-type dns_port_t, port_type;
-')
 
 daemon_domain(nsd)
 
diff -ru policy-1.14/domains/program/unused/squid.te selinux-policy-default-1.14/domains/program/unused/squid.te
--- policy-1.14/domains/program/unused/squid.te	2004-06-17 03:07:47.000000000 +1000
+++ selinux-policy-default-1.14/domains/program/unused/squid.te	2004-07-04 14:42:23.000000000 +1000
@@ -11,8 +11,6 @@
 # squid_t is the domain the squid process runs in
 ifdef(`apache.te',`
 can_tcp_connect(squid_t, httpd_t)
-', `
-type http_cache_port_t, port_type;
 ')
 
 daemon_domain(squid, `, web_client_domain')
diff -ru policy-1.14/domains/program/unused/tinydns.te selinux-policy-default-1.14/domains/program/unused/tinydns.te
--- policy-1.14/domains/program/unused/tinydns.te	2004-06-17 03:07:47.000000000 +1000
+++ selinux-policy-default-1.14/domains/program/unused/tinydns.te	2004-07-03 18:27:34.000000000 +1000
@@ -13,12 +13,6 @@
 #
 # Rules for the tinydns_t domain.
 #
-ifdef(`named.te', `', `
-ifdef(`nsd.te', `', `
-type dns_port_t, port_type;
-')dnl end if nsd.te
-')dnl end if named.te
-
 daemon_domain(tinydns)
 
 can_exec(tinydns_t, tinydns_exec_t)
diff -ru policy-1.14/net_contexts selinux-policy-default-1.14/net_contexts
--- policy-1.14/net_contexts	2004-06-17 03:07:41.000000000 +1000
+++ selinux-policy-default-1.14/net_contexts	2004-07-04 14:47:44.000000000 +1000
@@ -37,11 +37,6 @@
 portcon udp 892 system_u:object_r:inetd_port_t
 portcon tcp 901 system_u:object_r:biff_port_t
 ')
-ifdef(`cyrus.te', `define(`use_pop')')
-ifdef(`courier.te', `define(`use_pop')')
-ifdef(`perdition.te', `define(`use_pop')')
-ifdef(`dovecot.te', `define(`use_pop')')
-ifdef(`uwimap.te', `define(`use_pop')')
 ifdef(`ftpd.te', `
 portcon tcp 20 system_u:object_r:ftp_data_port_t
 portcon tcp 21 system_u:object_r:ftp_port_t
@@ -53,17 +48,11 @@
 portcon tcp 465 system_u:object_r:smtp_port_t
 portcon tcp 587 system_u:object_r:smtp_port_t
 ')
-ifdef(`named.te', `define(`dns_port')')
-ifdef(`nsd.te', `define(`dns_port')')
-ifdef(`tinydns.te', `define(`dns_port')')
-ifdef(`dns_port', `
+ifdef(`use_dns', `
 portcon udp 53 system_u:object_r:dns_port_t
 portcon tcp 53 system_u:object_r:dns_port_t
 ')
-ifdef(`dhcpd.te', `
-portcon udp 67  system_u:object_r:dhcpd_port_t
-define(`use_pxe')
-')
+ifdef(`use_dhcpd', `portcon udp 67  system_u:object_r:dhcpd_port_t')
 ifdef(`dhcpc.te', `portcon udp 68  system_u:object_r:dhcpc_port_t')
 ifdef(`tftpd.te', `portcon udp 69  system_u:object_r:tftp_port_t')
 ifdef(`fingerd.te', `portcon tcp 79  system_u:object_r:fingerd_port_t')
@@ -136,9 +125,6 @@
 portcon tcp 7000 system_u:object_r:gatekeeper_port_t
 ')
 ifdef(`dictd.te', `portcon tcp 2628 system_u:object_r:dict_port_t')
-ifdef(`pxe.te', `
-define(`use_pxe')
-')
 ifdef(`use_pxe', `portcon udp 4011 system_u:object_r:pxe_port_t')
 ifdef(`imazesrv.te',`
 portcon tcp 5323 system_u:object_r:imaze_port_t
@@ -183,8 +169,6 @@
 # 9433 is for YIFF
 portcon tcp 9433 system_u:object_r:soundd_port_t
 ')
-ifdef(`apache.te', `define(`use_http_cache')')
-ifdef(`squid.te', `define(`use_http_cache')')
 ifdef(`use_http_cache', `
 portcon tcp 3128  system_u:object_r:http_cache_port_t
 portcon tcp 8080  system_u:object_r:http_cache_port_t
diff -ru policy-1.14/types/network.te selinux-policy-default-1.14/types/network.te
--- policy-1.14/types/network.te	2004-05-12 02:33:23.000000000 +1000
+++ selinux-policy-default-1.14/types/network.te	2004-07-04 14:58:28.000000000 +1000
@@ -22,15 +22,36 @@
 #
 # Defines used by the te files need to be defined outside of net_constraints
 #
+ifdef(`named.te', `define(`use_dns')')
+ifdef(`nsd.te', `define(`use_dns')')
+ifdef(`tinydns.te', `define(`use_dns')')
+ifdef(`dnsmasq.te', `define(`use_dns')')
+ifdef(`use_dns', `
+type dns_port_t, port_type;
+')
+
+ifdef(`dhcpd.te', `define(`use_dhcpd')')
+ifdef(`dnsmasq.te', `define(`use_dhcpd')')
+ifdef(`use_dhcpd', `
+type dhcpd_port_t, port_type;
+')
+
 ifdef(`cyrus.te', `define(`use_pop')')
 ifdef(`courier.te', `define(`use_pop')')
 ifdef(`perdition.te', `define(`use_pop')')
 ifdef(`dovecot.te', `define(`use_pop')')
+ifdef(`uwimapd.te', `define(`use_pop')')
 ifdef(`use_pop', `
 type pop_port_t, port_type;
 ')
 ifdef(`apache.te', `define(`use_http_cache')')
 ifdef(`squid.te', `define(`use_http_cache')')
+ifdef(`use_http_cache', `
+type http_cache_port_t, port_type;
+')
+
+ifdef(`dhcpd.te', `define(`use_pxe')')
+ifdef(`pxe.te', `define(`use_pxe')')
 
 ############################################
 #

--Boundary-00=_D+45A8IbBfwltL5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
