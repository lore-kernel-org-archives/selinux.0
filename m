Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBHNScho006152
	for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2009 18:28:38 -0500
Received: from g4t0016.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBHNRPfY000145
	for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2009 23:27:25 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v2] selinux: Fix security_compute_av() to not return unknown class errors when in permissive mode
Date: Thu, 17 Dec 2009 18:28:33 -0500
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
        amworsley@gmail.com
References: <20091216221002.10808.67004.stgit@flek.lan> <alpine.LRH.2.00.0912171845380.2193@tundra.namei.org>
In-Reply-To: <alpine.LRH.2.00.0912171845380.2193@tundra.namei.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912171828.33410.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 17 December 2009 02:59:29 am James Morris wrote:
> On Wed, 16 Dec 2009, Paul Moore wrote:
> > It is possible security_compute_av() to return -EINVAL, even when in
> > permissive mode, due to unknown object classes and SIDs.  This patch
> > fixes this by doing away with the return value for security_compute_av()
> > and treating unknown classes and SIDs as permission denials.
> >
> > NOTE: I've only tested this on Fedora/Rawhide using the standard policy,
> > so while I'm fairly confident there are no regressions in the common case
> > the error case hasn't been fully tested yet; I'm posting this to solicit
> > comments on the basic approach.
> 
> Looks ok to me.

Me too.  I tested today with a hacked Fedora/Rawhide policy that didn't have 
the tun_socket class; it worked as expected both when set to allow and deny 
unknown classes.  As far as I'm concerned you can feel free to merge this 
patch when appropriate.

Andrew, I'll make sure this applies cleanly to 2.6.32 tomorrow, if not I'll 
send you a backported patch.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
