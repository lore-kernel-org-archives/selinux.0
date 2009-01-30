Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0UKkpkB012208
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2009 15:46:51 -0500
Received: from QMTA05.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0UKkod7016517
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2009 20:46:50 GMT
Subject: Re: [LTP] LTP SELinux policy error
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20090130173700.GA12069@us.ibm.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
	 <1233236562.9697.3.camel@gorn.columbia.tresys.com>
	 <1233247899.13403.23.camel@gorn.columbia.tresys.com>
	 <1233252592.5109.144.camel@localhost.localdomain>
	 <20090130171453.GA10745@us.ibm.com>  <20090130173700.GA12069@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-extWyWIQFAiwW/ZzfF4n"
Date: Fri, 30 Jan 2009 15:46:49 -0500
Message-Id: <1233348409.6143.52.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-extWyWIQFAiwW/ZzfF4n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Resending on the SELinux list as I accidentally sent it with my personal
addr, so it got dropped.

On Fri, 2009-01-30 at 11:37 -0600, Serge E. Hallyn wrote:
> Quoting Serge E. Hallyn (serue@us.ibm.com):
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > On Thu, 2009-01-29 at 11:51 -0500, Christopher J. PeBenito wrote:
> > > > On Thu, 2009-01-29 at 08:42 -0500, Christopher J. PeBenito wrote:
> > > > > On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> > > > > > I'm trying to run the LTP SELinux tests using the latest CVS ve=
rsion of=20
> > > > > > LTP and current Fedora development, and get the following polic=
y=20
> > > > > > compilation error:
> > > > > >=20
> > > > > > ----
> > > > > > Compiling targeted test_policy module
> > > > > >=20
> > > > > > test_policy.te:1730: Warning: r_dir_perms is deprecated please =
use list_dir_perms instead.
> > > > > > test_policy.te:1731: Warning: r_file_perms is deprecated please=
 use read_file_perms instead.
> > > > > > [lots of warnings similar to the above]
> > > > > >=20
> > > > > > /usr/bin/checkmodule:  loading policy configuration from=20
> > > > > > tmp/test_policy.tmp
> > > > > > test_policy.te":16:ERROR 'syntax error' at token=20
> > > > > > 'userdom_use_sysadm_terms' on line 3198:
> > > > > > userdom_use_sysadm_terms(testdomain)
> > > > > > # This allows read and write sysadm ttys and ptys.
> > > > > > /usr/bin/checkmodule:  error(s) encountered while parsing confi=
guration
> > > > > > make[1]: *** [tmp/test_policy.mod] Error 1
> > > > > > make[1]: Leaving directory `/usr/share/selinux/devel'
> > > > > > make: *** [load] Error 2
> > > > > > Failed to build and load test_policy module, aborting test run.
> > > > > > ----
> > > > > >=20
> > > > > > Is this likely to be fixed soon, and/or any suggestions for a w=
orkaround?
> > > > >=20
> > > > > It won't compile with the current trunk refpolicy, since the curr=
ent
> > > > > release was a major, API breaking change.  I'll try to get a patc=
h out
> > > > > shortly.
> > > >=20
> > > > I updated the policy since its fairly old, though I didn't convert =
its
> > > > raw rules over to use interfaces.  However this didn't completely f=
ix
> > > > it, as there is usage of a "unconfined_runs_test()", which isn't in=
 the
> > > > upstream refpolicy nor the fedora policy, as far as I can see.  One=
 of
> > > > the updates includes use of sysadm_entry_spec_domtrans_to(), which =
is in
> > > > the upstream refpolicy, but doesn't seem to have made its way downs=
tream
> > > > to the fedora policy.  I have attached my work so someone familiar =
with
>=20
> sysadm_entry_spec_domtrans is in fedora 10's policy sources, at least,
> in modules/roles/sysadm.if.  (I don't have a fedora devel system
> installed).

That has the opposite transition direction (the specified domain
transitions to sysadm).

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-extWyWIQFAiwW/ZzfF4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmDZzkACgkQvI7kLeavkkMkJQCeN5xFcFflc5OJA/6ZjZSqAi56
50oAnRdGXK5i+tYB8q0COuh33rqm4AXX
=0b3f
-----END PGP SIGNATURE-----

--=-extWyWIQFAiwW/ZzfF4n--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
