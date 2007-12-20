Subject: Re: Propper labeling of files under /var/www
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1198073575.19081.1.camel@moss-spartans.epoch.ncsc.mil>
References: <1198003507.3705.15.camel@localhost6.localdomain6>
	 <1198004134.11568.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1198059185.3342.3.camel@localhost6.localdomain6>
	 <1198073575.19081.1.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aNmJghFN9OBt55UE9noy"
Date: Thu, 20 Dec 2007 08:43:51 +0000
Message-Id: <1198140231.3248.7.camel@localhost6.localdomain6>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aNmJghFN9OBt55UE9noy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-12-19 at 09:12 -0500, Stephen Smalley wrote:
> On Wed, 2007-12-19 at 10:13 +0000, Stefan Schulze Frielinghaus wrote:
> > On Tue, 2007-12-18 at 13:55 -0500, Stephen Smalley wrote:
> > [...]
> > > Try restorecon -FRv /var/www
> >=20
> > Yeah that solved the problem. The -F option is a little bit tricky ;-)
> > Never expected something like that.
>=20
> /etc/selinux/targeted/contexts/customizable_types was created to allow
> programs like restorecon to omit files with certain types from being
> relabeled by default, so that admin customizations wouldn't be lost.
> The httpd-related types are a common case of this, where the admin wants
> to manually manage the type under the web root and not have them
> clobbered.  As to whether it still makes sense when we have semanage
> fcontext, I'm not sure.

I think at least from an user point of view it is misleading. I just
wanted to create a policy for some CGI/PHP webserver stuff which I could
role out to my clients. And if a client runs into some trouble, gets
some AVC messages etc., he just uses "fixfiles relabel" or even
"touch /.autorelabel && reboot". I think that's the normal behavior of a
non SELinux hacker.

So in the end removing it (or just ship an empty customizable_types file
like you pointed out) would be a good thing.

--=-aNmJghFN9OBt55UE9noy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHais1qYnt3l7ncSARAm/iAJ9SPwvOqLd1+6Wph/J5RmZofQ3wzwCgppgw
eQL9OrDPnVnee1rG71kOxa8=
=CcpX
-----END PGP SIGNATURE-----

--=-aNmJghFN9OBt55UE9noy--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
