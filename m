Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1NIKLmr001980
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 13:20:21 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1NIFVuD022342
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 18:15:31 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j1NIJakB009299
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 13:19:36 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j1NIJaJZ009298
	for selinux@tycho.nsa.gov; Wed, 23 Feb 2005 13:19:36 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1NHOEmr001537
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 12:24:14 -0500 (EST)
Received: from pentafluge.infradead.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1NHJNuD019628
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 17:19:24 GMT
Subject: Exim and SELinux
From: David Woodhouse <dwmw2@infradead.org>
To: russell@coker.com.au, walters@redhat.com
Cc: exim-dev@exim.org, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 23 Feb 2005 17:21:21 +0000
Message-Id: <1109179281.3820.15.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In a message for which marc.theaimsgroup.com ate the Message-ID, Russell
wrote:
> For the most desirable support of Exim we need some minor changes to the way 
> it works.  I have spoken to the author about this and he has a positive 
> attitude towards this, all that is necessary is for me (or someone else) to 
> write some patches, test them, and send them to him.
> 
> Once we get Exim working the way we desire doing the policy will be easy.
> 
> What we want is to have different parts of Exim running in different domains.  
> Exim is comprised of a single program that performs multiple tasks, but it 
> re-exec's itself for each task.  I think that the best way to do this is to 
> have (for non-SE systems) multiple hard links to the main executable and have 
> it use different names for each exec call.  This just takes up a few extra 
> directory entries on a non-SE system and has no noticeable overhead.

AFAICT there's only really two at the moment -- there's the unprivileged
mode where we only really need access to the spool directory, and the
mode we use for delivery, where we need to be able to write to users'
files. At http://david.woodhou.se/exim-4.50-selinux.patch there's a
patch which attempts to do this. If there are more personalities which I
should have distinguished between, we can fix that. Do we need a
separate binary to have privileges to listen on port 25? 

> For a SE system we could have small wrapper programs (a few K in size - they 
> would provide little overhead) that just exec the main executable.  So when a 
> new Exim task is launched it would exec the appropriate name which would 
> trigger a domain transition, that new domain would then execute the main 
> program to do the work.

For the moment I just hard-linked it. There's an patched version of the
current Fedora RPM called exim-4.50-2.selinux.{src,ppc,i386}.rpm in the
same location as above.

> This way Exim itself need know nothing about SE Linux, but we can get all the 
> functionality we want.
> 
> I believe that this would probably be acceptable to the author.  In a month or 
> so I may have time to code this.  If someone else makes an appropriate patch 
> to Exim I'll write the SE Linux policy immediately.

Let me know if you need anything more.

-- 
dwmw2

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
