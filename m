Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AC9GrT026695
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 08:09:16 -0400 (EDT)
Received: from gw-eur4.philips.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AC9DaH004021
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 08:09:13 -0400 (EDT)
Received: from smtpscan-eur4.philips.com (smtpscan-eur4.mail.philips.com [130.144.57.167])
	by gw-eur4.philips.com (Postfix) with ESMTP id DE09C497FE
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:09:09 +0000 (UTC)
Received: from smtpscan-eur4.philips.com (localhost [127.0.0.1])
	by localhost.philips.com (Postfix) with ESMTP id B710581
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:09:09 +0000 (GMT)
Received: from smtprelay-eur1.philips.com (smtprelay-eur1.philips.com [130.144.57.170])
	by smtpscan-eur4.philips.com (Postfix) with ESMTP id 96E39A6
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:09:09 +0000 (GMT)
Received: from prle4.natlab.research.philips.com (prle4.natlab.research.philips.com [130.145.137.96])
	by smtprelay-eur1.philips.com (8.9.3p3/8.9.3-1.2.2m-20040401) with ESMTP id MAA00804
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 12:09:09 GMT
Received: from smtpmon (smtpmon [130.145.137.150])
	by prle4.natlab.research.philips.com (8.11.6/8.11.6) with ESMTP id i5AC99W17904
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 14:09:09 +0200
Received: from therning by pc67148596.ddns.htc.nl.philips.com with local (Exim 4.34)
	id 1BYOMm-0003C7-Ud
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 14:09:08 +0200
Date: Thu, 10 Jun 2004 14:09:08 +0200
From: Magnus Therning <magnus-work@therning.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040610120908.GN5477@philips.com>
References: <20040609144404.GJ5477@philips.com> <20040609175001.GC5727@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
In-Reply-To: <20040609175001.GC5727@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2004 at 05:50:01PM +0000, Luke Kenneth Casson Leighton wrot=
e:
>ha ha, another debian victiiim .
>
>0) make sure you're really a debian/unstable (apt-get dist-upgrade?)

Done!

>1) install, at your own risk of course, the 2.6.6-selinux1 kernel
>from http://hands.com/~lkcl/selinux.

I compiled one myself. Didn't manage to google my way to any pre-built
(also checked apt-get.org, why isn't it mentioned there?).

I seem to have succeeded in compiling the kernel properly, but I'll give
this one a shot anyway.

>2) DO NOT add selinux.lemuria.org/newselinux to your /etc/apt/sources.list
>
>3) DO add selinux.lemuria.org/walters to your /etc/apt/sources.list

I followed the instructions in the HOWTO I found on the SF project. It
mentions Russel Coker's repository.

>4) DO install the (probably downgraded) cron, logrotate, coreutils etc.
>   from /walters
>  =20
>5) use the 1.12 .debs for libselinux1 and selinux-policy-default
>   and selinux-utils policycoreutils etc. they are the latest and they
>   ARE in [ftp/http].*.debian.org
>
>6) once you have installed the 1.12 selinux-policy-default and stuff,
>   YOU MUST go to http://sf.net/projects/selinux and download a
>   replacement genhomedircon from the
>   selinux-usr/policycoreutils//scripts/ directory.
>
>   the version presently released is brain-dead and does something
>   different and unexpected.
>
>i recommend you clean out everything you can find prior to doing all
>this.
>
>i ALSO recommend that you DO NOT install SE/Linux on an ext2 filesystem.

Ah, this I did do... Not too much of a problem to fix though.

>make sure you use ext3 for all partitions (well, i get away with /boot
>as an ext2) how do i put this this is REALLY IMPORTANT there is a bug
>somewhere in the extended attributes stuff and i got a repeatable and
>quite seriously corrupted filesystem.
>
>if you really really can't get it to work let me know and i can upload
>a set of pre-installed tar.gz'd partitions which only come to 124
>mbytes total, there are only about 160 packages preinstalled.

Thanks!

I'll be in touch with updates :-)

>On Wed, Jun 09, 2004 at 04:44:04PM +0200, Magnus Therning wrote:
>> I have run into some problems with getting a Debian box up and running
>> with SELinux. Maybe someone can offer some insights?
>>=20
>> Installing selinux-default-policy failed, make complains about 'chsid'
>> not being present. These are the problems I run into when trying to
>> complete the installation of the policies:
>>=20
>>  1. The makefile in /etc/selinux uses 'chsid'. This is the line:
>>=20
>>       chsid system_u:object_r:policy_config_t /ss_policy
>>=20
>>     Apparently that tool has been replaced by 'chcon'.
>>=20
>>       chcon -u system_u -r object_r -t policy_config_t /ss_policy
>>=20
>>     On a standard kernel this gave the following error message:
>>      =20
>>       chcon: invalid security context
>>=20
>>  2. The path to 'load_policy' is wrong in /etc/selinux/Makefile it now
>>     lives in /usr/sbin rather than /usr/bin. Also the variable
>>     LOADPOLICY isn't used at all, instead every reference to
>>     'load_policy' is written like this:
>>=20
>>       $(BINDIR)/load_policy
>>=20
>>     A little silly (-:
>>=20
>>  3. 'make relabel' fails on a standard kernel:
>>=20
>>       load_policy: security_load_policy failed
>>=20
>>     After rebooting using my SE-kernel 'make relabel' also fails:
>>=20
>>       security:  policydb magic number 0x8 does not match expected magic=
 number 0xf97cff8c
>>       load_policy: security_load_policy failed
>>=20
>> Now I am stuck :-( I simply don't know where to look for a thread to
>> pull to clean up the mess.
>>=20
>> /M
>>=20
>> --=20
>> Magnus Therning  mailto:therning@sourceforge.natlab.research.philips.com
>> +31-40-2745179  http://pww.innersource.philips.com/magnus/
>> OpenPGP:0x4FBB2C40
>>=20
>> X-Windows: ...The art of incompetence.=20
>
>
>
>--=20
>--=20
>expecting email to be received and understood is a bit like
>picking up the telephone and immediately dialing without
>checking for a dial-tone; speaking immediately without listening
>for either an answer or ring-tone; hanging up immediately and
>believing that you have actually started a conversation.
>--
><a href=3D"http://lkcl.net">      lkcl.net      </a> <br />
><a href=3D"mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
>

--=20
-----------------------------------------------------------------------
Magnus Therning                 Philips Research Laboratories Eindhoven
Phone: +31 40 2745179           (OpenPGP: 0x4FBB2C40)

People who don't make mistakes make the greatest mistake of all;
they do nothing.
     -- Unknown

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyE9kYcKlB0+7LEARAklbAJ9vEz++rQdKY83vimP16mOjhsmgvwCeKhZD
p3NUQmH5qw9t3WpEZJZS8B4=
=zVph
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
