Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4HJDII4028476
	for <selinux@tycho.nsa.gov>; Sat, 17 May 2003 15:13:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4HJCuQj002342
	for <selinux@tycho.nsa.gov>; Sat, 17 May 2003 19:12:56 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4HJCsxS002339
	for <selinux@tycho.nsa.gov>; Sat, 17 May 2003 19:12:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: Re: slow application of contexts in devfs?
Date: Sun, 18 May 2003 05:11:19 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <3EC2792D.1020209@yahoo.it> <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil> <1053191138.4322.33.camel@chris.pebenito.net>
In-Reply-To: <1053191138.4322.33.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305180511.19269.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 18 May 2003 03:05, Christopher J. PeBenito wrote:
> to my devfsd conflet.  That took care of metalog's unlink denial for
> /dev/log.  However, devfsd still gets the denial writing to to /dev/log
> because its still system_u:object_r:device_t.  Its somewhat confusing; I
> would have thought that the write to /dev/log would be after devfsd's
> initialization, so /dev/log would have the correct context.

It will log the fact that it is changing the SID of /dev/log...

> Another option would be to try to stop devfsd from saving /dev/log into
> dev-state in the first place.  Then /dev/log shouldn't be restored at
> all.  This is seeming like the cleaner/saner option.

That is the correct option.

> The binary for metalog is metalog.  If you'd like to look at it:
> http://metalog.sourceforge.net/.  I like it because of it's built-in
> rotation of logs based on age or size, and simple configuration.  The
> problem is that metalog is klogd+syslogd, so it doesnt fit in syslogd_t
> nicely (I didn't try running it in klogd_t, that might work better).  I
> just added policy to syslogd.te.

I have been considering merging the two domains for smaller systems.  Maybe it 
would be worth doing for the general case?  The difference between them is 
that klogd can read system_map_t (*), and the kernel message log, while 
syslogd is permitted network access, can write files to disk under /var/log, 
and can create /dev/log.

By merging the two we allow syslogd to read system map files under /boot which 
isn't that important and we allow syslogd to read the kernel message log 
directly (as it gets all the same data indirectly anyway that does not seem a 
problem).  klogd gets to write files under /var/log and to create a socket 
under /dev.  Is this enough of a problem to need a separate domain?


(*) The current policy allows reading file and lnk_file objects of boot_t as 
well.  A quick test suggests that klogd does not need such boot_t file access 
and I have changed my policy accordingly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
