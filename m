Message-ID: <1501249067.32334.8.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Cc: linux-audit@redhat.com, Eric Paris <eparis@redhat.com>, SElinux list
 <selinux@tycho.nsa.gov>
Date: Fri, 28 Jul 2017 09:37:47 -0400
In-Reply-To: <6418642.hManU9XiuR@x2>
References: <ce5219eaed412cc02caef75934b8c3b40087db83.1501158372.git.rgb@redhat.com>
 <6418642.hManU9XiuR@x2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: remove AVC init audit log message
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-07-28 at 09:11 -0400, Steve Grubb wrote:
> On Friday, July 28, 2017 3:23:31 AM EDT Richard Guy Briggs wrote:
> > In the process of normalizing audit log messages, it was noticed
> > that the
> > AVC initialization code registered an audit log KERNEL record that
> > didn't
> > fit the standard format.  In the process of attempting to normalize
> > it it
> > was determined that this record was not even necessary.  Remove it.
> 
> Actually, I'd probably go the other direction. I'd make it useful.
> How about a 
> AUDIT_MAC_INIT record that records, name of MAC framework, status
> (enabled/
> disabled), and enforcing mode (enforcing/permissive). This way if
> there is an 
> investigation that needs to know the initial system state, we have
> that 
> information preserved. There might be one or two other tidbits people
> might 
> want to know like policy version or number of overrides (booleans)
> deviating 
> from policy baseline. But I'd say that's nice to have and not
> mandatory.
> 
> I'm pretty sure that was the intent of the event and its probably to
> satisfy 
> one of the FMT_MSA.3 common criteria requirements about initial
> subject/object 
> security attribute association.

None of that is known in avc_init().  Aren't you already getting what
you need from AUDIT_MAC_STATUS and AUDIT_MAC_POLICY_LOAD?

> 
> -Steve
> 
> > Ref: http://marc.info/?l=selinux&m=149614868525826&w=2
> > See: https://github.com/linux-audit/audit-kernel/issues/48
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/selinux/avc.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index e60c79d..4b42931 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -197,8 +197,6 @@ void __init avc_init(void)
> >  	avc_xperms_data_cachep =
> > kmem_cache_create("avc_xperms_data",
> >  					sizeof(struct
> > extended_perms_data),
> >  					0, SLAB_PANIC, NULL);
> > -
> > -	audit_log(current->audit_context, GFP_KERNEL,
> > AUDIT_KERNEL, "AVC
> > INITIALIZED\n"); }
> > 
> >  int avc_get_hash_stats(char *page)
> 
> 
