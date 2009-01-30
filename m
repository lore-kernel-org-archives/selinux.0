Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0UKknJZ012199
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2009 15:46:49 -0500
Received: from QMTA10.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0UKkmd7016512
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2009 20:46:48 GMT
Subject: Re: LTP SELinux policy error
From: Chris PeBenito <pebenito@gentoo.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <20090130171453.GA10745@us.ibm.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
	 <1233236562.9697.3.camel@gorn.columbia.tresys.com>
	 <1233247899.13403.23.camel@gorn.columbia.tresys.com>
	 <1233252592.5109.144.camel@localhost.localdomain>
	 <20090130171453.GA10745@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Lfr22I4m7HGmLPI7tEAO"
Date: Fri, 30 Jan 2009 15:46:47 -0500
Message-Id: <1233348407.6143.51.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Lfr22I4m7HGmLPI7tEAO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Resending on the SELinux list as I accidentally sent it with my personal
addr, so it got dropped.


On Fri, 2009-01-30 at 11:14 -0600, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Thu, 2009-01-29 at 11:51 -0500, Christopher J. PeBenito wrote:
> > > On Thu, 2009-01-29 at 08:42 -0500, Christopher J. PeBenito wrote:
> > > > On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> > > > > I'm trying to run the LTP SELinux tests using the latest CVS vers=
ion of=20
> > > > > LTP and current Fedora development, and get the following policy=20
> > > > > compilation error:
> > > > >=20
> > > > > ----
> > > > > Compiling targeted test_policy module
> > > > >=20
> > > > > test_policy.te:1730: Warning: r_dir_perms is deprecated please us=
e list_dir_perms instead.
> > > > > test_policy.te:1731: Warning: r_file_perms is deprecated please u=
se read_file_perms instead.
> > > > > [lots of warnings similar to the above]
> > > > >=20
> > > > > /usr/bin/checkmodule:  loading policy configuration from=20
> > > > > tmp/test_policy.tmp
> > > > > test_policy.te":16:ERROR 'syntax error' at token=20
> > > > > 'userdom_use_sysadm_terms' on line 3198:
> > > > > userdom_use_sysadm_terms(testdomain)
> > > > > # This allows read and write sysadm ttys and ptys.
> > > > > /usr/bin/checkmodule:  error(s) encountered while parsing configu=
ration
> > > > > make[1]: *** [tmp/test_policy.mod] Error 1
> > > > > make[1]: Leaving directory `/usr/share/selinux/devel'
> > > > > make: *** [load] Error 2
> > > > > Failed to build and load test_policy module, aborting test run.
> > > > > ----
> > > > >=20
> > > > > Is this likely to be fixed soon, and/or any suggestions for a wor=
karound?
> > > >=20
> > > > It won't compile with the current trunk refpolicy, since the curren=
t
> > > > release was a major, API breaking change.  I'll try to get a patch =
out
> > > > shortly.
> > >=20
> > > I updated the policy since its fairly old, though I didn't convert it=
s
> > > raw rules over to use interfaces.  However this didn't completely fix
> > > it, as there is usage of a "unconfined_runs_test()", which isn't in t=
he
> > > upstream refpolicy nor the fedora policy, as far as I can see.  One o=
f
> > > the updates includes use of sysadm_entry_spec_domtrans_to(), which is=
 in
> > > the upstream refpolicy, but doesn't seem to have made its way downstr=
eam
> > > to the fedora policy.  I have attached my work so someone familiar wi=
th
> > > the LTP test cases can use it to complete the fix.
> >=20
> > Serge put together a patch and script under selinux-testsuite/misc that
> > defines unconfined_runs_test() as well as converting some of the
> > interfaces.  That was done so that the ltp testsuite could still be run
> > on older distributions (w/ the older policy) and on newer distributions
> > (w/ the patch applied to perform conversion).  It was originally done
> > based on the deprecation of the sbin interfaces, which is why it is
> > named that way even though it now includes more than just conversion of
> > those interfaces.
>=20
> (Sorry, this thread is rolling into my inbox delayed and out-of-order)
>=20
> So the unconfined_runs_test() shouldn't actually be a problem (right,
> Chris? pls let me know if you actually get compile failures as then
> something went wrong with the build scripts).

I just went to the directory and ran make.  Sounds like I might have
done something wrong.

> But what could have happened with sysadm_entry_spec_domtrans_to()?  It
> must have been in fedora's policy before, since it definately worked on
> fedora 7 and 8.  Has it been removed?  (I'll fire up a f10 partition and
> look through the policy sources...)

Well it used to be userdom_sysadm_entry_spec_domtrans_to().

> As for the list_dir_perms and read_file_perms, have those always macros
> in the refpolicy?  If so, then a straight search-and-replace is fine.
> If not, then we'll have to do another hook at the policy build to make
> the substitutions only when the policy is new enough.  :(

Those have been around for a while.  While the old r_dir_perms and
r_file_perms macros aren't going anywhere for the forseeable future,
their use is problematic as those may not get updated for new perms,
such as open.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Lfr22I4m7HGmLPI7tEAO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmDZzcACgkQvI7kLeavkkNP3wCaAov3YZNm2G4UquCbxyiIVlxx
UisAmwWvb7tQ3teRR7+BQBksMnOOSN9f
=kjqt
-----END PGP SIGNATURE-----

--=-Lfr22I4m7HGmLPI7tEAO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
