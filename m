Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3K4HWt002399
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:04:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3K3uC7012806
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 20:03:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hA3K3tuw012803
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 20:03:55 GMT
Subject: Re: default policy package
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1067887630.24100.8.camel@metropolis.verbum.private>
References: <20031103114353.GC13273@vnl.com>
	 <20031103152920.GD29928@vnl.com>
	 <1067876334.21113.75.camel@moss-spartans.epoch.ncsc.mil>
	 <200311040348.39876.russell@coker.com.au>
	 <1067887630.24100.8.camel@metropolis.verbum.private>
Content-Type: text/plain
Message-Id: <1067889855.29084.17.camel@moss-huskies>
Mime-Version: 1.0
Date: 03 Nov 2003 15:04:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-03 at 14:27, Colin Walters wrote:
> On Mon, 2003-11-03 at 11:48, Russell Coker wrote:
> 
> > Thanks for that reference, I have run check-all and fixed bugs in my policy 
> > tree related to updfstab, kudzu, and netsaint.  Colin, I have found what 
> > appears to be a minor bug in check-all, I get the following error related to 
> > mount:
> > 
> > Testing authbind.te...
> > Testing authbind.te...success.
> > make[1]: *** No rule to make target `presymlink/mount.te', needed by 
> > `presymlink/automount.te'.  Stop.
> 
> This is due to the fact that automount.te has a Depends: mount.te, but
> this is unnecessary since mount.te is included in the core
> (non-optional) policy.  Deleting that Depends: line should make it work.
> I'll try to come up with a patch soonish to make Depends: on core policy
> work though.

The Depends line has been fixed for a while (at least since the last
release) in the example policy at nsa.gov.  I've been using make
check-all for a while.  It's very useful, but it has some strange
behaviors.  I've noticed that often I can run check-all on a broken
policy and it will run fine.  Running it a second or third time will
cause the error to be generated.  Running make checkunused/file.te seems
to work in a more deterministic way.  I haven't had a chance to try and
track down the problem with check-all though.

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Office of Defensive Computing Research
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
