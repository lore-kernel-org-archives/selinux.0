From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, luto@amacapital.net
Subject: Re: [RFC PATCH] selinux: prevent setting a security label on
 MNT_NOSUID applications
Date: Wed, 14 May 2014 17:00:04 -0400
Message-ID: <1904410.NyD4ciNI6n@sifl>
In-Reply-To: <537399A8.2000405@tycho.nsa.gov>
References: <20140514155807.32072.32113.stgit@localhost>
 <537399A8.2000405@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, May 14, 2014 09:18:35 AM Andy Lutomirski wrote:
> > On Wed, May 14, 2014 at 8:58 AM, Paul Moore <pmoore@redhat.com> wrote:
> >> We presently prevent processes from explicitly setting an arbitrary
> >> security label on new processes when NO_NEW_PRIVS is enabled; in an
> >> attempt for more consistency, this patch extends this to prevent
> >> setting an arbitrary label when the new application lives on a
> >> filesystem mounted with MNT_NOSUID.
> >> 
> >> Signed-off-by: Paul Moore <pmoore@redhat.com>
> >> CC: Andy Lutomirski <luto@amacapital.net>
> >> CC: Stephen Smalley <sds@tycho.nsa.gov>
> >> ---
> > 
> Acked-by: Andy Lutomirski <luto@amacapital.net>
>
> I'm also unconvinced by the subject line -- would "selinux: return an
> error when rejecting settexeccon on MNT_NOSUID applications" be
> better?

...

On Wednesday, May 14, 2014 12:28:24 PM Stephen Smalley wrote:
> On 05/14/2014 11:58 AM, Paul Moore wrote:
> > We presently prevent processes from explicitly setting an arbitrary
> > security label on new processes when NO_NEW_PRIVS is enabled; in an
> > attempt for more consistency, this patch extends this to prevent
> > setting an arbitrary label when the new application lives on a
> > filesystem mounted with MNT_NOSUID.
> 
> It is never arbitrary (the new value is always controlled by policy),
> and it isn't set on "new processes" per se but rather transitioned to
> upon an exec.  Anyway, the point of the change is to return an error
> rather than silently ignore any /proc/self/attr/exec value when
> executing from a nosuid mount.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

I had a feeling while writing the patch description yesterday that someone was 
not going to be happy with the text ... does the subject/description below 
sound better to you guys?

***
selinux: reject setexeccon() on MNT_NOSUID applications with -EACCES

We presently prevent processes from using setexecon() to set the security 
label of exec()'d processes when NO_NEW_PRIVS is enabled by returning an 
error; however, we silently ignore setexeccon() when exec()'ing from a nosuid 
mounted filesystem.  This patch makes things a bit more consistent by 
returning an error in the setexeccon()/nosuid case.
***

> > Signed-off-by: Paul Moore <pmoore@redhat.com>
> > CC: Andy Lutomirski <luto@amacapital.net>
> > CC: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> > 
> >  security/selinux/hooks.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 57b0b49..6fafe86 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2106,11 +2106,13 @@ static int selinux_bprm_set_creds(struct
> > linux_binprm *bprm)> 
> >  		new_tsec->exec_sid = 0;
> >  		
> >  		/*
> > 
> > -		 * Minimize confusion: if no_new_privs and a transition is
> > -		 * explicitly requested, then fail the exec.
> > +		 * Minimize confusion: if no_new_privs or nosuid and a
> > +		 * transition is explicitly requested, then fail the exec.
> > 
> >  		 */
> >  		
> >  		if (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS)
> >  		
> >  			return -EPERM;
> > 
> > +		if (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)
> > +			return -EACCES;
> > 
> >  	} else {
> >  	
> >  		/* Check for a default transition on this program. */
> >  		rc = security_transition_sid(old_tsec->sid, isec->sid,

-- 
paul moore
security and virtualization @ redhat
