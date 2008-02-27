Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1REqWve004633
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 09:52:32 -0500
Received: from g1t0028.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1REqTDp019342
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 14:52:29 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: Speaking of networking...
Date: Wed, 27 Feb 2008 09:51:55 -0500
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
References: <Xine.LNX.4.64.0802280057060.14155@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0802280057060.14155@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802270951.55462.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 February 2008 9:01:31 am James Morris wrote:
> Any further thoughts on how to push the secmark integration forward?
>
> The secmark table patch should allow MAC rules to be administered
> independently, and I know there has been some demand for the new
> (well, now not so new) networking controls.

When I asked this question previously the one thing that came up was 
semanage integration/compatibility.  However, there didn't appear to be 
a consensus as to if that was a good idea because semanage has a rather 
simplistic view of local network controls due to the limitations of the 
legacy netif/node controls.

I'm with you in that I'd really like to see all of the distributions 
shift over to using secmark.  Beyond the normal performance improvement 
of moving to secmark, starting with 2.6.25 having both secmark and the 
new network_peer_controls capability enabled should result in a nice 
performance boost* over the legacy network controls.

* No, I don't have any numbers yet, but looking at the code should 
explain why.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
