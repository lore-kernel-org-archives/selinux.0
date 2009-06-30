Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5UMJ6pO015076
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 18:19:06 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5UMJgoV025708
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 22:19:42 GMT
Date: Wed, 1 Jul 2009 08:19:04 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov
Subject: Re: The problem with TUN/TAP devices
In-Reply-To: <200906301734.31986.paul.moore@hp.com>
Message-ID: <alpine.LRH.2.00.0907010817480.19282@tundra.namei.org>
References: <200906301734.31986.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 30 Jun 2009, Paul Moore wrote:

> So how do we fix it?  Well, there are a two options that I can think of right 
> now (feel free to add to the list):
> 
> 1. Set the sock's label/SID in sk_alloc()
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
> 
> Thoughts?

I'm not sure, but we probably need to include the netdev list in the 
discussion.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
