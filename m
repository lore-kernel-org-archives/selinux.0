Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5N2okrT013448
	for <selinux@tycho.nsa.gov>; Tue, 22 Jun 2004 22:50:46 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5N2og9A004291
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 02:50:42 GMT
Subject: Re: saslauthd policy, dovecot patches
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, russell@coker.com.au
In-Reply-To: <1087775351.32008.26.camel@optimus-prime.boston.redhat.com>
References: <1087775351.32008.26.camel@optimus-prime.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TVZrNIBd3gAduaRCxlTI"
Date: Tue, 22 Jun 2004 22:49:27 -0400
Message-Id: <1087958968.24644.4.camel@optimus-prime.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-TVZrNIBd3gAduaRCxlTI
Content-Type: multipart/mixed; boundary="=-997neA2ANe5ewjquTbWU"


--=-997neA2ANe5ewjquTbWU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 at 19:49 -0400, Colin Walters wrote:
> Hi,
>=20
> I'm trying to get postfix+SASL working, and to do that I had to write a
> policy for saslauthd, which is attached.  I haven't had a chance to test
> it with Kerberos yet, so that's incomplete.  But it does seem to
> authenticate via the PAM mechanism (smtp PLAIN) correctly.

Ok, with my later patch to extend the meaning of auth_chkpwd, I have
Postfix successfully sending mail via GSSAPI SMTP AUTH using saslauthd.
Here's an updated saslauthd.te which removes the now unnecessary
kerberos bits.




--=-997neA2ANe5ewjquTbWU
Content-Disposition: attachment; filename=saslauthd.te
Content-Type: text/plain; name=saslauthd.te; charset=utf-8
Content-Transfer-Encoding: base64

I0RFU0Mgc2FzbGF1dGhkIC0gQXV0aGVudGljYXRpb24gZGFlbW9uIGZvciBTQVNMDQojDQojIEF1
dGhvcjogQ29saW4gV2FsdGVycyA8d2FsdGVyc0B2ZXJidW0ub3JnPg0KIw0KDQpkYWVtb25fZG9t
YWluKHNhc2xhdXRoZCwgYCwgYXV0aF9jaGtwd2QnKQ0KDQphbGxvdyBzYXNsYXV0aGRfdCBzZWxm
OmZpZm9fZmlsZSB7IHJlYWQgd3JpdGUgfTsNCmFsbG93IHNhc2xhdXRoZF90IHNlbGY6dW5peF9k
Z3JhbV9zb2NrZXQgY3JlYXRlX3NvY2tldF9wZXJtczsNCmFsbG93IHNhc2xhdXRoZF90IHNlbGY6
dW5peF9zdHJlYW1fc29ja2V0IGNyZWF0ZV9zdHJlYW1fc29ja2V0X3Blcm1zOw0KYWxsb3cgc2Fz
bGF1dGhkX3Qgc2FzbGF1dGhkX3Zhcl9ydW5fdDpzb2NrX2ZpbGUgY3JlYXRlX2ZpbGVfcGVybXM7
DQoNCmFsbG93IHNhc2xhdXRoZF90IGV0Y190OmRpciB7IGdldGF0dHIgc2VhcmNoIH07DQphbGxv
dyBzYXNsYXV0aGRfdCBldGNfdDpmaWxlIHJfZmlsZV9wZXJtczsNCmFsbG93IHNhc2xhdXRoZF90
IG5ldF9jb25mX3Q6ZmlsZSByX2ZpbGVfcGVybXM7DQoNCmFsbG93IHNhc2xhdXRoZF90IHNlbGY6
ZmlsZSByX2ZpbGVfcGVybXM7DQphbGxvdyBzYXNsYXV0aGRfdCBwcm9jX3Q6ZmlsZSB7IHJlYWQg
fTsNCg0KYWxsb3cgc2FzbGF1dGhkX3QgdXJhbmRvbV9kZXZpY2VfdDpjaHJfZmlsZSB7IGdldGF0
dHIgcmVhZCB9OyANCg0KIyBOZWVkcyBpbnZlc3RpZ2F0aW9uDQpkb250YXVkaXQgc2FzbGF1dGhk
X3QgaG9tZV9yb290X3Q6ZGlyIHsgZ2V0YXR0ciB9Ow0K


--=-997neA2ANe5ewjquTbWU--

--=-TVZrNIBd3gAduaRCxlTI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2O+3OIkJWWp2WGURAs9UAJ47gde7VZZg4kijSbLTpCmrrwwAywCaA+ZE
V5P8Hr+uyEbhqQpeBtooWfA=
=GSyO
-----END PGP SIGNATURE-----

--=-TVZrNIBd3gAduaRCxlTI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
