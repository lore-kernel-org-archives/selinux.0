Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6KFhDrT021091
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 11:43:13 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6KFhCYW001522
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 15:43:12 GMT
Subject: Re: running interpreted scripts in different domains
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Joshua Brindle <method@gentoo.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <40FADE92.7060307@gentoo.org>
References: <40FADE92.7060307@gentoo.org>
Content-Type: text/plain
Message-Id: <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 20 Jul 2004 11:42:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-18 at 16:33, Joshua Brindle wrote:
> Ok, so I had this seemingly good idea to let apache run interpreted apps 
> (php, perl, whathaveyou) in different domains. To do this I started 
> playing with fastcgi to do the type transition from apache to the 
> interpreters domain (which works well) but that leaves all php scripts 
> in the same domain (php_t) which then can't be isolated from one 
> another. The idea is to have a php domain for each user (method_php_t) 
> and so on. The only way I could think to do this was to use fastcgi's 
> wrapper function to setexec() before calling the interpreter (it will do 
> this per user). So the idea is that there is a php script of a user 
> labeled with something like method_php_script_t and the fastcgi wrapper 
> would read that target context and paired with it's source context ask 
> selinux what the auto type trans would be so that it can explicitly do 
> it with setexec().
> 
Why can't the kernel do the auto transition?  Maybe I don't understand
what you are using for your source and target contexts.

If you call security_compute_create with fastcgi's context as the
source, the script's context as the target, and using the
SECCLASS_PROCESS class, then you will get the same result as the kernel
when it looks for the default transition in selinux_bprm_security.  So
if you take the new context returned by security_compute_create and call
setexec with it, you will end up with the same result that you would
have if you had just let the kernel do the auto transition.

> The problem is that the userspace avc doesn't currently provide this 
> information, all you can get is an access decision or a labeling or 
> relabeling decision. It seems a little extreme to add a 
> security_compute_trans() to the userspace avc (and selinuxfs filesystem, 
> etc) just to make scripts a little more isolated and provide more fine 
> grained access but I can't think of another (good) way to do this. The 
> alternative would be to use default types but that isn't very scalable 
> for X number of interpreters times N number of users.
> 
> Can anyone else think of a way to accomplish this or shall I try adding 
> a calculate auto type trans to the userspace avc's?
> 
Again, why can't you use security_compute_create?

>From selinux.h:
/* Compute a labeling decision and set *newcon to refer to it.
   Caller must free via freecon. */
extern int security_compute_create(security_context_t scon,
				   security_context_t tcon,
				   security_class_t tclass,
				   security_context_t *newcon);

> Joshua Brindle
> Hardened Gentoo
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
