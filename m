Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13124
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 09:16:21 -0500 (EST)
From: azeredo@qmc.ufsc.br
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA03677
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:14:25 GMT
Received: from quark.qmc.ufsc.br (bohr-gw.qmc.ufsc.br [150.162.31.223])
        by jazzband.ncsc.mil  with ESMTP id OAA03673 for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 14:14:24 GMT
Received: from localhost (azeredo@localhost)
	by quark.qmc.ufsc.br (8.11.3/8.11.3/SuSE Linux 8.11.1-0.5) with ESMTP id gA1Ebdt03036
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2002 12:37:39 -0200
Date: Fri, 1 Nov 2002 12:37:39 -0200 (BRST)
To: <selinux@tycho.nsa.gov>
Subject: Problems with policy in RH8
Message-ID: <Pine.LNX.4.33.0211011219430.2804-100000@quark.qmc.ufsc.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



  I saw at the  mail list someone was trying to get selinux to run in RH8.
I am trying too. And got many audit messages. The first one was:

avc: denied  {execute} for pid=9 exe=/bin/bash
path=/lib/libnss_files-2.2.93.so dev=16:01 ino=159491
scontext=system_u:system_r:initrc_t
tcontext=system_u:obeject_r:var_spool_t tclass=file

after that many other related to atd, sendmail and others daemons.
I read the work Configuring the SELinux Policy and I am getting used to
that structure, but still have many doubts. There, it is explained how to
solve problems like that but I dont feel secure enough to try myself to
solve mine.  Any help is very welcome.

                           Aldrovando  Azeredo (Bazil - UFSC)
                            azeredo@qmc.ufsc.br




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
