Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8H10krT029337
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 21:00:46 -0400 (EDT)
Received: from ms-smtp-03.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8H0xj8m022188
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 00:59:45 GMT
Date: Thu, 16 Sep 2004 20:00:07 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: policy for ddclient (new)
Message-ID: <20040917010007.GA21563@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--XF85m9dhOBO43t/C
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's another new policy which I hope is more-or-less ready for
inclusion in CVS.  This one is for ddclient, which is used to perform
DNS updates via DynDNS and similar services.  It's useful for those of
us with small, home networks.

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ddclient.te"

#DESC ddclient - Update dynamic IP address at DynDNS.org
#
# Author: Greg Norris <adric@debian.org>
# X-Debian-Packages: ddclient
#

#################################
#
# Rules for the ddclient_t domain.
#
daemon_domain(ddclient);
type ddclient_etc_t, file_type, sysadmfile;
type ddclient_var_t, file_type, sysadmfile;

base_file_read_access(ddclient_t)
can_exec(ddclient_t, shell_exec_t)

# ddclient can be launched by pppd
ifdef(`pppd.te',`domain_auto_trans(pppd_t, ddclient_exec_t, ddclient_t)')

# misc. requirements
allow ddclient_t self:fifo_file rw_file_perms;
allow ddclient_t self:unix_stream_socket create_socket_perms;
allow ddclient_t etc_t:file { getattr read };
allow ddclient_t etc_runtime_t:file r_file_perms;
allow ddclient_t ifconfig_exec_t:file { rx_file_perms execute_no_trans };
allow ddclient_t urandom_device_t:chr_file { read };
allow ddclient_t proc_t:file r_file_perms;
allow ddclient_t sysctl_net_t:dir { search };

# network-related goodies
can_network(ddclient_t)
allow ddclient_t self:unix_dgram_socket create_socket_perms;

# allow access to ddclient.conf and ddclient.cache
allow ddclient_t ddclient_etc_t:file r_file_perms;
allow ddclient_t ddclient_var_t:dir rw_dir_perms;
allow ddclient_t ddclient_var_t:file rw_file_perms;


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ddclient.fc"

# ddclient
/etc/ddclient.conf		--	system_u:object_r:ddclient_etc_t
/usr/sbin/ddclient		--	system_u:object_r:ddclient_exec_t
/var/cache/ddclient		-d	system_u:object_r:ddclient_var_t
/var/cache/ddclient/.*		--	system_u:object_r:ddclient_var_t
/var/run/ddclient\.pid		--	system_u:object_r:ddclient_var_run_t

--CE+1k2dSO48ffgeK--

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBSjcXgrEMyr8Cx2YRAlo+AJ0ckMT/jXH7dRh3pywDvztzRF4j3gCgjIgd
0G7HUFzGJdX+NXaN0Ra3Cfc=
=uY7H
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
