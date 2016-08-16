MIME-Version: 1.0
In-Reply-To: <CAFftDdqDRinx5w-GaapnCRAMrhjxYwKjPxvogrvxDX+p3ASzPg@mail.gmail.com>
References: <1471276754-25266-1-git-send-email-william.c.roberts@intel.com>
 <1471276754-25266-6-git-send-email-william.c.roberts@intel.com>
 <9ca86776-3817-1c5d-dca4-7490cd70212d@tycho.nsa.gov>
 <CAFftDdqDRinx5w-GaapnCRAMrhjxYwKjPxvogrvxDX+p3ASzPg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 16 Aug 2016 08:37:18 -0700
Message-ID: <CAFftDdqPOgi7ZBmscF-vUA=PMbMscrV2kOU2E=ODw-afUzOOhg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] libsepol: fix overflow and 0 length allocations
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113a6878c7c99f053a321f3f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113a6878c7c99f053a321f3f
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 16, 2016 at 8:11 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> On Aug 16, 2016 06:12, "James Carter" <jwcart2@tycho.nsa.gov> wrote:
> >
> > On 08/15/2016 11:59 AM, william.c.roberts@intel.com wrote:
> >>
> >> From: William Roberts <william.c.roberts@intel.com>
> >>
> >> Throughout libsepol, values taken from sepolicy are used in
> >> places where length == 0 or length == <saturated> matter,
> >> find and fix these.
> >>
> >> Also, correct any type mismatches noticed along the way.
> >>
> >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >> ---
> >>  libsepol/src/conditional.c    |  3 ++-
> >>  libsepol/src/context.c        | 16 ++++++++-----
> >>  libsepol/src/context_record.c | 52 ++++++++++++++++++++++++------
> -------------
> >>  libsepol/src/module.c         | 13 +++++++++++
> >>  libsepol/src/module_to_cil.c  |  4 +++-
> >>  libsepol/src/policydb.c       | 52 ++++++++++++++++++++++++++++++
> ++++++++++---
> >>  libsepol/src/private.h        |  3 +++
> >>  7 files changed, 110 insertions(+), 33 deletions(-)
> >>
> >
> >
> >> diff --git a/libsepol/src/context_record.c
> b/libsepol/src/context_record.c
> >> index ac2884a..fdf60a0 100644
> >> --- a/libsepol/src/context_record.c
> >> +++ b/libsepol/src/context_record.c
> >> @@ -5,6 +5,7 @@
> >>
> >>  #include "context_internal.h"
> >>  #include "debug.h"
> >> +#include "private.h"
> >>
> >>  struct sepol_context {
> >>
> >> @@ -284,39 +285,44 @@ int sepol_context_to_string(sepol_handle_t *
> handle,
> >>  {
> >>
> >>         int rc;
> >> -       const int user_sz = strlen(con->user);
> >> -       const int role_sz = strlen(con->role);
> >> -       const int type_sz = strlen(con->type);
> >> -       const int mls_sz = (con->mls) ? strlen(con->mls) : 0;
> >> -       const int total_sz = user_sz + role_sz + type_sz +
> >> -           mls_sz + ((con->mls) ? 3 : 2);
> >> -
> >> -       char *str = (char *)malloc(total_sz + 1);
> >> -       if (!str)
> >> -               goto omem;
> >> +       char *str = NULL;
> >> +       const size_t user_sz = strlen(con->user);
> >> +       const size_t role_sz = strlen(con->role);
> >> +       const size_t type_sz = strlen(con->type);
> >> +       const size_t mls_sz = (con->mls) ? strlen(con->mls) : 0;
> >> +       const size_t total_sz = user_sz + role_sz + type_sz +
> >> +           mls_sz + ((con->mls) ? 3 : 2) + 1;
> >> +
> >> +       if (zero_or_saturated(total_sz)) {
> >> +               ERR(handle, "invalid size");
> >> +               goto err;
> >> +       }
> >>
> >> +       str = (char *)malloc(total_sz);
> >
> >
> > Before, total_sz + 1 was malloc'd, so it made sense to check for
> saturation, but you add the 1 to total_sz before checking for saturation.
>
> True I didn't want to get rid of the const so we should be checking for 0
> or 1 length, or drop the const and check prior to the increment.
>
> >
> > This case is also different in that multiple string lengths are being
> added, so overflow would be the real concern here, but I don't think that
> it is possible to overflow because of limits in checkpolicy (8K) and xattrs
> (64K).
>
> Check policy isn't generating any of this and the xattr limits are not
> being enforced here. In theory we could make the check on the xattr limits
> if that woukd be preferred.
>
Currently, in file-systems like reiserFS that support scalable xattrs, only
VFS is the one limiting the size to 64k. Since their is no constant, and
maybe one day this arbitrary VFS limit
would be removed, I think we should check correctlly here that were
allocating > 1 bytes, and we keep total_sz a const.

>
> >
> > Jim
> >
> >
> >> +       if (!str) {
> >> +               ERR(handle, "out of memory");
> >> +               goto err;
> >> +       }
> >>         if (con->mls) {
> >> -               rc = snprintf(str, total_sz + 1, "%s:%s:%s:%s",
> >> +               rc = snprintf(str, total_sz, "%s:%s:%s:%s",
> >>                               con->user, con->role, con->type,
> con->mls);
> >> -               if (rc < 0 || (rc >= total_sz + 1)) {
> >> -                       ERR(handle, "print error");
> >> -                       goto err;
> >> -               }
> >>         } else {
> >> -               rc = snprintf(str, total_sz + 1, "%s:%s:%s",
> >> +               rc = snprintf(str, total_sz, "%s:%s:%s",
> >>                               con->user, con->role, con->type);
> >> -               if (rc < 0 || (rc >= total_sz + 1)) {
> >> -                       ERR(handle, "print error");
> >> -                       goto err;
> >> -               }
> >> +       }
> >> +
> >> +       /*
> >> +        * rc is >= 0 on the size_t cast and is safe to promote
> >> +        * to an unsigned value.
> >> +        */
> >> +       if (rc < 0 || (size_t)rc >= total_sz) {
> >> +               ERR(handle, "print error");
> >> +               goto err;
> >>         }
> >>
> >>         *str_ptr = str;
> >>         return STATUS_SUCCESS;
> >>
> >> -      omem:
> >> -       ERR(handle, "out of memory");
> >> -
> >>        err:
> >>         ERR(handle, "could not convert context to string");
> >>         free(str);
> >> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> >> index 1665ede..f25df95 100644
> >> --- a/libsepol/src/module.c
> >> +++ b/libsepol/src/module.c
> >> @@ -30,6 +30,7 @@
> >>  #include <stdio.h>
> >>  #include <stdlib.h>
> >>  #include <limits.h>
> >> +#include <inttypes.h>
> >>
> >>  #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
> >>  #define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91
> >> @@ -793,6 +794,12 @@ int sepol_module_package_info(struct
> sepol_policy_file *spf, int *type,
> >>                                 goto cleanup;
> >>                         }
> >>                         len = le32_to_cpu(buf[0]);
> >> +                       if (zero_or_saturated(len)) {
> >> +                               ERR(file->handle,
> >> +                                   "invalid module name length:
> 0x%"PRIx32,
> >> +                                   len);
> >> +                               goto cleanup;
> >> +                       }
> >>                         *name = malloc(len + 1);
> >>                         if (!*name) {
> >>                                 ERR(file->handle, "out of memory");
> >> @@ -814,6 +821,12 @@ int sepol_module_package_info(struct
> sepol_policy_file *spf, int *type,
> >>                                 goto cleanup;
> >>                         }
> >>                         len = le32_to_cpu(buf[0]);
> >> +                       if (zero_or_saturated(len)) {
> >> +                               ERR(file->handle,
> >> +                                   "invalid module version length:
> 0x%"PRIx32,
> >> +                                   len);
> >> +                               goto cleanup;
> >> +                       }
> >>                         *version = malloc(len + 1);
> >>                         if (!*version) {
> >>                                 ERR(file->handle, "out of memory");
> >> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> >> index 36f3b7d..fc65019 100644
> >> --- a/libsepol/src/module_to_cil.c
> >> +++ b/libsepol/src/module_to_cil.c
> >> @@ -47,6 +47,8 @@
> >>  #include <sepol/policydb/services.h>
> >>  #include <sepol/policydb/util.h>
> >>
> >> +#include "private.h"
> >> +
> >>  #ifdef __GNUC__
> >>  #  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))
> >>  #else
> >> @@ -124,7 +126,7 @@ static int get_line(char **start, char *end, char
> **line)
> >>
> >>         for (len = 0; p < end && *p != '\n' && *p != '\0'; p++, len++);
> >>
> >> -       if (len == 0) {
> >> +       if (zero_or_saturated(len)) {
> >>                 rc = 0;
> >>                 goto exit;
> >>         }
> >> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> >> index 971793d..604e022 100644
> >> --- a/libsepol/src/policydb.c
> >> +++ b/libsepol/src/policydb.c
> >> @@ -1911,6 +1911,9 @@ static int perm_read(policydb_t * p
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[0]);
> >> +       if (zero_or_saturated(len))
> >> +               goto bad;
> >> +
> >>         perdatum->s.value = le32_to_cpu(buf[1]);
> >>
> >>         key = malloc(len + 1);
> >> @@ -1949,6 +1952,9 @@ static int common_read(policydb_t * p, hashtab_t
> h, struct policy_file *fp)
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[0]);
> >> +       if (zero_or_saturated(len))
> >> +               goto bad;
> >> +
> >>         comdatum->s.value = le32_to_cpu(buf[1]);
> >>
> >>         if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
> >> @@ -2092,7 +2098,11 @@ static int class_read(policydb_t * p, hashtab_t
> h, struct policy_file *fp)
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[0]);
> >> +       if (zero_or_saturated(len))
> >> +               goto bad;
> >>         len2 = le32_to_cpu(buf[1]);
> >> +       if (is_saturated(len2))
> >> +               goto bad;
> >>         cladatum->s.value = le32_to_cpu(buf[2]);
> >>
> >>         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
> >> @@ -2199,6 +2209,9 @@ static int role_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[0]);
> >> +       if (zero_or_saturated(len))
> >> +               goto bad;
> >> +
> >>         role->s.value = le32_to_cpu(buf[1]);
> >>         if (policydb_has_boundary_feature(p))
> >>                 role->bounds = le32_to_cpu(buf[2]);
> >> @@ -2287,6 +2300,9 @@ static int type_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[pos]);
> >> +       if (zero_or_saturated(len))
> >> +               goto bad;
> >> +
> >>         typdatum->s.value = le32_to_cpu(buf[++pos]);
> >>         if (policydb_has_boundary_feature(p)) {
> >>                 uint32_t properties;
> >> @@ -2447,6 +2463,8 @@ int filename_trans_read(filename_trans_t **t,
> struct policy_file *fp)
> >>                 if (rc < 0)
> >>                         return -1;
> >>                 len = le32_to_cpu(buf[0]);
> >> +               if (zero_or_saturated(len))
> >> +                       return -1;
> >>
> >>                 name = calloc(len + 1, sizeof(*name));
> >>                 if (!name)
> >> @@ -2556,6 +2574,9 @@ static int ocontext_read_xen(struct
> policydb_compat_info *info,
> >>                                 if (rc < 0)
> >>                                         return -1;
> >>                                 len = le32_to_cpu(buf[0]);
> >> +                               if (zero_or_saturated(len))
> >> +                                       return -1;
> >> +
> >>                                 c->u.name = malloc(len + 1);
> >>                                 if (!c->u.name)
> >>                                         return -1;
> >> @@ -2618,6 +2639,8 @@ static int ocontext_read_selinux(struct
> policydb_compat_info *info,
> >>                                 if (rc < 0)
> >>                                         return -1;
> >>                                 len = le32_to_cpu(buf[0]);
> >> +                               if (zero_or_saturated(len))
> >> +                                       return -1;
> >>                                 c->u.name = malloc(len + 1);
> >>                                 if (!c->u.name)
> >>                                         return -1;
> >> @@ -2659,6 +2682,8 @@ static int ocontext_read_selinux(struct
> policydb_compat_info *info,
> >>                                         return -1;
> >>                                 c->v.behavior = le32_to_cpu(buf[0]);
> >>                                 len = le32_to_cpu(buf[1]);
> >> +                               if (zero_or_saturated(len))
> >> +                                       return -1;
> >>                                 c->u.name = malloc(len + 1);
> >>                                 if (!c->u.name)
> >>                                         return -1;
> >> @@ -2719,7 +2744,7 @@ static int genfs_read(policydb_t * p, struct
> policy_file *fp)
> >>         uint32_t buf[1];
> >>         size_t nel, nel2, len, len2;
> >>         genfs_t *genfs_p, *newgenfs, *genfs;
> >> -       unsigned int i, j;
> >> +       size_t i, j;
> >>         ocontext_t *l, *c, *newc = NULL;
> >>         int rc;
> >>
> >> @@ -2733,6 +2758,8 @@ static int genfs_read(policydb_t * p, struct
> policy_file *fp)
> >>                 if (rc < 0)
> >>                         goto bad;
> >>                 len = le32_to_cpu(buf[0]);
> >> +               if (zero_or_saturated(len))
> >> +                       goto bad;
> >>                 newgenfs = calloc(1, sizeof(genfs_t));
> >>                 if (!newgenfs)
> >>                         goto bad;
> >> @@ -2778,6 +2805,8 @@ static int genfs_read(policydb_t * p, struct
> policy_file *fp)
> >>                         if (rc < 0)
> >>                                 goto bad;
> >>                         len = le32_to_cpu(buf[0]);
> >> +                       if (zero_or_saturated(len))
> >> +                               goto bad;
> >>                         newc->u.name = malloc(len + 1);
> >>                         if (!newc->u.name) {
> >>                                 goto bad;
> >> @@ -2877,6 +2906,9 @@ static int user_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[0]);
> >> +       if (zero_or_saturated(len))
> >> +               goto bad;
> >> +
> >>         usrdatum->s.value = le32_to_cpu(buf[1]);
> >>         if (policydb_has_boundary_feature(p))
> >>                 usrdatum->bounds = le32_to_cpu(buf[2]);
> >> @@ -2960,6 +2992,9 @@ static int sens_read(policydb_t * p
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[0]);
> >> +       if (zero_or_saturated(len))
> >> +               goto bad;
> >> +
> >>         levdatum->isalias = le32_to_cpu(buf[1]);
> >>
> >>         key = malloc(len + 1);
> >> @@ -3003,6 +3038,9 @@ static int cat_read(policydb_t * p
> >>                 goto bad;
> >>
> >>         len = le32_to_cpu(buf[0]);
> >> +       if(zero_or_saturated(len))
> >> +               goto bad;
> >> +
> >>         catdatum->s.value = le32_to_cpu(buf[1]);
> >>         catdatum->isalias = le32_to_cpu(buf[2]);
> >>
> >> @@ -3339,6 +3377,8 @@ static int filename_trans_rule_read(filename_trans_rule_t
> ** r, struct policy_fi
> >>                         return -1;
> >>
> >>                 len = le32_to_cpu(buf[0]);
> >> +               if (zero_or_saturated(len))
> >> +                       return -1;
> >>
> >>                 ftr->name = malloc(len + 1);
> >>                 if (!ftr->name)
> >> @@ -3580,6 +3620,8 @@ static int scope_read(policydb_t * p, int symnum,
> struct policy_file *fp)
> >>         if (rc < 0)
> >>                 goto cleanup;
> >>         key_len = le32_to_cpu(buf[0]);
> >> +       if (zero_or_saturated(key_len))
> >> +               goto cleanup;
> >>         key = malloc(key_len + 1);
> >>         if (!key)
> >>                 goto cleanup;
> >> @@ -3664,8 +3706,8 @@ int policydb_read(policydb_t * p, struct
> policy_file *fp, unsigned verbose)
> >>         }
> >>
> >>         len = buf[1];
> >> -       if (len > POLICYDB_STRING_MAX_LENGTH) {
> >> -               ERR(fp->handle, "policydb string length too long ");
> >> +       if (len == 0 || len > POLICYDB_STRING_MAX_LENGTH) {
> >> +               ERR(fp->handle, "policydb string length %s ", len ?
> "too long" : "zero");
> >>                 return POLICYDB_ERROR;
> >>         }
> >>
> >> @@ -3798,6 +3840,8 @@ int policydb_read(policydb_t * p, struct
> policy_file *fp, unsigned verbose)
> >>                         goto bad;
> >>                 }
> >>                 len = le32_to_cpu(buf[0]);
> >> +               if (zero_or_saturated(len))
> >> +                       goto bad;
> >>                 if ((p->name = malloc(len + 1)) == NULL) {
> >>                         goto bad;
> >>                 }
> >> @@ -3809,6 +3853,8 @@ int policydb_read(policydb_t * p, struct
> policy_file *fp, unsigned verbose)
> >>                         goto bad;
> >>                 }
> >>                 len = le32_to_cpu(buf[0]);
> >> +               if (zero_or_saturated(len))
> >> +                       goto bad;
> >>                 if ((p->version = malloc(len + 1)) == NULL) {
> >>                         goto bad;
> >>                 }
> >> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> >> index 9c700c9..0beb4d4 100644
> >> --- a/libsepol/src/private.h
> >> +++ b/libsepol/src/private.h
> >> @@ -45,6 +45,9 @@
> >>
> >>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
> >>
> >> +#define is_saturated(x) (x == (typeof(x))-1)
> >> +#define zero_or_saturated(x) ((x == 0) || is_saturated(x))
> >> +
> >>  /* Policy compatibility information. */
> >>  struct policydb_compat_info {
> >>         unsigned int type;
> >>
> >
> >
> > --
> > James Carter <jwcart2@tycho.nsa.gov>
> > National Security Agency
> >
> > _______________________________________________
> > Seandroid-list mailing list
> > Seandroid-list@tycho.nsa.gov
> > To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>
>


-- 
Respectfully,

William C Roberts

--001a113a6878c7c99f053a321f3f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Aug 16, 2016 at 8:11 AM, William Roberts <span dir=3D"ltr">&lt;=
<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.robert=
s@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cl=
ass=3D"HOEnZb"><div class=3D"h5"><p dir=3D"ltr">On Aug 16, 2016 06:12, &quo=
t;James Carter&quot; &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" target=3D=
"_blank">jwcart2@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 08/15/2016 11:59 AM, <a href=3D"mailto:william.c.roberts@intel.com"=
 target=3D"_blank">william.c.roberts@intel.com</a> wrote:<br>
&gt;&gt;<br>
&gt;&gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@inte=
l.com" target=3D"_blank">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Throughout libsepol, values taken from sepolicy are used in<br>
&gt;&gt; places where length =3D=3D 0 or length =3D=3D &lt;saturated&gt; ma=
tter,<br>
&gt;&gt; find and fix these.<br>
&gt;&gt;<br>
&gt;&gt; Also, correct any type mismatches noticed along the way.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.rob=
erts@intel.com" target=3D"_blank">william.c.roberts@intel.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0libsepol/src/conditional.c=C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
&gt;&gt; =C2=A0libsepol/src/context.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16 +++++=
+++-----<br>
&gt;&gt; =C2=A0libsepol/src/context_record.c | 52 ++++++++++++++++++++++++-=
-----<wbr>-------------<br>
&gt;&gt; =C2=A0libsepol/src/module.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 =
+++++++++++<br>
&gt;&gt; =C2=A0libsepol/src/module_to_cil.c=C2=A0 |=C2=A0 4 +++-<br>
&gt;&gt; =C2=A0libsepol/src/policydb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 52 +++++=
+++++++++++++++++++++++++<wbr>++++++++++---<br>
&gt;&gt; =C2=A0libsepol/src/private.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 =
+++<br>
&gt;&gt; =C2=A07 files changed, 110 insertions(+), 33 deletions(-)<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; diff --git a/libsepol/src/context_record.<wbr>c b/libsepol/src/con=
text_record.<wbr>c<br>
&gt;&gt; index ac2884a..fdf60a0 100644<br>
&gt;&gt; --- a/libsepol/src/context_record.<wbr>c<br>
&gt;&gt; +++ b/libsepol/src/context_record.<wbr>c<br>
&gt;&gt; @@ -5,6 +5,7 @@<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0#include &quot;context_internal.h&quot;<br>
&gt;&gt; =C2=A0#include &quot;debug.h&quot;<br>
&gt;&gt; +#include &quot;private.h&quot;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0struct sepol_context {<br>
&gt;&gt;<br>
&gt;&gt; @@ -284,39 +285,44 @@ int sepol_context_to_string(sepol_<wbr>handl=
e_t * handle,<br>
&gt;&gt; =C2=A0{<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0const int user_sz =3D strlen(con-&gt;u=
ser);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0const int role_sz =3D strlen(con-&gt;r=
ole);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0const int type_sz =3D strlen(con-&gt;t=
ype);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0const int mls_sz =3D (con-&gt;mls) ? s=
trlen(con-&gt;mls) : 0;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0const int total_sz =3D user_sz + role_=
sz + type_sz +<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mls_sz + ((con-&gt;mls) =
? 3 : 2);<br>
&gt;&gt; -<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0char *str =3D (char *)malloc(total_sz =
+ 1);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!str)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto omem;=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *str =3D NULL;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const size_t user_sz =3D strlen(con-&g=
t;user);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const size_t role_sz =3D strlen(con-&g=
t;role);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const size_t type_sz =3D strlen(con-&g=
t;type);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const size_t mls_sz =3D (con-&gt;mls) =
? strlen(con-&gt;mls) : 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0const size_t total_sz =3D user_sz + ro=
le_sz + type_sz +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mls_sz + ((con-&gt;mls) =
? 3 : 2) + 1;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(total_sz)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(handle=
, &quot;invalid size&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D (char *)malloc(total_sz);<br>
&gt;<br>
&gt;<br>
&gt; Before, total_sz + 1 was malloc&#39;d, so it made sense to check for s=
aturation, but you add the 1 to total_sz before checking for saturation.</p=
>
</div></div><p dir=3D"ltr">True I didn&#39;t want to get rid of the const s=
o we should be checking for 0 or 1 length, or drop the const and check prio=
r to the increment.</p><span class=3D"">
<p dir=3D"ltr">&gt;<br>
&gt; This case is also different in that multiple string lengths are being =
added, so overflow would be the real concern here, but I don&#39;t think th=
at it is possible to overflow because of limits in checkpolicy (8K) and xat=
trs (64K).</p>
</span><p dir=3D"ltr">Check policy isn&#39;t generating any of this and the=
 xattr limits are not being enforced here. In theory we could make the chec=
k on the xattr limits if that woukd be preferred.</p></blockquote><div>Curr=
ently, in file-systems like reiserFS that support scalable xattrs, only VFS=
 is the one limiting the size to 64k. Since their is no constant, and maybe=
 one day this arbitrary VFS limit</div><div>would be removed, I think we sh=
ould check correctlly here that were allocating &gt; 1 bytes, and we keep t=
otal_sz a const.=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div cl=
ass=3D"h5"><br>
&gt;<br>
&gt; Jim<br>
&gt;<br>
&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!str) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(handle=
, &quot;out of memory&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (con-&gt;mls) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snp=
rintf(str, total_sz + 1, &quot;%s:%s:%s:%s&quot;,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snp=
rintf(str, total_sz, &quot;%s:%s:%s:%s&quot;,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 con-&gt;user, con-&gt;role, con-&gt;=
type, con-&gt;mls);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt=
; 0 || (rc &gt;=3D total_sz + 1)) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ERR(handle, &quot;print error&quot;);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snp=
rintf(str, total_sz + 1, &quot;%s:%s:%s&quot;,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D snp=
rintf(str, total_sz, &quot;%s:%s:%s&quot;,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 con-&gt;user, con-&gt;role, con-&gt;=
type);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt=
; 0 || (rc &gt;=3D total_sz + 1)) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ERR(handle, &quot;print error&quot;);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto err;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * rc is &gt;=3D 0 on the size_t cast =
and is safe to promote<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to an unsigned value.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc &lt; 0 || (size_t)rc &gt;=3D to=
tal_sz) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(handle=
, &quot;print error&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 *str_ptr =3D str;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return STATUS_SUCCESS;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 omem:<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(handle, &quot;out of memory&quot;)=
;<br>
&gt;&gt; -<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0err:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(handle, &quot;could not convert co=
ntext to string&quot;);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(str);<br>
&gt;&gt; diff --git a/libsepol/src/module.c b/libsepol/src/module.c<br>
&gt;&gt; index 1665ede..f25df95 100644<br>
&gt;&gt; --- a/libsepol/src/module.c<br>
&gt;&gt; +++ b/libsepol/src/module.c<br>
&gt;&gt; @@ -30,6 +30,7 @@<br>
&gt;&gt; =C2=A0#include &lt;stdio.h&gt;<br>
&gt;&gt; =C2=A0#include &lt;stdlib.h&gt;<br>
&gt;&gt; =C2=A0#include &lt;limits.h&gt;<br>
&gt;&gt; +#include &lt;inttypes.h&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0#define SEPOL_PACKAGE_SECTION_FC 0xf97cff90<br>
&gt;&gt; =C2=A0#define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91<br>
&gt;&gt; @@ -793,6 +794,12 @@ int sepol_module_package_info(<wbr>struct sep=
ol_policy_file *spf, int *type,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(file-&gt;handle,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;invalid=
 module name length: 0x%&quot;PRIx32,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 *name =3D malloc(len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (!*name) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(file-&gt;handle, &quot;ou=
t of memory&quot;);<br>
&gt;&gt; @@ -814,6 +821,12 @@ int sepol_module_package_info(<wbr>struct sep=
ol_policy_file *spf, int *type,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(file-&gt;handle,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;invalid=
 module version length: 0x%&quot;PRIx32,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 *version =3D malloc(len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (!*version) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(file-&gt;handle, &quot;ou=
t of memory&quot;);<br>
&gt;&gt; diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to=
_cil.c<br>
&gt;&gt; index 36f3b7d..fc65019 100644<br>
&gt;&gt; --- a/libsepol/src/module_to_cil.c<br>
&gt;&gt; +++ b/libsepol/src/module_to_cil.c<br>
&gt;&gt; @@ -47,6 +47,8 @@<br>
&gt;&gt; =C2=A0#include &lt;sepol/policydb/services.h&gt;<br>
&gt;&gt; =C2=A0#include &lt;sepol/policydb/util.h&gt;<br>
&gt;&gt;<br>
&gt;&gt; +#include &quot;private.h&quot;<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0#ifdef __GNUC__<br>
&gt;&gt; =C2=A0#=C2=A0 define UNUSED(x) UNUSED_ ## x __attribute__((__unuse=
d__))<br>
&gt;&gt; =C2=A0#else<br>
&gt;&gt; @@ -124,7 +126,7 @@ static int get_line(char **start, char *end, c=
har **line)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (len =3D 0; p &lt; end &amp;&amp; =
*p !=3D &#39;\n&#39; &amp;&amp; *p !=3D &#39;\0&#39;; p++, len++);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len =3D=3D 0) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len)) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D 0;<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto exit;=
<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c<br>
&gt;&gt; index 971793d..604e022 100644<br>
&gt;&gt; --- a/libsepol/src/policydb.c<br>
&gt;&gt; +++ b/libsepol/src/policydb.c<br>
&gt;&gt; @@ -1911,6 +1911,9 @@ static int perm_read(policydb_t * p<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 perdatum-&gt;s.value =3D le32_to_cpu(b=
uf[1]);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D malloc(len + 1);<br>
&gt;&gt; @@ -1949,6 +1952,9 @@ static int common_read(policydb_t * p, hasht=
ab_t h, struct policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 comdatum-&gt;s.value =3D le32_to_cpu(b=
uf[1]);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (symtab_init(&amp;comdatum-&gt;<wbr=
>permissions, PERM_SYMTAB_SIZE))<br>
&gt;&gt; @@ -2092,7 +2098,11 @@ static int class_read(policydb_t * p, hasht=
ab_t h, struct policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len2 =3D le32_to_cpu(buf[1]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_saturated(len2))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 cladatum-&gt;s.value =3D le32_to_cpu(b=
uf[2]);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (symtab_init(&amp;cladatum-&gt;<wbr=
>permissions, PERM_SYMTAB_SIZE))<br>
&gt;&gt; @@ -2199,6 +2209,9 @@ static int role_read(policydb_t * p, hashtab=
_t h, struct policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 role-&gt;s.value =3D le32_to_cpu(buf[1=
]);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (policydb_has_boundary_<wbr>feature=
(p))<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 role-&gt;b=
ounds =3D le32_to_cpu(buf[2]);<br>
&gt;&gt; @@ -2287,6 +2300,9 @@ static int type_read(policydb_t * p, hashtab=
_t h, struct policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[pos]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 typdatum-&gt;s.value =3D le32_to_cpu(b=
uf[++pos]);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (policydb_has_boundary_<wbr>feature=
(p)) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t p=
roperties;<br>
&gt;&gt; @@ -2447,6 +2463,8 @@ int filename_trans_read(filename_<wbr>trans_=
t **t, struct policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt=
; 0)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le=
32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_o=
r_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D c=
alloc(len + 1, sizeof(*name));<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!name)=
<br>
&gt;&gt; @@ -2556,6 +2574,9 @@ static int ocontext_read_xen(struct policydb=
_compat_info *info,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -1;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -1;<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;<a href=3D"http://u.nam=
e" target=3D"_blank">u.name</a> =3D malloc(len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;<a href=3D"http://=
u.name" target=3D"_blank">u.name</a>)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -1;<br>
&gt;&gt; @@ -2618,6 +2639,8 @@ static int ocontext_read_selinux(struct poli=
cydb_compat_info *info,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -1;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -1;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;<a href=3D"http://u.nam=
e" target=3D"_blank">u.name</a> =3D malloc(len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;<a href=3D"http://=
u.name" target=3D"_blank">u.name</a>)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -1;<br>
&gt;&gt; @@ -2659,6 +2682,8 @@ static int ocontext_read_selinux(struct poli=
cydb_compat_info *info,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -1;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;v.behavior =3D le32_to_=
cpu(buf[0]);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[1]);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return -1;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;<a href=3D"http://u.nam=
e" target=3D"_blank">u.name</a> =3D malloc(len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;<a href=3D"http://=
u.name" target=3D"_blank">u.name</a>)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn -1;<br>
&gt;&gt; @@ -2719,7 +2744,7 @@ static int genfs_read(policydb_t * p, struct=
 policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t buf[1];<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t nel, nel2, len, len2;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 genfs_t *genfs_p, *newgenfs, *genfs;<b=
r>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i, j;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t i, j;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ocontext_t *l, *c, *newc =3D NULL;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
&gt;&gt;<br>
&gt;&gt; @@ -2733,6 +2758,8 @@ static int genfs_read(policydb_t * p, struct=
 policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt=
; 0)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le=
32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_o=
r_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newgenfs =
=3D calloc(1, sizeof(genfs_t));<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!newge=
nfs)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; @@ -2778,6 +2805,8 @@ static int genfs_read(policydb_t * p, struct=
 policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 newc-&gt;<a href=3D"http://u.name" target=3D"_blank">u.na=
me</a> =3D malloc(len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (!newc-&gt;<a href=3D"http://u.name" target=3D"_blank"=
>u.name</a>) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; @@ -2877,6 +2906,9 @@ static int user_read(policydb_t * p, hashtab=
_t h, struct policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 usrdatum-&gt;s.value =3D le32_to_cpu(b=
uf[1]);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (policydb_has_boundary_<wbr>feature=
(p))<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usrdatum-&=
gt;bounds =3D le32_to_cpu(buf[2]);<br>
&gt;&gt; @@ -2960,6 +2992,9 @@ static int sens_read(policydb_t * p<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 levdatum-&gt;isalias =3D le32_to_cpu(b=
uf[1]);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D malloc(len + 1);<br>
&gt;&gt; @@ -3003,6 +3038,9 @@ static int cat_read(policydb_t * p<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<=
br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if(zero_or_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto bad;<=
br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 catdatum-&gt;s.value =3D le32_to_cpu(b=
uf[1]);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 catdatum-&gt;isalias =3D le32_to_cpu(b=
uf[2]);<br>
&gt;&gt;<br>
&gt;&gt; @@ -3339,6 +3377,8 @@ static int filename_trans_rule_read(<wbr>fil=
ename_trans_rule_t ** r, struct policy_fi<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le=
32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_o=
r_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ftr-&gt;na=
me =3D malloc(len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ftr-&=
gt;name)<br>
&gt;&gt; @@ -3580,6 +3620,8 @@ static int scope_read(policydb_t * p, int sy=
mnum, struct policy_file *fp)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto clean=
up;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 key_len =3D le32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_or_saturated(key_len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto clean=
up;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D malloc(key_len + 1);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!key)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto clean=
up;<br>
&gt;&gt; @@ -3664,8 +3706,8 @@ int policydb_read(policydb_t * p, struct pol=
icy_file *fp, unsigned verbose)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D buf[1];<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt; POLICYDB_STRING_MAX_LENGT=
H) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(fp-&gt=
;handle, &quot;policydb string length too long &quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (len =3D=3D 0 || len &gt; POLICYDB_=
STRING_MAX_LENGTH) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(fp-&gt=
;handle, &quot;policydb string length %s &quot;, len ? &quot;too long&quot;=
 : &quot;zero&quot;);<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return POL=
ICYDB_ERROR;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; @@ -3798,6 +3840,8 @@ int policydb_read(policydb_t * p, struct pol=
icy_file *fp, unsigned verbose)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le=
32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_o=
r_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((p-&gt=
;name =3D malloc(len + 1)) =3D=3D NULL) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; @@ -3809,6 +3853,8 @@ int policydb_read(policydb_t * p, struct pol=
icy_file *fp, unsigned verbose)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D le=
32_to_cpu(buf[0]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (zero_o=
r_saturated(len))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((p-&gt=
;version =3D malloc(len + 1)) =3D=3D NULL) {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto bad;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; diff --git a/libsepol/src/private.h b/libsepol/src/private.h<br>
&gt;&gt; index 9c700c9..0beb4d4 100644<br>
&gt;&gt; --- a/libsepol/src/private.h<br>
&gt;&gt; +++ b/libsepol/src/private.h<br>
&gt;&gt; @@ -45,6 +45,9 @@<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0#define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))<br>
&gt;&gt;<br>
&gt;&gt; +#define is_saturated(x) (x =3D=3D (typeof(x))-1)<br>
&gt;&gt; +#define zero_or_saturated(x) ((x =3D=3D 0) || is_saturated(x))<br=
>
&gt;&gt; +<br>
&gt;&gt; =C2=A0/* Policy compatibility information. */<br>
&gt;&gt; =C2=A0struct policydb_compat_info {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int type;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; -- <br>
&gt; James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" target=3D"_b=
lank">jwcart2@tycho.nsa.gov</a>&gt;<br>
&gt; National Security Agency<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Seandroid-list mailing list<br>
&gt; <a href=3D"mailto:Seandroid-list@tycho.nsa.gov" target=3D"_blank">Sean=
droid-list@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@t=
ycho.nsa.gov" target=3D"_blank">Seandroid-list-leave@tycho.<wbr>nsa.gov</a>=
.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Seandroid-list-request@tycho.nsa.gov" target=3D"_blank">Seandroid-lis=
t-request@tycho.<wbr>nsa.gov</a>.<br>
</div></div><p></p>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature">Respectfully,<br><b=
r>William C Roberts<br><br></div>
</div></div>

--001a113a6878c7c99f053a321f3f--
