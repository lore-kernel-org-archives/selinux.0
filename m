Subject: Re: [PATCH] fix masking of capabilities over netlink in permissive
	mode
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@redhat.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
In-Reply-To: <447DD3D7.4050200@trustedcs.com>
References: <447DD3D7.4050200@trustedcs.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 13:54:56 -0400
Message-Id: <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-31 at 12:35 -0500, Darrel Goeddel wrote:
> I think I ran across the problem described in this thread:
> 
> http://www.redhat.com/archives/linux-audit/2006-May/msg00059.html
> 
> The process' effective capabilities are always being masked with the
> allowed vector of the avc decision (for self against the capability
> security class) in netlink's copy of the process capabilities (eff_cap).
> The allowed vector takes on a slightly different role when SELinux
> is not in enforcing mode - it starts to track used-but-not-normally-
> permitted actions in the allowed vector.  That is what is causing
> the first attempt to fail (the allowed vector has not been "inflated")
> and the following attempts to succeed (the vector has been inflated in
> response to its previous use).  Does my reasoning (and patch) seem to
> be on track?

Alternative:  Since the sending task SID is now saved in the netlink
control buffer, we could move the netlink checking entirely to the
receive side, and perform a normal avc_has_perm() check, via
task_has_capability, with corresponding auditing of netlink denials.
Similarly for audit_netlink_ok.  We couldn't do that in the past because
the sender SID wasn't available to us on the receive side.

> This patch removes the masking of capabilities passed over netlink
> socket when SELinux is in enforcing mode.

I assume that you meant "permissive mode" above.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
