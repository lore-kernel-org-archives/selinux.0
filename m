Subject: Re: network and module problems
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0201241340360.28970-100000@raven>
References: <Pine.GSO.4.33.0201241340360.28970-100000@raven>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-m0W6aZlc5yLjqQPgtGCB"
Date: 25 Jan 2002 09:36:21 -0500
Message-Id: <1011969383.1945.1.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-m0W6aZlc5yLjqQPgtGCB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-01-24 at 13:58, Stephen Smalley wrote:
>=20
> On 24 Jan 2002, Timothy Wood wrote:
>=20
> > Cannot send dump request: Connection refused
>=20
> Did you enable Netlink support when you configured the kernel?
> What release of SELinux are you using?

Yes. 2001121010 (according to the tarball)

>=20
> > module and by building it straight into the kernel.  Which brings me to
> > the module problem.  Dmesg shows that it finds the nic but I never see
> > the module as being loaded when I run lsmod and when I try to insmod it
> > I get an error saying that it can't locate the card on the console and
> > avc errors in the system log.
>=20
> If you build the module into the kernel, it won't show up in lsmod.
> What AVC errors are being logged?  Did you run insmod after logging
> into the sysadm_r role?  Also, is your kernel in permissive mode or
> enforcing mode?

I realise that.  I merely brought it up in regards to the time when the
network was built as a module. =20

kernel: avc: denied { read } for pid=3D268 exe=3D/sbin/insmod
path=3D/etc/modules.conf.vm dev=3D08:01 ino=3D213709
scontext=3Dsystem-U:system_r:kmod_t
tcontext=3Dsystem_u:object_r:etc_runtime_t tclass=3Dlnk_file

that is one of the errors.  if you want an entire boot log I can provide
that.  Yes I did try insmoding after I logged in as an administrator and
thats when the I get the error telling me that it can't locate the card
despite the fact that dmesg shows it was found during boot.  I really
don't think this is a problem the network driver as the loopback (lo)
interface is never raised either.  The dump request thing looks like the
root of the problem since it occurs if I try to raise either the eth0 or
lo interfaces.  The system boots into permissive mode and I usually
leave it there.

>=20
> > I'm also running this on ext3 if that might have something to do with i=
t
> > since I know ext3 isn't properly supported yet.  Anyhow, any ideas are
> > welcome and I can reload this machine if the need arises.  Thanks.
>=20
> ext3 works fine.  It was only an issue when ext3 support wasn't in the
> mainstream kernel.

Ah, I see.  Thanks for the clarification.

Timothy,

--=-m0W6aZlc5yLjqQPgtGCB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8UW1lf/PqxrKarmgRAmVpAJsG6tcbUpbIvvk3J957HiC+ncvNKACfeiS7
eULY9/gFSCgGWvze9kQGzF4=
=wPSg
-----END PGP SIGNATURE-----

--=-m0W6aZlc5yLjqQPgtGCB--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
