Subject: Re: Proposed policy feature: $1_domain attribute
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov
In-Reply-To: <1109698283.10589.71.camel@moss-spartans.epoch.ncsc.mil>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <20050301151205.GC5243@thorium.jmh.mhn.de>
	 <1109690087.10589.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1109697404.3682.6.camel@cobra.ivg2.net>
	 <1109697292.10589.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1109698187.3682.15.camel@cobra.ivg2.net>
	 <1109698283.10589.71.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 11:25:58 -0500
Message-Id: <1109953558.12308.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > How about a: $1_constrained attribute.
> > 
> > Then we can do:
> > can_ps($1, $1_constrained)
> > can_ptrace($1, $1_constrained)
> > allow $1 $1_constrained:process signal;
> 
> I think I'd prefer a macro that can be selectively included by program
> domains that have been identified as being suitable for complete control
> by the user (but if you are allowing ptrace, then you might as well
> allow all signals, including sigkill and sigstop).

I am starting to give up on this idea - it's not going to work.
Programs have too many private things that should not be exposed
to user_t for no good reason. I thought there were going to be lots of
user-restricted domains, but that's not so - most of them do something
special that user can't currently do. Seems better to just make
the current permissions more consistent throughout the policy without
additional macros.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
