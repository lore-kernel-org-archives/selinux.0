From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: Networking Patch (outline)
Date: Wed, 12 Sep 2007 14:52:28 -0400
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "James Morris" <jmorris@namei.org>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
References: <001501c7f55f$908c4ac0$cc0a010a@tcssec.com>
In-Reply-To: <001501c7f55f$908c4ac0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121452.29012.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, September 12 2007 1:08:39 pm Venkatesh Yekkirala wrote:
> >  * Inbound packets (flow in check)
> >    - add to existing security_sock_rcv_skb() hook for locally consumed
> >      packets
> >    - new hook in ip[6]_forward_finish(), before the call to
> >      ip_forward_options() for ipv4, to catch packets not
> > destined for the
> >      local machine
>
> Actually, for forward, we may be able to get away with
> using a netfilter hook, cuz, by this time the label,
> and the true source address should be in place.

Great.  I was concerned about the packet having to back through the forward 
path if it matched a IPsec transform which resulted in a new address, but I 
imagine that would only affect the outbound check.

> >  * Outbound packets (flow out check)
> >    - new hook in ip_finish_output()/ip6_output_finish() to
> > catch all outbound
> >      packets, including forwarded packets on their way out
>
> I will whip up a prototype patch and send it on in a day or two.

Excellent.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
