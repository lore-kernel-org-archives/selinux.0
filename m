Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA03551
	for <selinux@tycho.nsa.gov>; Tue, 10 Dec 2002 07:42:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBACgCI05168
	for <selinux@tycho.nsa.gov>; Tue, 10 Dec 2002 12:42:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id gBACgCf05164 for <selinux@tycho.nsa.gov>; Tue, 10 Dec 2002 12:42:12 GMT
Message-Id: <200212101249.HAA29947@moss-shockers.ncsc.mil>
Date: Tue, 10 Dec 2002 07:49:30 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: ia64
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks, but perhaps it would be cleaner to move these header files into
the arch/* subdirectories, and simply provide separate versions of the
files for ia64 vs. i386?

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
