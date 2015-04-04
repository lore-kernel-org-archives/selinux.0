Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t34JhtOs011741
 for <selinux@tycho.nsa.gov>; Sat, 4 Apr 2015 15:43:55 -0400
Received: by obbfy7 with SMTP id fy7so915315obb.2
 for <selinux@tycho.nsa.gov>; Sat, 04 Apr 2015 12:43:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnH0V_+ZRoJ3Ff4zTFf5t+Bz2DOQ0fZnwMziy1WFBcwDbw@mail.gmail.com>
References: <1427990285-9746-1-git-send-email-sds@tycho.nsa.gov>
 <CAFJ0LnH0V_+ZRoJ3Ff4zTFf5t+Bz2DOQ0fZnwMziy1WFBcwDbw@mail.gmail.com>
Date: Sat, 4 Apr 2015 12:43:52 -0700
Message-ID: <CABXk95A1r2hNTt1CeEXdn4c5_cXtsdQkzDY0GPZJua=J8BVfXw@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol, secilc: Fix build for Android
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-by: Jeff Vander Stoep <jeffv@google.com>

On Thu, Apr 2, 2015 at 3:51 PM, Nick Kralevich <nnk@google.com> wrote:
> Acked-by: Nick Kralevich <nnk@google.com>
>
> On Thu, Apr 2, 2015 at 8:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> The Android build does not like the symbol versioning introduced
>> by commit 8147bc7; the build fails with:
>> host SharedLib: libsepol (out/host/linux-x86/obj/lib/libsepol.so)
>> prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8//x86_64-linux/bin/ld: error: symbol cil_build_policydb has undefined version
>> prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8//x86_64-linux/bin/ld: error: symbol cil_build_policydb has undefined version LIBSEPOL_1.1
>> clang: error: linker command failed with exit code 1 (use -v to see invocation)
>>
>> Omit the versioned symbols and simply use the current interfaces
>> when building on Android.
>>
>> Commit 36f62b7 also broke the Android build by moving secilc out of
>> libsepol, because the libsepol headers were not installed by the Android.mk
>> file.
>>
>> Export the required libsepol headers for use by secilc and adjust secilc
>> to pick them up from the right location on Android.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>  libsepol/Android.mk    |  2 ++
>>  libsepol/cil/src/cil.c | 30 ++++++++++++++++++++++++++++++
>>  secilc/Android.mk      |  4 ++--
>>  secilc/secilc.c        |  4 ++++
>>  4 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsepol/Android.mk b/libsepol/Android.mk
>> index 3e4700b..36f6d27 100644
>> --- a/libsepol/Android.mk
>> +++ b/libsepol/Android.mk
>> @@ -89,6 +89,8 @@ include $(CLEAR_VARS)
>>
>>  LOCAL_MODULE := libsepol
>>  LOCAL_MODULE_TAGS := optional
>> +LOCAL_COPY_HEADERS_TO := sepol
>> +LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h cil/include/cil/cil.h
>>  LOCAL_C_INCLUDES := $(common_includes)
>>  LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
>>  LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
>> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
>> index 1594be6..b852628 100644
>> --- a/libsepol/cil/src/cil.c
>> +++ b/libsepol/cil/src/cil.c
>> @@ -51,6 +51,7 @@
>>  #include "cil_policy.h"
>>  #include "cil_strpool.h"
>>
>> +#ifndef ANDROID
>>  asm(".symver cil_build_policydb_pdb,        cil_build_policydb@");
>>  asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
>>
>> @@ -65,6 +66,7 @@ asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSE
>>
>>  asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@");
>>  asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
>> +#endif
>>
>>  int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
>>         {64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
>> @@ -352,7 +354,11 @@ exit:
>>         return rc;
>>  }
>>
>> +#ifdef ANDROID
>> +int cil_compile(struct cil_db *db)
>> +#else
>>  int cil_compile_nopdb(struct cil_db *db)
>> +#endif
>>  {
>>         int rc = SEPOL_ERR;
>>
>> @@ -396,6 +402,7 @@ exit:
>>         return rc;
>>  }
>>
>> +#ifndef ANDROID
>>  int cil_compile_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db)
>>  {
>>         return cil_compile_nopdb(db);
>> @@ -415,8 +422,13 @@ int cil_build_policydb_pdb(cil_db_t *db, sepol_policydb_t *sepol_db)
>>  exit:
>>         return rc;
>>  }
>> +#endif
>>
>> +#ifdef ANDROID
>> +int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)
>> +#else
>>  int cil_build_policydb_create_pdb(cil_db_t *db, sepol_policydb_t **sepol_db)
>> +#endif
>>  {
>>         int rc;
>>
>> @@ -1104,7 +1116,11 @@ const char * cil_node_to_string(struct cil_tree_node *node)
>>         return "<unknown>";
>>  }
>>
>> +#ifdef ANDROID
>> +int cil_userprefixes_to_string(struct cil_db *db, char **out, size_t *size)
>> +#else
>>  int cil_userprefixes_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
>> +#endif
>>  {
>>         int rc = SEPOL_ERR;
>>         size_t str_len = 0;
>> @@ -1149,10 +1165,12 @@ exit:
>>
>>  }
>>
>> +#ifndef ANDROID
>>  int cil_userprefixes_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
>>  {
>>         return cil_userprefixes_to_string_nopdb(db, out, size);
>>  }
>> +#endif
>>
>>  static int cil_cats_to_ebitmap(struct cil_cats *cats, struct ebitmap* cats_ebitmap)
>>  {
>> @@ -1339,7 +1357,11 @@ static int __cil_level_to_string(struct cil_level *lvl, char *out)
>>         return str_tmp - out;
>>  }
>>
>> +#ifdef ANDROID
>> +int cil_selinuxusers_to_string(struct cil_db *db, char **out, size_t *size)
>> +#else
>>  int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
>> +#endif
>>  {
>>         size_t str_len = 0;
>>         int buf_pos = 0;
>> @@ -1396,12 +1418,18 @@ int cil_selinuxusers_to_string_nopdb(struct cil_db *db, char **out, size_t *size
>>         return SEPOL_OK;
>>  }
>>
>> +#ifndef ANDROID
>>  int cil_selinuxusers_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
>>  {
>>         return cil_selinuxusers_to_string_nopdb(db, out, size);
>>  }
>> +#endif
>>
>> +#ifdef ANDROID
>> +int cil_filecons_to_string(struct cil_db *db, char **out, size_t *size)
>> +#else
>>  int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
>> +#endif
>>  {
>>         uint32_t i = 0;
>>         int buf_pos = 0;
>> @@ -1519,10 +1547,12 @@ int cil_filecons_to_string_nopdb(struct cil_db *db, char **out, size_t *size)
>>         return SEPOL_OK;
>>  }
>>
>> +#ifndef ANDROID
>>  int cil_filecons_to_string_pdb(struct cil_db *db, __attribute__((unused)) sepol_policydb_t *sepol_db, char **out, size_t *size)
>>  {
>>         return cil_filecons_to_string_nopdb(db, out, size);
>>  }
>> +#endif
>>
>>  void cil_set_disable_dontaudit(struct cil_db *db, int disable_dontaudit)
>>  {
>> diff --git a/secilc/Android.mk b/secilc/Android.mk
>> index b80955c..ef584e7 100644
>> --- a/secilc/Android.mk
>> +++ b/secilc/Android.mk
>> @@ -24,8 +24,8 @@ LOCAL_MODULE := secilc
>>  LOCAL_MODULE_TAGS := optional
>>  LOCAL_C_INCLUDES := $(common_includes)
>>  LOCAL_CFLAGS := $(common_cflags)
>> -LOCAL_SRC_FILES := ./secilc.c
>> -LOCAL_SHARED_LIRARIES := libsepol
>> +LOCAL_SRC_FILES := secilc.c
>> +LOCAL_SHARED_LIBRARIES := libsepol
>>  LOCAL_MODULE_CLASS := EXECUTABLES
>>
>>  include $(BUILD_HOST_EXECUTABLE)
>> diff --git a/secilc/secilc.c b/secilc/secilc.c
>> index 923151c..e98abe2 100644
>> --- a/secilc/secilc.c
>> +++ b/secilc/secilc.c
>> @@ -34,7 +34,11 @@
>>  #include <getopt.h>
>>  #include <sys/stat.h>
>>
>> +#ifdef ANDROID
>> +#include <sepol/cil.h>
>> +#else
>>  #include <sepol/cil/cil.h>
>> +#endif
>>  #include <sepol/policydb.h>
>>
>>  void usage(char *prog)
>> --
>> 1.9.3
>>
>
>
>
> --
> Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
