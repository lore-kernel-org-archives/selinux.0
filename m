Subject: Re: [PATCH] libselinux: grant permissions on deny in
	permissive	mode
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <461538F3.1000905@tycho.nsa.gov>
References: <4615339A.1060700@tycho.nsa.gov>
	 <1175794555.5711.78.camel@moss-spartans.epoch.ncsc.mil>
	 <461538F3.1000905@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 13:58:37 -0400
Message-Id: <1175795917.5711.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-05 at 13:59 -0400, Eamon Walsh wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-04-05 at 13:36 -0400, Eamon Walsh wrote:
> >> This patch duplicates the kernel behavior of granting permissions
> >> after a denial to avoid repeated AVC's.
> >>
> >> It required moving the avc_update_node static inline function further
> >> up in the file and changing its prototype.
> > 
> > Alternatively, in the userspace AVC case, you could just directly mutate
> > ae->avd.allowed in avc_has_perm_noaudit(), as:
> > 	ae->avd.allowed |= requested;
> > 
> > That is what the kernel AVC used to do before it was converted to RCU
> > (at which point we could no longer mutate entries in-place).  Much
> > simpler to do it the above way since you aren't likely to be using RCU
> > in the userspace AVC ;)
> 
> OK, will resubmit using that approach.
> 
> > 
> > You also need to reset the cache upon a setenforce 1 in this case just
> > like the kernel does so that you flush any cached permissions from
> > permissive mode when you enter enforcing mode.
> 
> Adding James to the cc list:
> 
> I'm having trouble with this because avc_ss_reset() takes a "seqno" 
> argument and the selnl_msg_policyload netlink structure provides a seqno 
> field, but the selnl_msg_setenforce does not, it just has the new mode.
> 
> Does this field need to be added to the message structure?

No.  Just call avc_ss_reset(0); just like the kernel does.  Hacky, but
it works ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
