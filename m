Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59Ei8rT020011
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 10:44:09 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i59Ei6Qd028122
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 10:44:06 -0400 (EDT)
Received: from smtpscan-eur5.philips.com (smtpscan-eur5.mail.philips.com [130.144.57.168])
	by gw-eur4.philips.com (Postfix) with ESMTP id 98A06499AE
	for <selinux@tycho.nsa.gov>; Wed,  9 Jun 2004 14:44:06 +0000 (UTC)
Received: from smtpscan-eur5.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id 3C412AA
	for <selinux@tycho.nsa.gov>; Wed,  9 Jun 2004 14:44:06 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur5.philips.com (Postfix) with ESMTP id 83AB851
	for <selinux@tycho.nsa.gov>; Wed,  9 Jun 2004 14:44:05 +0000 (GMT)
Received: from prle4.natlab.research.philips.com (prle4.natlab.research.philips.com [130.145.137.96])
	by smtprelay-eur1.philips.com (8.9.3p3/8.9.3-1.2.2m-20040401) with ESMTP id OAA02153
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 14:44:05 GMT
Received: from smtpmon (smtpmon [130.145.137.150])
	by prle4.natlab.research.philips.com (8.11.6/8.11.6) with ESMTP id i59Ei5W13086
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 16:44:05 +0200
Received: from therning by pc67148596.ddns.htc.nl.philips.com with local (Exim 4.34)
	id 1BY4JA-0002Th-Uf
	for selinux@tycho.nsa.gov; Wed, 09 Jun 2004 16:44:04 +0200
Date: Wed, 9 Jun 2004 16:44:04 +0200
From: Magnus Therning <magnus-work@therning.org>
To: selinux@tycho.nsa.gov
Subject: SELinux on Debian (Sid)
Message-ID: <20040609144404.GJ5477@philips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have run into some problems with getting a Debian box up and running
with SELinux. Maybe someone can offer some insights?

Installing selinux-default-policy failed, make complains about 'chsid'
not being present. These are the problems I run into when trying to
complete the installation of the policies:

 1. The makefile in /etc/selinux uses 'chsid'. This is the line:

      chsid system_u:object_r:policy_config_t /ss_policy

    Apparently that tool has been replaced by 'chcon'.

      chcon -u system_u -r object_r -t policy_config_t /ss_policy

    On a standard kernel this gave the following error message:
     =20
      chcon: invalid security context

 2. The path to 'load_policy' is wrong in /etc/selinux/Makefile it now
    lives in /usr/sbin rather than /usr/bin. Also the variable
    LOADPOLICY isn't used at all, instead every reference to
    'load_policy' is written like this:

      $(BINDIR)/load_policy

    A little silly (-:

 3. 'make relabel' fails on a standard kernel:

      load_policy: security_load_policy failed

    After rebooting using my SE-kernel 'make relabel' also fails:

      security:  policydb magic number 0x8 does not match expected magic nu=
mber 0xf97cff8c
      load_policy: security_load_policy failed

Now I am stuck :-( I simply don't know where to look for a thread to
pull to clean up the mess.

/M

--=20
Magnus Therning  mailto:therning@sourceforge.natlab.research.philips.com
+31-40-2745179  http://pww.innersource.philips.com/magnus/
OpenPGP:0x4FBB2C40

X-Windows: ...The art of incompetence.=20

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxyI0YcKlB0+7LEARAtHoAJ9HXx0/PD8HagjQM8xIA5oELGPVoACeIubj
OvwZ5OmFR7kQ/RcrH+FpXkc=
=ECOs
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
