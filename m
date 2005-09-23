Date: Fri, 23 Sep 2005 22:03:47 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dale Amon <amon@vnl.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: More Debian bugs
Message-ID: <20050923210347.GB21546@vnl.com>
References: <20050923195227.GA21546@vnl.com> <1127506232.27851.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
In-Reply-To: <1127506232.27851.100.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2005 at 04:10:32PM -0400, Stephen Smalley wrote:
> You can change it to build policy.19 by adding the -c 19 option to
> checkpolicy.  Attached policy Makefile diff from upstream CVS causes it
> to build both versions and load the right one.

Good. Still, someone should update the patches in Debian. If
they are that far behind, lord only knows what other bugs
are still in there.
=20
> > sepol_genusers: can't find system.users
> > No such file or directory
> > unable to get boolean names: No surc file or directory
>=20
> That's technically ok; load_policy will fall back to just the raw binary
> policy image if those files don't exist.  But the Debian policy package
> should create them nonetheless, like the Fedora one.

Okay, that should mean I'm just about there.=20
=20
> > I also note there are some dangling softlinks created
> > by the setools package:
> >=20
> > /usr/share/setools/
> > lrwxrwxrwx  1 root root     24 2005-09-23 18:18 seaudit-report.conf -> =
/etc/seaudit-report.conf
> > lrwxrwxrwx  1 root root     23 2005-09-23 18:18 seaudit-report.css -> /=
etc/seaudit-report.css
> > lrwxrwxrwx  1 root root     16 2005-09-23 18:18 seuser.conf -> /etc/seu=
ser.conf
> >=20
> > But the targets are not at those locations, they are:
> > /etc/setools/
> > -rw-r--r--  1 root root 2805 2005-09-15 08:29 seaudit-report.conf
> > -rw-r--r--  1 root root 3040 2005-09-15 08:29 seaudit-report.css
> > -rw-r--r--  1 root root 1815 2005-09-15 08:29 seuser.conf
>=20
> Hmmm...on Fedora, they aren't symlinks and there is no /etc/setools.
> You may just want to grab the latest upstream tarball for setools from
> Tresys and build it directly.  But note that setools is purely optional;
> it is not required for operation of SELinux at all. =20

I included these for completeness... like the other
error messages they are not fatal but are something
that the packager should fix just to be tidy.

I'll have to see if I have time to swap drives this
evening and have another go. I presume I'm on my own
over the weekend...

--=20
------------------------------------------------------
             Artemis Systems Development
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNG2zZHES7UL0zXERAsmZAJ4gxAjboNfh63+MBytkPdmxpDid1wCeL1np
wFnPgIN3ulojEUX0VFH9PCs=
=NI94
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
