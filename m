Subject: Re: Opinions on installing SeLinux on different distros
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Douglas Phillipson <phillipd@oem.doe.gov>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <3E7A0B04.4090502@oem.doe.gov>
References: <3E7A0B04.4090502@oem.doe.gov>
Content-Type: text/plain
Message-Id: <1048195831.24500.119.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Mar 2003 16:30:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-03-20 at 13:40, Douglas Phillipson wrote:
> I have been monitoring this list for a few months and as a SELinux newby 
> I have a few questions for those that have braved the attempt to use 
> SELinux.  I hope to use it myself in the DOE community shortly.
> 
> 1) I see lots of problems with SELinux, by the posts I read.  Is there 
> any release version, by number, with known problems for each release. Or 
> is this just a evolving "Thing" where bugs are fixed and new capability 
> is added on the fly?

The NSA SELinux team fixes bugs as they arise, ports to new kernel
version and new application level utilities, and releases whatever is
ready for release in website updates every month or two.  The core
SELinux development is done as part of research and "customer support"
isn't part of that mission.  That said, we try to respond as much as
we're able to problems and have been IMNSHO pretty responsive.

> 2) Is it best to start from non-distro raw kernel source or is patching 
> one of the major distros, redhat, Suse, Mandrake, Debian compatible, better.

SELinux is a combination of a Linux kernel patch with most of the
enhanced core functionality, a series of application/utility patches to
provide key support in some areas (e.g., assigning users to roles at
login) and an example system policy.

Typically, an SELinux installation would completely replace the kernel
for a distribution with an SELinux modified kernel, replace appropriate
applications/utilities with patched versions and construct a policy
specific to the local system.  Since each distribution chooses a
different collection of utilities to include, the appropriate utilities
for a given distribution may not have SELinux patches.  The SELinux
development team at NSA uses Red Hat, and so that is often the easiest
distribution to update with SELinux.  It is also the one that the
instruction in the README assume you are using.  The provided example
policy is designed to work with Red Hat linux, although your specific
policy needs may vary.

Russell Coker has done much excellent work in bringing SELinux to
Debian, and provides the appropriate set of patched applications (which
are very close to the Red Hat applications) and a Debian specific
example policy.  Again, you'll probably need to modify the policy to
meet your specific needs.  Carsten Grohmann has done some work on SuSE
policy changes.Other SELinux specific distributions have been mentioned
in the past, but I'm not certain about the current availability of any
of them. See http://selinux.sourceforge.net/distros.

> 3) Are there recommended  distros and or kernel versions to use SELinux 
> with?  Perhaps a FAQ for each supported Distro or version of kernel?

I won't recommend any specific distribution, but the SELinux development
team at NSA uses Red Hat as I said above, and thus the instructions we
provide in how to install SELinux are based on that.

> 4) Has anyone compiled a installation procedure that was successful for 
> their distro that you could share with others?  Perhaps even a list of 
> "gotchas" to avoid.

See the README in the SELinux distribution on the NSA web site
http://www.nsa.gov/selinux/ for Red Hat instructions.  I'm sure Russell
could provide Debian instructions.

> 5) Has anyone had SELinux approved for use in a classified network?  If 
> so do you have a security plan I could look at?
> 
> 6) Does there exist a "White Paper" on SeLinux's security 
> features/enhancements.

There is extensive documentation at http://www.nsa.gov/selinux/ under
both "Documentation" and "Background"

> 7) Does SeLinux add and "C2" auditing functionality.

No.  Please see http://www.nsa.gov/selinux/faq.html#I12

> 8) I understand that  the "Secure Computing" corporation had a hand in 
> this.  Do they have a commercial version available or one planned?

I'm not aware of any currently available commercial version of SELinux.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
