Subject: Re: [OT] SELinux vs. other systems [was Re: [idea] udev + selinux]
From: Colin Walters <walters@verbum.org>
To: linas@austin.ibm.com
Cc: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   Nigel Kukard <nkukard@lbsd.net>, linux-hotplug-devel@lists.sourceforge.net,
   SELinux <SELinux@tycho.nsa.gov>, harald@redhat.com,
   Bill Nottingham <notting@redhat.com>
In-Reply-To: <20040831224447.GA4964@austin.ibm.com>
References: <20040830173744.GD10151@lbsd.net>
	 <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net>
	 <20040831191809.GC4375@lkcl.net>  <20040831224447.GA4964@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 01 Sep 2004 10:29:34 -0400
Message-Id: <1094048975.11084.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ The CC list here is rather nuts, someone needs to trim it...]

On Tue, 2004-08-31 at 17:44 -0500, Linas Vepstas wrote:

> Every now and then, I look at SELinux, and I get scared away by its
> complexity.  

It is actually not that complicated, but if you're unfamiliar with
mandatory access control (as I was when I first started learning about
SELinux), it does require understanding some theory before you dive in.

> This complexity makes it very hard to audit, and assure
> oneself that its actually providing any real security, as opposed to
> the illusion of security.  During this email thread, there are 
> references to mysterious rules that neither party in the conversation 
> fully understands; this scares me. 

Because two people in a thread don't understand SELinux, that means that
it's too complex?  I can certainly find plenty of examples of people not
understanding Linux on linux-kernel; does that imply Linux is too
complex?

> Compare this to less complex security provided by e.g. the Linux 
> VServer project.  VServer is intended to allow an ISP to pretend they
> have a rack of 100 cpu's all running linux, when in fact they have just
> one.  

VServer isn't solving the same problem as SELinux.  VServer is really a
virtualization solution.  For example, it would make sense to run *both*
a virtualization solution like VServer (or Xen, which looks more
promising), and SELinux at the same time.  That way, if e.g. the bind
daemon running in one of the virtualized servers gets cracked, it
doesn't mean a compromise of the whole virtual server.

Now, you can use a virtualization technology as a primitive form of
separation by running e.g. your MTA in one virtual server, your name
server in another, etc.  But that's rather painful, and is only an
approximation to least privilege.

> Another example: Way back in the kernel-2.2 timeframe, I hacked on 
> something neat: 'LOMAC': if you came in from a network connection, 
> you lost permission to do almost anything, other than to e.g. webserve. 
> The system was simple, worked well, the kernel patches were easy to audit, 
> you could go home without worrying about priveledge escalation.  

That's also a rather blunt tool; SELinux is much more flexible.

> Compare that to this thread, where we are talking about atomic vs.
> non-atomic restoration of context for udev-mounted temp file systems.
> Shudder. This seems to be begging for an exploit to be discovered.

I doubt it.  Files created in /dev should have a default type like
device_t which most domains will not have access to.

> Are we sure that SELinux is really on the right track here?

Given the amount of research behind SELinux, and the amount of work
being done on it, I think so, yes.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
