Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5R0TnB8006366
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 20:29:49 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5R0TlgW024576
	for <selinux@tycho.nsa.gov>; Tue, 27 Jun 2006 00:29:47 GMT
Date: Mon, 26 Jun 2006 20:29:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@tycho.nsa.gov, paul.moore@hp.com, eparis@redhat.com
Subject: Re: Labeled Networking Requirements and Design (formerly RE: [PATCH
 01/06] MLSXFRM: Granular IPSec associations for use in  MLS environments)
In-Reply-To: <44A0684D.9080904@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0606262004530.26545@d.namei>
References: <44A0684D.9080904@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Jun 2006, Venkat Yekkirala wrote:

> > What we need is a design rationale, some kind of detailed discussion of what
> > the user requirements are and what the plan is for implementing features to
> > meet these requirements.
> 
> The following is not extensive in a formal/theoretical sense, but hopefully
> addresses the need here.

This is great, thanks.  Exactly what was needed and much appreciated.

I think the interaction with secmark as you describe sounds good.

> 3. Patch for ITEM5 has already been done by Eric Paris and is being considered
>   for upstreaming.

This is in Linus' tree now.

> 5. Patch for ITEM7: TCS currently have no plans to design and implement this.
> 

(Datagram labeling)

I guess we'd probably use SCM_SECURITY for this (similar to 
IP_CMSG_PASSEC for receiving the label).

Is this enough support for user API support at the kernel level in terms 
of setting and getting labels?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
