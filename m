Subject: Re: [PATCH 1/4] selinux: add support for querying object classes
	and permissions from the running policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Antill <jantill@redhat.com>
Cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1179934928.23650.65.camel@code.and.org>
References: <1179925929721-git-send-email-cpebenito@tresys.com>
	 <11799259343624-git-send-email-cpebenito@tresys.com>
	 <1179934928.23650.65.camel@code.and.org>
Content-Type: text/plain
Date: Wed, 23 May 2007 17:25:47 +0000
Message-Id: <1179941147.10995.58.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-23 at 11:42 -0400, James Antill wrote:
> On Wed, 2007-05-23 at 09:12 -0400, Christopher J. PeBenito wrote:
> > 
> > +static int get_permissions_callback(void *k, void *d, void *args)
> > +{
> > +       struct perm_datum *datum = d;
> > +       char *name = k, **perms = args;
> > +       int value = datum->value - 1;
> > +
> > +       perms[value] = kstrdup(name, GFP_ATOMIC);
> > +       if (!perms[value])
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +int security_get_permissions(char *class, char ***perms, int *nperms)
> > +{
> [...]
> > +       *nperms = match->permissions.nprim;
> > +       *perms = kcalloc(*nperms, sizeof(*perms), GFP_ATOMIC);
> > +       if (!*perms)
> > +               goto out;
> > +
> > +       if (match->comdatum) {
> > +               rc = hashtab_map(match->comdatum->permissions.table,
> > +                               get_permissions_callback, *perms);
> > +               if (rc < 0)
> > +                       goto err;
> > +       }
> > +
> > +       rc = hashtab_map(match->permissions.table, get_permissions_callback,
> > +                       *perms);
> 
> 
>  So I'm probably just wasting your time out of ignorance here, but this
> looks really suspicious to me. Why don't you need to add in
> match->comdatum->permissions.nprim for the allocation?

match->permissions.nprim already includes
match->comdatum->permissions.nprim, see:

http://marc.info/?l=selinux&m=117517987105068&w=2

>  Also how is it
> guaranteed that one "datum->value - 1" won't be the same in both
> hashtabs? (if it isn't you've leaked memory).

If I understand what you're saying, then we would have a common
permission and a unique permission with the same value, which isn't
possible.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
