Subject: Re: [patch] selinux: support 64-bit capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <20080207171626.GB10603@sergelap.ibm.com>
References: <1202401264.27371.258.camel@moss-spartans.epoch.ncsc.mil>
	 <20080207171626.GB10603@sergelap.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 12:30:22 -0500
Message-Id: <1202405422.27371.283.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-07 at 11:16 -0600, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > Fix SELinux to handle 64-bit capabilities correctly, and to catch
> > future extensions of capabilities beyond 64 bits to ensure that SELinux
> > is properly updated.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > ---
> > 
> >  security/selinux/hooks.c                     |   21 +++++++++++++++++++--
> >  security/selinux/include/av_perm_to_string.h |    3 +++
> >  security/selinux/include/av_permissions.h    |    3 +++
> >  security/selinux/include/class_to_string.h   |    1 +
> >  security/selinux/include/flask.h             |    1 +
> >  5 files changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e5ed075..ed5b69f 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1272,12 +1272,18 @@ static int task_has_perm(struct task_struct *tsk1,
> >  			    SECCLASS_PROCESS, perms, NULL);
> >  }
> > 
> > +#if CAP_LAST_CAP > 63
> > +#error Fix SELinux to handle capabilities > 63.
> > +#endif
> 
> I suppose it would be going too far to do something like:
> 
> #define SELINUX_LAST_CAP CAPABILITY2__MAC_ADMIN
> 
> #if (CAP_TO_INDEX(CAP_LAST_CAP) > 2) || (CAP_TO_MASK(CAP_LAST_CAP) > SELINUX_LAST_CAP)
> #warning Please teach selinux about capabilities between SELINUX_LAST_CAP+SECCLASS_CAPABILITY2 and CAP_LAST_CAP.
> #endif
> 
> ?

I don't think it is necessary, although adding a comment to capability.h
where it defines CAP_LAST_CAP to notify
linux-security-module@vger.kernel.org of additions would be reasonable
as a separate and independent patch from this one.

If someone does add a capability < 63 w/o updating SELinux, then what
will happen with the current code is that either:
a) SELinux will allow it due to the handle_unknown support in Fedora 8
and later, or
b) SELinux will deny it (or at least log a denial, if permissive) and
avc_audit will report the hex value of the mask along with the
capability value in the logs.

Neither of which will trip the BUG() case.  I only wanted the build
failure to catch the BUG() case up front for mainline, and then the
BUG() case can only fire upon a real kernel bug and/or an out-of-tree
kernel module that is introducing its own private capability
definitions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
