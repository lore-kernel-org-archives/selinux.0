Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KBwORb017803
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 07:58:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KBwLAR013352
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 11:58:21 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4KBwLHn013349 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 11:58:21 GMT
Subject: Re: Bug#193644:
	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream
	patch)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Steve Greenland <steveg@moregruel.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org
In-Reply-To: <20040519215409.GA7459@moregruel.net>
References: <20040519091454.GL7348@lkcl.net>
	 <1084973453.30873.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20040519140239.GF4221@lkcl.net> <20040519181120.GA6115@moregruel.net>
	 <20040519200057.GD24597@lkcl.net>  <20040519215409.GA7459@moregruel.net>
Content-Type: text/plain
Message-Id: <1085054262.521.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 07:57:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-05-19 at 17:54, Steve Greenland wrote:
> No. How many times do I have to say this? It's the WRONG FSCKING FIELD.
> The field the SE linux people are so obsessed with changing is NOT
> THE USERNAME field. The username field is available. Using it for
> controlling the SE context would do the right thing, right? For the
> real user crontabs, it would have the real username, even for root. For
> the system crontabs, under /etc, it could be system_u. Then calling
> SE_get_security_context(username) (or whatever the function/terminology
> is) would always be the right thing to do, yes?

Yes, if we can get the field to be system_u for system crontabs (at
least when SELinux is enabled), then that would likely be fine. 
get_default_context will then get the proper context for system cron
jobs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
