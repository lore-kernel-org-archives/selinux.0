Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6CF3vkM023092
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 11:03:57 -0400
Received: from mail.gw90.de (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6CF3twW029048
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2011 15:03:56 GMT
Received: from f053045019.adsl.alicedsl.de ([78.53.45.19] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1QgeVe-0008FE-4p
	for selinux@tycho.nsa.gov; Tue, 12 Jul 2011 15:04:26 +0000
Subject: SELinux and CGI scripts
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fC7cfLtRDNHbrkNJz6Dd"
Date: Tue, 12 Jul 2011 17:03:52 +0200
Message-ID: <1310483032.4294.26.camel@mattotaupa>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fC7cfLtRDNHbrkNJz6Dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear SELinux folks,


the default policy of a Debian Squeeze system seems to prevent the CGI
script [1] of ikiwiki [2] from working properly.

        type=3DAVC msg=3Daudit(1310482485.480:79759): avc:  denied  { rlimi=
tinh } for  pid=3D13522 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:h=
ttpd_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dproce=
ss
        type=3DAVC msg=3Daudit(1310482485.480:79759): avc:  denied  { sigin=
h } for  pid=3D13522 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:http=
d_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dprocess
        type=3DAVC msg=3Daudit(1310482485.480:79759): avc:  denied  { noats=
ecure } for  pid=3D13522 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:=
httpd_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dproc=
ess
        type=3DSYSCALL msg=3Daudit(1310482485.480:79759): arch=3Dc000003e s=
yscall=3D59 success=3Dyes exit=3D0 a0=3D7f20c1b809d8 a1=3D7f20c1b7d648 a2=
=3D7f20c1b7d660 a3=3D0 items=3D0 ppid=3D13518 pid=3D13522 auid=3D4294967295=
 uid=3D33 gid=3D33 euid=3D105 suid=3D105 fsuid=3D105 egid=3D105 sgid=3D105 =
fsgid=3D105 tty=3D(none) ses=3D4294967295 comm=3D"ikiwiki.cgi" exe=3D"/www/=
cgi-bin/ikiwiki.cgi" subj=3Dsystem_u:system_r:httpd_sys_script_t:s0 key=3D(=
null)
        type=3DAVC msg=3Daudit(1310482491.360:79760): avc:  denied  { rlimi=
tinh } for  pid=3D13534 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:h=
ttpd_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dproce=
ss
        type=3DAVC msg=3Daudit(1310482491.360:79760): avc:  denied  { sigin=
h } for  pid=3D13534 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:http=
d_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dprocess
        type=3DAVC msg=3Daudit(1310482491.360:79760): avc:  denied  { noats=
ecure } for  pid=3D13534 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:=
httpd_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dproc=
ess
        type=3DSYSCALL msg=3Daudit(1310482491.360:79760): arch=3Dc000003e s=
yscall=3D59 success=3Dyes exit=3D0 a0=3D7f20c1b80b10 a1=3D7f20c1b877f0 a2=
=3D7f20c1b87808 a3=3D0 items=3D0 ppid=3D13518 pid=3D13534 auid=3D4294967295=
 uid=3D33 gid=3D33 euid=3D105 suid=3D105 fsuid=3D105 egid=3D105 sgid=3D105 =
fsgid=3D105 tty=3D(none) ses=3D4294967295 comm=3D"ikiwiki.cgi" exe=3D"/www/=
cgi-bin/ikiwiki.cgi" subj=3Dsystem_u:system_r:httpd_sys_script_t:s0 key=3D(=
null)
        type=3DAVC msg=3Daudit(1310482491.810:79761): avc:  denied  { getat=
tr } for  pid=3D13534 comm=3D"ikiwiki" path=3D"/etc/resolv.conf" dev=3Dxvda=
 ino=3D496312 scontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tcontext=
=3Dsystem_u:object_r:net_conf_t:s0 tclass=3Dfile
        type=3DSYSCALL msg=3Daudit(1310482491.810:79761): arch=3Dc000003e s=
yscall=3D4 success=3Dno exit=3D-131939282133032 a0=3D3a2eb00 a1=3D21de130 a=
2=3D21de130 a3=3D2839b70 items=3D0 ppid=3D13518 pid=3D13534 auid=3D42949672=
95 uid=3D105 gid=3D105 euid=3D105 suid=3D105 fsuid=3D105 egid=3D105 sgid=3D=
105 fsgid=3D105 tty=3D(none) ses=3D4294967295 comm=3D"ikiwiki" exe=3D"/usr/=
bin/perl" subj=3Dsystem_u:system_r:httpd_sys_script_t:s0 key=3D(null)

I could use the provided tools to allow those accesses.

        $ sudo cat /var/log/audit/audit.log | audit2why
       =20
        [=E2=80=A6]
       =20
        type=3DAVC msg=3Daudit(1310343668.084:76067): avc:  denied  { rlimi=
tinh } for  pid=3D28841 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:h=
ttpd_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dproce=
ss
       =20
                Was caused by:
                        Missing type enforcement (TE) allow rule.
       =20
                        You can use audit2allow to generate a loadable modu=
le to allow this access.
       =20
        type=3DAVC msg=3Daudit(1310343668.084:76067): avc:  denied  { sigin=
h } for  pid=3D28841 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:http=
d_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dprocess
       =20
                Was caused by:
                        Missing type enforcement (TE) allow rule.
       =20
                        You can use audit2allow to generate a loadable modu=
le to allow this access.
       =20
        type=3DAVC msg=3Daudit(1310343668.084:76067): avc:  denied  { noats=
ecure } for  pid=3D28841 comm=3D"ikiwiki.cgi" scontext=3Dsystem_u:system_r:=
httpd_t:s0 tcontext=3Dsystem_u:system_r:httpd_sys_script_t:s0 tclass=3Dproc=
ess
       =20
                Was caused by:
                        Missing type enforcement (TE) allow rule.
       =20
                        You can use audit2allow to generate a loadable modu=
le to allow this access.
       =20
        [=E2=80=A6]

        $ sudo cat /var/log/audit/audit.log | audit2allow -l -m local
       =20
        #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D httpd_sys_script_t =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        allow httpd_sys_script_t devlog_t:sock_file getattr;
        allow httpd_sys_script_t net_conf_t:file getattr;
        allow httpd_sys_script_t user_home_dir_t:dir search;
       =20
        #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D httpd_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
        allow httpd_t httpd_sys_script_t:process { siginh rlimitinh noatsec=
ure };

But I want to make sure first, what the recommended way is.

1. Am I right, that the default behavior is very strict and that
allowing exceptions for certain programs is needed?
2. What is the reason that `getattr` is not by default allowed for
scripts having the `httpd_sys_script_t` attribute(?)?
3. If you have time, do you think the above exceptions sound
sane/secure?
4. Is there a write up how to configure SELinux on Web servers?


Thanks,

Paul


[1] https://secure.wikimedia.org/wikipedia/en/wiki/Common_Gateway_Interface
[2] http://ikiwiki.info/

--=-fC7cfLtRDNHbrkNJz6Dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4cYlIACgkQPX1aK2wOHVjQ/gCgiFrHfy6gZpb8ZhUZ5BQXyabS
vwQAn1hf6XmGPAZN+VnpAsRyYp2V9w+J
=Z1Dc
-----END PGP SIGNATURE-----

--=-fC7cfLtRDNHbrkNJz6Dd--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
