Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0QCXii0005561
 for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2014 07:33:44 -0500
Received: from localhost ([127.0.0.1])
 by l4ms.rz.uni-kiel.de with esmtp (Exim 4.80.1)
 (envelope-from <kliemann@philsem.uni-kiel.de>) id 1W7OuD-0005oo-W3
 for selinux@tycho.nsa.gov; Sun, 26 Jan 2014 13:33:42 +0100
Date: Sun, 26 Jan 2014 13:33:31 +0100
From: ole@plastictree.net
To: Frank C <frankc@networkcrypt.com>
Subject: Re: Strange context on unix_stream_socket
Message-ID: <20140126123331.GB2837@telmora.telvanni>
References: <20140125205944.GB2542@telmora.telvanni>
 <CAPJdAQCZ0W4Bbm5JGa+R4QQkkeddoZFdUn5icJyo07xAB7BvNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
In-Reply-To: <CAPJdAQCZ0W4Bbm5JGa+R4QQkkeddoZFdUn5icJyo07xAB7BvNw@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2014 at 06:01:51AM +0800, Frank C wrote:
> So does this mean that we have sockets that are left open for discussion
> that are not being used?  They all have to come out if they are not being
> used.  Unused sockets shouldn't pass a static analysis.

Thank you for your input. Unfortunately I cannot quite follow.=20
Could you please elaborate what your question is?

My problem is that a socket created by the accept system call=20
(see my follow-up posting) has not only a wrong context that=20
prevents access to it, but also a context that following the=20
policy it should not be able to acquire.


>=20
>=20
> On Sun, Jan 26, 2014 at 4:59 AM, Ole Kliemann <ole@plastictree.net> wrote:
>=20
> > I'm having an odd problem:
> >
> > I am running my own MCS constrainted policy on Ubuntu 12.04. At
> > some point I have a process with context
> >
> >     sub_t:s0:c20-s0:c20.c29
> >
> > From this process I try to access a jack daemon with mplayer. For
> > this purpose unix stream sockets are being used. I then get an
> > avc denial saying that
> >
> >     process sub_t:s0:c20-s0:c20.c29
> >
> > tried to access
> >
> >     unix_stream_socket sub_t:s0
> >
> > which is prohibited by mcs constrain. The socket is on sockfs and
> > has no file associated with it.
> >
> > The problem is that under no circumstances the policy allows the
> > creation of anything with 'sub_t:s0'.
> >
> > Using an auditallow rule like
> >
> >     auditallow any_type sub_t:unix_stream_socket { create relabelto
> > relabelfrom };
> >
> > clearly shows that indeed no socket with a context like that is
> > created nor relabel to.  And yet it exists.
> >
> >
> > I'd highly appreciate any hint on this matter. Including how to
> > debug further. How can I display the security context of a socket
> > on sockfs?
> >
> > Best regards
> > Ole
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
> >
> >
>=20
>=20
> --=20
>=20
> *Francis X. Cunnane III*
> frankc@networkcrypt.com
>=20
>=20
> This email and any files transmitted with it are confidential and intended
> solely for the use of the individual or entity to whom they are addressed.
> If you have received this email in error please notify the system manager.
> This message contains confidential information and is intended only for t=
he
> individual named. If you are not the named addressee you should not
> disseminate, distribute or copy this e-mail. Please notify the sender
> immediately by e-mail if you have received this e-mail by mistake and
> delete this e-mail from your system. If you are not the intended recipient
> you are notified that disclosing, copying, distributing or taking any
> action in reliance on the contents of this information is strictly
> prohibited.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlLlAJsACgkQS1FjE303ERw0NwCfTTddco7FnVDkZB/tkUs/aukm
6AUAn0ldB+wZMKEQlKVjBSqMcqpSCYYr
=aRCT
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
