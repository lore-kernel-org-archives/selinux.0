Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA28462
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 12:35:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA00759
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 17:32:53 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id RAA00755
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 17:32:53 GMT
Message-Id: <200301211742.MAA02301@moss-shockers.ncsc.mil>
Date: Tue, 21 Jan 2003 12:42:53 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Cambridge Security Group talk
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> One issue that drew a number of comments from the audence was the length of 
> security contexts and the amount of typing that it can involve.  One audience 
> member said "space in an Xterm is precious", another audience member 
> mentioned having three servers without X that were not administered remotely 
> (IE everything is done at the console without even an X based cut/paste 
> facility).

How often does a user need to type a context?  Typically, labeling of
processes and objects is handled transparently to the user.  newrole
only requires you to enter the new role name.  Editing the policy
configuration or file contexts configuration can be done offline,
and shouldn't be too frequent anyway.

> Another suggestion was to remove some parts of the context when they 
> aren't needed (such as object_r).  I tried this once but Steve convinced me 
> to revert it.  I am now thinking that perhaps we should review this matter.

libsecure provides some functions for manipulating security context
fields that are used by newrole and runas.  In general, you want to
encapsulate any logic that knows about the syntax and semantics of the
security context in a library and avoid policy-specific knowledge in the
application unless the application is fundamentally policy-specific.

> Also an audience member asked me if it would be possible to run a machine with 
> all files and processes UID=0, which was a strange co-incidence as I have 
> been planning to do that for play machine ][ (but I may have mentioned it on 
> a mailing list or something and the word may have got around).  This idea 
> seemed to get a lot of interest from the audience, who seemed to actually 
> want to do it as a serious way of running a system (rather than as a fun 
> demonstration of the power of SE Linux).  But I can oblige.

I can't recommend this.  You would need to audit your policy
configuration very carefully in light of the fact that SELinux would be
providing the sole authoritative decision for Linux capabilities
(similar to
http://marc.theaimsgroup.com/?l=selinux&m=102614635816689&w=2), and you
would need to audit any applications that make hardcoded assumptions
about uid 0.  Also, if your system is intended to be multi-user, you will
still want a DAC mechanism for user-defined restrictions.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
