Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA13376
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 14:34:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA00963
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 19:33:56 GMT
Received: from smtpproxy1.mitre.org (mb-20-100.mitre.org [129.83.20.100])
	by jazzband.ncsc.mil  with ESMTP id TAA00959
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 19:33:55 GMT
Received: from avsrv1.mitre.org (avsrv1.mitre.org [129.83.20.58])
	by smtpproxy1.mitre.org (8.9.3/8.9.3) with ESMTP id OAA28518
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 14:34:00 -0500 (EST)
Received: from mailsrv1.mitre.org (mailsrv1.mitre.org [129.83.20.6])
	by smtpsrv1.mitre.org (8.9.3/8.9.3) with ESMTP id OAA05187
	for <selinux@tycho.nsa.gov>; Mon, 19 Feb 2001 14:33:59 -0500 (EST)
Message-ID: <3A912E56.8E4F7C76@mitre.org>
Date: Mon, 19 Feb 2001 09:31:50 -0500
From: Jen Salois <jsalois@mitre.org>
MIME-Version: 1.0
To: Mark Slagell <ms@iastate.edu>
CC: selinux@tycho.nsa.gov
Subject: Re: scontext/tcontext/tclass
References: <3A91639D.3BD5A0E6@iastate.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Mark,

	The scontext is the source context.  This is the file that is trying to
do the accessing.  The tcontext is the target context.  This is context
of the file that is being accessed.  In the case of your second error,
the scontext is the context of the crond daemon and the tcontext is the
context of the /var/log/cron file.  The error message is saying that
crond with a context of system_u:system_r:crond_t is trying to append to
/var/log/cron that has a context of system_u:object_r:xfs_tmp_t.  

Hope that helps clear up any confusion.  

Thanks

Jen


> Hi all,
> 
> Hopefully this is very basic stuff, but I'm not sure how to read some of
> the error messages I'm seeing. To wit:
> 
> avc:  denied { kill } for  pid=14271 exe=/usr/sbin/identd capability=5
>    scontext=system_u:system_r:inetd_child_t
>    tcontext=system_u:system_r:inetd_child_t
>    tclass=capability
> 
> avc:  denied  { append } for  pid=27031 exe=/usr/sbin/crond
> path=/var/log/cron dev=03:01 ino=99291
>    scontext=system_u:system_r:crond_t
>    tcontext=system_u:object_r:xfs_tmp_t
>    tclass=file
> 
> As I suspect getting these errors cleared up is a reasonable first goal
> in working with selinux, I wonder if someone would point out to me the
> difference between scontext and tcontext and make just one little light
> bulb come on here. I've been rtfm'ing for a while here and must be
> looking right at it, but it's not getting through.
> 
>   Mark
> 
> --
> I took a course in speed reading and was able to read War and Peace in
> twenty minutes.  It's about Russia.
>     -- Woody Allen
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
