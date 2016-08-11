MIME-Version: 1.0
In-Reply-To: <a41ef281-f0c6-ebc3-28c3-29d7bfe9bde3@tycho.nsa.gov>
References: <1470868560-31328-1-git-send-email-william.c.roberts@intel.com>
 <1470868560-31328-5-git-send-email-william.c.roberts@intel.com>
 <a41ef281-f0c6-ebc3-28c3-29d7bfe9bde3@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 11 Aug 2016 12:35:29 -0700
Message-ID: <CAFftDdqs56JXJrhs79zsU6h7_veWFG7nsMrywsNRd8Zg6riSWA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] libsepol: fix overflow and 0 length allocations
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113a68785c19830539d0de77
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113a68785c19830539d0de77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2016 at 12:14 PM, James Carter <jwcart2@tycho.nsa.gov>
wrote:

> On 08/10/2016 06:36 PM, william.c.roberts@intel.com wrote:
>
>> From: William Roberts <william.c.roberts@intel.com>
>>
>> Throughout libsepol, values taken from sepolicy are used in
>> places where length =3D=3D 0 or length =3D=3D <saturated> matter,
>> find and fix these.
>>
>> Also, correct any type mismatches noticed along the way.
>>
>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> ---
>>  libsepol/src/conditional.c    |  3 ++-
>>  libsepol/src/context.c        | 16 +++++++++-----
>>  libsepol/src/context_record.c | 26 ++++++++++++----------
>>  libsepol/src/module.c         | 13 +++++++++++
>>  libsepol/src/module_to_cil.c  |  4 +++-
>>  libsepol/src/policydb.c       | 50 ++++++++++++++++++++++++++++++
>> ++++++++++---
>>  libsepol/src/private.h        |  3 +++
>>  7 files changed, 94 insertions(+), 21 deletions(-)
>>
>> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
>> index ea47cdd..8680eb2 100644
>> --- a/libsepol/src/conditional.c
>> +++ b/libsepol/src/conditional.c
>> @@ -589,7 +589,8 @@ int cond_read_bool(policydb_t * p,
>>                 goto err;
>>
>>         len =3D le32_to_cpu(buf[2]);
>> -
>> +       if (zero_or_saturated(len))
>> +               goto err;
>>         key =3D malloc(len + 1);
>>         if (!key)
>>                 goto err;
>> diff --git a/libsepol/src/context.c b/libsepol/src/context.c
>> index 84dad34..39552f2 100644
>> --- a/libsepol/src/context.c
>> +++ b/libsepol/src/context.c
>> @@ -10,6 +10,7 @@
>>  #include "context.h"
>>  #include "handle.h"
>>  #include "mls.h"
>> +#include "private.h"
>>
>>  /* ----- Compatibility ---- */
>>  int policydb_context_isvalid(const policydb_t * p, const
>> context_struct_t * c)
>> @@ -297,10 +298,18 @@ int context_from_string(sepol_handle_t * handle,
>>         char *con_cpy =3D NULL;
>>         sepol_context_t *ctx_record =3D NULL;
>>
>> +       if (zero_or_saturated(con_str_len)) {
>> +               ERR(handle, "Invalid context length");
>> +               goto err;
>> +       }
>> +
>>         /* sepol_context_from_string expects a NULL-terminated string */
>>         con_cpy =3D malloc(con_str_len + 1);
>> -       if (!con_cpy)
>> -               goto omem;
>> +       if (!con_cpy) {
>> +               ERR(handle, "out of memory");
>> +               goto err;
>> +       }
>> +
>>         memcpy(con_cpy, con_str, con_str_len);
>>         con_cpy[con_str_len] =3D '\0';
>>
>> @@ -315,9 +324,6 @@ int context_from_string(sepol_handle_t * handle,
>>         sepol_context_free(ctx_record);
>>         return STATUS_SUCCESS;
>>
>> -      omem:
>> -       ERR(handle, "out of memory");
>> -
>>        err:
>>         ERR(handle, "could not create context structure");
>>         free(con_cpy);
>> diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record=
.
>> c
>> index ac2884a..01fd2c9 100644
>> --- a/libsepol/src/context_record.c
>> +++ b/libsepol/src/context_record.c
>> @@ -5,6 +5,7 @@
>>
>>  #include "context_internal.h"
>>  #include "debug.h"
>> +#include "private.h"
>>
>>  struct sepol_context {
>>
>> @@ -284,17 +285,23 @@ int sepol_context_to_string(sepol_handle_t *
>> handle,
>>  {
>>
>>         int rc;
>> -       const int user_sz =3D strlen(con->user);
>> -       const int role_sz =3D strlen(con->role);
>> -       const int type_sz =3D strlen(con->type);
>> -       const int mls_sz =3D (con->mls) ? strlen(con->mls) : 0;
>> -       const int total_sz =3D user_sz + role_sz + type_sz +
>> +       const size_t user_sz =3D strlen(con->user);
>> +       const size_t role_sz =3D strlen(con->role);
>> +       const size_t type_sz =3D strlen(con->type);
>> +       const size_t mls_sz =3D (con->mls) ? strlen(con->mls) : 0;
>> +       const size_t total_sz =3D user_sz + role_sz + type_sz +
>>             mls_sz + ((con->mls) ? 3 : 2);
>>
>> -       char *str =3D (char *)malloc(total_sz + 1);
>> -       if (!str)
>> -               goto omem;
>> +       if (zero_or_saturated(total_sz)) {
>> +               ERR(handle, "invalid size");
>> +               goto err;
>> +       }
>>
>> +       char *str =3D (char *)malloc(total_sz + 1);
>> +       if (!str) {
>> +               ERR(handle, "out of memory");
>> +               goto err;
>> +       }
>>         if (con->mls) {
>>                 rc =3D snprintf(str, total_sz + 1, "%s:%s:%s:%s",
>>                               con->user, con->role, con->type, con->mls)=
;
>>
>
> I get the following errors when compiling:
>
> context_record.c: In function =E2=80=98sepol_context_to_string=E2=80=99:
> context_record.c:308:21: error: comparison between signed and unsigned
> integer expressions [-Werror=3Dsign-compare]
>    if (rc < 0 || (rc >=3D total_sz + 1)) {
>                      ^~
> context_record.c:315:21: error: comparison between signed and unsigned
> integer expressions [-Werror=3Dsign-compare]
>    if (rc < 0 || (rc >=3D total_sz + 1)) {
>                      ^~
> context_record.c:326:2: error: =E2=80=98str=E2=80=99 may be used uninitia=
lized in this
> function [-Werror=3Dmaybe-uninitialized]
>   free(str);
>   ^~~~~~~~~
>

Interesting, i'm not seeing these, ill roll these into v3 and see if I can
reproduce to make sure they
don't come back.


>
> Jim
>
> @@ -314,9 +321,6 @@ int sepol_context_to_string(sepol_handle_t * handle,
>>         *str_ptr =3D str;
>>         return STATUS_SUCCESS;
>>
>> -      omem:
>> -       ERR(handle, "out of memory");
>> -
>>        err:
>>         ERR(handle, "could not convert context to string");
>>         free(str);
>> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
>> index 1665ede..f25df95 100644
>> --- a/libsepol/src/module.c
>> +++ b/libsepol/src/module.c
>> @@ -30,6 +30,7 @@
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <limits.h>
>> +#include <inttypes.h>
>>
>>  #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
>>  #define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91
>> @@ -793,6 +794,12 @@ int sepol_module_package_info(struct
>> sepol_policy_file *spf, int *type,
>>                                 goto cleanup;
>>                         }
>>                         len =3D le32_to_cpu(buf[0]);
>> +                       if (zero_or_saturated(len)) {
>> +                               ERR(file->handle,
>> +                                   "invalid module name length:
>> 0x%"PRIx32,
>> +                                   len);
>> +                               goto cleanup;
>> +                       }
>>                         *name =3D malloc(len + 1);
>>                         if (!*name) {
>>                                 ERR(file->handle, "out of memory");
>> @@ -814,6 +821,12 @@ int sepol_module_package_info(struct
>> sepol_policy_file *spf, int *type,
>>                                 goto cleanup;
>>                         }
>>                         len =3D le32_to_cpu(buf[0]);
>> +                       if (zero_or_saturated(len)) {
>> +                               ERR(file->handle,
>> +                                   "invalid module version length:
>> 0x%"PRIx32,
>> +                                   len);
>> +                               goto cleanup;
>> +                       }
>>                         *version =3D malloc(len + 1);
>>                         if (!*version) {
>>                                 ERR(file->handle, "out of memory");
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index 36f3b7d..fc65019 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -47,6 +47,8 @@
>>  #include <sepol/policydb/services.h>
>>  #include <sepol/policydb/util.h>
>>
>> +#include "private.h"
>> +
>>  #ifdef __GNUC__
>>  #  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))
>>  #else
>> @@ -124,7 +126,7 @@ static int get_line(char **start, char *end, char
>> **line)
>>
>>         for (len =3D 0; p < end && *p !=3D '\n' && *p !=3D '\0'; p++, le=
n++);
>>
>> -       if (len =3D=3D 0) {
>> +       if (zero_or_saturated(len)) {
>>                 rc =3D 0;
>>                 goto exit;
>>         }
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index 971793d..2267387 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>> @@ -1911,6 +1911,9 @@ static int perm_read(policydb_t * p
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[0]);
>> +       if (zero_or_saturated(len))
>> +               goto bad;
>> +
>>         perdatum->s.value =3D le32_to_cpu(buf[1]);
>>
>>         key =3D malloc(len + 1);
>> @@ -1949,6 +1952,9 @@ static int common_read(policydb_t * p, hashtab_t h=
,
>> struct policy_file *fp)
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[0]);
>> +       if (zero_or_saturated(len))
>> +               goto bad;
>> +
>>         comdatum->s.value =3D le32_to_cpu(buf[1]);
>>
>>         if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
>> @@ -2092,7 +2098,11 @@ static int class_read(policydb_t * p, hashtab_t h=
,
>> struct policy_file *fp)
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[0]);
>> +       if (zero_or_saturated(len))
>> +               goto bad;
>>         len2 =3D le32_to_cpu(buf[1]);
>> +       if (is_saturated(len2))
>> +               goto bad;
>>         cladatum->s.value =3D le32_to_cpu(buf[2]);
>>
>>         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
>> @@ -2199,6 +2209,9 @@ static int role_read(policydb_t * p, hashtab_t h,
>> struct policy_file *fp)
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[0]);
>> +       if (zero_or_saturated(len))
>> +               goto bad;
>> +
>>         role->s.value =3D le32_to_cpu(buf[1]);
>>         if (policydb_has_boundary_feature(p))
>>                 role->bounds =3D le32_to_cpu(buf[2]);
>> @@ -2287,6 +2300,9 @@ static int type_read(policydb_t * p, hashtab_t h,
>> struct policy_file *fp)
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[pos]);
>> +       if (zero_or_saturated(len))
>> +               goto bad;
>> +
>>         typdatum->s.value =3D le32_to_cpu(buf[++pos]);
>>         if (policydb_has_boundary_feature(p)) {
>>                 uint32_t properties;
>> @@ -2556,6 +2572,9 @@ static int ocontext_read_xen(struct
>> policydb_compat_info *info,
>>                                 if (rc < 0)
>>                                         return -1;
>>                                 len =3D le32_to_cpu(buf[0]);
>> +                               if (zero_or_saturated(len))
>> +                                       return -1;
>> +
>>                                 c->u.name =3D malloc(len + 1);
>>                                 if (!c->u.name)
>>                                         return -1;
>> @@ -2618,6 +2637,8 @@ static int ocontext_read_selinux(struct
>> policydb_compat_info *info,
>>                                 if (rc < 0)
>>                                         return -1;
>>                                 len =3D le32_to_cpu(buf[0]);
>> +                               if (zero_or_saturated(len))
>> +                                       return -1;
>>                                 c->u.name =3D malloc(len + 1);
>>                                 if (!c->u.name)
>>                                         return -1;
>> @@ -2659,6 +2680,8 @@ static int ocontext_read_selinux(struct
>> policydb_compat_info *info,
>>                                         return -1;
>>                                 c->v.behavior =3D le32_to_cpu(buf[0]);
>>                                 len =3D le32_to_cpu(buf[1]);
>> +                               if (zero_or_saturated(len))
>> +                                       return -1;
>>                                 c->u.name =3D malloc(len + 1);
>>                                 if (!c->u.name)
>>                                         return -1;
>> @@ -2719,7 +2742,7 @@ static int genfs_read(policydb_t * p, struct
>> policy_file *fp)
>>         uint32_t buf[1];
>>         size_t nel, nel2, len, len2;
>>         genfs_t *genfs_p, *newgenfs, *genfs;
>> -       unsigned int i, j;
>> +       size_t i, j;
>>         ocontext_t *l, *c, *newc =3D NULL;
>>         int rc;
>>
>> @@ -2733,6 +2756,8 @@ static int genfs_read(policydb_t * p, struct
>> policy_file *fp)
>>                 if (rc < 0)
>>                         goto bad;
>>                 len =3D le32_to_cpu(buf[0]);
>> +               if (zero_or_saturated(len))
>> +                       goto bad;
>>                 newgenfs =3D calloc(1, sizeof(genfs_t));
>>                 if (!newgenfs)
>>                         goto bad;
>> @@ -2778,6 +2803,8 @@ static int genfs_read(policydb_t * p, struct
>> policy_file *fp)
>>                         if (rc < 0)
>>                                 goto bad;
>>                         len =3D le32_to_cpu(buf[0]);
>> +                       if (zero_or_saturated(len))
>> +                               goto bad;
>>                         newc->u.name =3D malloc(len + 1);
>>                         if (!newc->u.name) {
>>                                 goto bad;
>> @@ -2877,6 +2904,9 @@ static int user_read(policydb_t * p, hashtab_t h,
>> struct policy_file *fp)
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[0]);
>> +       if (zero_or_saturated(len))
>> +               goto bad;
>> +
>>         usrdatum->s.value =3D le32_to_cpu(buf[1]);
>>         if (policydb_has_boundary_feature(p))
>>                 usrdatum->bounds =3D le32_to_cpu(buf[2]);
>> @@ -2960,6 +2990,9 @@ static int sens_read(policydb_t * p
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[0]);
>> +       if (zero_or_saturated(len))
>> +               goto bad;
>> +
>>         levdatum->isalias =3D le32_to_cpu(buf[1]);
>>
>>         key =3D malloc(len + 1);
>> @@ -3003,6 +3036,9 @@ static int cat_read(policydb_t * p
>>                 goto bad;
>>
>>         len =3D le32_to_cpu(buf[0]);
>> +       if(zero_or_saturated(len))
>> +               goto bad;
>> +
>>         catdatum->s.value =3D le32_to_cpu(buf[1]);
>>         catdatum->isalias =3D le32_to_cpu(buf[2]);
>>
>> @@ -3339,6 +3375,8 @@ static int filename_trans_rule_read(filename_trans=
_rule_t
>> ** r, struct policy_fi
>>                         return -1;
>>
>>                 len =3D le32_to_cpu(buf[0]);
>> +               if (zero_or_saturated(len))
>> +                       return -1;
>>
>>                 ftr->name =3D malloc(len + 1);
>>                 if (!ftr->name)
>> @@ -3580,6 +3618,8 @@ static int scope_read(policydb_t * p, int symnum,
>> struct policy_file *fp)
>>         if (rc < 0)
>>                 goto cleanup;
>>         key_len =3D le32_to_cpu(buf[0]);
>> +       if (zero_or_saturated(key_len))
>> +               goto cleanup;
>>         key =3D malloc(key_len + 1);
>>         if (!key)
>>                 goto cleanup;
>> @@ -3664,8 +3704,8 @@ int policydb_read(policydb_t * p, struct
>> policy_file *fp, unsigned verbose)
>>         }
>>
>>         len =3D buf[1];
>> -       if (len > POLICYDB_STRING_MAX_LENGTH) {
>> -               ERR(fp->handle, "policydb string length too long ");
>> +       if (len =3D=3D 0 || len > POLICYDB_STRING_MAX_LENGTH) {
>> +               ERR(fp->handle, "policydb string length %s ", len ? "too
>> long" : "zero");
>>                 return POLICYDB_ERROR;
>>         }
>>
>> @@ -3798,6 +3838,8 @@ int policydb_read(policydb_t * p, struct
>> policy_file *fp, unsigned verbose)
>>                         goto bad;
>>                 }
>>                 len =3D le32_to_cpu(buf[0]);
>> +               if (zero_or_saturated(len))
>> +                       goto bad;
>>                 if ((p->name =3D malloc(len + 1)) =3D=3D NULL) {
>>                         goto bad;
>>                 }
>> @@ -3809,6 +3851,8 @@ int policydb_read(policydb_t * p, struct
>> policy_file *fp, unsigned verbose)
>>                         goto bad;
>>                 }
>>                 len =3D le32_to_cpu(buf[0]);
>> +               if (zero_or_saturated(len))
>> +                       goto bad;
>>                 if ((p->version =3D malloc(len + 1)) =3D=3D NULL) {
>>                         goto bad;
>>                 }
>> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
>> index 9c700c9..0beb4d4 100644
>> --- a/libsepol/src/private.h
>> +++ b/libsepol/src/private.h
>> @@ -45,6 +45,9 @@
>>
>>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
>>
>> +#define is_saturated(x) (x =3D=3D (typeof(x))-1)
>> +#define zero_or_saturated(x) ((x =3D=3D 0) || is_saturated(x))
>> +
>>  /* Policy compatibility information. */
>>  struct policydb_compat_info {
>>         unsigned int type;
>>
>>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>



--=20
Respectfully,

William C Roberts

--001a113a68785c19830539d0de77
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIFRodSwgQXVnIDExLCAyMDE2IGF0IDEyOjE0IFBNLCBKYW1lcyBD
YXJ0ZXIgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86andjYXJ0MkB0eWNoby5u
c2EuZ292IiB0YXJnZXQ9Il9ibGFuayI+andjYXJ0MkB0eWNoby5uc2EuZ292PC9hPiZndDs8L3Nw
YW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij5PbiAwOC8xMC8yMDE2IDA2OjM2IFBNLCA8YSBocmVmPSJtYWlsdG86d2lsbGlhbS5jLnJvYmVy
dHNAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+d2lsbGlhbS5jLnJvYmVydHNAaW50ZWwuY29t
PC9hPiB3cm90ZTo8YnI+DQo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij4NCkZyb206IFdpbGxpYW0gUm9iZXJ0cyAmbHQ7PGEgaHJlZj0ibWFpbHRvOndpbGxpYW0u
Yy5yb2JlcnRzQGludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPndpbGxpYW0uYy5yb2JlcnRzQGlu
dGVsLmNvbTwvYT4mZ3Q7PGJyPg0KPGJyPg0KVGhyb3VnaG91dCBsaWJzZXBvbCwgdmFsdWVzIHRh
a2VuIGZyb20gc2Vwb2xpY3kgYXJlIHVzZWQgaW48YnI+DQpwbGFjZXMgd2hlcmUgbGVuZ3RoID09
IDAgb3IgbGVuZ3RoID09ICZsdDtzYXR1cmF0ZWQmZ3Q7IG1hdHRlciw8YnI+DQpmaW5kIGFuZCBm
aXggdGhlc2UuPGJyPg0KPGJyPg0KQWxzbywgY29ycmVjdCBhbnkgdHlwZSBtaXNtYXRjaGVzIG5v
dGljZWQgYWxvbmcgdGhlIHdheS48YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBXaWxsaWFtIFJv
YmVydHMgJmx0OzxhIGhyZWY9Im1haWx0bzp3aWxsaWFtLmMucm9iZXJ0c0BpbnRlbC5jb20iIHRh
cmdldD0iX2JsYW5rIj53aWxsaWFtLmMucm9iZXJ0c0BpbnRlbC5jb208L2E+Jmd0Ozxicj4NCi0t
LTxicj4NCsKgbGlic2Vwb2wvc3JjL2NvbmRpdGlvbmFsLmPCoCDCoCB8wqAgMyArKy08YnI+DQrC
oGxpYnNlcG9sL3NyYy9jb250ZXh0LmPCoCDCoCDCoCDCoCB8IDE2ICsrKysrKysrKy0tLS0tPGJy
Pg0KwqBsaWJzZXBvbC9zcmMvY29udGV4dF9yZWNvcmQuYyB8IDI2ICsrKysrKysrKysrKy0tLS0t
LS0tLS08YnI+DQrCoGxpYnNlcG9sL3NyYy9tb2R1bGUuY8KgIMKgIMKgIMKgIMKgfCAxMyArKysr
KysrKysrKzxicj4NCsKgbGlic2Vwb2wvc3JjL21vZHVsZV90b19jaWwuY8KgIHzCoCA0ICsrKy08
YnI+DQrCoGxpYnNlcG9sL3NyYy9wb2xpY3lkYi5jwqAgwqAgwqAgwqB8IDUwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKzx3YnI+KysrKysrKysrKy0tLTxicj4NCsKgbGlic2Vwb2wvc3Jj
L3ByaXZhdGUuaMKgIMKgIMKgIMKgIHzCoCAzICsrKzxicj4NCsKgNyBmaWxlcyBjaGFuZ2VkLCA5
NCBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEv
bGlic2Vwb2wvc3JjL2NvbmRpdGlvbmFsLmMgYi9saWJzZXBvbC9zcmMvY29uZGl0aW9uYWwuYzxi
cj4NCmluZGV4IGVhNDdjZGQuLjg2ODBlYjIgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2Vwb2wvc3Jj
L2NvbmRpdGlvbmFsLmM8YnI+DQorKysgYi9saWJzZXBvbC9zcmMvY29uZGl0aW9uYWwuYzxicj4N
CkBAIC01ODksNyArNTg5LDggQEAgaW50IGNvbmRfcmVhZF9ib29sKHBvbGljeWRiX3QgKiBwLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyOzxicj4NCjxicj4NCsKgIMKgIMKg
IMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1ZlsyXSk7PGJyPg0KLTxicj4NCivCoCDCoCDCoCDCoGlm
ICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdv
dG8gZXJyOzxicj4NCsKgIMKgIMKgIMKgIGtleSA9IG1hbGxvYyhsZW4gKyAxKTs8YnI+DQrCoCDC
oCDCoCDCoCBpZiAoIWtleSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycjs8
YnI+DQpkaWZmIC0tZ2l0IGEvbGlic2Vwb2wvc3JjL2NvbnRleHQuYyBiL2xpYnNlcG9sL3NyYy9j
b250ZXh0LmM8YnI+DQppbmRleCA4NGRhZDM0Li4zOTU1MmYyIDEwMDY0NDxicj4NCi0tLSBhL2xp
YnNlcG9sL3NyYy9jb250ZXh0LmM8YnI+DQorKysgYi9saWJzZXBvbC9zcmMvY29udGV4dC5jPGJy
Pg0KQEAgLTEwLDYgKzEwLDcgQEA8YnI+DQrCoCNpbmNsdWRlICZxdW90O2NvbnRleHQuaCZxdW90
Ozxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7aGFuZGxlLmgmcXVvdDs8YnI+DQrCoCNpbmNsdWRlICZx
dW90O21scy5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O3ByaXZhdGUuaCZxdW90Ozxicj4N
Cjxicj4NCsKgLyogLS0tLS0gQ29tcGF0aWJpbGl0eSAtLS0tICovPGJyPg0KwqBpbnQgcG9saWN5
ZGJfY29udGV4dF9pc3ZhbGlkKGNvbnN0IHBvbGljeWRiX3QgKiBwLCBjb25zdCBjb250ZXh0X3N0
cnVjdF90ICogYyk8YnI+DQpAQCAtMjk3LDEwICsyOTgsMTggQEAgaW50IGNvbnRleHRfZnJvbV9z
dHJpbmcoc2Vwb2xfaGFuZDx3YnI+bGVfdCAqIGhhbmRsZSw8YnI+DQrCoCDCoCDCoCDCoCBjaGFy
ICpjb25fY3B5ID0gTlVMTDs8YnI+DQrCoCDCoCDCoCDCoCBzZXBvbF9jb250ZXh0X3QgKmN0eF9y
ZWNvcmQgPSBOVUxMOzxicj4NCjxicj4NCivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRl
ZChjb25fc3RyX2xlbjx3YnI+KSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVSUiho
YW5kbGUsICZxdW90O0ludmFsaWQgY29udGV4dCBsZW5ndGgmcXVvdDspOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0K
wqAgwqAgwqAgwqAgLyogc2Vwb2xfY29udGV4dF9mcm9tX3N0cmluZyBleHBlY3RzIGEgTlVMTC10
ZXJtaW5hdGVkIHN0cmluZyAqLzxicj4NCsKgIMKgIMKgIMKgIGNvbl9jcHkgPSBtYWxsb2MoY29u
X3N0cl9sZW4gKyAxKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAoIWNvbl9jcHkpPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZ290byBvbWVtOzxicj4NCivCoCDCoCDCoCDCoGlmICghY29uX2Nw
eSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVSUihoYW5kbGUsICZxdW90O291dCBv
ZiBtZW1vcnkmcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyOzxi
cj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgbWVtY3B5KGNvbl9jcHks
IGNvbl9zdHIsIGNvbl9zdHJfbGVuKTs8YnI+DQrCoCDCoCDCoCDCoCBjb25fY3B5W2Nvbl9zdHJf
bGVuXSA9ICYjMzk7XDAmIzM5Ozs8YnI+DQo8YnI+DQpAQCAtMzE1LDkgKzMyNCw2IEBAIGludCBj
b250ZXh0X2Zyb21fc3RyaW5nKHNlcG9sX2hhbmQ8d2JyPmxlX3QgKiBoYW5kbGUsPGJyPg0KwqAg
wqAgwqAgwqAgc2Vwb2xfY29udGV4dF9mcmVlKGN0eF9yZWNvcmQpPHdicj47PGJyPg0KwqAgwqAg
wqAgwqAgcmV0dXJuIFNUQVRVU19TVUNDRVNTOzxicj4NCjxicj4NCi3CoCDCoCDCoCBvbWVtOjxi
cj4NCi3CoCDCoCDCoCDCoEVSUihoYW5kbGUsICZxdW90O291dCBvZiBtZW1vcnkmcXVvdDspOzxi
cj4NCi08YnI+DQrCoCDCoCDCoCDCoGVycjo8YnI+DQrCoCDCoCDCoCDCoCBFUlIoaGFuZGxlLCAm
cXVvdDtjb3VsZCBub3QgY3JlYXRlIGNvbnRleHQgc3RydWN0dXJlJnF1b3Q7KTs8YnI+DQrCoCDC
oCDCoCDCoCBmcmVlKGNvbl9jcHkpOzxicj4NCmRpZmYgLS1naXQgYS9saWJzZXBvbC9zcmMvY29u
dGV4dF9yZWNvcmQuPHdicj5jIGIvbGlic2Vwb2wvc3JjL2NvbnRleHRfcmVjb3JkLjx3YnI+Yzxi
cj4NCmluZGV4IGFjMjg4NGEuLjAxZmQyYzkgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2Vwb2wvc3Jj
L2NvbnRleHRfcmVjb3JkLjx3YnI+Yzxicj4NCisrKyBiL2xpYnNlcG9sL3NyYy9jb250ZXh0X3Jl
Y29yZC48d2JyPmM8YnI+DQpAQCAtNSw2ICs1LDcgQEA8YnI+DQo8YnI+DQrCoCNpbmNsdWRlICZx
dW90O2NvbnRleHRfaW50ZXJuYWwuaCZxdW90Ozxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7ZGVidWcu
aCZxdW90Ozxicj4NCisjaW5jbHVkZSAmcXVvdDtwcml2YXRlLmgmcXVvdDs8YnI+DQo8YnI+DQrC
oHN0cnVjdCBzZXBvbF9jb250ZXh0IHs8YnI+DQo8YnI+DQpAQCAtMjg0LDE3ICsyODUsMjMgQEAg
aW50IHNlcG9sX2NvbnRleHRfdG9fc3RyaW5nKHNlcG9sXzx3YnI+aGFuZGxlX3QgKiBoYW5kbGUs
PGJyPg0KwqB7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgaW50IHJjOzxicj4NCi3CoCDCoCDCoCDC
oGNvbnN0IGludCB1c2VyX3N6ID0gc3RybGVuKGNvbi0mZ3Q7dXNlcik7PGJyPg0KLcKgIMKgIMKg
IMKgY29uc3QgaW50IHJvbGVfc3ogPSBzdHJsZW4oY29uLSZndDtyb2xlKTs8YnI+DQotwqAgwqAg
wqAgwqBjb25zdCBpbnQgdHlwZV9zeiA9IHN0cmxlbihjb24tJmd0O3R5cGUpOzxicj4NCi3CoCDC
oCDCoCDCoGNvbnN0IGludCBtbHNfc3ogPSAoY29uLSZndDttbHMpID8gc3RybGVuKGNvbi0mZ3Q7
bWxzKSA6IDA7PGJyPg0KLcKgIMKgIMKgIMKgY29uc3QgaW50IHRvdGFsX3N6ID0gdXNlcl9zeiAr
IHJvbGVfc3ogKyB0eXBlX3N6ICs8YnI+DQorwqAgwqAgwqAgwqBjb25zdCBzaXplX3QgdXNlcl9z
eiA9IHN0cmxlbihjb24tJmd0O3VzZXIpOzxicj4NCivCoCDCoCDCoCDCoGNvbnN0IHNpemVfdCBy
b2xlX3N6ID0gc3RybGVuKGNvbi0mZ3Q7cm9sZSk7PGJyPg0KK8KgIMKgIMKgIMKgY29uc3Qgc2l6
ZV90IHR5cGVfc3ogPSBzdHJsZW4oY29uLSZndDt0eXBlKTs8YnI+DQorwqAgwqAgwqAgwqBjb25z
dCBzaXplX3QgbWxzX3N6ID0gKGNvbi0mZ3Q7bWxzKSA/IHN0cmxlbihjb24tJmd0O21scykgOiAw
Ozxicj4NCivCoCDCoCDCoCDCoGNvbnN0IHNpemVfdCB0b3RhbF9zeiA9IHVzZXJfc3ogKyByb2xl
X3N6ICsgdHlwZV9zeiArPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgbWxzX3N6ICsgKChjb24tJmd0
O21scykgPyAzIDogMik7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgY2hhciAqc3RyID0gKGNoYXIg
KiltYWxsb2ModG90YWxfc3ogKyAxKTs8YnI+DQotwqAgwqAgwqAgwqBpZiAoIXN0cik8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIG9tZW07PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHpl
cm9fb3Jfc2F0dXJhdGVkKHRvdGFsX3N6KSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oEVSUihoYW5kbGUsICZxdW90O2ludmFsaWQgc2l6ZSZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ290byBlcnI7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCjxicj4NCivCoCDC
oCDCoCDCoGNoYXIgKnN0ciA9IChjaGFyICopbWFsbG9jKHRvdGFsX3N6ICsgMSk7PGJyPg0KK8Kg
IMKgIMKgIMKgaWYgKCFzdHIpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFUlIoaGFu
ZGxlLCAmcXVvdDtvdXQgb2YgbWVtb3J5JnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBnb3RvIGVycjs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAgwqAgaWYgKGNv
bi0mZ3Q7bWxzKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmMgPSBzbnByaW50Zihz
dHIsIHRvdGFsX3N6ICsgMSwgJnF1b3Q7JXM6JXM6JXM6JXMmcXVvdDssPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uLSZndDt1c2VyLCBjb24tJmd0
O3JvbGUsIGNvbi0mZ3Q7dHlwZSwgY29uLSZndDttbHMpOzxicj4NCjwvYmxvY2txdW90ZT4NCjxi
cj4NCkkgZ2V0IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHdoZW4gY29tcGlsaW5nOjxicj4NCjxicj4N
CmNvbnRleHRfcmVjb3JkLmM6IEluIGZ1bmN0aW9uIOKAmHNlcG9sX2NvbnRleHRfdG9fc3RyaW5n
4oCZOjxicj4NCmNvbnRleHRfcmVjb3JkLmM6MzA4OjIxOiBlcnJvcjogY29tcGFyaXNvbiBiZXR3
ZWVuIHNpZ25lZCBhbmQgdW5zaWduZWQgaW50ZWdlciBleHByZXNzaW9ucyBbLVdlcnJvcj1zaWdu
LWNvbXBhcmVdPGJyPg0KwqAgwqBpZiAocmMgJmx0OyAwIHx8IChyYyAmZ3Q7PSB0b3RhbF9zeiAr
IDEpKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBefjxicj4NCmNvbnRl
eHRfcmVjb3JkLmM6MzE1OjIxOiBlcnJvcjogY29tcGFyaXNvbiBiZXR3ZWVuIHNpZ25lZCBhbmQg
dW5zaWduZWQgaW50ZWdlciBleHByZXNzaW9ucyBbLVdlcnJvcj1zaWduLWNvbXBhcmVdPGJyPg0K
wqAgwqBpZiAocmMgJmx0OyAwIHx8IChyYyAmZ3Q7PSB0b3RhbF9zeiArIDEpKSB7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBefjxicj4NCmNvbnRleHRfcmVjb3JkLmM6MzI2
OjI6IGVycm9yOiDigJhzdHLigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1
bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdPGJyPg0KwqAgZnJlZShzdHIpOzxi
cj4NCsKgIF5+fn5+fn5+fjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5JbnRl
cmVzdGluZywgaSYjMzk7bSBub3Qgc2VlaW5nIHRoZXNlLCBpbGwgcm9sbCB0aGVzZSBpbnRvIHYz
IGFuZCBzZWUgaWYgSSBjYW4gcmVwcm9kdWNlIHRvIG1ha2Ugc3VyZSB0aGV5PC9kaXY+PGRpdj5k
b24mIzM5O3QgY29tZSBiYWNrLjwvZGl2PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2Nj
YyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCkppbTxicj4NCjxicj4NCjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1s
ZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KQEAgLTMxNCw5ICszMjEsNiBA
QCBpbnQgc2Vwb2xfY29udGV4dF90b19zdHJpbmcoc2Vwb2xfPHdicj5oYW5kbGVfdCAqIGhhbmRs
ZSw8YnI+DQrCoCDCoCDCoCDCoCAqc3RyX3B0ciA9IHN0cjs8YnI+DQrCoCDCoCDCoCDCoCByZXR1
cm4gU1RBVFVTX1NVQ0NFU1M7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIG9tZW06PGJyPg0KLcKgIMKg
IMKgIMKgRVJSKGhhbmRsZSwgJnF1b3Q7b3V0IG9mIG1lbW9yeSZxdW90Oyk7PGJyPg0KLTxicj4N
CsKgIMKgIMKgIMKgZXJyOjxicj4NCsKgIMKgIMKgIMKgIEVSUihoYW5kbGUsICZxdW90O2NvdWxk
IG5vdCBjb252ZXJ0IGNvbnRleHQgdG8gc3RyaW5nJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCBm
cmVlKHN0cik7PGJyPg0KZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9tb2R1bGUuYyBiL2xpYnNl
cG9sL3NyYy9tb2R1bGUuYzxicj4NCmluZGV4IDE2NjVlZGUuLmYyNWRmOTUgMTAwNjQ0PGJyPg0K
LS0tIGEvbGlic2Vwb2wvc3JjL21vZHVsZS5jPGJyPg0KKysrIGIvbGlic2Vwb2wvc3JjL21vZHVs
ZS5jPGJyPg0KQEAgLTMwLDYgKzMwLDcgQEA8YnI+DQrCoCNpbmNsdWRlICZsdDtzdGRpby5oJmd0
Ozxicj4NCsKgI2luY2x1ZGUgJmx0O3N0ZGxpYi5oJmd0Ozxicj4NCsKgI2luY2x1ZGUgJmx0O2xp
bWl0cy5oJmd0Ozxicj4NCisjaW5jbHVkZSAmbHQ7aW50dHlwZXMuaCZndDs8YnI+DQo8YnI+DQrC
oCNkZWZpbmUgU0VQT0xfUEFDS0FHRV9TRUNUSU9OX0ZDIDB4Zjk3Y2ZmOTA8YnI+DQrCoCNkZWZp
bmUgU0VQT0xfUEFDS0FHRV9TRUNUSU9OX1NFVVNFUiAweDk3Y2ZmOTE8YnI+DQpAQCAtNzkzLDYg
Kzc5NCwxMiBAQCBpbnQgc2Vwb2xfbW9kdWxlX3BhY2thZ2VfaW5mbyhzdHJ1PHdicj5jdCBzZXBv
bF9wb2xpY3lfZmlsZSAqc3BmLCBpbnQgKnR5cGUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBjbGVhbnVwOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZpbGUt
Jmd0O2hhbmRsZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAmcXVvdDtpbnZhbGlkIG1vZHVsZSBuYW1lIGxlbmd0aDogMHglJnF1b3Q7
UFJJeDMyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGxlbik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ290byBjbGVhbnVwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqbmFt
ZSA9IG1hbGxvYyhsZW4gKyAxKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoISpuYW1lKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgRVJSKGZpbGUtJmd0O2hhbmRsZSwgJnF1b3Q7b3V0IG9mIG1lbW9yeSZx
dW90Oyk7PGJyPg0KQEAgLTgxNCw2ICs4MjEsMTIgQEAgaW50IHNlcG9sX21vZHVsZV9wYWNrYWdl
X2luZm8oc3RydTx3YnI+Y3Qgc2Vwb2xfcG9saWN5X2ZpbGUgKnNwZiwgaW50ICp0eXBlLDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gY2xl
YW51cDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGVuID0gbGUzMl90b19jcHUoYnVmWzBd
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoemVyb19vcl9z
YXR1cmF0ZWQobGVuKSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoEVSUihmaWxlLSZndDtoYW5kbGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7aW52YWxpZCBtb2R1bGUg
dmVyc2lvbiBsZW5ndGg6IDB4JSZxdW90O1BSSXgzMiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsZW4pOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gY2xlYW51cDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKnZlcnNpb24gPSBtYWxsb2MobGVuICsgMSk7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCEqdmVyc2lvbikgezxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVSUihmaWxlLSZn
dDtoYW5kbGUsICZxdW90O291dCBvZiBtZW1vcnkmcXVvdDspOzxicj4NCmRpZmYgLS1naXQgYS9s
aWJzZXBvbC9zcmMvbW9kdWxlX3RvX2NpbC5jIGIvbGlic2Vwb2wvc3JjL21vZHVsZV90b19jaWwu
Yzxicj4NCmluZGV4IDM2ZjNiN2QuLmZjNjUwMTkgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2Vwb2wv
c3JjL21vZHVsZV90b19jaWwuYzxicj4NCisrKyBiL2xpYnNlcG9sL3NyYy9tb2R1bGVfdG9fY2ls
LmM8YnI+DQpAQCAtNDcsNiArNDcsOCBAQDxicj4NCsKgI2luY2x1ZGUgJmx0O3NlcG9sL3BvbGlj
eWRiL3NlcnZpY2VzLmgmZ3Q7PGJyPg0KwqAjaW5jbHVkZSAmbHQ7c2Vwb2wvcG9saWN5ZGIvdXRp
bC5oJmd0Ozxicj4NCjxicj4NCisjaW5jbHVkZSAmcXVvdDtwcml2YXRlLmgmcXVvdDs8YnI+DQor
PGJyPg0KwqAjaWZkZWYgX19HTlVDX188YnI+DQrCoCPCoCBkZWZpbmUgVU5VU0VEKHgpIFVOVVNF
RF8gIyMgeCBfX2F0dHJpYnV0ZV9fKChfX3VudXNlZF9fKSk8YnI+DQrCoCNlbHNlPGJyPg0KQEAg
LTEyNCw3ICsxMjYsNyBAQCBzdGF0aWMgaW50IGdldF9saW5lKGNoYXIgKipzdGFydCwgY2hhciAq
ZW5kLCBjaGFyICoqbGluZSk8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBmb3IgKGxlbiA9IDA7IHAg
Jmx0OyBlbmQgJmFtcDsmYW1wOyAqcCAhPSAmIzM5O1xuJiMzOTsgJmFtcDsmYW1wOyAqcCAhPSAm
IzM5O1wwJiMzOTs7IHArKywgbGVuKyspOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoGlmIChsZW4g
PT0gMCkgezxicj4NCivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmMgPSAwOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGdvdG8gZXhpdDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KZGlmZiAtLWdpdCBhL2xp
YnNlcG9sL3NyYy9wb2xpY3lkYi5jIGIvbGlic2Vwb2wvc3JjL3BvbGljeWRiLmM8YnI+DQppbmRl
eCA5NzE3OTNkLi4yMjY3Mzg3IDEwMDY0NDxicj4NCi0tLSBhL2xpYnNlcG9sL3NyYy9wb2xpY3lk
Yi5jPGJyPg0KKysrIGIvbGlic2Vwb2wvc3JjL3BvbGljeWRiLmM8YnI+DQpAQCAtMTkxMSw2ICsx
OTExLDkgQEAgc3RhdGljIGludCBwZXJtX3JlYWQocG9saWN5ZGJfdCAqIHA8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4gPSBs
ZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRl
ZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCis8YnI+
DQrCoCDCoCDCoCDCoCBwZXJkYXR1bS0mZ3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7
PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAga2V5ID0gbWFsbG9jKGxlbiArIDEpOzxicj4NCkBAIC0x
OTQ5LDYgKzE5NTIsOSBAQCBzdGF0aWMgaW50IGNvbW1vbl9yZWFkKHBvbGljeWRiX3QgKiBwLCBo
YXNodGFiX3QgaCwgc3RydWN0IHBvbGljeV9maWxlICpmcCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBnb3RvIGJhZDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2Nw
dShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCis8YnI+DQrCoCDCoCDC
oCDCoCBjb21kYXR1bS0mZ3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7PGJyPg0KPGJy
Pg0KwqAgwqAgwqAgwqAgaWYgKHN5bXRhYl9pbml0KCZhbXA7Y29tZGF0dW0tJmd0O3Blcm1pczx3
YnI+c2lvbnMsIFBFUk1fU1lNVEFCX1NJWkUpKTxicj4NCkBAIC0yMDkyLDcgKzIwOTgsMTEgQEAg
c3RhdGljIGludCBjbGFzc19yZWFkKHBvbGljeWRiX3QgKiBwLCBoYXNodGFiX3QgaCwgc3RydWN0
IHBvbGljeV9maWxlICpmcCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivC
oCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCsKgIMKgIMKgIMKgIGxlbjIgPSBsZTMyX3RvX2NwdShi
dWZbMV0pOzxicj4NCivCoCDCoCDCoCDCoGlmIChpc19zYXR1cmF0ZWQobGVuMikpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgY2xhZGF0dW0t
Jmd0O3MudmFsdWUgPSBsZTMyX3RvX2NwdShidWZbMl0pOzxicj4NCjxicj4NCsKgIMKgIMKgIMKg
IGlmIChzeW10YWJfaW5pdCgmYW1wO2NsYWRhdHVtLSZndDtwZXJtaXM8d2JyPnNpb25zLCBQRVJN
X1NZTVRBQl9TSVpFKSk8YnI+DQpAQCAtMjE5OSw2ICsyMjA5LDkgQEAgc3RhdGljIGludCByb2xl
X3JlYWQocG9saWN5ZGJfdCAqIHAsIGhhc2h0YWJfdCBoLCBzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZw
KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gYmFkOzxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1ZlswXSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHpl
cm9fb3Jfc2F0dXJhdGVkKGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBi
YWQ7PGJyPg0KKzxicj4NCsKgIMKgIMKgIMKgIHJvbGUtJmd0O3MudmFsdWUgPSBsZTMyX3RvX2Nw
dShidWZbMV0pOzxicj4NCsKgIMKgIMKgIMKgIGlmIChwb2xpY3lkYl9oYXNfYm91bmRhcnlfZmVh
dHVyZTx3YnI+KHApKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJvbGUtJmd0O2JvdW5k
cyA9IGxlMzJfdG9fY3B1KGJ1ZlsyXSk7PGJyPg0KQEAgLTIyODcsNiArMjMwMCw5IEBAIHN0YXRp
YyBpbnQgdHlwZV9yZWFkKHBvbGljeWRiX3QgKiBwLCBoYXNodGFiX3QgaCwgc3RydWN0IHBvbGlj
eV9maWxlICpmcCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8YnI+DQo8
YnI+DQrCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbcG9zXSk7PGJyPg0KK8KgIMKg
IMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJhdGVkKGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZ290byBiYWQ7PGJyPg0KKzxicj4NCsKgIMKgIMKgIMKgIHR5cGRhdHVtLSZndDtzLnZh
bHVlID0gbGUzMl90b19jcHUoYnVmWysrcG9zXSk7PGJyPg0KwqAgwqAgwqAgwqAgaWYgKHBvbGlj
eWRiX2hhc19ib3VuZGFyeV9mZWF0dXJlPHdicj4ocCkpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB1aW50MzJfdCBwcm9wZXJ0aWVzOzxicj4NCkBAIC0yNTU2LDYgKzI1NzIsOSBAQCBz
dGF0aWMgaW50IG9jb250ZXh0X3JlYWRfeGVuKHN0cnVjdCBwb2xpY3lkYl9jb21wYXRfaW5mbyAq
aW5mbyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAocmMgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0p
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
ICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQorPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYy0mZ3Q7PGEg
aHJlZj0iaHR0cDovL3UubmFtZSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+dS5u
YW1lPC9hPiA9IG1hbGxvYyhsZW4gKyAxKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIWMtJmd0OzxhIGhyZWY9Imh0dHA6Ly91Lm5hbWUi
IHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnUubmFtZTwvYT4pPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0
dXJuIC0xOzxicj4NCkBAIC0yNjE4LDYgKzI2MzcsOCBAQCBzdGF0aWMgaW50IG9jb250ZXh0X3Jl
YWRfc2VsaW51eChzdHJ1Y3QgcG9saWN5ZGJfY29tcGF0X2luZm8gKmluZm8sPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJjICZsdDsgMCk8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgbGVuID0gbGUzMl90b19jcHUoYnVmWzBdKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0
ZWQobGVuKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYy0mZ3Q7PGEgaHJlZj0iaHR0cDovL3UubmFtZSIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+dS5uYW1lPC9hPiA9IG1hbGxvYyhsZW4gKyAx
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBp
ZiAoIWMtJmd0OzxhIGhyZWY9Imh0dHA6Ly91Lm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPnUubmFtZTwvYT4pPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCkBAIC0yNjU5LDYg
KzI2ODAsOCBAQCBzdGF0aWMgaW50IG9jb250ZXh0X3JlYWRfc2VsaW51eChzdHJ1Y3QgcG9saWN5
ZGJfY29tcGF0X2luZm8gKmluZm8sPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGMtJmd0O3YuYmVoYXZpb3IgPSBs
ZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJh
dGVkKGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGMtJmd0OzxhIGhyZWY9Imh0dHA6Ly91Lm5hbWUiIHJl
bD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnUubmFtZTwvYT4gPSBtYWxsb2MobGVuICsg
MSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aWYgKCFjLSZndDs8YSBocmVmPSJodHRwOi8vdS5uYW1lIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdl
dD0iX2JsYW5rIj51Lm5hbWU8L2E+KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQpAQCAtMjcxOSw3
ICsyNzQyLDcgQEAgc3RhdGljIGludCBnZW5mc19yZWFkKHBvbGljeWRiX3QgKiBwLCBzdHJ1Y3Qg
cG9saWN5X2ZpbGUgKmZwKTxicj4NCsKgIMKgIMKgIMKgIHVpbnQzMl90IGJ1ZlsxXTs8YnI+DQrC
oCDCoCDCoCDCoCBzaXplX3QgbmVsLCBuZWwyLCBsZW4sIGxlbjI7PGJyPg0KwqAgwqAgwqAgwqAg
Z2VuZnNfdCAqZ2VuZnNfcCwgKm5ld2dlbmZzLCAqZ2VuZnM7PGJyPg0KLcKgIMKgIMKgIMKgdW5z
aWduZWQgaW50IGksIGo7PGJyPg0KK8KgIMKgIMKgIMKgc2l6ZV90IGksIGo7PGJyPg0KwqAgwqAg
wqAgwqAgb2NvbnRleHRfdCAqbCwgKmMsICpuZXdjID0gTlVMTDs8YnI+DQrCoCDCoCDCoCDCoCBp
bnQgcmM7PGJyPg0KPGJyPg0KQEAgLTI3MzMsNiArMjc1Niw4IEBAIHN0YXRpYyBpbnQgZ2VuZnNf
cmVhZChwb2xpY3lkYl90ICogcCwgc3RydWN0IHBvbGljeV9maWxlICpmcCk8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBpZiAocmMgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGdvdG8gYmFkOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxl
biA9IGxlMzJfdG9fY3B1KGJ1ZlswXSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KHplcm9fb3Jfc2F0dXJhdGVkKGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbmV3Z2VuZnMg
PSBjYWxsb2MoMSwgc2l6ZW9mKGdlbmZzX3QpKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAoIW5ld2dlbmZzKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGdvdG8gYmFkOzxicj4NCkBAIC0yNzc4LDYgKzI4MDMsOCBAQCBzdGF0aWMgaW50IGdlbmZzX3Jl
YWQocG9saWN5ZGJfdCAqIHAsIHN0cnVjdCBwb2xpY3lfZmlsZSAqZnApPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJjICZsdDsgMCk8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0p
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3Nh
dHVyYXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIG5ld2MtJmd0OzxhIGhyZWY9Imh0dHA6Ly91Lm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPnUubmFtZTwvYT4gPSBtYWxsb2MobGVuICsgMSk7PGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFuZXdjLSZndDs8YSBocmVmPSJodHRwOi8v
dS5uYW1lIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj51Lm5hbWU8L2E+KSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBi
YWQ7PGJyPg0KQEAgLTI4NzcsNiArMjkwNCw5IEBAIHN0YXRpYyBpbnQgdXNlcl9yZWFkKHBvbGlj
eWRiX3QgKiBwLCBoYXNodGFiX3QgaCwgc3RydWN0IHBvbGljeV9maWxlICpmcCk8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4g
PSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVy
YXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCis8
YnI+DQrCoCDCoCDCoCDCoCB1c3JkYXR1bS0mZ3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1Zlsx
XSk7PGJyPg0KwqAgwqAgwqAgwqAgaWYgKHBvbGljeWRiX2hhc19ib3VuZGFyeV9mZWF0dXJlPHdi
cj4ocCkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdXNyZGF0dW0tJmd0O2JvdW5kcyA9
IGxlMzJfdG9fY3B1KGJ1ZlsyXSk7PGJyPg0KQEAgLTI5NjAsNiArMjk5MCw5IEBAIHN0YXRpYyBp
bnQgc2Vuc19yZWFkKHBvbGljeWRiX3QgKiBwPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Z290byBiYWQ7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgbGVuID0gbGUzMl90b19jcHUoYnVmWzBd
KTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0ZWQobGVuKSk8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGJhZDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgbGV2
ZGF0dW0tJmd0O2lzYWxpYXMgPSBsZTMyX3RvX2NwdShidWZbMV0pOzxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIGtleSA9IG1hbGxvYyhsZW4gKyAxKTs8YnI+DQpAQCAtMzAwMyw2ICszMDM2LDkgQEAg
c3RhdGljIGludCBjYXRfcmVhZChwb2xpY3lkYl90ICogcDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGdvdG8gYmFkOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1
KGJ1ZlswXSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYoemVyb19vcl9zYXR1cmF0ZWQobGVuKSk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGJhZDs8YnI+DQorPGJyPg0KwqAgwqAgwqAg
wqAgY2F0ZGF0dW0tJmd0O3MudmFsdWUgPSBsZTMyX3RvX2NwdShidWZbMV0pOzxicj4NCsKgIMKg
IMKgIMKgIGNhdGRhdHVtLSZndDtpc2FsaWFzID0gbGUzMl90b19jcHUoYnVmWzJdKTs8YnI+DQo8
YnI+DQpAQCAtMzMzOSw2ICszMzc1LDggQEAgc3RhdGljIGludCBmaWxlbmFtZV90cmFuc19ydWxl
X3JlYWQoZmlsZW48d2JyPmFtZV90cmFuc19ydWxlX3QgKiogciwgc3RydWN0IHBvbGljeV9maTxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQo8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQo8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmdHItJmd0O25hbWUgPSBtYWxsb2MobGVuICsg
MSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFmdHItJmd0O25hbWUpPGJyPg0K
QEAgLTM1ODAsNiArMzYxOCw4IEBAIHN0YXRpYyBpbnQgc2NvcGVfcmVhZChwb2xpY3lkYl90ICog
cCwgaW50IHN5bW51bSwgc3RydWN0IHBvbGljeV9maWxlICpmcCk8YnI+DQrCoCDCoCDCoCDCoCBp
ZiAocmMgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gY2xlYW51cDs8
YnI+DQrCoCDCoCDCoCDCoCBrZXlfbGVuID0gbGUzMl90b19jcHUoYnVmWzBdKTs8YnI+DQorwqAg
wqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0ZWQoa2V5X2xlbikpPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZ290byBjbGVhbnVwOzxicj4NCsKgIMKgIMKgIMKgIGtleSA9IG1hbGxvYyhr
ZXlfbGVuICsgMSk7PGJyPg0KwqAgwqAgwqAgwqAgaWYgKCFrZXkpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZ290byBjbGVhbnVwOzxicj4NCkBAIC0zNjY0LDggKzM3MDQsOCBAQCBpbnQg
cG9saWN5ZGJfcmVhZChwb2xpY3lkYl90ICogcCwgc3RydWN0IHBvbGljeV9maWxlICpmcCwgdW5z
aWduZWQgdmVyYm9zZSk8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAg
bGVuID0gYnVmWzFdOzxicj4NCi3CoCDCoCDCoCDCoGlmIChsZW4gJmd0OyBQT0xJQ1lEQl9TVFJJ
TkdfTUFYX0xFTkdUSCkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVSUihmcC0mZ3Q7
aGFuZGxlLCAmcXVvdDtwb2xpY3lkYiBzdHJpbmcgbGVuZ3RoIHRvbyBsb25nICZxdW90Oyk7PGJy
Pg0KK8KgIMKgIMKgIMKgaWYgKGxlbiA9PSAwIHx8IGxlbiAmZ3Q7IFBPTElDWURCX1NUUklOR19N
QVhfTEVOR1RIKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZwLSZndDtoYW5k
bGUsICZxdW90O3BvbGljeWRiIHN0cmluZyBsZW5ndGggJXMgJnF1b3Q7LCBsZW4gPyAmcXVvdDt0
b28gbG9uZyZxdW90OyA6ICZxdW90O3plcm8mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJldHVybiBQT0xJQ1lEQl9FUlJPUjs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJy
Pg0KQEAgLTM3OTgsNiArMzgzOCw4IEBAIGludCBwb2xpY3lkYl9yZWFkKHBvbGljeWRiX3QgKiBw
LCBzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZwLCB1bnNpZ25lZCB2ZXJib3NlKTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gYmFkOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2Nw
dShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVy
YXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8g
YmFkOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICgocC0mZ3Q7bmFtZSA9IG1hbGxv
YyhsZW4gKyAxKSkgPT0gTlVMTCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGdvdG8gYmFkOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQpAQCAt
MzgwOSw2ICszODUxLDggQEAgaW50IHBvbGljeWRiX3JlYWQocG9saWN5ZGJfdCAqIHAsIHN0cnVj
dCBwb2xpY3lfZmlsZSAqZnAsIHVuc2lnbmVkIHZlcmJvc2UpPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1Zlsw
XSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJhdGVkKGxl
bikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBiYWQ7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKChwLSZndDt2ZXJzaW9uID0gbWFsbG9jKGxl
biArIDEpKSA9PSBOVUxMKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCmRpZmYgLS1n
aXQgYS9saWJzZXBvbC9zcmMvcHJpdmF0ZS5oIGIvbGlic2Vwb2wvc3JjL3ByaXZhdGUuaDxicj4N
CmluZGV4IDljNzAwYzkuLjBiZWI0ZDQgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2Vwb2wvc3JjL3By
aXZhdGUuaDxicj4NCisrKyBiL2xpYnNlcG9sL3NyYy9wcml2YXRlLmg8YnI+DQpAQCAtNDUsNiAr
NDUsOSBAQDxicj4NCjxicj4NCsKgI2RlZmluZSBBUlJBWV9TSVpFKHgpIChzaXplb2YoeCkvc2l6
ZW9mKCh4KVswXSkpPGJyPg0KPGJyPg0KKyNkZWZpbmUgaXNfc2F0dXJhdGVkKHgpICh4ID09ICh0
eXBlb2YoeCkpLTEpPGJyPg0KKyNkZWZpbmUgemVyb19vcl9zYXR1cmF0ZWQoeCkgKCh4ID09IDAp
IHx8IGlzX3NhdHVyYXRlZCh4KSk8YnI+DQorPGJyPg0KwqAvKiBQb2xpY3kgY29tcGF0aWJpbGl0
eSBpbmZvcm1hdGlvbi4gKi88YnI+DQrCoHN0cnVjdCBwb2xpY3lkYl9jb21wYXRfaW5mbyB7PGJy
Pg0KwqAgwqAgwqAgwqAgdW5zaWduZWQgaW50IHR5cGU7PGJyPg0KPGJyPjxzcGFuIGNsYXNzPSJI
T0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij4NCjwvZm9udD48L3NwYW4+PC9ibG9ja3F1b3Rl
PjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij4NCjxicj4NCjxicj4N
Ci0tIDxicj4NCkphbWVzIENhcnRlciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmp3Y2FydDJAdHljaG8u
bnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPmp3Y2FydDJAdHljaG8ubnNhLmdvdjwvYT4mZ3Q7PGJy
Pg0KTmF0aW9uYWwgU2VjdXJpdHkgQWdlbmN5PGJyPg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fPHdicj5fX19fX19fX19fX19fX19fXzxicj4NClNlYW5kcm9pZC1saXN0IG1haWxpbmcg
bGlzdDxicj4NCjxhIGhyZWY9Im1haWx0bzpTZWFuZHJvaWQtbGlzdEB0eWNoby5uc2EuZ292IiB0
YXJnZXQ9Il9ibGFuayI+U2VhbmRyb2lkLWxpc3RAdHljaG8ubnNhLmdvdjwvYT48YnI+DQpUbyB1
bnN1YnNjcmliZSwgc2VuZCBlbWFpbCB0byA8YSBocmVmPSJtYWlsdG86U2VhbmRyb2lkLWxpc3Qt
bGVhdmVAdHljaG8ubnNhLmdvdiIgdGFyZ2V0PSJfYmxhbmsiPlNlYW5kcm9pZC1saXN0LWxlYXZl
QHR5Y2hvLm5zYTx3YnI+LmdvdjwvYT4uPGJyPg0KVG8gZ2V0IGhlbHAsIHNlbmQgYW4gZW1haWwg
Y29udGFpbmluZyAmcXVvdDtoZWxwJnF1b3Q7IHRvIDxhIGhyZWY9Im1haWx0bzpTZWFuZHJvaWQt
bGlzdC1yZXF1ZXN0QHR5Y2hvLm5zYS5nb3YiIHRhcmdldD0iX2JsYW5rIj5TZWFuZHJvaWQtbGlz
dC1yZXF1ZXN0QHR5Y2hvLm48d2JyPnNhLmdvdjwvYT4uPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Js
b2NrcXVvdGU+PC9kaXY+PGJyPjxiciBjbGVhcj0iYWxsIj48ZGl2Pjxicj48L2Rpdj4tLSA8YnI+
PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIiBkYXRhLXNtYXJ0bWFpbD0iZ21haWxfc2lnbmF0
dXJlIj5SZXNwZWN0ZnVsbHksPGJyPjxicj5XaWxsaWFtIEMgUm9iZXJ0czxicj48YnI+PC9kaXY+
DQo8L2Rpdj48L2Rpdj4NCg==
--001a113a68785c19830539d0de77--
