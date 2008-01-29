Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TKqtqE020006
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 15:52:55 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0TKqrSx013800
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 20:52:54 GMT
Date: Wed, 30 Jan 2008 07:51:55 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
Subject: Re: [RFC] security: add iptables "security" table for MAC rules
In-Reply-To: <200801291237.37349.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0801300750410.11074@us.intercode.com.au>
References: <Xine.LNX.4.64.0801292230080.29814@us.intercode.com.au>
 <200801291237.37349.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Jan 2008, Paul Moore wrote:

> I'm not sure if returning false and failing here is the best thing to do in 
> terms of backwards compatibility.  I think we need some grace period where we 
> print a warning message and still allow the operation; after some period of 
> time we can then remove the ability completely and force users to use the 
> new "security" table.

Currently, the patch allows the use of the mangle table, so it is 
backwards compatible.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
