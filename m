Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <1181836985.17547.645.camel@moss-spartans.epoch.ncsc.mil>
References: <C296D9C6.23423%csellers@tresys.com>
	 <1181836512.17547.640.camel@moss-spartans.epoch.ncsc.mil>
	 <1181836985.17547.645.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 12:13:53 -0400
Message-Id: <1181837633.14725.56.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-14 at 12:03 -0400, Stephen Smalley wrote:
> On Thu, 2007-06-14 at 11:55 -0400, Stephen Smalley wrote:
> > On Thu, 2007-06-14 at 11:40 -0400, Chad Sellers wrote:
> > > On 6/12/07 9:32 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> > > 
> > > > On Mon, 2007-06-11 at 15:55 -0400, Stephen Smalley wrote:
> > > >> Extend SELinux to allow capabilities to be granted authoritatively.
> > > >> Introduces a new cap_override access vector to indicate when the
> > > >> secondary module (i.e. capability or dummy) check should be skipped.
> > > >> Handle the new class gracefully even if the policy does not yet have
> > > >> it defined.
> > > > 
> > > > Ah, I realized that this has the same issue in permissive mode as the
> > > > get_user_sids code - we don't want to arbitrarily allow these
> > > > dac_override permissions in permissive mode (otherwise setenforce 0
> > > > turns off DAC as well), so the following patch should be applied on top:
> > > > 
> > > > diff -u b/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > --- b/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -1424,7 +1424,7 @@
> > > > int rc;
> > > >  
> > > > rc = avc_has_perm_noaudit(sid, sid, SECCLASS_CAP_OVERRIDE,
> > > > -      CAP_TO_MASK(cap), 0, NULL);
> > > > +      CAP_TO_MASK(cap), AVC_STRICT, NULL);
> > > > if (rc) {
> > > > rc = secondary_ops->capable(tsk, cap);
> > > > if (rc)
> > > > 
> > > > I'll fold that into the base patch for submission.
> > > 
> > > This certainly makes the permissive case better than the original patch, but
> > > you're still opening up a new vector for escalation of privilege when
> > > SELinux access controls aren't enforcing. At the very least, policy authors
> > > are going to have to be really careful with this, as it's easy to shoot
> > > yourself in the foot in permissive. One example scenario of escalation:
> > > 
> > > A domain is granted cap_override:dac_override in policy. The system is
> > > running in permissive mode. In permissive mode, the only thing that protects
> > > the policy from being reloaded is DAC permissions, which the policy has
> > > granted the domain the ability to override. So, the domain loads a new
> > > policy which grants it cap_override:*. This means that in permissive
> > > dac_override can easily get you all capabilities. Also, note that the same
> > > scenario can be constructed without the original allow rule using a
> > > capability shedding scenario.
> > > 
> > > I realize that there are already other scenarios where a program can use
> > > dac_override to escalate to further capabilities. My point is that we seem
> > > to be opening up a new attack vector here.
> > 
> > Actually, we don't want the cap_overrides to take affect at all under
> > permissive mode, since permissive mode is generally about avoiding side
> > effects from SELinux permission checks and we lose any inter-domain
> > protection in permissive mode (thus unprivileged domain could take
> > control of domain with cap_overrides).  So we would need to restrict the
> > override logic to enforcing mode only.
> 
> Like so:
> 

This is certainly safer, but it is going to be surprising and make
permissive hard to use for testing. Basically - you would have to make
some executables setuid while developing policy in permissive and remove
setuid when you move to enforcing (unless I'm missing something). Or I
guess you could run the apps under a different uid so that it would
inherit the right capabilities, which introduces a whole other set of
side-effects.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
