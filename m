Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1FF2viO028932
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2013 10:02:57 -0500
Date: Fri, 15 Feb 2013 16:02:40 +0100
From: Luis Ressel <aranea@aixah.de>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux
 enforcing mode
Message-ID: <20130215160240.47e8d1da@gentp.lnet>
In-Reply-To: <511E45F6.4030300@tycho.nsa.gov>
References: <20130214222502.2f7d657c@gentp.lnet>
	<511E38E7.4040609@tycho.nsa.gov>
	<20130215150649.22c20d5c@gentp.lnet>
	<511E45F6.4030300@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA512;
 boundary="Sig_/gMR/rv2Z3s6D/vli4LCS0A6"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Sig_/gMR/rv2Z3s6D/vli4LCS0A6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Feb 2013 09:28:06 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> So, just to be clear, you are saying that avc_has_perm_noaudit() is=20
> getting a denial (i.e. denied !=3D 0) but you are never getting an avc=20
> denied message even with no dontaudit rules?

I know this sounds strange, but that's exactly what it looks like to me
at the moment. (I'm a SELinux beginner, though)

> You could call slow_avc_audit() directly to display the arguments in
> a meaningful format.

I did the following in hooks.c:

         rc =3D avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0=
, &avd);
+        if (rc =3D=3D -13)
+        {
+            printk(KERN_ERR "avc_has_perm_noaudit(%u, %u, %u, %u, 0, &avd)=
", sid, isec->sid, isec->sclass, perms);
+            slow_avc_audit(sid, isec->sid, isec->sclass, perms, 1, 1, NULL=
, 0);
+        }  =20

But that also didn't yield any audit messages. The printk call works, howev=
er.=20
To be honest, I don't know exactly what to fill in for the last 4 arguments.

The call chain leading there is
cgroup_addrm_files
cgroup_add_file
lookup_one_len
inode_permission
__inode_permission
security_inode_permission
selinux_inode_permission

Inside selinux_inode_permission, avc_has_perm_noaudit returns -ENOACCES
and avc_audit_required returns 0.

--Sig_/gMR/rv2Z3s6D/vli4LCS0A6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJRHk4dAAoJEOBVC/zizycOR2wP/j+eTBaAA/nOE86c8VzfCi6N
Vbttiz9V2wTPA3clQPY1qjS5LCxZ9MvlG+d0aFF3mID4Pd6C/6lXFmeymNiYWZAI
vCzXkpUB3d/KnAT1axJdLiUkhP4lGhy7of+mdH/RwZ4S3rAp4obFPfSJZLZ8Xfwd
K8TVmnEFW4+BYgrXk9V57wjzp70ylffUC2pMrJrOttNXzKJPcFZqBrY2b5zGnBdA
MWwz84TPNrmS24VyfpCzjNbnSbsVrfbMfm5fdXboa7O4MU5hysxBlM6LVHqfaDTw
TdNoDjm2cFUhc9aGmSrZ5W/EEw2nPi+SwVwy5Cp0kiWVzEE0RRaIivxrzu3lKkPn
WU87cwEZITjkvCSAchNjMyY8CxDSTwPM/MFKZYJ8TTRmzX+QQ2kcvzUHahoclmyi
jj9rpRweYPSSoY434KIwYFoPNKV/1xS6GNj8yVoPXKKQs+n+/xpyW0CGbCjKhkGU
VxsXjo+q/usV0f1ghHtr2+aCmZlbL49aLutFmCZWkzPUj+J9/AmrNXBrF4esiZS1
q+11zXB1P59rFXmqz/PR1TTwkK43fupdRIragsixXrYfJD7RTuklO6LqN2ukw2Rh
gnc52Gr05xJRGe8s1tELt495OrDo2XhutTNehm7cWOx4+VoMXUzLjfGEuyzT29CN
DCiwvL1IAhvpkOllKzKn
=JeF3
-----END PGP SIGNATURE-----

--Sig_/gMR/rv2Z3s6D/vli4LCS0A6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
