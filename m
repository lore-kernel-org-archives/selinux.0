Date: Thu, 2 Sep 2004 12:29:07 -0500
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   Colin Walters <walters@verbum.org>,
   linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   Bill Nottingham <notting@redhat.com>, Nigel Kukard <nkukard@lbsd.net>,
   harald@redhat.com
Subject: Lomac questions [was Re: [OT] SELinux vs. other systems]
Message-ID: <20040902172907.GB9645@austin.ibm.com>
References: <20040830173744.GD10151@lbsd.net> <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net> <20040831191809.GC4375@lkcl.net> <20040831224447.GA4964@austin.ibm.com> <1094048975.11084.9.camel@nexus.verbum.private> <20040901172542.GH4964@austin.ibm.com> <1094141429.17265.281.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094141429.17265.281.camel@moss-spartans.epoch.ncsc.mil>
From: Linas Vepstas <linas@austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi Stephen,

Excellent answer... its been too long since I've played with selinux.
I'll try again.

> > I once thought about re-implementing LoMAC as a ruleset atop of SELinux.
> > I'm pretty sure that this is possible, but I started thinking that the
> > complexity of the ruleset may introduce holes that voids the effort.
> > And that thought disturbed me.
> 
> It isn't actually possible to implement LOMAC via SELinux, but that's
> another topic.

Hmm, why not? 

> > Along with Lomac's 'bluntness' comes 'zero configurability': its
> > something that could be installed on the proverbial 'Grandma's Linux
> > desktop', and provide additional security without causing pain.
> 
> Until Grandma wants to do useful work.  Simple security models are nice
> to look at, but they don't capture the behavior of real systems, and it
> doesn't matter that the model is "secure"; you just break one of the
> trusted subjects authorized to override the security model in order to
> get the real work done.  SELinux policy may look weaker to you, but it
> actually represents what is being allowed in the system; no exceptions.

I don't quite understand this.  I'm currently running Lomac on one of 
my servers, and I can get work done.  It seems to be usable, even if 
it makes some operations, like software install, harder.

I'm not sure what you mean by 'break a trusted subject'.  If you mean
'ssh is trusted, so if ssh is broken, all hope is lost', then yes.
But surely selinux has trusted subjects that may not be trustworthy?

If you mean 'lomac provides explicit tools that allow a sysadmin
to manually move a file from lower to higher trust domains', then,
well, I'm also confused.  Surely selinux also has a way to start
with something untrusted, and then raise its level ... e.g. to
install software downloaded from the net.   

Is the 'broken-ness' the fact that grandma failed to run an anti-virus
scanner and verify checksums, yada yada, before elevating the
priveldge on the downloaded software?

--linas


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
