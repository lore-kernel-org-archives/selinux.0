Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6KLZ0UE023630
 for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2016 17:35:00 -0400
Received: by mail-lf0-f41.google.com with SMTP id g62so47157733lfe.3
 for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2016 14:34:57 -0700 (PDT)
Received: from [10.0.1.103] (sub228-148.elpos.net. [85.193.228.148])
 by smtp.gmail.com with ESMTPSA id 90sm951656lfs.7.2016.07.20.14.34.54
 for <selinux@tycho.nsa.gov>
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 20 Jul 2016 14:34:54 -0700 (PDT)
From: =?utf-8?Q?Kamil_Boraty=C5=84ski?= <kboratynski@linsec.pl>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_15016264-2A11-4CFF-A634-9677EBCB9888";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Subject: redis - selinux
Date: Wed, 20 Jul 2016 23:34:49 +0200
Message-Id: <C8680873-CCF4-4613-A4F0-DF34CF783389@linsec.pl>
To: selinux@tycho.nsa.gov
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>


--Apple-Mail=_15016264-2A11-4CFF-A634-9677EBCB9888
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

It looks like SELinux policies block the connection betweeen Redis =
servers.
It is needed for replication purposes.


* sealert
> root@redis-2 ~]# sealert -a /var/log/audit/audit.log
>   3% done'list' object has no attribute 'split'
> 103% done
> found 1 alerts in /var/log/audit/audit.log
> =
--------------------------------------------------------------------------=
------
>=20
> SELinux is preventing /usr/bin/redis-server from name_connect access =
on the tcp_socket port 6379.
>=20
> *****  Plugin catchall (100. confidence) suggests   =
**************************
>=20
> If you believe that redis-server should be allowed name_connect access =
on the port 6379 tcp_socket by default.
> Then you should report this as a bug.
> You can generate a local policy module to allow this access.
> Do
> allow this access for now by executing:
> # grep redis-server /var/log/audit/audit.log | audit2allow -M mypol
> # semodule -i mypol.pp
>=20
>=20
> Additional Information:
> Source Context                system_u:system_r:redis_t:s0
> Target Context                system_u:object_r:redis_port_t:s0
> Target Objects                port 6379 [ tcp_socket ]
> Source                        redis-server
> Source Path                   /usr/bin/redis-server
> Port                          6379
> Host                          <Unknown>
> Source RPM Packages           redis-2.8.19-2.el7.x86_64
> Target RPM Packages
> Policy RPM                    selinux-policy-3.13.1-60.el7_2.7.noarch
> Selinux Enabled               True
> Policy Type                   targeted
> Enforcing Mode                Enforcing
> Host Name                     redis-2
> Platform                      Linux redis-2 3.10.0-327.22.2.el7.x86_64 =
#1 SMP
>                               Thu Jun 23 17:05:11 UTC 2016 x86_64 =
x86_64
> Alert Count                   250
> First Seen                    2016-07-20 21:14:59 UTC
> Last Seen                     2016-07-20 21:26:05 UTC
> Local ID                      90314588-4f75-485a-bce4-3b8b1742fe8f
>=20
> Raw Audit Messages
> type=3DAVC msg=3Daudit(1469049965.377:1214): avc:  denied  { =
name_connect } for  pid=3D5668 comm=3D"redis-server" dest=3D6379 =
scontext=3Dsystem_u:system_r:redis_t:s0 =
tcontext=3Dsystem_u:object_r:redis_port_t:s0 tclass=3Dtcp_socket
>=20
>=20
> type=3DSYSCALL msg=3Daudit(1469049965.377:1214): arch=3Dx86_64 =
syscall=3Dconnect success=3Dno exit=3DEACCES a0=3D5 a1=3D7f6e8c010df0 =
a2=3D10 a3=3D7fff1db82944 items=3D0 ppid=3D1 pid=3D5668 auid=3D4294967295 =
uid=3D995 gid=3D993 euid=3D995 suid=3D995 fsuid=3D995 egid=3D993 =
sgid=3D993 fsgid=3D993 tty=3D(none) ses=3D4294967295 comm=3Dredis-server =
exe=3D/usr/bin/redis-server subj=3Dsystem_u:system_r:redis_t:s0 =
key=3D(null)
>=20
> Hash: redis-server,redis_t,redis_port_t,tcp_socket,name_connect
>=20
> [root@redis-2 ~]#



* sestatus
> [root@redis-2 ~]# sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             targeted
> Current mode:                   enforcing
> Mode from config file:          enforcing
> Policy MLS status:              enabled
> Policy deny_unknown status:     allowed
> Max kernel policy version:      28
> [root@redis-2 ~]#
> Policy Type

* kernel-version
> [root@redis-2 ~]# uname -a
> Linux redis-2 3.10.0-327.22.2.el7.x86_64 #1 SMP Thu Jun 23 17:05:11 =
UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
> [root@redis-2 ~]#


* checkpolicy version:
> [root@redis-2 ~]# checkpolicy --version
> 29 (compatibility range 29-15)
> [root@redis-2 ~]#

* libselinux-version:
> [root@redis-2 ~]# yum info installed libselinux
> Loaded plugins: fastestmirror
> Installed Packages
> Name        : libselinux
> Arch        : x86_64
> Version     : 2.2.2
> Release     : 6.el7
> Size        : 159 k
> Repo        : installed
> =46rom repo   : anaconda
> Summary     : SELinux library and simple utilities
> URL         : http://oss.tresys.com/git/selinux.git
> License     : Public Domain
> Description : Security-enhanced Linux is a feature of the Linux? =
kernel and a number
>             : of utilities with enhanced security functionality =
designed to add
>             : mandatory access controls to Linux.  The =
Security-enhanced Linux
>             : kernel contains new architectural components originally =
developed to
>             : improve the security of the Flask operating system. =
These
>             : architectural components provide general support for the =
enforcement
>             : of many kinds of mandatory access control policies, =
including those
>             : based on the concepts of Type Enforcement?, Role-based =
Access
>             : Control, and Multi-level Security.
>             :
>             : libselinux provides an API for SELinux applications to =
get and set
>             : process and file security contexts and to obtain =
security policy
>             : decisions.  Required for any applications that use the =
SELinux API.
>=20
> [root@redis-2 ~]#

* libsemanage:
> [root@redis-2 ~]# yum info installed libsemanage
> Loaded plugins: fastestmirror
> Installed Packages
> Name        : libsemanage
> Arch        : x86_64
> Version     : 2.1.10
> Release     : 18.el7
> Size        : 220 k
> Repo        : installed
> =46rom repo   : anaconda
> Summary     : SELinux binary policy manipulation library
> URL         : http://oss.tresys.com/git/selinux.git
> License     : LGPLv2+
> Description : Security-enhanced Linux is a feature of the Linux? =
kernel and a number
>             : of utilities with enhanced security functionality =
designed to add
>             : mandatory access controls to Linux.  The =
Security-enhanced Linux
>             : kernel contains new architectural components originally =
developed to
>             : improve the security of the Flask operating system. =
These
>             : architectural components provide general support for the =
enforcement
>             : of many kinds of mandatory access control policies, =
including those
>             : based on the concepts of Type Enforcement?, Role-based =
Access
>             : Control, and Multi-level Security.
>             :
>             : libsemanage provides an API for the manipulation of =
SELinux binary
>             : policies. It is used by checkpolicy (the policy =
compiler) and similar
>             : tools, as well as by programs like load_policy that need =
to perform
>             : specific transformations on binary policies such as =
customizing policy
>             : boolean settings.
>=20
> [root@redis-2 ~]#

* policy:
> [root@redis-2 ~]# grep redis-server /var/log/audit/audit.log | =
audit2allow
> #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D redis_t =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> allow redis_t redis_port_t:tcp_socket name_connect;
> [root@redis-2 ~]#

In case of any further questions, feel free to ask me.
I think it would be nice to have a boolean value for this.

=E2=80=94 K.


--Apple-Mail=_15016264-2A11-4CFF-A634-9677EBCB9888
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJXj+59AAoJEDjQqL2Rz0xYdicQAJwNjL99kvcAgpcyN2bQjbbh
4O9kwI7VrERdGiaxi89Im/zulON1OItWax6sP3DyiZJ5B009lzGQu/5VBFFoAEJW
NsLHS76ZGQPVVqRP2fl284rD2baKxpWJLs/MjN6nZvpDBExz6OLkangicSiz5TZ6
DOP6zJxfaC5nuLyLI6feDZU3CZ+zXVbSv8EMPS809AgHgSQPbfo8ZeBFMjMBnMQp
2q+8rXRnQr2jFTi/92hlEpuR7wCGF5FWk8FBlFUIU18ZYQQT/odOxnUsQLczqK4d
pbw+aa0ra5Rqm4/E+QD65sOUC8y7+AD2zIM/4o/ml0IfbPKmzxL5wEBwymAVBBKP
Odm7eL411AcZkPWjmJl/nIKC41xwGidVrzWfG+xhTmE3aCRc9ms3PmCtw5KXPZTE
xGcHMMmYvxe2t6lAH4ndmTyw/pPwYAqQNe48fR6lN/swAEsutbLpiju4swuObUL9
IkvotIB6Hv0sSVf6Xdc+5x1hEYx5bRTRfzf5tudvpabcMvuHwaxGe6bOwANx2IUk
Ruzcu0dKbojFGOtqDhmzBsZSw2WsUD88e5Bu+sCr+YCA1oiQaGcLM2HZANAhCYEI
/zWRb/BPS1vt3cW+t21pFD3pbNw3l222pmHBHi31eydeOVXAayjhRuq5fubvwf3n
zxQx3+ERNKWgQTylXBbd
=Bo/s
-----END PGP SIGNATURE-----

--Apple-Mail=_15016264-2A11-4CFF-A634-9677EBCB9888--
