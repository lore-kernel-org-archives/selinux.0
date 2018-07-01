Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w61Kq5YU017717
 for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2018 16:52:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID15.oob.disa.mil (Postfix) with SMTP id 41JjGz1KFZz4KVfl
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 20:51:39 +0000 (UTC)
Received: from USFB19PA17.eemsg.mil (unknown [192.168.16.15])
 by USFBF3ID15.oob.disa.mil (Postfix) with ESMTP id 41JjGx6lZmz4KVfg
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 20:51:37 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so8315842oin.10
 for <selinux@tycho.nsa.gov>; Sun, 01 Jul 2018 13:51:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180701145739.23309-1-nicolas.iooss@m4x.org>
References: <20180701145739.23309-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sun, 1 Jul 2018 13:51:35 -0700
Message-ID: <CAFftDdohqWAb7o7aa=eWjN4m9WnJESaxQn56R8StYHEb-3bL5A@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] mcstrans: fix memory leaks reported by
 clang's static analyzer
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I see lots of repeating blocks, would it make more sense to goto an
error label and free them then return -1?

On Sun, Jul 1, 2018 at 7:57 AM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> There are many memory leaks in mcstrans. Clean them up in order to
> reduce the noise in clang's static analyzer report. Some are remaining,
> because they are more complex to fix.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  mcstrans/src/mcstrans.c | 68 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 12 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 00fb80856da7..96bdbdff7d8b 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -708,6 +708,7 @@ append(affix_t **affixes, const char *val) {
>
>  err:
>         log_error("allocation error %s", strerror(errno));
> +       free(affix);
>         return -1;
>  }
>
> @@ -1517,8 +1518,10 @@ trans_context(const security_context_t incon, security_context_t *rcon) {
>                 } else {
>                         trans = compute_trans_from_raw(range, domain);
>                         if (trans)
> -                               if (add_cache(domain, range, trans) < 0)
> +                               if (add_cache(domain, range, trans) < 0) {
> +                                       free(range);
>                                         return -1;
> +                               }
>                 }
>
>                 if (lrange && urange) {
> @@ -1526,12 +1529,15 @@ trans_context(const security_context_t incon, security_context_t *rcon) {
>                         if (! ltrans) {
>                                 ltrans = compute_trans_from_raw(lrange, domain);
>                                 if (ltrans) {
> -                                       if (add_cache(domain, lrange, ltrans) < 0)
> +                                       if (add_cache(domain, lrange, ltrans) < 0) {
> +                                               free(range);
>                                                 return -1;
> +                                       }
>                                 } else {
>                                         ltrans = strdup(lrange);
>                                         if (! ltrans) {
>                                                 log_error("strdup failed %s", strerror(errno));
> +                                               free(range);
>                                                 return -1;
>                                         }
>                                 }
> @@ -1541,25 +1547,36 @@ trans_context(const security_context_t incon, security_context_t *rcon) {
>                         if (! utrans) {
>                                 utrans = compute_trans_from_raw(urange, domain);
>                                 if (utrans) {
> -                                       if (add_cache(domain, urange, utrans) < 0)
> +                                       if (add_cache(domain, urange, utrans) < 0) {
> +                                               free(ltrans);
> +                                               free(range);
>                                                 return -1;
> +                                       }
>                                 } else {
>                                         utrans = strdup(urange);
>                                         if (! utrans) {
>                                                 log_error("strdup failed %s", strerror(errno));
> -                                               return -1;
> -                                       }
> -                               }
> +                                               free(ltrans);
> +                                               free(range);
> +                                               return -1;
> +                                       }
> +                               }
>                         }
>
>                         if (strcmp(ltrans, utrans) == 0) {
>                                 if (asprintf(&trans, "%s", ltrans) < 0) {
>                                         log_error("asprintf failed %s", strerror(errno));
> +                                       free(utrans);
> +                                       free(ltrans);
> +                                       free(range);
>                                         return -1;
>                                 }
>                         } else {
>                                 if (asprintf(&trans, "%s-%s", ltrans, utrans) < 0) {
>                                         log_error("asprintf failed %s", strerror(errno));
> +                                       free(utrans);
> +                                       free(ltrans);
> +                                       free(range);
>                                         return -1;
>                                 }
>                         }
> @@ -1629,13 +1646,17 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
>                                 if (!canonical) {
>                                         canonical = compute_trans_from_raw(raw, domain);
>                                         if (canonical && strcmp(canonical, range))
> -                                               if (add_cache(domain, raw, canonical) < 0)
> +                                               if (add_cache(domain, raw, canonical) < 0) {
> +                                                       free(range);
>                                                         return -1;
> +                                               }
>                                 }
>                                 if (canonical)
>                                         free(canonical);
> -                               if (add_cache(domain, raw, range) < 0)
> +                               if (add_cache(domain, raw, range) < 0) {
> +                                       free(range);
>                                         return -1;
> +                               }
>                         } else {
>                                 log_debug("untrans_context unable to compute raw context %s\n", range);
>                         }
> @@ -1650,17 +1671,24 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
>                                         if (!canonical) {
>                                                 canonical = compute_trans_from_raw(lraw, domain);
>                                                 if (canonical)
> -                                                       if (add_cache(domain, lraw, canonical) < 0)
> +                                                       if (add_cache(domain, lraw, canonical) < 0) {
> +                                                               free(lraw);
> +                                                               free(range);
>                                                                 return -1;
> +                                                       }
>                                         }
>                                         if (canonical)
>                                                 free(canonical);
> -                                       if (add_cache(domain, lraw, lrange) < 0)
> +                                       if (add_cache(domain, lraw, lrange) < 0) {
> +                                               free(lraw);
> +                                               free(range);
>                                                 return -1;
> +                                       }
>                                 } else {
>                                         lraw = strdup(lrange);
>                                         if (! lraw) {
>                                                 log_error("strdup failed %s", strerror(errno));
> +                                               free(range);
>                                                 return -1;
>                                         }
>                                 }
> @@ -1674,17 +1702,27 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
>                                         if (!canonical) {
>                                                 canonical = compute_trans_from_raw(uraw, domain);
>                                                 if (canonical)
> -                                                       if (add_cache(domain, uraw, canonical) < 0)
> +                                                       if (add_cache(domain, uraw, canonical) < 0) {
> +                                                               free(uraw);
> +                                                               free(lraw);
> +                                                               free(range);
>                                                                 return -1;
>                                                         }
> +                                       }
>                                         if (canonical)
>                                                 free(canonical);
> -                                       if (add_cache(domain, uraw, urange) < 0)
> +                                       if (add_cache(domain, uraw, urange) < 0) {
> +                                               free(uraw);
> +                                               free(lraw);
> +                                               free(range);
>                                                 return -1;
> +                                       }
>                                 } else {
>                                         uraw = strdup(urange);
>                                         if (! uraw) {
>                                                 log_error("strdup failed %s", strerror(errno));
> +                                               free(lraw);
> +                                               free(range);
>                                                 return -1;
>                                         }
>                                 }
> @@ -1694,11 +1732,17 @@ untrans_context(const security_context_t incon, security_context_t *rcon) {
>                         if (strcmp(lraw, uraw) == 0) {
>                                 if (asprintf(&raw, "%s", lraw) < 0) {
>                                         log_error("asprintf failed %s", strerror(errno));
> +                                       free(uraw);
> +                                       free(lraw);
> +                                       free(range);
>                                         return -1;
>                                 }
>                         } else {
>                                 if (asprintf(&raw, "%s-%s", lraw, uraw) < 0) {
>                                         log_error("asprintf failed %s", strerror(errno));
> +                                       free(uraw);
> +                                       free(lraw);
> +                                       free(range);
>                                         return -1;
>                                 }
>                         }
> --
> 2.17.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
