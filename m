Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAHIrSf004806
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 12:18:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAAHIS1Y018066
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 17:18:28 GMT
Date: Mon, 10 Nov 2003 11:18:28 -0600 (CST)
From: Richard Troth <rtroth@bmc.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Do we break POSIX?
In-Reply-To: <1068472925.32532.3.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.53.0311101117550.10825@rmt-desk.bmc.com>
References: <20031110143701.S16119@lemuria.org>
 <1068472925.32532.3.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> NFS can yield the same behavior.  If you are holding a file open on the
> client and writing to it, and someone changes the ownership of the file
> on the server, then subsequent write() requests will fail with
> Permission denied.  I just tested with a Linux client and server to
> verify, and this is what happens.

Find a Sun.
Test with Solaris.
(Just to be more sure.)

-- R;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
