Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i979NPrT012606
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 05:23:25 -0400 (EDT)
Received: from passage.avira.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i979NJov019745
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 09:23:24 GMT
Message-ID: <41650B5B.5000903@gentoo.org>
Date: Thu, 07 Oct 2004 12:24:43 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: postfix policy question
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5218F5C872F9BB2956DD0DB4"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5218F5C872F9BB2956DD0DB4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi!

from postconf(1):
The  postconf command prints the actual value of parameter (all known parameters by
default) one parameter per line, changes its value,  or  prints  other  information
about the Postfix mail system.

so sysadm_t should be able to exec this binary, regardless of the 'direct_sysadm_daemon' status

postconf is currently labeled postfix_master_exec_t, so would it be ok to add the following to the policy?:

  ifdef(`direct_sysadm_daemon', `
  domain_auto_trans(sysadm_t, postfix_master_exec_t, postfix_master_t)
  allow sysadm_t postfix_master_t:process { noatsecure siginh rlimitinh };
  role_transition sysadm_r postfix_master_exec_t system_r;
  domain_auto_trans(sysadm_mail_t, postfix_master_exec_t, system_mail_t)
  allow system_mail_t sysadm_t:process sigchld;
  allow system_mail_t privfd:fd use;
  ' ,`
+allow sysadm_t postfix_master_exec_t:file { execute execute_no_trans getattr read };
  ')dnl end direct_sysadm_daemon

I'm not at all sure about this one, please don't shoot the messenger.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig5218F5C872F9BB2956DD0DB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBZQtfGSBEIeh4AEYRAj5hAJ9uaSX77WvPwI/9sQT0VCFLai9vYgCZAfrE
lYBZYg+3alOkeEEiBPp4qHs=
=MIGm
-----END PGP SIGNATURE-----

--------------enig5218F5C872F9BB2956DD0DB4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
