Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18Lrdef013396
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:53:39 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18LrcIH012363
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 21:53:38 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id m18LrM4S007854
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 15:53:22 -0600
Subject: newrole transition problems w/ local user domain
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MUqH+rK+403i0Gj7OmTt"
Date: Fri, 08 Feb 2008 15:53:20 -0600
Message-Id: <1202507600.3577.51.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-MUqH+rK+403i0Gj7OmTt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

for some reason, I can't seem to get newrole to do it's thing.=20

example:
[bob@XXXX ~]$ newrole -r monetra_admin_r -t monetra_admin_t
Authenticating bob.
Password:=20
failed to exec shell
: Permission denied

audit log has:
type=3DUSER_AUTH msg=3Daudit(1202507011.151:2157): user pid=3D21599 uid=3D5=
04 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 msg=3D'PAM: a=
uthentication acct=3D"bob" : exe=3D"/usr/bin/newrole" (hostname=3D?, addr=
=3D?, terminal=3Dpts/3 res=3Dsuccess)'
type=3DUSER_ACCT msg=3Daudit(1202507011.151:2158): user pid=3D21599 uid=3D5=
04 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 msg=3D'PAM: a=
ccounting acct=3D"bob" : exe=3D"/usr/bin/newrole" (hostname=3D?, addr=3D?, =
terminal=3Dpts/3 res=3Dsuccess)'
type=3DUSER_START msg=3Daudit(1202507011.152:2159): user pid=3D21600 uid=3D=
504 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 msg=3D'PAM: =
session open acct=3D"bob" : exe=3D"/usr/bin/newrole" (hostname=3D?, addr=3D=
?, terminal=3Dpts/3 res=3Dsuccess)'
type=3DUSER_ROLE_CHANGE msg=3Daudit(1202507011.152:2160): user pid=3D21600 =
uid=3D504 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 msg=3D=
'newrole: old-context=3Dmonetra_adm_u:monetra_adm_r:monetra_adm_t:s0 new-co=
ntext=3Dmonetra_adm_u:monetra_admin_r:monetra_admin_t:s0
: exe=3D"/usr/bin/newrole" (hostname=3D?, addr=3D?, terminal=3D/dev/pts/3 r=
es=3Dsuccess)'
type=3DAVC msg=3Daudit(1202507011.152:2161): avc:  denied  { transition } f=
or  pid=3D21600 comm=3D"newrole" path=3D"/bin/bash" dev=3Dsda1 ino=3D327714=
 scontext=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 tcontext=3Dmonetra_adm=
_u:monetra_admin_r:monetra_admin_t:s0 tclass=3Dprocess
type=3DSYSCALL msg=3Daudit(1202507011.152:2161): arch=3D40000003 syscall=3D=
11 success=3Dno exit=3D-13 a0=3D9cbe010 a1=3Dbff58a64 a2=3D9cc4fc0 a3=3D0 i=
tems=3D0 ppid=3D21599 pid=3D21600 auid=3D504 uid=3D504 gid=3D504 euid=3D504=
 suid=3D504 fsuid=3D504 egid=3D504 sgid=3D504 fsgid=3D504 tty=3Dpts3 comm=
=3D"newrole"=20
exe=3D"/usr/bin/newrole" subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 ke=
y=3D(null)

and yet my te file has:
allow newrole_t monetra_admin_t:process transition;

I added a role to no avail:
role monetra_admin_r types newrole_t;


this just produced errors about old TE rules an new te rule conflicts:
domain_type(monetra_admin_t)
#domain_entry_file(monetra_admin_t , newrole_exec_t )
#domain_auto_trans(monetra_adm_t,newrole_exec_t,monetra_admin_t)

could it be I need to use somthing other than:
userdom_unpriv_user_template(monetra_adm)?


thanx

--=-MUqH+rK+403i0Gj7OmTt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHrM9Q6caZY8jbHDkRAo9MAJ94CulLlYROs1f1/jbOUEYeIdtoAgCgkhLR
LrQAdzOSqxY/K1jAP8DsY+Y=
=dUPm
-----END PGP SIGNATURE-----

--=-MUqH+rK+403i0Gj7OmTt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
