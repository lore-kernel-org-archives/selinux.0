Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA02370
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 04:30:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA10739
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 09:30:01 GMT
Received: from ultraviolet.org (freeside.ultraviolet.org [192.215.175.10])
	by jazzswing.ncsc.mil  with SMTP id JAA10735
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 09:30:01 GMT
Date: Wed, 21 Nov 2001 02:30:20 -0800
From: Tracy R Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux policy configuration tutorial?
Message-ID: <20011121023020.D6432@ultraviolet.org>
References: <20011116190059.L24702@ultraviolet.org> <Pine.GSO.4.33.0111190826490.24517-100000@raven> <20011121013204.C6432@ultraviolet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
In-Reply-To: <20011121013204.C6432@ultraviolet.org>; from treed@ultraviolet.org on Wed, Nov 21, 2001 at 01:32:04AM -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2001 at 01:32:04AM -0800, Tracy R Reed wrote:
> Just to make sure the newly installed files get assigned the right type
> and the policy gets compiled and loaded. But when I try to start apache I
> get permission denied:
>=20
> [root@tracy policy]# /etc/rc.d/init.d/httpd start
> Starting httpd: execvp: Permission denied

I just discovered in the docs:

No domain is currently allowed to bind http_port_t

Why have fully defined policies for running apache if it isn't allowed to
bind to the port? How can I allow this?

--=20
Tracy Reed      http://www.ultraviolet.org

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjv7gjwACgkQ9PIYKZYVAq05ngCeJcRMlmwHSWGV2NaI4Q5KcrZ0
8tYAn0TjzHSIzzEhVZ7CiRahaQdHkMsw
=llmS
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
