Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4BNZ9I4000732
	for <selinux@tycho.nsa.gov>; Sun, 11 May 2003 19:35:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4BNZ87R029494
	for <selinux@tycho.nsa.gov>; Sun, 11 May 2003 23:35:08 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h4BNZ6KP029491 for <selinux@tycho.nsa.gov>; Sun, 11 May 2003 23:35:07 GMT
Date: Mon, 12 May 2003 09:34:50 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: kernel crashes
Message-ID: <20030511233450.GD11671@snoopy.apana.org.au>
References: <20030503002143.GB28891@snoopy.apana.org.au> <200305031526.03543.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305031526.03543.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, May 03, 2003 at 03:26:03PM +1000, Russell Coker wrote:
> On Sat, 3 May 2003 10:21, Brian May wrote:
> > Next time I reboot my computer, I will boot it in single user
> > mode, and see if it still crashes with fewer daemons being
> > loaded.
> 
> Good idea.  Then try adding different types of load (disk IO, fork/exec, etc).

My crashes only seem to occur when connecting to the computer via a ssh
connection.

If I do stuff entirely on the console, with X/Gnome and without X, it
hasn't crashed yet.

Its been a while since I logged on last with ssh, so I will have to do
so again, and see if it causes it to crash again.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
