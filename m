Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hACLOKSf015637
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 16:24:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hACLNsBb001605
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 21:23:54 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hACLNs4o001602
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 21:23:54 GMT
Subject: Re: AVC messages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos Anisio Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <3FB260CC.4020801@ipen.br>
References: <3FB260CC.4020801@ipen.br>
Content-Type: text/plain
Message-Id: <1068672253.32532.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Nov 2003 16:24:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-12 at 11:33, Carlos Anisio Monteiro wrote:
> a)  I'd like to know in  what manner I can write the "avc messages" to
> a specific log file to SELinux, for instance, selinux.log file, and
> not in the messages log file.
> 
> b) How I do to that "avc messages" not are displayed in the console
> only in the selinux.log file ?

SELinux simply uses the existing kernel logging support.
You can set the log level via the 'avc_log_level=' kernel boot
parameter.  The default level is 4 (KERN_WARNING).  You
can alter the behavior of klogd or syslogd in the usual manner, see
their man pages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
