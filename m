Subject: Re: secadm question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1203088187.3669.241.camel@bluejay.goodinassociates.com>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
	 <200802150855.47722.paul.moore@hp.com>
	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Fri, 15 Feb 2008 10:16:02 -0500
Message-Id: <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-15 at 09:09 -0600, Jeremiah Jahn wrote:
> So if I change my build.conf to be mls I should be up and running. I'm
> on RHEL5 btw

Chris - how hard would it be to make this a separate tunable so that
people who want a separate security admin can turn that on without
enabling MLS?

> On Fri, 2008-02-15 at 08:55 -0500, Paul Moore wrote:
> > On Thursday 14 February 2008 6:09:43 pm Jeremiah Jahn wrote:
> > > I see a number of places where the secadm_r role shows up, but It
> > > doesn't show up in the list of users and what not, Is there something
> > > simple I need to enable it, or 	do I need to build it from scratch?
> > > My goal it to have sysadm not able to modify policy enforcement, and
> > > my secadm not be able to do anything but. If there is a standard way
> > > to do this, I'd love to know.
> > 
> > I believe the secadm_r role is only defined for the "mls" policy builds; 
> > if you are running a "mcs" (the Fedora default) policy I don't think 
> > the secadm_r role is present.
> > 
> Boy, n.: A noise with dirt on it.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
