Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA13359
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 19:01:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA02403
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 22:59:45 GMT
Received: from web40008.mail.yahoo.com (web40008.mail.yahoo.com [66.218.78.26])
        by jazzband.ncsc.mil  with SMTP id WAA02399 for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 22:59:44 GMT
Message-ID: <20020822230123.76888.qmail@web40008.mail.yahoo.com>
Date: Thu, 22 Aug 2002 16:01:23 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Correct order to become sysadm_r
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020822224339.4CF298B5E@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:
> On Thu, 22 Aug 2002 23:52, Brad Chapman wrote:
> > What is the correct sequence of commands to change from Brad:user_r:user_t
> > to Brad:sysadm_r:sysadm_t without incurring avc: denied errors from either
> > the transfer itself or any actions performed within sysadm_r? I'm trying to
> > keep a lot of things out of user_macros.te and su_macros.te, and the only
> > way to do that IMHO is to become either Brad:sysadm_r:sysadm_t or
> > Brad:sysadm_r:sysadm_su_t. How do I do it?
> 
> newrole -r sysadm_r
> 
> The above command is all you need on a correctly configured system.

Correectly configured == Your policy out of the box?

> 
> As an aside, it's better to change to sysadm_r before running "su -" so you 
> can access .bashrc etc.

OK. I'll try all this after a reboot.

Brad


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
