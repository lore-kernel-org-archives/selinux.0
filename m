Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MKQ0gA009596
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 16:26:00 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MKKOKk012233
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 20:20:24 GMT
Subject: Re: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42E14F60.7090104@tresys.com>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
	 <1122039886.24847.6.camel@celtics.boston.redhat.com>
	 <42E10804.5030401@tresys.com>
	 <1122046798.25951.27.camel@celtics.boston.redhat.com>
	 <42E146D3.60809@tresys.com>
	 <1122061488.30783.14.camel@celtics.boston.redhat.com>
	 <42E14F60.7090104@tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 16:18:33 -0400
Message-Id: <1122063513.30783.47.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-22 at 15:56 -0400, Joshua Brindle wrote:
> <snip>
> 
> >Speaking of which... I'm duplicating your sepol_*_t records
> >almost one-to-one in the libsepol api. I don't see a way around 
> >that, however, because they are located in libsemanage.
> >
> >  
> >
> Why do you need them in libsepol? You don't need or want opaque types in 
> libsepol, libsepol is a direct representation of the policy data 
> structures. All the abstracted structures go in libsemanage.

I don't _want_ libsepol to be a direct representation of the policy data
structures. This is the state of affairs right now, and I think it's
completely wrong, and needs to be changed. 

You can't do any representation changes without modifying libsepol _and_
everything that goes and manipulates internal structures outside 
libsepol. 

The whole point of a library is to hide internal functionality, not
to expose it to everything, so that you get dependencies.
Your desire to make libsepol static addresses the symptom of the 
problem, not the problem itself. To really address the problem,
we should move sepol structural dependencies inside sepol.
We should be building libsepol, not destroying it, and reducing
it down to a bunch of random object files with no interface.

I remember Stephen Smalley saying he wanted the internal headers
hidden, but they had to be shared with checkpolicy, and he didn't
know how to solve this - I think the answer is that all the
code in checkpolicy that manipulates data structures shouldn't
be in checkpolicy at all. I disagree with you that all the
code that matters has already been moved - this is just not
true in my opinion.

========

Now, the structures I've added to libsepol are not actually opaque,
they're just...higher level than the ones that manipulate sids.
This could be a bad thing or not - I don't know - people
who know and care more about ABI compatibility should say
something here. The fact of the matter is that I don't want 
to manipulate sids from libsemanage, and I think that's the 
completely wrong level for it. The code I have has nothing 
to do with sids - it manipulates files, and has to do with 
parsing information from those files, and relaying it to sepol.
 

> >It does matter, because I can write patches against it, and not write
> >semod_ everywhere that I need to fix later.
> >
> >  
> >
> We aren't writing patches right now, we are trying to design a library. 
> I'm really asking for your help to flesh out what is required for this 
> API to work so that we can actually implement it.

I am trying to help, but you're ignoring the fact that I had a working
implementation already when we began this discussion, and I've been
trying to turn it into something usable that people agree with
before my internship at RedHat ends by the end of next week.

> >I can't see if actually works, because there is no library to test it
> >with. It used to work when it was in libselinux... I'm sure I'll have
> >to change it a bit to fit with your structure names, and your apis,
> >and your transaction processing.
> >
> >  
> >
> I mean that it works conceptually, ie: the API provides everything you 
> need. Compiling and testing is very irrelavent right now since we are 
> trying to design a very abstract management API for SELinux, something 
> that needs to be carefully designed.

Ok, so let's carefully design it.. and then
add an implementation.

> >>semanage_user_change(semanage_handle_t *, semanage_user_t *userdata, 
> >>char* key);
> >>it would totally replace the datum, no unioning or anything like that
> >>    
> >>
> >
> >If you're assuming character key, please assume character key in
> >the delete functions as well. I'm not against it, simply pointing out..
> >
> >  
> >
> or we make opaque types for all keys and all datums just incase we want 
> a composite key later.

...or that...
I agree with your point that this way you can use a composite data key..
but it just looks weird. Is this a widely used practice of software
development - I don't have enough experience? 

> >The drawback to not providing any more specific change functions 
> >to the caller, is that now you have to do a query and a change for
> >everything, even if all you're doing is adding information, and not
> >extracting any. That means two iterations in the flat file case...
> >but for the sake of simplicity and cleanness of API, maybe I'll agree.
> >
> >However, not having a query function is just wrong, I disagree with
> >that.
> >  
> >
> We'll add them, they are just convenience functions that will be added 
> as needed.

The query functions are not a convenience functions - they
are fundamental to this whole thing working, especially the way
you have it right now.

I know the name of a selinux user, and I want to add a role.
How would I do that? I can't - it's impossible, because you've
provided no way to query the existing information (which provides
the rest of user's data to combine with this new role). I have
to completely regenerate the user record in order to add a new
role.

> Please, please stop focusing on the implementation details and help with 
> the API design, I really need to know if this is sufficient for you 
> (sans the labeling stuff that we are still working out). This is going 
> to be an API that is used by every single tool that manages policy and 
> it needs to be well thought out and flexible.

Okay... 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
