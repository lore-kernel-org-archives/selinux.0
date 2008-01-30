Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0U0i0SE016199
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 19:44:00 -0500
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0U0ht0I000433
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2008 00:43:56 GMT
Date: Wed, 30 Jan 2008 11:43:11 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
Subject: Re: [RFC] security: add iptables "security" table for MAC rules
In-Reply-To: <200801291237.37349.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0801301141120.11220@us.intercode.com.au>
References: <Xine.LNX.4.64.0801292230080.29814@us.intercode.com.au>
 <200801291237.37349.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Jan 2008, Paul Moore wrote:

> That seems reasonable.  By the way, this isn't really related, but is it 
> possible to change the NF_IP_PRI_SELINUX_* constants to NF_IP_PRI_SECURITY_* 
> for the sake of consistency or are those values already visible to userspace?  

They are visible to userspace, and included in glibc headers, but I don't 
see any userland use of them via google codesearch or know of a possible 
valid use.

> I suppose we could always rename them anyway and just add a #define for 
> compatibility ...

Yep, if you want to.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
