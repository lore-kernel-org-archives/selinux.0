Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8H0lKrT029274
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 20:47:20 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8H0kN8m021886
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 00:46:23 GMT
Date: Thu, 16 Sep 2004 19:47:08 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: policy for fetchmail (new)
Message-ID: <20040917004708.GA21413@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--CUfgB8w4ZwR/yMy5
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've written a policy for fetchmail (only required for daemon mode),
which I think is more-or-less ready to be incorporated into CVS.  At
the moment it only covers handing mail off to a local MTA (postfix in
my case), and not directly to a MDA such as procmail.  I do intend to
add procmail support in the future, but it may be some time... this
policy should be able to handle the majority usage, however.

As always, comments are most welcome.

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fetchmail.te"

#DESC fetchmail - remote-mail retrieval utility
#
# Author: Greg Norris <adric@debian.org>
# X-Debian-Packages: fetchmail
#
# Note: This policy is only required when running fetchmail in daemon mode.

#################################
#
# Rules for the fetchmail_t domain.
#
daemon_domain(fetchmail);
type fetchmail_etc_t, file_type, sysadmfile;
type fetchmail_uidl_cache_t, file_type, sysadmfile;

# misc. requirements
allow fetchmail_t self:process setrlimit;

# network-related goodies
can_network(fetchmail_t)
allow fetchmail_t self:unix_dgram_socket create_socket_perms;
allow fetchmail_t self:unix_stream_socket create_stream_socket_perms;

# file access
allow fetchmail_t etc_t:file r_file_perms;
allow fetchmail_t fetchmail_etc_t:file r_file_perms;
allow fetchmail_t mail_spool_t:dir search;
file_type_auto_trans(fetchmail_t, mail_spool_t, fetchmail_uidl_cache_t, file)

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fetchmail.fc"

# fetchmail
/etc/fetchmailrc			--	system_u:object_r:fetchmail_etc_t
/usr/bin/fetchmail			--	system_u:object_r:fetchmail_exec_t
/var/run/fetchmail			-d	system_u:object_r:fetchmail_var_run_t
/var/run/fetchmail/.+			--	system_u:object_r:fetchmail_var_run_t
/var/mail/\.fetchmail-UIDL-cache 	--	system_u:object_r:fetchmail_uidl_cache_t

--tThc/1wpZn/ma/RB--

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBSjQMgrEMyr8Cx2YRAprKAKC17+wo84kylKDt5mqJDEX2I0z7hwCfVVFt
SdstrOCZ3SeH+hwWEzdnAfc=
=49Cv
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
