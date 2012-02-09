Message-ID: <1328808846.5174.41.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
Date: Thu, 09 Feb 2012 09:34:06 -0800
In-Reply-To: <1328795756.6866.30.camel@moss-pluto>
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
	 <1328736760.5174.11.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328795756.6866.30.camel@moss-pluto>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-WZB7/Y/PLSZs2518d27C"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WZB7/Y/PLSZs2518d27C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-02-09 at 08:55 -0500, Stephen Smalley wrote:
> On Wed, 2012-02-08 at 13:32 -0800, C.J. Adams-Collier KF7BMP wrote:
> > Okay.  Do these ever get purged under any other circumstances?  I noted
> > that when I booted without selinux enabled and then with it enabled, th=
e
> > filesystem was re-labeled.  Does anything else get triggered in this
> > situation?  Specifically, do policies get removed?
>=20
> No.
>=20
> > It looks like the alsa.pp is failing, so my working and slightly
> > modified command was:
>=20
> That's interesting, and it might explain why your policy didn't get
> fully installed originally.  Is that alsa.pp file from the current
> selinux-policy package or is it a leftover of an older one?  What is the
> error you get with it?  It should be removed if it doesn't work.

cjac@foxtrot:~$ locate alsa.pp | xargs dpkg -S | awk -F: '{print $1}' | xar=
gs debsums | grep alsa.pp
/usr/share/selinux/default/alsa.pp                                         =
   OK
cjac@foxtrot:~$=20

How do I check for an error.  Not on STDOUT or STDERR it seems...  This
may be one of the strangest, least useful error message I've ever seen.
But it's got stiff competition.

cjac@foxtrot:~$ locate alsa.pp | xargs dpkg -S | awk -F: '{print $1}' | xar=
gs debsums | grep alsa.pp | sudo xargs semodule -i
semodule:  Failed on OK!


> >         $ pushd /usr/share/selinux/default
> >         $ time sudo \
> >         semodule -i `ls *.pp | grep -v -e 'base.pp' -e 'alsa.pp'`
> >        =20
> >         real	0m24.148s
> >         user	0m23.249s
> >         sys	0m0.628s
> >        =20
> > This seems like it would take slightly less time than piping the output
> > of ls to xargs, since it only runs semodule once.
> >=20
> >         $ time ls *.pp | grep -v -e 'base.pp' -e 'alsa.pp' | \
> >         xargs sudo semodule -b base.pp -i=20
> >        =20
> >         real	0m25.659s
> >         user	0m24.778s
> >         sys	0m0.660s
> >=20
> > But they both get the job done and the difference in run time is very
> > small.

Yep.  Might be a potential indicator for performance improvement,
however.

> Feel free to submit a patch for the EXAMPLES section in the semodule man
> page.  Even better would be to improve semodule so that it automatically
> detects the base module and handles it so that you can just do semodule
> -i *.pp in all cases and not have to worry about filtering the list and
> handling base specially.

sounds reasonable.  git uri anyone?



--=-WZB7/Y/PLSZs2518d27C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPNAOOAAoJEEyimPmPQm23GLMH/RvztHlBQ5HfUTsoUkEUthV4
IEYyuUlvWYvQ6vOOeI+KSmhnQcbNH2NNbHEQAFWE33a0k+fhJ1rC8UouMb0siEOq
GeKMlH0bdTXuRgg+qTgMTASfr2Rj+4cnp9WMw+xIpZmEX0NHsLqT+r/xNK2j7i/E
/HFBSd0RoxY9S9Bx4whIkZq8SQ+kt1qpie5WQ71PUUhGB5Ii9tWaH+6VxjwmHkw8
XCrtAOLTMI4DKc+P17+aMbEPGOpk5r8D26yhpdWodZL+DFXLC3mTy5BlxqQDBB3G
/UiwTveEjd3LA8+gahQtWOg4LSSY1OziSFz5Aztx5o/8WwWilnn/ZGaBhk+na0c=
=oM5a
-----END PGP SIGNATURE-----

--=-WZB7/Y/PLSZs2518d27C--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
