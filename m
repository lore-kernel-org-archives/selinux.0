Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JDCoI4003344
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 09:12:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JDCSQj028386
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 13:12:28 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4JDCPxS028383
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 13:12:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: slow application of contexts in devfs?
Date: Mon, 19 May 2003 23:10:59 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <3EC2792D.1020209@yahoo.it> <1053191138.4322.33.camel@chris.pebenito.net> <1053344357.4729.918.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1053344357.4729.918.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305192310.59960.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 May 2003 21:39, Stephen Smalley wrote:
> On Sat, 2003-05-17 at 13:05, Christopher J. PeBenito wrote:
> > The binary for metalog is metalog.  If you'd like to look at it:
> > http://metalog.sourceforge.net/.  I like it because of it's built-in
> > rotation of logs based on age or size, and simple configuration.  The
> > problem is that metalog is klogd+syslogd, so it doesnt fit in syslogd_t
> > nicely (I didn't try running it in klogd_t, that might work better).  I
> > just added policy to syslogd.te.
>
> Given that it performs rotation of the logs, you may want to also look
> into integrating the logrotate.te policy and the logrotate patch into
> metalog.  The logrotate patch is necessary to ensure that the log
> security contexts are preserved when they are rotated.

logrotate runs scripts related to log file rotation on behalf of daemons 
(generally scripts to do whatever is necessary to cause the daemon to use the 
new files).  Having all this done in the main syslogd_t domain is probably 
not desirable.  But then having all the things in logrotate_t that are 
currently in it probably isn't a good idea either.  Maybe if we change 
logrotate to use a different domain for those scripts then we could have it 
run in syslogd_t.

Another issue is that it would be nice to have syslogd only be able to create 
and append to log files, not delete or modify.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
