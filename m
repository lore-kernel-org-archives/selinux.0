Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA06362
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2001 16:10:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA07024
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2001 21:09:35 GMT
Received: from pandora.shad0w.org (shad0w.dial.nildram.co.uk [195.112.18.51])
	by jazzswing.ncsc.mil  with ESMTP id VAA07020
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2001 21:09:23 GMT
Received: from monolith.sanctum.shad0w.org ([10.2.0.4] ident=shadow)
	by pandora.shad0w.org with esmtp (Exim 3.22 #1)
	id 14b7gZ-0000Pb-00
	for selinux@tycho.nsa.gov; Thu, 08 Mar 2001 21:10:59 +0000
Date: Thu, 8 Mar 2001 16:14:11 -0500 (EST)
From: Chris Crowther <shadow@shad0w.org>
To: selinux@tycho.nsa.gov
Subject: Re: make errors with policy
In-Reply-To: <20010308170327.48932.qmail@web9307.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0103081611070.16333-100000@monolith.sanctum.shad0w.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Thu, 8 Mar 2001, Dan DeVries wrote:

> What is an error 127 when doing a make install in
> policy

	It means whatever the last program make ran exited with return
code 127, what that means depends on what the command it called was.

-- 
Chris "_Shad0w_" Crowther
shad0w@shad0w.org
http://www.shad0w.org.uk/


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
