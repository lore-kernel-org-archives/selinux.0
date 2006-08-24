Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7OJbDo7027209
	for <selinux@tycho.nsa.gov>; Thu, 24 Aug 2006 15:37:13 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7OJadvU008516
	for <selinux@tycho.nsa.gov>; Thu, 24 Aug 2006 19:36:39 GMT
Date: Thu, 24 Aug 2006 15:37:07 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [PATCH 0/3] secid reconciliation-v01: Repost patchset with
 updates
In-Reply-To: <44EDE6EA.1090601@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0608241536130.15506@d.namei>
References: <44EDE6EA.1090601@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Aug 2006, Venkat Yekkirala wrote:

> The following are the changes included in this patchset since the previous
> post:
> 
> - Use SELinux transition rules instead of precedence when reconciling the
> secid's
>  making it flexible/policy-driven; xfrm secid would prevail by default.
> - Change the naming of access vector perms to flow_in and flow_out.
> - Make selinux_xfrm_sock_rcv_skb checks conditional on compat_net.
> - Switch selinux_inet_conn_request to use secmark; cipso is still allowed to
>  override secmark currently in this regard (will rely on Paul Moore at HP
>  to bring cipso into the reconciliation path).

I like these changes, but wondering why you haven't supplied code for the 
outbound case ?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
