Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5TN1vLs031497
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 19:01:57 -0400
Received: from mail.gw90.de (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p5TN1ua5019739
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 23:01:56 GMT
Received: from f053043156.adsl.alicedsl.de ([78.53.43.156] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1Qc3ld-0005kZ-Af
	for selinux@tycho.nsa.gov; Wed, 29 Jun 2011 23:01:58 +0000
Subject: context of files not adapted to new directory when moved (was:
 htpasswd file outside of standard Apache location)
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: selinux@tycho.nsa.gov
In-Reply-To: <1309367740.3643.12.camel@localhost.localdomain>
References: <1309366657.4648.40.camel@mattotaupa>
	 <1309367740.3643.12.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uah8EhNlAr05l0SfRllW"
Date: Thu, 30 Jun 2011 01:01:52 +0200
Message-ID: <1309388512.13175.35.camel@mattotaupa>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uah8EhNlAr05l0SfRllW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 29.06.2011, 19:15 +0200 schrieb Dominick Grift:
> On Wed, 2011-06-29 at 18:57 +0200, Paul Menzel wrote:

> > I am running Debian Squeeze with SELinux and Apache.
> >=20
> > In Apache I configured a secured section using `AuthType Basic` with
> > `AuthUserFile /srv/site.htpasswd`. It works when the state of the syste=
m
> > is permissive. When in enforcing state the following error is logged.
> >=20
> >         type=3DAVC msg=3Daudit(1308090063.174:17742): avc:  denied  { g=
etattr } for  pid=3D1412 comm=3D"apache2" path=3D"/srv/www/www.example.net/=
foo/bar.tar.gz" dev=3Dxvda ino=3D425775 scontext=3Dunconfined_u:system_r:ht=
tpd_t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tclass=
=3Dfile
> >         type=3DSYSCALL msg=3Daudit(1308090063.174:17742): arch=3Dc00000=
3e syscall=3D6 success=3Dno exit=3D-13 a0=3D7f9da985eb38 a1=3D7fff8da1e6f0 =
a2=3D7fff8da1e6f0 a3=3D1 items=3D0 ppid=3D29237 pid=3D1412 auid=3D429496729=
5 uid=3D33 gid=3D33 euid=3D33 suid=3D33 fsuid=3D33 egid=3D33 sgid=3D33 fsgi=
d=3D33 tty=3D(none) ses=3D4294967295 comm=3D"apache2" exe=3D"/usr/lib/apach=
e2/mpm-prefork/apache2" subj=3Dunconfined_u:system_r:httpd_t:s0-s0:c0.c1023=
 key=3D(null)
> >=20
> > Is there a recommended location for these password files or a
> > recommended way what policies to set. Not being sure of the correct
> > search term for this I found plenty of sites regarding SELinux and
> > Apache but nothing related to my problem in the results. If you could
> > point me to some specific documentation that would be great too.

> If you are using a different location for your web server then it is
> best to clone the web server locations file contexts.

Understood. This is off-topic, but do password files belong to the Web
server configuration and should be stored in `/etc/apache2/`? You could
argue passwords belong to the Web site and when you move it you should
easily move the passwords with you. On the other hand the secured
directories are also listed in the Web server configuration file under
`/etc/apache2/` and therefore you cannot move the site without moving or
duplication the Web server configuration files either.

> In fedora the semanage command has a handy option to do this very
> easily:
>=20
>      # semanage fcontext -a -e /var/www /srv/www
>      # restorecon -R -v /srv/www
>=20
> this will clone all the file context specifications for /var/www and its
> children to apply for /srv/www as well
>=20
> If debian does not support this option then you would do it manually.

`semanage` is also included in Debian.

> 1. to list the file context specs for /var/www and its children:
>=20
>  # semanage fcontext -l | grep /var/www

Thank you for this hint. Using it I could figure out that it already
includes the following policies(?).

        $ sudo semanage fcontext -l | less
        [=E2=80=A6]
        /srv/([^/]*/)?www(/.*)?                            all files       =
   system_u:object_r:httpd_sys_content_t:s0
        [=E2=80=A6]
        /var/www(/.*)?                                     all files       =
   system_u:object_r:httpd_sys_content_t:s0
        [=E2=80=A6]

Also the password file seemed to have the correct contexts(?).

        $ ls -Z /srv/site.htpasswd
        system_u:object_r:httpd_sys_content_t /srv/site.htpasswd

> 2. an example of how you would add a file context spec for /var/www:
>=20
>  # semanage fcontext -a -t httpd_sys_content_t "/srv/www(/.*)?"
>  # restorecon -R -v /srv/www
>=20
> (This is just one example)

Then looking at the file to be served in question I found out that it
had the wrong context.

        $ ls -Z /srv/www/site/restricted/*
        unconfined_u:object_r:user_home_t /srv/www/site/restricted/bar.tar.=
gz
        $ sudo restorecon -v /srv/www/site/restricted/bar.tar.gz
        [=E2=80=A6]
        $ ls -Z /srv/www/site/restricted/*
        system_u:object_r:httpd_sys_content_t /srv/www/site/restricted/bar.=
tar.gz

That solved my problem. The reason seems to be that I had that file
first in my home directory and then used

        sudo mv ~/bar.tar.gz /srv/www/=E2=80=A6

to move it to the Web site directory. `mv` seems to preserve the old
SELinux contexts and I have to relabel it afterward. Is there a way to
make the relabel step obsolete?

> The issue is that objects are labelled with contexts which include types
> which are used for type enforcement. Each type has a set of properties
> that matches the characteristics of the object in relation to the
> subjects that needs to interact with it.
>=20
> So it is important that each object gets the proper context.

Thank you very much for your detailed explanation and writing down the
commands. That helped me a lot.


Thanks,

Paul

--=-uah8EhNlAr05l0SfRllW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4Lrs4ACgkQPX1aK2wOHVgzoQCdFRMG0Isrq2NU+vVRfdf3oxyu
9jwAn08asftOxaRiQS2Ci5ToxdeJpI1V
=aD9t
-----END PGP SIGNATURE-----

--=-uah8EhNlAr05l0SfRllW--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
