Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KCQVRb018069
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:26:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KCQRAR017739
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:26:27 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
        by jazzband.ncsc.mil  with SMTP id i4KCQQHn017731 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:26:26 GMT
Date: Thu, 20 May 2004 12:23:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Steve Greenland <steveg@moregruel.net>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040520122347.GB8810@lkcl.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net> <20040519200057.GD24597@lkcl.net> <20040519215409.GA7459@moregruel.net> <20040520060606.GG24597@lkcl.net> <1085054796.521.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085054796.521.36.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 08:06:36AM -0400, Stephen Smalley wrote:

> >  "system" is like... a privilege ABOVE root, and i presume its
> >  closest equivalent is to the "SYSTEM" SID on the NT
> >  (actually VAX/VMS) security model.
> 
> No.  It is just a way of distinguishing system processes from user
> processes.  

 oh, okay :)

 i stand corrected.

> >  i think this can be resolved by adding an extra argument to
> >  process_crontab.  to put that another way: if an extra
> >  argument is added which is used solely the selinux context,
> >  the issue you have, steve, over the change from *system*
> >  to system_u goes away.
> 
> I don't think that this is necessary; it sounds like we can use the
> username field, assuming that it can be system_u for system cron jobs
> (or something else that is easily recognizable and can be mapped to
> system_u by the SELinux code).

 then that leaves the other approach, the one suggested by russell:
 to do a strcmp(fname, "*system*") == 0 in process_crontab, and
 in that specific case to call get_default_context("system_u", ...)

 i don't think steve is going to allow any changes upstream to crond
 because the letters "system_u" _could_ be a valid username used
 by a NON selinux enabled system in /etc/passwd or other security
 system.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
