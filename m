Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JGpa5u004363
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 12:51:36 -0400
Received: by mail-lf0-f66.google.com with SMTP id t2-v6so527974lfd.6
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 09:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-4-peter.enderborg@sony.com>
 <CAHC9VhTULXGAjbRSeriXm6g=aQbaG6XcfXtROVoJr632yis=Gw@mail.gmail.com>
 <e66cad5399b741b8d5c06c8ea772c8b84caf1150.camel@perches.com>
In-Reply-To: <e66cad5399b741b8d5c06c8ea772c8b84caf1150.camel@perches.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 12:51:18 -0400
Message-ID: <CAHC9VhRPeSjtWE_HNhRQGZedtOsHKfPN0d=_yC9-n=HhAtkMrg@mail.gmail.com>
To: joe@perches.com
Cc: peter.enderborg@sony.com, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 danielj@mellanox.com, dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 03/13] selinux: Cleanup printk logging in
 policydb
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 19, 2018 at 12:45 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-06-19 at 12:41 -0400, Paul Moore wrote:
> > On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
> > <peter.enderborg@sony.com> wrote:
> > >
> > > Replace printk with pr_* to avoid checkpatch warnings and
> > > replace KERN_CONT with 2 longer prints.
> > >
> > > Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 91 +++++++++++++++++++++---------------------
> > >  1 file changed, 46 insertions(+), 45 deletions(-)
> >
> > Merged, thank you.  While removing the separate KERN_CONT message
> > introduces some duplication, I think that's the right thing to do.
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> []
> > > @@ -504,7 +504,7 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
> > >         struct hashtab_info info;
> > >
> > >         hashtab_stat(h, &info);
> > > -       printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
> > > +       pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
> > >                "longest chain length %d\n", hash_name, h->nel,
> > >                info.slots_used, h->size, info.max_chain_len);
> > >  }
> > > @@ -533,15 +533,17 @@ static int policydb_index(struct policydb *p)
> > >  {
> > >         int i, rc;
> > >
> > > -       printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
> > > -              p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
> > >         if (p->mls_enabled)
> > > -               printk(KERN_CONT ", %d sens, %d cats", p->p_levels.nprim,
> > > -                      p->p_cats.nprim);
> > > -       printk(KERN_CONT "\n");
> > > +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats",
> > > +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> > > +                        p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
> > > +       else
> > > +               pr_debug("SELinux:  %d users, %d roles, %d types, %d bools",
> > > +                        p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
> > > +                        p->p_bools.nprim);
>
> This lost the terminating newline on each pr_debug

Good catch.  I haven't pushed to selinux/next yet, and this is pretty
minor, so I'll just fix that up in the merge.

-- 
paul moore
www.paul-moore.com
