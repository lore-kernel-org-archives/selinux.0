Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4G3C4I4021781
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 23:12:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4G3Bhl5013154
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 03:11:43 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h4G3BhNc013151
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 03:11:43 GMT
Subject: Re: slow application of contexts in devfs?
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200305160945.45658.russell@coker.com.au>
References: <3EC2792D.1020209@yahoo.it>
	 <1053016311.20932.17.camel@chris.pebenito.net>
	 <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
	 <200305160945.45658.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1053054721.21382.32.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 15 May 2003 22:12:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am using metalog, however I've already fixed up the file contexts, so
its running in the correct domain.  The fact (which didnt occur to me
earlier) is that devfsd starts up before the syslogger in Gentoo.  So
I'll check with our init scripts guy to see why its like this, and if
its possible to reorder this (devfsd's start is in /sbin/rc, not a
regular init script).  Otherwise, I'll just put it on dontaudit.  The
devfsd startup message isn't very interesting anyway.

Chris

On Thu, 2003-05-15 at 18:45, Russell Coker wrote:
> /dev/log doesn't exist in devfs before syslogd has run.
> 
> My guess is that syslogd is running in the wrong domain and therefore the type 
> transition does not apply.  "ps ax --context | grep syslogd" should give a 
> good clue.  Of course for this to happen the machine must have booted in 
> permissive mode.
> 
> Christopher, would you happen to be running something other than the regular 
> syslogd?  Maybe a different syslogd with a file name that doesn't match the 
> pattern?
-- 
Chris PeBenito
<pebenito@ieee.org>
AIM: PeBenito78
ICQ#: 10434387

"Engineering does not require science. Science helps
a lot, but people built perfectly good brick walls 
long before they knew why cement works."-Alan Cox

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
