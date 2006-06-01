Message-ID: <447EF602.5080003@trustedcs.com>
Date: Thu, 01 Jun 2006 09:13:22 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
Subject: Re: [PATCH] fix masking of capabilities over netlink in permissive
 mode
References: <447DD3D7.4050200@trustedcs.com> <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2006-05-31 at 12:35 -0500, Darrel Goeddel wrote:
> 
>>I think I ran across the problem described in this thread:
>>
>>http://www.redhat.com/archives/linux-audit/2006-May/msg00059.html
>>
>>The process' effective capabilities are always being masked with the
>>allowed vector of the avc decision (for self against the capability
>>security class) in netlink's copy of the process capabilities (eff_cap).
>>The allowed vector takes on a slightly different role when SELinux
>>is not in enforcing mode - it starts to track used-but-not-normally-
>>permitted actions in the allowed vector.  That is what is causing
>>the first attempt to fail (the allowed vector has not been "inflated")
>>and the following attempts to succeed (the vector has been inflated in
>>response to its previous use).  Does my reasoning (and patch) seem to
>>be on track?
> 
> 
> Alternative:  Since the sending task SID is now saved in the netlink
> control buffer, we could move the netlink checking entirely to the
> receive side, and perform a normal avc_has_perm() check, via
> task_has_capability, with corresponding auditing of netlink denials.
> Similarly for audit_netlink_ok.  We couldn't do that in the past because
> the sender SID wasn't available to us on the receive side.

Good idea - I forgot about the sid being there now.  That approach would
have the benefit of actually getting the AVC denials for capability checks
that occur "over netlink".  However, this would involve replacing all of the
checks using eff_cap (thankfully not very many) with new lsm hook(s).  This
also will provide better encapsulation for the capability system.  I was
hoping that this simple patch would have a shot at making the release
of 2.6.17 to at least address the current problem.  I can work up patches
that creates the new lsm hook to replace the current instances of
cap_raised(eff_cap) and move the SELinux checking into that hook.  Would
a single security_netlink_capable(struct netlink_skb_params) hook suffice,
or would decomposition of the the actual actions be preferred
(and acceptable)?

Thanks for the idea.

> 
>>This patch removes the masking of capabilities passed over netlink
>>socket when SELinux is in enforcing mode.
> 
> 
> I assume that you meant "permissive mode" above.
>

Yep, looks like I was in a hurry when I sent the mail...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
