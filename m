Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GL3kL9020132
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 16:03:46 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GL08Nj006161
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 21:00:09 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 16 Feb 2005 22:02:24 +0100
Date: Wed, 16 Feb 2005 22:02:28 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: ssh problems when no pty allocated
Message-Id: <20050216210227.GD5431@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am having some problems with ssh:
ssh works fine as long as I just call a shell. However, when ssh is
called like "ssh host command" it doesn't allocate a pty. See the
comment in domains/program/ssh.te:

# inheriting stream sockets is needed for "ssh host command" as no pty
# is allocated
allow unpriv_userdomain sshd_t:unix_stream_socket rw_stream_socket_perms;

This works for userdomains but breaks horribly when transitioning to
another domain. We use ssh for remote system administration here, so to
this date I had to add permissions to the following domains to access
the unix_stream_socket of sshd_t and send sigchld to sshd_t:
  dmesg_t hostname_t checkpolicy_t load_policy_t restorecon_t mount_t
  setfiles_t ldconfig_t sysadm_gpg_t bootloader_t user_ssh_agent_t rpm_t
More are probably needed.

I am not sure what the right way is to handle this problem, so I'm
asking here. Is it possible to just always allocate a pty? That seems to
be the most correct solution.
I wouldn't like to give every domain which can be called by a user
access to sshd_t:unix_stream_socket.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCE7TjD9qpeVMU938RAiJhAJ9ttmZeFI2hSmAzvnUlBtpMbui64gCgiVQ6
aaA4Mu98Ch44FlVzULTjGs0=
=X92p
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
