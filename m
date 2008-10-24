Subject: Re: ext4_has_free_blocks always checks cap_sys_resource and makes
	SELinux unhappy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: linux-ext4@vger.kernel.org, selinux@tycho.nsa.gov, esandeen@redhat.com,
        tytso@mit.edu, dwalsh@redhat.com,
        linux-security-module@vger.kernel.org
In-Reply-To: <1224869312.3404.80.camel@localhost.localdomain>
References: <1224860735.3404.74.camel@localhost.localdomain>
	 <1224860899.9353.6.camel@moss-spartans.epoch.ncsc.mil>
	 <1224869312.3404.80.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 13:38:42 -0400
Message-Id: <1224869922.9353.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-24 at 13:28 -0400, Eric Paris wrote:
> On Fri, 2008-10-24 at 11:08 -0400, Stephen Smalley wrote:
> > On Fri, 2008-10-24 at 11:05 -0400, Eric Paris wrote:
> 
> > > Do others have thoughts?
> > 
> > Seems similar to the vm_enough_memory() case, where we likewise
> > introduced a separate security hook that internally checks without
> > auditing.
> > 
> > The OOM killer likewise ought to be using a non-auditing form of
> > capability checks.
> 
> So would you suggest a generic non-auditing capability checking
> mechanism or a specific hook for "things to use"
> 
> * capable_noaudit(current, cap)
> * security_capable_noaudit(current, cap)
> * security_cap_sys_resource(current)
> 
> Looks like oom also checks CAP_SYS_ADMIN so maybe a generic cap
> interface would be best.

In the vm_enough_memory() case, I think it was Alan Cox's idea to take
the entire policy logic into a distinct security hook so that you could
ultimately support policy-based resource constraints.  Versus only
introducing a non-auditing variant of the capable check.  If we wanted
to be consistent, we'd likewise introduce distinct hooks for these cases
and take more of the logic into them, not just the capability check.
I'm open to either approach though.

> esandeen: I still think it would be a good idea to simplify
> ext4_claim_free_blocks() and ext4_has_free_blocks() which seems to have
> a lot of code duplication and both have the unconditional capable
> calls...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
