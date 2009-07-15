Subject: RE: /etc/selinux/  directory structure...
From: Dominick Grift <domg472@gmail.com>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D06F02F2C@de01exm68.ds.mot.com>
References: <D06FE0A2807BC145B0D38744789D4F5D06817A56@de01exm68.ds.mot.com>
	 <13D6E9E0302C0E4B9EE667132D21766C02B8342F@ala-mail09.corp.ad.wrs.com>
	 <D06FE0A2807BC145B0D38744789D4F5D06F02EC0@de01exm68.ds.mot.com>
	 <1247673423.9960.10.camel@notebook2.grift.internal>
	 <D06FE0A2807BC145B0D38744789D4F5D06F02F2C@de01exm68.ds.mot.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9qUeMS1JcxodzRvuOofg"
Date: Wed, 15 Jul 2009 18:28:57 +0200
Message-Id: <1247675337.9960.21.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9qUeMS1JcxodzRvuOofg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-07-15 at 12:09 -0400, Hasan Rezaul-CHR010 wrote:
> Interesting.  Thanks so much for your response.
>=20
> Is there some place I can get more useful info about how best to take my
> current set of 'strict' policies, and sort of migrate them onto the new
> improved targeted policy framework.

Well the way to do it is pretty much the same. But policy itself has
evolved in the meantime. So some of your custom policy may not longer be
applicable.

> I am not dying to use 'strict' policies... The reasons why I was pushed
> in this direction were:
> - I wrote some policies (custom.pp)=20
> to deny certain accesses by certain
> users. The targeted policy didn't seem to be restricting those
> operations, as I had intended. But the strict policy, did.

Now you can use both strict users and unrestricted users or you can
choose to make your targeted policy strict by uninstalling the
unconfined module.

> - I wanted the philosophy of, "when in doubt, block the operation", as
> opposed to "when in doubt, allow the operation".  I felt that the
> 'strict' policy better aligns with that goal. Perhaps I am wrong, and
> either option is viable ?

I like to think least privilege. If i am in doubt i will block until
proven otherwise.

> In any case, I guess I would have to develop my policies again to fit
> with the targeted policy framework now. Any suggestions on a good
> starting point.. Documentation, training materials for developing custom
> policies ?   Thanks again for the help.

Reference policy itself is the best documentation around in my view. It
is full of examples. There is also danwalsh.livejournal.com where dwalsh
pretty much covered all new features. Also the selinux, fedora-selinux
and tresys-refpolicy mail list archives have good information. You can
also get help by joining our irc chat rooms.

Here is a neat summary of some SELinux resources:

http://selinuxproject.org/page/User_Resources


>=20
> -----Original Message-----
> From: Dominick Grift [mailto:domg472@gmail.com]=20
> Sent: Wednesday, July 15, 2009 10:57 AM
> To: Hasan Rezaul-CHR010
> Cc: selinux@tycho.nsa.gov; Daniel J Walsh; Stephen Smalley
> Subject: Re: /etc/selinux/ directory structure...
>=20
> On Wed, 2009-07-15 at 11:25 -0400, Hasan Rezaul-CHR010 wrote:
> > Hi All,
> >=20
> > I work on a product that uses Linux Kernel 2.6.21.  We are currently=20
> > using the following SELinux libs and related package
> > versions:
> >=20
> > checkpolicy      1.33.1
> > libselinux       2.0.13
> > libsemanage      2.0.1
> > libsepol         2.0.3
> > libsetrans       0.1.18
> > policycoreutils  2.0.16
> >=20
> > I am implementing the "Strict" policy. And so I see the directory=20
> > structure on my machine as:
> >=20
> > -------------------------------------------
> > /etc/selinux/config
> > /etc/selinux/restorecond.conf
> > /etc/selinux/semanage.conf
> >=20
> > /etc/selinux/strict/
> > /etc/selinux/strict/contexts/
> > /etc/selinux/strict/modules/
> > /etc/selinux/strict/policy/
> > /etc/selinux/strict/setrans.conf
> > /etc/selinux/strict/seusers
> >=20
> > --------------------------------------------
> >=20
> >=20
> > We are moving to a newer Linux version 2.6.27 (that's packaged for us=20
> > by a third-party company), and as a result of this newer OS delivery,=20
> > we will automatically get moved to the SELinux package version:
> >=20
> > checkpolicy      svn2950
> > libselinux       svn2950
> > libsemanage      svn2950
> > libsepol         svn2950
> > libsetrans       N/A
> > policycoreutils  svn2950
> >=20
> >=20
> > ** My questions are:
> >=20
> > 1. I see the  /etc/selinux/   directory structure is quite different
> for
> > the svn2950 version!  Is it supposed to be that way ?
> >=20
> > 2. Is the difference in directory structure due to the svn2950 package
>=20
> > version, or is it because of a newer Linux kernel version ? (Linux
> > 2.6.21  vs.  Linux 2.6.27)
> >=20
> > 3. Is the 'strict' policy supported in this svn2950 version?
> >=20
> > 4. In the LATEST officially released version(s) of the Selinux=20
> > packages from http://userspace.selinuxproject.org/trac/wiki/Releases,=20
> > is the /etc/selinux/  directory structure the same as I have described
> in the
> > ---  block  ---   above, or did it change ?
> >=20
> > 5. Does the LATEST officially supported versions still support
> "strict"
> > policy, or does it only support "targeted" ??
>=20
> It supports "strict policy" but the strict policy model merged with the
> targeted policy model. You would have to configure the Targeted SELinux
> policy to make it strict.
>=20
> >=20
> > 6. Has the concept of "targeted" policy changed since about two years=20
> > ago ?
>=20
> Not really. Targeted policy still targets a set of processes and the
> rest goes into the unconfined domain. However, now it is possible to
> uninstall the unconfined module which effectively turns your targeted
> policy into a strict policy.=20
>=20
> Basically the targeted policy was extended by the merger with strict
> policy.
>=20
> > Thanks in advance for all your help.
> >=20
> >=20
> > --
> > This message was distributed to subscribers of the selinux mailing
> list.
> > If you no longer wish to subscribe, send mail to=20
> > majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.

--=-9qUeMS1JcxodzRvuOofg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEABECAAYFAkpeA8QACgkQMlxVo39jgT/9IACgz6i5rxjz+gSiRiItFFSwmPx+
DrAAmKAgIUw48LsDQM44fEpLIsSGpMk=
=EPLR
-----END PGP SIGNATURE-----

--=-9qUeMS1JcxodzRvuOofg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
