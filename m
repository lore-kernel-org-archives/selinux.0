Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02258
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 17:38:02 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0LMc2I08899
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 22:38:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0LMc0f08895 for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 22:38:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: Cambridge Security Group talk
Date: Tue, 21 Jan 2003 23:37:50 +0100
References: <200301211742.MAA02301@moss-shockers.ncsc.mil>
In-Reply-To: <200301211742.MAA02301@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301212337.50756.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jan 2003 18:42, Stephen D. Smalley wrote:
> > One issue that drew a number of comments from the audence was the length
> > of security contexts and the amount of typing that it can involve.  One
> > audience member said "space in an Xterm is precious", another audience
> > member mentioned having three servers without X that were not
> > administered remotely (IE everything is done at the console without even
> > an X based cut/paste facility).
>
> How often does a user need to type a context?  Typically, labeling of
> processes and objects is handled transparently to the user.  newrole

There are times when you boot in single-user mode and need to relabel files.

> only requires you to enter the new role name.  Editing the policy
> configuration or file contexts configuration can be done offline,
> and shouldn't be too frequent anyway.

True, policy editing can usually be done from an xterm, although there are 
people who don't have this luxuary.

Another thing, when using a keyboard displayed on a 240x320 TFT display with a 
stylus typing in the current context names is going to be painful...

> > Another suggestion was to remove some parts of the context when they
> > aren't needed (such as object_r).  I tried this once but Steve convinced
> > me to revert it.  I am now thinking that perhaps we should review this
> > matter.
>
> libsecure provides some functions for manipulating security context
> fields that are used by newrole and runas.  In general, you want to
> encapsulate any logic that knows about the syntax and semantics of the
> security context in a library and avoid policy-specific knowledge in the
> application unless the application is fundamentally policy-specific.

What about a bash plugin for it?  I believe that bash supports writing plugins 
for the TAB key to complete various operations, which could probably be 
extended for this.

> > Also an audience member asked me if it would be possible to run a machine
> > with all files and processes UID=0, which was a strange co-incidence as I
> > have been planning to do that for play machine ][ (but I may have
> > mentioned it on a mailing list or something and the word may have got
> > around).  This idea seemed to get a lot of interest from the audience,
> > who seemed to actually want to do it as a serious way of running a system
> > (rather than as a fun demonstration of the power of SE Linux).  But I can
> > oblige.
>
> I can't recommend this.  You would need to audit your policy
> configuration very carefully in light of the fact that SELinux would be
> providing the sole authoritative decision for Linux capabilities
> (similar to
> http://marc.theaimsgroup.com/?l=selinux&m=102614635816689&w=2), and you
> would need to audit any applications that make hardcoded assumptions
> about uid 0.  Also, if your system is intended to be multi-user, you will
> still want a DAC mechanism for user-defined restrictions.

I agree in concept, however we have to consider the following three issues:

Embedded devices run everything as root and so does Lindows.  SE Linux on such 
machines can only do good.

If we independantly verify that both SE permissions and Unix permissions are 
each capable of meeting the base security goals on their own then the result 
of combining the two of them will be better still.

In many production systems it's necessary to have SUID root programs for tasks 
such as starting chroot environments.  Not all of them will be written by 
good programmers.  If we design SE Linux to withstand free root access then 
it will stand up to the inevitable failures of SUID root programs.


That said, I have a SE machine online right now with everything as root.  It 
is a very untrusted machine, it has no passwords that are similar to 
passwords on trusted hosts, and it has firewalls to stop it attacking 
machines inside or outside my network.  I recommend that machines with such a 
configuration be locked down in such a fashion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
