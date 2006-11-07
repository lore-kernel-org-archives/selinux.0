From: James Antill <james.antill@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y3fOFD+OPhX41biRZ9Sh"
Date: Tue, 07 Nov 2006 16:51:36 -0500
Message-Id: <1162936296.26574.10.camel@code.and.org>
Mime-Version: 1.0
Subject: [PATCH] MLS context contains policy/libselinux changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Y3fOFD+OPhX41biRZ9Sh
Content-Type: multipart/mixed; boundary="=-po6K2weBprZYLWr/PYW0"


--=-po6K2weBprZYLWr/PYW0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


 Here is the policy changes needed for the context contains security
checking in PAM and cron.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-po6K2weBprZYLWr/PYW0
Content-Description: MLS Range checking for cron/PAM
Content-Disposition: inline; filename=policy-range-checking.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IHBvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIHBvbGlj
eS9mbGFzay9hY2Nlc3NfdmVjdG9ycwkocmV2aXNpb24gMjA3OCkNCisrKyBwb2xpY3kvZmxhc2sv
YWNjZXNzX3ZlY3RvcnMJKHdvcmtpbmcgY29weSkNCkBAIC02MzUsNCArNjM1LDUgQEANCiBjbGFz
cyBjb250ZXh0DQogew0KIAl0cmFuc2xhdGUNCisJY29udGFpbnMNCiB9DQpJbmRleDogcG9saWN5
L21vZHVsZXMvc3lzdGVtL3VzZXJkb21haW4uaWYNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBwb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgkocmV2aXNpb24gMjA3OCkNCisrKyBwb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgkod29ya2luZyBjb3B5KQ0KQEAgLTUxLDYgKzUxLDgg
QEANCiAJYWxsb3cgJDFfdCBzZWxmOm1zZyB7IHNlbmQgcmVjZWl2ZSB9Ow0KIAlkb250YXVkaXQg
JDFfdCBzZWxmOnNvY2tldCBjcmVhdGU7DQogDQorCWFsbG93ICQxX3Qgc2VsZjpjb250ZXh0IGNv
bnRhaW5zOw0KKw0KIAlhbGxvdyAkMV90ICQxX2RldnB0c190OmNocl9maWxlIHsgc2V0YXR0ciBp
b2N0bCByZWFkIGdldGF0dHIgbG9jayB3cml0ZSBhcHBlbmQgfTsNCiAJdGVybV9jcmVhdGVfcHR5
KCQxX3QsJDFfZGV2cHRzX3QpDQogDQpJbmRleDogcG9saWN5L21scw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IHBvbGljeS9tbHMJKHJldmlzaW9uIDIwNzgpDQorKysgcG9saWN5L21scwkod29ya2luZyBjb3B5
KQ0KQEAgLTU5Nyw0ICs1OTcsNyBAQA0KIG1sc2NvbnN0cmFpbiBjb250ZXh0IHRyYW5zbGF0ZQ0K
IAkoKCBoMSBkb20gaDIgKSBvciAoIHQxID09IG1sc3RyYW5zbGF0ZSApKTsNCiANCittbHNjb25z
dHJhaW4gY29udGV4dCBjb250YWlucw0KKwkoIGgxIGRvbSBoMiApOw0KKw0KICcpIGRubCBlbmQg
ZW5hYmxlX21scw0K


--=-po6K2weBprZYLWr/PYW0--

--=-Y3fOFD+OPhX41biRZ9Sh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFUP/o11eXTEMrxtQRAppuAKDEdh08eQTY7mXe8fbf701tmxzvaQCfZa0u
8PwFPu0BfFyia74iEJuA8fM=
=SNIY
-----END PGP SIGNATURE-----

--=-Y3fOFD+OPhX41biRZ9Sh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
