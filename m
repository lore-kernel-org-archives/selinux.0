Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KCANRb017893
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:10:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KC6OB2017952
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:06:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4KC5Wwi017650
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:05:33 GMT
Subject: Re: Bug#193644:
	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream
	patch)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Steve Greenland <steveg@moregruel.net>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org
In-Reply-To: <20040520060606.GG24597@lkcl.net>
References: <20040519091454.GL7348@lkcl.net>
	 <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net>
	 <20040519200057.GD24597@lkcl.net> <20040519215409.GA7459@moregruel.net>
	 <20040520060606.GG24597@lkcl.net>
Content-Type: text/plain
Message-Id: <1085054796.521.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 08:06:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 02:06, Luke Kenneth Casson Leighton wrote:
>  no, it wouldn't, because in some cases the context switch must
>  come from "system".

No.  We just want "system_u" as the key passed to get_default_context
when dealing with system cron jobs so that it will return a suitable
security context.  So if the username field mentioned by Steve Greenland
can be changed to store system_u for system cron jobs and the normal
username for user-configurable cron jobs, then we can just use it.

>  "system" is like... a privilege ABOVE root, and i presume its
>  closest equivalent is to the "SYSTEM" SID on the NT
>  (actually VAX/VMS) security model.

No.  It is just a way of distinguishing system processes from user
processes.  Calling get_default_context on system_u from crond will
return an appropriate context for system cron jobs (because
get_default_context obtains a context for the specified SELinux user
that is reachable from the current context).

>  i think this can be resolved by adding an extra argument to
>  process_crontab.  to put that another way: if an extra
>  argument is added which is used solely the selinux context,
>  the issue you have, steve, over the change from *system*
>  to system_u goes away.

I don't think that this is necessary; it sounds like we can use the
username field, assuming that it can be system_u for system cron jobs
(or something else that is easily recognizable and can be mapped to
system_u by the SELinux code).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
