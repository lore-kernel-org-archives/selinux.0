Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KIvvRb022015
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:57:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KItVB2020196
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:55:31 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
	by jazzswing.ncsc.mil  with SMTP id i4KItUwi020193
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:55:30 GMT
Date: Thu, 20 May 2004 18:55:15 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Steve Greenland <steveg@moregruel.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040520185515.GB18182@lkcl.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net> <20040519200057.GD24597@lkcl.net> <20040519215409.GA7459@moregruel.net> <1085054262.521.27.camel@moss-spartans.epoch.ncsc.mil> <20040520142212.GE8810@lkcl.net> <20040520154849.GA14106@moregruel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040520154849.GA14106@moregruel.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 20, 2004 at 10:48:49AM -0500, Steve Greenland wrote:

> >  by doing process_crontab ("system_u", "*system*", ...) wherever
> >  "*system*" is used, and by doing get_default_context(uname, ...)
> >  inside process_crontab, the correct semantics are maintained.
> 
> Yes.
> 
> Thanks for following this through. I'll look at the patch this weekend.
> 
> Hmmm. One Debian specific problem. libselinux1 is priority "optional",
> while cron is "important". I guess I need to talk to Colin Walters.
 
 ultimately it needs to be priority "required" and essential "yes"
 because programs in coreutils (e.g. ls) need libselinux1.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
