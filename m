Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02912
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 14:55:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA27963
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 19:53:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id TAA27959 for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 19:53:40 GMT
Message-Id: <200211292002.PAA23890@moss-shockers.ncsc.mil>
Date: Fri, 29 Nov 2002 15:02:59 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: expect
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Due to what I believe to be bugs in expect, the new open_init_pty program will 
> not work correctly with old versions of expect.  Version 5.38.0 works fine, 
> version 5.32.2 is broken.  I don't know when the bug was fixed exactly.

I've backed out the open_init_pty changes to our internal copy of
run_init.   I'd rather not have the base run_init functionality dependent
on a particular version of expect, and I'm not even sure that it is
wise to depend on having expect installed at all.  

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
