From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Incorrect avc logs for the packet object class
Date: Thu, 21 May 2009 15:10:36 -0400
Cc: Marshall Miller <mmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
References: <1242840195.22878.339.camel@hostmachine.tresys.com> <1242928629.20082.499.camel@localhost.localdomain> <200905211505.54545.paul.moore@hp.com>
In-Reply-To: <200905211505.54545.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200905211510.36339.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 21 May 2009 03:05:54 pm Paul Moore wrote:
> On Thursday 21 May 2009 01:57:09 pm Stephen Smalley wrote:
> > On Thu, 2009-05-21 at 12:26 -0400, Stephen Smalley wrote:
> > > On Thu, 2009-05-21 at 10:37 -0400, Paul Moore wrote:
> > > > On Thursday 21 May 2009 10:14:40 am Stephen Smalley wrote:
> > > > > On Wed, 2009-05-20 at 13:23 -0400, Marshall Miller wrote:
> > > > > > I first noticed this bug on a RHEL 5 system, and I also noticed
> > > > > > it on Ubuntu Jaunty.  I tested this out on Fedora 11 Preview and
> > > > > > it was there also.
> > > > > >
> > > > > > The avc messages for the packet object class sporadically report
> > > > > > incorrect comm/pid info.  It is most apparent when multiple
> > > > > > processes are sending/receiving packets at the same time.  To
> > > > > > demonstrate this, I added an iptables rule such that every packet
> > > > > > being sent is labeled system_u:object_r:dns_client_packet_t:s0
> > > > > > (arbitrarily chosen from existing types).  I then created and
> > > > > > inserted a module that auditallows all packet perms for subj ==
> > > > > > domain and obj == dns_client_packet_t. Then I started the
> > > > > > Software Updater, and when it started downloading packages I ran
> > > > > > firefox.
> > > > >
> > > > > This has always been an issue for the low level networking
> > > > > permission checks that may happen outside of process context;
> > > > > unfortunately, "current" is still defined in that situation and
> > > > > thus avc_audit() cannot distinguish the cases where it has a
> > > > > relevant process context from these situations.  Options for
> > > > > fixing:
> > > > > - Have the callers of avc_has_perm() pass a flag (e.g. via
> > > > > avc_audit_data) when no relevant process context is available, and
> > > > > use that flag within avc_audit() to omit the comm= and pid=
> > > > > information and to pass a NULL audit_context to audit_log_start().
> > > > > - Have avc_audit() internally check for certain classes and
> > > > > permissions (e.g. SECCLASS_PACKET, SECCLASS_PEER, SECCLASS_NETIF,
> > > > > SECCLASS_NODE) known to have this behavior, and likewise omit the
> > > > > comm= and pid= information and pass a NULL context to
> > > > > audit_log_start() in that case. Concern with this approach is that
> > > > > a given class/permission may be used from multiple call sites, some
> > > > > of which may have a valid process context and some of which may
> > > > > not.
> > > >
> > > > For the reasons that Stephen pointed out as well as a concern that it
> > > > would be harder to maintain (we would likely forget to add new
> > > > classes in the future should they arise) I vote for the first
> > > > flag-passing approach.  It should be a relatively small patch; if I
> > > > don't hear any objections I'll start working on it on in the next day
> > > > or two ... I would think we should be able to still get this into
> > > > 2.6.30.
> > >
> > > Thanks, Paul - sounds good.  One further observation here:  in the
> > > past, I only recall seeing this issue crop up on recv-side checking,
> > > not the send-side checking, as most sends happen while still in the
> > > process context of the sender.  I guess what we are seeing here is TCP
> > > re-transmit.  Unfortunately, I don't think that we can distinguish the
> > > cases from our hooks for the packet send checks, and thus we may end up
> > > losing audit information (both at the avc level and at the syscall
> > > audit record level) about the sending process even when that
> > > information would in fact be accurate.
>
> If we still want to do this we would likely need to trim the process
> information (i.e. pid and comm) for everything lower than the socket layer
> which in the case of outgoing packets is pretty much everything.
>
> > ...which might be why we have never "fixed" this behavior.  While the
> > information is unreliable, it is sometimes correct and can be helpful in
> > diagnosing network policy denials.  Depends on what is more important -
> > complete accuracy in the avc denials (although the comm field is
> > inherently unreliable, of course) or providing as much information as
> > possible to debug avc denials.
>
> That is a tough call, and I think the "correct" answer will depend on who
> you ask.
>
> > A simple heuristic would be to check whether the scontext matches the
> > context of the process, i.e. (current_sid() == ssid).  That will
> > eliminate some of the noise but not all of it, and it might suppress
> > auditing of the pid/comm information on some checks that happen in
> > process context but don't take the current task SID as the source.
>
> Although this runs into issues of losing information when the sender
> changes the label of the originating socket (I assume you are talking about
> comparing the socket/packet's SID with current_sid()) and I don't think
> anyone wants to lose audit records.
>
> I thought netfilter had a way to filter packets based on PID, I need to go
> check on that as we could probably use the same mechanism ...

Never mind, looks like that functionality no longer exists ...

static bool owner_mt_check_v0(const struct xt_mtchk_param *par)
{
        const struct ipt_owner_info *info = par->matchinfo;

        if (info->match & (IPT_OWNER_PID | IPT_OWNER_SID | IPT_OWNER_COMM)) {
                printk(KERN_WARNING KBUILD_MODNAME
                       ": PID, SID and command matching is not "
                       "supported anymore\n");
                return false;
        }

        return true;
}

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
