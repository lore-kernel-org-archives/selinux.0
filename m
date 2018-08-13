Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7DNdjCC028382
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 19:39:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so13920540ljg.10
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 16:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180806211932.198488-1-jannh@google.com>
 <CAHC9VhR5S6jGsHVwrGXemGobB1O=tADHBHWZMRP5BuRMGqDrOQ@mail.gmail.com>
 <CAGH-Kgvn5=BT0GQU2qHBwJos8Ev=VgasicXeqQEG166Mi8fc6w@mail.gmail.com>
 <CAG48ez1QS6e4cBsunh=V0fx6Gj-VENGeuakz2XK9eQoHU6Uh6Q@mail.gmail.com>
In-Reply-To: <CAG48ez1QS6e4cBsunh=V0fx6Gj-VENGeuakz2XK9eQoHU6Uh6Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Aug 2018 19:38:40 -0400
Message-ID: <CAHC9VhSkr1dtU=ai-ss8xPLiSvb5_L839+7ytTY1ya=h_yk5sg@mail.gmail.com>
To: jannh@google.com
Cc: Paul Moore <pmoore@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 James Morris <jmorris@namei.org>, serge@hallyn.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: refactor mls_context_to_sid() and make
 it stricter
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Aug 10, 2018 at 7:01 PM Jann Horn <jannh@google.com> wrote:
> On Thu, Aug 9, 2018 at 4:07 AM Paul Moore <pmoore@redhat.com> wrote:
> > On Wed, Aug 8, 2018 at 9:56 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Aug 6, 2018 at 5:19 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > The intended behavior change for this patch is to reject any MLS strings
> > > > that contain (trailing) garbage if p->mls_enabled is true.
> > > >
> > > > As suggested by Paul Moore, change mls_context_to_sid() so that the two
> > > > parts of the range are extracted before the rest of the parsing. Because
> > > > now we don't have to scan for two different separators simultaneously
> > > > everywhere, we can actually switch to strchr() everywhere instead of the
> > > > open-coded loops that scan for two separators at once.
> > > >
> > > > mls_context_to_sid() used to signal how much of the input string was parsed
> > > > by updating `*scontext`. However, there is actually no case in which
> > > > mls_context_to_sid() only parses a subset of the input and still returns
> > > > a success (other than the buggy case with a second '-' in which it
> > > > incorrectly claims to have consumed the entire string). Turn `scontext`
> > > > into a simple pointer argument and stop redundantly checking whether the
> > > > entire input was consumed in string_to_context_struct(). This also lets us
> > > > remove the `scontext_len` argument from `string_to_context_struct()`.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > > Refactored version of
> > > > "[PATCH] selinux: stricter parsing in mls_context_to_sid()" based on
> > > > Paul's comments. WDYT?
> > > > I've thrown some inputs at it, and it seems to work.
> > > >
> > > >  security/selinux/ss/mls.c      | 178 ++++++++++++++-------------------
> > > >  security/selinux/ss/mls.h      |   2 +-
> > > >  security/selinux/ss/services.c |  12 +--
> > > >  3 files changed, 82 insertions(+), 110 deletions(-)
> > >
> > > Thanks for the rework, this looks much better than what we currently
> > > have.  I have some comments/questions below ...
> > >
> > > > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > > > index 39475fb455bc..2fe459df3c85 100644
> > > > --- a/security/selinux/ss/mls.c
> > > > +++ b/security/selinux/ss/mls.c
> > > > @@ -218,9 +218,7 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> > > >  /*
> > > >   * Set the MLS fields in the security context structure
> > > >   * `context' based on the string representation in
> > > > - * the string `*scontext'.  Update `*scontext' to
> > > > - * point to the end of the string representation of
> > > > - * the MLS fields.
> > > > + * the string `scontext'.
> > > >   *
> > > >   * This function modifies the string in place, inserting
> > > >   * NULL characters to terminate the MLS fields.
> > > > @@ -235,22 +233,21 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> > > >   */
> > > >  int mls_context_to_sid(struct policydb *pol,
> > > >                        char oldc,
> > > > -                      char **scontext,
> > > > +                      char *scontext,
> > > >                        struct context *context,
> > > >                        struct sidtab *s,
> > > >                        u32 def_sid)
> > > >  {
> > > > -
> > > > -       char delim;
> > > > -       char *scontextp, *p, *rngptr;
> > > > +       char *sensitivity, *cur_cat, *next_cat, *rngptr;
> > > >         struct level_datum *levdatum;
> > > >         struct cat_datum *catdatum, *rngdatum;
> > > > -       int l, rc = -EINVAL;
> > > > +       int l, rc, i;
> > > > +       char *rangep[2];
> > > >
> > > >         if (!pol->mls_enabled) {
> > > > -               if (def_sid != SECSID_NULL && oldc)
> > > > -                       *scontext += strlen(*scontext) + 1;
> > > > -               return 0;
> > > > +               if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> > > > +                       return 0;
> > > > +               return -EINVAL;
> > >
> > > Why are we simply not always return 0 in the case where MLS is not
> > > enabled in the policy?  The mls_context_to_sid() is pretty much a
> > > no-op in this case (even more so with your pat regardless of input and
> > > I worry that returning EINVAL here is a deviation from current
> > > behavior which could cause problems.
> >
> > Sorry, I was rephrasing the text above when I accidentally hit send.
> > While my emails are generally a good source of typos, the above is
> > pretty bad, so let me try again ...
> >
> > Why are we simply not always returning 0 in the case where MLS is not
> > enabled in the policy?  The mls_context_to_sid() function is pretty
> > much a no-op in this case regardless of input and I worry that
> > returning EINVAL here is a deviation from current behavior which could
> > cause problems.
>
> Reverse call graph of mls_context_to_sid():
>
> mls_context_to_sid()
>     mls_from_string()
>         selinux_audit_rule_init()
>             [...]
>     string_to_context_struct()
>         security_context_to_sid_core()
>             [...]
>         convert_context()
>             [...]
>
> string_to_context_struct() currently has the following code:
>
>         rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
>         if (rc)
>                 goto out;
>
>         rc = -EINVAL;
>         if ((p - scontext) < scontext_len)
>                 goto out;
>
> In my patch, I tried to preserve the behavior of
> string_to_context_struct(), at the expense of slightly changing the
> behavior of selinux_audit_rule_init().
>
> But if you think that's a bad idea or unnecessary, say so and I'll change it.

I'll be honest and mention that I kinda spaced on the change you made
to string_to_context_struct() while I was looking over the
mls_context_to_sid() changes.  As you point out, I believe
string_to_context_struct() will continue to work as expected for
callers so that should be okay.

The selinux_audit_rule_init() function is a little different, but
looking at some of the callers, and thinking about it a bit more, it
probably isn't a bad thing to return EINVAL as in your patch.  The
label isn't valid given that the system isn't in MLS mode and letting
admins know that should be okay.  So I guess we can leave this section
of the patch as-is, but understand that we might need to tweak this if
we end up breaking something important.

As an aside, I believe my other comments on this patch still stand.
It's a nice improvement but I think there are some other small things
that need to be addressed.

-- 
paul moore
www.paul-moore.com
