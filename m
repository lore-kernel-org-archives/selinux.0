Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9OD0tWt014698
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 09:00:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9OD0gIS029669
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 13:00:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9OD0fDc029666
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 13:00:41 GMT
Subject: Re: [PATCH] checkpolicy/policy_scan.y
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031023210410.GA21631@wavehammer.waldi.eu.org>
References: <20031022175608.GB4531@hydra.joerghoh.de>
	 <1066847603.32228.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20031022190241.GA4671@hydra.joerghoh.de>
	 <1066855497.32228.150.camel@moss-spartans.epoch.ncsc.mil>
	 <20031022211407.GC4671@hydra.joerghoh.de>
	 <1066858032.32228.169.camel@moss-spartans.epoch.ncsc.mil>
	 <20031023210410.GA21631@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1067000452.4326.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Oct 2003 09:00:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-23 at 17:04, Bastian Blank wrote:
> On Wed, Oct 22, 2003 at 05:27:13PM -0400, Stephen Smalley wrote:
> > I've merged this patch with the ~0UL -> ~0U fix.
> 
> I just find out that this patch have unpredictable side effects. It uses
> integers of different size at the same time (op and roleop uses int,
> cexpr and cexpr_prim uses uintptr_t).
> 
> this should work on 32bit machines (big and little), but breaks if
> uintptr_t is larger than int, because accessing the int member only
> writes the corresponding 32bit. the attached sources demonstrates this
> problem.

Ok, so op and roleop need to be moved to <valptr> as well, with
corresponding changes to the rest of the code.  Remind me again as to
how this is any better than just using void* as in the original code?
And note that truncation will still ultimately occur when the values are
assigned to the fields of the constraint expression if they ever exceed
a 32bit value, as I've mentioned previously.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
