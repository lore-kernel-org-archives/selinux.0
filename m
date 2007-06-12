Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <20070611222402.GA21593@sergelap.austin.ibm.com>
References: <20070611204336.GA30846@sergelap.austin.ibm.com>
	 <620792.60154.qm@web36608.mail.mud.yahoo.com>
	 <20070611222402.GA21593@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 07:43:24 -0400
Message-Id: <1181648604.17547.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-11 at 17:24 -0500, Serge E. Hallyn wrote:
> Quoting Casey Schaufler (casey@schaufler-ca.com):
> > 
> > --- "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > 
> > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > Extend SELinux to allow capabilities to be granted authoritatively.
> > > > Introduces a new cap_override access vector to indicate when the
> > > > secondary module (i.e. capability or dummy) check should be skipped.
> > > > Handle the new class gracefully even if the policy does not yet have
> > > > it defined.
> > > 
> > > Cool.
> > > 
> > > If we decide to have this take the place of the file capabilities i
> > > guess we're all set, but if both are going upstream, do you think
> > > CONFIG_SECURITY_FILE_CAPABILITIES and selinux should be mutually
> > > exclusive?
> > 
> > We're already living in a non-stacking LSM environment, so whatever
> > SELinux wants to do with capabilities is Stephen's affair, I suppose.
> > I assume that this is in preparation for file based capabilities
> 
> Well it arguably obviates the need for file based capabilities :)
> 
> Stephen, I assume the intent would be to simply assign capabilities to
> TE types, not to eventually add a new 'capability' field to the selinux
> context akin to the mls field?

Correct.  We were already authorizing the use of capabilities in SELinux
policy via e.g.:
	allow foo_t self:capability dac_override;

But the foo_t process had to already have obtained that capability in
the first place, e.g. by being invoked by a uid 0 process or by being
setuid root.  With this change, we can now add a second allow rule:
	allow foo_t self:cap_override dac_override;

if we want foo_t to be able to use that capability without ever having
been uid 0.  But we still have the choice of only granting the first
rule when we don't want this behavior, and only the first rule will ever
show up from audit2allow (due to the use of _noaudit) - the second one
will always be an explicit choice by a policy writer.

> That changes how one uses these a bit, in an interesting way.  Let's say
> we want users running ping to get CAP_NET_RAW.  If ping were then
> exploited to exec something else, then with capabilities it would lose
> CAP_NET_RAW.  How should (or should?) that be emulated in selinux?

SELinux already provides controls over what each domain can execute, so
that is simply a matter of preventing ping from executing other code in
SELinux policy, and/or defining domain transitions to less privileged
domains when ping does execute another program.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
