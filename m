Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7UJhsLa003135
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 15:43:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7UJhret027674
	for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 19:43:54 GMT
Received: from out005.verizon.net (out005pub.verizon.net [206.46.170.143])
        by jazzband.ncsc.mil  with ESMTP id h7UJhrlq027671 for <selinux@tycho.nsa.gov>; Sat, 30 Aug 2003 19:43:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Q on Internals & Data Structures
Date: Sat, 30 Aug 2003 15:45:03 -0400
Cc: SELinux <selinux@tycho.nsa.gov>
References: <200308291222.23424.wlsel@verizon.net> <1062177075.5432.143.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1062177075.5432.143.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200308301545.03201.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 29 August 2003 01:11 pm, Stephen Smalley wrote:
> On Fri, 2003-08-29 at 12:22, Bill Laut wrote:
> > I'm beginning work on my first experimental implementation of a
> > security-aware X, using the paper "Securing the X Window System with
> > SELinux"
> > [KilSalVanNAI2003] as a guide.  To facilitate this, I would like to
> > prepare an informal reference document that schematically charts all of
> > the kernel data structures used within SELinux, along with a chart
> > tracing the execution thread of the security services from start to
> > finish.  Of particular interest is the format of the compiled policy as
> > it sits in the kernel, and how it is interrogated to arrive at a yes/no
> > decision.
> >
> > Has any documentation of this sort been created, and if so where can I
> > find it?  I already have "Configuring the SELinux Policy" and
> > "Implementing SELinux as a Linux Security Module," but while good they
> > are not what I'm looking for.
>
> The Integrating Flexible Support... technical report (not to be confused
> with the conference paper of the same name) is out of date, but you can
> still glean quite a bit of useful information from it.  It described the
> original SELinux implementation, and remains the only description of
> certain aspects of the system.  The Flask architecture background paper
> describes the security architecture and how the components interact, but
> not at the level of detail you may want.
>

Thank you.  I've downloaded those reports and will digest them over the Labor 
Day weekend.

>
> You don't actually need to re-invent the base security services, as the
> modified X server can simply invoke the security policy API exported by
> the kernel (and wrapped by libselinux).
>

Agreed.  I don't wish to replicate the security services outside of the 
kernel, as it would likely create more problems than solve.  Worse, it would 
establish an undesirable long-term precedent.  My gut concern is that each 
security decision -could- involve multiple target contexts (ie, taking a 
screen snapshot populated with windows from a half-dozen or more clients) 
instead of the single source/target pair.  Therefore, my immediate desire for 
this information is to thoroughly learn the intricacies of SELinux so that I 
can devise a means of implementing the MACs while minimizing  CPU overhead.

Beyond X, down the road I intend to put on my "black hat" and thoroughly 
scourge SELinux for possible vulnerabilities.

>
> But you will ultimately need the following supporting components:
>
> 1) A userspace access vector cache (AVC), likely as an addition to
> libselinux.  This can be a trivial port of the kernel AVC code, adapting
> it to use the security policy API functions already provided by
> libselinux to interact with the kernel security server.  The major
> missing element is a notification interface from the kernel security
> server to flush userspace AVCs upon policy changes, but that isn't
> critical to basic operation.
>

Yes.  This would resolve the peculiarities I raised (eg, multiple target 
contexts) without impacting the kernel.  For now, the notification interface 
can be put off until the first experimental version is implemented so that 
its "lessons learned" can help describe the interface.

>
> 2) Extensions to the socket API so that the X server can obtain the
> security contexts of clients.  The overhaul of the SELinux API for
> mainline integration caused us to lose our extended socket calls, so we
> do not presently have an interface for that purpose.  To be accepted
> into the mainline, the API extensions would need to be more consistent
> with existing kernel interfaces, e.g. a SCM_CREDENTIALS control message
> for sendmsg/recvmsg or a new option for getsockopt rather than extended
> versions of the base socket calls.
>

For the first draft I was originally going to interrogate the kernel data 
structures directly myself to find the peer's PID and then use the security 
services to obtain the client's security context without bothering with an 
extention to the socket API, with the second experimental draft "cleaning up" 
things like formal APIs, etc.

I agree with your point.  Let me digest this further in order to formulate 
intelligent questions for you about the best way to proceed. 

>
> We would likely implement the notification interface for the userspace
> AVC and the socket API extensions ourselves if there were someone
> helping to drive the requirements for them.  Their current absence is
> mostly a reflection of the lack of any users for them.  The X server
> modifications could be done in parallel, with some scaffolding until the
> supporting components were ready.
>

That is reasonable.  To the extent I can assist you, I'd be happy to.  

Speaking of "driving the requirements," there is something I've been curious 
about:  Would it be possible to add permissions to the security services 
themselves?  EG, if I have a program that is security-ignorant but which 
passes through the firewall to talk on the Internet, should a malicious 
server compromise it via an unforeseen buffer-overflow I want to insure that 
a security-aware payload inside the BO cannot somehow interrogate my policy 
or in any way alter it.

In short, if an application/client is assumed to be security-ignorant, I want 
its domain to -enforce- that ignorance and to audit any unexpected behavior 
to the contrary, especially if the app is a network client talking to a peer 
over an untrusted network.

>
> Are you just working on this yourself, or as part of a larger project?
>

I'm working on this by myself, and will make the finished enhancements 
available to whomever might want them.  If the XFree86 people would like fold 
them into their tree, that will be fine as well.  Same applies to KDE, once I 
finish up with X.

SELinux is the premiere Linux security solution for the server side of things, 
but no one has yet pushed it into the client workstation arena.  I had a 
buffer overflow attack penetrate my workstation earlier this year (see my 
reply to Steven Jenkins re Type Background).  Fortunately I caught it in time 
to remove anything sensitive off of my system before the attacker could find 
it.  Nevertheless I now have plenty of motivation to drive SELinux into the 
client workstation arena--along with an obsessive attention to detail that 
will leave "no stone unturned" until SELinux is seamlessly airtight.


Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
