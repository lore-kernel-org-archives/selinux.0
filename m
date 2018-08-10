Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7AN1cge014457
 for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2018 19:01:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so18505772oib.6
 for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2018 16:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180806211932.198488-1-jannh@google.com>
 <CAHC9VhR5S6jGsHVwrGXemGobB1O=tADHBHWZMRP5BuRMGqDrOQ@mail.gmail.com>
 <CAGH-Kgvn5=BT0GQU2qHBwJos8Ev=VgasicXeqQEG166Mi8fc6w@mail.gmail.com>
In-Reply-To: <CAGH-Kgvn5=BT0GQU2qHBwJos8Ev=VgasicXeqQEG166Mi8fc6w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Sat, 11 Aug 2018 01:01:03 +0200
Message-ID: <CAG48ez1QS6e4cBsunh=V0fx6Gj-VENGeuakz2XK9eQoHU6Uh6Q@mail.gmail.com>
To: pmoore@redhat.com
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: refactor mls_context_to_sid() and make
 it stricter
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 9, 2018 at 4:07 AM Paul Moore <pmoore@redhat.com> wrote:
>
> On Wed, Aug 8, 2018 at 9:56 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Aug 6, 2018 at 5:19 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > The intended behavior change for this patch is to reject any MLS strings
> > > that contain (trailing) garbage if p->mls_enabled is true.
> > >
> > > As suggested by Paul Moore, change mls_context_to_sid() so that the two
> > > parts of the range are extracted before the rest of the parsing. Because
> > > now we don't have to scan for two different separators simultaneously
> > > everywhere, we can actually switch to strchr() everywhere instead of the
> > > open-coded loops that scan for two separators at once.
> > >
> > > mls_context_to_sid() used to signal how much of the input string was parsed
> > > by updating `*scontext`. However, there is actually no case in which
> > > mls_context_to_sid() only parses a subset of the input and still returns
> > > a success (other than the buggy case with a second '-' in which it
> > > incorrectly claims to have consumed the entire string). Turn `scontext`
> > > into a simple pointer argument and stop redundantly checking whether the
> > > entire input was consumed in string_to_context_struct(). This also lets us
> > > remove the `scontext_len` argument from `string_to_context_struct()`.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > Refactored version of
> > > "[PATCH] selinux: stricter parsing in mls_context_to_sid()" based on
> > > Paul's comments. WDYT?
> > > I've thrown some inputs at it, and it seems to work.
> > >
> > >  security/selinux/ss/mls.c      | 178 ++++++++++++++-------------------
> > >  security/selinux/ss/mls.h      |   2 +-
> > >  security/selinux/ss/services.c |  12 +--
> > >  3 files changed, 82 insertions(+), 110 deletions(-)
> >
> > Thanks for the rework, this looks much better than what we currently
> > have.  I have some comments/questions below ...
> >
> > > diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
> > > index 39475fb455bc..2fe459df3c85 100644
> > > --- a/security/selinux/ss/mls.c
> > > +++ b/security/selinux/ss/mls.c
> > > @@ -218,9 +218,7 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> > >  /*
> > >   * Set the MLS fields in the security context structure
> > >   * `context' based on the string representation in
> > > - * the string `*scontext'.  Update `*scontext' to
> > > - * point to the end of the string representation of
> > > - * the MLS fields.
> > > + * the string `scontext'.
> > >   *
> > >   * This function modifies the string in place, inserting
> > >   * NULL characters to terminate the MLS fields.
> > > @@ -235,22 +233,21 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
> > >   */
> > >  int mls_context_to_sid(struct policydb *pol,
> > >                        char oldc,
> > > -                      char **scontext,
> > > +                      char *scontext,
> > >                        struct context *context,
> > >                        struct sidtab *s,
> > >                        u32 def_sid)
> > >  {
> > > -
> > > -       char delim;
> > > -       char *scontextp, *p, *rngptr;
> > > +       char *sensitivity, *cur_cat, *next_cat, *rngptr;
> > >         struct level_datum *levdatum;
> > >         struct cat_datum *catdatum, *rngdatum;
> > > -       int l, rc = -EINVAL;
> > > +       int l, rc, i;
> > > +       char *rangep[2];
> > >
> > >         if (!pol->mls_enabled) {
> > > -               if (def_sid != SECSID_NULL && oldc)
> > > -                       *scontext += strlen(*scontext) + 1;
> > > -               return 0;
> > > +               if ((def_sid != SECSID_NULL && oldc) || (*scontext) == '\0')
> > > +                       return 0;
> > > +               return -EINVAL;
> >
> > Why are we simply not always return 0 in the case where MLS is not
> > enabled in the policy?  The mls_context_to_sid() is pretty much a
> > no-op in this case (even more so with your pat regardless of input and
> > I worry that returning EINVAL here is a deviation from current
> > behavior which could cause problems.
>
> Sorry, I was rephrasing the text above when I accidentally hit send.
> While my emails are generally a good source of typos, the above is
> pretty bad, so let me try again ...
>
> Why are we simply not always returning 0 in the case where MLS is not
> enabled in the policy?  The mls_context_to_sid() function is pretty
> much a no-op in this case regardless of input and I worry that
> returning EINVAL here is a deviation from current behavior which could
> cause problems.

Reverse call graph of mls_context_to_sid():

mls_context_to_sid()
    mls_from_string()
        selinux_audit_rule_init()
            [...]
    string_to_context_struct()
        security_context_to_sid_core()
            [...]
        convert_context()
            [...]

string_to_context_struct() currently has the following code:

        rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
        if (rc)
                goto out;

        rc = -EINVAL;
        if ((p - scontext) < scontext_len)
                goto out;

In my patch, I tried to preserve the behavior of
string_to_context_struct(), at the expense of slightly changing the
behavior of selinux_audit_rule_init().

But if you think that's a bad idea or unnecessary, say so and I'll change it.

> > >         }
> > >
> > >         /*
> > > @@ -261,113 +258,94 @@ int mls_context_to_sid(struct policydb *pol,
> > >                 struct context *defcon;
> > >
> > >                 if (def_sid == SECSID_NULL)
> > > -                       goto out;
> > > +                       return -EINVAL;
> > >
> > >                 defcon = sidtab_search(s, def_sid);
> > >                 if (!defcon)
> > > -                       goto out;
> > > +                       return -EINVAL;
> > >
> > > -               rc = mls_context_cpy(context, defcon);
> > > -               goto out;
> > > +               return mls_context_cpy(context, defcon);
> > >         }
> > >
> > > -       /* Extract low sensitivity. */
> > > -       scontextp = p = *scontext;
> > > -       while (*p && *p != ':' && *p != '-')
> > > -               p++;
> > > -
> > > -       delim = *p;
> > > -       if (delim != '\0')
> > > -               *p++ = '\0';
> > > +       /*
> > > +        * If we're dealing with a range, figure out where the two parts
> > > +        * of the range begin.
> > > +        */
> > > +       rangep[0] = scontext;
> > > +       rangep[1] = strchr(scontext, '-');
> > > +       if (rangep[1]) {
> > > +               rangep[1][0] = '\0';
> > > +               rangep[1]++;
> > > +       }
> > >
> > > +       /* For each part of the range: */
> > >         for (l = 0; l < 2; l++) {
> > > -               levdatum = hashtab_search(pol->p_levels.table, scontextp);
> > > -               if (!levdatum) {
> > > -                       rc = -EINVAL;
> > > -                       goto out;
> > > -               }
> > > +               /* Split sensitivity and category set. */
> > > +               sensitivity = rangep[l];
> > > +               if (sensitivity == NULL)
> > > +                       break;
> > > +               next_cat = strchr(sensitivity, ':');
> > > +               if (next_cat)
> > > +                       *(next_cat++) = '\0';
> > >
> > > +               /* Parse sensitivity. */
> > > +               levdatum = hashtab_search(pol->p_levels.table, sensitivity);
> > > +               if (!levdatum)
> > > +                       return -EINVAL;
> > >                 context->range.level[l].sens = levdatum->level->sens;
> > >
> > > -               if (delim == ':') {
> > > -                       /* Extract category set. */
> > > -                       while (1) {
> > > -                               scontextp = p;
> > > -                               while (*p && *p != ',' && *p != '-')
> > > -                                       p++;
> > > -                               delim = *p;
> > > -                               if (delim != '\0')
> > > -                                       *p++ = '\0';
> > > -
> > > -                               /* Separate into range if exists */
> > > -                               rngptr = strchr(scontextp, '.');
> > > -                               if (rngptr != NULL) {
> > > -                                       /* Remove '.' */
> > > -                                       *rngptr++ = '\0';
> > > -                               }
> > > +               /* Extract category set. */
> > > +               while (next_cat != NULL) {
> > > +                       cur_cat = next_cat;
> > > +                       next_cat = strchr(next_cat, ',');
> > > +                       if (next_cat != NULL)
> > > +                               *(next_cat++) = '\0';
> > > +
> > > +                       /* Separate into range if exists */
> > > +                       rngptr = strchr(cur_cat, '.');
> > > +                       if (rngptr != NULL) {
> > > +                               /* Remove '.' */
> >
> > On the chance you need to respin this patch, you can probably get rid
> > of the above comment and the if-body braces; we don't have "Remove X"
> > comments in other similar places in this function.
> >
> > > +                               *rngptr++ = '\0';
> > > +                       }
> > >
> > > -                               catdatum = hashtab_search(pol->p_cats.table,
> > > -                                                         scontextp);
> > > -                               if (!catdatum) {
> > > -                                       rc = -EINVAL;
> > > -                                       goto out;
> > > -                               }
> > > +                       catdatum = hashtab_search(pol->p_cats.table, cur_cat);
> > > +                       if (!catdatum)
> > > +                               return -EINVAL;
> > >
> > > -                               rc = ebitmap_set_bit(&context->range.level[l].cat,
> > > -                                                    catdatum->value - 1, 1);
> > > -                               if (rc)
> > > -                                       goto out;
> > > -
> > > -                               /* If range, set all categories in range */
> > > -                               if (rngptr) {
> > > -                                       int i;
> > > -
> > > -                                       rngdatum = hashtab_search(pol->p_cats.table, rngptr);
> > > -                                       if (!rngdatum) {
> > > -                                               rc = -EINVAL;
> > > -                                               goto out;
> > > -                                       }
> > > -
> > > -                                       if (catdatum->value >= rngdatum->value) {
> > > -                                               rc = -EINVAL;
> > > -                                               goto out;
> > > -                                       }
> > > -
> > > -                                       for (i = catdatum->value; i < rngdatum->value; i++) {
> > > -                                               rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
> > > -                                               if (rc)
> > > -                                                       goto out;
> > > -                                       }
> > > -                               }
> > > +                       rc = ebitmap_set_bit(&context->range.level[l].cat,
> > > +                                            catdatum->value - 1, 1);
> > > +                       if (rc)
> > > +                               return rc;
> > > +
> > > +                       /* If range, set all categories in range */
> > > +                       if (rngptr == NULL)
> > > +                               continue;
> > > +
> > > +                       rngdatum = hashtab_search(pol->p_cats.table, rngptr);
> > > +                       if (!rngdatum)
> > > +                               return -EINVAL;
> > > +
> > > +                       if (catdatum->value >= rngdatum->value)
> > > +                               return -EINVAL;
> > >
> > > -                               if (delim != ',')
> > > -                                       break;
> > > +                       for (i = catdatum->value; i < rngdatum->value; i++) {
> > > +                               rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
> > > +                               if (rc)
> > > +                                       return rc;
> > >                         }
> > >                 }
> > > -               if (delim == '-') {
> > > -                       /* Extract high sensitivity. */
> > > -                       scontextp = p;
> > > -                       while (*p && *p != ':')
> > > -                               p++;
> > > -
> > > -                       delim = *p;
> > > -                       if (delim != '\0')
> > > -                               *p++ = '\0';
> > > -               } else
> > > -                       break;
> > >         }
> > >
> > > -       if (l == 0) {
> > > +       /* If we didn't see a '-', the range start is also the range end. */
> > > +       if (rangep[1] == NULL) {
> > >                 context->range.level[1].sens = context->range.level[0].sens;
> > >                 rc = ebitmap_cpy(&context->range.level[1].cat,
> > >                                  &context->range.level[0].cat);
> > >                 if (rc)
> > > -                       goto out;
> > > +                       return rc;
> > >         }
> > > -       *scontext = ++p;
> > > -       rc = 0;
> > > -out:
> > > -       return rc;
> > > +
> > > +       return 0;
> >
> > In the case where we have a MLS policy loaded (pol->mls_enabled != 0)
> > and scontext is empty (scontext[0] = '\0'), we could end up returning
> > 0 couldn't we?  It seems like we might want a quick check for this
> > before we parse the low/high portions of the field into the rangep
> > array.
> >
> > >  }
> > >
> > >  /*
> > > @@ -379,21 +357,19 @@ int mls_context_to_sid(struct policydb *pol,
> > >  int mls_from_string(struct policydb *p, char *str, struct context *context,
> > >                     gfp_t gfp_mask)
> > >  {
> > > -       char *tmpstr, *freestr;
> > > +       char *tmpstr;
> > >         int rc;
> > >
> > >         if (!p->mls_enabled)
> > >                 return -EINVAL;
> > >
> > > -       /* we need freestr because mls_context_to_sid will change
> > > -          the value of tmpstr */
> > > -       tmpstr = freestr = kstrdup(str, gfp_mask);
> > > +       tmpstr = kstrdup(str, gfp_mask);
> > >         if (!tmpstr) {
> > >                 rc = -ENOMEM;
> > >         } else {
> > > -               rc = mls_context_to_sid(p, ':', &tmpstr, context,
> > > +               rc = mls_context_to_sid(p, ':', tmpstr, context,
> > >                                         NULL, SECSID_NULL);
> > > -               kfree(freestr);
> > > +               kfree(tmpstr);
> > >         }
> > >
> > >         return rc;
> > > diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
> > > index 9a3ff7af70ad..67093647576d 100644
> > > --- a/security/selinux/ss/mls.h
> > > +++ b/security/selinux/ss/mls.h
> > > @@ -34,7 +34,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l);
> > >
> > >  int mls_context_to_sid(struct policydb *p,
> > >                        char oldc,
> > > -                      char **scontext,
> > > +                      char *scontext,
> > >                        struct context *context,
> > >                        struct sidtab *s,
> > >                        u32 def_sid);
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > > index dd2ceec06fef..9212d4dd817a 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -1367,7 +1367,6 @@ int security_sid_to_context_force(struct selinux_state *state, u32 sid,
> > >  static int string_to_context_struct(struct policydb *pol,
> > >                                     struct sidtab *sidtabp,
> > >                                     char *scontext,
> > > -                                   u32 scontext_len,
> > >                                     struct context *ctx,
> > >                                     u32 def_sid)
> > >  {
> > > @@ -1428,15 +1427,12 @@ static int string_to_context_struct(struct policydb *pol,
> > >
> > >         ctx->type = typdatum->value;
> > >
> > > -       rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
> > > +       rc = mls_context_to_sid(pol, oldc, p, ctx, sidtabp, def_sid);
> > >         if (rc)
> > >                 goto out;
> > >
> > > -       rc = -EINVAL;
> > > -       if ((p - scontext) < scontext_len)
> > > -               goto out;
> > > -
> > >         /* Check the validity of the new context. */
> > > +       rc = -EINVAL;
> > >         if (!policydb_context_isvalid(pol, ctx))
> > >                 goto out;
> > >         rc = 0;
> > > @@ -1491,7 +1487,7 @@ static int security_context_to_sid_core(struct selinux_state *state,
> > >         policydb = &state->ss->policydb;
> > >         sidtab = &state->ss->sidtab;
> > >         rc = string_to_context_struct(policydb, sidtab, scontext2,
> > > -                                     scontext_len, &context, def_sid);
> > > +                                     &context, def_sid);
> > >         if (rc == -EINVAL && force) {
> > >                 context.str = str;
> > >                 context.len = strlen(str) + 1;
> > > @@ -1959,7 +1955,7 @@ static int convert_context(u32 key,
> > >                         goto out;
> > >
> > >                 rc = string_to_context_struct(args->newp, NULL, s,
> > > -                                             c->len, &ctx, SECSID_NULL);
> > > +                                             &ctx, SECSID_NULL);
> > >                 kfree(s);
> > >                 if (!rc) {
> > >                         printk(KERN_INFO "SELinux:  Context %s became valid (mapped).\n",
> > > --
> > > 2.18.0.597.ga71716f1ad-goog
> >
> > --
> > paul moore
> > www.paul-moore.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> paul moore
> security @ redhat
