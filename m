Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983343E92AB
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805399; cv=pass; b=Ze4zIJYcWqqmAQRLKCSfiAGeIPMX6UP4HvViIuMnUpHYCoyCXgh3xp/FRFr68zrrz3RSpa70r7Oy3u8IiqY9rZ8upB2bVXkwFqr5ANdC2qziTBKtJG/zS+0FfUtnykw77yaMCES3Yfms/BRuFJLz7Yq/Ejw6P0NfeeerJ0QdY1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805399; c=relaxed/simple;
	bh=yqFKP6OEJtC2hjkarDPgQ8KRWGAgD3dtMcTbTWiHs38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3ANoZ0pw67BW6PM+cDvigfDFQnmpxexNOKVRYc/UtsRJgFmQF8g3vJZJ03grV0o3luc3FEPvW8nV65UuQLtMNbjoPRdscgSgSmqLVpl/waPU7Jo4JG9/6rLu8M1Iw6TAzS1R1E7LydHCuKFAr3i1e9hizVkGLcdcGzmrBPg2JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqm7ndGV; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqm7ndGV"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3680540a6efso5992005a91.2
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 07:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805398; cv=none;
        d=google.com; s=arc-20240605;
        b=TtyeI4T0LwuHM5zVgcS74M1FQ6m3zGxl7LRBaNRztEvpysMQ8nPYTmac+FyksGGQRO
         CisDN6ZlAwjrtrH9UJ5J5Xt1OqrNxXPPziXQgVAmLs9KHG5YKpgBQZPyR7hoDu4yGhUK
         By0xPnHHrnqrflBEbA/E+wmIsyVWKTFFftaUA4NIURmOzx0zRqt2IeP2mijLZxiOFFje
         CFG57eMX4Q/kWMuJQAmjs/SQitNgwUaJNNyrNrpMAR41c8Iuq1p2bLoR9RTRgs5Lau/g
         BrEAI8gIhWqX7ukxoQMOvNJWsnrBPWnxYytIEqZAj9mq+2uIwjd959ObF0p2cQCXmNh0
         MB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=poVC9PtHCWDB+qzTAu1BZpx/ofC2oDa7j7pRxERRK+M=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=Ig6geGsgZaJJYRy27Dlb+33l+C1Glviayw0V6YRibBdlmCyqtQKINYwgNZ/HxGEqgB
         SbUyBo7Ak9RlQd556GfkeQaSekfa4awkpASVLZcJ6Z6hhwA9KSCNTYKQsA1/g8bHf0Pb
         3Lqw7yF9YDjqhKQofD8j1IQDhyYR1Kr4kF4omssh5CyKjbMF8Ofx6Egoyki4RGm7c+LT
         dyFAHnI5wjOm++M2WK/p42d93KIFkjFoHdAyTXeStluwuE/ull30mMjEFW5MXQlARz14
         A/HctiRvprt5o+dWyYKk9KRtIdXRxI6sBb+I4BKTevzfRIBiNO8xOvNEMsf9XcK9d2VI
         fo2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805398; x=1780410198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poVC9PtHCWDB+qzTAu1BZpx/ofC2oDa7j7pRxERRK+M=;
        b=oqm7ndGVUBDZJOBcL69/wFkEl0CF3H96Yh3B2qbMZhdiIRTLbpRKo19Zew2Gvn7RgG
         8DPi82Rs+kL9gZr6LMUNPcdYdd5PJy8GAZStQIQtk4vk8zx3UECFnJjRyGRGkN460OTZ
         E+GEzCB8NbOStcZBRuw2vTPD87XzRsjMo5j6vkUv2pFz6ZnB358JjkFgafDmSDBZfYvB
         +1s1tXjGmi7mE/774EHmzj3GVBbT+ZOR5ZD9wZwN5XYoWB03chuKENhLyzSe+4IEgCh6
         6tVZ69pkiF839rHDbP/ke8IXfHVbmOYryWDUtY1uLoABCFA9rytGQZr0hGwqbB9L96nY
         PmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805398; x=1780410198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=poVC9PtHCWDB+qzTAu1BZpx/ofC2oDa7j7pRxERRK+M=;
        b=DD0m2IG9frz3f5GJA/5OzGwwVy3apjwX/AY+Qi3uHatVJtm4RM0WZN4YvxNsaaQCg1
         FTE+q857c8XxXw8cCiJSLHwzN+Yq5ALyA8n6+/Qc6JsnclnQAlNlU7s4R0QZuuqf7PRz
         KW6agjV4UopAaODWkK/4E/WJeGjnyjXcEOWnVXc23dQmsOy9FiNS5zAxAAgTi8pWqF5c
         EElSjDRBlMIB8m6LX8iCj+kgG9a2MXWvduQnaC7t+XLv5/Y1sD+z7Umh+AxRaQKhTo5t
         fiIQKiwZu8ubei4k13zGG7eo6F+Pbmp3YVg39kL6JI2ct2C7bWkcsR1ZbIGpFot7u+LN
         eufQ==
X-Gm-Message-State: AOJu0YypWSaFhnB01tN5YGkTRRZvl5G/vc9+UZGQtQdo83ILI/TGlMHt
	K8soyUb7cPIdo9gB0NGbxPUCmI5TO4ecviheFhDRCBY36ke10VVdGpMFKoDp/odAm/4qLCqcA0D
	zUwrrAofGqUwQAgGq0FiigqqQSs2VaBfsVw==
X-Gm-Gg: Acq92OEoY42p4Pp3SpYsRQdA9pMiAg9UB4ZiAFMoept6oOaVqQmtfYIB4+gIYTWJyPL
	rhhYgWQj7+N6XAWJTnik+7D9+zxSSK6FHuxAcBQ2Q6cggytcZDSwj8pgz9nw4H7uPSEInaj1nOC
	SbETAzG7bPRB4/W48+AXokhQFbA2MusHQXL52ljuBiK9Ch8VMhy5JY3fIXT5tAcrdEvfHSshzXP
	amhrIimLiUte+OdPRSbcGCZf1bMvc/RuNJ1K4Y37gojnWhBXeGlnMDehOrGPEenIjNrjbVVf1Lw
	YmOKzNBkyTQlup9OAg==
X-Received: by 2002:a17:90b:2d44:b0:368:ea0c:1b6f with SMTP id
 98e67ed59e1d1-36a6741d7afmr17149570a91.5.1779805397893; Tue, 26 May 2026
 07:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521155444.27110-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260521155444.27110-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 10:23:06 -0400
X-Gm-Features: AVHnY4I4e3nCWtCgl7DwhMVWAFTL3E7OtXcdy3mWACjaQo13FsE4WJDL0od-9Hk
Message-ID: <CAEjxPJ77t6o=o44Grm3CcEqdZ1Rn0YjCGaTfW=Vs5f4R=u0gdQ@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: drop -k/--kill support
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Drop the -k/--kill support; it is fundamentally racy, redundant
> with killall -Z, and seemingly unused by sandbox itself.
> Provide an error message to the user telling them how to achieve
> the same effect via killall.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  sandbox/seunshare.c | 93 +--------------------------------------------
>  1 file changed, 1 insertion(+), 92 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 1d13d261..a4454027 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -710,97 +710,6 @@ good:
>         return tmpdir;
>  }
>
> -#define PROC_BASE "/proc"
> -
> -static int
> -killall (const char *execcon)
> -{
> -       DIR *dir;
> -       char *scon;
> -       struct dirent *de;
> -       pid_t *pid_table, pid, self;
> -       unsigned int i;
> -       unsigned int pids, max_pids;
> -       int running =3D 0;
> -       self =3D getpid();
> -       if (!(dir =3D opendir(PROC_BASE))) {
> -               return -1;
> -       }
> -       max_pids =3D 256;
> -       pid_table =3D malloc(max_pids * sizeof (pid_t));
> -       if (!pid_table) {
> -               (void)closedir(dir);
> -               return -1;
> -       }
> -       pids =3D 0;
> -       context_t con =3D context_new(execcon);
> -       if (!con) {
> -               free(pid_table);
> -               (void)closedir(dir);
> -               return -1;
> -       }
> -       const char *const mcs =3D context_range_get(con);
> -       const char *const type =3D context_type_get(con);
> -       if (!mcs || !type) {
> -               context_free(con);
> -               free(pid_table);
> -               (void)closedir(dir);
> -               return -1;
> -       }
> -       if (verbose)
> -               printf("mcs=3D%s type=3D%s\n", mcs, type);
> -       while ((de =3D readdir (dir)) !=3D NULL) {
> -               if (!(pid =3D (pid_t)atoi(de->d_name)) || pid =3D=3D self=
)
> -                       continue;
> -
> -               if (pids =3D=3D max_pids) {
> -                       max_pids *=3D 2;
> -                       if (max_pids <=3D pids)
> -                       {
> -                               free(pid_table);
> -                               (void)closedir(dir);
> -                               return -1;
> -                       }
> -                       pid_t *new_pid_table =3D reallocarray(pid_table, =
max_pids, sizeof(pid_t));
> -                       if (!new_pid_table) {
> -                               free(pid_table);
> -                               (void)closedir(dir);
> -                               return -1;
> -                       }
> -                       pid_table =3D new_pid_table;
> -               }
> -               pid_table[pids++] =3D pid;
> -       }
> -
> -       (void)closedir(dir);
> -
> -       for (i =3D 0; i < pids; i++) {
> -               pid_t id =3D pid_table[i];
> -
> -               if (getpidcon(id, &scon) =3D=3D 0) {
> -
> -                       context_t pidcon =3D context_new(scon);
> -                       if (pidcon) {
> -                               const char *const pmcs =3D context_range_=
get(pidcon);
> -                               const char *const ptype =3D context_type_=
get(pidcon);
> -
> -                               /* Attempt to kill remaining processes */
> -                               if (pmcs && ptype && !strcmp(pmcs, mcs) &=
&
> -                                       !strcmp(ptype, type))
> -                                       kill(id, SIGKILL);
> -
> -                               context_free(pidcon);
> -                       }
> -                       freecon(scon);
> -               }
> -               running++;
> -       }
> -
> -       context_free(con);
> -       free(pid_table);
> -       return running;
> -}
> -
>  int main(int argc, char **argv) {
>         int status =3D -1;
>         const char *execcon =3D NULL;
> @@ -1253,7 +1162,7 @@ childerr:
>         kill(-child,SIGTERM);
>
>         if (execcon && kill_all)
> -               killall(execcon);
> +               fprintf(stderr, "-k/--kill no longer supported; run killa=
ll -Z %s\n", execcon);
>
>         if (tmpdir_r) cleanup_tmpdir(tmpdir_r, tmpdir_s, pwd, 1);
>
> --
> 2.54.0
>
