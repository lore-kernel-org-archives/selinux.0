Subject: Re: Incorrect avc logs for the packet object class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Marshall Miller <mmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <200905211037.06609.paul.moore@hp.com>
References: <1242840195.22878.339.camel@hostmachine.tresys.com>
	 <1242915280.20082.463.camel@localhost.localdomain>
	 <200905211037.06609.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 21 May 2009 12:26:22 -0400
Message-Id: <1242923182.20082.468.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-05-21 at 10:37 -0400, Paul Moore wrote:
> On Thursday 21 May 2009 10:14:40 am Stephen Smalley wrote:
> > On Wed, 2009-05-20 at 13:23 -0400, Marshall Miller wrote:
> > > I first noticed this bug on a RHEL 5 system, and I also noticed it on
> > > Ubuntu Jaunty.  I tested this out on Fedora 11 Preview and it was there
> > > also.
> > >
> > > The avc messages for the packet object class sporadically report
> > > incorrect comm/pid info.  It is most apparent when multiple processes
> > > are sending/receiving packets at the same time.  To demonstrate this, I
> > > added an iptables rule such that every packet being sent is labeled
> > > system_u:object_r:dns_client_packet_t:s0 (arbitrarily chosen from
> > > existing types).  I then created and inserted a module that auditallows
> > > all packet perms for subj == domain and obj == dns_client_packet_t.
> > > Then I started the Software Updater, and when it started downloading
> > > packages I ran firefox.
> >
> > This has always been an issue for the low level networking permission
> > checks that may happen outside of process context; unfortunately,
> > "current" is still defined in that situation and thus avc_audit() cannot
> > distinguish the cases where it has a relevant process context from these
> > situations.  Options for fixing:
> > - Have the callers of avc_has_perm() pass a flag (e.g. via
> > avc_audit_data) when no relevant process context is available, and use
> > that flag within avc_audit() to omit the comm= and pid= information and
> > to pass a NULL audit_context to audit_log_start().
> > - Have avc_audit() internally check for certain classes and permissions
> > (e.g. SECCLASS_PACKET, SECCLASS_PEER, SECCLASS_NETIF, SECCLASS_NODE)
> > known to have this behavior, and likewise omit the comm= and pid=
> > information and pass a NULL context to audit_log_start() in that case.
> > Concern with this approach is that a given class/permission may be used
> > from multiple call sites, some of which may have a valid process context
> > and some of which may not.
> 
> For the reasons that Stephen pointed out as well as a concern that it would be 
> harder to maintain (we would likely forget to add new classes in the future 
> should they arise) I vote for the first flag-passing approach.  It should be a 
> relatively small patch; if I don't hear any objections I'll start working on 
> it on in the next day or two ... I would think we should be able to still get 
> this into 2.6.30.

Thanks, Paul - sounds good.  One further observation here:  in the past,
I only recall seeing this issue crop up on recv-side checking, not the
send-side checking, as most sends happen while still in the process
context of the sender.  I guess what we are seeing here is TCP
re-transmit.  Unfortunately, I don't think that we can distinguish the
cases from our hooks for the packet send checks, and thus we may end up
losing audit information (both at the avc level and at the syscall audit
record level) about the sending process even when that information would
in fact be accurate.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
