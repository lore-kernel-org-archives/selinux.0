Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7AJQdPE021888
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 15:26:39 -0400
Date: Fri, 10 Aug 2012 21:26:21 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: SELinux performance depending on type count
Message-ID: <20120810192621.GM2296@telvanni>
References: <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
 <20120810154454.GH2296@telvanni>
 <1344614902.10631.70.camel@moss-pluto.epoch.ncsc.mil>
 <1344615485.10631.72.camel@moss-pluto.epoch.ncsc.mil>
 <20120810170008.GI2296@telvanni>
 <1344622106.10631.75.camel@moss-pluto.epoch.ncsc.mil>
 <20120810184653.GK2296@telvanni>
 <1344624930.10631.78.camel@moss-pluto.epoch.ncsc.mil>
 <20120810191111.GL2296@telvanni>
 <1344626388.10631.82.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EguBBKnZWdUQS9Kz"
In-Reply-To: <1344626388.10631.82.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--EguBBKnZWdUQS9Kz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2012 at 03:19:48PM -0400, Stephen Smalley wrote:
> On Fri, 2012-08-10 at 21:11 +0200, Ole Kliemann wrote:
> > On Fri, Aug 10, 2012 at 02:55:30PM -0400, Stephen Smalley wrote:
> > > > If you want hard numbers, use the attached script. First start=20
> > > > off in system_r:unconfined_r:unconfined_t. Run the script=20
> > > > somewhere, /tmp e.g. For proper average value computation you=20
> > > > need 'bc' installed, otherwise it's rounded but doesn't matter.
> > >=20
> > > Triggers a ton of error messages in dmesg from SELinux about unmapped
> > > security contexts?
> > >=20
> > > > Then switch to choke_u:choke_r:choke_t. Run the script here. If=20
> > > > it's inconclusive, start uncommenting additional attributes in=20
> > > > choke/src/support/choke.spt.
> >=20
> > Sorry, my mistake, got confused. Here's the right stuff now.=20
> > The script is in choke/test/
>=20
> Well, that certainly yielded very different numbers but also lots of AVC
> denials, all of which look like this:
> time->Fri Aug 10 15:12:33 2012
> type=3DSYSCALL msg=3Daudit(1344625953.002:10135): arch=3Dc000003e syscall=
=3D188
> success=3Dyes exit=3D0 a0=3D125a0e0 a1=3D311e81646b a2=3D125b5b0 a3=3D1d =
items=3D0
> ppid=3D10903 pid=3D18574 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fs=
uid=3D0 egid=3D0
> sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D1 comm=3D"chcon" exe=3D"/usr/bin/chco=
n"
> subj=3Dchoke_u:choke_r:choke_t key=3D(null)
> type=3DAVC msg=3Daudit(1344625953.002:10135): avc:  denied  { associate }
> for  pid=3D18574 comm=3D"chcon" name=3D"9448e490-297f-4856-8022-da19d91db=
9a4"
> dev=3D"dm-2" ino=3D1706648 scontext=3Dchoke_u:object_r:choke9x55_t
> tcontext=3Dsystem_u:object_r:unconfined_t tclass=3Dfilesystem

Forgot to mention, I added that associate rule in the policy. You=20
have to use the one I sent last and rebuild.

But you'll see the AVC denials are not causing the slowdown.

--EguBBKnZWdUQS9Kz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAlYF0ACgkQS1FjE303ERzOFQCgkUajHZ1H9Ukj4xYaonJg67fR
l50AoI23pw2ligz1E8TGcVLwTVpSrQ1k
=+9cR
-----END PGP SIGNATURE-----

--EguBBKnZWdUQS9Kz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
