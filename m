Date: Wed, 19 May 2004 15:07:59 -0500
From: Chris Grier <grier@uiuc.edu>
To: Colin Walters <walters@verbum.org>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: policy questions and bugs
Message-ID: <20040519200759.GA13982@balder>
References: <20040515033020.GA5060@balder> <1084640772.10945.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084640772.10945.9.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> ----- Forwarded message from Colin Walters <walters@verbum.org> -----
>                                                                                              
> > When running some services, I would like them to run as a non root uid                     
> > and gid (ircd and oidentd are the services which I usually do this                         
> > with), which I normally do with su. When we do this with selinux                           
> > running, we are prompted to enter a role and type (not select from a                       
> > list). Is this just a matter of defining a transition to acommodate for                    
> > this to happen?                                                                            
>                                                                                              
> You run "su" interactively from a root shell?  I'd suggest instead using                     
> init scripts.                                                                                

No, not interactively. I am trying to use the init scripts. The way it
works is the init function daemon() (from /etc/init.d/functions)
accepts a --user argument to run the daemon as a given user. This
eventually calls su -c to launch the daemon as the approprate user.
The problem is that su prompts, asking to switch roles, and thus this
causes init to hang. Which is bad.

I've tried editing /etc/pam.d/su to remove the "multiple" keyword as
is indicated in the FAQ, but this does nothing to resolve the issue..

> > Why do normal users have the option of changing to sysadm?                                 
>                                                                                              
> That's a Red Hat addition to the policy.                                                     

How do I make it go away? I thought it was a matter of removing the
transition from sysadm to user in
/etc/security/selinux/src/policy/domains/user.te and then reloading,
but this doesn't seem to work. I suspect this is probably the reverse
of the transition I want to disable anyways.

> > I don't particularly like this, and I could remove it, but I'm                             
> > looking for the reasoning behind the default being like this.                              
>                                                                                              
> Basically to make the SELinux experience more like a "normal" Linux                          
> system.                                                                                      

In what ways?

-- 
Chris Grier <grier@uiuc.edu>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
