Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KFmtRb019996
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 11:48:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KFkSB2005614
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:46:28 GMT
Received: from fury.moregruel.net (fury.moregruel.net [64.62.190.193])
	by jazzswing.ncsc.mil  with ESMTP id i4KFkRwi005609
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:46:28 GMT
Date: Thu, 20 May 2004 10:48:49 -0500
From: Steve Greenland <steveg@moregruel.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>,
   193644@bugs.debian.org
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Message-ID: <20040520154849.GA14106@moregruel.net>
Reply-To: Steve Greenland <steveg@moregruel.net>
References: <20040519091454.GL7348@lkcl.net> <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil> <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net> <20040519200057.GD24597@lkcl.net> <20040519215409.GA7459@moregruel.net> <1085054262.521.27.camel@moss-spartans.epoch.ncsc.mil> <20040520142212.GE8810@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040520142212.GE8810@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 20-May-04, 09:22 (CDT), Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote: 
>  therefore, whatever you specify under such circumstances (fname
>  == '*system*'), the uname argument is completely irrelevant.
>  it could, in fact, be NULL.
> 
>  therefore, under such circumstances, whatever is specified in
>  uname there can be no objection about.
> 
>  therefore, it is perfectly reasonable to do this, at both lines
>  179 and 220 or thereabouts:
> 
>  process_crontab ("system_u", "*system*", ...)

Bingo. 

>  now, it so happens that at line 250 or thereabouts, the
>  first and 2nd arg are identical (fname).
> 
>  conclusion:
> 
>  by doing process_crontab ("system_u", "*system*", ...) wherever
>  "*system*" is used, and by doing get_default_context(uname, ...)
>  inside process_crontab, the correct semantics are maintained.

Yes.

Thanks for following this through. I'll look at the patch this weekend.

Hmmm. One Debian specific problem. libselinux1 is priority "optional",
while cron is "important". I guess I need to talk to Colin Walters.

Steve


-- 
Steve Greenland
    The irony is that Bill Gates claims to be making a stable operating
    system and Linus Torvalds claims to be trying to take over the
    world.       -- seen on the net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
