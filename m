Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4GBewI4022787
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 07:40:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4GBebl5028160
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 11:40:38 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4GBebNc028157
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 11:40:37 GMT
Subject: Re: slow application of contexts in devfs?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1053054721.21382.32.camel@chris.pebenito.net>
References: <3EC2792D.1020209@yahoo.it>
	 <1053016311.20932.17.camel@chris.pebenito.net>
	 <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
	 <200305160945.45658.russell@coker.com.au>
	 <1053054721.21382.32.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 May 2003 07:40:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-05-15 at 23:12, Christopher J. PeBenito wrote:
> I am using metalog, however I've already fixed up the file contexts, so
> its running in the correct domain.  The fact (which didnt occur to me
> earlier) is that devfsd starts up before the syslogger in Gentoo.  So
> I'll check with our init scripts guy to see why its like this, and if
> its possible to reorder this (devfsd's start is in /sbin/rc, not a
> regular init script).  Otherwise, I'll just put it on dontaudit.  The
> devfsd startup message isn't very interesting anyway.

/dev/log shouldn't exist in devfs prior to syslogd (or metalog)
starting.  But perhaps your devfsd is automatically restoring /dev
entries from a backup when it initializes, thereby creating an orphaned
/dev/log that is subsequently removed and re-created by syslogd.

You may need to grant syslogd permission to unlink device_t:sock_file so
that it can remove the orphaned /dev/log left by devfsd.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
