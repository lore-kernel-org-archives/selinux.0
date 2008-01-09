From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: Q: SECMARK controls on forwarded packets
Date: Wed, 9 Jan 2008 15:48:10 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, cpebenito@tresys.com,
        vyekkirala@trustedcs.com
References: <200801082330.58907.paul.moore@hp.com> <Xine.LNX.4.64.0801100100590.9291@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0801100100590.9291@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801091548.10359.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 January 2008 9:04:43 am James Morris wrote:
> It'd be interesting to see what some fully worked network policy
> would look like ...

Everything below is based on the patches found here (the very observant 
will notice slight differences in permission ordering from previous 
mailing list patch postings):

 * http://git.infradead.org/?p=users/pcmoore/lblnet-2.6_testing

The following is an example of what permissions are needed for the 
various send/receive/forward network tasks using the "new and improved" 
network controls.  In addition, while policy is not ordered, I've 
ordered the allow rules in the order in which the kernel performs the 
access checks.  I've also left out the labeled IPsec SA polmatch checks 
since those are unchanged and add some noise to the rules below.

If anyone has any comments/problems/objections please speak up quickly 
so we can get everything straightened out as soon as possible.

 - basic subj/obj definitions

   socket_t  = socket's label
   peer_t    = peer label as determined by NetLabel and/or labeled IPsec
   secmark_t = secmark/iptables label
   netif_t   = network interface label
   node_t    = network address label

 - inbound locally consumed traffic permissions

   # is TOP_SECRET traffic allowed on this network?
   allow peer_t netif_t:netif ingress;
   allow peer_t node_t:node recvfrom;
   # is apache allowed to receive traffic from firefox?
   allow socket_t peer_t:peer recv;
   # is apache allowed to receive web traffic?
   allow socket_t secmark_t:packet recv;

 - outbound locally generated traffic permissions
   
   # is apache allowed to send web traffic?
   allow socket_t secmark_t:packet send;
   # is TOP_SECRET traffic allowed on this network?
   allow socket_t netif_t:netif egress;
   allow socket_t node_t:node sendto;

 - inbound forwaded traffic permissions

   # is TOP_SECRET traffic allowed on this network?   
   allow peer_t netif_t:netif ingress;
   allow peer_t node_t:node recvfrom;
   # is apache allowed to forward web traffic through this system?
   allow peer_t secmark_t:packet forward_in;

 - outbound forwarded traffic permissions

   # is apache allowed to forward web traffic through this system?
   allow peer_t secmark_t:packet forward_out;
   # is TOP_SECRET traffic allowed on this network?
   allow peer_t netif_t:netif egress;
   allow peer_t node_t:node sendto;

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
