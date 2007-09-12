Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkatesh Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Paul Moore'" <paul.moore@hp.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "James Morris" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: RE: Networking Patch (outline)
Date: Wed, 12 Sep 2007 12:08:39 -0500
Message-ID: <001501c7f55f$908c4ac0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200709111531.37143.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Actually, postroute_last would be hit for each xfrm as well.
> > So, perhaps a separate LSM hook into say ip_output() ...
> 
> Yep, I'd say we even need to move the check farther down into 
> the call stack 
> to ip_finish_output2() or at least after the XFRM check in 
> ip_finish_output() 
> so we avoid problems with source NAT (see the check at the top of 
> ip_finish_output()).

Yep. That would be the correct location.

>  Sadly, using netfilter hooks doesn't 
> look like it will 
> work.
> 
> I think this is the current summary of what we think we need 
> in terms of new 
> hooks to do flow control, take a look and see if you agree.  
> The one thing I 
> still want to check is how the ipv6 portion of the stack 
> handles options; 
> it's a bit different than ipv4 for obvious reasons and I want 
> to make sure 
> our hook placement for ipv6 doesn't cause us any problems in 
> the future.
> 
>  * Inbound packets (flow in check)
>    - add to existing security_sock_rcv_skb() hook for locally consumed
>      packets
>    - new hook in ip[6]_forward_finish(), before the call to  
>      ip_forward_options() for ipv4, to catch packets not 
> destined for the
>      local machine

Actually, for forward, we may be able to get away with
using a netfilter hook, cuz, by this time the label,
and the true source address should be in place.

> 
>  * Outbound packets (flow out check)
>    - new hook in ip_finish_output()/ip6_output_finish() to 
> catch all outbound
>      packets, including forwarded packets on their way out

I will whip up a prototype patch and send it on in a day or two.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
