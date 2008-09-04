Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84BiS0p010109
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 07:44:28 -0400
Received: from g1t0027.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m84BiSPx026971
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 11:44:28 GMT
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 00/14] Labeled networking patches for 2.6.28
Date: Thu, 4 Sep 2008 07:44:24 -0400
References: <20080903003647.15669.45349.stgit@flek.lan> <200809031005.59102.paul.moore@hp.com>
In-Reply-To: <200809031005.59102.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200809040744.24717.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 03 September 2008 10:05:59 am Paul Moore wrote:
> On Tuesday 02 September 2008 8:48:41 pm Paul Moore wrote:
> > Since I'm reasonable certain there are no really nasty regressions,
> > I've added sign-offs to all the patches now.  I expect there will
> > probably be another spin or two to take care of bugs yet to be
> > found and fix other various things that pop-up (maybe even the
> > Smack stuff if I can find the time) but the patches are in
> > reasonably good shape right now.  I also did a test merge/compile
> > with the September 2nd linux-next tree and there were no nasty
> > surprises so I'm also pushing these patches to my lblnet-2.6_next
> > tree which means you should see them in tomorrow's linux-next tree
> > if all goes well.
>
> Just an FYI, it looks like I may have missed the cut for the
> September 3rd linux-next tree.  The patches should be in there for
> tomorrow's tree.

... another quick update, I just verified that the patches are included 
in the September 4th linux-next tree so if you are feeling particularly 
adventurous you can try testing that tree as well (be warned, it will 
likely be much less stable than the lblnet-2.6_testing tree due to the 
high degree of flux).

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
