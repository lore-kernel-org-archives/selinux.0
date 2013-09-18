Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8II5QSJ011400
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2013 14:05:27 -0400
From: Paul Moore <pmoore@redhat.com>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: add Paul Moore as a SELinux maintainer
Date: Wed, 18 Sep 2013 14:05:17 -0400
Message-ID: <13288872.e4rikYWUTT@sifl>
In-Reply-To: <1379524979.3032.53.camel@localhost>
References: <20130918171403.24618.84645.stgit@localhost> <1379524979.3032.53.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, September 18, 2013 01:22:59 PM Eric Paris wrote:
> I do have comments about your tree itself.  Namely, you are doing the
> same wrong broken thing that James does.  Despite Linus telling him not
> to repeatedly.  You pulled in some completely random -rc release without
> a really good reason (-rc is better than totally random, but still, it's
> junk).
> 
> You should have your tree based on an actual release unless there is a
> really good reason not to.  If the person above you is going to have a
> merge conflict that is THEIR problem.  You can/should be nice and
> check/explain how to solve the conflict, but hiding merge conflicts
> below the higher level maintainer is wrong ...

Okay, makes sense to me.

> My opinion, you should start your tree as 3.11 and rebase everything in
> my tree onto yours.
> 
> git checkout -b master
> git reset --hard v3.11
> git rebase --onto master 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376
> 0b4bdb3573a86a88c829b9e4ad702859eb923e7e
> git push -f $REPO master:master
> 
> As soon as 3.12 releases merge it into your tree and keep running.  If
> there does end up being some actual requirement to merge James's tree or
> Linus' tree (aka patches you want to apply depend on patches in another
> tree) so be it, merge those changes.  But if the only reason to merge
> another tree is to solve a conflict yourself or to 'have the latest and
> greatest' don't do it.  Keep you tree based on a released 3.x as often
> as possible.

I believe everything should be fixed now, take a look and if I've messed 
something up again, let me know.

Thanks,
-Paul

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
