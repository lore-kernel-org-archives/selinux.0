Date: Fri, 30 Jan 2009 08:44:07 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 13/13] selinux: remove secondary ops call to
 file_mprotect
In-Reply-To: <20090129165614.GA13082@us.ibm.com>
Message-ID: <alpine.LRH.1.10.0901300842080.28910@tundra.namei.org>
References: <1233201347-17568-5-git-send-email-jmorris@namei.org> <1233201347-17568-6-git-send-email-jmorris@namei.org> <1233201347-17568-7-git-send-email-jmorris@namei.org> <1233201347-17568-8-git-send-email-jmorris@namei.org> <1233201347-17568-9-git-send-email-jmorris@namei.org>
 <1233201347-17568-10-git-send-email-jmorris@namei.org> <1233201347-17568-11-git-send-email-jmorris@namei.org> <1233201347-17568-12-git-send-email-jmorris@namei.org> <1233201347-17568-13-git-send-email-jmorris@namei.org> <1233201347-17568-14-git-send-email-jmorris@namei.org>
 <20090129165614.GA13082@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Jan 2009, Serge E. Hallyn wrote:

> Quoting James Morris (jmorris@namei.org):
> > Remove secondary ops call to file_mprotect, which is
> > a noop in capabilities.
> > 
> 
> Wrong patch?

Ahh, older version of a wrongly described patch which ended up in the 
directory from where the patchset was sent (it's not in the local git 
repo).

> 
> > Signed-off-by: James Morris <jmorris@namei.org>
> > ---
> >  security/selinux/hooks.c |    6 ------
> >  1 files changed, 0 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7056570..99758ca 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3212,12 +3212,6 @@ static int selinux_dentry_open(struct file *file, const struct cred *cred)
> > 
> >  static int selinux_task_create(unsigned long clone_flags)
> >  {
> > -	int rc;
> > -
> > -	rc = secondary_ops->task_create(clone_flags);
> > -	if (rc)
> > -		return rc;
> > -
> >  	return current_has_perm(current, PROCESS__FORK);
> >  }
> > 
> > -- 
> > 1.6.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
