Subject: Re: user_trans/user_trans_boolean macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
	 <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 12:12:09 -0500
Message-Id: <1110820329.16850.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-14 at 07:45 -0500, Stephen Smalley wrote:
> On Sun, 2005-03-13 at 00:33 -0500, Ivan Gyurdiev wrote:
> > Is there anything wrong with this patch?
> > 
> > It continues to remove stuff from x_client_domain.
> > This time the type declaration is removed, along with 
> > the transboolean stuff. The transition stuff is placed
> > in new macros called user_trans and user_trans_boolean.
> 
> Why user_trans?  Nothing is specific to users or even user domains.

Well, the role (arg $1) is the user... but I guess I could make that
into a separate argument, and rename the macro for general usage if you
prefer. 

By the way, for the second statement I tried to put the role inside the
boolean, but that wouldn't work for some reason - syntax error?

> > Points of interest:
> > 
> > - can_exec($1_$2_t, $2_exec_t)
> > I don't quite understand what this does, but I remember
> > domains needed it. It was also in the x_client rules.
> 
> This seems wrong to me; domain_trans already allows rx_file_perms
> between the new domain and the executable, so the only further
> permission being added by this macro is execute_no_trans, and that is
> wrong unless the program re-executes itself at times and wants to stay
> in the same domain upon such re-execution.

That's what I figured it probably does - should I get rid of it?
I do remember denials without it, but I could test and see.

> > - nscd_client_domain was removed for mplayer and mozilla.
> > I didn't see any problems.
> 
> Are you running nscd?  If you are using it, it will be used for any
> passwd, group, and host lookups, so many programs use it.

Well, no, but I usually get denials anyway - there were denials for
tvtime, gift, and games, but none for mplayer and mozilla, so I thought
that perhaps they don't need it. It does seem rather strange that
mozilla wouldn't need it for host lookups.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
