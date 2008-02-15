Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FFJSLm023865
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 10:19:28 -0500
Received: from g1t0028.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FFJQ8Q011305
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 15:19:27 GMT
From: Paul Moore <paul.moore@hp.com>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Subject: Re: secadm question
Date: Fri, 15 Feb 2008 10:18:57 -0500
Cc: selinux <selinux@tycho.nsa.gov>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com> <200802150855.47722.paul.moore@hp.com> <1203088187.3669.241.camel@bluejay.goodinassociates.com>
In-Reply-To: <1203088187.3669.241.camel@bluejay.goodinassociates.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802151018.57712.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 15 February 2008 10:09:47 am Jeremiah Jahn wrote:
> So if I change my build.conf to be mls I should be up and running.
> I'm on RHEL5 btw

Yes, setting the TYPE to "mls" should enable the secadm_r role.  If you 
don't need the latest Reference Policy, there is a MLS policy as part 
of RHEL5 - it's what was used for the recent (okay, maybe not that 
recent anymore) Common Criteria LSPP evaluations.

> On Fri, 2008-02-15 at 08:55 -0500, Paul Moore wrote:
> > On Thursday 14 February 2008 6:09:43 pm Jeremiah Jahn wrote:
> > > I see a number of places where the secadm_r role shows up, but It
> > > doesn't show up in the list of users and what not, Is there
> > > something simple I need to enable it, or 	do I need to build it
> > > from scratch? My goal it to have sysadm not able to modify policy
> > > enforcement, and my secadm not be able to do anything but. If
> > > there is a standard way to do this, I'd love to know.
> >
> > I believe the secadm_r role is only defined for the "mls" policy
> > builds; if you are running a "mcs" (the Fedora default) policy I
> > don't think the secadm_r role is present.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
