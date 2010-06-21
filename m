Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5LJDKjx010585
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2010 15:13:20 -0400
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5LJExpB028953
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2010 19:14:59 GMT
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
	by g1t0027.austin.hp.com (Postfix) with ESMTP id 4EDCA3898F
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2010 19:13:19 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
	by g1t0039.austin.hp.com (Postfix) with ESMTP id 429B334024
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2010 19:13:19 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 05262CF000B
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2010 13:13:19 -0600 (MDT)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7nWGPz+pOYA for <selinux@tycho.nsa.gov>;
	Mon, 21 Jun 2010 13:13:18 -0600 (MDT)
Received: from flek.localnet (squirrel.fc.hp.com [15.11.146.57])
	by ldl (Postfix) with ESMTP id C1908CF0008
	for <selinux@tycho.nsa.gov>; Mon, 21 Jun 2010 13:13:18 -0600 (MDT)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/6] SELinux UNIX domain socket fixes/cleanup
Date: Mon, 21 Jun 2010 15:13:17 -0400
References: <20100529214628.4042.88276.stgit@flek.lan> <201006211432.53781.paul.moore@hp.com>
In-Reply-To: <201006211432.53781.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201006211513.17495.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, June 21, 2010 02:32:53 pm Paul Moore wrote:
> On Saturday, May 29, 2010 05:53:16 pm Paul Moore wrote:
> > I finally got a chance to cobble together some tests to verify both
> > getpeercon() on the client end of a connected UNIX domain socket as well
> > as the proper operation of fsetxattr() on sockets.  I'm happy to report
> > that everything worked as I expected it to (UNIX sockets now behave like
> > INET sockets) and nothing exploded.  This latest version of the patchset
> > should include all the feedback I've received so far as well as my
> > sign-off on each patch so I think we should be in good shape at this
> > point.  As a result, I'm submitting these patches for whatever kernel
> > release looks most appropriate - maybe to late for .35, but you might
> > be able to make a weak argument that some of the patches are
> > bugfixes - regardless, I'll let you guys make that call; as long as
> > they go somewhere I'll be happy.
> > 
> > For those of you using git, you can also find a copy of the patches at
> > the URL below.
> > 
> >  * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing
> 
> Just a quick follow-up for the archives ... James has merged patches 2
> through 6 with patch 1 being intentionally excluded due to concerns from
> Stephan Smalley over the potential race conditions described in the
> comments.

My apologies, that would be _Stephen_ Smalley and not his evil twin Stephan ;)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
