Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4I51dI4029305
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 01:01:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4I51IQj007110
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 05:01:18 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h4I51HxS007107
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 05:01:17 GMT
Subject: Re: slow application of contexts in devfs?
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200305180511.19269.russell@coker.com.au>
References: <3EC2792D.1020209@yahoo.it>
	 <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil>
	 <1053191138.4322.33.camel@chris.pebenito.net>
	 <200305180511.19269.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1053234096.4322.125.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 18 May 2003 00:01:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well the IGNOREs in the devfsd.conf for /dev/log took care of the
denials.

Most Gentoo users tend to use syslogs that don't have a separate klogd
(syslog-ng, metalog, msyslog), so I've been merging klogd and syslogd. 
In the case of sysklogd, we felt that it was reasonable to run klogd and
syslogd in the same domain.  Of course theres nothing stopping the users
from getting the separate syslogd and klogd policies if they really want
it.

On Sat, 2003-05-17 at 14:11, Russell Coker wrote: 
> On Sun, 18 May 2003 03:05, Christopher J. PeBenito wrote:
> > problem is that metalog is klogd+syslogd, so it doesnt fit in syslogd_t
> > nicely (I didn't try running it in klogd_t, that might work better).  I
> > just added policy to syslogd.te.
> 
> I have been considering merging the two domains for smaller systems.  Maybe it 
> would be worth doing for the general case?  The difference between them is 
> that klogd can read system_map_t (*), and the kernel message log, while 
> syslogd is permitted network access, can write files to disk under /var/log, 
> and can create /dev/log.
> 
> By merging the two we allow syslogd to read system map files under /boot which 
> isn't that important and we allow syslogd to read the kernel message log 
> directly (as it gets all the same data indirectly anyway that does not seem a 
> problem).  klogd gets to write files under /var/log and to create a socket 
> under /dev.  Is this enough of a problem to need a separate domain?
> 
> 
> (*) The current policy allows reading file and lnk_file objects of boot_t as 
> well.  A quick test suggests that klogd does not need such boot_t file access 
> and I have changed my policy accordingly.

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
