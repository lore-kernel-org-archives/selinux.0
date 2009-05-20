From: Dennis Wronka <linuxweb@gmx.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Policy loading problem
Date: Wed, 20 May 2009 23:22:55 +0800
Cc: SELinux@tycho.nsa.gov
References: <1242641994.470.5.camel@notebook2.grift.internal> <200905202257.08555.linuxweb@gmx.net> <1242831553.20082.406.camel@localhost.localdomain>
In-Reply-To: <1242831553.20082.406.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4573215.nX46VAYlEs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200905202323.00527.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart4573215.nX46VAYlEs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Well, I guess I must have misunderstood the development-option.
The way I thought it to work was that it provides the kernel-parameter=20
enforcing=3D... but that I can still set SELinux to run in permissive mode=
=20
through /etc/selinux/config
So that's not the case, right?

Just recompiled the kernel with CONFIG_SECURITY_SELINUX_DEVELOP set and now=
 it=20
seems to work.

Thanks a lot!

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



--nextPart4573215.nX46VAYlEs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEABECAAYFAkoUIFQACgkQ1sXw8/2VziTrhgCcDpbGIpmpemqA2GDjy/IE0HBp
V+AAniacoECJLniiWfQOQf2VSzfwlLyQ
=7fjQ
-----END PGP SIGNATURE-----

--nextPart4573215.nX46VAYlEs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
