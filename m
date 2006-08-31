Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7VGdWMj007389
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 12:39:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7VGdCSk011154
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 16:39:12 GMT
Subject: Re: type transitioning script race condition?
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Joshua Brindle <method@gentoo.org>, russell@coker.com.au,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
In-Reply-To: <20060831160222.GD12307@w-m-p.com>
References: <20060830223937.GB12307@w-m-p.com>
	 <200608310918.03263.russell@coker.com.au> <44F6539E.7090800@gentoo.org>
	 <1157030632.3106.7.camel@localhost.localdomain>
	 <1157032383.24429.90.camel@twoface.columbia.tresys.com>
	 <1157038164.14623.6.camel@localhost.localdomain>
	 <20060831160222.GD12307@w-m-p.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 12:39:10 -0400
Message-Id: <1157042350.14623.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-31 at 11:02 -0500, Klaus Weidner wrote:
> On Thu, Aug 31, 2006 at 11:29:24AM -0400, Karl MacMillan wrote:
> > Sorry - started one message and sent another. If you embed the script
> > (as a string) and interpreter in the C wrapper you can avoid the race.
> 
> Yes, the important thing is to ensure that raising the privileges and
> picking the thing to execute is a single operation.
> 
> > In practice - for the scripts we are discussing - if you have sufficient
> > privilege to modify the script or the environment to take advantage of
> > the race condition you likely have a more direct attack vector. So the
> > environment cleansing seems more important to me.
> 
> You don't need to modify the script or have special privileges to exploit
> the race condition. A possible example looks like this:
> 
> - create link to executable (the link can be one of the path components),
>   for example:
> 
> 	ln -s /usr/sbin /tmp/hack
> 

In a strict environment the creation of the symlinks to privileged
applications should be controlled.

> - execute /tmp/hack/semanage
> 
> - kernel looks at label of /tmp/hack/semanage, gets the label of
>   /usr/sbin/semanage
> 
> - kernel decides to do a domain transition, suid, whatever
> 
> - kernel executes: /usr/bin/python /tmp/hack/semanage
> 
> - attacker redirects /tmp/hack to /tmp/malicious/ which contains a
>   different semanage script
> 
> - python opens /tmp/hack/semanage which now resolves to
>   /tmp/malicious/semanage
> 

Good point. Seems like a less invasive option than opening the file
descriptor is to pass in the target of the symlink instead of the
symlink, but this has several other problems.

> (As an aside, I think in this specific case the AppArmor approach of
> making the security decisions based on the path name is actually safer
> than using the file label. Time for a flame war about "label based
> security considered harmful"? ;-)  But the real solution is to avoid the
> race in the first place.)
> 

Well, this is more a problem that the privilege escalation is not
properly tied to the entrypoint object, which is why this is a problem
for both suid and selinux - in which both _correctly_ associate security
attributes with the object :).

This should be fixed for semanage. Actually, things are even worse since
semanage has "#! /usr/bin/env python" - no need to try to exploit a race
condition when you can just execute whatever you want with privileges as
long as it is called python.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
