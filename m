Message-ID: <1499866012.23108.3.camel@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux: Introduce a policy capability and
 permission for NNP transitions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 12 Jul 2017 09:26:52 -0400
In-Reply-To: <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
References: <20170710202553.20668-1-sds@tycho.nsa.gov>
 <CAHC9VhQ_uQid=iqetWk3mpehn82sts9NW6oeZzFk0Fq3Td7xFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-07-11 at 17:00 -0400, Paul Moore wrote:
> On Mon, Jul 10, 2017 at 4:25 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > As systemd ramps up enabling NoNewPrivileges (either explicitly in
> > service unit files or as a side effect of other security-related
> > settings in service unit files), we're increasingly running afoul
> > of
> > its interactions with SELinux...
> 
> We already talked about this in the other thread so I'll refrain from
> repeating myself.
> 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3a06afb..f0c11c2 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2326,24 +2326,37 @@ static int check_nnp_nosuid(const struct
> > linux_binprm *bprm,
> >                 return 0; /* No change in credentials */
> > 
> >         /*
> > -        * The only transitions we permit under NNP or nosuid
> > -        * are transitions to bounded SIDs, i.e. SIDs that are
> > -        * guaranteed to only be allowed a subset of the
> > permissions
> > -        * of the current SID.
> > +        * If the policy enables the nnp_transition policy
> > capability,
> > +        * then we permit transitions under NNP or nosuid if the
> > +        * policy explicitly allows nnp_transition permission
> > between
> > +        * the old and new contexts.
> >          */
> > -       rc = security_bounded_transition(old_tsec->sid, new_tsec-
> > >sid);
> > -       if (rc) {
> > +       if (selinux_policycap_nnptransition) {
> > +               rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
> > +                                 SECCLASS_PROCESS,
> > +                                 PROCESS__NNP_TRANSITION, NULL);
> > +               if (!rc)
> > +                       return 0;
> 
> This is interesting, we had been talking about domain transitions
> under NNP, but we never really discussed transitions under nosuid
> mounts, and the motivation for this patch appears to be entirely
> around NNP alone.

Yes, I decided to keep NNP and nosuid handling consistent.  Similar
arguments apply; the current restriction on SELinux transitions on
nosuid mounts forces users to make a choice between SELinux transitions
and nosuid mounts, which can leave them less protected.  That has been
a common issue e.g. for httpd transitions on cgi scripts and the like.

> I think the policycap/permission approach is reasonable, but I wonder
> if we should separate this into two permissions, e.g. process {
> nnp_transition nosuid_transition }, especially since such a change in
> the future would likely require another policycap?

I was hoping to avoid that and keep the nnp/nosuid handling consistent.
 Also, we are out of process permissions after nnp_transition, so we
can't do that without adding a process2 or similar class. Possibly we
could name the capability and permission more generally to make it
clearer that it affect both, but not sure what to suggest there
(nnpnosuid_transition?).
