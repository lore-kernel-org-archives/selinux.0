Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6LN5prT001092
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2004 19:05:52 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6LN5NRL012915
	for <selinux@tycho.nsa.gov>; Wed, 21 Jul 2004 23:05:24 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 22 Jul 2004 01:05:48 +0200
Date: Thu, 22 Jul 2004 01:06:06 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
Message-Id: <20040721230605.GD2848@jmh.mhn.de>
References: <40FADE92.7060307@gentoo.org> <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil> <40FD6114.3020808@gentoo.org> <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil> <40FD814B.2060503@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <40FD814B.2060503@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Joshua Brindle <method@gentoo.org> [2004-07-20 23:57]:
> James Carter wrote:
> >I was trying to say that you are trying to manually do something that
> >the kernel can do automatically. =20
> >
> >You don't need to do the security_create_compute() and setexeccon()
> >before the exec, because, on the exec, the kernel will do the same
> >thing.  In both cases, you would have had to use the domain_auto_trans
> >macro, so you don't gain anything by doing it manually.
> >
> >Without an exec, setexecon() won't help you. =20
> >>From selinux.h:
> >/* Set exec security context for the next execve.=20
> >  Call with NULL if you want to reset to the default. */
> >extern int setexeccon(security_context_t con);
> >
> >I am not an expert on Apache and php, but I am pretty sure that when you
> >execute the php interpreter an exec is occurring somewhere.
> >
> Right, an exec is happening from httpd_t to php_exec_t currently, and=20
> this will give back php_exec_t. Thats the standard way php is done in=20
> SELinux at the moment and exactly what I'm trying to make better.
>=20
> Now, the new idea is to have fastcgi wrapper which already does setuid()=
=20
> and setgid() based on the ownership of the target php script (this is a=
=20
> script! it is not executed by execve()) and then executes php (which is=
=20
> php_exec_t) resulting in php_t again. What I want it to do is also read=
=20
> the context of the target script and calculate the autotrans that would=
=20
> happen if php was going to execute the script directly and then do=20
> setexeccon() to do it manually.

How does cron handle this? I think that cron is in a similar situation
since it can't exec the users crontab. From macros/program/crond_macros.te:

# Permit a transition from the crond_t domain to this domain.
# The transition is requested explicitly by the modified crond
# via execve_secure.  There is no way to set up an automatic
# transition, since crontabs are configuration files, not executables.
domain_trans(crond_t, shell_exec_t, $1_crond_t)

Additionaly, crond has this:
# Set exec context.
can_setexec(crond_t)

Maybe someone who knows the cron code better than me can explain what
exactly cron is doing and if this can be applied to the fastcgi code as
well.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/vbdxWIrrrL0q+cRAiZfAKCQaRnRF7Jd+RMr5zZ/u9En4yp6ygCcCB81
i4Luwpch0Io/ApfhAs92tT4=
=RKO0
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
