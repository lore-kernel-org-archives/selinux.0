Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA06131
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 14:16:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA18832
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 19:15:46 GMT
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.101])
	by jazzswing.ncsc.mil  with ESMTP id TAA18828
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 19:15:46 GMT
Received: from northrelay02.pok.ibm.com (northrelay02.pok.ibm.com [9.117.200.22])
	by e1.ny.us.ibm.com (8.9.3/8.9.3) with ESMTP id OAA280792
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 14:13:07 -0500
Received: from d01ml244.pok.ibm.com (d01ml244.pok.ibm.com [9.117.127.106])
	by northrelay02.pok.ibm.com (8.11.1m3/NCO v5.01) with ESMTP id g0HJG4n176848
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 14:16:04 -0500
Subject: klogd_t problem
To: selinux@tycho.nsa.gov
Message-ID: <OF90AA15D0.BDA8EACC-ON85256B44.0068C05D@pok.ibm.com>
From: "Trent Jaeger" <jaegert@us.ibm.com>
Date: Thu, 17 Jan 2002 14:16:01 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

My freshly installed SELinux system on RedHat 7.1 makes one complaint that
I am having a little trouble figuring out how to fix.

avc:  denied   { read } for   pid=475 exe=/sbin/klogd path=/System.map
dev=03:01 ino=23 scontext=system_u:system_r:klogd_t
tcontext=system_u:object_r:boot_t tclass:lnk_file

I think the problem is that /System.map can be a lnk_file (it is a file on
my machine, but a link on our other SELinux machine).  All domains can read
files of type boot_t, but only initrc_t can read boot_t lnk_files.  On the
other hand, initrc_t transitions to klogd_t, so perhaps this permission is
supposed to arrive in the transition.

Should the following be changed as follows, should System.map always be a
file, or is there something else wrong.

old: allow domains boot_t:file r_file_perms;
to:   allow domains boot_t:{file lnk_file} r_file_perms;

Thanks,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
30 Saw Mill River Road
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
