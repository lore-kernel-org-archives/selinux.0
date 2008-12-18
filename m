Subject: Re: Avc denies while running in Permissive mode...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>,
        Hasan Rezaul-CHR010 <CHR010@motorola.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <1229617309.3384.62.camel@localhost.localdomain>
References: <1228865476.3737.13.camel@localhost.localdomain>
	 <1228916038.23307.1.camel@localhost.localdomain>
	 <D06FE0A2807BC145B0D38744789D4F5D051775A7@de01exm68.ds.mot.com>
	 <1229535751.31499.22.camel@localhost.localdomain>
	 <alpine.LRH.1.10.0812181525050.30403@tundra.namei.org>
	 <1229608651.27670.14.camel@localhost.localdomain>
	 <1229617309.3384.62.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 Dec 2008 11:26:49 -0500
Message-Id: <1229617609.27670.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-12-18 at 11:21 -0500, Eric Paris wrote:
> On Thu, 2008-12-18 at 08:57 -0500, Stephen Smalley wrote:
> > On Thu, 2008-12-18 at 15:30 +1100, James Morris wrote:
> > > On Wed, 17 Dec 2008, Stephen Smalley wrote:
> > > 
> > > > In permissive mode, when a permission would be denied for a given
> > > > (source context, target context, target class) triple for the first
> > > > time, the kernel audits the denial (avc:  denied) and then adds that
> > > > permission to the allowed vector for that triple in the AVC (access
> > > > vector cache).  Thus, subsequent uses of that same permission on that
> > > > same triple will not trigger further denials until the cache entry is
> > > > evicted from the cache (which can happen automatically if we need to
> > > > free up space for use by other entries or explicitly upon either a
> > > > policy reload or changing a policy boolean).
> > > 
> > > What about adding a kernel option (say, selinux_permissive_debug), which 
> > > causes the permission update to be bypassed, but still allows the 
> > > operation?
> > > 
> > > Something like:
> > > 
> > > int avc_has_perm_noaudit(...)
> > > {
> > > 
> > > 	...
> > > 
> > >         if (denied) {
> > >                 if (flags & AVC_STRICT)
> > >                         rc = -EACCES;
> > >                 else if (!selinux_enforcing || security_permissive_sid(ssid))
> > > 			if (!selinux_permissive_debug)
> > > 				avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
> > >                                 	        tsid, tclass);
> > >                 else
> > >                         rc = -EACCES;
> > >         }
> > > 
> > > 	...
> > > }
> > 
> > Yes, that was what I had in mind, although Eric seems to think we can
> > get by via existing auditallow and/or syscall audit mechanisms.
> > 
> > Such an option could have its initial value specified via kernel config
> > or via boot parameter (so that one can boot a kernel in this state
> > initially and collect all avc messages in permissive) and the value
> > could subsequently be changed via a new selinuxfs node.
> 
> The only point of this new impossible to find and twittle flag would be
> to get notification of what would have been denied.  I think I gave 2
> ways to get such notification and you already get one "correct" denial
> which audit2allow will be able to translate.  What tools really
> differentiate between one denial and 1000?  Setroubleshoot I guess sorta
> does...
> 
> I know in the past I've wished something like this flag was present, so
> I'm not going to stand in the way, but it seems to me like one can
> already get the info and we are just cluttering the kernel code so we
> can get the same info another way....

It would likely help to know why Hasan wants to see every instance of a
given avc denial.  What benefit do you derive from seeing repeated
instances of the same denial, given that they yield the same resulting
allow rules?

If you just want to run through a test sequence multiple times and see
the denials on each run, then you could always just run load_policy
after each run to flush the AVC.

Or is it the fact that you want to see multiple instances of the same
avc denial because they involve different programs and/or files running
in the same domain or labeled with the same type and you are trying to
figure out what new domains/types you need to introduce?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
