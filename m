Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89IJurT013798
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 14:19:56 -0400 (EDT)
Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters
	for dbus.
From: Colin Walters <walters@redhat.com>
To: jwcart2@epoch.ncsc.mil
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1094734410.2895.45.camel@moss-lions.epoch.ncsc.mil>
References: <413E1DE0.9050905@redhat.com>
	 <1094734410.2895.45.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-r6ott23onXVubRSyHnum"
Date: Thu, 09 Sep 2004 14:21:06 -0400
Message-Id: <1094754066.28487.25.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-r6ott23onXVubRSyHnum
Content-Type: multipart/mixed; boundary="=-Yvb4Sf9/L1iDof3aHWwh"


--=-Yvb4Sf9/L1iDof3aHWwh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-09 at 08:53 -0400, James Carter wrote:
> When I build the policy with this patch there is a conflict with two
> type transitions.
>=20
> Because of the alias rule:
> typealias system_dbusd_exec_t alias dbusd_exec_t;
>=20
> The following type transitions conflict:
> type_transition sysadm_t dbusd_exec_t:process sysadm_dbusd_t;
> type_transition sysadm_t system_dbusd_exec_t:process system_dbusd_t;
>=20
> The second transition is the one used when I build the policy.  I am not
> sure if that is the desired transition.

Hm.  Yes, we actually want the former.  Can you try this patch?


--=-Yvb4Sf9/L1iDof3aHWwh
Content-Disposition: attachment; filename=se-dbus-nosysadm.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=se-dbus-nosysadm.patch; charset=utf-8

LS0tIG1hY3Jvcy9wcm9ncmFtL2RidXNkX21hY3Jvcy50ZX4JMjAwNC0wOS0wOSAxNDowODoyMC4x
OTI5NTExOTIgLTA0MDANCisrKyBtYWNyb3MvcHJvZ3JhbS9kYnVzZF9tYWNyb3MudGUJMjAwNC0w
OS0wOSAxNDoxOTowNi43MDE2NjY5MjggLTA0MDANCkBAIC05LDcgKzksNyBAQA0KIA0KIGRlZmlu
ZShgZGJ1c2RfZG9tYWluJywgYA0KIGlmZWxzZShgc3lzdGVtJywgYCQxJyxgDQotZGFlbW9uX2Rv
bWFpbihzeXN0ZW1fZGJ1c2QsIGAsIHVzZXJzcGFjZV9vYmptZ3InKQ0KK2RhZW1vbl9kb21haW4o
c3lzdGVtX2RidXNkLCBgLCB1c2Vyc3BhY2Vfb2JqbWdyJywgYG5vc3lzYWRtJykNCiAjIEZvciBi
YWNrd2FyZHMgY29tcGF0aWJpbGl0eQ0KIHR5cGVhbGlhcyBzeXN0ZW1fZGJ1c2RfdCBhbGlhcyBk
YnVzZF90Ow0KIHR5cGVhbGlhcyBzeXN0ZW1fZGJ1c2RfZXhlY190IGFsaWFzIGRidXNkX2V4ZWNf
dDsNCg==


--=-Yvb4Sf9/L1iDof3aHWwh--

--=-r6ott23onXVubRSyHnum
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBQJ8SOIkJWWp2WGURAj5fAJ9AMW91x4yFlSdE2/4IjSTWddx0YACfV4ih
9iBuNvJjxKPiWPTqEnUSg/I=
=vK75
-----END PGP SIGNATURE-----

--=-r6ott23onXVubRSyHnum--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
