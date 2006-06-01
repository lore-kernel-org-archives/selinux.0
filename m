Subject: Re: [PATCH] fix masking of capabilities over netlink in permissive
	mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@redhat.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
In-Reply-To: <447EF602.5080003@trustedcs.com>
References: <447DD3D7.4050200@trustedcs.com>
	 <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>
	 <447EF602.5080003@trustedcs.com>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 10:31:01 -0400
Message-Id: <1149172261.524.370.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-01 at 09:13 -0500, Darrel Goeddel wrote:
> Stephen Smalley wrote:
> > On Wed, 2006-05-31 at 12:35 -0500, Darrel Goeddel wrote:
> > 
> >>I think I ran across the problem described in this thread:
> >>
> >>http://www.redhat.com/archives/linux-audit/2006-May/msg00059.html
> >>
> >>The process' effective capabilities are always being masked with the
> >>allowed vector of the avc decision (for self against the capability
> >>security class) in netlink's copy of the process capabilities (eff_cap).
> >>The allowed vector takes on a slightly different role when SELinux
> >>is not in enforcing mode - it starts to track used-but-not-normally-
> >>permitted actions in the allowed vector.  That is what is causing
> >>the first attempt to fail (the allowed vector has not been "inflated")
> >>and the following attempts to succeed (the vector has been inflated in
> >>response to its previous use).  Does my reasoning (and patch) seem to
> >>be on track?
> > 
> > 
> > Alternative:  Since the sending task SID is now saved in the netlink
> > control buffer, we could move the netlink checking entirely to the
> > receive side, and perform a normal avc_has_perm() check, via
> > task_has_capability, with corresponding auditing of netlink denials.
> > Similarly for audit_netlink_ok.  We couldn't do that in the past because
> > the sender SID wasn't available to us on the receive side.
> 
> Good idea - I forgot about the sid being there now.  That approach would
> have the benefit of actually getting the AVC denials for capability checks
> that occur "over netlink".  However, this would involve replacing all of the
> checks using eff_cap (thankfully not very many) with new lsm hook(s).  This
> also will provide better encapsulation for the capability system.  I was
> hoping that this simple patch would have a shot at making the release
> of 2.6.17 to at least address the current problem.

If we think it is warranted, we can push up the simple patch now and
then proceed with the more general fix later.  But I wasn't clear that
the current behavior is a major problem, as it only affects permissive
mode operation.   

>   I can work up patches
> that creates the new lsm hook to replace the current instances of
> cap_raised(eff_cap) and move the SELinux checking into that hook.  Would
> a single security_netlink_capable(struct netlink_skb_params) hook suffice,
> or would decomposition of the the actual actions be preferred
> (and acceptable)?

Possibly generalize the existing security_netlink_recv() hook to also
take a capability to check as an argument, and then pass CAP_NET_ADMIN
from the net callers and CAP_AUDIT_xxx from audit_netlink_ok.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
