Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA24561
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 10:16:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB9FG8I06427
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 15:16:08 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id gB9FG8f06423 for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 15:16:08 GMT
Message-Id: <200212091523.KAA29425@moss-shockers.ncsc.mil>
Date: Mon, 9 Dec 2002 10:23:24 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: new policy
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Added a can_exec rule for the ftpd cron jobs.

This is questionable, as you might not want to grant these same permissions
to the corresponding daemon.  Using the same domain for the daemon process
and for these cron jobs might not be desirable.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
