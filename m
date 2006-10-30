From: James Antill <james.antill@redhat.com>
To: redhat-lspp <redhat-lspp@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>
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
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Msmsouh2NYWK7C+7ZG+5"
Date: Mon, 30 Oct 2006 15:03:51 -0500
Message-Id: <1162238632.31104.11.camel@code.and.org>
Mime-Version: 1.0
Subject: [PATCH 1/3] Re: MLS enforcing PTYs, sshd, and newrole
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Msmsouh2NYWK7C+7ZG+5
Content-Type: multipart/mixed; boundary="=-gmdV1I7NBJIKecaOxHix"


--=-gmdV1I7NBJIKecaOxHix
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-10-27 at 14:38 -0400, Stephen Smalley wrote:

> Look at Darrel's patch for mcstransd to apply a permission check between
> the level of the caller and the level being translated for context
> translations.=20

 Thanks to much discussion with Dan and Stephen, I'm pretty sure I have
this correct now.

 Here is the libselinux part of the patch (reference policy and PAM are
next).

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-gmdV1I7NBJIKecaOxHix
Content-Disposition: inline; filename=selinux-pam-range-checking.patch
Content-Type: text/x-patch; name=selinux-pam-range-checking.patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGxpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L2F2X3Blcm1pc3Npb25zLmgNCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCi0tLSBsaWJzZWxpbnV4L2luY2x1ZGUvc2VsaW51eC9hdl9wZXJtaXNzaW9ucy5oCShy
ZXZpc2lvbiAyMDc0KQ0KKysrIGxpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L2F2X3Blcm1pc3Np
b25zLmgJKHdvcmtpbmcgY29weSkNCkBAIC04OTYsMyArODk2LDQgQEANCiAjZGVmaW5lIEtFWV9f
U0VUQVRUUiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMjBVTA0KICNkZWZp
bmUgS0VZX19DUkVBVEUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMDA0MFVM
DQogI2RlZmluZSBDT05URVhUX19UUkFOU0xBVEUgICAgICAgICAgICAgICAgICAgICAgICAweDAw
MDAwMDAxVUwNCisjZGVmaW5lIENPTlRFWFRfX1RSQU5TSVRJT04gICAgICAgICAgICAgICAgICAg
ICAgIDB4MDAwMDAwMDJVTA0KSW5kZXg6IGxpYnNlbGludXgvc3JjL2F2X3Blcm1fdG9fc3RyaW5n
LmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCi0tLSBsaWJzZWxpbnV4L3NyYy9hdl9wZXJtX3RvX3N0cmluZy5oCShy
ZXZpc2lvbiAyMDc0KQ0KKysrIGxpYnNlbGludXgvc3JjL2F2X3Blcm1fdG9fc3RyaW5nLmgJKHdv
cmtpbmcgY29weSkNCkBAIC0yNjYsMyArMjY2LDQgQEANCiAgICAgU18oU0VDQ0xBU1NfS0VZLCBL
RVlfX1NFVEFUVFIsICJzZXRhdHRyIikNCiAgICAgU18oU0VDQ0xBU1NfS0VZLCBLRVlfX0NSRUFU
RSwgImNyZWF0ZSIpDQogICAgIFNfKFNFQ0NMQVNTX0NPTlRFWFQsIENPTlRFWFRfX1RSQU5TTEFU
RSwgInRyYW5zbGF0ZSIpDQorICAgIFNfKFNFQ0NMQVNTX0NPTlRFWFQsIENPTlRFWFRfX1RSQU5T
SVRJT04sICJ0cmFuc2l0aW9uIikNCg==


--=-gmdV1I7NBJIKecaOxHix--

--=-Msmsouh2NYWK7C+7ZG+5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFRlqn11eXTEMrxtQRApaNAJ9SjvCrJINRtarmjLuCZFr/XjL3+gCfYy8Z
W6FOVhVyEtrBJ0oFVl5ncQA=
=D7Wm
-----END PGP SIGNATURE-----

--=-Msmsouh2NYWK7C+7ZG+5--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
