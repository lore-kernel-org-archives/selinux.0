Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBKJ1xRb016858
	for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2003 14:01:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBKJ1wpn029148
	for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2003 19:01:58 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
        by jazzband.ncsc.mil  with ESMTP id hBKJ1tab029141 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2003 19:01:56 GMT
Message-ID: <003201c3c72b$b32c6c60$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
References: <001e01c3c65f$5849f320$5d38a8c0@lky> <1071865851.11143.98.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: question about remote login
Date: Sun, 21 Dec 2003 03:01:38 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


 On Saturday, December 20, 2003 4:30 AM,Stephen Smalley wrote: 
> >     By the way I want to know how to disable the display of deny
> > messages on screen? Is there a command?
> 
> They are handled by the normal kernel logging infrastructure.  You can
> set the log level via the avc_log_level= kernel boot parameter.  The
> default level is 4 (KERN_WARNING).  You can alter the behavior of klogd
> or syslogd in the usual manner, see their man pages.
> 

Sorry,I think I didn't express my meaning clearly.I just want to stop the deny messages on screen but keep them in the log file such as messages.I set the log level via the avc_log_level= kernel boot parameter.It did stop the display of deny messages but disable the logging as well.Any advice?
Thanks!
lky


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
