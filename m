Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4AJXQgA012747
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2005 15:33:26 -0400 (EDT)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4AJUr6B018370
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2005 19:30:53 GMT
Subject: Re: [selinux] HOWTO Install SELinux on Ubuntu
From: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
Reply-To: lorenzo@gnu.org
To: "Brian T. Sniffen" <bsniffen@mitre.org>
Cc: ubuntu-hardened@lists.ubuntu.com, selinux@tycho.nsa.gov
In-Reply-To: <d28acn2j3nd.fsf@jon-strange.mitre.org>
References: <1115152564.15188.24.camel@localhost.localdomain>
	 <d28acn2j3nd.fsf@jon-strange.mitre.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cE/RcbtYdqArE3/CDBbA"
Date: Tue, 10 May 2005 21:28:14 +0200
Message-Id: <1115753294.1937.17.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cE/RcbtYdqArE3/CDBbA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

El mar, 10-05-2005 a las 15:13 -0400, Brian T. Sniffen escribi=F3:
> Thanks for writing this up.  I tried to follow the instructions on an
> Ubuntu machine, but had serious problems:


First, many thanks for testing and I'm glad that it's helpful even if
some things need to be worked out ;)
>=20
> * The basic packages (e.g., coreutils) installed fine.  I had some
>   difficulties with the selinux-aware PAM 0.78 packages: they
>   complained about a missing module in pam_authenticate.  It was
>   somewhat annoying to debug this, since it caused login and sudo to
>   fail.  I never did solve this problem, because I gave up on:

Well, Andrew Mitchell has fixed the packages but until we upload them to
pearls.tuxedo-es.org and refresh the repository, I've removed the PAM
packages from the apt-get'able repository, and moved them into:
http://pearls.tuxedo-es.org/selinux/ubuntu.wip/

> * The selinux-policy-targeted package in your suggested repository fails =
to
>   install.  There is no appconfig directory.

I'll check. The package is to be updated as of the forthcoming new
upstream release, among that the policies are still under development
and possibly we may use binary policy modules as shown in the diagram at
http://pearls.tuxedo-es.org/selinux/diagrams/selinux-binary-policies-1.png.

Much like Gentoo does but used pre-compiled policies.

>=20
> * The selinux-policy-default package also fails to install.  There are
>   many .te files without corresponding .fc files.  The postinst script
>   exits with status 1, apparently failing to copy policy/default to
>   policy/current.

-default which is to be renamed to -strict, is maintained by Russell
Coker, thus, it's refreshed eventually from Debian repositories.
Among that issues, the configuration method needs to be reworked too.

> * Those two policy packages conflict in practice, but have neither
>   diversions nor explicit Conflict headers.

Right, it's to be fixed after -default gets renamed to -strict, and
-default gets converted to a meta-package depending on the final /
approved default policy, among -server and -desktop packages depending
on -strict and -targeted respectively.

> * There is no selinux-support package in your selinux/ubuntu apt
>   repository---only over in selinux/debian.

Right, even if it's "Ubuntu'ized" (version depends and the like).
Thanks for pointing this out too.

> This looks like a great project---I'd be very happy to have a second
> Desktop SE Linux project for which to develop in parallel with Fedora.
> It would help, I think, resolve what are elements of a Desktop SE
> Linux install, and what features are really Red Hat's, not necessary
> to SE Linux.

Right, there's a need of deployment for a well designed and implemented
containment/confinement model and SELinux fits all the needs of a
project of the dimension of Ubuntu Linux.

A specification regarding such deployment and development is in the
writing process, to be released soon (well, I had a few issues that
stopped me to finish it in the expected time, I apologize).

> But right now, I don't think it's ready for prime time.  Since
> unhorking a machine with broken PAM is a bit tricky, perhaps you could
> add a note to the top of your web page explaining that the following
> instructions may break your machine, and to be exceptionally careful
> about having a backout-path before attempting them.

The PAM thing is quite weird, right. Hopefully, fixed packages will get
uploaded soon.

You can feel free to add anything you want to the HOWTO. I will add the
note.

Many thanks again for all the comments and testing, hope to see you here
for a long while ;)

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-cE/RcbtYdqArE3/CDBbA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCgQtODcEopW8rLewRAsu2AJ9kpkJSeGc82d5i8gENfZyzkub9IACfWTGO
4KEz/FfyaS/5RkPH0k/MTzE=
=5s+5
-----END PGP SIGNATURE-----

--=-cE/RcbtYdqArE3/CDBbA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
