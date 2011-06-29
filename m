Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5THFi8A023192
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 13:15:44 -0400
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p5THFhON023153
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 17:15:44 GMT
Received: by eyh5 with SMTP id 5so561392eyh.12
        for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 10:15:42 -0700 (PDT)
Subject: Re: htpasswd file outside of standard Apache location
From: Dominick Grift <domg472@gmail.com>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: selinux@tycho.nsa.gov
Date: Wed, 29 Jun 2011 19:15:38 +0200
In-Reply-To: <1309366657.4648.40.camel@mattotaupa>
References: <1309366657.4648.40.camel@mattotaupa>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-SJoUHmYYQFes8rV7dCYZ"
Message-ID: <1309367740.3643.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-SJoUHmYYQFes8rV7dCYZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2011-06-29 at 18:57 +0200, Paul Menzel wrote:
> Dear SELinux folks,
>=20
>=20
> I am running Debian Squeeze with SEL
> inux and Apache.
>=20
> In Apache I configured a secured section using `AuthType Basic` with
> `AuthUserFile /srv/site.htpasswd`. It works when the state of the system
> is permissive. When in enforcing state the following error is logged.
>=20
>         type=3DAVC msg=3Daudit(1308090063.174:17742): avc:  denied  { get=
attr } for  pid=3D1412 comm=3D"apache2" path=3D"/srv/www/www.example.net/fo=
o/bar.tar.gz" dev=3Dxvda ino=3D425775 scontext=3Dunconfined_u:system_r:http=
d_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tclass=
=3Dfile
>         type=3DSYSCALL msg=3Daudit(1308090063.174:17742): arch=3Dc000003e=
 syscall=3D6 success=3Dno exit=3D-13 a0=3D7f9da985eb38 a1=3D7fff8da1e6f0 a2=
=3D7fff8da1e6f0 a3=3D1 items=3D0 ppid=3D29237 pid=3D1412 auid=3D4294967295 =
uid=3D33 gid=3D33 euid=3D33 suid=3D33 fsuid=3D33 egid=3D33 sgid=3D33 fsgid=
=3D33 tty=3D(none) ses=3D4294967295 comm=3D"apache2" exe=3D"/usr/lib/apache=
2/mpm-prefork/apache2" subj=3Dunconfined_u:system_r:httpd_t:s0-s0:c0.c1023 =
key=3D(null)
>=20
> Is there a recommended location for these password files or a
> recommended way what policies to set. Not being sure of the correct
> search term for this I found plenty of sites regarding SELinux and
> Apache but nothing related to my problem in the results. If you could
> point me to some specific documentation that would be great too.
>=20
>=20
> Thanks,
>=20
> Paul

If you are using a different location for your web server then it is
best to clone the web server locations file contexts.

In fedora the semanage command has a handy option to do this very
easily:

     # semanage fcontext -a -e /var/www /srv/www
     # restorecon -R -v /srv/www

this will clone all the file context specifications for /var/www and its
children to apply for /srv/www as well

If debian does not support this option then you would do it manually.

1. to list the file context specs for /var/www and its children:

 # semanage fcontext -l | grep /var/www

2. an example of how you would add a file context spec for /var/www:

 # semanage fcontext -a -t httpd_sys_content_t "/srv/www(/.*)?"
 # restorecon -R -v /srv/www

(This is just one example)

The issue is that objects are labelled with contexts which include types
which are used for type enforcement. Each type has a set of properties
that matches the characteristics of the object in relation to the
subjects that needs to interact with it.

So it is important that each object gets the proper context.


--=-SJoUHmYYQFes8rV7dCYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk4LXboACgkQMlxVo39jgT/KWACgwaPpg/2imy4JlVThg37iHbaR
adwAn2+eIxBu7ajQMOaw+lgTYPoOTpGQ
=FJyG
-----END PGP SIGNATURE-----

--=-SJoUHmYYQFes8rV7dCYZ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
