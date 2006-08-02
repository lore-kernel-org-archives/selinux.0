Subject: Re: [PATCH 2/6] netfilter integration take 2: add netfilter
	contexts package section
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154525790.16917.49.camel@moss-spartans.epoch.ncsc.mil>
References: <1154457788.31522.148.camel@sgc.columbia.tresys.com>
	 <1154525176.27457.40.camel@localhost.localdomain>
	 <1154525790.16917.49.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 10:02:24 -0400
Message-Id: <1154527344.27457.43.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 09:36 -0400, Stephen Smalley wrote:
> On Wed, 2006-08-02 at 09:26 -0400, Karl MacMillan wrote:
> > On Tue, 2006-08-01 at 14:43 -0400, Christopher J. PeBenito wrote:
> > > Add a section to the package for netfilter contexts.
> > > 
> > >  libsepol/include/sepol/module.h          |   10 ++
> > >  libsepol/include/sepol/policydb/module.h |    2
> > >  libsepol/src/module.c                    |  119 +++++++++++++++++++++++++++++++
> > >  3 files changed, 131 insertions(+)
> > > 
> > > diff --exclude .svn -purN trunk/libsepol/include/sepol/module.h netfilter-integration/libsepol/include/sepol/module.h
> > > --- trunk/libsepol/include/sepol/module.h	2006-07-03 10:42:01.031370000 -0400
> > > +++ netfilter-integration/libsepol/include/sepol/module.h	2006-07-14 11:15:32.923435000 -0400
> > > @@ -40,6 +40,16 @@ extern size_t sepol_module_package_get_u
> > >  extern int sepol_module_package_set_user_extra(sepol_module_package_t * p,
> > >  					       char *data, size_t len);
> > >  
> > > +extern char *sepol_module_package_get_netfilter_contexts(sepol_module_package_t
> > > +							 * p);
> > > +
> > 
> > No space in front of p -> *p.
> > 
> > > +extern size_t
> > > +sepol_module_package_get_netfilter_contexts_len(sepol_module_package_t * p);
> > > +
> > 
> > Same - this is all throughout. Otherwise fine.
> 
> That's an artifact of Lindent.  OTOH, if we stopped used typedef'd types
> and just used struct foo *p, I think it does the right thing.
> 

I thought that you were kidding when you suggested that before. It's
fine with me, but it will take a while to make the change.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
