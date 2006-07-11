Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6BDaTbr008105
	for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2006 09:36:29 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6BDaRoB015516
	for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2006 13:36:27 GMT
Message-ID: <44B3A993.2070906@redhat.com>
Date: Tue, 11 Jul 2006 09:37:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: role infrastructure
References: <1152106918.8907.28.camel@sgc>
In-Reply-To: <1152106918.8907.28.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bringing this out for full discussion.

Christopher J. PeBenito wrote:
> Dan, can you give me a run down of:
>
> 1. how you want to be able to configure user roles
> 2. things that fc/rhel users request for user role customization
>   
Good question I think this is more a brain storming exercise, which I 
don't necessarily have the knowledge or
experience to answer.

What I have heard is for Sarbanes Oxley, groups want to be allowed to 
have administrators that can get root privs in order to
configure certain facets of the system, but not full control.

So you could imagine a webadmin, nameserveradmin, dhcpadmin as 
examples.  Then I believe they would like to use
dominance in some way to group them.  netadmin = { nameserveradmin 
dhcpadmin }.

My idea is that we give these administrators full control over the types 
defined for these domains, and allow them to use all of the
standard tools for configuring (vi, emacs, basically anything labeled 
bin_t.)

To make this useful in a Targeted policy system, we might do something 
to sudo to get a transition to happen.

So dwalsh can run a root shell but only in the webadm_r  unconfined_t 
would transition to webadm_r.

Thoughts?

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
