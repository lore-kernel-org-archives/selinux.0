Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA12090
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 09:54:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA20914
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 14:52:08 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA20910
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 14:52:08 GMT
Date: Fri, 6 Dec 2002 09:53:38 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Chris Vance <cvance@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: new policy
In-Reply-To: <200212061426.07762.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0212060928110.27194-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Dec 2002, Russell Coker wrote:

> Which are the pieces of policy that have no logical connection?
>

  The fact that I want to place hwclock in it's own domain has no
relationship to the fact that I have RPM in it's own domain, or an RPM
policy for that matter. hwclock, the program, is independent of RPM
programs, is it not? Or is there an interaction between the hwclock_t
domain and the rpm_t domain that I am missing?

 > Where exactly is the data-as-metadata issue?

  Using the fact that rpm.te exists to say "this is a RedHat system" in
order to conditionally build the policy. I can have RPM on Slackware, for
example. Or I might have hwclock on a non-RedHat system. I don't see the
reason to conditionally include the hwclock policy piece based on the fact
that we've included the RPM policy piece. rpm.te is data for the policy,
not an indicator as to the nature of the OS distribution.

> Sure you could remove dpkg.te from the CVS.  But that wouldn't make the
> distributed policy RH only.  There's policy for many daemons in there that I
> wrote which has not been greatly tested under RH.  Someone would have to
> spend some serious amounts of effort testing and analysing the policy to
> determine which bits are Debian specific.
>

  Yes, there are many things shared between Debian and RedHat, and this is
not an simple problem to solve. We could have the RedHat policy, and the
Debian policy in a separate tree that is derived from that, but then we
have all kinds of issues with updating both, etc. We could have a single
policy, with checks during the build to include only those pieces as
necessary, but having those checks WITHIN the policy files is bad, in my
opinion.  Or we could just "build everything"; it is an example policy,
remember, and any serious use of SELinux needs a custom policy anyway.

  The issue goes beyond Debian-RedHat. It is possible that portions of the
policy written for RedHat 7.3 do not apply to RedHat 8.0.

  I'm porting SELinux and the policy over to a Slackware system for
another project, and need to strip to policy down to exactly what I
need. I suspect I'll have to remove some of the if(rpm.te) type rules in
order to build what I want.

 > What do you think of Brian's work on XML for policy?

  I haven't looked at it.  Does it solve the issues we are dealing with
here, or is it just a representation of policy in an XML form?

-- 
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
