Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1K0YDDT010187
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 19:34:15 -0500
Received: from tracyreed.org (wsip-98-175-106-200.sd.sd.cox.net
 [98.175.106.200])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.copilotco.com (Postfix) with ESMTP id 4DBD964C71
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 16:34:09 -0800 (PST)
Date: Thu, 19 Feb 2015 16:34:25 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150220003425.GF12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6S+CllbbV/7E5K18"
In-Reply-To: <20150219204841.GA1649@linksys-wireless-usb.network2>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--6S+CllbbV/7E5K18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 12:48:41PM PST, Dominick Grift spake thusly:
> cat >> mytest.te <<EOF
> policy_module(mytest, 1.0,0)
> gen_require(` type bla_t; attribute mcsuntrustedproc; ')
> type_attribute bla_t mcsuntrustedproc;
> EOF

Ok, great. So I've got this policy in place for user_t and loaded:

policy_module(mytest, 1.0,0)                                               =
                                   =20
gen_require(` type user_t; attribute mcsuntrustedproc; ')
typeattribute user_t mcsuntrustedproc;

So I ssh to the machine and login as p16001 which is a Linux user who also =
has
an SELinux user and is assigned category p16001:

# semanage login -l

Login Name                SELinux User              MLS/MCS Range          =
 =20

__default__               unconfined_u              SystemLow-SystemHigh   =
 =20
p16001                    p16001_u                  p16001                 =
 =20
p16002                    appuser_u                 s0:c1.c499-s0:c2       =
 =20
p16003                    appuser_u                 s0:c1.c499-s0:c3       =
 =20
p16004                    unconfined_u              s0-s0:c0.c1023,c4      =
 =20
p16005                    unconfined_u              s0-s0:c0.c1023,c4,c5   =
 =20
p16006                    unconfined_u              s0-s0:c0.c1023,c6      =
 =20
p16007                    unconfined_u              s0-s0:c0.c1023,c7      =
 =20
p16008                    unconfined_u              s0-s0:c0.c1023,c8      =
 =20
p16009                    unconfined_u              s0-s0:c0.c1023,c9      =
 =20
root                      unconfined_u              SystemLow-SystemHigh   =
 =20
system_u                  system_u                  SystemLow-SystemHigh =
=20

but when I try to test that it is being MCS restricted nothing gets denied:

-bash-4.1$ cd /nodes/p16001/
-bash-4.1$ ls=20
testfile
-bash-4.1$=20
-bash-4.1$ id -Z
p16001_u:user_r:user_t:p16001
-bash-4.1$ ls -laZ
drwxr-xr-x. p16001 p16001 user_u:object_r:default_t:p16001 .
drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow ..
-rw-r--r--. p16001 p16001 user_u:object_r:default_t:p16001 testfile
-bash-4.1$ cat testfile=20
I am 16001
-bash-4.1$ cd ../p16002/
-bash-4.1$ ls -laZ
drwxr-xr-x. p16002 p16002 user_u:object_r:default_t:p16002 .
drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow ..
-rw-r--r--. p16002 p16002 user_u:object_r:default_t:p16002 testfile
-bash-4.1$ cat testfile=20
I am 16002

to my understanding user p16001 with only category p16001 should not be abl=
e to
read this file of category p16002.

Also, I would really like to clean up the above MCS range for users p16002
through p16009.

# First let's try to remove c4 from p16004:
[mcstest:/nodes/p16001]# chcat -l -- -c4 p16004 p16004

Login Name                SELinux User              MLS/MCS Range          =
 =20

__default__               unconfined_u              SystemLow-SystemHigh   =
 =20
p16001                    p16001_u                  p16001                 =
 =20
p16002                    appuser_u                 s0:c1.c499-s0:c2       =
 =20
p16003                    appuser_u                 s0:c1.c499-s0:c3       =
 =20
p16004                    unconfined_u              s0-s0:c0.c1023,c4      =
 =20
p16005                    unconfined_u              s0-s0:c0.c1023,c4,c5   =
 =20
p16006                    unconfined_u              s0-s0:c0.c1023,c6      =
 =20
p16007                    unconfined_u              s0-s0:c0.c1023,c7      =
 =20
p16008                    unconfined_u              s0-s0:c0.c1023,c8      =
 =20
p16009                    unconfined_u              s0-s0:c0.c1023,c9      =
 =20
root                      unconfined_u              SystemLow-SystemHigh   =
 =20
system_u                  system_u                  SystemLow-SystemHigh   =
 =20
# That's odd, no change. Let's delete appuser_u since I probably don't need
# that and want each app to run under its own p1600x user:
[mcstest:/nodes/p16001]# semanage user -d appuser_u
[mcstest:/nodes/p16001]# semanage login -l

Login Name                SELinux User              MLS/MCS Range          =
 =20

__default__               unconfined_u              SystemLow-SystemHigh   =
 =20
p16001                    p16001_u                  p16001                 =
 =20
p16002                    appuser_u                 s0:c1.c499-s0:c2       =
 =20
p16003                    appuser_u                 s0:c1.c499-s0:c3       =
 =20
p16004                    unconfined_u              s0-s0:c0.c1023,c4      =
 =20
p16005                    unconfined_u              s0-s0:c0.c1023,c4,c5   =
 =20
p16006                    unconfined_u              s0-s0:c0.c1023,c6      =
 =20
p16007                    unconfined_u              s0-s0:c0.c1023,c7      =
 =20
p16008                    unconfined_u              s0-s0:c0.c1023,c8      =
 =20
p16009                    unconfined_u              s0-s0:c0.c1023,c9      =
 =20
root                      unconfined_u              SystemLow-SystemHigh   =
 =20
system_u                  system_u                  SystemLow-SystemHigh   =
 =20
# Weird. That didn't seem to do anything either. Let's try the removing the=
 category again:
[mcstest:/nodes/p16001]# chcat -l -- -c4 p16004 p16004
libsemanage.validate_handler: selinux user appuser_u does not exist (No suc=
h file or directory).
libsemanage.validate_handler: seuser mapping [p16002 -> (appuser_u, s0:c1.c=
499-s0:c2)] is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such fi=
le or directory).
/usr/sbin/semanage: Could not commit semanage transaction
# Oops. Now we've got problems. Let's add it back...
[mcstest:/nodes/p16001]# semanage user -a -R user_r appuser_u
libsemanage.validate_handler: selinux user appuser_u does not exist (No suc=
h file or directory).
libsemanage.validate_handler: seuser mapping [p16002 -> (appuser_u, s0:c1.c=
499-s0:c2)] is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such fi=
le or directory).
/usr/sbin/semanage: Could not commit semanage transaction

It's saying it doesn't exist when it's the user I'm trying to add? I'm conf=
used.

--=20
Tracy Reed

--6S+CllbbV/7E5K18
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU5oERBhSTPg0d/nQRAkDVAKDf03hh4gq5VzpQEXXAS8WFJgiMKQCeIe4e
ADWKXhLhVz0I/SBXeuQtTxk=
=5jdC
-----END PGP SIGNATURE-----

--6S+CllbbV/7E5K18--
