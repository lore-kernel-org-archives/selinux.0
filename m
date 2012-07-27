Message-ID: <1343421683.17570.111.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] You can now specify a sebool= flag in seapp_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Fri, 27 Jul 2012 16:41:23 -0400
In-Reply-To: <CAFftDdo_M-ctBQ=V=L-ExGQ6D8SrC2tXO94iPcx+8MYa8X2Z_A@mail.gmail.com>
References: <1343421174-7556-1-git-send-email-w.roberts@sta.samsung.com>
	 <CAFftDdo_M-ctBQ=V=L-ExGQ6D8SrC2tXO94iPcx+8MYa8X2Z_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 13:37 -0700, William Roberts wrote:
> Their doesn't seem to be consistent formatting in this file
> (libselinux/src/android.c) for multi-line statements, especially in
> regards to selinux_log. What is the style supposed to be, and at what
> width should we start wrapping code at?

Usually we follow Linux kernel coding style (Documentation/CodingStyle
in any kernel tree), which is 80 columns typically but it is all about
readability, so some variance is acceptable.

> 
> On Fri, Jul 27, 2012 at 1:32 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > The seapp rule will containing an sebool clause will
> > ONLY be applied on a match to that boolean,
> > and only if the boolean is set to true.
> >
> > Change-Id: Ifdba35cd3a78ce1c8173786514db649203018e28
> > Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
> > ---
> >  src/android.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
> >  1 files changed, 43 insertions(+), 7 deletions(-)
> >
> > diff --git a/src/android.c b/src/android.c
> > index 83ba7b7..dbac4f2 100644
> > --- a/src/android.c
> > +++ b/src/android.c
> > @@ -45,6 +45,7 @@ struct seapp_context {
> >         char *domain;
> >         char *type;
> >         char *level;
> > +       char *sebool;
> >         char levelFromUid;
> >  };
> >
> > @@ -85,6 +86,12 @@ static int seapp_context_cmp(const void *A, const void *B)
> >         if (!s1->name && s2->name)
> >                 return 1;
> >
> > +        /* Give precedence to a specified sebool= over an unspecified sebool=. */
> > +        if (s1->sebool && !s2->sebool)
> > +                return -1;
> > +        if (!s1->sebool && s2->sebool)
> > +                return 1;
> > +
> >         /* Anything else has equal precedence. */
> >         return 0;
> >  }
> > @@ -196,6 +203,10 @@ int selinux_android_seapp_context_reload(void)
> >                                 cur->level = strdup(value);
> >                                 if (!cur->level)
> >                                         goto oom;
> > +                       } else if (!strcasecmp(name, "sebool")) {
> > +                               cur->sebool = strdup(value);
> > +                               if (!cur->sebool)
> > +                                       goto oom;
> >                         } else
> >                                 goto err;
> >
> > @@ -217,12 +228,14 @@ int selinux_android_seapp_context_reload(void)
> >                 int i;
> >                 for (i = 0; i < nspec; i++) {
> >                         cur = seapp_contexts[i];
> > -                       selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s seinfo=%s name=%s -> domain=%s type=%s level=%s levelFromUid=%s",
> > -                                   __FUNCTION__,
> > -                                   cur->isSystemServer ? "true" : "false",
> > -                                   cur->user, cur->seinfo, cur->name,
> > -                                   cur->domain, cur->type, cur->level,
> > -                                   cur->levelFromUid ? "true" : "false");
> > +                       selinux_log(SELINUX_INFO, "%s:  isSystemServer=%s user=%s
> > +                       seinfo=%s name=%s sebool=%s -> domain=%s type=%s level=%s
> > +                       levelFromUid=%s",
> > +                       __FUNCTION__,
> > +                       cur->isSystemServer ? "true" : "false", cur->user,
> > +                       cur->seinfo, cur->name, cur->sebool, cur->domain,
> > +                       cur->type, cur->level,
> > +                       cur->levelFromUid ? "true" : "false");
> >                 }
> >         }
> >  #endif
> > @@ -335,6 +348,17 @@ int selinux_android_setfilecon2(const char *pkgdir,
> >                 if (!cur->type)
> >                         continue;
> >
> > +               if (cur->sebool) {
> > +                       int value = security_get_boolean_active(cur->sebool);
> > +                       if (value == 0)
> > +                               continue;
> > +                       else if (value == -1) {
> > +                               selinux_log(SELINUX_ERROR, \
> > +                               "Could not find boolean: %s ", cur->sebool);
> > +                               goto err;
> > +                       }
> > +               }
> > +
> >                 if (context_type_set(ctx, cur->type))
> >                         goto oom;
> >
> > @@ -348,7 +372,7 @@ int selinux_android_setfilecon2(const char *pkgdir,
> >                         if (context_range_set(ctx, cur->level))
> >                                 goto oom;
> >                 }
> > -
> > +
> >                 break;
> >         }
> >
> > @@ -443,6 +467,7 @@ int selinux_android_setcontext(uid_t uid,
> >
> >         for (i = 0; i < nspec; i++) {
> >                 cur = seapp_contexts[i];
> > +
> >                 if (cur->isSystemServer != isSystemServer)
> >                         continue;
> >                 if (cur->user) {
> > @@ -466,6 +491,17 @@ int selinux_android_setcontext(uid_t uid,
> >                 if (!cur->domain)
> >                         continue;
> >
> > +               if (cur->sebool) {
> > +                       int value = security_get_boolean_active(cur->sebool);
> > +                       if (value == 0)
> > +                               continue;
> > +                       else if (value == -1) {
> > +                               selinux_log(SELINUX_ERROR, \
> > +                               "Could not find boolean: %s ", cur->sebool);
> > +                                goto err;
> > +                        }
> > +                }
> > +
> >                 if (context_type_set(ctx, cur->domain))
> >                         goto oom;
> >
> > --
> > 1.7.0.4
> >
> 
> 
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
