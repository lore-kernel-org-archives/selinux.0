Subject: Re: policy questions and bugs
From: Colin Walters <walters@verbum.org>
To: Chris Grier <grier@uiuc.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20040515033020.GA5060@balder>
References: <20040515033020.GA5060@balder>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CduxR1q8OCPoRCnOpecR"
Message-Id: <1084640772.10945.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Sat, 15 May 2004 13:06:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-CduxR1q8OCPoRCnOpecR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-14 at 23:30, Chris Grier wrote:
> I have a whole bunch of questions after reading the FAQ and some other
> random documents I found for selinux, here they are:
>=20
> The dpkg and rpm both have apt-get in their domain te files. fixfiles
> doesn't like having multiple contexts defined for a single file. This
> might be a bug.

Sounds like it, yes.

> Why do dmesg redirections (such as root running dmesg > ~/output) cause
> an audit deny? I'm not sure this is a dmesg specific error, I think it
> might be a little more general for other redirections too. Here's the
> message:
>=20
> avc:  denied  { write } for  pid=3D1953 exe=3D/bin/dmesg path=3D/root/tes=
t
> dev=3Dmd0 ino=3D740514 scontext=3Droot:system_r:dmesg_t
> tcontext=3Droot:object_r:staff_home_t tclass=3Dfile

Under normal operation, the dmesg program doesn't need write access to
your home directory.  Thus using the principle of least privilege, any
write operations will be denied by the SELinux policy.

Allowing arbitrary redirections of program output through the shell, but
denying otherwise is, I believe, not possible using SELinux currently.

> When running some services, I would like them to run as a non root uid
> and gid (ircd and oidentd are the services which I usually do this
> with), which I normally do with su. When we do this with selinux
> running, we are prompted to enter a role and type (not select from a
> list). Is this just a matter of defining a transition to acommodate for
> this to happen?

You run "su" interactively from a root shell?  I'd suggest instead using
init scripts. =20

> Why do normal users have the option of changing to sysadm?

That's a Red Hat addition to the policy.

>  I don't
> particularly like this, and I could remove it, but I'm looking for the
> reasoning behind the default being like this.

Basically to make the SELinux experience more like a "normal" Linux
system.

> What does this mean:=20
>=20
> inode_doinit_with_dentry:  context_to_sid(system_u:object_r:apt_etc_t)
> returned 22 for dev=3Dmd0 ino=3D517610

That means that the context system_u:object_r:apt_etc_t is not defined
in the policy.  Probably the apt_etc_t type got deleted somehow from
your policy.

> Last question for today, when creating my own fc and te files to build
> into the policy, is it safe to create them in the policy/src directory,
> or will future package updates simply overwrite them and kill all the
> stuff I'm writing? How about modifications of existing files in the
> policy source directory?

Under Red Hat, they will be moved to .rpmsave, AIUI.


--=-CduxR1q8OCPoRCnOpecR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBApk4EOIkJWWp2WGURAo01AJ9hANvRfe/QvyrjMYaJe0n8IMlEtgCfXBRJ
0xZokGKHbTPmZhlg5RKLMaY=
=Smqy
-----END PGP SIGNATURE-----

--=-CduxR1q8OCPoRCnOpecR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
