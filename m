Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RJCiRb000128
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 15:12:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3RJAmZC014304
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 19:12:42 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
        by jazzband.ncsc.mil  with ESMTP id i3RHqKJP006548 for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 17:52:20 GMT
Message-Id: <200404271752.i3RHqC8E015562@turing-police.cc.vt.edu>
To: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
Subject: Policy file for 'aide' and/or 'tripwire'?
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2076588404P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 27 Apr 2004 13:52:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-2076588404P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <15547.1083088324.1@turing-police.cc.vt.edu>

Has anybody already done a policy file for Tripwire or its
open-sourced replacement 'aide'?

Trying to run 'tripwire --check' from a cron job gets this:

Apr 27 04:03:37 orange kernel: audit(1083053017.355:0): avc:  denied  { write }                     
for  pid=14045 exe=/usr/sbin/tripwire name=tripwire dev=dm-5 ino=22529
scontext=system_u:system_r:system_crond_t tcontext=system_u:object_r:var_t tclass=dir

when trying to open the TEMPDIRECTORY directory:

#  ls -ld --context /var/tripwire/
drwx------+ root     root     system_u:object_r:var_t          /var/tripwire/

(The actual database files are here:

# ls --context /var/lib/tripwire
-rw-------+ root     root     system_u:object_r:var_lib_t      orange.cirt.vt.edu.twd
-rw-------  root     root     system_u:object_r:var_lib_t      orange.cirt.vt.edu.twd.bak
drwxr-xr-x+ root     root     system_u:object_r:var_lib_t      report

It occurs to me that it would be simple but incorrect to just use setfilecon
to coerce the contexts into something that works, and that a separate
set of tripwire_t and/or aide_t contexts is probably desired.  Having no wish
to reinvent the wheel, has anybody done this already?


--==_Exmh_-2076588404P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAjp3McC3lWbTT17ARAkXvAKD8AD1w9mOnUfvfYDeUFfgWDi0ttQCdHb+e
3B3CMTMDDwKQoXUTTkoqj8E=
=zqtz
-----END PGP SIGNATURE-----

--==_Exmh_-2076588404P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
