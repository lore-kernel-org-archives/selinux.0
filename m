Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6EDFs5r029204
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 09:15:54 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6EDFr5n022614
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 13:15:53 GMT
Subject: Re: role infrastructure
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44B3A993.2070906@redhat.com>
References: <1152106918.8907.28.camel@sgc>  <44B3A993.2070906@redhat.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 09:17:04 -0400
Message-Id: <1152883024.3299.79.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-11 at 09:37 -0400, Daniel J Walsh wrote:
> Bringing this out for full discussion.
> 
> Christopher J. PeBenito wrote:
> > Dan, can you give me a run down of:
> >
> > 1. how you want to be able to configure user roles
> > 2. things that fc/rhel users request for user role customization
> >   
> Good question I think this is more a brain storming exercise, which I 
> don't necessarily have the knowledge or
> experience to answer.
> 
> What I have heard is for Sarbanes Oxley, groups want to be allowed to 
> have administrators that can get root privs in order to
> configure certain facets of the system, but not full control.
> 
> So you could imagine a webadmin, nameserveradmin, dhcpadmin as 
> examples.  Then I believe they would like to use
> dominance in some way to group them.  netadmin = { nameserveradmin 
> dhcpadmin }.
> 
> My idea is that we give these administrators full control over the types 
> defined for these domains, and allow them to use all of the
> standard tools for configuring (vi, emacs, basically anything labeled 
> bin_t.)
> 
> To make this useful in a Targeted policy system, we might do something 
> to sudo to get a transition to happen.
> 
> So dwalsh can run a root shell but only in the webadm_r  unconfined_t 
> would transition to webadm_r.

So this looks like the main goal of these examples is finer-grained
admin users, which makes sense.  What I'd like to do is go one step
farther and make it possible to compose the roles more easily, making it
possible to have unprivileged users that have less access than the
current user_t.  If you look at the userdomain.if in the role-infra
branch, you can see that I started to break down the user domains into
logical blocks so they can be more easily composed.  Note, the names on
these templates are just temporary, and will be changed in the future.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
