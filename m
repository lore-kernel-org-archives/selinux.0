Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: James Antill <james.antill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Jim Meyering <meyering@redhat.com>
In-Reply-To: <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	 <1168632626.13080.212.camel@code.and.org>
	 <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kKyuRakC1ACMYUvUk+Ya"
Date: Fri, 12 Jan 2007 16:15:13 -0500
Message-Id: <1168636513.13080.227.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-kKyuRakC1ACMYUvUk+Ya
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-01-12 at 15:24 -0500, Stephen Smalley wrote:
> On Fri, 2007-01-12 at 15:10 -0500, James Antill wrote:

> Hmm...I'm not sure about the precise history of the coreutils selinux
> patch, but I had thought it was using setfscreatecon() as much as
> possible to ensure that the file was labeled correctly at creation time.
> Otherwise, the file can exist in the wrong label temporarily, which can
> produce "false" denials (e.g. another process tries to access the file
> before it is in the expected label and gets a denial) as well as "false"
> grantings (e.g. another process tries to open the file before it is in
> the right label and gets a descriptor - which is mitigated in part by
> the revalidation of access on read/write/... calls and fd
> inheritance/transfer but revocation support is incomplete). Note also
> that the permission checks are different for creating vs. relabeling, so
> the behavior affects policy.
> Also, I'm not sure what you mean by the above, as I would expect that it
> would do one of two things for preserving context:

 Ok, I can see why we'd use setfscreatecon() but atm. cp does:

newcon =3D getfilecon("old")
setfscreatecon(newcon);
[...]
fd =3D open("new");
con =3D getfscreatecon();
fsetfilecon(fd, con);

...the later of which, I think, does nothing useful atm.

> I seem to recall earlier discussions where people found that
> automatically enabling preservation of contexts upon -p and -a produced
> a fair amount of breakage in practice, particularly under -strict
> policy, because processes could very well be allowed to preserve DAC
> information but not alter their own default MAC labeling behaviors.

 That seems likely, although I think apart from a few corner cases (like
isos and nfs) the labels should be preserved in targeted.

> >  So if we moved coreutils to just using fsetfilecon() for -p/-a, could
> > we do something?
>=20
> You don't have to do that; it just makes it clearer as to what failed.
> But it does have other implications as well, as above.

 Right, but if we did this for targeted then I think it's safe to ignore
the EPERM error (maybe with a single warning). This should then do the
right thing all the time for targeted, AIUI.

> > > cp could fall back to resetting fscreate to NULL and try again in tha=
t
> > > case (as long as the user didn't explicitly request preservation via
> > > --preserve=3Dcontext).
> >=20
> >  I'm not sure that's the right behaviour, I think the behaviour should
> > be like if you copy an ACL to an FS that doesn't support them (Ie. it
> > knows what failed, and why ... and so "does the right thing").
>=20
> If the user/caller specifies to cp that it wants the security context
> preserved, then any failure there should be fatal to the copy.  But if
> the user/caller just specified -p or -a, which used to not include
> security contexts, then it seems that an inability to preserve the
> context shouldn't be fatal to the copy.

 This implies that --preserve=3Dcontext is "different" from
--preserve=3Dall, -p or -a. I don't think upstream coreutils will accept
that, and it seems pretty magic to me.

 Maybe if we had --preserve=3Dcontext-open and --preserve=3Dcontext-post[1]
(usable names pending), we could have -a/-p/--preserve=3Dall use
context-post (and that not error out). But specifying context-open would
error out.
 We could even change -p/-a if is_selinux_mls_enabled() is true?

 Of course, I'm not 100% upstream coreutils will accept that either :)

[1] context-open =3D=3D use setfscreatecon and context-post =3D just use
fsetfilecon().

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-kKyuRakC1ACMYUvUk+Ya
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFp/ph11eXTEMrxtQRAr8rAJ9jiSXMyeP0RFOKPvMvloZWXj7FAACgrSjg
scYPw7u7LWU+eQ1zc26K/P0=
=0ejC
-----END PGP SIGNATURE-----

--=-kKyuRakC1ACMYUvUk+Ya--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
