Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n92GLXKH018514
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 12:21:33 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n92GKiJE006280
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 16:20:44 GMT
Received: by ewy7 with SMTP id 7so1087830ewy.41
        for <selinux@tycho.nsa.gov>; Fri, 02 Oct 2009 09:21:31 -0700 (PDT)
Date: Fri, 2 Oct 2009 18:21:28 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: How to trace why MCS permissions granted?
Message-ID: <20091002162126.GA3474@notebook3.grift.internal>
References: <20091002154012.GT4221@ruber.office.udmvt.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
In-Reply-To: <20091002154012.GT4221@ruber.office.udmvt.ru>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2009 at 08:40:12PM +0500, selinux@udmvt.ru wrote:
> Hello, everyone.
> I'm just playing with MCS and trying to understand the system's behavior.
>=20
> As far as I have read the theory, categories can be used to limit unwante=
d user's
> access to your data. So, I am trying to create a file, mark it with a cat=
egory,
> first time - the same as the process has. Then I write there some data an=
d read it back.
> That works OK and is as expected.
> But when I change file's category to some other, that my testing process =
don't have,
> to prevent the process from accessing that file, I discover that the proc=
ess may read,
> but cannot write (append) to that file:
>=20
> 	root@selinux1:/tmp# id
> 	uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Droot:sysadm_r:sys=
adm_t:s0:c0
> 	root@selinux1:/tmp# ls -laZ test
> 	-rw-r--r-- 1 root root system_u:object_r:sysadm_tmp_t:s0:c1   9 Oct  3 0=
0:44 test
> 	root@selinux1:/tmp# cat test
> 	asfasdaf
> 	root@selinux1:/tmp# cat >> test
> 	bash: test: Permission denied
> 	root@selinux1:/tmp# setenforce 0
> 	root@selinux1:/tmp# cat >> test
> 	blabla
> 	root@selinux1:/tmp# cat test
> 	asfasdaf
> 	blabla
>=20
> When the process is at s0:c0, the file is at s0:c1, and in enforcing mode=
 I expect
> to have no access at all.
>=20
> I can only guess, that sysadm_t is in some way marked as a special type f=
or
> bypassing MCS constraints, but how can I proof/check that?
> And if that is true, I still expect to have all access or no access at al=
l,
> but not the read only access.
> Please, if there is nothing wrong with what I am seeing, tell where can I=
 read
> about that more?
>=20
> Thanks.

The tresys reference policy maillist is better suited for this.

http://oss.tresys.com/mailman/listinfo/refpolicy

My guess is that "mls_process_read_up(sysadm_t)" in sysadm.te is responsibl=
e for the behaviour but i am not sure.

http://oss.tresys.com/projects/refpolicy/browser/policy/modules/roles/sysad=
m.te

line 31

looking in the mls module:

http://oss.tresys.com/projects/refpolicy/browser/policy/modules/kernel/mls.=
if

line 72

http://oss.tresys.com/projects/refpolicy/browser/policy/mcs

line 83

mlsconstrain file { read }
 	        (( h1 dom h2 ) or ( t2 =3D=3D domain ) or ( t1 =3D=3D mlsfileread=
 ));
 =09

>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrGKIYACgkQMlxVo39jgT/yqwCfa1PccTtx85Ak6LHLj5U6B5/6
2r8AoMXqp424FfTcozZ6q5ttN5x5CP2z
=BIdY
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
