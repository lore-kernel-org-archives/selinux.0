Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: James Antill <james.antill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Jim Meyering <meyering@redhat.com>
In-Reply-To: <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eyePgbr948BfmVmQs6m6"
Date: Fri, 12 Jan 2007 15:10:26 -0500
Message-Id: <1168632626.13080.212.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-eyePgbr948BfmVmQs6m6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

kOn Fri, 2007-01-12 at 13:55 -0500, Stephen Smalley wrote:
> On Fri, 2007-01-12 at 13:46 -0500, Daniel J Walsh wrote:
> > Currently in policy we do NOT have the following rule
> >=20
> > allow iso9660_t fs_t:filesystem associate;
> >=20
[...]
> > Maybe a fix would be to allow cp to ask the kernel what to do if it can=
=20
> > not setfscreatecon a particular context on a file system.

 Note that copy.c uses fsetfilecon() on the open fd of the new file, but
it saves the context of the old file in setfscreatecon() (and so does
open+getfscreatecon+fsetfilecon). Fixing this to just store in a local
variable would mean we'd see the error at setfilecon() time.

> > Thoughts?
>=20
> First, I seem to recall debates about whether -p (and thus -a) should
> automatically enable preservation of SELinux context or whether that
> should remain a separate option only.  Pros and cons to both sides.

 I never saw the original discussion, but I'm 99% sure I complained to
Jim and/or Dan that cp -a/-p should do "the right thing" and preserve
everything, when I was adding the xattr support.
 Note that the changes in question are not really consistent:


               FC-5           FC-6            rawhide         =20

mode =3D acls[1] yes            yes             no
-p             trad.          trad.           trad.+acls+xattrs
-a             -dpPR          -dpPRc          -dpPR
--preserve=3Dall trad.+context  trad.+context   trad.+context+acls+xattrs

...and in FC-6 -Z also does the open+getfscreatecon+fsetfilecon dance.


> I agree that allowing the association isn't the right thing to do.  Part
> of the problem here is that setfscreatecon() doesn't know where you are
> going to put the file, so it cannot report an error at that time, and
> the open/mkdir failure could happen for a variety of reasons, not just
> this one.

 So if we moved coreutils to just using fsetfilecon() for -p/-a, could
we do something?

> cp could fall back to resetting fscreate to NULL and try again in that
> case (as long as the user didn't explicitly request preservation via
> --preserve=3Dcontext).

 I'm not sure that's the right behaviour, I think the behaviour should
be like if you copy an ACL to an FS that doesn't support them (Ie. it
knows what failed, and why ... and so "does the right thing").


[1] This means that preserving the "unix permission mode bits" implies
preserving any ACLs.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-eyePgbr948BfmVmQs6m6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFp+sx11eXTEMrxtQRAj95AKCHIHHa0fRUiJhpgCa85xRbgn/gPgCeNeZb
+zT75C+kF8BEaeAsI9IF85Y=
=RuJ/
-----END PGP SIGNATURE-----

--=-eyePgbr948BfmVmQs6m6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
