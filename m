From: Dennis Wronka <linuxweb@gmx.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Policy loading problem
Date: Wed, 20 May 2009 22:42:34 +0800
Cc: SELinux@tycho.nsa.gov
References: <1242641994.470.5.camel@notebook2.grift.internal> <1242828596.20082.395.camel@localhost.localdomain> <1242829261.20082.399.camel@localhost.localdomain>
In-Reply-To: <1242829261.20082.399.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2292799.JvJYK0py3Z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200905202242.37606.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart2292799.JvJYK0py3Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for this, I think we're going somewhere.

Booting into single-user and running load_policy -i I get this:
Mount failed for selinuxfs on /selinux: Device or resource busy
load_policy: Can't load policy: Device or resource busy

I've seen this before when I was testing around, but didn't find much about=
=20
this.

I'll see that I install strace in order to provide a trace.

libselinux is 2.0.79

On Wednesday 20 May 2009 22:21:01 Stephen Smalley wrote:
> On Wed, 2009-05-20 at 10:09 -0400, Stephen Smalley wrote:
> > On Wed, 2009-05-20 at 22:07 +0800, Dennis Wronka wrote:
> > > Sorry I got to ask, but what do you actually mean by "initial policy
> > > loading logic"?
> > >
> > > I haven't actually written any code that handles the policy. I took t=
he
> > > attached patch for SysVInit and applied it. From what I know this is
> > > the commonly used patch for this, as it seems to be pretty identical
> > > wherever I'm looking.
> >
> > That's what I wanted to see, thanks.
> >
> > Now, if you boot permissive in single-user mode (enforcing=3D0 single) =
and
> > run "load_policy -i" (note the -i option), does that work?  That calls
> > the same function for initial policy loading as the patch for sysvinit.
>
> If it doesn't work (i.e. policy is still not loaded by it, as shown by
> e.g. running id -Z), then try running strace load_policy -i 2>& out and
> send the output file.
>
> Also, please identify your version of libselinux.



--nextPart2292799.JvJYK0py3Z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEABECAAYFAkoUFt0ACgkQ1sXw8/2VziSR1QCbBlz7po9FNPfTBj6OdXzD9i12
0BcAn32QzTxULH5js4FG/jXA0whBKozF
=RIY+
-----END PGP SIGNATURE-----

--nextPart2292799.JvJYK0py3Z--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
