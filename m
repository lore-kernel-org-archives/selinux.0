Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MIFptl018663
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 13:15:51 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MIFmYC019185
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 18:15:49 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id m1MIFmpw019612
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 12:15:48 -0600
Subject: default user roles
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MZx+2iEhS/mpgevj8u2m"
Date: Fri, 22 Feb 2008 12:15:48 -0600
Message-Id: <1203704148.3669.953.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-MZx+2iEhS/mpgevj8u2m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I can't seem to get the login to set the proper initial role for a user.
Every time I login, I end up as auditadm, and not secstaff.

I have the following in my policy:

userdom_unpriv_user_template(secstaff)
userdom_role_change_template(secstaff, secadm)
userdom_role_change_template(secstaff, auditadm)
allow secstaff_t devlog_t:sock_file write;
allow secstaff_t newrole_t:process { siginh noatsecure rlimitinh };
allow secstaff_t syslogd_t:unix_dgram_socket sendto;
allow secstaff_t unconfined_tmp_t:dir { write search rmdir remove_name crea=
te getattr add_name };
allow secstaff_t user_home_dir_t:dir { read getattr search };
userdom_manage_generic_user_home_content_files(secstaff_t)
userdom_read_generic_user_home_content_files(secstaff_t)

############################################################
# Set default role for sec staff <-- not quite :)
#
role secstaff_r types secstaff_t;

############################################################
# define roles the secstaff can transition to
#
user secstaff_u roles { secstaff_r secadm_r auditadm_r } level s0 range s0 =
- s0;
=09




In the olden days in England, you could be hung for stealing a sheep or
a loaf of bread. However, if a sheep stole a loaf of bread and gave it
to you, you would only be tried for receiving, a crime punishable by
forty lashes with the cat or the dog, whichever was handy. If you stole
a dog and were caught, you were punished with twelve rabbit punches,
although it was hard to find rabbits big enough or strong enough to
punch you. -- Mike Harding, "The Armchair Anarchist's Almanac"

--=-MZx+2iEhS/mpgevj8u2m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHvxFU6caZY8jbHDkRAmECAKClI6pqCnDZSTALk1GMaNEyxAGcqQCgg80T
xvKR6jgbNUKqgJEb7CLs5qk=
=iLrF
-----END PGP SIGNATURE-----

--=-MZx+2iEhS/mpgevj8u2m--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
