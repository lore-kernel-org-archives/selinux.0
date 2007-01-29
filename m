Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>,
        Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <m14pq9lntk.fsf@ebiederm.dsl.xmission.com>
References: <200701280106.l0S16CG3019873@shell0.pdx.osdl.net>
	 <20070127172410.2b041952.akpm@osdl.org>
	 <1169972718.17469.164.camel@localhost.localdomain>
	 <20070128003549.2ca38dc8.akpm@osdl.org> <20070128093358.GA2071@elte.hu>
	 <20070128095712.GA6485@elte.hu> <20070128100627.GA8416@elte.hu>
	 <20070128104548.a835d859.akpm@osdl.org>
	 <m1r6tfq7nv.fsf_-_@ebiederm.dsl.xmission.com>
	 <1170075866.8720.15.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.64.0701291017520.11801@d.namei>
	 <m14pq9lntk.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 14:26:43 -0500
Message-Id: <1170098803.8720.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-29 at 10:55 -0700, Eric W. Biederman wrote:
> James Morris <jmorris@namei.org> writes:
> 
> > On Mon, 29 Jan 2007, Stephen Smalley wrote:
> >
> >> NAK.  Mapping all sysctls to a single security label prevents any kind
> >> of fine-grained security on sysctls, and current policies already make
> >> use of the current distinctions to limit access to particular sets of
> >> sysctls to particular processes.  As is, I'd expect breakage of current
> >> systems running SELinux from this patch, because (confined) processes
> >> that formerly only required access to specific sysctl labels will
> >> suddenly run into denials on the generic fallback label.
> >
> > Agreed, 100% NACK.
> >
> > Please don't just simply remove long-researched & analyzed MAC security 
> > which has been in the kernel for years, which is being used in the field 
> > for high assurance systems, because you neglected to consider it during a 
> > code cleanup.
> 
> Please don't shoot the messenger when a weakness is found in your code.

I'm not sure how breaking our code with your set of patches qualifies as
finding a weakness.  I will agree that the current handling of sysctl in
selinux is fragile and can be improved, but it did work (prior to your
patches).

> Systems that increase security without worry that their implementation
> is correct do not impress me, but I do understand that security has
> little to do with correctness and everything to do with making it
> _expensive_ for the other guy to do what he isn't supposed to.

I think you misunderstand; we are concerned about the correctness of our
implementation.  I think that possibly you are misunderstanding one of
the SELinux FAQ answers outside of its historical context (the initial
release of a proof-of-concept implementation of flexible MAC in Dec
2000).

> This code path was always in the selinux code for when /proc was
> compiled out.  I could see no way to preserve it so I removed
> it.
> 
> Not knowing if it was a problem, or if we needed to do something more
> I copied the people who did, at the first available opportunity.
> Before this code makes it's way into peoples production systems.

Which we appreciate, although it would be nice if you tried building
with selinux (and ideally testing with it) in the first place.

> Of course after all of the rants against path based security I was
> amazed to find a code path that was using exactly that in selinux.

To clarify, in this case, the pathname (relative to the root of proc) is
derived from the proc_dir_entry hierarchy and is thus not ambiguous or
mutable by userspace, unlike the pathname-based approaches that we have
criticized.  There is a difference.  But we are open to improving the
approach via explicit marking of the ctl_table entries with sufficient
information.

> I'm trying to make things correct, and simple and will be happy to
> work with you in a way to achieve what you need in a way that does
> not conflict with the rest of the kernel.

Good.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
