Message-Id: <200212031526.KAA25860@moss-shockers.ncsc.mil>
Date: Tue, 3 Dec 2002 10:26:19 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: tcp_send errors
To: SELinux@tycho.nsa.gov, timothy@hallcomp.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I have the latest lsm (as per the NSA site) installed on a fresh RH8.0
> install and I am getting errors trying to forward packets through it. 
> Is there something I need to change in the policy to premit forwarding
> or is this just a RH8.0 problem not present in the 7.X versions? I do
> not have the exact errors since the ssh apparently isn't working
> properly, but they were tcp_send errors and I can provide those later.  
> 
> Also I have four interfaces and I'm thinking I remember there being a
> problem with more than two, so is this still a problem?

This should just be a policy configuration issue, and shouldn't be
different for RH8.0.  You need to allow the tcp_send permission
between the appropriate netmsg_* type and the appropriate netif_* type
in policy/types/network.te to forward the packet.  The example policy only 
defines types and contexts for eth[0-2], so you'll need to define additional 
types and contexts in policy/types/network.te and policy/net_contexts if you 
want to distinguish each interface in your policy.  Or, if you don't care
to use SELinux to separate the interfaces, you can remove all of the
eth[0-2] entries, in which case they will all map to netif_t for the
interface and netmsg_t for packets received on the interface.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
