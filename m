Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n88Gadkw009352
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 12:36:39 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n88GZw9T012726
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 16:35:59 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id n88GaTMu058100
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 18:36:29 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] ([147.32.84.251])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id n88GaSAX016387
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 18:36:29 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Tue, 8 Sep 2009 18:36:28 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: MCS and default labels
Message-ID: <20090908163628.GC24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
In-Reply-To: <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Stephen Smalley wrote:
> MCS deviates from this scheme by only using the high level and by
> requiring the user/application to intentionally label the objects as
> desired up to their high level - that is part of what makes it
> discretionary.

It is okay that the system is discretionary, and I don't question that
fact. I question the way labels get assigned *per default*. In
comparison to DAC, it would mean that all files are created with an=20
umask of 000 and are required to change the resulting permissions
afterwards. You can not expect that every application out there is
aware of MCS and/or that every user uses chcat thoroughly on all new
files (plus there are issues like text editors making a copy of a file
prior to editing).

So in other words DAC nature of MCS is okay it is just that there should
be some more sensible defaults pointing towards preservation of labels
on objects in their respective containers. The unix setgid bit can do
that on directories, as do default ACLs, both being mechanisms of DAC.

Secondly I don't see why a user is not able to discretionarily specify
his range outright when going via ssh just as he can with roles.=20

> Perhaps you ought to use MLS instead.  Or just use TE and define domains
> and types for these processes and files.

No. MLS is about strict ordering 0 < 1 < 2 ... I just want a partially
ordered set. I want compartments, not sensitivities. MCS and MLS are
orthogonal, at least by their theoretical properties (and SELinux MCS
strongly resembles the theory in practice).

And TE? Almost any of these models can be simulated by TE, given types
are granular enough, but I don't want the number of types be a quadratic
function of compartments plus the hassle associated with that.

With regards,
Michal Svoboda

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqmiAwACgkQg/fU9pp1uX7ysgCgpTEIgDURT1VYpfaOPKSdTeRV
OQIAoJxUH1zfSMTbYCex8HTHe0zymMis
=qp27
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
