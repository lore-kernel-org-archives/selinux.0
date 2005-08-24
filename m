Subject: Re: Ok I plead ignorance to the way MLS works.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430CA3EC.8080102@trustedcs.com>
References: <430A33E5.1030100@redhat.com>
	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
	 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
	 <430C75B4.3020008@redhat.com>
	 <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>
	 <430C8944.6090306@redhat.com>  <430CA3EC.8080102@trustedcs.com>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 12:56:36 -0400
Message-Id: <1124902596.11553.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-08-24 at 11:44 -0500, Darrel Goeddel wrote:
> I think you would want to run the kernel would at s0:c0.c127.
> Then, do a "range_transition kernel_t init_exec_t s0" to get the whole
> of userspace started off with no categories present.

Why not just have the kernel start out at s0 (no categories), and just
give its domain the necessary attributes to override MLS?  Then you
don't need to transition at all.  Otherwise, you also have to deal with
any other kernel-invoked helpers, e.g. hotplug.

> I'm sure about the compilation error, I did a similar statement with a
> toolchain that is are pre-modules - that worked.  I'm updating an FC4 box
> now so I at least have something up-to-date.

I just tried adding the range_transition listed by Dan to a policy.conf
and rebuilding with checkpolicy -M (latest cvs), and it worked for me.
But note that s0 - s0 is unnecessary; it is the same as just s0.  The
high level defaults to the low level if it isn't specified.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
