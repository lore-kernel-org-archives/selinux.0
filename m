Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KNHnrT024182
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 19:17:49 -0400 (EDT)
Date: Wed, 21 Jul 2004 00:22:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
Message-ID: <20040720232237.GA13117@lkcl.net>
References: <40FADE92.7060307@gentoo.org> <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil> <40FD6114.3020808@gentoo.org> <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil> <40FD814B.2060503@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40FD814B.2060503@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 20, 2004 at 04:32:11PM -0400, Joshua Brindle wrote:
> James Carter wrote:
> 
> >Sorry, I guess I wasn't very clear.
> >
> >I was trying to say that you are trying to manually do something that
> >the kernel can do automatically.  
> >
> >You don't need to do the security_create_compute() and setexeccon()
> >before the exec, because, on the exec, the kernel will do the same
> >thing.  In both cases, you would have had to use the domain_auto_trans
> >macro, so you don't gain anything by doing it manually.
> >
> >Without an exec, setexecon() won't help you.  
> >>From selinux.h:
> >/* Set exec security context for the next execve. 
> >  Call with NULL if you want to reset to the default. */
> >extern int setexeccon(security_context_t con);
> >
> >I am not an expert on Apache and php, but I am pretty sure that when you
> >execute the php interpreter an exec is occurring somewhere.
> >
> > 
> >
> Right, an exec is happening from httpd_t to php_exec_t currently, and 
> this will give back php_exec_t. Thats the standard way php is done in 
> SELinux at the moment and exactly what I'm trying to make better.
> 
> Now, the new idea is to have fastcgi wrapper which already does setuid() 
> and setgid() based on the ownership of the target php script (this is a 
> script! it is not executed by execve()) and then executes php (which is 
> php_exec_t) resulting in php_t again. What I want it to do is also read 
> the context of the target script and calculate the autotrans that would 
> happen if php was going to execute the script directly and then do 
> setexeccon() to do it manually.
> 
> You are exactly right in that I'm trying to do something manually but 
> afaik the kernel can't do this automatically because it's just the php 
> binary reading in a script and interpreting it, no execve() happens 
> after the php interpreter is loaded and therefore no per-user php 
> domains can currently happen.
 
 so, you want to emulate [activate] the effect of domain_auto_trans without
 _actually_ doing an execve.

 but also because you are not actually doing an execve, you also wish
 to RETURN to the context from which the domain_auto_trans was made.

 in other words, if i am interpreting this correctly [please someone
 make sure i have this right] you wish to do what a seteuid does,
 namely to temporarily go to an alternative-privileged context and
 then return to the previous context.

 and as we know, seteuid was discussed and then explicitly stomped on
 from a great height (tm).

 the recommended approach to get round this was, sadly-in-this-case
 (given the name fastcgi), to do the execve and be done with it.

 ... alternatively, might we see the rebirth of that cgi "helper" daemon
 that i am aware cropped up at one point in apache?

 like i said, my experience with SE/Linux being limited to a few months,
 if i have the wrong end of the stick, here, please some correct me.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
