Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JBdjI4002488
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 07:39:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JBdNQj023935
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 11:39:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4JBdMxS023932
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 11:39:23 GMT
Subject: Re: slow application of contexts in devfs?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1053191138.4322.33.camel@chris.pebenito.net>
References: <3EC2792D.1020209@yahoo.it>
	 <1053016311.20932.17.camel@chris.pebenito.net>
	 <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
	 <200305160945.45658.russell@coker.com.au>
	 <1053054721.21382.32.camel@chris.pebenito.net>
	 <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil>
	 <1053191138.4322.33.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1053344357.4729.918.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 19 May 2003 07:39:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-05-17 at 13:05, Christopher J. PeBenito wrote:
> The binary for metalog is metalog.  If you'd like to look at it:
> http://metalog.sourceforge.net/.  I like it because of it's built-in
> rotation of logs based on age or size, and simple configuration.  The
> problem is that metalog is klogd+syslogd, so it doesnt fit in syslogd_t
> nicely (I didn't try running it in klogd_t, that might work better).  I
> just added policy to syslogd.te.

Given that it performs rotation of the logs, you may want to also look
into integrating the logrotate.te policy and the logrotate patch into
metalog.  The logrotate patch is necessary to ensure that the log
security contexts are preserved when they are rotated.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
