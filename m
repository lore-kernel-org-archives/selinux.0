Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0U2pN5B026481
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 21:51:23 -0500
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0U2pM0I002235
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2008 02:51:22 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] security: add iptables "security" table for MAC rules
Date: Tue, 29 Jan 2008 21:51:17 -0500
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        fedora-selinux-list@redhat.com
References: <Xine.LNX.4.64.0801292230080.29814@us.intercode.com.au> <200801291237.37349.paul.moore@hp.com> <Xine.LNX.4.64.0801301141120.11220@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0801301141120.11220@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801292151.18265.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 29 January 2008 7:43:11 pm James Morris wrote:
> On Tue, 29 Jan 2008, Paul Moore wrote:
> > That seems reasonable.  By the way, this isn't really related, but is it
> > possible to change the NF_IP_PRI_SELINUX_* constants to
> > NF_IP_PRI_SECURITY_* for the sake of consistency or are those values
> > already visible to userspace?
>
> They are visible to userspace, and included in glibc headers, but I don't
> see any userland use of them via google codesearch or know of a possible
> valid use.
>
> > I suppose we could always rename them anyway and just add a #define for
> > compatibility ...
>
> Yep, if you want to.

Hey, let's not forget I'm the guy that gets into arguments over names that 
span months :)  I think it's a worthwhile change, but only once we have a 
reason to do so.  In my mind this means either another user (not unlikely 
considering recent events) or something like you are proposing.  I'll keep my 
eyes peeled and throw a patch out when I see an opportunity.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
