Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA25959
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 02:04:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA25908
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 06:04:11 GMT
Received: from mail.servicemail123.com ([12.96.162.84])
	by jazzswing.ncsc.mil  with ESMTP id GAA25900
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 06:04:11 GMT
Received: from jw (unknown [65.166.138.2])
	by mail.servicemail123.com (Postfix on SuSE Linux 7.1 (i386)) with ESMTP id 446AD499D3
	for <selinux@tycho.nsa.gov>; Tue,  9 Jul 2002 01:04:43 -0500 (CDT)
Content-Type: text/plain;
  charset="us-ascii"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Make relabel problems with rsync and localtime
Date: Tue, 9 Jul 2002 01:04:19 -0500
MIME-Version: 1.0
Message-Id: <200207090104.19564.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Well, byt fixing the plocy files I managed to get rid of most of the previsouly mentioned problems with make relabel, but where are 2 warnings that I have no idea how to fix:

/usr/local/selinux/bin/setfiles:  Running on a SELinux kernel, using new system calls
/usr/local/selinux/bin/setfiles:  read 700 specifications
/usr/local/selinux/bin/setfiles:  labeling files under /
/usr/local/selinux/bin/setfiles:  conflicting specifications for /usr/sbin/rsyncd and /usr/bin/rsync, using system_u:object_r:sbin_t.
/usr/local/selinux/bin/setfiles:  conflicting specifications for /usr/share/zoneinfo/US/Central and /etc/localtime, using system_u:object_r:usr_t.
/usr/local/selinux/bin/setfiles:  hash table stats: 202220 elements, 65536/65536 buckets used, longest chain length 4
/usr/local/selinux/bin/setfiles:  labeling files under /boot
/usr/local/selinux/bin/setfiles:  hash table stats: 30 elements, 30/65536 buckets used, longest chain length 1
/usr/local/selinux/bin/setfiles:  labeling files under /home
/usr/local/selinux/bin/setfiles:  hash table stats: 33 elements, 33/65536 buckets used, longest chain length 1
/usr/local/selinux/bin/setfiles:  Done.
ccs001:/usr/src/selinux/policy #

I cna't find _anything_ about rsyncd with grep, and the things I find about localtime and Central are just in the src, not in any policy files (at least I cna't see if they are).

Does anyone know how to solve these 2 problems?

- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KnzjQ5u80xXOLBcRAskkAKCAABX5G7V+Sf0pXy8mTxZfONA/lACcDXLi
m9r26dUyX0MEJacXt7N7gUk=
=A4wQ
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
