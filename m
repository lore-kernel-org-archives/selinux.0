Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JF23Tl012270
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 11:02:03 -0400
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5JF21D6023496
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 15:02:01 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 1/5] Use the netmsg initial SID for NetLabel connections
Date: Tue, 19 Jun 2007 11:01:50 -0400
Cc: selinux@tycho.nsa.gov
References: <20070614195502.420663549@hp.com> <20070614200057.176682747@hp.com> <1182262382.4077.111.camel@gorn>
In-Reply-To: <1182262382.4077.111.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706191101.51123.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 19 June 2007 10:13:02 am Christopher J. PeBenito wrote:
> On Thu, 2007-06-14 at 15:55 -0400, Paul Moore wrote:
> > plain text document attachment (netlabel-netmsg_update)
> > This patch changes the policy to use the netmsg initial SID as the "base"
> > SID/context for NetLabel packets which only have MLS security attributes.
> > Currently we use the unlabeled initial SID which makes it very difficult
> > to distinquish between actual unlabeled packets and those packets which
> > have MLS security attributes.
>
> I've been thinking more about unifying the ipsec and netlabel interfaces
> where possible, looking forward to when labeled ipsec is working.
>
> However, I think the ipsec control will be with associations, so they'll
> be protocol inspecific (from a policy perspective).  The question is do
> we really care which protocol a labeled packet comes over?

I assume by protocol you mean UDP, TCP, etc. and not labeled IPsec, CIPSO, 
etc. ?

If that is the case NetLabel/CIPSO does care about the upper layer transport 
protocol because the permissions are based around the different socket 
classes.  Labeled IPsec doesn't have this level of granularity so that camp 
most likely doesn't care.

If we are talking about labeling protocols, I'm not sure we care how a 
packet/connection/SA is labeled as long as it is labeled.  For example, I'm 
okay with having the following policy interfaces (or something similar):

 corenet_{tcp,udp,raw,etc}_recv_labeled
 corenet_{tcp,udp,raw,etc}_send_labeled
 corenet_{tcp,udp,raw,etc}_recv_unlabeled
 corenet_{tcp,udp,raw,etc}_send_unlabeled

This is what I was trying to get at earlier with my RFC patch questions, 
perhaps I just worded it poorly.

> If not we 
> can collapse the netlabel rules.  Since we already have the regular
> networking controls that are protocol-aware, it seems ok to not care
> about the protocol of a labeled packet.
>
> Also interesting is that the current association controls have a sendto,
> though that will eventually be dropped, so the unlabeled recvfrom will
> have to include the sendto rule for now.

Okay, I think I see what you are getting at but just so I'm clear can you give 
me a quick example?  This is a _very_ big patch (even though the changes are 
small, there are a lot of them) and I'd like to minimize the number of times 
I have to rewrite it ;)

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
