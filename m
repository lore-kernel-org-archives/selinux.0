Message-ID: <1512156017.5144.11.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <pmoore@redhat.com>, William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 01 Dec 2017 14:20:17 -0500
In-Reply-To: <CAGH-Kgtzi_P9ZCLEd2_-6y4kn0eA6EHBA3OVvV=64czxUjRQQQ@mail.gmail.com>
References: <151206074183.32567.881282052709289967.stgit@chester>
 <CAFftDdp34FQf45OEx+2AaVE62Y=imG2SstMySR9tN__=yoec4g@mail.gmail.com>
 <CAGH-Kgtzi_P9ZCLEd2_-6y4kn0eA6EHBA3OVvV=64czxUjRQQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: ensure the context is NULL terminated in
 security_context_to_sid_core()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-12-01 at 10:34 -0500, Paul Moore wrote:
> On Thu, Nov 30, 2017 at 6:44 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Thu, Nov 30, 2017 at 8:52 AM, Paul Moore <pmoore@redhat.com>
> > wrote:
> > > From: Paul Moore <paul@paul-moore.com>
> > > 
> > > The syzbot/syzkaller automated tests found a problem in
> > > security_context_to_sid_core() during early boot (before we load
> > > the
> > > SELinux policy) where we could potentially feed context strings
> > > without
> > > NULL terminators into the strcmp() function.
> > > 
> > > We already guard against this during normal operation (after the
> > > SELinux
> > > policy has been loaded) by making a copy of the context strings
> > > and
> > > explicitly adding a NULL terminator to the end.  The patch
> > > extends this
> > > protection to the early boot case (no loaded policy) by moving
> > > the context
> > > copy earlier in security_context_to_sid_core().
> > > 
> > > Reported-by: syzbot <syzkaller@googlegroups.com>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/ss/services.c |   20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/security/selinux/ss/services.c
> > > b/security/selinux/ss/services.c
> > > index 33cfe5d3d6cb..6ec4cdc8af8f 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -1413,27 +1413,27 @@ static int
> > > security_context_to_sid_core(const char *scontext, u32
> > > scontext_len,
> > >         if (!scontext_len)
> > >                 return -EINVAL;
> > > 
> > > +       /* Copy the string to allow changes and ensure a NULL
> > > terminator */
> > > +       scontext2 = kmalloc(scontext_len + 1, gfp_flags);
> > > +       if (!scontext2)
> > > +               return -ENOMEM;
> > > +       memcpy(scontext2, scontext, scontext_len);
> > > +       scontext2[scontext_len] = 0;
> > 
> > Call me crazy, but can't we use kmemdup_nul() here?
> 
> Crazy good idea ;)
> 
> I didn't realize that function existed, I'll respin.  Thanks.

Also note that it should be NUL not NULL in the patch subject and
description.  '\0' vs (void*)0

> 
> > /**
> >  * kmemdup_nul - Create a NUL-terminated string from unterminated
> > data
> >  * @s: The data to stringify
> >  * @len: The size of the data
> >  * @gfp: the GFP mask used in the kmalloc() call when allocating
> > memory
> >  */
> > char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
> 
> 
