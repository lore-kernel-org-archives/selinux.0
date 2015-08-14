Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7E8N2ri023216
 for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2015 04:23:02 -0400
Received: by wibhh20 with SMTP id hh20so12449908wib.0
 for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2015 01:22:59 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id x6sm1899270wiy.6.2015.08.14.01.22.59
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2015 01:22:59 -0700 (PDT)
Date: Fri, 14 Aug 2015 10:22:57 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: selinux mls/mcs rang modify
Message-ID: <20150814082256.GA26540@x250>
References: <BLU436-SMTP8926E1E94C430CC9C28B0F9D7C0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <BLU436-SMTP8926E1E94C430CC9C28B0F9D7C0@phx.gbl>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 02:45:05PM +0800, rowan wrote:
> Dear all,
>=20
>          When do test, I use semanage change the mls/mcs range of selinux
> user 'system_u' from 's0-s0:c0.c1023' to 's0-s0:c0.c1020',cmd as bleow
>=20
>                    'semanage user -m -r s0-s0:c0.c1020 system_u'
>=20
> =20
>=20
> How do I change it back?

I think I know what you are getting at here. Libsemanage does not do a good=
 job with validation.

you could try to remove or change  any login mappings of system_u that auth=
orize use of categories that exceeds the range associated with system_u use=
r mapping first , or change that range so that it is equal to or fall in th=
e range of the system_u user mapping.

What, i think happened was, is that libsemanage allowed you to change the r=
ange associated with the system_u id, even though there is a login mapping =
in place that associates one or more linux uids with system_u and a range t=
hat exceeds the range that is associated with system_u

libsemanage shouldnt have let you done that in the first place. It should h=
ave said instead: " Hey! i noticed you are trying to change the levelrange =
associated with system_u, but there currently is a login mapping in place t=
hat associates system_u, and a range that exceeds that of system_u with a l=
inux id. I can't do that!"

Now when you try to change the range associated with system_u back to the o=
ld state. libsemanage wont allow you to because there is a login mapping of=
 system_u with a range that exceeds the current range.

So if this is at all possible without manually editting /etc/selinux/*/seus=
ers(.local)? then try and use semanage to make the range of any login mappi=
ng that applies to system_u equal or less than the range associated with sy=
stem_u id

I hope this makes sense, i realise that it is kind of confusing

>=20
> =20
>=20
> Thanks
>=20
> rowan
>=20

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVzaVcAAoJENAR6kfG5xmc2PoL/j6gHxvkFciNvp6RiqmV+sfa
hEbX1V3VJ3R2Pq29I20aCwfQ8GkJSze/4+E20vNryL55R0u/GYcBKHEpl/N82oaQ
v3zCaBzGScgH+qUbXdc9LMjy4ZviFiDHgEBZT0yYtFX0JKHj1KSSUTYJHLbn4F95
t1bmY7qaHkjKlY+JBpH26B69JRnbJhYf8o5EpQhxZzw+HmjZNvwUgqybPhwZ/DoS
jtD/TZFz60WO+s4JZhEpV8rm9Jx2ETXkHpZq+ceYwgKZ/QAuNzcTVR4oFQd6yoJj
Q16S615CtnaEvOxYBStj2Abn24GxtHjSL0xoqMLrfEW3JpMeCgDxaM6cKtzZ7dcP
/Y0qHfrRjVBtKUt0Hcz/NlIPwt5zPRgJ+P2hlVSFwDIj1Ff+qaZND7aD87TNb/JU
FBJSSbpEklWvn0K6E4/uqh9H0mGn73dTgPwq6IEq3Xo9jVyIyFQpcO9b561h4GeF
pI81nXLmBfsSHLbzBcwqIIHk5sAICvGkErvxNuyH7g==
=4FYk
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
