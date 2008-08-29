Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7TA7vpW006661
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 06:07:57 -0400
Received: from ey-out-1920.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7TA7unt016379
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 10:07:56 GMT
Received: by ey-out-1920.google.com with SMTP id 4so245761eyg.30
        for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 03:07:55 -0700 (PDT)
Subject: Re: About Domain Transition
From: Dominick Grift <domg472@gmail.com>
To: Hong <kindloaf@gmail.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <f00ed96d0808282045v633a018fsf06aa8a70b55474e@mail.gmail.com>
References: <f00ed96d0808281333i6fb890a9j85949806cbbf2179@mail.gmail.com>
	 <1219957912.11166.14.camel@sulphur.notebook.internal>
	 <f00ed96d0808282045v633a018fsf06aa8a70b55474e@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+0IWYgEVTHzOy90nQ320"
Date: Fri, 29 Aug 2008 12:07:53 +0200
Message-Id: <1220004473.12040.10.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+0IWYgEVTHzOy90nQ320
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-08-28 at 23:45 -0400, Hong wrote:
> Thanks Dominick, your comments are very helpful.
>=20
> I have another question.  Suppose there is a rule:
> type_transition  domain1_type  app_exec_t: process domain2_type;
>=20
> but domain1_type only has execute_no_trans over over app_exec_t:
> allow domain1_type app_exec_t: file execute_no_trans;
>=20
> Then what'll happen when a process within domain1_type executes a
> program with type app_exec_t?  Will it stay in domain1_type or the
> access is denied?

Good question. My bet is that it will be able to execute it but not
transition.

These things can be reproduced and referenced easily. Try it :)

define(`domain_transition_pattern',`
	allow $1 $2:file { getattr read execute };
	allow $1 $3:process transition;
	dontaudit $1 $3:process { noatsecure siginh rlimitinh };
type_transition $1 $2:process $3;
')

--=20
Dominick Grift <domg472@gmail.com>

--=-+0IWYgEVTHzOy90nQ320
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAki3ynEACgkQL00QnzrVtlwvPACeLS9hWTMUIwJ5eKH+AhoiQcxf
Er4AoJmRt8QZIEYsPpbaJS1BUWEoLa5a
=2I/f
-----END PGP SIGNATURE-----

--=-+0IWYgEVTHzOy90nQ320--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
