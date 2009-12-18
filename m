Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBIINeOd022725
	for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2009 13:23:40 -0500
Received: from g5t0009.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBIIQ38B012897
	for <selinux@tycho.nsa.gov>; Fri, 18 Dec 2009 18:26:03 GMT
From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: [RFC PATCH v2] selinux: Fix security_compute_av() to not return unknown class errors when in permissive mode
Date: Fri, 18 Dec 2009 13:23:31 -0500
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, amworsley@gmail.com
References: <20091216221002.10808.67004.stgit@flek.lan> <43af0f430912171648y71483798nd335cb86397ffb64@mail.gmail.com>
In-Reply-To: <43af0f430912171648y71483798nd335cb86397ffb64@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912181323.31166.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 17 December 2009 07:48:13 pm Stephen Smalley wrote:
> On Wed, Dec 16, 2009 at 5:10 PM, Paul Moore <paul.moore@hp.com> wrote:
> > It is possible security_compute_av() to return -EINVAL, even when in
> > permissive mode, due to unknown object classes and SIDs.  This patch
> > fixes this by doing away with the return value for security_compute_av()
> > and treating unknown classes and SIDs as permission denials.
> >
> > NOTE: I've only tested this on Fedora/Rawhide using the standard policy,
> > so while I'm fairly confident there are no regressions in the common case
> > the error case hasn't been fully tested yet; I'm posting this to solicit
> > comments on the basic approach.
> >
> > Reported-by: Andrew Worsley <amworsley@gmail.com>
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > ---
> >  security/selinux/avc.c              |   11 +++--------
> >  security/selinux/include/security.h |    6 +++---
> >  security/selinux/ss/services.c      |   27 ++++++++++++++-------------
> >  3 files changed, 20 insertions(+), 24 deletions(-)
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index f2dde26..648a263 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -731,7 +731,6 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> >        struct avc_node *node;
> >        struct av_decision avd_entry, *avd;
> >        int rc = 0;
> > -       u32 denied;
> >
> >        BUG_ON(!requested);
> >
> > @@ -746,9 +745,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> >                else
> >                        avd = &avd_entry;
> >
> > -               rc = security_compute_av(ssid, tsid, tclass, requested,
> > avd); -               if (rc)
> > -                       goto out;
> > +               security_compute_av(ssid, tsid, tclass, requested, avd);
> >                rcu_read_lock();
> >                node = avc_insert(ssid, tsid, tclass, avd);
> >        } else {
> > @@ -757,9 +754,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
> >                avd = &node->ae.avd;
> >        }
> >
> > -       denied = requested & ~(avd->allowed);
> > -
> > -       if (denied) {
> > +       if (requested & ~(avd->allowed)) {
> >                if (flags & AVC_STRICT)
> >                        rc = -EACCES;
> >                else if (!selinux_enforcing || (avd->flags &
> > AVD_FLAGS_PERMISSIVE)) @@ -770,7 +765,7 @@ int avc_has_perm_noaudit(u32
> > ssid, u32 tsid, }
> >
> >        rcu_read_unlock();
> > -out:
> > +
> >        return rc;
> >  }
> >
> > diff --git a/security/selinux/include/security.h
> > b/security/selinux/include/security.h index 2553266..7dab870 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -96,9 +96,9 @@ struct av_decision {
> >  /* definitions of av_decision.flags */
> >  #define AVD_FLAGS_PERMISSIVE   0x0001
> >
> > -int security_compute_av(u32 ssid, u32 tsid,
> > -                       u16 tclass, u32 requested,
> > -                       struct av_decision *avd);
> > +void security_compute_av(u32 ssid, u32 tsid,
> > +                        u16 tclass, u32 requested,
> > +                        struct av_decision *avd);
> 
> requested argument can be dropped - a legacy of the security server
> interface support for partial computation of access vectors based on
> what was requested, obsoleted when the decided vector was dropped.

Good catch, saw it was used by functions called inside security_compute_av() 
and never bothered to follow it all the way down.  Fixed.

> >  int security_compute_av_user(u32 ssid, u32 tsid,
> >                             u16 tclass, u32 requested,
> > diff --git a/security/selinux/ss/services.c
> > b/security/selinux/ss/services.c index b3efae2..6e4904d 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -632,7 +632,7 @@ static int context_struct_compute_av(struct context
> > *scontext, avd->flags = 0;
> >
> >        if (unlikely(!tclass || tclass > policydb.p_classes.nprim)) {
> > -               if (printk_ratelimit())
> > +               if (!policydb.allow_unknown && printk_ratelimit())
> >                        printk(KERN_WARNING "SELinux:  Invalid class
> > %hu\n", tclass); return -EINVAL;
> >        }
> 
> I don't think this is correct, or the change to the allow_unknown
> handling later.  This function gets called both upon userspace access
> to /selinux/access for userspace object managers and by the kernel.
> We want to distinguish userspace passing an invalid class to the
> kernel (still an error even in the allow_unknown case, as the
> userspace AVC performs the mapping and deals with allow_unknown based
> on /selinux/deny_unknown) from the kernel not being able to map the
> class.

I was under the impression that we would want to do the same for both the 
kernel and userspace (I like consistency), but I understand your point.  
Fixed.

> > @@ -929,14 +929,12 @@ static int security_compute_av_core(u32 ssid,
> >  *
> >  * Compute a set of access vector decisions based on the
> >  * SID pair (@ssid, @tsid) for the permissions in @tclass.
> > - * Return -%EINVAL if any of the parameters are invalid or %0
> > - * if the access vector decisions were computed successfully.
> >  */
> > -int security_compute_av(u32 ssid,
> > -                       u32 tsid,
> > -                       u16 orig_tclass,
> > -                       u32 orig_requested,
> > -                       struct av_decision *avd)
> > +void security_compute_av(u32 ssid,
> > +                        u32 tsid,
> > +                        u16 orig_tclass,
> > +                        u32 orig_requested,
> > +                        struct av_decision *avd)
> >  {
> >        u16 tclass;
> >        u32 requested;
> > @@ -949,24 +947,27 @@ int security_compute_av(u32 ssid,
> >
> >        requested = unmap_perm(orig_tclass, orig_requested);
> >        tclass = unmap_class(orig_tclass);
> > -       if (unlikely(orig_tclass && !tclass)) {
> 
> Here we detect the specific case of a legitimate (non-zero) class
> value that could not be mapped to a policy value due to a lack of a
> definition in the policy, and handle it according to allow_unknown.

Fixed.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
