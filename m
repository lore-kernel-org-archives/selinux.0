Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81Kx1rT024759
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 16:59:01 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81KwBY2000914
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 20:58:12 GMT
Subject: SE Linux and /proc files
From: Albert Cahalan <albert@users.sourceforge.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1094072237.434.7207.camel@cube>
Mime-Version: 1.0
Date: 01 Sep 2004 16:57:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At an extreme security level, users can't see processes
running in other roles. At a low security level, they can.

How about a middle ground? I've been thinking of adding
a new /proc file containing some basic data for procps.
It wouldn't have EIP, ESP, WCHAN, and a few others that
are quite revealing to an attacker. A list of items that
would be enough for basic procps functionality is:

class   - scheduling class
cmd     - COMMAND, w/o args
cstime  - CPU time
cutime  - CPU time
euid
nice
nlwp  - num threads
pcpu  - %CPU (once implemented)
pgrp
ppid
priority
processor
resident
rtprio
ruid
sched  - RT scheduling class
session
share  - memory info
size
start_time
state
stime  - CPU time
tgid
tid
tpgid
tty
utime  - CPU time
vm_lock - locked mem (just need yes/no)
vm_rss
vm_size

Might this be useful?

Anything on that list more troublesome than cmd?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
