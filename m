Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0CJqMWm017254
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 14:52:22 -0500
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
 by gentp.lnet (Postfix) with ESMTP id CDD3B261237
 for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2014 20:52:12 +0100 (CET)
Date: Sun, 12 Jan 2014 20:52:00 +0100
From: Luis Ressel <aranea@aixah.de>
To: selinux@tycho.nsa.gov
Subject: Re: Create new NetFilter table
Message-ID: <20140112205200.0a066042@gentp.lnet>
In-Reply-To: <1171389381947@web15m.yandex.ru>
References: <1171389381947@web15m.yandex.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/3JCym3ZNwxr.C1xAjW1REYm"; protocol="application/pgp-signature"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--Sig_/3JCym3ZNwxr.C1xAjW1REYm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2014 21:25:47 +0200
Victor Porton <porton@narod.ru> wrote:

> I propose to create a new NetFilter table dedicated to rules created
> programmatically (not by explicit admin's iptables command).
>=20
> Otherwise an admin could be tempted to say `iptables -F security`
> which would probably break rules created for example by sandboxing
> software (which may follow same-origin policy to restrict one
> particular program to certain domain and port only). Note that in
> this case `iptables -F security` is a security risk (sandbox
> breaking)?
>=20
> New table could be possibly be called:
>=20
> - temp
> - temporary
> - auto
> - automatic
> - volatile
> - daemon
> - system
> - sys
>=20
> In iptables docs it should be said that this table should not be
> manipulated manually.
>=20

Just like the last thread, this one is also completely unrelated to
SELinux. And it doesn't make sense anyway. Only the admin can
manipulate netfilter rules, so he'll know if the can flush them or not.
If you want to separate automatically-created rules (which is a good
idea), just put them in a separate *chain*, not a separate *table*.
Side note: Even assuming creating such a table would make any sense,
one wouldn't suffice, you'd have to create five of them.

And if you're still prefer to create new kernel interfaces for your
specific requirements instead of using the well thought-out and much
more flexible preexisting ones -- nobody keeps you from patching your
kernel, just don't try to upstream them.


--=20
Luis Ressel <aranea@aixah.de>
GPG fpr: F08D 2AF6 655E 25DE 52BC  E53D 08F5 7F90 3029 B5BD

--Sig_/3JCym3ZNwxr.C1xAjW1REYm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJS0vJsXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpoogP/RFyO56IyNyI2Qbd8G3KkRC0
59zwDhTlRD2iO2FV6J7fRfZOtBWkUy3tvCDDUVwzAK2kDBMwX9CEgR06nRehF16l
J28h2pjzQbv7dXnDz5gi15kby50/MIRBifpzUpcxnjsUY0W1BlRDc3kV6si+Q0JO
Mtydf2uK1TxXl68ph3GjVO5SaLm0gfcbXkENCcYcpNXCe6qbVWo3GzzHOQwEki9j
JzS6tPdlSvVQO/IOSE6uQBreyVxx1vKymqY8xkfHW4HjDbXFM9qcOTmmZzOlr/BG
NZuzcJtqiXQ0/t/ZGAqPwRHRXlqn7uUON9VoPH1yoZvVTkKeQy4Jws++mo5HGIFh
VyNf62ulMyslKbBwwzRWqj9mgU84ilPPh+1WV7bHJZ2JS8zO1h+jF7jBQMnOZN6i
gr+EUBKUSj6wtTVwYBBOpqZDHtlnfh2pEt/l9zCxlULZdKI8JeFDCaftD8PJrrTy
+q1Ck7c3AQPatNPRy0q5GSdVMjpBdeX0PKKXq/QL3QHimTeQ1YawFep0hjZgkFCX
VpDncPJAiCEQG+fGsXPgi9FtgrLcVoVmHL9rk4PoPvm/wGa9m2+h8HYywJFfCPE2
9HE3a0EQAjofu70w1nLCz9ekk7tuMSpnP70WuUg8T+mM5Vja9H42WeAaFjjZtnqi
+9UTW9jj8XWhS+XlJnvq
=AZzv
-----END PGP SIGNATURE-----

--Sig_/3JCym3ZNwxr.C1xAjW1REYm--
