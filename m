Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1SIOIuw000968
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 13:24:18 -0500
Received: by mail-ot0-f194.google.com with SMTP id 108so3109426otv.3
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 10:24:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdq6FSzXqYnEGuXMSo0LXuiHY36yLaipVwyh-Cisgu3Lpw@mail.gmail.com>
References: <1498485334.13301.9.camel@tycho.nsa.gov>
 <20180228101510.21023-1-vmojzis@redhat.com>
 <20180228101510.21023-3-vmojzis@redhat.com>
 <CAFftDdq6FSzXqYnEGuXMSo0LXuiHY36yLaipVwyh-Cisgu3Lpw@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Feb 2018 10:24:14 -0800
Message-ID: <CAFftDdrLJwF3eeWiYTdaxT=fJL89=pFN=_rZHYEPsh-nZCXanQ@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 3/3] libsemanage: replace access() checks to
 make setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Where is patch 2/2, I have yet to see it?

Did something get screwy and is it: [PATCH] libsemanage: Improve
warning for installing disabled module


On Wed, Feb 28, 2018 at 9:50 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Wed, Feb 28, 2018 at 2:15 AM, Vit Mojzis <vmojzis@redhat.com> wrote:
>> access() uses real UID instead of effective UID which causes false
>> negative checks in setuid programs.
>> Replace access(,F_OK) (i.e. tests for file existence) by stat().
>> And access(,R_OK) by fopen(,"r")
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>  libsemanage/src/direct_api.c     | 132 +++++++++++++++++++++++++--------------
>>  libsemanage/src/semanage_store.c |  14 ++++-
>>  2 files changed, 98 insertions(+), 48 deletions(-)
>>
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index f4d57cf8..d42a51cd 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -140,6 +140,7 @@ int semanage_direct_is_managed(semanage_handle_t * sh)
>>  int semanage_direct_connect(semanage_handle_t * sh)
>>  {
>>         const char *path;
>> +       struct stat sb;
>>
>>         if (semanage_check_init(sh, sh->conf->store_root_path))
>>                 goto err;
>> @@ -302,10 +303,17 @@ int semanage_direct_connect(semanage_handle_t * sh)
>>
>>         /* set the disable dontaudit value */
>>         path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_DISABLE_DONTAUDIT);
>> -       if (access(path, F_OK) == 0)
>> +
>> +       if (stat(path, &sb) == 0)
>>                 sepol_set_disable_dontaudit(sh->sepolh, 1);
>> -       else
>> +       else {
>> +               if (errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                       goto err;
>> +               }
>> +
>>                 sepol_set_disable_dontaudit(sh->sepolh, 0);
>> +       }
>>
>>         return STATUS_SUCCESS;
>>
>> @@ -1139,6 +1147,7 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
>>         int status = 0;
>>         int i;
>>         char cil_path[PATH_MAX];
>> +       struct stat sb;
>>
>>         assert(sh);
>>         assert(modinfos);
>> @@ -1155,9 +1164,13 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
>>                 }
>>
>>                 if (semanage_get_ignore_module_cache(sh) == 0 &&
>> -                               access(cil_path, F_OK) == 0) {
>> +                               (status = stat(cil_path, &sb)) == 0) {
>>                         continue;
>>                 }
>> +               if (status != 0 && errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", cil_path, strerror(errno));
>> +                       goto cleanup; //an error in the "stat" call
>> +               }
>>
>>                 status = semanage_compile_module(sh, &modinfos[i]);
>>                 if (status < 0) {
>> @@ -1188,6 +1201,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>         struct cil_db *cildb = NULL;
>>         semanage_module_info_t *modinfos = NULL;
>>         mode_t mask = umask(0077);
>> +       struct stat sb;
>>
>>         int do_rebuild, do_write_kernel, do_install;
>>         int fcontexts_modified, ports_modified, seusers_modified,
>> @@ -1226,10 +1240,16 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>
>>         /* Create or remove the disable_dontaudit flag file. */
>>         path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
>> -       if (access(path, F_OK) == 0)
>> +       if (stat(path, &sb) == 0)
>>                 do_rebuild |= !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
>> -       else
>> +       else {
>> +               if (errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                       goto cleanup;
>> +               }
>> +
>
> I am not a huge fan of this if under else block of if (errno !=ENOENT).
>
> maybe this is a bit cleaner:
>
> if (stat() == 0)
>   //exists
> else if (errno == ENOENT)
>   // doesn't exist
> else
>   //fail
>
>>                 do_rebuild |= (sepol_get_disable_dontaudit(sh->sepolh) == 1);
>> +       }
>>         if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
>>                 FILE *touch;
>>                 touch = fopen(path, "w");
>> @@ -1251,10 +1271,17 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>
>>         /* Create or remove the preserve_tunables flag file. */
>>         path = semanage_path(SEMANAGE_TMP, SEMANAGE_PRESERVE_TUNABLES);
>> -       if (access(path, F_OK) == 0)
>> +       if (stat(path, &sb) == 0)
>>                 do_rebuild |= !(sepol_get_preserve_tunables(sh->sepolh) == 1);
>> -       else
>> +       else {
>> +               if (errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                       goto cleanup;
>> +               }
>> +
>>                 do_rebuild |= (sepol_get_preserve_tunables(sh->sepolh) == 1);
>> +       }
>> +
>>         if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
>>                 FILE *touch;
>>                 touch = fopen(path, "w");
>> @@ -1291,40 +1318,24 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>          * a rebuild.
>>          */
>>         if (!do_rebuild) {
>> -               path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL);
>> -               if (access(path, F_OK) != 0) {
>> -                       do_rebuild = 1;
>> -                       goto rebuild;
>> -               }
>> -
>> -               path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
>> -               if (access(path, F_OK) != 0) {
>> -                       do_rebuild = 1;
>> -                       goto rebuild;
>> -               }
>> -
>> -               path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
>> -               if (access(path, F_OK) != 0) {
>> -                       do_rebuild = 1;
>> -                       goto rebuild;
>> -               }
>> -
>> -               path = semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED);
>> -               if (access(path, F_OK) != 0) {
>> -                       do_rebuild = 1;
>> -                       goto rebuild;
>> -               }
>> -
>> -               path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
>> -               if (access(path, F_OK) != 0) {
>> -                       do_rebuild = 1;
>> -                       goto rebuild;
>> -               }
>> +               int files[] = {SEMANAGE_STORE_KERNEL,
>> +                                          SEMANAGE_STORE_FC,
>> +                                          SEMANAGE_STORE_SEUSERS,
>> +                                          SEMANAGE_LINKED,
>> +                                          SEMANAGE_SEUSERS_LINKED,
>> +                                          SEMANAGE_USERS_EXTRA_LINKED};
>> +
>> +               for (i = 0; i < (int) sizeof(files); i++) {
>> +                       path = semanage_path(SEMANAGE_TMP, files[i]);
>> +                       if (stat(path, &sb) != 0) {
>> +                               if (errno != ENOENT) {
>> +                                       ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                                       goto cleanup;
>> +                               }
>>
>> -               path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
>> -               if (access(path, F_OK) != 0) {
>> -                       do_rebuild = 1;
>> -                       goto rebuild;
>> +                               do_rebuild = 1;
>> +                               goto rebuild;
>> +                       }
>>                 }
>>         }
>>
>> @@ -1457,7 +1468,7 @@ rebuild:
>>                         goto cleanup;
>>
>>                 path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
>> -               if (access(path, F_OK) == 0) {
>> +               if (stat(path, &sb) == 0) {
>>                         retval = semanage_copy_file(path,
>>                                                     semanage_path(SEMANAGE_TMP,
>>                                                                   SEMANAGE_STORE_SEUSERS),
>> @@ -1466,11 +1477,16 @@ rebuild:
>>                                 goto cleanup;
>>                         pseusers->dtable->drop_cache(pseusers->dbase);
>>                 } else {
>> +                       if (errno != ENOENT) {
>> +                               ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                               goto cleanup;
>> +                       }
>> +
>>                         pseusers->dtable->clear(sh, pseusers->dbase);
>>                 }
>>
>>                 path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
>> -               if (access(path, F_OK) == 0) {
>> +               if (stat(path, &sb) == 0) {
>>                         retval = semanage_copy_file(path,
>>                                                     semanage_path(SEMANAGE_TMP,
>>                                                                   SEMANAGE_USERS_EXTRA),
>> @@ -1479,6 +1495,11 @@ rebuild:
>>                                 goto cleanup;
>>                         pusers_extra->dtable->drop_cache(pusers_extra->dbase);
>>                 } else {
>> +                       if (errno != ENOENT) {
>> +                               ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                               goto cleanup;
>> +                       }
>> +
>>                         pusers_extra->dtable->clear(sh, pusers_extra->dbase);
>>                 }
>>         }
>> @@ -1809,6 +1830,7 @@ static int semanage_direct_extract(semanage_handle_t * sh,
>>         ssize_t _data_len;
>>         char *_data;
>>         int compressed;
>> +       struct stat sb;
>>
>>         /* get path of module */
>>         rc = semanage_module_get_path(
>> @@ -1821,8 +1843,8 @@ static int semanage_direct_extract(semanage_handle_t * sh,
>>                 goto cleanup;
>>         }
>>
>> -       if (access(module_path, F_OK) != 0) {
>> -               ERR(sh, "Module does not exist: %s", module_path);
>> +       if (stat(module_path, &sb) != 0) {
>> +               ERR(sh, "Unable to access %s: %s\n", module_path, strerror(errno));
>>                 rc = -1;
>>                 goto cleanup;
>>         }
>> @@ -1851,7 +1873,12 @@ static int semanage_direct_extract(semanage_handle_t * sh,
>>                 goto cleanup;
>>         }
>>
>> -       if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && access(input_file, F_OK) != 0) {
>> +       if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && stat(input_file, &sb) != 0) {
>> +               if (errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", input_file, strerror(errno));
>> +                       goto cleanup;
>> +               }
>> +
>>                 rc = semanage_compile_module(sh, _modinfo);
>>                 if (rc < 0) {
>>                         goto cleanup;
>> @@ -1996,6 +2023,12 @@ static int semanage_direct_get_enabled(semanage_handle_t *sh,
>>         }
>>
>>         if (stat(path, &sb) < 0) {
>> +               if (errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                       status = -1;
>> +                       goto cleanup;
>> +               }
>> +
>>                 *enabled = 1;
>>         }
>>         else {
>> @@ -2322,6 +2355,12 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
>>
>>         /* set enabled/disabled status */
>>         if (stat(fn, &sb) < 0) {
>> +               if (errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", fn, strerror(errno));
>> +                       status = -1;
>> +                       goto cleanup;
>> +               }
>> +
>>                 ret = semanage_module_info_set_enabled(sh, *modinfo, 1);
>>                 if (ret != 0) {
>>                         status = -1;
>> @@ -2730,6 +2769,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
>>         int status = 0;
>>         int ret = 0;
>>         int type;
>> +       struct stat sb;
>>
>>         char path[PATH_MAX];
>>         mode_t mask = umask(0077);
>> @@ -2830,7 +2870,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
>>                         goto cleanup;
>>                 }
>>
>> -               if (access(path, F_OK) == 0) {
>> +               if (stat(path, &sb) == 0) {
>>                         ret = unlink(path);
>>                         if (ret != 0) {
>>                                 ERR(sh, "Error while removing cached CIL file %s: %s", path, strerror(errno));
>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
>> index 4bd1d651..83c188dc 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -514,6 +514,7 @@ char *semanage_conf_path(void)
>>  {
>>         char *semanage_conf = NULL;
>>         int len;
>> +       FILE *fp = NULL;
>>
>>         len = strlen(semanage_root()) + strlen(selinux_path()) + strlen(SEMANAGE_CONF_FILE);
>>         semanage_conf = calloc(len + 1, sizeof(char));
>> @@ -522,7 +523,10 @@ char *semanage_conf_path(void)
>>         snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(), selinux_path(),
>>                  SEMANAGE_CONF_FILE);
>>
>> -       if (access(semanage_conf, R_OK) != 0) {
>> +       //the following replaces access(semanage_conf, R_OK) check
>> +       if ((fp = fopen(semanage_conf, "r")) != NULL) {
>> +               fclose(fp);
>> +       } else {
>>                 snprintf(semanage_conf, len + 1, "%s%s", selinux_path(), SEMANAGE_CONF_FILE);
>>         }
>>
>> @@ -1508,8 +1512,14 @@ int semanage_split_fc(semanage_handle_t * sh)
>>  static int sefcontext_compile(semanage_handle_t * sh, const char *path) {
>>
>>         int r;
>> +       struct stat sb;
>> +
>> +       if (stat(path, &sb) < 0) {
>> +               if (errno != ENOENT) {
>> +                       ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
>> +                       return -1;
>> +               }
>>
>> -       if (access(path, F_OK) != 0) {
>>                 return 0;
>>         }
>>
>> --
>> 2.14.3
>>
>>
>
>
>
> --
> Respectfully,
>
> William C Roberts



-- 
Respectfully,

William C Roberts
