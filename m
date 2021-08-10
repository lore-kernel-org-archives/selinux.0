Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452FDC4338F
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177BC6056C
	for <selinux@archiver.kernel.org>; Tue, 10 Aug 2021 18:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhHJS2g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhHJS2d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Aug 2021 14:28:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1D2C0613D3
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:28:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o185so359741oih.13
        for <selinux@vger.kernel.org>; Tue, 10 Aug 2021 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ARSXsdtqK6oSJrEoHqzdwyhGgKIZGQaOikE9s4ghJVs=;
        b=id9//nKlAfRX+iFb6JLMSLD5V+FThWa4hKTPhIjjr3zyPciqgTQwRVUFgN/OKoZqtq
         9yHGOaY3URAzadn5wy7vttXeV6ZgYgS4ygSOsSHm7OGMbdlGeJJDSE5oJ+mwPHfY238+
         w7X97GI3XQ19Xq05p3h05eiU8Li/8sLhxMFIfEkZ30xNhYLyfWFcq6K1H5wWX0Q92WXN
         We1A1xzYCLTSwuWW9frRNAVzUWKlrcmiy0e04UITWe2RL348XLHIw1WATDXx3DBYq3MR
         vXpFRsBz8V96+bV+R9GVTmJU9TCvfnAer+a6V/qsppfWK+uuV+h9+DezzXQxZI4Ff8PG
         LLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARSXsdtqK6oSJrEoHqzdwyhGgKIZGQaOikE9s4ghJVs=;
        b=SQTGcZzG43x4YDdPN887wbqOyg40+mKKivpn6C/uwJ64BPQC2cRSDqNbYUlY6epD2g
         TWxln2qf9fZaB/mFppdNY6RWTdfuJxlprPDMgvBc0iF0FcKA5pGkO8DUXMK2Kz30/LaA
         U6YVMPGRmzsLivRYDRvT37NK/fOIUvYMbRxL3fg1tBYlkNrJXNu/dbdASNugyv0IchSq
         hnTLN2HDhtDu4C56gdgG8WWR5hPu4Ul0Z9pElb9I9KrbBJJvSQhlOjusgWJvJG63eQTI
         N8ytQfgOkxG1l8aeYiFLQa1zj7aViaHO6VAEthOiylWKz/iPQaGrMvoY0V5DJzcgP11G
         BiGw==
X-Gm-Message-State: AOAM533eW+lByl6VjKytSi+9ChBFcIs/9oi+SSofnkeTJjF9hU7y+yrQ
        YeziwSbc7KdHgd+nKetohE4LrMkNSgsTxsOMqWQ=
X-Google-Smtp-Source: ABdhPJxb05evr8qt4Cu8mPoJxhFYB9nb85mmZkB7qZXZ5HzFvn76wWl2XI6LqFVhnS6XfBCodc72qOGdx7rQ3nhvxH4=
X-Received: by 2002:a05:6808:13c7:: with SMTP id d7mr4605778oiw.138.1628620089757;
 Tue, 10 Aug 2021 11:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210809105209.12705-1-cgzones@googlemail.com>
In-Reply-To: <20210809105209.12705-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Aug 2021 14:27:58 -0400
Message-ID: <CAP+JOzTn_4eD5AxOg0W=Gm_K906k3zNSSQLNiKCnGDq=6zbKFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] libselinux: replace strerror by %m
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 9, 2021 at 6:54 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The standard function `strerror(3)` is not thread safe.  This does not
> only affect the concurrent usage of libselinux itself but also with
> other `strerror(3)` linked libraries.
> Use the thread safe GNU extension format specifier `%m`[1].
>
> libselinux already uses the GNU extension format specifier `%ms`.
>
> [1]: https://www.gnu.org/software/libc/manual/html_node/Other-Output-Conv=
ersions.html
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/audit2why.c              | 11 ++--
>  libselinux/src/avc.c                    |  9 ++--
>  libselinux/src/avc_internal.c           |  4 +-
>  libselinux/src/label_backends_android.c | 12 +++--
>  libselinux/src/label_file.h             | 12 +++--
>  libselinux/src/load_policy.c            | 20 ++++----
>  libselinux/src/matchpathcon.c           |  8 +--
>  libselinux/src/selinux_restorecon.c     | 68 +++++++++++++------------
>  8 files changed, 79 insertions(+), 65 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 029f874f..ca38e13c 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -204,8 +204,8 @@ static int __policy_init(const char *init_path)
>                 fp =3D fopen(path, "re");
>                 if (!fp) {
>                         snprintf(errormsg, sizeof(errormsg),
> -                                "unable to open %s:  %s\n",
> -                                path, strerror(errno));
> +                                "unable to open %s:  %m\n",
> +                                path);
>                         PyErr_SetString( PyExc_ValueError, errormsg);
>                         return 1;
>                 }
> @@ -221,9 +221,8 @@ static int __policy_init(const char *init_path)
>                 fp =3D fopen(curpolicy, "re");
>                 if (!fp) {
>                         snprintf(errormsg, sizeof(errormsg),
> -                                "unable to open %s:  %s\n",
> -                                curpolicy,
> -                                strerror(errno));
> +                                "unable to open %s:  %m\n",
> +                                curpolicy);
>                         PyErr_SetString( PyExc_ValueError, errormsg);
>                         return 1;
>                 }
> @@ -242,7 +241,7 @@ static int __policy_init(const char *init_path)
>         if (sepol_policy_file_create(&pf) ||
>             sepol_policydb_create(&avc->policydb)) {
>                 snprintf(errormsg, sizeof(errormsg),
> -                        "policydb_init failed: %s\n", strerror(errno));
> +                        "policydb_init failed: %m\n");
>                 PyErr_SetString( PyExc_RuntimeError, errormsg);
>                 fclose(fp);
>                 return 1;
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index daaedbc6..7493e4b2 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -206,9 +206,8 @@ static int avc_init_internal(const char *prefix,
>                 rc =3D security_getenforce();
>                 if (rc < 0) {
>                         avc_log(SELINUX_ERROR,
> -                               "%s:  could not determine enforcing mode:=
 %s\n",
> -                               avc_prefix,
> -                               strerror(errno));
> +                               "%s:  could not determine enforcing mode:=
 %m\n",
> +                               avc_prefix);
>                         goto out;
>                 }
>                 avc_enforcing =3D rc;
> @@ -217,8 +216,8 @@ static int avc_init_internal(const char *prefix,
>         rc =3D selinux_status_open(0);
>         if (rc < 0) {
>                 avc_log(SELINUX_ERROR,
> -                       "%s: could not open selinux status page: %d (%s)\=
n",
> -                       avc_prefix, errno, strerror(errno));
> +                       "%s: could not open selinux status page: %d (%m)\=
n",
> +                       avc_prefix, errno);
>                 goto out;
>         }
>         avc_running =3D 1;
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.=
c
> index 53a99a1f..71a1357b 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -308,8 +308,8 @@ int avc_netlink_acquire_fd(void)
>                 rc =3D avc_netlink_open(0);
>                 if (rc < 0) {
>                         avc_log(SELINUX_ERROR,
> -                               "%s: could not open netlink socket: %d (%=
s)\n",
> -                               avc_prefix, errno, strerror(errno));
> +                               "%s: could not open netlink socket: %d (%=
m)\n",
> +                               avc_prefix, errno);
>                         return rc;
>                 }
>         }
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/lab=
el_backends_android.c
> index cb8aae26..66d4df2d 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -94,9 +94,15 @@ static int process_line(struct selabel_handle *rec,
>         items =3D read_spec_entries(line_buf, &errbuf, 2, &prop, &context=
);
>         if (items < 0) {
>                 items =3D errno;
> -               selinux_log(SELINUX_ERROR,
> -                       "%s:  line %u error due to: %s\n", path,
> -                       lineno, errbuf ?: strerror(errno));
> +               if (errbuf) {
> +                       selinux_log(SELINUX_ERROR,
> +                                   "%s:  line %u error due to: %s\n", pa=
th,
> +                                   lineno, errbuf);
> +               } else {
> +                       selinux_log(SELINUX_ERROR,
> +                                   "%s:  line %u error due to: %m\n", pa=
th,
> +                                   lineno);
> +               }
>                 errno =3D items;
>                 return -1;
>         }
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 9f633701..343ffc70 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -445,9 +445,15 @@ static inline int process_line(struct selabel_handle=
 *rec,
>         items =3D read_spec_entries(line_buf, &errbuf, 3, &regex, &type, =
&context);
>         if (items < 0) {
>                 rc =3D errno;
> -               selinux_log(SELINUX_ERROR,
> -                       "%s:  line %u error due to: %s\n", path,
> -                       lineno, errbuf ?: strerror(errno));
> +               if (errbuf) {
> +                       selinux_log(SELINUX_ERROR,
> +                                   "%s:  line %u error due to: %s\n", pa=
th,
> +                                   lineno, errbuf);
> +               } else {
> +                       selinux_log(SELINUX_ERROR,
> +                                   "%s:  line %u error due to: %m\n", pa=
th,
> +                                   lineno);
> +               }
>                 errno =3D rc;
>                 return -1;
>         }
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 5857b821..d8c715ed 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -137,15 +137,15 @@ int selinux_mkload_policy(int preservebools __attri=
bute__((unused)))
>         }
>         if (fd < 0) {
>                 fprintf(stderr,
> -                       "SELinux:  Could not open policy file <=3D %s.%d:=
  %s\n",
> -                       selinux_binary_policy_path(), maxvers, strerror(e=
rrno));
> +                       "SELinux:  Could not open policy file <=3D %s.%d:=
  %m\n",
> +                       selinux_binary_policy_path(), maxvers);
>                 goto dlclose;
>         }
>
>         if (fstat(fd, &sb) < 0) {
>                 fprintf(stderr,
> -                       "SELinux:  Could not stat policy file %s:  %s\n",
> -                       path, strerror(errno));
> +                       "SELinux:  Could not stat policy file %s:  %m\n",
> +                       path);
>                 goto close;
>         }
>
> @@ -153,8 +153,8 @@ int selinux_mkload_policy(int preservebools __attribu=
te__((unused)))
>         data =3D map =3D mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
>         if (map =3D=3D MAP_FAILED) {
>                 fprintf(stderr,
> -                       "SELinux:  Could not map policy file %s:  %s\n",
> -                       path, strerror(errno));
> +                       "SELinux:  Could not map policy file %s:  %m\n",
> +                       path);
>                 goto close;
>         }
>
> @@ -193,8 +193,8 @@ int selinux_mkload_policy(int preservebools __attribu=
te__((unused)))
>
>         if (rc)
>                 fprintf(stderr,
> -                       "SELinux:  Could not load policy file %s:  %s\n",
> -                       path, strerror(errno));
> +                       "SELinux:  Could not load policy file %s:  %m\n",
> +                       path);
>
>        unmap:
>         if (data !=3D map)
> @@ -306,7 +306,7 @@ int selinux_init_load_policy(int *enforce)
>                         *enforce =3D 0;
>                 } else {
>                         /* Only emit this error if selinux was not disabl=
ed */
> -                       fprintf(stderr, "Mount failed for selinuxfs on %s=
:  %s\n", SELINUXMNT, strerror(errno));
> +                       fprintf(stderr, "Mount failed for selinuxfs on %s=
:  %m\n", SELINUXMNT);
>                 }
>
>                 if (rc =3D=3D 0)
> @@ -352,7 +352,7 @@ int selinux_init_load_policy(int *enforce)
>         if (orig_enforce !=3D *enforce) {
>                 rc =3D security_setenforce(*enforce);
>                 if (rc < 0) {
> -                       fprintf(stderr, "SELinux:  Unable to switch to %s=
 mode:  %s\n", (*enforce ? "enforcing" : "permissive"), strerror(errno));
> +                       fprintf(stderr, "SELinux:  Unable to switch to %s=
 mode:  %m\n", (*enforce ? "enforcing" : "permissive"));
>                         if (*enforce)
>                                 goto noload;
>                 }
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 075a3fb3..1e7f8890 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -393,8 +393,8 @@ int realpath_not_final(const char *name, char *resolv=
ed_path)
>
>         tmp_path =3D strdup(name);
>         if (!tmp_path) {
> -               myprintf("symlink_realpath(%s) strdup() failed: %s\n",
> -                       name, strerror(errno));
> +               myprintf("symlink_realpath(%s) strdup() failed: %m\n",
> +                       name);
>                 rc =3D -1;
>                 goto out;
>         }
> @@ -414,8 +414,8 @@ int realpath_not_final(const char *name, char *resolv=
ed_path)
>         }
>
>         if (!p) {
> -               myprintf("symlink_realpath(%s) realpath() failed: %s\n",
> -                       name, strerror(errno));
> +               myprintf("symlink_realpath(%s) realpath() failed: %m\n",
> +                       name);
>                 rc =3D -1;
>                 goto out;
>         }
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 999aa924..04d95650 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -333,8 +333,7 @@ static int add_xattr_entry(const char *directory, boo=
l delete_nonmatch,
>                 rc =3D removexattr(directory, RESTORECON_PARTIAL_MATCH_DI=
GEST);
>                 if (rc) {
>                         selinux_log(SELINUX_ERROR,
> -                                 "Error: %s removing xattr \"%s\" from: =
%s\n",
> -                                 strerror(errno),
> +                                 "Error: %m removing xattr \"%s\" from: =
%s\n",
>                                   RESTORECON_PARTIAL_MATCH_DIGEST, direct=
ory);
>                         digest_result =3D ERROR;
>                 }
> @@ -734,8 +733,8 @@ out1:
>         return rc;
>  err:
>         selinux_log(SELINUX_ERROR,
> -                   "Could not set context for %s:  %s\n",
> -                   pathname, strerror(errno));
> +                   "Could not set context for %s:  %m\n",
> +                   pathname);
>         rc =3D -1;
>         goto out1;
>  }
> @@ -857,6 +856,7 @@ int selinux_restorecon(const char *pathname_orig,
>         dev_t dev_num =3D 0;
>         struct dir_hash_node *current =3D NULL;
>         struct dir_hash_node *head =3D NULL;
> +       int errno_tmp;
>
>         if (flags.verbose && flags.progress)
>                 flags.verbose =3D false;
> @@ -929,8 +929,8 @@ int selinux_restorecon(const char *pathname_orig,
>                         return 0;
>                 } else {
>                         selinux_log(SELINUX_ERROR,
> -                                   "lstat(%s) failed: %s\n",
> -                                   pathname, strerror(errno));
> +                                   "lstat(%s) failed: %m\n",
> +                                   pathname);
>                         error =3D -1;
>                         goto cleanup;
>                 }
> @@ -954,8 +954,8 @@ int selinux_restorecon(const char *pathname_orig,
>         memset(&sfsb, 0, sizeof sfsb);
>         if (!S_ISLNK(sb.st_mode) && statfs(pathname, &sfsb) < 0) {
>                 selinux_log(SELINUX_ERROR,
> -                           "statfs(%s) failed: %s\n",
> -                           pathname, strerror(errno));
> +                           "statfs(%s) failed: %m\n",
> +                           pathname);
>                 error =3D -1;
>                 goto cleanup;
>         }
> @@ -1006,24 +1006,30 @@ int selinux_restorecon(const char *pathname_orig,
>                 case FTS_DP:
>                         continue;
>                 case FTS_DNR:
> +                       errno_tmp =3D errno;
> +                       errno =3D ftsent->fts_errno;
>                         selinux_log(SELINUX_ERROR,
> -                                   "Could not read %s: %s.\n",
> -                                   ftsent->fts_path,
> -                                                 strerror(ftsent->fts_er=
rno));
> +                                   "Could not read %s: %m.\n",
> +                                   ftsent->fts_path);
> +                       errno =3D errno_tmp;
>                         fts_set(fts, ftsent, FTS_SKIP);
>                         continue;
>                 case FTS_NS:
> +                       errno_tmp =3D errno;
> +                       errno =3D ftsent->fts_errno;
>                         selinux_log(SELINUX_ERROR,
> -                                   "Could not stat %s: %s.\n",
> -                                   ftsent->fts_path,
> -                                                 strerror(ftsent->fts_er=
rno));
> +                                   "Could not stat %s: %m.\n",
> +                                   ftsent->fts_path);
> +                       errno =3D errno_tmp;
>                         fts_set(fts, ftsent, FTS_SKIP);
>                         continue;
>                 case FTS_ERR:
> +                       errno_tmp =3D errno;
> +                       errno =3D ftsent->fts_errno;
>                         selinux_log(SELINUX_ERROR,
> -                                   "Error on %s: %s.\n",
> -                                   ftsent->fts_path,
> -                                                 strerror(ftsent->fts_er=
rno));
> +                                   "Error on %s: %m.\n",
> +                                   ftsent->fts_path);
> +                       errno =3D errno_tmp;
>                         fts_set(fts, ftsent, FTS_SKIP);
>                         continue;
>                 case FTS_D:
> @@ -1087,9 +1093,8 @@ int selinux_restorecon(const char *pathname_orig,
>                             current->digest,
>                             SHA1_HASH_SIZE, 0) < 0) {
>                                 selinux_log(SELINUX_ERROR,
> -                                           "setxattr failed: %s: %s\n",
> -                                           current->path,
> -                                           strerror(errno));
> +                                           "setxattr failed: %s: %m\n",
> +                                           current->path);
>                         }
>                         current =3D current->next;
>                 }
> @@ -1131,16 +1136,16 @@ oom:
>  realpatherr:
>         sverrno =3D errno;
>         selinux_log(SELINUX_ERROR,
> -                   "SELinux: Could not get canonical path for %s restore=
con: %s.\n",
> -                   pathname_orig, strerror(errno));
> +                   "SELinux: Could not get canonical path for %s restore=
con: %m.\n",
> +                   pathname_orig);
>         errno =3D sverrno;
>         error =3D -1;
>         goto cleanup;
>
>  fts_err:
>         selinux_log(SELINUX_ERROR,
> -                   "fts error while labeling %s: %s\n",
> -                   paths[0], strerror(errno));
> +                   "fts error while labeling %s: %m\n",
> +                   paths[0]);
>         error =3D -1;
>         goto cleanup;
>  }
> @@ -1181,8 +1186,7 @@ struct selabel_handle *selinux_restorecon_default_h=
andle(void)
>
>         if (!sehandle) {
>                 selinux_log(SELINUX_ERROR,
> -                           "Error obtaining file context handle: %s\n",
> -                                                   strerror(errno));
> +                           "Error obtaining file context handle: %m\n");
>                 return NULL;
>         }
>
> @@ -1202,8 +1206,8 @@ void selinux_restorecon_set_exclude_list(const char=
 **exclude_list)
>         for (i =3D 0; exclude_list[i]; i++) {
>                 if (lstat(exclude_list[i], &sb) < 0 && errno !=3D EACCES)=
 {
>                         selinux_log(SELINUX_ERROR,
> -                                   "lstat error on exclude path \"%s\", =
%s - ignoring.\n",
> -                                   exclude_list[i], strerror(errno));
> +                                   "lstat error on exclude path \"%s\", =
%m - ignoring.\n",
> +                                   exclude_list[i]);
>                         break;
>                 }
>                 if (add_exclude(exclude_list[i], CALLER_EXCLUDED) &&
> @@ -1269,8 +1273,8 @@ int selinux_restorecon_xattr(const char *pathname, =
unsigned int xattr_flags,
>                         return 0;
>
>                 selinux_log(SELINUX_ERROR,
> -                           "lstat(%s) failed: %s\n",
> -                           pathname, strerror(errno));
> +                           "lstat(%s) failed: %m\n",
> +                           pathname);
>                 return -1;
>         }
>
> @@ -1300,8 +1304,8 @@ int selinux_restorecon_xattr(const char *pathname, =
unsigned int xattr_flags,
>         fts =3D fts_open(paths, fts_flags, NULL);
>         if (!fts) {
>                 selinux_log(SELINUX_ERROR,
> -                           "fts error on %s: %s\n",
> -                           paths[0], strerror(errno));
> +                           "fts error on %s: %m\n",
> +                           paths[0]);
>                 return -1;
>         }
>
> --
> 2.32.0
>
