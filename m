Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7TLiZQs032284
 for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2018 17:44:35 -0400
Received: by mail-yb0-f193.google.com with SMTP id c4-v6so2621494ybl.6
 for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2018 14:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180828213217.67080-1-mortonm@chromium.org>
 <797d811d-e7a1-aca8-2d8f-a1cf9def66fb@schaufler-ca.com>
In-Reply-To: <797d811d-e7a1-aca8-2d8f-a1cf9def66fb@schaufler-ca.com>
From: Micah Morton <mortonm@chromium.org>
Date: Wed, 29 Aug 2018 14:44:04 -0700
Message-ID: <CAJ-EccMBuqmWxLwJdybeqR6=Fvh5ffJSWZEHT2aQoJEyzD+Gpg@mail.gmail.com>
To: casey@schaufler-ca.com
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] SELinux: allow other LSMs to use custom mount
 args
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

So are you saying that since another security module (i.e. Smack) has
this issue, SELinux ought not to fix this issue? I agree it would be
optimal to solve this problem in the general sense, but I don't see
why it shouldn't be solved for SELinux in the mean time. Seems like
that would give even more motivation to solve the problem in the
general sense down the road. I'm not sure which patch your talking
about, although I'm familiar with this post
https://lwn.net/Articles/635771/ and the linked patch:
https://lwn.net/Articles/636056/. Is there a more recent version since
2015?
On Wed, Aug 29, 2018 at 9:18 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 8/28/2018 2:32 PM, Micah Morton wrote:
> > The security_sb_copy_data LSM hook allows LSMs to copy custom string
> > name/value args passed to mount_fs() into a temporary buffer (called
> > "secdata") that will be accessible to LSM code during the
> > security_sb_kern_mount hook further down in mount_fs(). Currently,
> > SELinux effectively prevents any other LSMs from copying custom mount
> > args into the temporary buffer (and being able to access them during
> > security_sb_kern_mount), as it will fail with -EINVAL and print
> > "SELinux:  unknown mount option" to the kernel message buffer if args it
> > doesn't recognize are present in the temporary buffer when
> > selinux_sb_kern_mount is called. This change adds an arg to the list of
> > those accepted by SELinux during security_sb_kern_mount. SELinux won't
> > do anything with this arg besides allow the name/value pair to be passed
> > along to any other LSM that is stacked after SELinux.
> >
> > Developed on v4.18.
> >
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
>
> This needs to be generalized. Whatever security module you're
> working on won't stack with any other module that uses mount
> options, Smack in particular. Have you looked at the patch I've
> been proposing as part of the general stacking work?
>
> > ---
> >  security/selinux/hooks.c            |  7 ++++++-
> >  security/selinux/include/security.h | 11 ++++++-----
> >  2 files changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 2b5ee5fbd652..e70ccc701eb8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -445,6 +445,7 @@ enum {
> >       Opt_rootcontext = 4,
> >       Opt_labelsupport = 5,
> >       Opt_nextmntopt = 6,
> > +     Opt_lsm_custom_arg = 7,
> >  };
> >
> >  #define NUM_SEL_MNT_OPTS     (Opt_nextmntopt - 1)
> > @@ -455,6 +456,7 @@ static const match_table_t tokens = {
> >       {Opt_defcontext, DEFCONTEXT_STR "%s"},
> >       {Opt_rootcontext, ROOTCONTEXT_STR "%s"},
> >       {Opt_labelsupport, LABELSUPP_STR},
> > +     {Opt_lsm_custom_arg, LSM_CUSTOM_ARG_STR "%s"},
> >       {Opt_error, NULL},
> >  };
> >
> > @@ -1156,6 +1158,8 @@ static int selinux_parse_opts_str(char *options,
> >                       break;
> >               case Opt_labelsupport:
> >                       break;
> > +             case Opt_lsm_custom_arg:
> > +                     break;
> >               default:
> >                       rc = -EINVAL;
> >                       printk(KERN_WARNING "SELinux:  unknown mount option\n");
> > @@ -2758,7 +2762,8 @@ static inline int selinux_option(char *option, int len)
> >               match_prefix(FSCONTEXT_STR, sizeof(FSCONTEXT_STR)-1, option, len) ||
> >               match_prefix(DEFCONTEXT_STR, sizeof(DEFCONTEXT_STR)-1, option, len) ||
> >               match_prefix(ROOTCONTEXT_STR, sizeof(ROOTCONTEXT_STR)-1, option, len) ||
> > -             match_prefix(LABELSUPP_STR, sizeof(LABELSUPP_STR)-1, option, len));
> > +             match_prefix(LABELSUPP_STR, sizeof(LABELSUPP_STR)-1, option, len) ||
> > +             match_prefix(LSM_CUSTOM_ARG_STR, sizeof(LSM_CUSTOM_ARG_STR)-1, option, len));
> >  }
> >
> >  static inline void take_option(char **to, char *from, int *first, int len)
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index 23e762d529fa..0ead836a0625 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -59,11 +59,12 @@
> >  #define SE_SBPROC            0x0200
> >  #define SE_SBGENFS           0x0400
> >
> > -#define CONTEXT_STR  "context="
> > -#define FSCONTEXT_STR        "fscontext="
> > -#define ROOTCONTEXT_STR      "rootcontext="
> > -#define DEFCONTEXT_STR       "defcontext="
> > -#define LABELSUPP_STR "seclabel"
> > +#define CONTEXT_STR         "context="
> > +#define FSCONTEXT_STR       "fscontext="
> > +#define ROOTCONTEXT_STR     "rootcontext="
> > +#define DEFCONTEXT_STR      "defcontext="
> > +#define LABELSUPP_STR       "seclabel"
> > +#define LSM_CUSTOM_ARG_STR  "lsm_custom_arg="
> >
> >  struct netlbl_lsm_secattr;
> >
>
