Subject: Re: [PATCH 2/3] SELinux: call capabilities code directory
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1234274798.4642.24.camel@localhost.localdomain>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
	 <20090209213719.9537.98143.stgit@paris.rdu.redhat.com>
	 <1234274798.4642.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 09:30:41 -0500
Message-Id: <1234276241.3724.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-02-10 at 09:06 -0500, Stephen Smalley wrote:
> On Mon, 2009-02-09 at 16:37 -0500, Eric Paris wrote:
> > For cleanliness and efficiency remove all calls to secondary-> and instead
> > call capabilities code directly.  capabilities are the only module that
> > selinux stacks with and so the code should not indicate that other stacking
> > might be possible.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> > 
> >  security/selinux/hooks.c |   28 ++++++++++++++--------------
> >  1 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6e6847d..e2bdb28 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2087,7 +2087,7 @@ static int selinux_syslog(int type)
> >   * mapping. 0 means there is enough memory for the allocation to
> >   * succeed and -ENOMEM implies there is not.
> >   *
> > - * Note that secondary_ops->capable and task_has_perm_noaudit return 0
> > + * Note that cap_capable and task_has_perm_noaudit return 0
> 
> This part of the comment is a bit out of date - at this point we are
> just calling selinux_capable(...SECURITY_CAP_NOAUDIT) rather than
> separately calling cap_capable() and task_has_perm_noaudit().

version 2 will redo the comment completely.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
