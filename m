Subject: Re: [OT] SELinux vs. other systems [was Re: [idea] udev + selinux]
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: Colin Walters <walters@verbum.org>,
   linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   Bill Nottingham <notting@redhat.com>, Nigel Kukard <nkukard@lbsd.net>,
   harald@redhat.com
In-Reply-To: <20040901172542.GH4964@austin.ibm.com>
References: <20040830173744.GD10151@lbsd.net>
	 <20040831160750.GM11456@lkcl.net> <20040831164635.GK10151@lbsd.net>
	 <20040831191809.GC4375@lkcl.net> <20040831224447.GA4964@austin.ibm.com>
	 <1094048975.11084.9.camel@nexus.verbum.private>
	 <20040901172542.GH4964@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1094141429.17265.281.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 12:10:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-01 at 13:25, Linas Vepstas wrote:
> Hmm, I thought I understood MAC; I was refering to the large numbers of
> rules in SELinux.  Its not obvious (to me) that there isn't a path
> through those rules that allows privledge escalation.  
> 
> For example: and correct me if I'm wrong, but its quite possible to 
> write a complex rule set that intentionally leaves 'holes' allowing
> for priveledge escalation.  Thus, by extrapolation, its quite possible
> to write a set of rules that accidentally do the same.  When one is
> presented with a set of rules, how does one know that they don't have a
> hole? Answer: one audits the rules.  Unfortunately, there are a lot
> of rules: last time I looked at one of the config files, it was
> thousands of lines long.  Thus, a short, simple audit performed by
> one person seems out of the question.

The complexity of the rules reflect the complexity of the existing Linux
system and its interactions; SELinux didn't introduce that complexity -
SELinux just enables you to control what happens in that complex
system.  No criticism intended of Linux; the same would apply to any
mainstream operating system, and the complexity just reflects real world
requirements.  And you do have the option of reducing the visible
complexity based on your security goals; if you don't care about the
interactions among a set of processes/resources, you fold the domain and
type space accordingly.  The targeted policy is an example of doing that
to an extreme.

Analysis of that complexity _does_ require automated tools, and such
tools exist.  apol (yum install setools setools-gui) provides support
for analysis, including domain transitions and information flow.  slat
(available from the NSA SELinux site or MITRE) does security goal
checking using a model checker.  Gokyo from IBM Watson (which AFAIK is
unfortunately not released publically yet, perhaps you could encourage
that to happen) analyzes against Biba integrity constraints and
identifies exceptions for further examination.

> However, the SELinux rules
> are unlike the kernel in an important way: they are config files. 
> This allows allows some anonymous fedora/debian/gentoo maintainer
> to do something dumb like "gee, my USB camera doesn't work with udev,
> but then when I change this selinux rule, it does", and poof, you've
> lost the security.

The policy maintainers for the various distros are not anonymous and
appear to take their work quite seriously; rejecting policy changes
despite a reduction in functionality is not uncommon.  You seem to be
assuming that policy for each package is maintained by the individual
package maintainers; that isn't the case, and likely never will be. 
Ditto for sysadmins; most of them should never touch policy at all.

> What I'm proposing here is that bluntness can be traded for increased
> assurances and increased ability to audit the code for "correctness". 
> Yes, SELinux is far more flexible; but this is exactly what scares me.

Reality is complex.  Deal with it.  Being confident in the correctness
of an inadequate security model doesn't help much.

> I once thought about re-implementing LoMAC as a ruleset atop of SELinux.
> I'm pretty sure that this is possible, but I started thinking that the
> complexity of the ruleset may introduce holes that voids the effort.
> And that thought disturbed me.

It isn't actually possible to implement LOMAC via SELinux, but that's
another topic.

> Along with Lomac's 'bluntness' comes 'zero configurability': its
> something that could be installed on the proverbial 'Grandma's Linux
> desktop', and provide additional security without causing pain.

Until Grandma wants to do useful work.  Simple security models are nice
to look at, but they don't capture the behavior of real systems, and it
doesn't matter that the model is "secure"; you just break one of the
trusted subjects authorized to override the security model in order to
get the real work done.  SELinux policy may look weaker to you, but it
actually represents what is being allowed in the system; no exceptions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
