Date: Tue, 22 Sep 2015 11:24:25 +1000
From: Matthew Cengia <mattcen@cyber.com.au>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, russell@coker.com.au
Subject: Re: overlayfs+selinux error: OPNOTSUPP
Message-ID: <20150922012425.GO22582@cyber.com.au>
References: <20150921022517.GH22582@cyber.com.au>
 <56006BBA.4070602@tycho.nsa.gov> <56006CC7.2070605@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TOcFo/l1T3s1H/TJ"
In-Reply-To: <56006CC7.2070605@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TOcFo/l1T3s1H/TJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-09-21 16:47, Stephen Smalley wrote:
[...]
> >> This problem *ONLY* occurs in the initrd,
> >> which is *BEFORE* the SELinux policy loads.
> >> I'm not sure if this is relevant.
> >=20
> > Yes, I believe it is.  Most likely culprit is:
> > security/selinux/hooks.c:
> >    2890 static int selinux_inode_setxattr(struct dentry *dentry, const
> > char *name,
> >    2891                                   const void *value, size_t
> > size, int flags)
> >    2892 {
> >    2893         struct inode *inode =3D dentry->d_inode;
> >    2894         struct inode_security_struct *isec =3D inode->i_securit=
y;
> >    2895         struct superblock_security_struct *sbsec;
> >    2896         struct common_audit_data ad;
> >    2897         u32 newsid, sid =3D current_sid();
> >    2898         int rc =3D 0;
> >    2899
> >    2900         if (strcmp(name, XATTR_NAME_SELINUX))
> >    2901                 return selinux_inode_setotherxattr(dentry, name=
);
> >    2902
> >    2903         sbsec =3D inode->i_sb->s_security;
> >    2904         if (!(sbsec->flags & SBLABEL_MNT))
> >    2905                 return -EOPNOTSUPP;
> >                                ^^^^^^^^^^^^
> > That's to prevent setting SELinux attributes on a filesystem that does
> > not support labeling due to use of a context=3D mount or policy genfscon
> > rules to override any xattrs on the filesystem.  Maybe that should be
> > exempted if no policy is loaded (!ss_initialized).
> >=20
> > At this point, I have to ask:  which is easier, patching systemd to do
> > what you want, loading policy earlier (in general, the earlier you load
> > SELinux policy, the better), or patching the kernel.
>=20
> BTW, IIUC, the reason that this manifests on an open(2) call is that
> overlayfs is trying to copy-up any xattrs from the lower filesystem to
> the upper filesystem when you touch the file, which triggers a
> vfs_getxattr on the lower filesystem and then a vfs_setxattr on the
> upper filesystem, and then we fail here.  Not something we would see on
> open(2) otherwise.

Thanks for your response Stephen!

Let me confirm I understand correctly. The problem doesn't occur when I
write a file to the root of the overlay mountpoint. Are you saying this
is because I'm not attempting to copy/set ant SELinux attributes on this
file, but when I write something to /etc or /home, copy-up attempts and
fails to write the SELinux attribute xattr?

As for possible solutions: I'm not sure I want to contemplate patching
systemd, so I'll leave that as a last resort.

I'm happy to investigate loading the policy earlier; I'll need to talk
to some Debian SELinux people to understand better how the policy gets
loaded so I can duplicate that functionality into the initrd; I'm still
getting my head around SELinux.

Your final suggestion was a kernel change (!ss_initialized). Are you
suggesting this is something you'd consider changing in mainline, or
something I might want to patch for my specific instance? I want to
avoid the latter, but if you think the former may be sensible, that'd be
cool. Would that mean, however, that SELinux attributes may not be set
correctly and that the files create wouldn't be accessible by everything
that needs them after the policy has loaded?

--=20
Regards,
Matthew Cengia

--TOcFo/l1T3s1H/TJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQJ8BAEBCgBmBQJWAK3JXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDMTlFRDFDRTdERThBODYxMjhGOEQwNEI5
RDBCNTY1NTlCRjZBNTYyAAoJEJ0LVlWb9qVi/1QP/3cDzy/+H1gZDPd3HB3N8gu+
9ieCMsjYuqTPuWmrtOpvgwOO22ltmeBTAb5+jXsdiwA0ynPffApzzKZeGsLhVWcH
4tp+13SWwbXw1Lyd+awFyji5TZKV9Zssvh2dsnuISexDD7bc27kAUJBUAGpb40hs
x6lx0Xz4DwB0uehUZ5a9fJ274faRwUlf2lozWqGkHRPmIW/xUftrlZMN9AWcLiYw
jEOMwD5uG9zirYijD/6SlOt2kmMXLU9ikqNxaxHSbjNN5fQsXiHgdyUmKY+1KQyo
H1pVFh1OyBpr49/3mHE7/pa5SKzX/wqbPAAKLJVjkOT/BJoJvdyQ1JSu/7gkLSbP
u4OgFO0EmRL/umAHjMybX3MAgw3Amw2zyG+TTnxBBZKZt94j+ItDqul9jIKxPFwh
Sj1uGpOOp98bxrtNmO0j2lSKxsiFP4yxwfhTdUGHkexHYZQF+kYT/gwxCC1XA4Qe
5L/doc4xiFV8hT8WpnRhIJJSe4n4tFcYKcNa0AOvOV6Uvxz5wxaoFZ5WWUv5wcPJ
xdH+g5vsMDWwyPnkqrE/7sYACdaq7igMCo//+tRBDtwk2vWV8lNB89uMOVnxDz6w
hc0c5qWHkrFJCoPf3JPcBSggsWZ3QP/3I0X87C0JuqvZAqtZHEEurue5uoMwOlNP
EfNGYbWVVo4giRjEExpx
=Gcgx
-----END PGP SIGNATURE-----

--TOcFo/l1T3s1H/TJ--
