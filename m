From: James Antill <james.antill@redhat.com>
To: redhat-lspp <redhat-lspp@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162238632.31104.11.camel@code.and.org>
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
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-slV5gK3FaLp7be+64LXf"
Date: Mon, 30 Oct 2006 15:16:34 -0500
Message-Id: <1162239394.31104.13.camel@code.and.org>
Mime-Version: 1.0
Subject: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-slV5gK3FaLp7be+64LXf
Content-Type: multipart/mixed; boundary="=-Zfim6DT8dBAmuf61PZTx"


--=-Zfim6DT8dBAmuf61PZTx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-30 at 15:03 -0500, James Antill wrote:
> On Fri, 2006-10-27 at 14:38 -0400, Stephen Smalley wrote:
>=20
> > Look at Darrel's patch for mcstransd to apply a permission check betwee=
n
> > the level of the caller and the level being translated for context
> > translations.=20
>=20
>  Thanks to much discussion with Dan and Stephen, I'm pretty sure I have
> this correct now.


 Here is the reference policy part of the patches (libselinux came
previously and PAM is next).


--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-Zfim6DT8dBAmuf61PZTx
Content-Disposition: inline; filename=policy-pam-range-checking.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=policy-pam-range-checking.patch; charset=UTF-8

SW5kZXg6IHBvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIHBvbGlj
eS9mbGFzay9hY2Nlc3NfdmVjdG9ycwkocmV2aXNpb24gMjA2NSkNCisrKyBwb2xpY3kvZmxhc2sv
YWNjZXNzX3ZlY3RvcnMJKHdvcmtpbmcgY29weSkNCkBAIC02MzUsNCArNjM1LDUgQEANCiBjbGFz
cyBjb250ZXh0DQogew0KIAl0cmFuc2xhdGUNCisJdHJhbnNpdGlvbg0KIH0NCkluZGV4OiBwb2xp
Y3kvbW9kdWxlcy9zeXN0ZW0vYXV0aGxvZ2luLmlmDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gcG9saWN5L21v
ZHVsZXMvc3lzdGVtL2F1dGhsb2dpbi5pZgkocmV2aXNpb24gMjA2NSkNCisrKyBwb2xpY3kvbW9k
dWxlcy9zeXN0ZW0vYXV0aGxvZ2luLmlmCSh3b3JraW5nIGNvcHkpDQpAQCAtMjc4LDYgKzI3OCw5
IEBADQogCWFsbG93ICQyICQxOmZkIHVzZTsNCiAJYWxsb3cgJDIgJDE6Zmlmb19maWxlIHJ3X2Zp
bGVfcGVybXM7DQogCWFsbG93ICQyICQxOnByb2Nlc3Mgc2lnY2hsZDsNCisNCisgICAgICAgICMg
Q2hlY2sgTUxTIFJhbmdlDQorICAgICAgICBhbGxvdyAkMSBkb21haW46Y29udGV4dCB0cmFuc2l0
aW9uOw0KICcpDQogDQogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0K
SW5kZXg6IHBvbGljeS9tbHMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBwb2xpY3kvbWxzCShyZXZpc2lvbiAy
MDY1KQ0KKysrIHBvbGljeS9tbHMJKHdvcmtpbmcgY29weSkNCkBAIC01OTYsNCArNTk2LDcgQEAN
CiBtbHNjb25zdHJhaW4gY29udGV4dCB0cmFuc2xhdGUNCiAJKCggaDEgZG9tIGgyICkgb3IgKCB0
MSA9PSBtbHN0cmFuc2xhdGUgKSk7DQogDQorbWxzY29uc3RyYWluIGNvbnRleHQgdHJhbnNpdGlv
bg0KKwkoIGgxIGRvbSBoMiApOw0KKw0KICcpIGRubCBlbmQgZW5hYmxlX21scw0K


--=-Zfim6DT8dBAmuf61PZTx--

--=-slV5gK3FaLp7be+64LXf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFRl2i11eXTEMrxtQRAoMGAJ9rsHf71BjDYsAURybB6VXkw5kwJgCfeSZ+
VPtLpta+I0KKPyoqQHixJSM=
=ZJ8f
-----END PGP SIGNATURE-----

--=-slV5gK3FaLp7be+64LXf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
