Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72204ADD89
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007775; cv=pass; b=VDH/CuZBCNVU89a2h+04kxuI9g1pZwqvxq2BmUkTFql/2sji7ns7rQaQdWvL0Z2JU7O/Vqb203Og4OzG8pqqTK+STf2jxEGSKVvBgbC3IVGqdcvxWxqZoMd5QMgcX6jk6axKOBex9zzWPYJGYu3kVh1tHqiUdbBEy0uC+piKa40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007775; c=relaxed/simple;
	bh=a0jBK9EAHKJIeqLaNprBOTKTaQz3acrU5TQzqN1CUYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfYTkuPWX5g8RXdDRYKBk4p+dJBzwcM/+qJxCPiT8sXKhHHf5wHZrEwKHLCefuvct2EgpSglM9gt0trZfXCLwTd6WgLRlzy7nIX7pN5Gu+CkKxJoDffdN32xmvx/zQHIZF4ejohp8ba9x4TNPnM4iK4LjLg28qlEQUJgItZ0rjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMhe1KCG; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMhe1KCG"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8027e876fcso1022204a12.1
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 12:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778007770; cv=none;
        d=google.com; s=arc-20240605;
        b=Ku+2EDBm46NzxNOOpDpbQOepHXDbHFrexwzAGA5rbPHU4KuXYAiXVRlJ50PXexnPYi
         3KfrfLm0btrursqZOp5GfuISRe70RNY4EUzCWq6Fy5almdwulX8OksEylSDMZlsGGwuN
         8qzRA1z6p2vU5HeHtVUVsxDIbI7P0YXqMMs0SJIqwYCpXkXbZbExRnOxu+Z2Jo3LL8zD
         R/naPnDC7JhaHkaPLWiEEcLyjfzRZtKddlc33J/lVQo53o2sJMOJoU0JTWrlcSfL6N50
         kVQawT51M3mZA+MPxkwZAb/M1NTIcWmJE8igF2COc25bxtao+pczzvwWrmAZBfxKXLgF
         YHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sCjA9wAVuAFyKqvWN+TdtFqX30vPraADlFjqgKN0cfA=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=NizFD8xAMBX35nYNVWQenwg2oKckB9rSKqTDsF0yWIzjH7+L3Qxh7BUX3+IAMEpWpz
         eQzdSgZZKXx+FmwJiYjboA2w+fspINORe9dR6WUo5B8dUfHQb5cTu/XbQiodbN8/0z5O
         C5sSzKlHFKC/X9Cs5avrVQMlJDyis1IdKlbZLW2FsNvR98owdjxEhDNE+NjvD7g1yC+I
         pq03EJNor6pB/gY1ckUdFCE40du5CjHlqYweYUQNvLwAqD0kC4HHUDqHPY1hrnhU2l9V
         MyDgu771PD7CkzVlt/F6/BglP8c/fcJJeFqNjBVWZqUgYHpKB5iiUuGM49FKaStg9QIo
         gikg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778007770; x=1778612570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCjA9wAVuAFyKqvWN+TdtFqX30vPraADlFjqgKN0cfA=;
        b=NMhe1KCGafS93uE11UWPW1ny4gD89V+64cVGIS9j/mnbQlav8r628CKHRuSojKxRF2
         hpTJqaT0Wrny3NhI4fUbs5XhFYqaQB9wI9t8C8ssnIYG9yUK3lbrdZ6tIMrf+d3V6yGo
         krlAPbPNPilP3amm7XEUkqvcwgoenMwa7NScdF7+jswXhEwx8Mybup1jpNHNCNPZS8r4
         OcaxgsKj+w22Lu/m8pZxcO1YsH3pX7GxDHH/YEdargB2XB7BphAEjMdwXRishAt7Z7oX
         4orKrlYfiWBDqeyVzqrqyEzRf/gLwFmI2LrZJzTU3L6x1T4eF229/tyQFEH1Lk3G2869
         UbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778007770; x=1778612570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCjA9wAVuAFyKqvWN+TdtFqX30vPraADlFjqgKN0cfA=;
        b=GUvdTok8Uv1vE+s4FDJlhw0C3FZ9mpCI7/dShUZsgdMIQhy8uMAuyMbl99HN9AQTog
         I+4OyKBkFTWgEd6onTBNmOFGYaBQpFMwIp0Q3ujbNvnzLjlSB+yMwaEWqpfRbL40d7vM
         MwQKpC9oQxtwstXRQsFtS/Rd846iumm4gbvcD0jcpV65Te+zIHM2eMdxYIj6kpBAkmrR
         yCEI6ojVkCmhSTd3d5GOMTq+kjCEbqNpzQDqpBP6cEX0I0RqyVqjGQzc+9GydGkTYhsF
         7zMAvfXsQnkZ+J53QFo0RM+XjvPGqaPq/k3cS7HxG0i1sLyMAl2zUeVmNhMxySnfT8PE
         oNcw==
X-Gm-Message-State: AOJu0YxZkRcWF//Zfx0Q39OCr6NewDWCVOG6s2oPpzYV6EJTH0R5kc9H
	aUP4cniMRvpJviVKuvuCh3RWWxBb3GCP/GIW2Dm1LQjanCRjg+ZSUBEv/pYC+T9buoylfFgrSWe
	686OZwWQF45g588XYyra3ELLHZDQc/xVjuQ==
X-Gm-Gg: AeBDietgkx0MQV6gFboHJ36Tc7ahucGd/h4CwD59QyJw9VJaCTptGZdRpSPKP464cPs
	As2t3w+RGob6bcHEmq8Yo6esqvnZ2JJxjxswKJdK0h0jWnlMa/qopVoMsY9oOi1bZ0q0cDwtrkn
	sNCJWS077OgycY2rvHgUe5AdLxpsSc+C09ow+Q6NropqY8uRtZG/kptmtIgr9gtdqrX3RcmSUjC
	KRlJMJVs35hJL524cl2z9Yq8ilR/lLuD5kzLRCi3YBq3nqKc0Ueb2JSdRqi79KsYOM8eoWs/Irq
	ky2+XbTIdUXDUsP4aA==
X-Received: by 2002:a17:903:2f4e:b0:2ba:3b93:aa4d with SMTP id
 d9443c01a7336-2ba793b7c1emr2100265ad.25.1778007770348; Tue, 05 May 2026
 12:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505185017.18428-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260505185017.18428-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 5 May 2026 15:02:39 -0400
X-Gm-Features: AVHnY4L-ji0YATYtd0BxX_x0mXI2_vtAzFOMLQucn65pVR9IugxT4EYcguE1N2I
Message-ID: <CAEjxPJ6f8Rckr3Gz_t5VZCwYSXq9afmNU0=nVWxb=bjz7+ZmMA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon: revisit pinning files to avoid
 TOCTOU issues
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 2:50=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> selinux_restorecon(3) is currently susceptible to TOCTOU issues since
> it looks up pathnames multiple times when getting and setting the
> SELinux contexts. Commit 7e979b56fd2cee ("libselinux: restorecon: pin
> file to avoid TOCTOU issues") tried to fix this problem by opening an
> O_PATH descriptor for each directory/file once and using this
> descriptor for all subsequent operations on the file. However, this
> commit was reverted by commit de285252a1801 ('Revert "libselinux:
> restorecon: pin file to avoid TOCTOU issues"') due to it breaking
> setfiles (and any other user of selinux_restorecon) when it is run
> from a chroot (or mount namespace) without /proc mounted. The
> dependency on /proc is a side effect of the fact that
> fgetxattr/fsetxattr cannot be used with O_PATH descriptors, so glibc
> internally falls back to trying to call getxattr/setxattr on
> /proc/self/fd/<n> instead, which works iff /proc is mounted. This
> change revives the earlier changes but provides a fallback for the
> case where /proc is not mounted. This change also cover the handling
> of the original pathname passed into selinux_restorecon(3).
>
> NB I also tried using getxattrat/setxattrat(2) but these also seem
> to fail with EBADF on the O_PATH descriptors.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

NB This does seem to have a non-trivial impact on restorecon/setfiles
performance, which could probably be reduced by cutting out the use of
f[gs]etfilecon->f[gs]etxattr() -> EBADF and just directly constructing
the /proc/self/fd/<n> paths and calling getfilecon()/setfilecon() on
those.


> ---
>  libselinux/src/selinux_restorecon.c | 173 ++++++++++++++++++++++++++--
>  1 file changed, 162 insertions(+), 11 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 35dd6441..12199200 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -21,6 +21,7 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/xattr.h>
> +#include <sys/syscall.h>
>  #include <sys/vfs.h>
>  #include <sys/statvfs.h>
>  #include <sys/utsname.h>
> @@ -94,6 +95,45 @@ struct rest_flags {
>         bool count_relabeled;
>  };
>
> +static int have_proc;
> +
> +static int probe_proc(void)
> +{
> +       struct statfs sb;
> +
> +       if (statfs("/proc", &sb) < 0)
> +               return 0;
> +       if (sb.f_type !=3D PROC_SUPER_MAGIC)
> +               return 0;
> +       return 1;
> +}
> +
> +static int fd_path_getfilecon(int fd, const char *pathname, char **con)
> +{
> +       int rc;
> +
> +       if (have_proc) {
> +               rc =3D fgetfilecon_raw(fd, con);
> +               if (rc >=3D 0 || errno !=3D EBADF)
> +                       return rc;
> +       }
> +
> +       return lgetfilecon_raw(pathname, con);
> +}
> +
> +static int fd_path_setfilecon(int fd, const char *pathname, char *con)
> +{
> +       int rc;
> +
> +       if (have_proc) {
> +               rc =3D fsetfilecon_raw(fd, con);
> +               if (rc >=3D 0 || errno !=3D EBADF)
> +                       return rc;
> +       }
> +
> +       return lsetfilecon_raw(pathname, con);
> +}
> +
>  static void restorecon_init(void)
>  {
>         struct selabel_handle *sehandle =3D NULL;
> @@ -106,6 +146,8 @@ static void restorecon_init(void)
>         efile_count =3D 0;
>         if (!ignore_mounts)
>                 efile_count =3D exclude_non_seclabel_mounts();
> +
> +       have_proc =3D probe_proc();
>  }
>
>  static pthread_once_t fc_once =3D PTHREAD_ONCE_INIT;
> @@ -646,8 +688,9 @@ out:
>         return rc;
>  }
>
> -static int restorecon_sb(const char *pathname, const struct stat *sb,
> -                           const struct rest_flags *flags, bool first, b=
ool *updated_out)
> +static int restorecon_sb(int fd, const char *pathname, const struct stat=
 *sb,
> +                        const struct rest_flags *flags, bool first,
> +                        bool *updated_out)
>  {
>         char *newcon =3D NULL;
>         char *curcon =3D NULL;
> @@ -723,7 +766,7 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>                 selinux_log(SELINUX_INFO, "%s matched by %s\n",
>                             pathname, newcon);
>
> -       if (lgetfilecon_raw(pathname, &curcon) < 0) {
> +       if (fd_path_getfilecon(fd, pathname, &curcon) < 0) {
>                 /* Ignore files removed during relabeling if ignore_noent=
 is set */
>                 if (flags->ignore_noent && errno =3D=3D ENOENT)
>                         goto out;
> @@ -765,7 +808,7 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>                 }
>
>                 if (!flags->nochange) {
> -                       if (lsetfilecon(pathname, newcon) < 0) {
> +                       if (fd_path_setfilecon(fd, pathname, newcon) < 0)=
 {
>                                 /* Ignore files removed during relabeling=
 if ignore_noent is set */
>                                 if (flags->ignore_noent && errno =3D=3D E=
NOENT)
>                                         goto out;
> @@ -894,6 +937,87 @@ struct rest_state {
>         pthread_mutex_t mutex;
>  };
>
> +static int open_final(int dfd, const char *name, struct stat *sb)
> +{
> +       int fd;
> +
> +       if (name)
> +               fd =3D openat(dfd, name, O_PATH | O_NOFOLLOW | O_CLOEXEC)=
;
> +       else
> +               fd =3D fcntl(dfd, F_DUPFD_CLOEXEC, 0);
> +       if (fd < 0)
> +               return -1;
> +
> +       if (fstat(fd, sb) < 0) {
> +               close(fd);
> +               return -1;
> +       }
> +
> +       return fd;
> +}
> +
> +static int safe_open(const char *path, struct stat *sb)
> +{
> +       char *copy, *cur, *slash;
> +       int dfd, nfd;
> +
> +       if (!path || path[0] =3D=3D '\0') {
> +               errno =3D ENOENT;
> +               return -1;
> +       }
> +
> +       copy =3D strdup(path);
> +       if (!copy)
> +               return -1;
> +
> +       if (copy[0] =3D=3D '/') {
> +               dfd =3D open("/", O_PATH | O_DIRECTORY | O_CLOEXEC);
> +               cur =3D copy + 1;
> +       } else {
> +               dfd =3D open(".", O_PATH | O_DIRECTORY | O_CLOEXEC);
> +               cur =3D copy;
> +       }
> +       if (dfd < 0) {
> +               free(copy);
> +               return -1;
> +       }
> +
> +       while (*cur =3D=3D '/')
> +               cur++;
> +
> +       while (*cur !=3D '\0') {
> +               slash =3D strchr(cur, '/');
> +               if  (slash) {
> +                       *slash =3D '\0';
> +                       char *next =3D slash + 1;
> +                       while (*next =3D=3D '/')
> +                               next++;
> +                       if (*next !=3D '\0') {
> +                               nfd =3D openat(dfd, cur, O_PATH | O_NOFOL=
LOW |
> +                                       O_DIRECTORY | O_CLOEXEC);
> +                               close(dfd);
> +                               if (nfd < 0) {
> +                                       free(copy);
> +                                       return -1;
> +                               }
> +                               dfd =3D nfd;
> +                               cur =3D next;
> +                               continue;
> +                       }
> +               }
> +
> +               nfd =3D open_final(dfd, cur, sb);
> +               close(dfd);
> +               free(copy);
> +               return nfd;
> +       }
> +
> +       nfd =3D open_final(dfd, NULL, sb);
> +       close(dfd);
> +       free(copy);
> +       return nfd;
> +}
> +
>  static void *selinux_restorecon_thread(void *arg)
>  {
>         struct rest_state *state =3D arg;
> @@ -1010,13 +1134,34 @@ loop_body:
>                                 goto finish;
>                         }
>
> -                       ent_st =3D *ftsent->fts_statp;
> +                       int ent_fd =3D safe_open(ent_path, &ent_st);
> +                       if (ent_fd < 0) {
> +                               fts_set(fts, ftsent, FTS_SKIP);
> +                               if (state->flags.ignore_noent && errno =
=3D=3D ENOENT)
> +                                       continue;
> +                               selinux_log(SELINUX_ERROR, "Could not saf=
ely open %s: %m.\n", ent_path);
> +                               if (state->flags.count_errors)
> +                                       state->skipped_errors++;
> +                               else
> +                                       state->error =3D -1;
> +                               continue;
> +                       }
> +
> +                       if (ent_st.st_ino !=3D ftsent->fts_statp->st_ino =
||
> +                               ent_st.st_dev !=3D ftsent->fts_statp->st_=
dev) {
> +                               selinux_log(SELINUX_WARNING, "Skipping %s=
: changed inodes during relabel.\n", ent_path);
> +                               close(ent_fd);
> +                               fts_set(fts, ftsent, FTS_SKIP);
> +                               continue;
> +                       }
> +
>                         if (state->parallel)
>                                 __pthread_mutex_unlock(&state->mutex);
>
>                         bool updated =3D false;
> -                       error =3D restorecon_sb(ent_path, &ent_st, &state=
->flags,
> -                                             first, &updated);
> +                       error =3D restorecon_sb(ent_fd, ent_path, &ent_st=
,
> +                                             &state->flags, first, &upda=
ted);
> +                       close(ent_fd);
>
>                         if (state->parallel) {
>                                 __pthread_mutex_lock(&state->mutex);
> @@ -1056,6 +1201,7 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>                                      size_t nthreads)
>  {
>         struct rest_state state;
> +       int top_fd;
>
>         state.flags.nochange =3D (restorecon_flags &
>                     SELINUX_RESTORECON_NOCHANGE) ? true : false;
> @@ -1201,14 +1347,15 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
>
>         paths[0] =3D pathname;
>
> -       if (lstat(pathname, &sb) < 0) {
> +       top_fd =3D safe_open(pathname, &sb);
> +       if (top_fd < 0) {
>                 if (state.flags.ignore_noent && errno =3D=3D ENOENT) {
>                         free(pathdnamer);
>                         free(pathname);
>                         return 0;
>                 } else {
>                         selinux_log(SELINUX_ERROR,
> -                                   "lstat(%s) failed: %m\n",
> +                                   "open(%s) failed: %m\n",
>                                     pathname);
>                         error =3D -1;
>                         goto cleanup;
> @@ -1221,27 +1368,31 @@ static int selinux_restorecon_common(const char *=
pathname_orig,
>
>         if (!state.flags.recurse) {
>                 if (check_excluded(pathname)) {
> +                       close(top_fd);
>                         error =3D 0;
>                         goto cleanup;
>                 }
>
>                 bool updated =3D false;
> -               error =3D restorecon_sb(pathname, &sb, &state.flags, true=
, &updated);
> +               error =3D restorecon_sb(top_fd, pathname, &sb, &state.fla=
gs,
> +                                     true, &updated);
>                 if (updated && state.flags.count_relabeled) {
>                         state.relabeled_files++;
>                 }
> +               close(top_fd);
>                 goto cleanup;
>         }
>
>         /* Obtain fs type */
>         memset(&state.sfsb, 0, sizeof(state.sfsb));
> -       if (!S_ISLNK(sb.st_mode) && statfs(pathname, &state.sfsb) < 0) {
> +       if (!S_ISLNK(sb.st_mode) && fstatfs(top_fd, &state.sfsb) < 0) {
>                 selinux_log(SELINUX_ERROR,
>                             "statfs(%s) failed: %m\n",
>                             pathname);
>                 error =3D -1;
>                 goto cleanup;
>         }
> +       close(top_fd);
>
>         /* Skip digest on in-memory filesystems and /sys */
>         if ((uint32_t)state.sfsb.f_type =3D=3D (uint32_t)RAMFS_MAGIC ||
> --
> 2.54.0
>
