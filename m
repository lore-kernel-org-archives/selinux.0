Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA07055
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 16:47:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA24960
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 21:46:27 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
        by jazzband.ncsc.mil  with ESMTP id VAA24956 for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 21:46:25 GMT
Subject: ext3 file system
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 17 Jan 2002 16:45:02 -0500
Message-Id: <1011303902.5928.2.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When trying to label files with the setfiles utilities, the process
crashes when they encounter the .journal files. These are user-visible,
but are not regular files (they are immutable in the sense that even
root cannot change them in any way). The setfiles utilities issue a
warning that they cannot write to .journal and quit.

Any ideas?

Perhaps there should be some way of exempting the .journal files from
the labelling process. It is unfortunate that they are visible to users
(since users cannot actually use them for anything).

--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
