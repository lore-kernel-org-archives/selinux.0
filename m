Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i63FUVrT019015
	for <selinux@tycho.nsa.gov>; Sat, 3 Jul 2004 11:30:31 -0400 (EDT)
Received: from ms-smtp-02.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i63FUT4K029400
	for <selinux@tycho.nsa.gov>; Sat, 3 Jul 2004 15:30:29 GMT
Date: Sat, 3 Jul 2004 10:30:07 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dnsmasq policy advice
Message-ID: <20040703153007.GA25813@yggdrasil.localdomain>
References: <20040703032852.GA23857@yggdrasil.localdomain> <200407031834.02192.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
In-Reply-To: <200407031834.02192.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--IiVenqGWf+H9Y6IX
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 03, 2004 at 06:34:02PM +1000, Russell Coker wrote:
> I've attached a modified version of types/network.te to make the
> dns_port_t declaration more sane and modified your dnsmask.te to work
> with other policy and not multiply declare types.

Actually, I made some modifications to net_contexts to handle that. I
wasn't really thinking of that piece at the time... I guess I should
have included it as well (it's attached, along with the diff).  I'm not
sure if that's any better than using network.te or not, but it seemed
to fit in fairly seamlessly.  I'd appreciate your comments, as I really
want the final version (which I'm hoping to get included upstream) to
be "correct".

A couple of thoughts... dnsmasq provides both dns and dhcpd services,
so I'm thinking that the "ifdef(`dhcpd.te'" part isn't appropriate.  In
current versions (2.x), there's no dependency on an external dhcp
server.

Also, I'm not sure why the "node_inaddr_any_t:udp_socket { node_bind }"
entry was removed.  This is definitely required in dnsmasq's default
configuration, and the author makes a reasonable case (IMO) for why it
was coded that way.  I don't have the docs handy at the moment, but I'd
be happy to dig up the reference if you like.

> Also at the end I put in a file_type_auto_trans() rule because that
> seems to map to what you want to do.

Yes, that's exactly what I was intending.  Thanx!

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=net_contexts
Content-Transfer-Encoding: quoted-printable

# FLASK

#
# Security contexts for network entities
# If no context is specified, then a default initial SID is used.
#

# Modified by Reino Wallin <reino@oribium.com>
# Multi NIC, and IPSEC features

# Modified by Russell Coker
# ifdefs to encapsulate domains, and many additional port contexts

#
# Port numbers (default =3D initial SID "port")
#=20
# protocol number context
# protocol low-high context
#
ifdef(`inetd.te', `
portcon tcp 7 system_u:object_r:inetd_port_t
portcon udp 7 system_u:object_r:inetd_port_t
portcon tcp 9 system_u:object_r:inetd_port_t
portcon udp 9 system_u:object_r:inetd_port_t
portcon tcp 13 system_u:object_r:inetd_port_t
portcon udp 13 system_u:object_r:inetd_port_t
portcon tcp 19 system_u:object_r:inetd_port_t
portcon udp 19 system_u:object_r:inetd_port_t
portcon tcp 37 system_u:object_r:inetd_port_t
portcon udp 37 system_u:object_r:inetd_port_t
portcon tcp 113 system_u:object_r:inetd_port_t
portcon udp 512 system_u:object_r:biff_port_t
portcon udp 517 system_u:object_r:inetd_port_t
portcon tcp 891 system_u:object_r:inetd_port_t
portcon udp 891 system_u:object_r:inetd_port_t
portcon tcp 892 system_u:object_r:inetd_port_t
portcon udp 892 system_u:object_r:inetd_port_t
portcon tcp 901 system_u:object_r:biff_port_t
')
ifdef(`cyrus.te', `define(`use_pop')')
ifdef(`courier.te', `define(`use_pop')')
ifdef(`perdition.te', `define(`use_pop')')
ifdef(`dovecot.te', `define(`use_pop')')
ifdef(`uwimap.te', `define(`use_pop')')
ifdef(`ftpd.te', `
portcon tcp 20 system_u:object_r:ftp_data_port_t
portcon tcp 21 system_u:object_r:ftp_port_t
')
ifdef(`ssh.te', `portcon tcp 22 system_u:object_r:ssh_port_t')
ifdef(`inetd.te', `portcon tcp 23 system_u:object_r:telnet_port_t')
ifdef(`mta.te', `
portcon tcp 25 system_u:object_r:smtp_port_t
portcon tcp 465 system_u:object_r:smtp_port_t
portcon tcp 587 system_u:object_r:smtp_port_t
')
ifdef(`named.te', `define(`dns_port')')
ifdef(`nsd.te', `define(`dns_port')')
ifdef(`tinydns.te', `define(`dns_port')')
ifdef(`dnsmasq.te', `define(`dns_port')')
ifdef(`dns_port', `
portcon udp 53 system_u:object_r:dns_port_t
portcon tcp 53 system_u:object_r:dns_port_t
')
ifdef(`dhcpd.te', `
define(`dhcpd_port')
define(`use_pxe')
')
ifdef(`dnsmasq.te', `define(`dhcpd_port')')
ifdef(`dhcpd_port', `portcon udp 67 system_u:object_r:dhcpd_port_t')
ifdef(`dhcpc.te', `portcon udp 68  system_u:object_r:dhcpc_port_t')
ifdef(`tftpd.te', `portcon udp 69  system_u:object_r:tftp_port_t')
ifdef(`fingerd.te', `portcon tcp 79  system_u:object_r:fingerd_port_t')
ifdef(`apache.te', `
portcon tcp 80  system_u:object_r:http_port_t
portcon tcp 443  system_u:object_r:http_port_t
')
ifdef(`use_pop', `
portcon tcp 106 system_u:object_r:pop_port_t
portcon tcp 109 system_u:object_r:pop_port_t
portcon tcp 110 system_u:object_r:pop_port_t
')
ifdef(`portmap.te', `
portcon udp 111 system_u:object_r:portmap_port_t
portcon tcp 111 system_u:object_r:portmap_port_t
')
ifdef(`innd.te', `portcon tcp 119 system_u:object_r:innd_port_t')
ifdef(`ntpd.te', `portcon udp 123 system_u:object_r:ntp_port_t')
ifdef(`samba.te', `
portcon tcp 137 system_u:object_r:smbd_port_t
portcon udp 137 system_u:object_r:nmbd_port_t
portcon tcp 138 system_u:object_r:smbd_port_t
portcon udp 138 system_u:object_r:nmbd_port_t
portcon tcp 139 system_u:object_r:smbd_port_t
portcon udp 139 system_u:object_r:nmbd_port_t
portcon tcp 445 system_u:object_r:smbd_port_t
')
ifdef(`use_pop', `
portcon tcp 143 system_u:object_r:pop_port_t
portcon tcp 220 system_u:object_r:pop_port_t
')
ifdef(`snmpd.te', `
portcon udp 161 system_u:object_r:snmp_port_t
portcon udp 162 system_u:object_r:snmp_port_t
portcon tcp 199 system_u:object_r:snmp_port_t
')
ifdef(`use_pop', `portcon tcp 220 system_u:object_r:pop_port_t')
ifdef(`slapd.te', `portcon tcp 389 system_u:object_r:ldap_port_t')
ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogin_port_t')
ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
ifdef(`lpd.te', `portcon tcp 515 system_u:object_r:printer_port_t')
ifdef(`syslogd.te', `
portcon udp 514 system_u:object_r:syslogd_port_t
')
ifdef(`talk.te', `
portcon udp 517 system_u:object_r:talk_port_t
portcon udp 518 system_u:object_r:ntalk_port_t
')
ifdef(`cups.te', `
portcon tcp 631 system_u:object_r:ipp_port_t
portcon udp 631 system_u:object_r:ipp_port_t
')
ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
ifdef(`named.te', `portcon tcp 953 system_u:object_r:rndc_port_t')
ifdef(`use_pop', `
portcon tcp 993 system_u:object_r:pop_port_t
portcon tcp 995 system_u:object_r:pop_port_t
portcon tcp 1109 system_u:object_r:pop_port_t
')
ifdef(`nessusd.te', `portcon tcp 1241 system_u:object_r:nessus_port_t')
ifdef(`monopd.te', `portcon tcp 1234 system_u:object_r:monopd_port_t')
ifdef(`radius.te', `portcon udp 1645 system_u:object_r:radius_port_t
portcon udp 1646 system_u:object_r:radacct_port_t
portcon udp 1812 system_u:object_r:radius_port_t
portcon udp 1813 system_u:object_r:radacct_port_t')
ifdef(`gatekeeper.te', `
portcon udp 1718 system_u:object_r:gatekeeper_port_t
portcon udp 1719 system_u:object_r:gatekeeper_port_t
portcon tcp 1721 system_u:object_r:gatekeeper_port_t
portcon tcp 7000 system_u:object_r:gatekeeper_port_t
')
ifdef(`dictd.te', `portcon tcp 2628 system_u:object_r:dict_port_t')
ifdef(`mysqld.te', `portcon tcp 3306 system_u:object_r:mysqld_port_t')
ifdef(`pxe.te', `
define(`use_pxe')
')
ifdef(`use_pxe', `portcon udp 4011 system_u:object_r:pxe_port_t')
ifdef(`imazesrv.te',`
portcon tcp 5323 system_u:object_r:imaze_port_t
portcon udp 5323 system_u:object_r:imaze_port_t
')
ifdef(`jabberd.te', `
portcon tcp 5222 system_u:object_r:jabber_client_port_t
portcon tcp 5223 system_u:object_r:jabber_client_port_t
portcon tcp 5269 system_u:object_r:jabber_interserver_port_t
')
ifdef(`postgresql.te', `portcon tcp 5432 system_u:object_r:postgresql_port_=
t')
ifdef(`nrpe.te', `portcon tcp 5666 system_u:object_r:inetd_port_t')
ifdef(`xdm.te', `
portcon tcp 5900  system_u:object_r:vnc_port_t=20
')
ifdef(`use_x_ports', `
portcon tcp 6000  system_u:object_r:xserver_port_t
portcon tcp 6001  system_u:object_r:xserver_port_t
portcon tcp 6002  system_u:object_r:xserver_port_t
portcon tcp 6003  system_u:object_r:xserver_port_t
portcon tcp 6004  system_u:object_r:xserver_port_t
portcon tcp 6005  system_u:object_r:xserver_port_t
portcon tcp 6006  system_u:object_r:xserver_port_t
portcon tcp 6007  system_u:object_r:xserver_port_t
portcon tcp 6008  system_u:object_r:xserver_port_t
portcon tcp 6009  system_u:object_r:xserver_port_t
portcon tcp 6010  system_u:object_r:xserver_port_t
portcon tcp 6011  system_u:object_r:xserver_port_t
portcon tcp 6012  system_u:object_r:xserver_port_t
portcon tcp 6013  system_u:object_r:xserver_port_t
portcon tcp 6014  system_u:object_r:xserver_port_t
portcon tcp 6015  system_u:object_r:xserver_port_t
portcon tcp 6016  system_u:object_r:xserver_port_t
portcon tcp 6017  system_u:object_r:xserver_port_t
portcon tcp 6018  system_u:object_r:xserver_port_t
portcon tcp 6019  system_u:object_r:xserver_port_t
')
ifdef(`ircd.te', `portcon tcp 6667 system_u:object_r:ircd_port_t')
ifdef(`ciped.te', `portcon udp 7007 system_u:object_r:cipe_port_t')
ifdef(`sound-server.te', `
portcon tcp 8000 system_u:object_r:soundd_port_t
# 9433 is for YIFF
portcon tcp 9433 system_u:object_r:soundd_port_t
')
ifdef(`apache.te', `define(`use_http_cache')')
ifdef(`squid.te', `define(`use_http_cache')')
ifdef(`use_http_cache', `
portcon tcp 3128  system_u:object_r:http_cache_port_t
portcon tcp 8080  system_u:object_r:http_cache_port_t
portcon udp 3130  system_u:object_r:http_cache_port_t
')
ifdef(`transproxy.te', `portcon tcp 8081 system_u:object_r:transproxy_port_=
t')
ifdef(`amanda.te', `
portcon udp 10080 system_u:object_r:amanda_port_t
portcon tcp 10080 system_u:object_r:amanda_port_t
portcon udp 10081 system_u:object_r:amanda_port_t
portcon tcp 10081 system_u:object_r:amanda_port_t
portcon tcp 10082 system_u:object_r:amandaidx_port_t
portcon tcp 10083 system_u:object_r:amidxtape_port_t
')

# Network interfaces (default =3D initial SID "netif" and "netmsg")
#
# interface netif_context default_msg_context
#
netifcon lo system_u:object_r:netif_lo_t system_u:object_r:unlabeled_t
netifcon eth0 system_u:object_r:netif_eth0_t system_u:object_r:unlabeled_t
netifcon eth1 system_u:object_r:netif_eth1_t system_u:object_r:unlabeled_t
netifcon eth2 system_u:object_r:netif_eth2_t system_u:object_r:unlabeled_t
netifcon ippp0 system_u:object_r:netif_ippp0_t system_u:object_r:unlabeled_t
netifcon ipsec0 system_u:object_r:netif_ipsec0_t system_u:object_r:unlabele=
d_t
netifcon ipsec1 system_u:object_r:netif_ipsec1_t system_u:object_r:unlabele=
d_t
netifcon ipsec2 system_u:object_r:netif_ipsec2_t system_u:object_r:unlabele=
d_t

# Nodes (default =3D initial SID "node")
#
# address mask context
#
# The first matching entry is used.
#
nodecon 127.0.0.1	  255.255.255.255			   system_u:object_r:node_lo_t
nodecon 0.0.0.0		  255.255.255.255			   system_u:object_r:node_inaddr_any_t
nodecon ::		  ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff  system_u:object_r:no=
de_unspec_t
nodecon ::1		  ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff  system_u:object_r:n=
ode_lo_t
nodecon ff00::		  ff00::				   system_u:object_r:node_multicast_t
nodecon fe80::		  ffff:ffff:ffff:ffff::			   system_u:object_r:node_link_lo=
cal_t
nodecon fec0::		  ffc0::				   system_u:object_r:node_site_local_t
nodecon ::		  ffff:ffff:ffff:ffff:ffff:ffff::	   system_u:object_r:node_com=
pat_ipv4_t
nodecon ::ffff:0000:0000  ffff:ffff:ffff:ffff:ffff:ffff::	   system_u:objec=
t_r:node_mapped_ipv4_t

# FLASK

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="net_contexts.diff"

--- /usr/share/selinux/policy/default/net_contexts	2004-06-10 03:09:29.000000000 -0500
+++ /usr/share/selinux/policy/current/net_contexts	2004-06-28 19:08:30.000000000 -0500
@@ -56,14 +56,17 @@
 ifdef(`named.te', `define(`dns_port')')
 ifdef(`nsd.te', `define(`dns_port')')
 ifdef(`tinydns.te', `define(`dns_port')')
+ifdef(`dnsmasq.te', `define(`dns_port')')
 ifdef(`dns_port', `
 portcon udp 53 system_u:object_r:dns_port_t
 portcon tcp 53 system_u:object_r:dns_port_t
 ')
 ifdef(`dhcpd.te', `
-portcon udp 67  system_u:object_r:dhcpd_port_t
+define(`dhcpd_port')
 define(`use_pxe')
 ')
+ifdef(`dnsmasq.te', `define(`dhcpd_port')')
+ifdef(`dhcpd_port', `portcon udp 67 system_u:object_r:dhcpd_port_t')
 ifdef(`dhcpc.te', `portcon udp 68  system_u:object_r:dhcpc_port_t')
 ifdef(`tftpd.te', `portcon udp 69  system_u:object_r:tftp_port_t')
 ifdef(`fingerd.te', `portcon tcp 79  system_u:object_r:fingerd_port_t')

--zhXaljGHf11kAtnf--

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5tD/grEMyr8Cx2YRApKZAJ9i/+pd9LUY+sp3JwOPuM/zpube3gCdF931
Nm8DPMGsd1cS1nQBIO22gbo=
=FUFn
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
