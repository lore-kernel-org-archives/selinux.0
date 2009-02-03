Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n13DqAFq011332
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2009 08:52:10 -0500
Received: from QMTA06.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n13Dn2VI006562
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2009 13:49:02 GMT
Subject: Re: LTP SELinux policy error
From: Chris PeBenito <pebenito@gentoo.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        ltp-list@lists.sourceforge.net, selinux@tycho.nsa.gov
In-Reply-To: <20090201225131.GA12455@us.ibm.com>
References: <alpine.LRH.1.10.0901292128540.25382@tundra.namei.org>
	 <1233236562.9697.3.camel@gorn.columbia.tresys.com>
	 <1233247899.13403.23.camel@gorn.columbia.tresys.com>
	 <1233252592.5109.144.camel@localhost.localdomain>
	 <20090130171453.GA10745@us.ibm.com>
	 <1233345437.6143.42.camel@defiant.pebenito.net>
	 <20090201225131.GA12455@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-vfi90eJMevvKwETyCgSA"
Date: Tue, 03 Feb 2009 08:51:42 -0500
Message-Id: <1233669102.3321.4.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vfi90eJMevvKwETyCgSA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-02-01 at 16:51 -0600, Serge E. Hallyn wrote:
> Quoting Christopher J. PeBenito (pebenito@ieee.org):
> > On Fri, 2009-01-30 at 11:14 -0600, Serge E. Hallyn wrote:
> > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > On Thu, 2009-01-29 at 11:51 -0500, Christopher J. PeBenito wrote:
> > > > > On Thu, 2009-01-29 at 08:42 -0500, Christopher J. PeBenito wrote:
> > > > > > On Thu, 2009-01-29 at 21:32 +1100, James Morris wrote:
> > > > > > > I'm trying to run the LTP SELinux tests using the latest CVS =
version of=20
> > > > > > > LTP and current Fedora development, and get the following pol=
icy=20
> > > > > > > compilation error:
> > > > > > >=20
> > > > > > > ----
> > > > > > > Compiling targeted test_policy module
> > > > > > >=20
> > > > > > > test_policy.te:1730: Warning: r_dir_perms is deprecated pleas=
e use list_dir_perms instead.
> > > > > > > test_policy.te:1731: Warning: r_file_perms is deprecated plea=
se use read_file_perms instead.
> > > > > > > [lots of warnings similar to the above]
> > > > > > >=20
> > > > > > > /usr/bin/checkmodule:  loading policy configuration from=20
> > > > > > > tmp/test_policy.tmp
> > > > > > > test_policy.te":16:ERROR 'syntax error' at token=20
> > > > > > > 'userdom_use_sysadm_terms' on line 3198:
> > > > > > > userdom_use_sysadm_terms(testdomain)
> > > > > > > # This allows read and write sysadm ttys and ptys.
> > > > > > > /usr/bin/checkmodule:  error(s) encountered while parsing con=
figuration
> > > > > > > make[1]: *** [tmp/test_policy.mod] Error 1
> > > > > > > make[1]: Leaving directory `/usr/share/selinux/devel'
> > > > > > > make: *** [load] Error 2
> > > > > > > Failed to build and load test_policy module, aborting test ru=
n.
> > > > > > > ----
> > > > > > >=20
> > > > > > > Is this likely to be fixed soon, and/or any suggestions for a=
 workaround?
> > > > > >=20
> > > > > > It won't compile with the current trunk refpolicy, since the cu=
rrent
> > > > > > release was a major, API breaking change.  I'll try to get a pa=
tch out
> > > > > > shortly.
> > > > >=20
> > > > > I updated the policy since its fairly old, though I didn't conver=
t its
> > > > > raw rules over to use interfaces.  However this didn't completely=
 fix
> > > > > it, as there is usage of a "unconfined_runs_test()", which isn't =
in the
> > > > > upstream refpolicy nor the fedora policy, as far as I can see.  O=
ne of
> > > > > the updates includes use of sysadm_entry_spec_domtrans_to(), whic=
h is in
> > > > > the upstream refpolicy, but doesn't seem to have made its way dow=
nstream
> > > > > to the fedora policy.  I have attached my work so someone familia=
r with
> > > > > the LTP test cases can use it to complete the fix.
> > > >=20
> > > > Serge put together a patch and script under selinux-testsuite/misc =
that
> > > > defines unconfined_runs_test() as well as converting some of the
> > > > interfaces.  That was done so that the ltp testsuite could still be=
 run
> > > > on older distributions (w/ the older policy) and on newer distribut=
ions
> > > > (w/ the patch applied to perform conversion).  It was originally do=
ne
> > > > based on the deprecation of the sbin interfaces, which is why it is
> > > > named that way even though it now includes more than just conversio=
n of
> > > > those interfaces.
> > >=20
> > > (Sorry, this thread is rolling into my inbox delayed and out-of-order=
)
> > >=20
> > > So the unconfined_runs_test() shouldn't actually be a problem (right,
> > > Chris? pls let me know if you actually get compile failures as then
> > > something went wrong with the build scripts).
> >=20
> > I just went to the directory and ran make.  Sounds like I might have
> > done something wrong.
> >=20
> > > But what could have happened with sysadm_entry_spec_domtrans_to()?  I=
t
> > > must have been in fedora's policy before, since it definately worked =
on
> > > fedora 7 and 8.  Has it been removed?  (I'll fire up a f10 partition =
and
> > > look through the policy sources...)
> >=20
> > Well it used to be userdom_sysadm_entry_spec_domtrans_to().
> >=20
> > > As for the list_dir_perms and read_file_perms, have those always macr=
os
> > > in the refpolicy?  If so, then a straight search-and-replace is fine.
> > > If not, then we'll have to do another hook at the policy build to mak=
e
> > > the substitutions only when the policy is new enough.  :(
> >=20
> > Those have been around for a while.  While the old r_dir_perms and
> > r_file_perms macros aren't going anywhere for the forseeable future,
> > their use is problematic as those may not get updated for new perms,
> > such as open.
>=20
> So I guess we should switch all the instances over, and have
> misc/update_refpolicy.sh switch them back if list_dir_perms
> doesn't exist.
>=20
> What would be a good way to determine whether we're in a kernel
> version too old to use those?  Can we just check whether
> sestatus | grep version | awk -F: '{ print $2 '} is less than,
> say, 22?

Well the new permission sets have been around since the end of 2006.
But a kernel with v22 policy would probably be a good way to determine
if it should be switched.  Those kernels wouldn't have new permissions
like open, so it would be safe to use the old permission sets.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-vfi90eJMevvKwETyCgSA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmIS+4ACgkQvI7kLeavkkOvuACfRrJjeMPjIvAzZ0uuAIEYdf+w
ayoAni4Z4vEbHcXnv70D+qT1ASCzbI5f
=D0qS
-----END PGP SIGNATURE-----

--=-vfi90eJMevvKwETyCgSA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
