Subject: Re: secadm question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Jeremiah Jahn <jeremiah@goodinassociates.com>,
        selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200802151018.57712.paul.moore@hp.com>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
	 <200802150855.47722.paul.moore@hp.com>
	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>
	 <200802151018.57712.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 15 Feb 2008 10:27:32 -0500
Message-Id: <1203089252.16038.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-15 at 10:18 -0500, Paul Moore wrote:
> On Friday 15 February 2008 10:09:47 am Jeremiah Jahn wrote:
> > So if I change my build.conf to be mls I should be up and running.
> > I'm on RHEL5 btw
> 
> Yes, setting the TYPE to "mls" should enable the secadm_r role.  If you 
> don't need the latest Reference Policy, there is a MLS policy as part 
> of RHEL5 - it's what was used for the recent (okay, maybe not that 
> recent anymore) Common Criteria LSPP evaluations.

Using the -mls policy from RHEL5 is somewhat limiting as it excludes
various parts of the policy not covered by the evaluation (e.g. little
things like X Window System support).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
