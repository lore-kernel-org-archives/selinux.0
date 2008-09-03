Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m83E6BjN019223
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 10:06:12 -0400
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m83E5ZFh003228
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 14:05:35 GMT
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 00/14] Labeled networking patches for 2.6.28
Date: Wed, 3 Sep 2008 10:05:59 -0400
References: <20080903003647.15669.45349.stgit@flek.lan>
In-Reply-To: <20080903003647.15669.45349.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200809031005.59102.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 02 September 2008 8:48:41 pm Paul Moore wrote:
> Since I'm reasonable certain there are no really nasty regressions,
> I've added sign-offs to all the patches now.  I expect there will
> probably be another spin or two to take care of bugs yet to be found
> and fix other various things that pop-up (maybe even the Smack stuff
> if I can find the time) but the patches are in reasonably good shape
> right now.  I also did a test merge/compile with the September 2nd
> linux-next tree and there were no nasty surprises so I'm also pushing
> these patches to my lblnet-2.6_next tree which means you should see
> them in tomorrow's linux-next tree if all goes well.

Just an FYI, it looks like I may have missed the cut for the September 
3rd linux-next tree.  The patches should be in there for tomorrow's 
tree.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
