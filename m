Return-Path: <SRS0=ZMzQ=UN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C6C31E44
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 10:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ED420665
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 10:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfFNKSo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:18:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39297 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfFNKSo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jun 2019 06:18:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id m202so1569471oig.6
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2019 03:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wp1vgEPpx2tDkACz5jC52AGjmtx267Wpo9WHtt3wICo=;
        b=n43Ltqzk+C8H4+5a56SjjsuHCQXNbmPzF4c8HOwpnLx2lRZDuS06EII+D1rjNptxUj
         wyoKO3SaWcK0mERUQWo1j2jPREQFsCTIdXmKeRVyT20G/zdzKSkwUfX8ROc4bPncgCO5
         DmQ8n6IN66uz0z4uzYIakxR3c44k3obs1RcbTRxZTA4UZNbx5qYLQAMzHm0qzD+5Okmc
         WHQKL7zlGi5URYhmqpDQByi7RfZarZqf/md4TKbqCPF9gwaYWMrX4HB4PRFVcV/fkyv4
         CB8e4l5bhHr2EGCtl/72MwMv35UWAX/h5Viox1B6CMiFdqAwlJFOTFrvH/jgHtcOLR+4
         bVIw==
X-Gm-Message-State: APjAAAV1/nFJqMBb+CQ9wUmZLMetC1XSqp6l5enNUOVEqgssIfbPZkyg
        +IHezLGaE0QakrupK9tpgrpTOKqThmTVIclqTxbuhBBC
X-Google-Smtp-Source: APXvYqxgY9+ckLe6itWfWdHh5OLro+jAVUsF2kUPu59Fu1QZ7LdRFziUTpdBu1/NQhK9B6x3pOBvkCuAJPcFxo1oRDU=
X-Received: by 2002:aca:e588:: with SMTP id c130mr1407632oih.166.1560507523156;
 Fri, 14 Jun 2019 03:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190613114558.32621-1-omosnace@redhat.com> <20190613114558.32621-3-omosnace@redhat.com>
 <0e7cdb7f-b4a1-8ac7-e837-9bbb7523f4ff@tycho.nsa.gov>
In-Reply-To: <0e7cdb7f-b4a1-8ac7-e837-9bbb7523f4ff@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 14 Jun 2019 12:18:31 +0200
Message-ID: <CAFqZXNsgRTcH_=AUWNeGTdVNwBSDpw6EG9xu4B8uQJwa7zJdPA@mail.gmail.com>
Subject: Re: [Non-DoD Source] [PATCH userspace v4 2/4] libsemanage: optionally
 optimize policy on rebuild
To:     jwcart2 <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 13, 2019 at 9:51 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> On 6/13/19 7:45 AM, Ondrej Mosnacek wrote:
> > When building binary policy, optionally run it through
> > sepol_policydb_optimize() just before writing it out.
> >
> > Add an optimize-policy variable to semanage.conf(5) that controls
>
> Sorry I didn't notice this in v3, but why not use "optimize" instead of
> "optimize-policy"?

Since this is in a global libsemanage config file, I thought it would
be better if the name described also what is being optimized. In
secilc or checkpolicy it is more or less obvious; in the config file
it can't hurt to be more specific, IMHO.

>
> Jim
>
> > whether optimization will be applied during libsemanage operations.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   libsemanage/man/man5/semanage.conf.5 |  5 +++++
> >   libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
> >   libsemanage/src/conf-scan.l          |  1 +
> >   libsemanage/src/direct_api.c         |  7 +++++++
> >   libsemanage/src/semanage_conf.h      |  1 +
> >   5 files changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
> > index 8f8de55a..8efc7dd5 100644
> > --- a/libsemanage/man/man5/semanage.conf.5
> > +++ b/libsemanage/man/man5/semanage.conf.5
> > @@ -121,6 +121,11 @@ and by default it is set to "false".
> >   Please note that since this option deletes all HLL files, an updated HLL compiler will not be able to recompile the original HLL file into CIL.
> >   In order to compile the original HLL file into CIL, the same HLL file will need to be reinstalled.
> >
> > +.TP
> > +.B optimize-policy
> > +When set to "true", the kernel policy will be optimized upon rebuilds.
> > +It can be set to either "true" or "false" and by default it is set to "false".
> > +
> >   .SH "SEE ALSO"
> >   .TP
> >   semanage(8)
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> > index b527e893..9bf9364a 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -59,7 +59,7 @@ static int parse_errors;
> >           char *s;
> >   }
> >
> > -%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
> > +%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY
> >   %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
> >   %token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
> >   %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
> > @@ -95,6 +95,7 @@ single_opt:     module_store
> >       |       bzip_blocksize
> >       |       bzip_small
> >       |       remove_hll
> > +     |       optimize_policy
> >           ;
> >
> >   module_store:   MODULE_STORE '=' ARG {
> > @@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
> >       free($3);
> >   }
> >
> > +optimize_policy:  OPTIMIZE_POLICY '=' ARG {
> > +     if (strcasecmp($3, "false") == 0) {
> > +             current_conf->optimize_policy = 0;
> > +     } else if (strcasecmp($3, "true") == 0) {
> > +             current_conf->optimize_policy = 1;
> > +     } else {
> > +             yyerror("optimize-policy can only be 'true' or 'false'");
> > +     }
> > +     free($3);
> > +}
> > +
> >   command_block:
> >                   command_start external_opts BLOCK_END  {
> >                           if (new_external->path == NULL) {
> > @@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
> >       conf->bzip_small = 0;
> >       conf->ignore_module_cache = 0;
> >       conf->remove_hll = 0;
> > +     conf->optimize_policy = 0;
> >
> >       conf->save_previous = 0;
> >       conf->save_linked = 0;
> > diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> > index 607bbf0b..b06a896c 100644
> > --- a/libsemanage/src/conf-scan.l
> > +++ b/libsemanage/src/conf-scan.l
> > @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
> >   bzip-blocksize      return BZIP_BLOCKSIZE;
> >   bzip-small  return BZIP_SMALL;
> >   remove-hll  return REMOVE_HLL;
> > +optimize-policy return OPTIMIZE_POLICY;
> >   "[load_policy]"   return LOAD_POLICY_START;
> >   "[setfiles]"      return SETFILES_START;
> >   "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > index c58961be..0153091f 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -1461,6 +1461,13 @@ rebuild:
> >
> >               cil_db_destroy(&cildb);
> >
> > +             /* Remove redundancies in binary policy if requested. */
> > +             if (sh->conf->optimize_policy) {
> > +                     retval = sepol_policydb_optimize(out);
> > +                     if (retval < 0)
> > +                             goto cleanup;
> > +             }
> > +
> >               /* Write the linked policy before merging local changes. */
> >               retval = semanage_write_policydb(sh, out,
> >                                                SEMANAGE_LINKED);
> > diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
> > index c99ac8c7..23c4b8b4 100644
> > --- a/libsemanage/src/semanage_conf.h
> > +++ b/libsemanage/src/semanage_conf.h
> > @@ -47,6 +47,7 @@ typedef struct semanage_conf {
> >       int bzip_small;
> >       int remove_hll;
> >       int ignore_module_cache;
> > +     int optimize_policy;
> >       char *ignoredirs;       /* ";" separated of list for genhomedircon to ignore */
> >       struct external_prog *load_policy;
> >       struct external_prog *setfiles;
> >
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency



--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
