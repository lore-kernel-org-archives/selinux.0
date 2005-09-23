Date: Fri, 23 Sep 2005 20:52:27 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <SELinux@tycho.nsa.gov>
Subject: More Debian bugs
Message-ID: <20050923195227.GA21546@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As I plough onwards... with last nights set of hacks
I was able to label files today. But that is about it.
The latest debian packaged kernel turns out to have
POLICYVERS=3D19 in security.h. However, the selinux-policy-default
package builds a policy.20.=20

I have other error messages which may or may not
follow from that problem. When I attempt a load_policy:

sepol_genusers: can't find system.users
No such file or directory
unable to get boolean names: No surc file or directory

I also note there are some dangling softlinks created
by the setools package:

/usr/share/setools/
lrwxrwxrwx  1 root root     24 2005-09-23 18:18 seaudit-report.conf -> /etc=
/seaudit-report.conf
lrwxrwxrwx  1 root root     23 2005-09-23 18:18 seaudit-report.css -> /etc/=
seaudit-report.css
lrwxrwxrwx  1 root root     16 2005-09-23 18:18 seuser.conf -> /etc/seuser.=
conf

But the targets are not at those locations, they are:
/etc/setools/
-rw-r--r--  1 root root 2805 2005-09-15 08:29 seaudit-report.conf
-rw-r--r--  1 root root 3040 2005-09-15 08:29 seaudit-report.css
-rw-r--r--  1 root root 1815 2005-09-15 08:29 seuser.conf

Although I have not looked at Stephens patches, I
would very much be surprised if I could just change
the defines in security.h, rebuild the kernel and
have it work...

I've got a bad feeling that the debian kernel
(2.6.12-1-686) is using a very out of date=20
selinux patch set.

--=20
------------------------------------------------------
             Artemis Systems Development
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDNFz7ZHES7UL0zXERAsbqAJ9lj2aH7w860BWwlNQpwyaSozFTeQCdGI/U
g/gxhIWuvl5JXQ6AX1LjpZw=
=slJk
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
