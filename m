Date: Thu, 20 May 2004 06:26:58 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Grier <grier@uiuc.edu>
Cc: Colin Walters <walters@verbum.org>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: policy questions and bugs
Message-ID: <20040520062656.GI24597@lkcl.net>
References: <20040515033020.GA5060@balder> <1084640772.10945.9.camel@nexus.verbum.private> <20040519200759.GA13982@balder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519200759.GA13982@balder>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 03:07:59PM -0500, Chris Grier wrote:
> > ----- Forwarded message from Colin Walters <walters@verbum.org> -----
> >                                                                                              
> > > When running some services, I would like them to run as a non root uid                     
> > > and gid (ircd and oidentd are the services which I usually do this                         
> > > with), which I normally do with su. When we do this with selinux                           
> > > running, we are prompted to enter a role and type (not select from a                       
> > > list). Is this just a matter of defining a transition to acommodate for                    
> > > this to happen?                                                                            
> >                                                                                              
> > You run "su" interactively from a root shell?  I'd suggest instead using                     
> > init scripts.                                                                                
> 
> No, not interactively. I am trying to use the init scripts. The way it
> works is the init function daemon() (from /etc/init.d/functions)
> accepts a --user argument to run the daemon as a given user. 

 oo.  ah.  yes, i have some scripts that need to be run under
 specific user contexts, too.

 i use /sbin/start-stop-daemon with a "-u lkcl" argument.

 is /sbin/start-stop-daemon going to need to be updated, too,
 to have a get_default_context() call in it?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
