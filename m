From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: Q: SECMARK controls on forwarded packets
Date: Wed, 9 Jan 2008 18:35:20 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, cpebenito@tresys.com,
        vyekkirala@TrustedCS.com
References: <200801082330.58907.paul.moore@hp.com> <Xine.LNX.4.64.0801100100590.9291@us.intercode.com.au> <200801091548.10359.paul.moore@hp.com>
In-Reply-To: <200801091548.10359.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801091835.20692.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 January 2008 3:48:10 pm Paul Moore wrote:
>  - inbound locally consumed traffic permissions
>
>    # is TOP_SECRET traffic allowed on this network?
>    allow peer_t netif_t:netif ingress;
>    allow peer_t node_t:node recvfrom;
>    # is apache allowed to receive traffic from firefox?
>    allow socket_t peer_t:peer recv;
>    # is apache allowed to receive web traffic?
>    allow socket_t secmark_t:packet recv;
>
>  - outbound locally generated traffic permissions
>
>    # is apache allowed to send web traffic?
>    allow socket_t secmark_t:packet send;
>    # is TOP_SECRET traffic allowed on this network?
>    allow socket_t netif_t:netif egress;
>    allow socket_t node_t:node sendto;
>
>  - inbound forwaded traffic permissions
>
>    # is TOP_SECRET traffic allowed on this network?
>    allow peer_t netif_t:netif ingress;
>    allow peer_t node_t:node recvfrom;
>    # is apache allowed to forward web traffic through this system?
>    allow peer_t secmark_t:packet forward_in;
>
>  - outbound forwarded traffic permissions
>
>    # is apache allowed to forward web traffic through this system?
>    allow peer_t secmark_t:packet forward_out;
>    # is TOP_SECRET traffic allowed on this network?
>    allow peer_t netif_t:netif egress;
>    allow peer_t node_t:node sendto;

While it doesn't have a big impact on policy, it's probably also worth 
mentioning that all of the above access checks are now dynamically 
enabled/disabled based on the presence of user configuration at 
runtime.  What this means is that if you have not configured NetLabel, 
labeled IPsec, or SECMARK all of the checks above will be skipped which 
should result in significantly less per-packet overhead in most cases.

For those of you who only make use of some of the labeled networking 
functionality, as you configure the system to use the labeled 
networking features you want, the relevant access checks are 
automatically enabled by the kernel.  For example, if you only have 
SECMARK configured you will only hit the following access checks:

 - inbound locally consumed traffic permissions

   allow socket_t secmark_t:packet recv;

 - outbound locally generated traffic permissions
   
   allow socket_t secmark_t:packet send;

 - inbound forwaded traffic permissions

   allow unlabeled_t secmark_t:packet forward_in;

 - outbound forwarded traffic permissions

   allow unlabeled_t secmark_t:packet forward_out;

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
