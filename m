Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2N0usK0008294
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 20:56:54 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2N0uqtM000348
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 00:56:53 GMT
Date: Thu, 22 Mar 2007 20:56:50 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Joy Latten <latten@austin.ibm.com>
cc: David Miller <davem@davemloft.net>, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, vyekkirala@TrustedCS.com
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
In-Reply-To: <1174607451.3085.290.camel@faith.austin.ibm.com>
Message-ID: <Line.LNX.4.64.0703222056080.25271@d.namei>
References: <200703221835.l2MIZdDw007850@faith.austin.ibm.com>
 <20070322.120139.74735307.davem@davemloft.net>  <1174598630.3085.285.camel@faith.austin.ibm.com>
  <Line.LNX.4.64.0703221943110.24461@d.namei> <1174607451.3085.290.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Mar 2007, Joy Latten wrote:

> > Perhaps a better semantic would be to fail the entire flush operation if 
> > one of the security checks failed.  e.g. loop through for permissions 
> > first, then if all ok, loop through for deletion.
> > 
> Ok, will code this up and test it if there are no objections.

I'd suggest making the permission loop a noop if CONFIG_SECURITY=n, via a 
static inline function.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
