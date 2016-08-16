MIME-Version: 1.0
In-Reply-To: <CAFftDdqPOgi7ZBmscF-vUA=PMbMscrV2kOU2E=ODw-afUzOOhg@mail.gmail.com>
References: <1471276754-25266-1-git-send-email-william.c.roberts@intel.com>
 <1471276754-25266-6-git-send-email-william.c.roberts@intel.com>
 <9ca86776-3817-1c5d-dca4-7490cd70212d@tycho.nsa.gov>
 <CAFftDdqDRinx5w-GaapnCRAMrhjxYwKjPxvogrvxDX+p3ASzPg@mail.gmail.com>
 <CAFftDdqPOgi7ZBmscF-vUA=PMbMscrV2kOU2E=ODw-afUzOOhg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 16 Aug 2016 10:16:31 -0700
Message-ID: <CAFftDdpxGbzPRP0LsU+r=NXra4Q57Yte5ApAS_Ksqt2LmPdXJQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] libsepol: fix overflow and 0 length allocations
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 16, 2016 at 8:37 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
>
>
> On Tue, Aug 16, 2016 at 8:11 AM, William Roberts <bill.c.roberts@gmail.com>
> wrote:
>>
>> On Aug 16, 2016 06:12, "James Carter" <jwcart2@tycho.nsa.gov> wrote:
>> >
>> > On 08/15/2016 11:59 AM, william.c.roberts@intel.com wrote:
>> >>
>> >> From: William Roberts <william.c.roberts@intel.com>
>> >>
>> >> Throughout libsepol, values taken from sepolicy are used in
>> >> places where length == 0 or length == <saturated> matter,
>> >> find and fix these.
>> >>
>> >> Also, correct any type mismatches noticed along the way.
>> >>
>> >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> >> ---
>> >>  libsepol/src/conditional.c    |  3 ++-
>> >>  libsepol/src/context.c        | 16 ++++++++-----
>> >>  libsepol/src/context_record.c | 52
>> >> ++++++++++++++++++++++++-------------------
>> >>  libsepol/src/module.c         | 13 +++++++++++
>> >>  libsepol/src/module_to_cil.c  |  4 +++-
>> >>  libsepol/src/policydb.c       | 52
>> >> ++++++++++++++++++++++++++++++++++++++++---
>> >>  libsepol/src/private.h        |  3 +++
>> >>  7 files changed, 110 insertions(+), 33 deletions(-)
>> >>
>> >
>> >
>> >> diff --git a/libsepol/src/context_record.c
>> >> b/libsepol/src/context_record.c
>> >> index ac2884a..fdf60a0 100644
>> >> --- a/libsepol/src/context_record.c
>> >> +++ b/libsepol/src/context_record.c
>> >> @@ -5,6 +5,7 @@
>> >>
>> >>  #include "context_internal.h"
>> >>  #include "debug.h"
>> >> +#include "private.h"
>> >>
>> >>  struct sepol_context {
>> >>
>> >> @@ -284,39 +285,44 @@ int sepol_context_to_string(sepol_handle_t *
>> >> handle,
>> >>  {
>> >>
>> >>         int rc;
>> >> -       const int user_sz = strlen(con->user);
>> >> -       const int role_sz = strlen(con->role);
>> >> -       const int type_sz = strlen(con->type);
>> >> -       const int mls_sz = (con->mls) ? strlen(con->mls) : 0;
>> >> -       const int total_sz = user_sz + role_sz + type_sz +
>> >> -           mls_sz + ((con->mls) ? 3 : 2);
>> >> -
>> >> -       char *str = (char *)malloc(total_sz + 1);
>> >> -       if (!str)
>> >> -               goto omem;
>> >> +       char *str = NULL;
>> >> +       const size_t user_sz = strlen(con->user);
>> >> +       const size_t role_sz = strlen(con->role);
>> >> +       const size_t type_sz = strlen(con->type);
>> >> +       const size_t mls_sz = (con->mls) ? strlen(con->mls) : 0;
>> >> +       const size_t total_sz = user_sz + role_sz + type_sz +
>> >> +           mls_sz + ((con->mls) ? 3 : 2) + 1;
>> >> +
>> >> +       if (zero_or_saturated(total_sz)) {
>> >> +               ERR(handle, "invalid size");
>> >> +               goto err;
>> >> +       }
>> >>
>> >> +       str = (char *)malloc(total_sz);
>> >
>> >
>> > Before, total_sz + 1 was malloc'd, so it made sense to check for
>> > saturation, but you add the 1 to total_sz before checking for saturation.
>>
>> True I didn't want to get rid of the const so we should be checking for 0
>> or 1 length, or drop the const and check prior to the increment.
>>
>> >
>> > This case is also different in that multiple string lengths are being
>> > added, so overflow would be the real concern here, but I don't think that it
>> > is possible to overflow because of limits in checkpolicy (8K) and xattrs
>> > (64K).
>>
>> Check policy isn't generating any of this and the xattr limits are not
>> being enforced here. In theory we could make the check on the xattr limits
>> if that woukd be preferred.
>
> Currently, in file-systems like reiserFS that support scalable xattrs, only
> VFS is the one limiting the size to 64k. Since their is no constant, and
> maybe one day this arbitrary VFS limit
> would be removed, I think we should check correctlly here that were
> allocating > 1 bytes, and we keep total_sz a const.


BTW do you want to take everything up to this patchset and I can
rebase on the repo
instead of sending out so many patches each time. This is me assuming the others
are ok by lack of commentary.

>>
>>
>> >
>> > Jim
>> >
>> >
>> >> +       if (!str) {
>> >> +               ERR(handle, "out of memory");
>> >> +               goto err;
>> >> +       }
>> >>         if (con->mls) {
>> >> -               rc = snprintf(str, total_sz + 1, "%s:%s:%s:%s",
>> >> +               rc = snprintf(str, total_sz, "%s:%s:%s:%s",
>> >>                               con->user, con->role, con->type,
>> >> con->mls);
>> >> -               if (rc < 0 || (rc >= total_sz + 1)) {
>> >> -                       ERR(handle, "print error");
>> >> -                       goto err;
>> >> -               }
>> >>         } else {
>> >> -               rc = snprintf(str, total_sz + 1, "%s:%s:%s",
>> >> +               rc = snprintf(str, total_sz, "%s:%s:%s",
>> >>                               con->user, con->role, con->type);
>> >> -               if (rc < 0 || (rc >= total_sz + 1)) {
>> >> -                       ERR(handle, "print error");
>> >> -                       goto err;
>> >> -               }
>> >> +       }
>> >> +
>> >> +       /*
>> >> +        * rc is >= 0 on the size_t cast and is safe to promote
>> >> +        * to an unsigned value.
>> >> +        */
>> >> +       if (rc < 0 || (size_t)rc >= total_sz) {
>> >> +               ERR(handle, "print error");
>> >> +               goto err;
>> >>         }
>> >>
>> >>         *str_ptr = str;
>> >>         return STATUS_SUCCESS;
>> >>
>> >> -      omem:
>> >> -       ERR(handle, "out of memory");
>> >> -
>> >>        err:
>> >>         ERR(handle, "could not convert context to string");
>> >>         free(str);
>> >> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
>> >> index 1665ede..f25df95 100644
>> >> --- a/libsepol/src/module.c
>> >> +++ b/libsepol/src/module.c
>> >> @@ -30,6 +30,7 @@
>> >>  #include <stdio.h>
>> >>  #include <stdlib.h>
>> >>  #include <limits.h>
>> >> +#include <inttypes.h>
>> >>
>> >>  #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
>> >>  #define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91
>> >> @@ -793,6 +794,12 @@ int sepol_module_package_info(struct
>> >> sepol_policy_file *spf, int *type,
>> >>                                 goto cleanup;
>> >>                         }
>> >>                         len = le32_to_cpu(buf[0]);
>> >> +                       if (zero_or_saturated(len)) {
>> >> +                               ERR(file->handle,
>> >> +                                   "invalid module name length:
>> >> 0x%"PRIx32,
>> >> +                                   len);
>> >> +                               goto cleanup;
>> >> +                       }
>> >>                         *name = malloc(len + 1);
>> >>                         if (!*name) {
>> >>                                 ERR(file->handle, "out of memory");
>> >> @@ -814,6 +821,12 @@ int sepol_module_package_info(struct
>> >> sepol_policy_file *spf, int *type,
>> >>                                 goto cleanup;
>> >>                         }
>> >>                         len = le32_to_cpu(buf[0]);
>> >> +                       if (zero_or_saturated(len)) {
>> >> +                               ERR(file->handle,
>> >> +                                   "invalid module version length:
>> >> 0x%"PRIx32,
>> >> +                                   len);
>> >> +                               goto cleanup;
>> >> +                       }
>> >>                         *version = malloc(len + 1);
>> >>                         if (!*version) {
>> >>                                 ERR(file->handle, "out of memory");
>> >> diff --git a/libsepol/src/module_to_cil.c
>> >> b/libsepol/src/module_to_cil.c
>> >> index 36f3b7d..fc65019 100644
>> >> --- a/libsepol/src/module_to_cil.c
>> >> +++ b/libsepol/src/module_to_cil.c
>> >> @@ -47,6 +47,8 @@
>> >>  #include <sepol/policydb/services.h>
>> >>  #include <sepol/policydb/util.h>
>> >>
>> >> +#include "private.h"
>> >> +
>> >>  #ifdef __GNUC__
>> >>  #  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))
>> >>  #else
>> >> @@ -124,7 +126,7 @@ static int get_line(char **start, char *end, char
>> >> **line)
>> >>
>> >>         for (len = 0; p < end && *p != '\n' && *p != '\0'; p++, len++);
>> >>
>> >> -       if (len == 0) {
>> >> +       if (zero_or_saturated(len)) {
>> >>                 rc = 0;
>> >>                 goto exit;
>> >>         }
>> >> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> >> index 971793d..604e022 100644
>> >> --- a/libsepol/src/policydb.c
>> >> +++ b/libsepol/src/policydb.c
>> >> @@ -1911,6 +1911,9 @@ static int perm_read(policydb_t * p
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[0]);
>> >> +       if (zero_or_saturated(len))
>> >> +               goto bad;
>> >> +
>> >>         perdatum->s.value = le32_to_cpu(buf[1]);
>> >>
>> >>         key = malloc(len + 1);
>> >> @@ -1949,6 +1952,9 @@ static int common_read(policydb_t * p, hashtab_t
>> >> h, struct policy_file *fp)
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[0]);
>> >> +       if (zero_or_saturated(len))
>> >> +               goto bad;
>> >> +
>> >>         comdatum->s.value = le32_to_cpu(buf[1]);
>> >>
>> >>         if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
>> >> @@ -2092,7 +2098,11 @@ static int class_read(policydb_t * p, hashtab_t
>> >> h, struct policy_file *fp)
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[0]);
>> >> +       if (zero_or_saturated(len))
>> >> +               goto bad;
>> >>         len2 = le32_to_cpu(buf[1]);
>> >> +       if (is_saturated(len2))
>> >> +               goto bad;
>> >>         cladatum->s.value = le32_to_cpu(buf[2]);
>> >>
>> >>         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
>> >> @@ -2199,6 +2209,9 @@ static int role_read(policydb_t * p, hashtab_t h,
>> >> struct policy_file *fp)
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[0]);
>> >> +       if (zero_or_saturated(len))
>> >> +               goto bad;
>> >> +
>> >>         role->s.value = le32_to_cpu(buf[1]);
>> >>         if (policydb_has_boundary_feature(p))
>> >>                 role->bounds = le32_to_cpu(buf[2]);
>> >> @@ -2287,6 +2300,9 @@ static int type_read(policydb_t * p, hashtab_t h,
>> >> struct policy_file *fp)
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[pos]);
>> >> +       if (zero_or_saturated(len))
>> >> +               goto bad;
>> >> +
>> >>         typdatum->s.value = le32_to_cpu(buf[++pos]);
>> >>         if (policydb_has_boundary_feature(p)) {
>> >>                 uint32_t properties;
>> >> @@ -2447,6 +2463,8 @@ int filename_trans_read(filename_trans_t **t,
>> >> struct policy_file *fp)
>> >>                 if (rc < 0)
>> >>                         return -1;
>> >>                 len = le32_to_cpu(buf[0]);
>> >> +               if (zero_or_saturated(len))
>> >> +                       return -1;
>> >>
>> >>                 name = calloc(len + 1, sizeof(*name));
>> >>                 if (!name)
>> >> @@ -2556,6 +2574,9 @@ static int ocontext_read_xen(struct
>> >> policydb_compat_info *info,
>> >>                                 if (rc < 0)
>> >>                                         return -1;
>> >>                                 len = le32_to_cpu(buf[0]);
>> >> +                               if (zero_or_saturated(len))
>> >> +                                       return -1;
>> >> +
>> >>                                 c->u.name = malloc(len + 1);
>> >>                                 if (!c->u.name)
>> >>                                         return -1;
>> >> @@ -2618,6 +2639,8 @@ static int ocontext_read_selinux(struct
>> >> policydb_compat_info *info,
>> >>                                 if (rc < 0)
>> >>                                         return -1;
>> >>                                 len = le32_to_cpu(buf[0]);
>> >> +                               if (zero_or_saturated(len))
>> >> +                                       return -1;
>> >>                                 c->u.name = malloc(len + 1);
>> >>                                 if (!c->u.name)
>> >>                                         return -1;
>> >> @@ -2659,6 +2682,8 @@ static int ocontext_read_selinux(struct
>> >> policydb_compat_info *info,
>> >>                                         return -1;
>> >>                                 c->v.behavior = le32_to_cpu(buf[0]);
>> >>                                 len = le32_to_cpu(buf[1]);
>> >> +                               if (zero_or_saturated(len))
>> >> +                                       return -1;
>> >>                                 c->u.name = malloc(len + 1);
>> >>                                 if (!c->u.name)
>> >>                                         return -1;
>> >> @@ -2719,7 +2744,7 @@ static int genfs_read(policydb_t * p, struct
>> >> policy_file *fp)
>> >>         uint32_t buf[1];
>> >>         size_t nel, nel2, len, len2;
>> >>         genfs_t *genfs_p, *newgenfs, *genfs;
>> >> -       unsigned int i, j;
>> >> +       size_t i, j;
>> >>         ocontext_t *l, *c, *newc = NULL;
>> >>         int rc;
>> >>
>> >> @@ -2733,6 +2758,8 @@ static int genfs_read(policydb_t * p, struct
>> >> policy_file *fp)
>> >>                 if (rc < 0)
>> >>                         goto bad;
>> >>                 len = le32_to_cpu(buf[0]);
>> >> +               if (zero_or_saturated(len))
>> >> +                       goto bad;
>> >>                 newgenfs = calloc(1, sizeof(genfs_t));
>> >>                 if (!newgenfs)
>> >>                         goto bad;
>> >> @@ -2778,6 +2805,8 @@ static int genfs_read(policydb_t * p, struct
>> >> policy_file *fp)
>> >>                         if (rc < 0)
>> >>                                 goto bad;
>> >>                         len = le32_to_cpu(buf[0]);
>> >> +                       if (zero_or_saturated(len))
>> >> +                               goto bad;
>> >>                         newc->u.name = malloc(len + 1);
>> >>                         if (!newc->u.name) {
>> >>                                 goto bad;
>> >> @@ -2877,6 +2906,9 @@ static int user_read(policydb_t * p, hashtab_t h,
>> >> struct policy_file *fp)
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[0]);
>> >> +       if (zero_or_saturated(len))
>> >> +               goto bad;
>> >> +
>> >>         usrdatum->s.value = le32_to_cpu(buf[1]);
>> >>         if (policydb_has_boundary_feature(p))
>> >>                 usrdatum->bounds = le32_to_cpu(buf[2]);
>> >> @@ -2960,6 +2992,9 @@ static int sens_read(policydb_t * p
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[0]);
>> >> +       if (zero_or_saturated(len))
>> >> +               goto bad;
>> >> +
>> >>         levdatum->isalias = le32_to_cpu(buf[1]);
>> >>
>> >>         key = malloc(len + 1);
>> >> @@ -3003,6 +3038,9 @@ static int cat_read(policydb_t * p
>> >>                 goto bad;
>> >>
>> >>         len = le32_to_cpu(buf[0]);
>> >> +       if(zero_or_saturated(len))
>> >> +               goto bad;
>> >> +
>> >>         catdatum->s.value = le32_to_cpu(buf[1]);
>> >>         catdatum->isalias = le32_to_cpu(buf[2]);
>> >>
>> >> @@ -3339,6 +3377,8 @@ static int
>> >> filename_trans_rule_read(filename_trans_rule_t ** r, struct policy_fi
>> >>                         return -1;
>> >>
>> >>                 len = le32_to_cpu(buf[0]);
>> >> +               if (zero_or_saturated(len))
>> >> +                       return -1;
>> >>
>> >>                 ftr->name = malloc(len + 1);
>> >>                 if (!ftr->name)
>> >> @@ -3580,6 +3620,8 @@ static int scope_read(policydb_t * p, int symnum,
>> >> struct policy_file *fp)
>> >>         if (rc < 0)
>> >>                 goto cleanup;
>> >>         key_len = le32_to_cpu(buf[0]);
>> >> +       if (zero_or_saturated(key_len))
>> >> +               goto cleanup;
>> >>         key = malloc(key_len + 1);
>> >>         if (!key)
>> >>                 goto cleanup;
>> >> @@ -3664,8 +3706,8 @@ int policydb_read(policydb_t * p, struct
>> >> policy_file *fp, unsigned verbose)
>> >>         }
>> >>
>> >>         len = buf[1];
>> >> -       if (len > POLICYDB_STRING_MAX_LENGTH) {
>> >> -               ERR(fp->handle, "policydb string length too long ");
>> >> +       if (len == 0 || len > POLICYDB_STRING_MAX_LENGTH) {
>> >> +               ERR(fp->handle, "policydb string length %s ", len ?
>> >> "too long" : "zero");
>> >>                 return POLICYDB_ERROR;
>> >>         }
>> >>
>> >> @@ -3798,6 +3840,8 @@ int policydb_read(policydb_t * p, struct
>> >> policy_file *fp, unsigned verbose)
>> >>                         goto bad;
>> >>                 }
>> >>                 len = le32_to_cpu(buf[0]);
>> >> +               if (zero_or_saturated(len))
>> >> +                       goto bad;
>> >>                 if ((p->name = malloc(len + 1)) == NULL) {
>> >>                         goto bad;
>> >>                 }
>> >> @@ -3809,6 +3853,8 @@ int policydb_read(policydb_t * p, struct
>> >> policy_file *fp, unsigned verbose)
>> >>                         goto bad;
>> >>                 }
>> >>                 len = le32_to_cpu(buf[0]);
>> >> +               if (zero_or_saturated(len))
>> >> +                       goto bad;
>> >>                 if ((p->version = malloc(len + 1)) == NULL) {
>> >>                         goto bad;
>> >>                 }
>> >> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
>> >> index 9c700c9..0beb4d4 100644
>> >> --- a/libsepol/src/private.h
>> >> +++ b/libsepol/src/private.h
>> >> @@ -45,6 +45,9 @@
>> >>
>> >>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
>> >>
>> >> +#define is_saturated(x) (x == (typeof(x))-1)
>> >> +#define zero_or_saturated(x) ((x == 0) || is_saturated(x))
>> >> +
>> >>  /* Policy compatibility information. */
>> >>  struct policydb_compat_info {
>> >>         unsigned int type;
>> >>
>> >
>> >
>> > --
>> > James Carter <jwcart2@tycho.nsa.gov>
>> > National Security Agency
>> >
>> > _______________________________________________
>> > Seandroid-list mailing list
>> > Seandroid-list@tycho.nsa.gov
>> > To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
>> > To get help, send an email containing "help" to
>> > Seandroid-list-request@tycho.nsa.gov.
>
>
>
>
> --
> Respectfully,
>
> William C Roberts
>



-- 
Respectfully,

William C Roberts
