Message-ID: <1328736760.5174.11.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
Date: Wed, 08 Feb 2012 13:32:40 -0800
In-Reply-To: <1328732265.19254.95.camel@moss-pluto>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636826.2162.60.camel@moss-pluto>
	 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
	 <20120207200224.GB18478@colliertech.org>
	 <1328645305.2162.105.camel@moss-pluto>
	 <20120207210501.GE18478@colliertech.org>
	 <1328707470.19254.16.camel@moss-pluto>
	 <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328723647.19254.62.camel@moss-pluto>
	 <1328730315.5174.1.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328732265.19254.95.camel@moss-pluto>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1qGcXVopqxvRJRSmmM3v"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1qGcXVopqxvRJRSmmM3v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-08 at 15:17 -0500, Stephen Smalley wrote:
> On Wed, 2012-02-08 at 11:45 -0800, C.J. Adams-Collier KF7BMP wrote:
> > > > $ locate xserver.pp
> > > > /usr/share/selinux/default/xserver.pp
> > > >=20
> > > > I'll run semodule -i after this morning's reboot.  I installed mutt
> > > > yesterday, so I'll work from the console until you folks sign off f=
or
> > > > the evening.
> > >=20
> > > I'd suggest installing all of the .pp files to ensure you aren't miss=
ing
> > > anything else.  The man page for semodule has some examples of how to
> > > install all modules from a directory.
> >=20
> > What's the best way to do this at boot?
>=20
> You just do it once and it remains until/unless you remove it with
> semodule -r.  No need to do it on each boot.  Normally it is done when
> you install the policy package, but since your policy package apparently
> didn't install all modules, I'm suggesting that you do so manually. =20
>=20
> cd /usr/share/selinux/default
> ls *.pp | grep -Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule -b=
 base.pp -i
> should install them all.

Okay.  Do these ever get purged under any other circumstances?  I noted
that when I booted without selinux enabled and then with it enabled, the
filesystem was re-labeled.  Does anything else get triggered in this
situation?  Specifically, do policies get removed?

It looks like the alsa.pp is failing, so my working and slightly
modified command was:

        $ pushd /usr/share/selinux/default
        $ time sudo \
        semodule -i `ls *.pp | grep -v -e 'base.pp' -e 'alsa.pp'`
       =20
        real	0m24.148s
        user	0m23.249s
        sys	0m0.628s
       =20
This seems like it would take slightly less time than piping the output
of ls to xargs, since it only runs semodule once.

        $ time ls *.pp | grep -v -e 'base.pp' -e 'alsa.pp' | \
        xargs sudo semodule -b base.pp -i=20
       =20
        real	0m25.659s
        user	0m24.778s
        sys	0m0.660s

But they both get the job done and the difference in run time is very
small.


--=-1qGcXVopqxvRJRSmmM3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPMun4AAoJEEyimPmPQm23JgwH/AmWChuzJkWoJLWnaTMjNXJN
iaMmAvgerwN/oKstL9MoARxikPpuuS5XRek7g+zF4IHAWmAe3JL2EgntsWnIeh4J
lnkgZSQJYWn07b0LPyPxGAMJnGyoaVWuhRBZi3UiKbLKvDo1PaaM/7Llb48E2W87
CG349CVGIwhfZyaDFGAJ8ft64QWRd669HbKg3YlysEEbeHJNk0pK5Vs7Z8QXahOA
unJKeaoF+4sab1Qj5SFa4Y3Cjx7TB5rlg6dsOdjUMI7jd+AHBJnweSpC0S1nMfjo
nMrnnf4Mj80bIX0KynTJJnnpfEdoUmlydbhb2eWmzeGdVZvXMnjOfzeklun8kkU=
=U5JI
-----END PGP SIGNATURE-----

--=-1qGcXVopqxvRJRSmmM3v--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
