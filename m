Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i37MO2Rb013711
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 18:24:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i37MO1mw024429
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 22:24:01 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i37MO14w024426 for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 22:24:01 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i37MO0WB002337
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 18:24:00 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i37MO0j18477
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 18:24:00 -0400
Received: from nexus.verbum.private (nexus.boston.redhat.com [172.16.67.53])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i37MNxhP026828
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 18:23:59 -0400
Subject: strange labeling problem
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D1HquoP5MCb7yRRHxIZy"
Message-Id: <1081376404.9215.13.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Wed, 07 Apr 2004 18:20:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-D1HquoP5MCb7yRRHxIZy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I encountered this issue earlier today.  It had me totally stumped:

root@optimus-prime:/home/walters$ ls -alZ /usr/libexec/gconfd-2
-rwxr-xr-x+ root     root     system_u:object_r:gconfd_exec_t  /usr/libexec=
/gconfd-2
walters@optimus-prime:~$ ls -alZ /usr/libexec/gconfd-2
ls: /usr/libexec/gconfd-2: Permission denied
audit(1081374706.094:0): avc:  denied  { getattr } for  pid=3D13695 exe=3D/=
bin/ls=20
  path=3D/usr/libexec/gconfd-2 dev=3Dhda2 ino=3D683045 scontext=3Duser_u:us=
er_r:user_t=20
  tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dfile

I double-checked that I had a rule:

allow user_t gconfd_exec_t:file { getattr };=20

in policy.  Even more baffling, when I added a rule:

allow user_t unlabeled_t:file { getattr };

and then did a ls -alZ as a user, it correctly showed up as gconfd_exec_t!

I had tried rerunning chcon -t gconfd_exec_t /usr/libexec/gconfd-2
several times.  I verified that the stored xattr was correct; i.e. a
getfattr -d -m . /usr/libexec/gconfd-2 showed gconfd_exec_t.
After a bit of futzing around I gave up and rebooted.  It worked
correctly on reboot.=20

I haven't looked at the code, but my thought is that somehow the cached
inode got out of sync with the xattr, and was really unlabeled_t.

Has anyone seen this before?


--=-D1HquoP5MCb7yRRHxIZy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAdH6UOIkJWWp2WGURAlVDAJ4+or9OBwZRSKX7RLvPvHtVQscWAgCfReEv
+oCPhn756bkaCvNVwfZ9LPU=
=AgUM
-----END PGP SIGNATURE-----

--=-D1HquoP5MCb7yRRHxIZy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
