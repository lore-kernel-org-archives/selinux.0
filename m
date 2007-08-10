Date: Fri, 10 Aug 2007 09:49:55 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
cc: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <46BB9B79.2070602@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0708100857170.25010@us.intercode.com.au>
References: <46BB9B79.2070602@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Aug 2007, Darrel Goeddel wrote:

> picture here: http://home.insightbb.com/~dgoeddel/networking/simple.png
> (when commenting, please refrain from belittling my artistic skills)

I think this looks good in terms of labeling via secmark, although it 
hides external labeling.

> - A new SECFILTER iptables module is in place to perform flow control
>   checks.  Just as we have used the expressiveness (either fine grained
>   or coarse grained - your choice) of iptables to define fallback labels
>   for packets based on their attributes, we want to be able to define
>   access check based on those attributes.  It is here where we can say
>   that only http_client_t can get to port 80 on this machine, or that
>   only a secret packet can leave the machine through the eth1 device.
>   The SECFILTER mechanism will be able to distinguish controls for
>   incoming, outgoing, and forwarded traffic.  In the absence of a
>   matching "target context" from SECFILTER, the secmark will be checked
>   against the unlabeled context (no SECFILTER - no label).  

This seems problematic.  The secmark model is currently based upon 
iptables rules being used to classify and label traffic, with access 
control performed within SELinux based upon those labels and permission 
types.  So, the access control decisions are performed via the AVC and 
according to SELinux policy.

In the case of local labeling, the packet is labeled based upon the port 
(and any other iptables selector), so you don't need to have a separate 
mechanism  i.e. the packet will only be labled as http_client_t if it's 
leaving via port 80 and also part of a validated connection.

Not sure what the answer is for applying controls to externally labeled 
packets.  It seems like a special case, though, and that typically, the 
network interface is the only thing you really want to check here.  If so, 
perhaps we implement a secmark (packet label) vs. netif check once 
external labeling has been applied.

So, the packet control permissions using secmark would be something like:

socket layer  : send, recv
network layer : flow_in, flow_forward, flow_out
link layer    : netif_in, netif_out

I think this will make sense to users due to the layering, and separation 
of labeling and access control.

The order of mediation is:

Inbound to local:
 
   netif_in -> flow_in -> recv

Forward:

   netif_in -> flow_forward -> netif_out

Outbound from local:

   send -> flow_out -> netif_out


Now, labeling is not so simple :-)

We have local labeling via secmark, which needs to be applied first and 
then potentially overridden.

Then we have two differnt forms of external labeling, with differing 
mechanisms and policy constructs.

For general and non-legacy users, we need to be focused on IPsec labeling.  

I'm not sure what the answer is for making it more usable at this stage, 
although if we don't make significant improvements, people will never use 
it.  Any bright ideas? :-)



- James 
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
