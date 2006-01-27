Subject: Re: Best method for obtaining the 'sid' of a task?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, SE-Linux <selinux@tycho.nsa.gov>,
   Linux Audit Discussion <linux-audit@redhat.com>
In-Reply-To: <1138390724.7916.21.camel@localhost>
References: <1138390724.7916.21.camel@localhost>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 15:23:17 -0500
Message-Id: <1138393397.13075.394.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-27 at 13:38 -0600, Timothy R. Chavez wrote:
> sending the correct sid.  Once the kernel receives this packet, it can
> then resolve the sid to the correct security label.  One of the pitfalls
> of this approach may be that the sid disappears because policy is
> reloaded while the packet is in transit.  Is this correct?

Yes, the SID could be invalidated by a policy reload, in which case
subsequent attempts to ask for its context will return the context of
the unlabeled SID.  Naturally, policy reload is a privileged operation.

> "What is the best way to do this?"
> 
> Because I am not exposed to: task_security_struct in net/af_netlink.c, I
> cannot simply do a:
> 
> if (current->security)
> 	NETLINK_CB(skb).selinux_sid = current->security->sid;
> 
> So I did a little digging and I thought perhaps the security hook,
> selinux_getprocattr(), could be modified such that I can pass into it
> &NETLINK_CB(skb).selinux_sid and obtain the 'sid' in addition to the
> context since we're already obtaining the sid there.  The disadvantage I
> see here, is that it changes the interface.  I'm not sure how sensitive
> people are to this.  Are there any alternative (possibly better)
> suggestions?

I'd tend to suggest a new interface for getting the current task SID and
an interface for mapping it to a context, and I'm not sure it even needs
to be LSM-based, given its specifity to SELinux for LSPP.  I wouldn't
call the field 'selinux_sid' however, and even sid may be confusing
(unfortunate overlap with session id).  secid may be better.

There are a couple of examples of SELinux exporting SID and context
information to other parts of the kernel.  One example is the ctx_sid
and ctx_str fields of xfrm_sec_ctx for the IPSEC work by Trent for the
SIDs associated with IPSEC SAs.  That does use LSM interfaces for its
purposes.  Another example are some experimental patches by James Morris
for iptables integration, which provide direct interfaces from SELinux
for getting socket SIDs and mapping between them and contexts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
