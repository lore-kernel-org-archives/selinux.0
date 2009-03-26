Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2QAN5GD025448
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 06:23:05 -0400
Received: from asav4.lyse.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2QAN4U6029036
	for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2009 10:23:05 GMT
Date: Thu, 26 Mar 2009 11:22:56 +0100
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [Fwd: [idea] web-application security powered by SELinux]
Message-ID: <20090326102256.GA1353@janfrode.ibm.com>
References: <49C98427.8080300@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <49C98427.8080300@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2009 at 10:08:55AM +0900, KaiGai Kohei wrote:
>=20
> One idea is to add a security focused MPM which provide above features
> and hooks for external modules.
> I've actually developed a working example based on the "prefork" MPM.
> When it accepts a request from the client, it creates a one-time thread
> and assigns a new security context (which is a privileges set in SELinux),
> then invokes contents handler.
>=20
>   http://code.google.com/p/sepgsql/source/browse/misc/httpd-selinux/
>=20
> However, I don't adhere the current implementation as is.
> I would like to have a discussion to brush up the idea to achieve
> the goal and to get acceptance in the mainline.
>=20
> Any comments, questions and others are welcome.
>=20

I've been patiently hoping you would return to this idea, but it's
not quite tackling my problem. I was hoping for something more
similar to mod_privileges, where each virtual host is running in
a separate selinux domain. That would be very usefull for ISP's
offering virtual hostings to customers, and give the possibility
of giving guest_t shell access to multiple users with unique
namespaces.

It might not be necessary to run everything within the same apache
process, maybe launch one per virtual host would be OK. But full
mod_privileges-like support would be perfect.

Has anybody tackled something like that with selinux ?


  -jf

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJy1eA5zjUY2TLWqARAsa/AJ0UDmlyLBOKW9i3O7ARgOmq6x++5gCdGvqP
8JzJv1iW1yhe760A5d6RCNw=
=wSHp
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
