Message-ID: <448F0B3C.20901@trustedcs.com>
Date: Tue, 13 Jun 2006 14:00:12 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@redhat.com>,
        "'SELinux List'" <SELinux@tycho.nsa.gov>, redhat-lspp@redhat.com
Subject: Re: [PATCH] fix masking of capabilities over netlink in permissive
 mode
References: <447DD3D7.4050200@trustedcs.com>	 <1149098096.524.241.camel@moss-spartans.epoch.ncsc.mil>	 <447EF602.5080003@trustedcs.com>	 <1149172261.524.370.camel@moss-spartans.epoch.ncsc.mil>	 <4480500E.10906@trustedcs.com> <1149262527.524.503.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1149262527.524.503.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-06-02 at 09:49 -0500, Darrel Goeddel wrote:
> 
>>Here's an attempt using the above approach.  What does everyone think?  The
>>only issue I can see is that there may be a possibility of getting some
>>incorrect audit information if many queued netlink messages are processed
>>at the same time.  The AVC message will include information about "current",
>>which may not be the sending process.  Stephen suggested that the AVC message
>>could be modified to include the pid from the netlink message instead of
>>information about current.  That would lead to an AVC message stating pid=XXX,
>>while the syscall message would state pid=YYY.  Anyone see a way to get correct
>>information, or at least suppress possibly incorrect information.
> 
> 
> Note that this could involve more than just the pid; it could be any of
> the information in the NETLINK_CB or even the NETLINK_CREDS, so it could
> also include loginuid and possibly uid info.  You can propagate that
> data to avc_audit by extending the avc audit data structure, and either
> have it log it instead of the current task info or have it log it as
> supplemental data in addition to the current task info.  You could
> further propagate it to syscall audit by setting those values in the
> audit context from the netlink information, but it isn't clear that is
> what you want and I don't think that gives you the full task information
> that is presently logged by audit_log_exit.
> 
> The other approach is to move all checking to send time, including
> audit_netlink_ok and equivalent checking by other netlink handlers,
> using a callback mechanism as proposed in patches by Chris Wright a long
> time ago.  I'm not sure what happened with those.  Then the current task
> info is valid for checking and for auditing

Looks like they just died...

http://marc.theaimsgroup.com/?l=linux-netdev&m=110819902809549&w=2
http://marc.theaimsgroup.com/?l=linux-netdev&m=110819906824642&w=2
http://marc.theaimsgroup.com/?l=linux-netdev&m=110819919430147&w=2
http://marc.theaimsgroup.com/?l=linux-netdev&m=110819926630794&w=2

Seems like a nice idea (wish it would have been completed and upstreamed...).
I have no idea how this fits into the current state of the kernel or what
may have been missing from the original implementation.  My limited knowledge
of netlink puts this approach out of my league for now (would be nice to learn
more about this in the future though).  I'd be happy to see this in the future.

>>  I really
>>like the idea of getting the AVC message because tracking down cases where
>>SELinux was denying CAP_AUDIT_XXX was a huge pain when userspace was starting to
>>become audit-aware...
> 
> 
> Yes, and the same applies for CAP_NET_ADMIN check by various netlink
> handlers - we don't get any audit messages presently since they are
> checked at receive time.
> 
> 
>>This patch encapsulates the usage of eff_cap (in netlink_skb_params) within
>>the lsm framework by extending security_netlink_recv to include a required
>>capability parameter and converting all direct usage of eff_caps outside
>>of the lsm modules to use the interface.  It also updates the SELinux
>>implementation of the security_netlink_send and security_netlink_recv
>>hooks to take advantage of the sid in the netlink_skb_params struct.
> 
> 
> The patch looks sane to me.  I'm not as concerned about the audit
> confusion because the portions relevant to policy will be correct (i.e.
> the SIDs/contexts).

I am also not really concerned about it.  Shall we give this a whirl in the
lspp kernel (since its users are currently exercising the problematic code
path) and include push it through the audit git tree if it works nicely?
Note that this would replace the band-aid patch that is currently included
in the lspp kernel.  Anyone object (or have a patch using the callback
method)?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
