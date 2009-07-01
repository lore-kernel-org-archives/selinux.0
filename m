Subject: Re: The problem with TUN/TAP devices
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200906301734.31986.paul.moore@hp.com>
References: <200906301734.31986.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 09:44:39 -0400
Message-Id: <1246455879.13464.144.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-30 at 17:34 -0400, Paul Moore wrote:
> Unfortunately we have a problem with the network access controls and TUN/TAP 
> devices.  The basic issue is that packets entering the stack via a TUN device, 
> e.g. QEMU/KVM guest instance operating with a bridged network configuration, 
> do not have a fully initialized sock associated with them.  I say "fully 
> initialized" because the basic initialization has been done (memory allocated, 
> initial values set to SECINITSID_UNLABELED, etc.) but the last step where we 
> assign the sock a label/SID never happens.  Why?  Because the TUN driver code 
> only calls sk_alloc() and nothing else in the TUN code paths finish the 
> SELinux sock setup.
> 
> Okay, so what?  Well, the problem is that the SELinux IP postrouting code 
> treats the packet's sock label (the one that is still set as unlabeled_t in 
> the TUN case) as the originating peer label; in short it looks like packets 
> sent from your QEMU/KVM instance are unlabeled_t instead of my_guest_t:s3.  
> Needless to say this is not ideal.
> 
> So how do we fix it?  Well, there are a two options that I can think of right 
> now (feel free to add to the list):
> 
> 1. Set the sock's label/SID in sk_alloc()

This seems to be the right choice; not sure why we didn't do it that way
in the first place (maybe we did in the original LSM patches, but it
fell out when the original networking hooks were rejected).

> 2. Introduce a new hook to set the label/SID of a sock and call it from
>    tun_set_iff()
> 
> The problem with #2 is that it introduces a new (basically TUN specific) hook 
> to do something silly.  Important, but still kinda silly.  The problem with #1 
> is that we currently set the sock's label/SID in selinux_socket_post_create() 
> and match it with the inode's label/SID which has the potential to get ugly (I 
> haven't verified all of those cases yet).  However, there may be an 
> alternative, call it #1a, where set label the sock in sk_alloc() and then use 
> the sock's label to set the inode's label in socket_post_create(); this should 
> solve the potential ugliness.

Wouldn't it be a bug if they didn't match?  So I'd add the sk_alloc()
hook, set the label/SID for the sock there, and remove the setting of
the sock label/SID from post_create.  And then just add a BUG_ON to
post_create to assert that the inode SID should be the same as the sock
SID and if they don't match something has gone wrong.

> 
> Thoughts?
> 
> There is also a somewhat related issue involving persistent TUN/TAP devices 
> but I'd like to resolve this before getting deeper into that problem.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
