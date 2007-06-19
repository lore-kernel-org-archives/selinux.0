Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5JEEefp007951
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 10:14:40 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5JEEdif006961
	for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2007 14:14:39 GMT
Subject: Re: [PATCH 1/5] Use the netmsg initial SID for NetLabel connections
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070614200057.176682747@hp.com>
References: <20070614195502.420663549@hp.com>
	 <20070614200057.176682747@hp.com>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 14:13:02 +0000
Message-Id: <1182262382.4077.111.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-14 at 15:55 -0400, Paul Moore wrote:
> plain text document attachment (netlabel-netmsg_update)
> This patch changes the policy to use the netmsg initial SID as the "base"
> SID/context for NetLabel packets which only have MLS security attributes.
> Currently we use the unlabeled initial SID which makes it very difficult to
> distinquish between actual unlabeled packets and those packets which have MLS
> security attributes.

I've been thinking more about unifying the ipsec and netlabel interfaces
where possible, looking forward to when labeled ipsec is working.

However, I think the ipsec control will be with associations, so they'll
be protocol inspecific (from a policy perspective).  The question is do
we really care which protocol a labeled packet comes over?  If not we
can collapse the netlabel rules.  Since we already have the regular
networking controls that are protocol-aware, it seems ok to not care
about the protocol of a labeled packet.

Also interesting is that the current association controls have a sendto,
though that will eventually be dropped, so the unlabeled recvfrom will
have to include the sendto rule for now.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
