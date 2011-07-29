Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6TC6bE0030026
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2011 08:06:37 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6TC6Z6c015618
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2011 12:06:36 GMT
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6TC6ZIv002687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2011 08:06:35 -0400
Message-ID: <4E32A24A.4000503@redhat.com>
Date: Fri, 29 Jul 2011 08:06:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
CC: Karel Srot <ksrot@redhat.com>
Subject: Fwd: How to extract file context patterns from selinux module
References: <1311941001.7994.4.camel@dhcp-30-102.brq.redhat.com>
In-Reply-To: <1311941001.7994.4.camel@dhcp-30-102.brq.redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



- -------- Original Message --------
Subject: How to extract file context patterns from selinux module
Date: Fri, 29 Jul 2011 14:03:21 +0200
From: Karel Srot <ksrot@redhat.com>
To: selinux@lists.fedoraproject.org

Hi,
could you please help me with following problem?
I would like to extract context patterns from a selinux module.
I know there are placed at the end of the module but I don't know (and
didn't find) the module structure. Therefore I don't know how to parse
them (if there are any in the module).

Thank you in advance
Karel Srot

$ tail abrt.pp
var/cache/abrt-di(/.*)?		system_u:object_r:abrt_var_cache_t:s0
/var/log/abrt-logger		--	system_u:object_r:abrt_var_log_t:s0
/var/run/abrt\.pid			--	system_u:object_r:abrt_var_run_t:s0
/var/run/abrtd?\.lock		--	system_u:object_r:abrt_var_run_t:s0
/var/run/abrtd?\.socket		-s  system_u:object_r:abrt_var_run_t:s0
/var/run/abrt(/.*)?		system_u:object_r:abrt_var_run_t:s0
...


Karel

- -- 
Karel Srot
QE BaseOS team
http://intranet.corp.redhat.com/ic/intranet/KarelSrot

Email: ksrot@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkyňova 99/71, 612 45, Brno, Czech Republic

- --
selinux mailing list
selinux@lists.fedoraproject.org
https://admin.fedoraproject.org/mailman/listinfo/selinux
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4yokoACgkQrlYvE4MpobNp1wCgpyyfWSCd5z6hMaOutlLT9dT0
chIAn2Qmq3I6XeKfYuMPrx+8SoJbV0Dr
=CBv7
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
