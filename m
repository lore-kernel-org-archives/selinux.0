Subject: Re: secadm question
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203092070.3669.251.camel@bluejay.goodinassociates.com>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
	 <200802150855.47722.paul.moore@hp.com>
	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>
	 <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil>
	 <1203089944.13618.40.camel@gorn>
	 <1203091760.3669.249.camel@bluejay.goodinassociates.com>
	 <1203091792.13618.56.camel@gorn>
	 <1203092070.3669.251.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Fri, 15 Feb 2008 11:23:30 -0500
Message-Id: <1203092610.13618.58.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-15 at 10:14 -0600, Jeremiah Jahn wrote:
> true, but I thought there was a tunable/boolean the disabled all that
> for sysadm

No, there isn't.  It suffers the problems I discussed below.

> On Fri, 2008-02-15 at 11:09 -0500, Christopher J. PeBenito wrote:
> > On Fri, 2008-02-15 at 10:09 -0600, Jeremiah Jahn wrote:
> > > So for my purposes, to would probably be best to just make a secadm
> > > user/role and add follow most of the interface for the original secadm
> > > role?
> > 
> > You could do that, but it wouldn't stop sysadm from being able to do all
> > the secadm things too, defeating the purpose of having a secadm in the
> > first place :)
> > 
> > > On Fri, 2008-02-15 at 10:39 -0500, Christopher J. PeBenito wrote:
> > > > On Fri, 2008-02-15 at 10:16 -0500, Stephen Smalley wrote:
> > > > > On Fri, 2008-02-15 at 09:09 -0600, Jeremiah Jahn wrote:
> > > > > > So if I change my build.conf to be mls I should be up and running. I'm
> > > > > > on RHEL5 btw
> > > > > 
> > > > > Chris - how hard would it be to make this a separate tunable so that
> > > > > people who want a separate security admin can turn that on without
> > > > > enabling MLS?
> > > > 
> > > > Problematic.  The security admin pieces are nicely abstracted into an
> > > > interface.  However, the problem is that it has some typeattribute
> > > > statements, so we can't put that in a conditional.
> > > > 
> > > > There are two things that will eventually make this possible.  The plan
> > > > is to move roles into their own modules, and at that point you should be
> > > > able to just insert the secadm module.
> > > > 
> > > > > > On Fri, 2008-02-15 at 08:55 -0500, Paul Moore wrote:
> > > > > > > On Thursday 14 February 2008 6:09:43 pm Jeremiah Jahn wrote:
> > > > > > > > I see a number of places where the secadm_r role shows up, but It
> > > > > > > > doesn't show up in the list of users and what not, Is there something
> > > > > > > > simple I need to enable it, or 	do I need to build it from scratch?
> > > > > > > > My goal it to have sysadm not able to modify policy enforcement, and
> > > > > > > > my secadm not be able to do anything but. If there is a standard way
> > > > > > > > to do this, I'd love to know.
> > > > > > > 
> > > > > > > I believe the secadm_r role is only defined for the "mls" policy builds; 
> > > > > > > if you are running a "mcs" (the Fedora default) policy I don't think 
> > > > > > > the secadm_r role is present.
> > > > > > > 
> > > > > > Boy, n.: A noise with dirt on it.
> > > "Consequences, Schmonsequences, as long as I'm rich." -- "Ali Baba
> > > Bunny" [1957, Chuck Jones]
> First Law of Bicycling: No matter which way you ride, it's uphill and
> against the wind.
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
