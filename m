Message-ID: <1349454393.16023.52.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [selinux-testsuite][PATCH] use auth_read_passwd only if defined
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jan Stancek <jstancek@redhat.com>, selinux@tycho.nsa.gov,
        jburke@redhat.com
Date: Fri, 05 Oct 2012 12:26:33 -0400
In-Reply-To: <20121005142753.GA29202@mail.hallyn.com>
References: 
	<4f49eed5e3ce75a790287d42688f7e83ca4689b1.1349434641.git.jstancek@redhat.com>
	 <20121005142753.GA29202@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-10-05 at 14:27 +0000, Serge E. Hallyn wrote:
> Quoting Jan Stancek (jstancek@redhat.com):
> > This interface doesn't exist on older distros, for example RHEL6.
> 
> Thanks, applied.
> 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  policy/test_global.te |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/policy/test_global.te b/policy/test_global.te
> > index b92cc1c..3891f6e 100644
> > --- a/policy/test_global.te
> > +++ b/policy/test_global.te
> > @@ -90,5 +90,7 @@ selinux_compute_relabel_context(testdomain)
> >  selinux_compute_user_contexts(testdomain)
> >  
> >  ifdef(`distro_redhat', `
> > -auth_read_passwd(testdomain)
> > +    ifdef(`auth_read_passwd', `
> > +        auth_read_passwd(testdomain)
> > +    ')
> >  ')

In that case, should we just dispense with the ifdef(`distro_redhat')
altogether?  Then it will get enabled for any distro with a policy that
defines that interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
