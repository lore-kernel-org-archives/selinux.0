Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6RGPPWv027571
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 12:25:30 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6RGPX02005701
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 16:25:33 GMT
Received: by ewy19 with SMTP id 19so1620854ewy.12
        for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 09:25:28 -0700 (PDT)
Date: Tue, 27 Jul 2010 18:25:23 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: help with a compiled policy and port 443
Message-ID: <20100727162522.GB10237@localhost.localdomain>
References: <4C4DF495.3000704@gmail.com>
 <1280241091.2673.51.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <1280241091.2673.51.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 27, 2010 at 10:31:31AM -0400, David P. Quigley wrote:
> On Mon, 2010-07-26 at 16:48 -0400, Ralph Blach wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >=20
> > good afternoon,
> > I happen to be a novice at selinux and wish more familiar with it.
> >=20
> > This worked before but it does not work now.
> >=20
> > I wish to put ssh on port 443
> >=20
> > Before I used the commands
> >=20
> >=20
> > semanage port -d -t http_port_t -p tcp 443
> > semanage port -a -t sshd_port_t -p tcp 443
> >=20
> > and these worked perfectly.
> >=20
> > Now I get the error
> >=20
> > semanage port -d -t http_port_t -p tcp 443
> > /usr/sbin/semanage: Port tcp/443 is defined in policy, cannot be deleted
> > [root@chipblach ~]#
> >=20
> >=20
> > How do I get around this and and get semanage to function?
> >=20
> >=20
> > what is a defined policy and how I edit it?
> >=20
> > Thanks
> >=20
>=20
> what I did was semanage port -m -t ssh_port_t -p tcp 443 and it added
> 443 to the list of ports for ssh_port_t. The issue is that 443 is still
> listed under the ports for http_port_t as well. If I remember correctly
> it should take the last change made as the label for the port. So even
> though it says 443 for http_port_t it will match the entry for
> ssh_port_t.

I do not think it works like that but i could be wrong. tcp 443 is defined =
in policy for httpd_t.

What you could do it use audit2allow to allow sshd to interact with http_po=
rt_t instead.
>=20
> Dave
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkxPCHIACgkQMlxVo39jgT8sbQCePpPeO3FrhwIaUUYqHq9CnnPe
azYAnA49DcrVFYygrJ8ryllkuoSY1c7F
=mefd
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
