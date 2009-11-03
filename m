Date: Tue, 3 Nov 2009 12:45:30 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux@tycho.nsa.gov
Subject: MCS read only cats
Message-ID: <20091103114530.GH1672@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I have been thinking of how to best implement a feature called read only
categories. That is, if we have a file with say c2, then c2 folks would
have full access (given by TE rules), but also there would be a category
called r2 (or c512+2 = c514 or whatever), that would be given read only
access to the file.

It seems to me that an implementation would ideally deal with a simple
MLS constrain or constrain relaxation. The reference policy constrains
file reading thus:

mlsconstrain file { read ioctl lock execute execute_no_trans }
        (( h1 dom h2 ) or ( t1 == mcsreadall ) or ( t2 == domain ));

How would one say 'also allow rN if file is cN'? So far I only came up
with an enumeration like so:

           (h1 dom r0 and h2 == c0)
	or (h1 dom r1 and h2 == c1)
	or (...1022 more)

Which seems ugly and perhaps such a mammoth expression would hog the
system too much. Moreover it seems it would be very difficult to
accomodate this enumeration for h2 == { c0, c1 } and beyond.

Does anyone have any better tips?

Michal Svoboda


--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrwF9oACgkQg/fU9pp1uX4RWgCgjzKP+Y4+3KaDfTGKqWKozveW
q70AnRczcyq13jElPgxFGITGukHFomym
=qSE0
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
