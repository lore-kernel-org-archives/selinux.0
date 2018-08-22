Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7MIJB5R030773
 for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2018 14:19:13 -0400
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5DB9A561254
 for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2018 20:18:59 +0200 (CEST)
Received: by mail-oi0-f44.google.com with SMTP id q11-v6so4730244oic.12
 for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2018 11:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=m205+Xsx2D4nf4xMk1Y3WCZjm4+xUHFPsmdELZP_e5PA@mail.gmail.com>
 <20180821131731.12104-1-vmojzis@redhat.com>
In-Reply-To: <20180821131731.12104-1-vmojzis@redhat.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 22 Aug 2018 20:18:46 +0200
Message-ID: <CAJfZ7=mmuq=EBN+u4Jzamm2WWHw1=+cZaih9Nch1ui65BQbA9w@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage: reset umask before creating
 directories
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 21, 2018 at 3:18 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Restrictive umask may cause creating directories with with unintended
> access mode. Reset umask before creating directories to avoid this
> issue.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186422
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, I merged this commit.

Nicolas

> ---
>  libsemanage/src/semanage_store.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index f1984c50..58dded6e 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -541,14 +541,18 @@ int semanage_create_store(semanage_handle_t * sh, int create)
>         struct stat sb;
>         const char *path = semanage_files[SEMANAGE_ROOT];
>         int fd;
> +       mode_t mask;
>
>         if (stat(path, &sb) == -1) {
>                 if (errno == ENOENT && create) {
> +                       mask = umask(0077);
>                         if (mkdir(path, S_IRWXU) == -1) {
> +                               umask(mask);
>                                 ERR(sh, "Could not create module store at %s.",
>                                     path);
>                                 return -2;
>                         }
> +                       umask(mask);
>                 } else {
>                         if (create)
>                                 ERR(sh,
> @@ -567,12 +571,15 @@ int semanage_create_store(semanage_handle_t * sh, int create)
>         path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
>         if (stat(path, &sb) == -1) {
>                 if (errno == ENOENT && create) {
> +                       mask = umask(0077);
>                         if (mkdir(path, S_IRWXU) == -1) {
> +                               umask(mask);
>                                 ERR(sh,
>                                     "Could not create module store, active subdirectory at %s.",
>                                     path);
>                                 return -2;
>                         }
> +                       umask(mask);
>                 } else {
>                         ERR(sh,
>                             "Could not read from module store, active subdirectory at %s.",
> @@ -590,12 +597,15 @@ int semanage_create_store(semanage_handle_t * sh, int create)
>         path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
>         if (stat(path, &sb) == -1) {
>                 if (errno == ENOENT && create) {
> +                       mask = umask(0077);
>                         if (mkdir(path, S_IRWXU) == -1) {
> +                               umask(mask);
>                                 ERR(sh,
>                                     "Could not create module store, active modules subdirectory at %s.",
>                                     path);
>                                 return -2;
>                         }
> +                       umask(mask);
>                 } else {
>                         ERR(sh,
>                             "Could not read from module store, active modules subdirectory at %s.",
> @@ -613,11 +623,14 @@ int semanage_create_store(semanage_handle_t * sh, int create)
>         path = semanage_files[SEMANAGE_READ_LOCK];
>         if (stat(path, &sb) == -1) {
>                 if (errno == ENOENT && create) {
> +                       mask = umask(0077);
>                         if ((fd = creat(path, S_IRUSR | S_IWUSR)) == -1) {
> +                               umask(mask);
>                                 ERR(sh, "Could not create lock file at %s.",
>                                     path);
>                                 return -2;
>                         }
> +                       umask(mask);
>                         close(fd);
>                 } else {
>                         ERR(sh, "Could not read lock file at %s.", path);
> @@ -763,6 +776,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>         struct stat sb;
>         struct dirent **names = NULL;
>         char path[PATH_MAX], path2[PATH_MAX];
> +       mode_t mask;
>
>         if ((len = scandir(src, &names, semanage_filename_select, NULL)) == -1) {
>                 fprintf(stderr, "Could not read the contents of %s: %s\n", src, strerror(errno));
> @@ -770,10 +784,13 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>         }
>
>         if (stat(dst, &sb) != 0) {
> +               mask = umask(0077);
>                 if (mkdir(dst, S_IRWXU) != 0) {
> +                       umask(mask);
>                         fprintf(stderr, "Could not create %s: %s\n", dst, strerror(errno));
>                         goto cleanup;
>                 }
> +               umask(mask);
>         }
>
>         for (i = 0; i < len; i++) {
> @@ -785,14 +802,20 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>                 }
>                 snprintf(path2, sizeof(path2), "%s/%s", dst, names[i]->d_name);
>                 if (S_ISDIR(sb.st_mode)) {
> +                       mask = umask(0077);
>                         if (mkdir(path2, 0700) == -1 ||
>                             semanage_copy_dir_flags(path, path2, flag) == -1) {
> +                               umask(mask);
>                                 goto cleanup;
>                         }
> +                       umask(mask);
>                 } else if (S_ISREG(sb.st_mode) && flag == 1) {
> +                       mask = umask(0077);
>                         if (semanage_copy_file(path, path2, sb.st_mode) < 0) {
> +                               umask(mask);
>                                 goto cleanup;
>                         }
> +                       umask(mask);
>                 }
>         }
>         retval = 0;
> @@ -872,16 +895,20 @@ int semanage_mkdir(semanage_handle_t *sh, const char *path)
>  {
>         int status = 0;
>         struct stat sb;
> +       mode_t mask;
>
>         /* check if directory already exists */
>         if (stat(path, &sb) != 0) {
>                 /* make the modules directory */
> +               mask = umask(0077);
>                 if (mkdir(path, S_IRWXU) != 0) {
> +                       umask(mask);
>                         ERR(sh, "Cannot make directory at %s", path);
>                         status = -1;
>                         goto cleanup;
>
>                 }
> +               umask(mask);
>         }
>         else {
>                 /* check that it really is a directory */
> @@ -906,6 +933,7 @@ int semanage_make_sandbox(semanage_handle_t * sh)
>         const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
>         struct stat buf;
>         int errsv;
> +       mode_t mask;
>
>         if (stat(sandbox, &buf) == -1) {
>                 if (errno != ENOENT) {
> @@ -922,12 +950,15 @@ int semanage_make_sandbox(semanage_handle_t * sh)
>                 }
>         }
>
> +       mask = umask(0077);
>         if (mkdir(sandbox, S_IRWXU) == -1 ||
>             semanage_copy_dir(semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL),
>                               sandbox) == -1) {
> +               umask(mask);
>                 ERR(sh, "Could not copy files to sandbox %s.", sandbox);
>                 goto cleanup;
>         }
> +       umask(mask);
>         return 0;
>
>        cleanup:
> --
> 2.14.3
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
