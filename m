Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5MLgSrT012125
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 17:42:30 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5MLgP9A027054
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 21:42:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i5MLgQe1014045
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 17:42:26 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i5MLgQ025874
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 17:42:26 -0400
Received: from [172.16.67.52] (optimus-prime.boston.redhat.com [172.16.67.52])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i5MLgP8A019739
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 17:42:25 -0400
Subject: generic pam authentication
From: Colin Walters <walters@verbum.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-60lHQtWoVju+gJel0Hd2"
Date: Tue, 22 Jun 2004 17:41:20 -0400
Message-Id: <1087940480.17038.96.camel@optimus-prime.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-60lHQtWoVju+gJel0Hd2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to configure my system to use Kerberos, and I've been hacking
Kerry Thompson's kerberos.te.  One issue that has seemed common among
many programs is that they require many additional privileges when
pam_krb5 is inserted into the stack.  For example, when I use "passwd",
I get at least:

allow passwd_t krb5_conf_t:file { getattr };
allow passwd_t net_conf_t:file { read };
allow passwd_t passwd_t:udp_socket { create };
allow passwd_t urandom_device_t:chr_file { read };

What I think might be nice is a generic macro, say uses_pam(passwd)
which would grant any privileges necessary to use the libraries in the
PAM stack.  This macro would be defined in domains/pam.te, and would be
intended for customization by the administrator.  For example, if the
administrator decided to use PostgreSQL for holding user data, they
could insert the necessary privileges to talk to postgresql_port_t.

Before doing something this invasive, I'd like to see what opinions are.


--=-60lHQtWoVju+gJel0Hd2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2KeAOIkJWWp2WGURAo6bAJ9K/Yup4H3XKkT4pU7L7RGrkEBAVwCbBtEK
7IakkFSuvAKXlwL59Loovv0=
=tGyu
-----END PGP SIGNATURE-----

--=-60lHQtWoVju+gJel0Hd2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
