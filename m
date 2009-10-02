Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n92H2bAB026316
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 13:02:37 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n92H4BCX022363
	for <selinux@tycho.nsa.gov>; Fri, 2 Oct 2009 17:04:11 GMT
Received: by ewy7 with SMTP id 7so1109299ewy.41
        for <selinux@tycho.nsa.gov>; Fri, 02 Oct 2009 10:02:34 -0700 (PDT)
Date: Fri, 2 Oct 2009 19:02:31 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: How to trace why MCS permissions granted?
Message-ID: <20091002170230.GB3474@notebook3.grift.internal>
References: <20091002154012.GT4221@ruber.office.udmvt.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
In-Reply-To: <20091002154012.GT4221@ruber.office.udmvt.ru>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--9zSXsLTf0vkW971A
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

Whoops i was wrong. That was process_read_up not file so i guess it is beca=
use

userdom_security_admin_template(sysadm_t, sysadm_r)

like ssmalley say's

i guess the policy is built with mls enabled.
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrGMiYACgkQMlxVo39jgT+q2QCgi7vGHhW7LkhOCO273mr2YwSO
j9IAoK3FQCAeGUR3Uk2sQKftuPQpmbWi
=tXec
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
