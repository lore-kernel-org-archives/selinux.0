Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4HH61I4028200
	for <selinux@tycho.nsa.gov>; Sat, 17 May 2003 13:06:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4HH5PQj028619
	for <selinux@tycho.nsa.gov>; Sat, 17 May 2003 17:05:25 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h4HH5OxS028616
	for <selinux@tycho.nsa.gov>; Sat, 17 May 2003 17:05:24 GMT
Subject: Re: slow application of contexts in devfs?
From: "Christopher J. PeBenito" <pebenito@ieee.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil>
References: <3EC2792D.1020209@yahoo.it>
	 <1053016311.20932.17.camel@chris.pebenito.net>
	 <1053025378.4729.770.camel@moss-huskers.epoch.ncsc.mil>
	 <200305160945.45658.russell@coker.com.au>
	 <1053054721.21382.32.camel@chris.pebenito.net>
	 <1053085242.4729.786.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1053191138.4322.33.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: 17 May 2003 12:05:38 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-05-16 at 06:40, Stephen Smalley wrote:
> /dev/log shouldn't exist in devfs prior to syslogd (or metalog)
> starting.  But perhaps your devfsd is automatically restoring /dev
> entries from a backup when it initializes, thereby creating an orphaned
> /dev/log that is subsequently removed and re-created by syslogd.
> 
> You may need to grant syslogd permission to unlink device_t:sock_file so
> that it can remove the orphaned /dev/log left by devfsd.

I agree with your assessment, Stephen.  There is an entry for /dev/log
in devfsd's "dev-state" directory.  Devfsd is restoring this on its
startup.  So, I added:

REGISTER ^log CFUNCTION devfsd-se.so set_sid $devname
system_u:object_r:devlog_t

to my devfsd conflet.  That took care of metalog's unlink denial for
/dev/log.  However, devfsd still gets the denial writing to to /dev/log
because its still system_u:object_r:device_t.  Its somewhat confusing; I
would have thought that the write to /dev/log would be after devfsd's
initialization, so /dev/log would have the correct context.

Another option would be to try to stop devfsd from saving /dev/log into
dev-state in the first place.  Then /dev/log shouldn't be restored at
all.  This is seeming like the cleaner/saner option.

The binary for metalog is metalog.  If you'd like to look at it:
http://metalog.sourceforge.net/.  I like it because of it's built-in
rotation of logs based on age or size, and simple configuration.  The
problem is that metalog is klogd+syslogd, so it doesnt fit in syslogd_t
nicely (I didn't try running it in klogd_t, that might work better).  I
just added policy to syslogd.te.

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
