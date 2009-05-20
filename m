From: Dennis Wronka <linuxweb@gmx.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Policy loading problem
Date: Wed, 20 May 2009 23:44:13 +0800
Cc: SELinux@tycho.nsa.gov
References: <1242641994.470.5.camel@notebook2.grift.internal> <200905202257.08555.linuxweb@gmx.net> <1242831553.20082.406.camel@localhost.localdomain>
In-Reply-To: <1242831553.20082.406.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2099818.ZMGN6gSeVg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200905202344.16667.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart2099818.ZMGN6gSeVg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Just an idea:
Wouldn't it be possible to split CONFIG_SECURITY_SELINUX_DEVELOP into two=20
options, pretty much like CONFIG_SECURITY_SELINUX_BOOTPARAM and=20
CONFIG_SECURITY_SELINUX_DISABLE?

I like the idea because it would prevent somebody that has physical access =
to=20
set SELinux to permissive (and thus practically disabling its protection) o=
n=20
boot, but still keep the option for root (either as sysadm_r or, preferably=
,=20
as secadm_r) to switch to permissive mode after boot.

On Wednesday 20 May 2009 22:59:13 Stephen Smalley wrote:
> On Wed, 2009-05-20 at 22:57 +0800, Dennis Wronka wrote:
> > Okay, here we go:
> >
> > I unmounted /selinux and then got this:
> > load_policy: Can't load policy: Invalid argument
> >
> > I attached my kernel-config and the two traces (trace1 for the "Device =
or
> > resource busy"-error, trace2 for the "Invalid argument"-error).
>
> Ahem.  Your kernel config has these SELinux options:
> CONFIG_SECURITY_SELINUX=3Dy
> # CONFIG_SECURITY_SELINUX_BOOTPARAM is not set
> # CONFIG_SECURITY_SELINUX_DISABLE is not set
> # CONFIG_SECURITY_SELINUX_DEVELOP is not set
> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
> # CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX is not set
>
> Note that your kernel config does not support:
> 1) The selinux=3D kernel boot parameter
> (CONFIG_SECURITY_SELINUX_BOOTPARAM),
> 2) The ability to disable SELinux from /sbin/init based on
> SELINUX=3Ddisabled in /etc/selinux/config
> (CONFIG_SECURITY_SELINUX_DISABLE),
> 3) Permissive mode (CONFIG_SECURITY_SELINUX_DEVELOP)
>
> Is that what you intended?  IOW, you cannot boot permissive, and the
> load policy logic is failing when it tries to switch to permissive mode
> (write to /selinux/enforce).



--nextPart2099818.ZMGN6gSeVg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEABECAAYFAkoUJVAACgkQ1sXw8/2VziSvAgCg27gqMkaZ/6k6rOE8pfWWoDdx
ZdoAn01W/eO9YnM1ChLlDXzxQo8nf810
=7A37
-----END PGP SIGNATURE-----

--nextPart2099818.ZMGN6gSeVg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
