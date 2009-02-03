Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n13Du0rK012003
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2009 08:56:00 -0500
Received: from QMTA09.emeryville.ca.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n13DqqVI007201
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2009 13:52:52 GMT
Subject: Re: [LTP] LTP SELinux policy error
From: Chris PeBenito <pebenito@gentoo.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, ltp-list@lists.sourceforge.net,
        selinux@tycho.nsa.gov
In-Reply-To: <20090201225429.GB12455@us.ibm.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
	 <1233236562.9697.3.camel@gorn.columbia.tresys.com>
	 <1233247899.13403.23.camel@gorn.columbia.tresys.com>
	 <1233252592.5109.144.camel@localhost.localdomain>
	 <20090130171453.GA10745@us.ibm.com> <20090130173700.GA12069@us.ibm.com>
	 <1233345509.6143.43.camel@defiant.pebenito.net>
	 <20090201225429.GB12455@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9sxHXbV1txfrLc6o19gj"
Date: Tue, 03 Feb 2009 08:55:33 -0500
Message-Id: <1233669333.3321.8.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9sxHXbV1txfrLc6o19gj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-02-01 at 16:54 -0600, Serge E. Hallyn wrote:
> Quoting Christopher J. PeBenito (pebenito@ieee.org):
> > On Fri, 2009-01-30 at 11:37 -0600, Serge E. Hallyn wrote:
> > > Quoting Serge E. Hallyn (serue@us.ibm.com):
> > > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > > On Thu, 2009-01-29 at 11:51 -0500, Christopher J. PeBenito wrote:
> > > > > > On Thu, 2009-01-29 at 08:42 -0500, Christopher J. PeBenito wrot=
e:
> > > > > > > On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> > > > > > > > I'm trying to run the LTP SELinux tests using the latest CV=
S version of=20
> > > > > > > > LTP and current Fedora development, and get the following p=
olicy=20
> > > > > > > > compilation error:
> > > > > > > >=20
> > > > > > > > ----
> > > > > > > > Compiling targeted test_policy module
> > > > > > > >=20
> > > > > > > > test_policy.te:1730: Warning: r_dir_perms is deprecated ple=
ase use list_dir_perms instead.
> > > > > > > > test_policy.te:1731: Warning: r_file_perms is deprecated pl=
ease use read_file_perms instead.
> > > > > > > > [lots of warnings similar to the above]
> > > > > > > >=20
> > > > > > > > /usr/bin/checkmodule:  loading policy configuration from=20
> > > > > > > > tmp/test_policy.tmp
> > > > > > > > test_policy.te":16:ERROR 'syntax error' at token=20
> > > > > > > > 'userdom_use_sysadm_terms' on line 3198:
> > > > > > > > userdom_use_sysadm_terms(testdomain)
> > > > > > > > # This allows read and write sysadm ttys and ptys.
> > > > > > > > /usr/bin/checkmodule:  error(s) encountered while parsing c=
onfiguration
> > > > > > > > make[1]: *** [tmp/test_policy.mod] Error 1
> > > > > > > > make[1]: Leaving directory `/usr/share/selinux/devel'
> > > > > > > > make: *** [load] Error 2
> > > > > > > > Failed to build and load test_policy module, aborting test =
run.
> > > > > > > > ----
> > > > > > > >=20
> > > > > > > > Is this likely to be fixed soon, and/or any suggestions for=
 a workaround?
> > > > > > >=20
> > > > > > > It won't compile with the current trunk refpolicy, since the =
current
> > > > > > > release was a major, API breaking change.  I'll try to get a =
patch out
> > > > > > > shortly.
> > > > > >=20
> > > > > > I updated the policy since its fairly old, though I didn't conv=
ert its
> > > > > > raw rules over to use interfaces.  However this didn't complete=
ly fix
> > > > > > it, as there is usage of a "unconfined_runs_test()", which isn'=
t in the
> > > > > > upstream refpolicy nor the fedora policy, as far as I can see. =
 One of
> > > > > > the updates includes use of sysadm_entry_spec_domtrans_to(), wh=
ich is in
> > > > > > the upstream refpolicy, but doesn't seem to have made its way d=
ownstream
> > > > > > to the fedora policy.  I have attached my work so someone famil=
iar with
> > >=20
> > > sysadm_entry_spec_domtrans is in fedora 10's policy sources, at least=
,
> > > in modules/roles/sysadm.if.  (I don't have a fedora devel system
> > > installed).
> >=20
> > That has the opposite transition direction (the specified domain
> > transitions to sysadm).
>=20
> Just to make sure...
>=20
> You're saying that in upstream refpolicy sysadm_entry_spec_domtrans(foo)
> means foo may transition to sysadm_t, while in fedora 10 policy
> sysadm_entry_spec_domtrans(foo) means sysadm_t may transition to
> foo?

No.  They have the same behavior.  What happened is that the interface
(the one you need to use, not the above ones) used to be called
userdom_sysadm_entry_spec_domtrans_to().  Then I split all of the roles
into individual policy modules, so that interface got renamed to
sysadm_entry_spec_domtrans_to(), except the new interface was
accidentally dropped.  So I added it back in, and it just hasn't gotten
downstream yet.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-9sxHXbV1txfrLc6o19gj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmITNUACgkQvI7kLeavkkOkzgCeNcxoO1fsmEFp22XHQhJgQrZA
DYEAoIyHEbQ0b8gTs+Jnum+7lV4Rn/Q0
=N+MF
-----END PGP SIGNATURE-----

--=-9sxHXbV1txfrLc6o19gj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
