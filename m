Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA06363
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 10:24:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA25759
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 14:23:05 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
        by jazzband.ncsc.mil  with ESMTP id OAA25755 for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 14:23:04 GMT
Date: Mon, 15 Jul 2002 09:24:28 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207151424.JAA10680@tomcat.admin.navo.hpc.mil>
To: russell@coker.com.au, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: revising the su decision
In-Reply-To: <20020712232915.70A7C44D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au>:
> On Fri, 12 Jul 2002 17:46, Jesse Pollard wrote:
> > The separation now means that a root compromise is not all that usefull.
> >
> > Consider what happes if a root compromise performs a "su - root". It
> > currently looks like the compromise would suddenly get whatever role has
> > been assiged to root.
> 
> You are assuming here that root:user_r:user_t can su to any domain without a 
> password, and that a default su to a domain will get the maximum SE Linux 
> privs.
> 
> The former assumption is not what I had been thinking of, and the latter is a 
> matter of policy.

I was basing it on the current functionality of "su". Right now, any use of
su will succeed for root. If additional options (not just "-") are provided
to establish a different security context, and that context change requires
a password, then my objections are overcome. The advantage of a different
option to set security context is that some (like some user support activity)
want to be able to switch to the users environment (minus the security context).
This would be accomplished by "su - user". To complete the security context
too, another option (how about something like "su - -s user") would allow
switching to user environment context and security context; but requires
a password (not necessarily the users password but that's a different subject).

It would also allow a "su -s user" to only setup the security context of that
target user account (good for verifying that the user context is correct).

> I had imagined that the ability to do "su - account" without a password would 
> depend on both UID=0 and being sysadm_r:sysadm_t.
> 
> > The advantage of the newrole is to REQUIRE a password before gaining
> > sysadm_r.
> 
> Yes, but that doesn't stop us from having one program doing both
> "newrole -r sysadm_r" and "su -" functionality.

No it doesn't. Should work fine, with the additional safegards that are
implicit in the "newrole".
 
> > Now, If you merge the newrole functions into su and remove the automatic
> > su to itself (ie su root when root still requires a password, AND su to
> > any account requires a password), then my objections are much weaker.
> 
> How about su to any account without a password gets the same result as such a 
> su operation now, the source UID must be 0 and the context doesn't change.
> 
> I think that your disagreement is due to imagining a different way of 
> implementing it to that which I had imagined.

I was just imagining some of the various attacks using "su" to gain privileges
or context. I think that any security context change sould always require
a password, and hence, a real tty structure associated with the "su" process
for additional audit information (as to who/what is connected to that
tty/pty).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
