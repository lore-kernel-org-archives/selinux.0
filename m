MIME-Version: 1.0
In-Reply-To: <1470865882-22435-5-git-send-email-william.c.roberts@intel.com>
References: <1470865882-22435-1-git-send-email-william.c.roberts@intel.com>
 <1470865882-22435-5-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 10 Aug 2016 14:57:52 -0700
Message-ID: <CAFftDdqnw5g_6_8dWPO4O5C-iO-Ym2W87GtDzgJsAGpeGTcMHA@mail.gmail.com>
Subject: Re: [PATCH 5/5] libsepol: fix overflow and 0 length allocations
To: William Roberts <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 James Carter <jwcart2@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114382e8b707360539bebd27
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114382e8b707360539bebd27
Content-Type: text/plain; charset=UTF-8

Disregard these and wait for v2, a test is failing that I thought was
passing.

On Wed, Aug 10, 2016 at 2:51 PM, <william.c.roberts@intel.com> wrote:

> From: William Roberts <william.c.roberts@intel.com>
>
> Throughout libsepol, values taken from sepolicy are used in
> places where length == 0 or length == <saturated> matter,
> find and fix these.
>
> Also, correct any type mismatches noticed along the way.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsepol/src/conditional.c    |  3 ++-
>  libsepol/src/context.c        | 16 +++++++++-----
>  libsepol/src/context_record.c | 26 ++++++++++++----------
>  libsepol/src/module.c         | 13 +++++++++++
>  libsepol/src/module_to_cil.c  |  4 +++-
>  libsepol/src/policydb.c       | 50 ++++++++++++++++++++++++++++++
> ++++++++++---
>  libsepol/src/private.h        |  2 ++
>  7 files changed, 93 insertions(+), 21 deletions(-)
>
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index ea47cdd..8680eb2 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -589,7 +589,8 @@ int cond_read_bool(policydb_t * p,
>                 goto err;
>
>         len = le32_to_cpu(buf[2]);
> -
> +       if (zero_or_saturated(len))
> +               goto err;
>         key = malloc(len + 1);
>         if (!key)
>                 goto err;
> diff --git a/libsepol/src/context.c b/libsepol/src/context.c
> index 84dad34..39552f2 100644
> --- a/libsepol/src/context.c
> +++ b/libsepol/src/context.c
> @@ -10,6 +10,7 @@
>  #include "context.h"
>  #include "handle.h"
>  #include "mls.h"
> +#include "private.h"
>
>  /* ----- Compatibility ---- */
>  int policydb_context_isvalid(const policydb_t * p, const context_struct_t
> * c)
> @@ -297,10 +298,18 @@ int context_from_string(sepol_handle_t * handle,
>         char *con_cpy = NULL;
>         sepol_context_t *ctx_record = NULL;
>
> +       if (zero_or_saturated(con_str_len)) {
> +               ERR(handle, "Invalid context length");
> +               goto err;
> +       }
> +
>         /* sepol_context_from_string expects a NULL-terminated string */
>         con_cpy = malloc(con_str_len + 1);
> -       if (!con_cpy)
> -               goto omem;
> +       if (!con_cpy) {
> +               ERR(handle, "out of memory");
> +               goto err;
> +       }
> +
>         memcpy(con_cpy, con_str, con_str_len);
>         con_cpy[con_str_len] = '\0';
>
> @@ -315,9 +324,6 @@ int context_from_string(sepol_handle_t * handle,
>         sepol_context_free(ctx_record);
>         return STATUS_SUCCESS;
>
> -      omem:
> -       ERR(handle, "out of memory");
> -
>        err:
>         ERR(handle, "could not create context structure");
>         free(con_cpy);
> diff --git a/libsepol/src/context_record.c b/libsepol/src/context_record.c
> index ac2884a..01fd2c9 100644
> --- a/libsepol/src/context_record.c
> +++ b/libsepol/src/context_record.c
> @@ -5,6 +5,7 @@
>
>  #include "context_internal.h"
>  #include "debug.h"
> +#include "private.h"
>
>  struct sepol_context {
>
> @@ -284,17 +285,23 @@ int sepol_context_to_string(sepol_handle_t * handle,
>  {
>
>         int rc;
> -       const int user_sz = strlen(con->user);
> -       const int role_sz = strlen(con->role);
> -       const int type_sz = strlen(con->type);
> -       const int mls_sz = (con->mls) ? strlen(con->mls) : 0;
> -       const int total_sz = user_sz + role_sz + type_sz +
> +       const size_t user_sz = strlen(con->user);
> +       const size_t role_sz = strlen(con->role);
> +       const size_t type_sz = strlen(con->type);
> +       const size_t mls_sz = (con->mls) ? strlen(con->mls) : 0;
> +       const size_t total_sz = user_sz + role_sz + type_sz +
>             mls_sz + ((con->mls) ? 3 : 2);
>
> -       char *str = (char *)malloc(total_sz + 1);
> -       if (!str)
> -               goto omem;
> +       if (zero_or_saturated(total_sz)) {
> +               ERR(handle, "invalid size");
> +               goto err;
> +       }
>
> +       char *str = (char *)malloc(total_sz + 1);
> +       if (!str) {
> +               ERR(handle, "out of memory");
> +               goto err;
> +       }
>         if (con->mls) {
>                 rc = snprintf(str, total_sz + 1, "%s:%s:%s:%s",
>                               con->user, con->role, con->type, con->mls);
> @@ -314,9 +321,6 @@ int sepol_context_to_string(sepol_handle_t * handle,
>         *str_ptr = str;
>         return STATUS_SUCCESS;
>
> -      omem:
> -       ERR(handle, "out of memory");
> -
>        err:
>         ERR(handle, "could not convert context to string");
>         free(str);
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index 1665ede..f25df95 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -30,6 +30,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <limits.h>
> +#include <inttypes.h>
>
>  #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
>  #define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91
> @@ -793,6 +794,12 @@ int sepol_module_package_info(struct
> sepol_policy_file *spf, int *type,
>                                 goto cleanup;
>                         }
>                         len = le32_to_cpu(buf[0]);
> +                       if (zero_or_saturated(len)) {
> +                               ERR(file->handle,
> +                                   "invalid module name length:
> 0x%"PRIx32,
> +                                   len);
> +                               goto cleanup;
> +                       }
>                         *name = malloc(len + 1);
>                         if (!*name) {
>                                 ERR(file->handle, "out of memory");
> @@ -814,6 +821,12 @@ int sepol_module_package_info(struct
> sepol_policy_file *spf, int *type,
>                                 goto cleanup;
>                         }
>                         len = le32_to_cpu(buf[0]);
> +                       if (zero_or_saturated(len)) {
> +                               ERR(file->handle,
> +                                   "invalid module version length:
> 0x%"PRIx32,
> +                                   len);
> +                               goto cleanup;
> +                       }
>                         *version = malloc(len + 1);
>                         if (!*version) {
>                                 ERR(file->handle, "out of memory");
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 36f3b7d..fc65019 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -47,6 +47,8 @@
>  #include <sepol/policydb/services.h>
>  #include <sepol/policydb/util.h>
>
> +#include "private.h"
> +
>  #ifdef __GNUC__
>  #  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))
>  #else
> @@ -124,7 +126,7 @@ static int get_line(char **start, char *end, char
> **line)
>
>         for (len = 0; p < end && *p != '\n' && *p != '\0'; p++, len++);
>
> -       if (len == 0) {
> +       if (zero_or_saturated(len)) {
>                 rc = 0;
>                 goto exit;
>         }
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 971793d..c2e1a43 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1911,6 +1911,9 @@ static int perm_read(policydb_t * p
>                 goto bad;
>
>         len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               goto bad;
> +
>         perdatum->s.value = le32_to_cpu(buf[1]);
>
>         key = malloc(len + 1);
> @@ -1949,6 +1952,9 @@ static int common_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
>                 goto bad;
>
>         len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               goto bad;
> +
>         comdatum->s.value = le32_to_cpu(buf[1]);
>
>         if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
> @@ -2092,7 +2098,11 @@ static int class_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
>                 goto bad;
>
>         len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               goto bad;
>         len2 = le32_to_cpu(buf[1]);
> +       if (len2 == 0 || len2 == SIZE_MAX)
> +               goto bad;
>         cladatum->s.value = le32_to_cpu(buf[2]);
>
>         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
> @@ -2199,6 +2209,9 @@ static int role_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
>                 goto bad;
>
>         len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               goto bad;
> +
>         role->s.value = le32_to_cpu(buf[1]);
>         if (policydb_has_boundary_feature(p))
>                 role->bounds = le32_to_cpu(buf[2]);
> @@ -2287,6 +2300,9 @@ static int type_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
>                 goto bad;
>
>         len = le32_to_cpu(buf[pos]);
> +       if (zero_or_saturated(len))
> +               goto bad;
> +
>         typdatum->s.value = le32_to_cpu(buf[++pos]);
>         if (policydb_has_boundary_feature(p)) {
>                 uint32_t properties;
> @@ -2556,6 +2572,9 @@ static int ocontext_read_xen(struct
> policydb_compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 len = le32_to_cpu(buf[0]);
> +                               if (zero_or_saturated(len))
> +                                       return -1;
> +
>                                 c->u.name = malloc(len + 1);
>                                 if (!c->u.name)
>                                         return -1;
> @@ -2618,6 +2637,8 @@ static int ocontext_read_selinux(struct
> policydb_compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 len = le32_to_cpu(buf[0]);
> +                               if (zero_or_saturated(len))
> +                                       return -1;
>                                 c->u.name = malloc(len + 1);
>                                 if (!c->u.name)
>                                         return -1;
> @@ -2659,6 +2680,8 @@ static int ocontext_read_selinux(struct
> policydb_compat_info *info,
>                                         return -1;
>                                 c->v.behavior = le32_to_cpu(buf[0]);
>                                 len = le32_to_cpu(buf[1]);
> +                               if (zero_or_saturated(len))
> +                                       return -1;
>                                 c->u.name = malloc(len + 1);
>                                 if (!c->u.name)
>                                         return -1;
> @@ -2719,7 +2742,7 @@ static int genfs_read(policydb_t * p, struct
> policy_file *fp)
>         uint32_t buf[1];
>         size_t nel, nel2, len, len2;
>         genfs_t *genfs_p, *newgenfs, *genfs;
> -       unsigned int i, j;
> +       size_t i, j;
>         ocontext_t *l, *c, *newc = NULL;
>         int rc;
>
> @@ -2733,6 +2756,8 @@ static int genfs_read(policydb_t * p, struct
> policy_file *fp)
>                 if (rc < 0)
>                         goto bad;
>                 len = le32_to_cpu(buf[0]);
> +               if (zero_or_saturated(len))
> +                       goto bad;
>                 newgenfs = calloc(1, sizeof(genfs_t));
>                 if (!newgenfs)
>                         goto bad;
> @@ -2778,6 +2803,8 @@ static int genfs_read(policydb_t * p, struct
> policy_file *fp)
>                         if (rc < 0)
>                                 goto bad;
>                         len = le32_to_cpu(buf[0]);
> +                       if (zero_or_saturated(len))
> +                               goto bad;
>                         newc->u.name = malloc(len + 1);
>                         if (!newc->u.name) {
>                                 goto bad;
> @@ -2877,6 +2904,9 @@ static int user_read(policydb_t * p, hashtab_t h,
> struct policy_file *fp)
>                 goto bad;
>
>         len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               goto bad;
> +
>         usrdatum->s.value = le32_to_cpu(buf[1]);
>         if (policydb_has_boundary_feature(p))
>                 usrdatum->bounds = le32_to_cpu(buf[2]);
> @@ -2960,6 +2990,9 @@ static int sens_read(policydb_t * p
>                 goto bad;
>
>         len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(len))
> +               goto bad;
> +
>         levdatum->isalias = le32_to_cpu(buf[1]);
>
>         key = malloc(len + 1);
> @@ -3003,6 +3036,9 @@ static int cat_read(policydb_t * p
>                 goto bad;
>
>         len = le32_to_cpu(buf[0]);
> +       if(zero_or_saturated(len))
> +               goto bad;
> +
>         catdatum->s.value = le32_to_cpu(buf[1]);
>         catdatum->isalias = le32_to_cpu(buf[2]);
>
> @@ -3339,6 +3375,8 @@ static int filename_trans_rule_read(filename_trans_rule_t
> ** r, struct policy_fi
>                         return -1;
>
>                 len = le32_to_cpu(buf[0]);
> +               if (zero_or_saturated(len))
> +                       return -1;
>
>                 ftr->name = malloc(len + 1);
>                 if (!ftr->name)
> @@ -3580,6 +3618,8 @@ static int scope_read(policydb_t * p, int symnum,
> struct policy_file *fp)
>         if (rc < 0)
>                 goto cleanup;
>         key_len = le32_to_cpu(buf[0]);
> +       if (zero_or_saturated(key_len))
> +               goto cleanup;
>         key = malloc(key_len + 1);
>         if (!key)
>                 goto cleanup;
> @@ -3664,8 +3704,8 @@ int policydb_read(policydb_t * p, struct policy_file
> *fp, unsigned verbose)
>         }
>
>         len = buf[1];
> -       if (len > POLICYDB_STRING_MAX_LENGTH) {
> -               ERR(fp->handle, "policydb string length too long ");
> +       if (len == 0 || len > POLICYDB_STRING_MAX_LENGTH) {
> +               ERR(fp->handle, "policydb string length %s ", len ? "too
> long" : "zero");
>                 return POLICYDB_ERROR;
>         }
>
> @@ -3798,6 +3838,8 @@ int policydb_read(policydb_t * p, struct policy_file
> *fp, unsigned verbose)
>                         goto bad;
>                 }
>                 len = le32_to_cpu(buf[0]);
> +               if (zero_or_saturated(len))
> +                       goto bad;
>                 if ((p->name = malloc(len + 1)) == NULL) {
>                         goto bad;
>                 }
> @@ -3809,6 +3851,8 @@ int policydb_read(policydb_t * p, struct policy_file
> *fp, unsigned verbose)
>                         goto bad;
>                 }
>                 len = le32_to_cpu(buf[0]);
> +               if (zero_or_saturated(len))
> +                       goto bad;
>                 if ((p->version = malloc(len + 1)) == NULL) {
>                         goto bad;
>                 }
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index 9c700c9..5bc5d64 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -45,6 +45,8 @@
>
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))
>
> +#define zero_or_saturated(x) ((x == 0) || (x == (typeof(x))-1))
> +
>  /* Policy compatibility information. */
>  struct policydb_compat_info {
>         unsigned int type;
> --
> 1.9.1
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>



-- 
Respectfully,

William C Roberts

--001a114382e8b707360539bebd27
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+RGlzcmVnYXJkIHRoZXNlIGFuZCB3YWl0IGZvciB2MiwgYSB0ZXN0IGlz
IGZhaWxpbmcgdGhhdCBJIHRob3VnaHQgd2FzIHBhc3NpbmcuPC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gV2VkLCBBdWcgMTAsIDIw
MTYgYXQgMjo1MSBQTSwgIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOndpbGxp
YW0uYy5yb2JlcnRzQGludGVsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPndpbGxpYW0uYy5yb2JlcnRz
QGludGVsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+RnJvbTogV2lsbGlhbSBSb2JlcnRzICZsdDs8YSBocmVm
PSJtYWlsdG86d2lsbGlhbS5jLnJvYmVydHNAaW50ZWwuY29tIj53aWxsaWFtLmMucm9iZXJ0c0Bp
bnRlbC5jb208L2E+Jmd0Ozxicj4NCjxicj4NClRocm91Z2hvdXQgbGlic2Vwb2wsIHZhbHVlcyB0
YWtlbiBmcm9tIHNlcG9saWN5IGFyZSB1c2VkIGluPGJyPg0KcGxhY2VzIHdoZXJlIGxlbmd0aCA9
PSAwIG9yIGxlbmd0aCA9PSAmbHQ7c2F0dXJhdGVkJmd0OyBtYXR0ZXIsPGJyPg0KZmluZCBhbmQg
Zml4IHRoZXNlLjxicj4NCjxicj4NCkFsc28sIGNvcnJlY3QgYW55IHR5cGUgbWlzbWF0Y2hlcyBu
b3RpY2VkIGFsb25nIHRoZSB3YXkuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogV2lsbGlhbSBS
b2JlcnRzICZsdDs8YSBocmVmPSJtYWlsdG86d2lsbGlhbS5jLnJvYmVydHNAaW50ZWwuY29tIj53
aWxsaWFtLmMucm9iZXJ0c0BpbnRlbC5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCsKgbGlic2Vw
b2wvc3JjL2NvbmRpdGlvbmFsLmPCoCDCoCB8wqAgMyArKy08YnI+DQrCoGxpYnNlcG9sL3NyYy9j
b250ZXh0LmPCoCDCoCDCoCDCoCB8IDE2ICsrKysrKysrKy0tLS0tPGJyPg0KwqBsaWJzZXBvbC9z
cmMvY29udGV4dF9yZWNvcmQuYyB8IDI2ICsrKysrKysrKysrKy0tLS0tLS0tLS08YnI+DQrCoGxp
YnNlcG9sL3NyYy9tb2R1bGUuY8KgIMKgIMKgIMKgIMKgfCAxMyArKysrKysrKysrKzxicj4NCsKg
bGlic2Vwb2wvc3JjL21vZHVsZV90b19jaWwuY8KgIHzCoCA0ICsrKy08YnI+DQrCoGxpYnNlcG9s
L3NyYy9wb2xpY3lkYi5jwqAgwqAgwqAgwqB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKzx3YnI+KysrKysrKysrKy0tLTxicj4NCsKgbGlic2Vwb2wvc3JjL3ByaXZhdGUuaMKgIMKg
IMKgIMKgIHzCoCAyICsrPGJyPg0KwqA3IGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKyks
IDIxIGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9saWJzZXBvbC9zcmMvY29u
ZGl0aW9uYWwuYyBiL2xpYnNlcG9sL3NyYy9jb25kaXRpb25hbC5jPGJyPg0KaW5kZXggZWE0N2Nk
ZC4uODY4MGViMiAxMDA2NDQ8YnI+DQotLS0gYS9saWJzZXBvbC9zcmMvY29uZGl0aW9uYWwuYzxi
cj4NCisrKyBiL2xpYnNlcG9sL3NyYy9jb25kaXRpb25hbC5jPGJyPg0KQEAgLTU4OSw3ICs1ODks
OCBAQCBpbnQgY29uZF9yZWFkX2Jvb2wocG9saWN5ZGJfdCAqIHAsPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZ290byBlcnI7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgbGVuID0gbGUzMl90
b19jcHUoYnVmWzJdKTs8YnI+DQotPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJh
dGVkKGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnI7PGJyPg0KwqAg
wqAgwqAgwqAga2V5ID0gbWFsbG9jKGxlbiArIDEpOzxicj4NCsKgIMKgIMKgIMKgIGlmICgha2V5
KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyOzxicj4NCmRpZmYgLS1naXQg
YS9saWJzZXBvbC9zcmMvY29udGV4dC5jIGIvbGlic2Vwb2wvc3JjL2NvbnRleHQuYzxicj4NCmlu
ZGV4IDg0ZGFkMzQuLjM5NTUyZjIgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2Vwb2wvc3JjL2NvbnRl
eHQuYzxicj4NCisrKyBiL2xpYnNlcG9sL3NyYy9jb250ZXh0LmM8YnI+DQpAQCAtMTAsNiArMTAs
NyBAQDxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7Y29udGV4dC5oJnF1b3Q7PGJyPg0KwqAjaW5jbHVk
ZSAmcXVvdDtoYW5kbGUuaCZxdW90Ozxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7bWxzLmgmcXVvdDs8
YnI+DQorI2luY2x1ZGUgJnF1b3Q7cHJpdmF0ZS5oJnF1b3Q7PGJyPg0KPGJyPg0KwqAvKiAtLS0t
LSBDb21wYXRpYmlsaXR5IC0tLS0gKi88YnI+DQrCoGludCBwb2xpY3lkYl9jb250ZXh0X2lzdmFs
aWQoY29uc3QgcG9saWN5ZGJfdCAqIHAsIGNvbnN0IGNvbnRleHRfc3RydWN0X3QgKiBjKTxicj4N
CkBAIC0yOTcsMTAgKzI5OCwxOCBAQCBpbnQgY29udGV4dF9mcm9tX3N0cmluZyhzZXBvbF88d2Jy
PmhhbmRsZV90ICogaGFuZGxlLDxicj4NCsKgIMKgIMKgIMKgIGNoYXIgKmNvbl9jcHkgPSBOVUxM
Ozxicj4NCsKgIMKgIMKgIMKgIHNlcG9sX2NvbnRleHRfdCAqY3R4X3JlY29yZCA9IE5VTEw7PGJy
Pg0KPGJyPg0KK8KgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJhdGVkKGNvbl9zdHJfPHdicj5s
ZW4pKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGhhbmRsZSwgJnF1b3Q7SW52
YWxpZCBjb250ZXh0IGxlbmd0aCZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Z290byBlcnI7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCAvKiBz
ZXBvbF9jb250ZXh0X2Zyb21fc3RyaW5nIGV4cGVjdHMgYSBOVUxMLXRlcm1pbmF0ZWQgc3RyaW5n
ICovPGJyPg0KwqAgwqAgwqAgwqAgY29uX2NweSA9IG1hbGxvYyhjb25fc3RyX2xlbiArIDEpOzxi
cj4NCi3CoCDCoCDCoCDCoGlmICghY29uX2NweSk8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBnb3RvIG9tZW07PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFjb25fY3B5KSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgRVJSKGhhbmRsZSwgJnF1b3Q7b3V0IG9mIG1lbW9yeSZxdW90Oyk7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBlcnI7PGJyPg0KK8KgIMKgIMKgIMKg
fTxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBtZW1jcHkoY29uX2NweSwgY29uX3N0ciwgY29uX3N0
cl9sZW4pOzxicj4NCsKgIMKgIMKgIMKgIGNvbl9jcHlbY29uX3N0cl9sZW5dID0gJiMzOTtcMCYj
Mzk7Ozxicj4NCjxicj4NCkBAIC0zMTUsOSArMzI0LDYgQEAgaW50IGNvbnRleHRfZnJvbV9zdHJp
bmcoc2Vwb2xfPHdicj5oYW5kbGVfdCAqIGhhbmRsZSw8YnI+DQrCoCDCoCDCoCDCoCBzZXBvbF9j
b250ZXh0X2ZyZWUoY3R4X3JlY29yZCk8d2JyPjs8YnI+DQrCoCDCoCDCoCDCoCByZXR1cm4gU1RB
VFVTX1NVQ0NFU1M7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIG9tZW06PGJyPg0KLcKgIMKgIMKgIMKg
RVJSKGhhbmRsZSwgJnF1b3Q7b3V0IG9mIG1lbW9yeSZxdW90Oyk7PGJyPg0KLTxicj4NCsKgIMKg
IMKgIMKgZXJyOjxicj4NCsKgIMKgIMKgIMKgIEVSUihoYW5kbGUsICZxdW90O2NvdWxkIG5vdCBj
cmVhdGUgY29udGV4dCBzdHJ1Y3R1cmUmcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIGZyZWUoY29u
X2NweSk7PGJyPg0KZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9jb250ZXh0X3JlY29yZC48d2Jy
PmMgYi9saWJzZXBvbC9zcmMvY29udGV4dF9yZWNvcmQuPHdicj5jPGJyPg0KaW5kZXggYWMyODg0
YS4uMDFmZDJjOSAxMDA2NDQ8YnI+DQotLS0gYS9saWJzZXBvbC9zcmMvY29udGV4dF9yZWNvcmQu
PHdicj5jPGJyPg0KKysrIGIvbGlic2Vwb2wvc3JjL2NvbnRleHRfcmVjb3JkLjx3YnI+Yzxicj4N
CkBAIC01LDYgKzUsNyBAQDxicj4NCjxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7Y29udGV4dF9pbnRl
cm5hbC5oJnF1b3Q7PGJyPg0KwqAjaW5jbHVkZSAmcXVvdDtkZWJ1Zy5oJnF1b3Q7PGJyPg0KKyNp
bmNsdWRlICZxdW90O3ByaXZhdGUuaCZxdW90Ozxicj4NCjxicj4NCsKgc3RydWN0IHNlcG9sX2Nv
bnRleHQgezxicj4NCjxicj4NCkBAIC0yODQsMTcgKzI4NSwyMyBAQCBpbnQgc2Vwb2xfY29udGV4
dF90b19zdHJpbmcoc2Vwb2xfPHdicj5oYW5kbGVfdCAqIGhhbmRsZSw8YnI+DQrCoHs8YnI+DQo8
YnI+DQrCoCDCoCDCoCDCoCBpbnQgcmM7PGJyPg0KLcKgIMKgIMKgIMKgY29uc3QgaW50IHVzZXJf
c3ogPSBzdHJsZW4oY29uLSZndDt1c2VyKTs8YnI+DQotwqAgwqAgwqAgwqBjb25zdCBpbnQgcm9s
ZV9zeiA9IHN0cmxlbihjb24tJmd0O3JvbGUpOzxicj4NCi3CoCDCoCDCoCDCoGNvbnN0IGludCB0
eXBlX3N6ID0gc3RybGVuKGNvbi0mZ3Q7dHlwZSk7PGJyPg0KLcKgIMKgIMKgIMKgY29uc3QgaW50
IG1sc19zeiA9IChjb24tJmd0O21scykgPyBzdHJsZW4oY29uLSZndDttbHMpIDogMDs8YnI+DQot
wqAgwqAgwqAgwqBjb25zdCBpbnQgdG90YWxfc3ogPSB1c2VyX3N6ICsgcm9sZV9zeiArIHR5cGVf
c3ogKzxicj4NCivCoCDCoCDCoCDCoGNvbnN0IHNpemVfdCB1c2VyX3N6ID0gc3RybGVuKGNvbi0m
Z3Q7dXNlcik7PGJyPg0KK8KgIMKgIMKgIMKgY29uc3Qgc2l6ZV90IHJvbGVfc3ogPSBzdHJsZW4o
Y29uLSZndDtyb2xlKTs8YnI+DQorwqAgwqAgwqAgwqBjb25zdCBzaXplX3QgdHlwZV9zeiA9IHN0
cmxlbihjb24tJmd0O3R5cGUpOzxicj4NCivCoCDCoCDCoCDCoGNvbnN0IHNpemVfdCBtbHNfc3og
PSAoY29uLSZndDttbHMpID8gc3RybGVuKGNvbi0mZ3Q7bWxzKSA6IDA7PGJyPg0KK8KgIMKgIMKg
IMKgY29uc3Qgc2l6ZV90IHRvdGFsX3N6ID0gdXNlcl9zeiArIHJvbGVfc3ogKyB0eXBlX3N6ICs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCBtbHNfc3ogKyAoKGNvbi0mZ3Q7bWxzKSA/IDMgOiAyKTs8
YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBjaGFyICpzdHIgPSAoY2hhciAqKW1hbGxvYyh0b3RhbF9z
eiArIDEpOzxicj4NCi3CoCDCoCDCoCDCoGlmICghc3RyKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGdvdG8gb21lbTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0ZWQo
dG90YWxfc3opKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGhhbmRsZSwgJnF1
b3Q7aW52YWxpZCBzaXplJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3Rv
IGVycjs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KPGJyPg0KK8KgIMKgIMKgIMKgY2hhciAqc3Ry
ID0gKGNoYXIgKiltYWxsb2ModG90YWxfc3ogKyAxKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoIXN0
cikgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVSUihoYW5kbGUsICZxdW90O291dCBv
ZiBtZW1vcnkmcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gZXJyOzxi
cj4NCivCoCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoCDCoCBpZiAoY29uLSZndDttbHMpIHs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYyA9IHNucHJpbnRmKHN0ciwgdG90YWxfc3ogKyAx
LCAmcXVvdDslczolczolczolcyZxdW90Oyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBjb24tJmd0O3VzZXIsIGNvbi0mZ3Q7cm9sZSwgY29uLSZndDt0
eXBlLCBjb24tJmd0O21scyk7PGJyPg0KQEAgLTMxNCw5ICszMjEsNiBAQCBpbnQgc2Vwb2xfY29u
dGV4dF90b19zdHJpbmcoc2Vwb2xfPHdicj5oYW5kbGVfdCAqIGhhbmRsZSw8YnI+DQrCoCDCoCDC
oCDCoCAqc3RyX3B0ciA9IHN0cjs8YnI+DQrCoCDCoCDCoCDCoCByZXR1cm4gU1RBVFVTX1NVQ0NF
U1M7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIG9tZW06PGJyPg0KLcKgIMKgIMKgIMKgRVJSKGhhbmRs
ZSwgJnF1b3Q7b3V0IG9mIG1lbW9yeSZxdW90Oyk7PGJyPg0KLTxicj4NCsKgIMKgIMKgIMKgZXJy
Ojxicj4NCsKgIMKgIMKgIMKgIEVSUihoYW5kbGUsICZxdW90O2NvdWxkIG5vdCBjb252ZXJ0IGNv
bnRleHQgdG8gc3RyaW5nJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCBmcmVlKHN0cik7PGJyPg0K
ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9tb2R1bGUuYyBiL2xpYnNlcG9sL3NyYy9tb2R1bGUu
Yzxicj4NCmluZGV4IDE2NjVlZGUuLmYyNWRmOTUgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2Vwb2wv
c3JjL21vZHVsZS5jPGJyPg0KKysrIGIvbGlic2Vwb2wvc3JjL21vZHVsZS5jPGJyPg0KQEAgLTMw
LDYgKzMwLDcgQEA8YnI+DQrCoCNpbmNsdWRlICZsdDtzdGRpby5oJmd0Ozxicj4NCsKgI2luY2x1
ZGUgJmx0O3N0ZGxpYi5oJmd0Ozxicj4NCsKgI2luY2x1ZGUgJmx0O2xpbWl0cy5oJmd0Ozxicj4N
CisjaW5jbHVkZSAmbHQ7aW50dHlwZXMuaCZndDs8YnI+DQo8YnI+DQrCoCNkZWZpbmUgU0VQT0xf
UEFDS0FHRV9TRUNUSU9OX0ZDIDB4Zjk3Y2ZmOTA8YnI+DQrCoCNkZWZpbmUgU0VQT0xfUEFDS0FH
RV9TRUNUSU9OX1NFVVNFUiAweDk3Y2ZmOTE8YnI+DQpAQCAtNzkzLDYgKzc5NCwxMiBAQCBpbnQg
c2Vwb2xfbW9kdWxlX3BhY2thZ2VfaW5mbyg8d2JyPnN0cnVjdCBzZXBvbF9wb2xpY3lfZmlsZSAq
c3BmLCBpbnQgKnR5cGUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZ290byBjbGVhbnVwOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsZW4g
PSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZpbGUtJmd0O2hhbmRsZSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAm
cXVvdDtpbnZhbGlkIG1vZHVsZSBuYW1lIGxlbmd0aDogMHglJnF1b3Q7UFJJeDMyLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxlbik7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290
byBjbGVhbnVwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqbmFtZSA9IG1hbGxvYyhsZW4g
KyAxKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoISpuYW1l
KSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
RVJSKGZpbGUtJmd0O2hhbmRsZSwgJnF1b3Q7b3V0IG9mIG1lbW9yeSZxdW90Oyk7PGJyPg0KQEAg
LTgxNCw2ICs4MjEsMTIgQEAgaW50IHNlcG9sX21vZHVsZV9wYWNrYWdlX2luZm8oPHdicj5zdHJ1
Y3Qgc2Vwb2xfcG9saWN5X2ZpbGUgKnNwZiwgaW50ICp0eXBlLDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gY2xlYW51cDs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgbGVuID0gbGUzMl90b19jcHUoYnVmWzBdKTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0ZWQobGVuKSkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVS
UihmaWxlLSZndDtoYW5kbGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7aW52YWxpZCBtb2R1bGUgdmVyc2lvbiBsZW5ndGg6
IDB4JSZxdW90O1BSSXgzMiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBsZW4pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gY2xlYW51cDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgKnZlcnNpb24gPSBtYWxsb2MobGVuICsgMSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgaWYgKCEqdmVyc2lvbikgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVSUihmaWxlLSZndDtoYW5kbGUsICZxdW90
O291dCBvZiBtZW1vcnkmcXVvdDspOzxicj4NCmRpZmYgLS1naXQgYS9saWJzZXBvbC9zcmMvbW9k
dWxlX3RvX2NpbC5jIGIvbGlic2Vwb2wvc3JjL21vZHVsZV90b19jaWwuYzxicj4NCmluZGV4IDM2
ZjNiN2QuLmZjNjUwMTkgMTAwNjQ0PGJyPg0KLS0tIGEvbGlic2Vwb2wvc3JjL21vZHVsZV90b19j
aWwuYzxicj4NCisrKyBiL2xpYnNlcG9sL3NyYy9tb2R1bGVfdG9fY2lsLmM8YnI+DQpAQCAtNDcs
NiArNDcsOCBAQDxicj4NCsKgI2luY2x1ZGUgJmx0O3NlcG9sL3BvbGljeWRiL3NlcnZpY2VzLmgm
Z3Q7PGJyPg0KwqAjaW5jbHVkZSAmbHQ7c2Vwb2wvcG9saWN5ZGIvdXRpbC5oJmd0Ozxicj4NCjxi
cj4NCisjaW5jbHVkZSAmcXVvdDtwcml2YXRlLmgmcXVvdDs8YnI+DQorPGJyPg0KwqAjaWZkZWYg
X19HTlVDX188YnI+DQrCoCPCoCBkZWZpbmUgVU5VU0VEKHgpIFVOVVNFRF8gIyMgeCBfX2F0dHJp
YnV0ZV9fKChfX3VudXNlZF9fKSk8YnI+DQrCoCNlbHNlPGJyPg0KQEAgLTEyNCw3ICsxMjYsNyBA
QCBzdGF0aWMgaW50IGdldF9saW5lKGNoYXIgKipzdGFydCwgY2hhciAqZW5kLCBjaGFyICoqbGlu
ZSk8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBmb3IgKGxlbiA9IDA7IHAgJmx0OyBlbmQgJmFtcDsm
YW1wOyAqcCAhPSAmIzM5O1xuJiMzOTsgJmFtcDsmYW1wOyAqcCAhPSAmIzM5O1wwJiMzOTs7IHAr
KywgbGVuKyspOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoGlmIChsZW4gPT0gMCkgezxicj4NCivC
oCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKSB7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmMgPSAwOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXhp
dDs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3NyYy9wb2xp
Y3lkYi5jIGIvbGlic2Vwb2wvc3JjL3BvbGljeWRiLmM8YnI+DQppbmRleCA5NzE3OTNkLi5jMmUx
YTQzIDEwMDY0NDxicj4NCi0tLSBhL2xpYnNlcG9sL3NyYy9wb2xpY3lkYi5jPGJyPg0KKysrIGIv
bGlic2Vwb2wvc3JjL3BvbGljeWRiLmM8YnI+DQpAQCAtMTkxMSw2ICsxOTExLDkgQEAgc3RhdGlj
IGludCBwZXJtX3JlYWQocG9saWN5ZGJfdCAqIHA8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBnb3RvIGJhZDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZb
MF0pOzxicj4NCivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBw
ZXJkYXR1bS0mZ3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7PGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAga2V5ID0gbWFsbG9jKGxlbiArIDEpOzxicj4NCkBAIC0xOTQ5LDYgKzE5NTIsOSBA
QCBzdGF0aWMgaW50IGNvbW1vbl9yZWFkKHBvbGljeWRiX3QgKiBwLCBoYXNodGFiX3QgaCwgc3Ry
dWN0IHBvbGljeV9maWxlICpmcCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJh
ZDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4N
CivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBjb21kYXR1bS0m
Z3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAg
aWYgKHN5bXRhYl9pbml0KCZhbXA7Y29tZGF0dW0tJmd0Ozx3YnI+cGVybWlzc2lvbnMsIFBFUk1f
U1lNVEFCX1NJWkUpKTxicj4NCkBAIC0yMDkyLDcgKzIwOTgsMTEgQEAgc3RhdGljIGludCBjbGFz
c19yZWFkKHBvbGljeWRiX3QgKiBwLCBoYXNodGFiX3QgaCwgc3RydWN0IHBvbGljeV9maWxlICpm
cCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8YnI+DQo8YnI+DQrCoCDC
oCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoGlmICh6
ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8g
YmFkOzxicj4NCsKgIMKgIMKgIMKgIGxlbjIgPSBsZTMyX3RvX2NwdShidWZbMV0pOzxicj4NCivC
oCDCoCDCoCDCoGlmIChsZW4yID09IDAgfHwgbGVuMiA9PSBTSVpFX01BWCk8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBnb3RvIGJhZDs8YnI+DQrCoCDCoCDCoCDCoCBjbGFkYXR1bS0mZ3Q7
cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1ZlsyXSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgaWYg
KHN5bXRhYl9pbml0KCZhbXA7Y2xhZGF0dW0tJmd0Ozx3YnI+cGVybWlzc2lvbnMsIFBFUk1fU1lN
VEFCX1NJWkUpKTxicj4NCkBAIC0yMTk5LDYgKzIyMDksOSBAQCBzdGF0aWMgaW50IHJvbGVfcmVh
ZChwb2xpY3lkYl90ICogcCwgaGFzaHRhYl90IGgsIHN0cnVjdCBwb2xpY3lfZmlsZSAqZnApPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBiYWQ7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgbGVuID0gbGUzMl90b19jcHUoYnVmWzBdKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoemVyb19v
cl9zYXR1cmF0ZWQobGVuKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGJhZDs8
YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgcm9sZS0mZ3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1
ZlsxXSk7PGJyPg0KwqAgwqAgwqAgwqAgaWYgKHBvbGljeWRiX2hhc19ib3VuZGFyeV88d2JyPmZl
YXR1cmUocCkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcm9sZS0mZ3Q7Ym91bmRzID0g
bGUzMl90b19jcHUoYnVmWzJdKTs8YnI+DQpAQCAtMjI4Nyw2ICsyMzAwLDkgQEAgc3RhdGljIGlu
dCB0eXBlX3JlYWQocG9saWN5ZGJfdCAqIHAsIGhhc2h0YWJfdCBoLCBzdHJ1Y3QgcG9saWN5X2Zp
bGUgKmZwKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gYmFkOzxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1Zltwb3NdKTs8YnI+DQorwqAgwqAgwqAg
wqBpZiAoemVyb19vcl9zYXR1cmF0ZWQobGVuKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBnb3RvIGJhZDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgdHlwZGF0dW0tJmd0O3MudmFsdWUg
PSBsZTMyX3RvX2NwdShidWZbKytwb3NdKTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAocG9saWN5ZGJf
aGFzX2JvdW5kYXJ5Xzx3YnI+ZmVhdHVyZShwKSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHVpbnQzMl90IHByb3BlcnRpZXM7PGJyPg0KQEAgLTI1NTYsNiArMjU3Miw5IEBAIHN0YXRp
YyBpbnQgb2NvbnRleHRfcmVhZF94ZW4oc3RydWN0IHBvbGljeWRiX2NvbXBhdF9pbmZvICppbmZv
LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlm
IChyYyAmbHQ7IDApPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1ZlswXSk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHpl
cm9fb3Jfc2F0dXJhdGVkKGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCis8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjLSZndDs8YSBocmVm
PSJodHRwOi8vdS5uYW1lIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj51Lm5hbWU8
L2E+ID0gbWFsbG9jKGxlbiArIDEpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmICghYy0mZ3Q7PGEgaHJlZj0iaHR0cDovL3UubmFtZSIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+dS5uYW1lPC9hPik8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4g
LTE7PGJyPg0KQEAgLTI2MTgsNiArMjYzNyw4IEBAIHN0YXRpYyBpbnQgb2NvbnRleHRfcmVhZF9z
ZWxpbnV4KHN0cnVjdCBwb2xpY3lkYl9jb21wYXRfaW5mbyAqaW5mbyw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmMgJmx0OyAwKTxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChs
ZW4pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBjLSZndDs8YSBocmVmPSJodHRwOi8vdS5uYW1lIiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj51Lm5hbWU8L2E+ID0gbWFsbG9jKGxlbiArIDEpOzxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmICgh
Yy0mZ3Q7PGEgaHJlZj0iaHR0cDovL3UubmFtZSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+dS5uYW1lPC9hPik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KQEAgLTI2NTksNiArMjY4
MCw4IEBAIHN0YXRpYyBpbnQgb2NvbnRleHRfcmVhZF9zZWxpbnV4KHN0cnVjdCBwb2xpY3lkYl9j
b21wYXRfaW5mbyAqaW5mbyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYy0mZ3Q7di5iZWhhdmlvciA9IGxlMzJf
dG9fY3B1KGJ1ZlswXSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgbGVuID0gbGUzMl90b19jcHUoYnVmWzFdKTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0ZWQo
bGVuKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgYy0mZ3Q7PGEgaHJlZj0iaHR0cDovL3UubmFtZSIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+dS5uYW1lPC9hPiA9IG1hbGxvYyhsZW4gKyAxKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAo
IWMtJmd0OzxhIGhyZWY9Imh0dHA6Ly91Lm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJf
YmxhbmsiPnUubmFtZTwvYT4pPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCkBAIC0yNzE5LDcgKzI3
NDIsNyBAQCBzdGF0aWMgaW50IGdlbmZzX3JlYWQocG9saWN5ZGJfdCAqIHAsIHN0cnVjdCBwb2xp
Y3lfZmlsZSAqZnApPGJyPg0KwqAgwqAgwqAgwqAgdWludDMyX3QgYnVmWzFdOzxicj4NCsKgIMKg
IMKgIMKgIHNpemVfdCBuZWwsIG5lbDIsIGxlbiwgbGVuMjs8YnI+DQrCoCDCoCDCoCDCoCBnZW5m
c190ICpnZW5mc19wLCAqbmV3Z2VuZnMsICpnZW5mczs8YnI+DQotwqAgwqAgwqAgwqB1bnNpZ25l
ZCBpbnQgaSwgajs8YnI+DQorwqAgwqAgwqAgwqBzaXplX3QgaSwgajs8YnI+DQrCoCDCoCDCoCDC
oCBvY29udGV4dF90ICpsLCAqYywgKm5ld2MgPSBOVUxMOzxicj4NCsKgIMKgIMKgIMKgIGludCBy
Yzs8YnI+DQo8YnI+DQpAQCAtMjczMyw2ICsyNzU2LDggQEAgc3RhdGljIGludCBnZW5mc19yZWFk
KHBvbGljeWRiX3QgKiBwLCBzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZwKTxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGlmIChyYyAmbHQ7IDApPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGVuID0g
bGUzMl90b19jcHUoYnVmWzBdKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoemVy
b19vcl9zYXR1cmF0ZWQobGVuKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBnb3RvIGJhZDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBuZXdnZW5mcyA9IGNh
bGxvYygxLCBzaXplb2YoZ2VuZnNfdCkpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlm
ICghbmV3Z2VuZnMpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290
byBiYWQ7PGJyPg0KQEAgLTI3NzgsNiArMjgwMyw4IEBAIHN0YXRpYyBpbnQgZ2VuZnNfcmVhZChw
b2xpY3lkYl90ICogcCwgc3RydWN0IHBvbGljeV9maWxlICpmcCk8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmMgJmx0OyAwKTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gYmFkOzxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1ZlswXSk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJh
dGVkKGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
bmV3Yy0mZ3Q7PGEgaHJlZj0iaHR0cDovL3UubmFtZSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+dS5uYW1lPC9hPiA9IG1hbGxvYyhsZW4gKyAxKTs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIW5ld2MtJmd0OzxhIGhyZWY9Imh0dHA6Ly91Lm5h
bWUiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPnUubmFtZTwvYT4pIHs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8
YnI+DQpAQCAtMjg3Nyw2ICsyOTA0LDkgQEAgc3RhdGljIGludCB1c2VyX3JlYWQocG9saWN5ZGJf
dCAqIHAsIGhhc2h0YWJfdCBoLCBzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZwKTxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGdvdG8gYmFkOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIGxlbiA9IGxl
MzJfdG9fY3B1KGJ1ZlswXSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJhdGVk
KGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBiYWQ7PGJyPg0KKzxicj4N
CsKgIMKgIMKgIMKgIHVzcmRhdHVtLSZndDtzLnZhbHVlID0gbGUzMl90b19jcHUoYnVmWzFdKTs8
YnI+DQrCoCDCoCDCoCDCoCBpZiAocG9saWN5ZGJfaGFzX2JvdW5kYXJ5Xzx3YnI+ZmVhdHVyZShw
KSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1c3JkYXR1bS0mZ3Q7Ym91bmRzID0gbGUz
Ml90b19jcHUoYnVmWzJdKTs8YnI+DQpAQCAtMjk2MCw2ICsyOTkwLDkgQEAgc3RhdGljIGludCBz
ZW5zX3JlYWQocG9saWN5ZGJfdCAqIHA8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3Rv
IGJhZDs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxi
cj4NCivCoCDCoCDCoCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBsZXZkYXR1
bS0mZ3Q7aXNhbGlhcyA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAga2V5ID0gbWFsbG9jKGxlbiArIDEpOzxicj4NCkBAIC0zMDAzLDYgKzMwMzYsOSBAQCBzdGF0
aWMgaW50IGNhdF9yZWFkKHBvbGljeWRiX3QgKiBwPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZ290byBiYWQ7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgbGVuID0gbGUzMl90b19jcHUoYnVm
WzBdKTs8YnI+DQorwqAgwqAgwqAgwqBpZih6ZXJvX29yX3NhdHVyYXRlZChsZW4pKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdvdG8gYmFkOzxicj4NCis8YnI+DQrCoCDCoCDCoCDCoCBj
YXRkYXR1bS0mZ3Q7cy52YWx1ZSA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7PGJyPg0KwqAgwqAgwqAg
wqAgY2F0ZGF0dW0tJmd0O2lzYWxpYXMgPSBsZTMyX3RvX2NwdShidWZbMl0pOzxicj4NCjxicj4N
CkBAIC0zMzM5LDYgKzMzNzUsOCBAQCBzdGF0aWMgaW50IGZpbGVuYW1lX3RyYW5zX3J1bGVfcmVh
ZCg8d2JyPmZpbGVuYW1lX3RyYW5zX3J1bGVfdCAqKiByLCBzdHJ1Y3QgcG9saWN5X2ZpPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1ZlswXSk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJhdGVkKGxlbikpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZ0ci0mZ3Q7bmFtZSA9IG1hbGxvYyhsZW4gKyAxKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIWZ0ci0mZ3Q7bmFtZSk8YnI+DQpAQCAt
MzU4MCw2ICszNjE4LDggQEAgc3RhdGljIGludCBzY29wZV9yZWFkKHBvbGljeWRiX3QgKiBwLCBp
bnQgc3ltbnVtLCBzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZwKTxicj4NCsKgIMKgIMKgIMKgIGlmIChy
YyAmbHQ7IDApPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBjbGVhbnVwOzxicj4N
CsKgIMKgIMKgIMKgIGtleV9sZW4gPSBsZTMyX3RvX2NwdShidWZbMF0pOzxicj4NCivCoCDCoCDC
oCDCoGlmICh6ZXJvX29yX3NhdHVyYXRlZChrZXlfbGVuKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBnb3RvIGNsZWFudXA7PGJyPg0KwqAgwqAgwqAgwqAga2V5ID0gbWFsbG9jKGtleV9s
ZW4gKyAxKTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAoIWtleSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBnb3RvIGNsZWFudXA7PGJyPg0KQEAgLTM2NjQsOCArMzcwNCw4IEBAIGludCBwb2xp
Y3lkYl9yZWFkKHBvbGljeWRiX3QgKiBwLCBzdHJ1Y3QgcG9saWN5X2ZpbGUgKmZwLCB1bnNpZ25l
ZCB2ZXJib3NlKTxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBsZW4g
PSBidWZbMV07PGJyPg0KLcKgIMKgIMKgIMKgaWYgKGxlbiAmZ3Q7IFBPTElDWURCX1NUUklOR19N
QVhfTEVOR1RIKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRVJSKGZwLSZndDtoYW5k
bGUsICZxdW90O3BvbGljeWRiIHN0cmluZyBsZW5ndGggdG9vIGxvbmcgJnF1b3Q7KTs8YnI+DQor
wqAgwqAgwqAgwqBpZiAobGVuID09IDAgfHwgbGVuICZndDsgUE9MSUNZREJfU1RSSU5HX01BWF9M
RU5HVEgpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBFUlIoZnAtJmd0O2hhbmRsZSwg
JnF1b3Q7cG9saWN5ZGIgc3RyaW5nIGxlbmd0aCAlcyAmcXVvdDssIGxlbiA/ICZxdW90O3RvbyBs
b25nJnF1b3Q7IDogJnF1b3Q7emVybyZxdW90Oyk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmV0dXJuIFBPTElDWURCX0VSUk9SOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQpA
QCAtMzc5OCw2ICszODM4LDggQEAgaW50IHBvbGljeWRiX3JlYWQocG9saWN5ZGJfdCAqIHAsIHN0
cnVjdCBwb2xpY3lfZmlsZSAqZnAsIHVuc2lnbmVkIHZlcmJvc2UpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxlbiA9IGxlMzJfdG9fY3B1KGJ1
ZlswXSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHplcm9fb3Jfc2F0dXJhdGVk
KGxlbikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ290byBiYWQ7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKChwLSZndDtuYW1lID0gbWFsbG9jKGxl
biArIDEpKSA9PSBOVUxMKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZ290byBiYWQ7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCkBAIC0zODA5
LDYgKzM4NTEsOCBAQCBpbnQgcG9saWN5ZGJfcmVhZChwb2xpY3lkYl90ICogcCwgc3RydWN0IHBv
bGljeV9maWxlICpmcCwgdW5zaWduZWQgdmVyYm9zZSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBnb3RvIGJhZDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbGVuID0gbGUzMl90b19jcHUoYnVmWzBdKTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoemVyb19vcl9zYXR1cmF0ZWQobGVuKSk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnb3RvIGJhZDs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoKHAtJmd0O3ZlcnNpb24gPSBtYWxsb2MobGVuICsg
MSkpID09IE5VTEwpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBn
b3RvIGJhZDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KZGlmZiAtLWdpdCBh
L2xpYnNlcG9sL3NyYy9wcml2YXRlLmggYi9saWJzZXBvbC9zcmMvcHJpdmF0ZS5oPGJyPg0KaW5k
ZXggOWM3MDBjOS4uNWJjNWQ2NCAxMDA2NDQ8YnI+DQotLS0gYS9saWJzZXBvbC9zcmMvcHJpdmF0
ZS5oPGJyPg0KKysrIGIvbGlic2Vwb2wvc3JjL3ByaXZhdGUuaDxicj4NCkBAIC00NSw2ICs0NSw4
IEBAPGJyPg0KPGJyPg0KwqAjZGVmaW5lIEFSUkFZX1NJWkUoeCkgKHNpemVvZih4KS9zaXplb2Yo
KHgpWzBdKSk8YnI+DQo8YnI+DQorI2RlZmluZSB6ZXJvX29yX3NhdHVyYXRlZCh4KSAoKHggPT0g
MCkgfHwgKHggPT0gKHR5cGVvZih4KSktMSkpPGJyPg0KKzxicj4NCsKgLyogUG9saWN5IGNvbXBh
dGliaWxpdHkgaW5mb3JtYXRpb24uICovPGJyPg0KwqBzdHJ1Y3QgcG9saWN5ZGJfY29tcGF0X2lu
Zm8gezxicj4NCsKgIMKgIMKgIMKgIHVuc2lnbmVkIGludCB0eXBlOzxicj4NCjxzcGFuIGNsYXNz
PSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij4tLTxicj4NCjEuOS4xPGJyPg0KPGJyPg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPHdicj5fX19fX19fX19fX19fX19fXzxicj4N
ClNlYW5kcm9pZC1saXN0IG1haWxpbmcgbGlzdDxicj4NCjxhIGhyZWY9Im1haWx0bzpTZWFuZHJv
aWQtbGlzdEB0eWNoby5uc2EuZ292Ij5TZWFuZHJvaWQtbGlzdEB0eWNoby5uc2EuZ292PC9hPjxi
cj4NClRvIHVuc3Vic2NyaWJlLCBzZW5kIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzpTZWFuZHJv
aWQtbGlzdC1sZWF2ZUB0eWNoby5uc2EuZ292Ij5TZWFuZHJvaWQtbGlzdC1sZWF2ZUB0eWNoby48
d2JyPm5zYS5nb3Y8L2E+Ljxicj4NClRvIGdldCBoZWxwLCBzZW5kIGFuIGVtYWlsIGNvbnRhaW5p
bmcgJnF1b3Q7aGVscCZxdW90OyB0byA8YSBocmVmPSJtYWlsdG86U2VhbmRyb2lkLWxpc3QtcmVx
dWVzdEB0eWNoby5uc2EuZ292Ij5TZWFuZHJvaWQtbGlzdC1yZXF1ZXN0QHR5Y2hvLjx3YnI+bnNh
LmdvdjwvYT4uPGJyPg0KPC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxiciBj
bGVhcj0iYWxsIj48ZGl2Pjxicj48L2Rpdj4tLSA8YnI+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0
dXJlIiBkYXRhLXNtYXJ0bWFpbD0iZ21haWxfc2lnbmF0dXJlIj5SZXNwZWN0ZnVsbHksPGJyPjxi
cj5XaWxsaWFtIEMgUm9iZXJ0czxicj48YnI+PC9kaXY+DQo8L2Rpdj4NCg==
--001a114382e8b707360539bebd27--
