Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437A3BFA.1080901@cornell.edu>
References: <BF9A263D.7FFA%csellers@tresys.com>
	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>
	 <200511141041.49643.csellers@tresys.com>
	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>
	 <4378B88B.6040003@redhat.com> <4378C285.3080005@tresys.com>
	 <4378D6F9.5070301@redhat.com>
	 <1131997064.5415.241.camel@moss-spartans.epoch.ncsc.mil>
	 <1132053434.5415.269.camel@moss-spartans.epoch.ncsc.mil>
	 <1132062002.5415.350.camel@moss-spartans.epoch.ncsc.mil>
	 <4379F431.1070908@redhat.com>
	 <1132066658.5415.379.camel@moss-spartans.epoch.ncsc.mil>
	 <1132067431.5415.383.camel@moss-spartans.epoch.ncsc.mil>
	 <1132067881.5415.391.camel@moss-spartans.epoch.ncsc.mil>
	 <1132081420.28124.80.camel@moss-spartans.epoch.ncsc.mil>
	 <437A3BFA.1080901@cornell.edu>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 08:11:15 -0500
Message-Id: <1132146675.12540.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 14:50 -0500, Ivan Gyurdiev wrote:
> >
> >> Ok, so perhaps what we need is a new semanage policy component that
> >> provides libsemanage with:
> >> a) default role (or use default_contexts to determine), and
> >> b) home directory type prefix for that role, which can be different from
> >> the role prefix itself.
> >>
> >> And then have libsemanage export an interface to genhomedircon to obtain
> >> the home directory type prefix for use in generating the file contexts
> >> rather than using the role prefix itself.
> >>     
> >
> > Is there agreement on this direction?  Is anyone working on this issue
> > yet?
> >   
> 
> I am very confused..
> 
> 1. The reason we designate a role as a "default" role is to get the 
> labeling prefix. If we already have the labeling prefix, why do we still 
> want to keep a "default" role around?
> 
> 2. The labeling prefix has so far been tied to the user (map is 
> seuser->user->(fixed) role -> labeing prefix). Now you're saying the 
> login context should play a role in determining the labeling prefix? How 
> would this work? Which login context from default_contexts should be used?

Good point.   Let's just add a user->labelingprefix mapping and drop out
defrole altogether then.  

> 3. Is there documentation on default_contexts, and how to work with it?

I suppose this becomes irrelevant given the above.  I think it is
described in brief in the policy tech report, but not in great detail.
libselinux get_ordered_context_list is the "documentation" for how to
work with it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
