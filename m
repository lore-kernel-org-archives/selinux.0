Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FNleI4021324
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 19:47:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4FNlJl5005947
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 23:47:20 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4FNl6Nc005931
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 23:47:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
   "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: Re: slow application of contexts in devfs?
Date: Fri, 16 May 2003 09:45:45 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <3EC2792D.1020209@yahoo.it> <1053016311.20932.17.camel@chris.pebenito.net> <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305160945.45658.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 May 2003 05:02, Stephen Smalley wrote:
> > is set up using genfs_contexts.  Then shortly later after devfs is
> > mounted, devfsd gets a denial writing to /dev/log, because its still
> > labeled as device_t
>
> /dev/log is a name for a Unix domain socket created by syslogd.  Until
> syslogd is running and has bound a socket to /dev/log, writing to
> /dev/log isn't going to work regardless of your policy.  When syslogd
> binds its socket to /dev/log, then it will pick up the correct type
> based on the file type transition rule, as with other file creations.
> Why does /dev/log even exist in devfs before syslogd has bound to it?

/dev/log doesn't exist in devfs before syslogd has run.

My guess is that syslogd is running in the wrong domain and therefore the type 
transition does not apply.  "ps ax --context | grep syslogd" should give a 
good clue.  Of course for this to happen the machine must have booted in 
permissive mode.

Christopher, would you happen to be running something other than the regular 
syslogd?  Maybe a different syslogd with a file name that doesn't match the 
pattern?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
