Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JEZoI4003894
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 10:35:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4JEZntV023977
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 14:35:49 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h4JEZkal023969 for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 14:35:47 GMT
Subject: Re: slow application of contexts in devfs?
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1053344357.4729.918.camel@moss-huskers.epoch.ncsc.mil>
References: <3EC2792D.1020209@yahoo.it>
	 <1053016311.20932.17.camel@chris.pebenito.net>
	 <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
	 <200305160945.45658.russell@coker.com.au>
	 <1053054721.21382.32.camel@chris.pebenito.net>
	 <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil>
	 <1053191138.4322.33.camel@chris.pebenito.net>
	 <1053344357.4729.918.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1053354944.19202.56.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 19 May 2003 09:35:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I should be more specific, metalog only rotates the logs
created/modified by itself, not logs from daemons that don't log thru
syslog.  So, stuff like the apache access/error log or mysqld logs are
still rotated with logrotate.

On Mon, 2003-05-19 at 06:39, Stephen Smalley wrote:
> On Sat, 2003-05-17 at 13:05, Christopher J. PeBenito wrote:
> > http://metalog.sourceforge.net/.  I like it because of it's built-in
> > rotation of logs based on age or size, and simple configuration.  The
> Given that it performs rotation of the logs, you may want to also look
> into integrating the logrotate.te policy and the logrotate patch into
> metalog.  The logrotate patch is necessary to ensure that the log
> security contexts are preserved when they are rotated.
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
