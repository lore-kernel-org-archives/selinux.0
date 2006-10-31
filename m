From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
	 <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
	 <1161803724.29689.57.camel@code.and.org>
	 <1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>
	 <1161970810.29689.88.camel@code.and.org>
	 <1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>
	 <1162238632.31104.11.camel@code.and.org>
	 <1162239394.31104.13.camel@code.and.org>
	 <1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>
	 <1162304681.32614.26.camel@moss-spartans.epoch.ncsc.mil>
	 <1162306839.31104.23.camel@code.and.org>
	 <1162307495.32614.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1162310652.31104.46.camel@code.and.org>
	 <1162311675.32614.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iUdFxq/BZFiPOEq2pQXf"
Date: Tue, 31 Oct 2006 13:33:02 -0500
Message-Id: <1162319582.23631.1.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-iUdFxq/BZFiPOEq2pQXf
Content-Type: multipart/mixed; boundary="=-SU1RUPDVyf+iAzXsoisl"


--=-SU1RUPDVyf+iAzXsoisl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-31 at 11:21 -0500, Stephen Smalley wrote:

> No.  The ability to make the security call is controlled by the
> compute_av permission on the security class, and isn't based on the
> individual contexts passed as arguments.  That would be:
> 	allow $1 security_t:security compute_av;
> which has an interface:
> 	selinux_compute_access_vector($1)
> which is already in authlogin.if.  No change required for allowing the
> call to happen.
>=20
> What you are instead trying to do is to define the _result_ of that
> compute_av call based on its arguments, not whether it can be made by
> login.  So the TE rule would go into userdomain.if and be of the form:
> 	allow $1 self:context <permissionname>;

 Ok, I think I have it now. Both patches are at (with the renamed
permission):

 http://people.redhat.com/jantill/pam-config_role/upstream/


--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-SU1RUPDVyf+iAzXsoisl
Content-Disposition: inline; filename=policy-pam-range-checking.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=policy-pam-range-checking.patch; charset=UTF-8

SW5kZXg6IHBvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIHBvbGlj
eS9mbGFzay9hY2Nlc3NfdmVjdG9ycwkocmV2aXNpb24gMjA2NSkNCisrKyBwb2xpY3kvZmxhc2sv
YWNjZXNzX3ZlY3RvcnMJKHdvcmtpbmcgY29weSkNCkBAIC02MzUsNCArNjM1LDUgQEANCiBjbGFz
cyBjb250ZXh0DQogew0KIAl0cmFuc2xhdGUNCisJY29udGFpbnMNCiB9DQpJbmRleDogcG9saWN5
L21vZHVsZXMvc3lzdGVtL3VzZXJkb21haW4uaWYNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBwb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgkocmV2aXNpb24gMjA2NSkNCisrKyBwb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vdXNlcmRvbWFpbi5pZgkod29ya2luZyBjb3B5KQ0KQEAgLTUxLDYgKzUxLDgg
QEANCiAJYWxsb3cgJDFfdCBzZWxmOm1zZyB7IHNlbmQgcmVjZWl2ZSB9Ow0KIAlkb250YXVkaXQg
JDFfdCBzZWxmOnNvY2tldCBjcmVhdGU7DQogDQorCWFsbG93ICQxX3Qgc2VsZjpjb250ZXh0IGNv
bnRhaW5zOw0KKw0KIAlhbGxvdyAkMV90ICQxX2RldnB0c190OmNocl9maWxlIHsgc2V0YXR0ciBp
b2N0bCByZWFkIGdldGF0dHIgbG9jayB3cml0ZSBhcHBlbmQgfTsNCiAJdGVybV9jcmVhdGVfcHR5
KCQxX3QsJDFfZGV2cHRzX3QpDQogDQpJbmRleDogcG9saWN5L21scw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IHBvbGljeS9tbHMJKHJldmlzaW9uIDIwNjUpDQorKysgcG9saWN5L21scwkod29ya2luZyBjb3B5
KQ0KQEAgLTU5Niw0ICs1OTYsNyBAQA0KIG1sc2NvbnN0cmFpbiBjb250ZXh0IHRyYW5zbGF0ZQ0K
IAkoKCBoMSBkb20gaDIgKSBvciAoIHQxID09IG1sc3RyYW5zbGF0ZSApKTsNCiANCittbHNjb25z
dHJhaW4gY29udGV4dCBjb250YWlucw0KKwkoIGgxIGRvbSBoMiApOw0KKw0KICcpIGRubCBlbmQg
ZW5hYmxlX21scw0K


--=-SU1RUPDVyf+iAzXsoisl
Content-Disposition: inline; filename=selinux-pam-range-checking.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=selinux-pam-range-checking.patch; charset=UTF-8

SW5kZXg6IGxpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L2F2X3Blcm1pc3Npb25zLmgNCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCi0tLSBsaWJzZWxpbnV4L2luY2x1ZGUvc2VsaW51eC9hdl9wZXJtaXNzaW9ucy5oCShy
ZXZpc2lvbiAyMDc0KQ0KKysrIGxpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L2F2X3Blcm1pc3Np
b25zLmgJKHdvcmtpbmcgY29weSkNCkBAIC04OTYsMyArODk2LDQgQEANCiAjZGVmaW5lIEtFWV9f
U0VUQVRUUiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMjBVTA0KICNkZWZp
bmUgS0VZX19DUkVBVEUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMDA0MFVM
DQogI2RlZmluZSBDT05URVhUX19UUkFOU0xBVEUgICAgICAgICAgICAgICAgICAgICAgICAweDAw
MDAwMDAxVUwNCisjZGVmaW5lIENPTlRFWFRfX0NPTlRBSU5TICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4MDAwMDAwMDJVTA0KSW5kZXg6IGxpYnNlbGludXgvc3JjL2F2X3Blcm1fdG9fc3RyaW5n
LmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCi0tLSBsaWJzZWxpbnV4L3NyYy9hdl9wZXJtX3RvX3N0cmluZy5oCShy
ZXZpc2lvbiAyMDc0KQ0KKysrIGxpYnNlbGludXgvc3JjL2F2X3Blcm1fdG9fc3RyaW5nLmgJKHdv
cmtpbmcgY29weSkNCkBAIC0yNjYsMyArMjY2LDQgQEANCiAgICAgU18oU0VDQ0xBU1NfS0VZLCBL
RVlfX1NFVEFUVFIsICJzZXRhdHRyIikNCiAgICAgU18oU0VDQ0xBU1NfS0VZLCBLRVlfX0NSRUFU
RSwgImNyZWF0ZSIpDQogICAgIFNfKFNFQ0NMQVNTX0NPTlRFWFQsIENPTlRFWFRfX1RSQU5TTEFU
RSwgInRyYW5zbGF0ZSIpDQorICAgIFNfKFNFQ0NMQVNTX0NPTlRFWFQsIENPTlRFWFRfX0NPTlRB
SU5TLCAiY29udGFpbnMiKQ0K


--=-SU1RUPDVyf+iAzXsoisl--

--=-iUdFxq/BZFiPOEq2pQXf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFR5bd11eXTEMrxtQRAqiIAKC2jblbxJB+EmU9Fqr/ltXChSIEbQCeNv/d
51kJ1Hfa3kz+trmHs08a2BA=
=9jaI
-----END PGP SIGNATURE-----

--=-iUdFxq/BZFiPOEq2pQXf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
