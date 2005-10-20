Subject: Re: [ SEMANAGE ] More work on policy_components.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4356F1B3.3060000@cornell.edu>
References: <4356F1B3.3060000@cornell.edu>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 11:05:43 -0400
Message-Id: <1129820743.2375.396.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 21:24 -0400, Ivan Gyurdiev wrote:
> This patch makes the commit function shorter, and more intelligent, and 
> implements a lot more of the "merge into base" function (but not all of 
> it). It also adds comments in database.h about the behavior of the 
> add(), modify(), and iterate() functions.

Also merged as of libsemanage 1.3.28.

> Note how I can loop over the components, and not care about the details 
> (what's being loaded, what backend is it coming from, or going to).  
> That's why I can implement one load handler, and not 5 of them 
> (multiplied by the number of source and target backends). So, despite 
> what Tresys says, I think I'll keep my method tables around, since I 
> like them very much - oop is your friend.

That should be "Oopses are your friend."  Oh, sorry, different topic.

> Once this detail is fixed, I can add attach/detach calls in commit for 
> the policydb database(s), and this whole system should (in theory) work 
> (minus the functions that are stubbed, or unimplemented). Of course, 
> after that I'd need to carefully test it..

Let's get that theory turned into practice RSN...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
