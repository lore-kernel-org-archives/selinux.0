Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NIks99003522
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 14:46:54 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NIkqsr025850
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 18:46:53 GMT
Date: Fri, 23 Mar 2007 14:46:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: Joy Latten <latten@austin.ibm.com>, David Miller <davem@davemloft.net>,
        selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        vyekkirala@TrustedCS.com
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
In-Reply-To: <1174628387.10788.53.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0703231441390.30602@d.namei>
References: <200703221835.l2MIZdDw007850@faith.austin.ibm.com>
 <20070322.120139.74735307.davem@davemloft.net>  <1174598630.3085.285.camel@faith.austin.ibm.com>
  <Line.LNX.4.64.0703221943110.24461@d.namei> <1174628387.10788.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Mar 2007, Eric Paris wrote:

> Maybe I'm way out on a limb here but if I am a regular user and I say
> rm /tmp/* and I only have permissions to delete some of the files I
> expect just those couple to be delete, not the whole operation denied.

I don't think this analogy holds up, as rm is a per-file deletion 
operation, and it is the shell which expands the wildcard for you.

A 'flush' has a semantic implication that all entries will be removed, and 
it should be atomic and either succeed or fail at that granularity.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
