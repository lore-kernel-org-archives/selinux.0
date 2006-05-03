Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jeremy Katz <katzj@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@redhat.com>, SELinux-dev@tresys.com,
        SE Linux <selinux@tycho.nsa.gov>, Paul Nasrat <pnasrat@redhat.com>,
        James Antill <jantill@redhat.com>
In-Reply-To: <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1146583639.32102.20.camel@orodruin.boston.redhat.com>
	 <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 03 May 2006 11:08:12 -0400
Message-Id: <1146668892.6723.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 12:26 -0400, Stephen Smalley wrote:
> On Tue, 2006-05-02 at 11:27 -0400, Jeremy Katz wrote:
> > Lots do.  On the order of as many packages as require users at least.
> > And I'd expect more over time (especially given policy around dbus and
> > the increasing reliance on dbus through the distribution).  Imagine a
> > world where every user you wanted to add had to have a separate package
> > to create the user first. 
> 
> I'm not sure these all require separate policy.  Ideally, we'd like to
> see greater use of the equivalence class concepts to limit the explosion
> in policy and not require per-application/per-package policy in so many
> cases.  There is a tradeoff here in least privilege vs. manageability.
> 

The other issue that I'm concerned with is how multiple policy types
will be supported including custom third-part policies. I know that Dan
has been pushing the concept that policies should be portable across
base policies, but I think that there is a limit to how far that can go.
Separate policy packages seem to handle this situation elegantly. So,
how is the MLS policy going to be handled?

Karl

-- 
Karl MacMillan
kmacmillan@tresys.com
http://www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
