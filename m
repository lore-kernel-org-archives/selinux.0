Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OLtmsJ020956
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 17:55:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8OLtlCG017748
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 21:55:47 GMT
Received: from dymwsm14.mailwatch.com (dymwsm14.mailwatch.com [204.253.83.38])
        by jazzband.ncsc.mil  with ESMTP id h8OLtlqJ017745 for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 21:55:47 GMT
Received: from mwsc0224.mw4.mailwatch.com (mwsc0224.mw4.mailwatch.com [204.253.83.169])
	by dymwsm14.mailwatch.com (8.12.9/8.12.9) with ESMTP id h8OLtkqD030130
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 17:55:46 -0400
Received: from ecpo1.azell.com (ecpo1.azell.com [136.1.7.4])
	by dymwsm10.mailwatch.com (8.12.9/8.12.9) with ESMTP id h8OLtkwL014403
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 17:55:46 -0400
Message-ID: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com>
From: "Inger, Slav (S.B.)" <vinger@ford.com>
To: "'Dale Amon'" <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: RE: ssh policy hassles
Date: Wed, 24 Sep 2003 17:55:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----Original Message-----
From: Dale Amon [mailto:amon@vnl.com]
Sent: Wednesday, September 24, 2003 4:31 PM
To: SELinux Mail List
Subject: ssh policy hassles

> avc:  denied  { search } for  pid=654 exe=/usr/sbin/sshd dev=sda2 ino=903169 
> scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:var_lib_t tclass=dir
> 
> Can anyone think of a reason why an sshd would try to search
> /var/lib upon an incoming ssh connection? /var/lib is
> not in the source code, it's not in the config files...
> The only thing I see that looks even vaguely like a possible 
> target there is /var/lib/urandom.

Don't know if this helps much, but the only reference I see to /var/lib in the trace is sshd doing a stat on directory /var/lib/empty.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
