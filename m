Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050ED31F99F
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791326; cv=none; b=mHq8PSIdKD9OtrB5a94CFtGlxJ/Xa2scEOdhdj6jO7gSpcyKp+k+799Ql6sjkgTs27vQ/wPutz5gjaeuqo1ucgIchOL4cDSJtdD8LHhdsbTxAN/CEr2XjEn1Q9FNOhVshByDljcNVqev4mDfA8CPq3m6NpB1CwiLnIXdIUA7umY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791326; c=relaxed/simple;
	bh=2tTZTL3QM9osAIq8XnpLwHTGyb1Kgib0gomicSMYb2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMj8onDzGRIttoV5ChQ6ypM1vbPYbMVr299vw4QwwaRyboHqrKoEDQd5UhpYm1vqlWtLPGmyG1qzhCvNhrjnveHwzXWE11q36J4m/+1qT33yJw9hsvHmkmy4jM0uzJJ3w+dqCiZL67PPj5ZHBWbx8wFSCqeeOs0s6E51fK8Q1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=m1zuAJNo; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="m1zuAJNo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JsNMn0rj2TYwimoMGzgDTRcMy7TmfEpYfFSSXMGu3mQ=; b=m1zuAJNo+eMq/wdKmRg+GKuaBR
	qe/cR/fxGbQQ/R+tIN/Oe+wveWpzuaS/netmB+7+3JNgscSW0gM+TXp3uA3+Jvk4GTHf/wz1CnWBG
	+8A+mdyEKjb9nSFxl8lxqHypPdGQ+izvRxYOv55DRQXeaIAZplupX94QugarYVIbacp0Yc2gOO15F
	456meWSem02zLwOUIsdR9KhbMCjwysDY/MS04i3EKhiKrjnXbXVSEUrT/KRuCGA+kU6BUrGXtyWhm
	qi/eSWt9zrOjcej+QHhGEHPoznCfS1atWWTIjwpkqJB6YGSyEjH6LXsaHWf+7a5lBhoBf3xoVYNR+
	e/p5hxAw==;
Received: from 176-93-144-62.bb.dnainternet.fi ([176.93.144.62]:11323 helo=14-5A-FC-31-E8-67)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wNcsY-0000000E1jt-1lSq;
	Thu, 14 May 2026 23:41:53 +0300
Date: Thu, 14 May 2026 23:41:51 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH v2] libsemanage: use 'bool' for boolean options
Message-ID: <agYzjzVKUZ1pK1o1@14-5A-FC-31-E8-67>
References: <20260506195818.93622-1-kalevi@kolttonen.fi>
 <CAP+JOzTtcQikXMEjQrN5zO+9qwzQ9jz7X-bRhrEaq-2k0MR0Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP+JOzTtcQikXMEjQrN5zO+9qwzQ9jz7X-bRhrEaq-2k0MR0Ng@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Thu, May 14, 2026 at 03:25:44PM -0400, James Carter wrote:
> On Wed, May 6, 2026 at 3:58 PM Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> >
> > Use 'bool' for boolean options. Check strdup() failures.
> > Add explicit 'conf->disable_genhomedircon = false' default
> > initialization.
> >
> > Add missing <stdbool.h> include.
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> > ---
> >  libsemanage/src/conf-parse.y    | 68 ++++++++++++++++++---------------
> >  libsemanage/src/semanage_conf.h | 21 +++++-----
> >  2 files changed, 49 insertions(+), 40 deletions(-)
> >
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> > index b69ac75b..0f10546e 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -29,6 +29,7 @@
> >
> >  #include <errno.h>
> >  #include <unistd.h>
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -132,9 +133,9 @@ compiler_dir:       COMPILER_DIR '=' ARG  {
> >
> >  ignore_module_cache:   IGNORE_MODULE_CACHE '=' ARG  {
> >                                                         if (strcasecmp($3, "true") == 0)
> > -                                                               current_conf->ignore_module_cache = 1;
> > +                                                               current_conf->ignore_module_cache = true;
> >                                                         else if (strcasecmp($3, "false") == 0)
> > -                                                               current_conf->ignore_module_cache = 0;
> > +                                                               current_conf->ignore_module_cache = false;
> >                                                         else {
> >                                                                 yyerror("disable-caching can only be 'true' or 'false'");
> >                                                         }
> > @@ -195,9 +196,9 @@ file_mode:   FILE_MODE '=' ARG  {
> >
> >  save_previous:    SAVE_PREVIOUS '=' ARG {
> >                         if (strcasecmp($3, "true") == 0)
> > -                               current_conf->save_previous = 1;
> > +                               current_conf->save_previous = true;
> >                         else if (strcasecmp($3, "false") == 0)
> > -                               current_conf->save_previous = 0;
> > +                               current_conf->save_previous = false;
> >                         else {
> >                                 yyerror("save-previous can only be 'true' or 'false'");
> >                         }
> > @@ -208,9 +209,9 @@ save_previous:    SAVE_PREVIOUS '=' ARG {
> >
> >  save_linked:    SAVE_LINKED '=' ARG {
> >                         if (strcasecmp($3, "true") == 0)
> > -                               current_conf->save_linked = 1;
> > +                               current_conf->save_linked = true;
> >                         else if (strcasecmp($3, "false") == 0)
> > -                               current_conf->save_linked = 0;
> > +                               current_conf->save_linked = false;
> >                         else {
> >                                 yyerror("save-linked can only be 'true' or 'false'");
> >                         }
> > @@ -220,9 +221,9 @@ save_linked:    SAVE_LINKED '=' ARG {
> >
> >  disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> > -               current_conf->disable_genhomedircon = 0;
> > +               current_conf->disable_genhomedircon = false;
> >         } else if (strcasecmp($3, "true") == 0) {
> > -               current_conf->disable_genhomedircon = 1;
> > +               current_conf->disable_genhomedircon = true;
> >         } else {
> >                 yyerror("disable-genhomedircon can only be 'true' or 'false'");
> >         }
> > @@ -231,9 +232,9 @@ disable_genhomedircon: DISABLE_GENHOMEDIRCON '=' ARG {
> >
> >  usepasswd: USEPASSWD '=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> > -               current_conf->usepasswd = 0;
> > +               current_conf->usepasswd = false;
> >         } else if (strcasecmp($3, "true") == 0) {
> > -               current_conf->usepasswd = 1;
> > +               current_conf->usepasswd = true;
> >         } else {
> >                 yyerror("usepasswd can only be 'true' or 'false'");
> >         }
> > @@ -272,9 +273,9 @@ bzip_blocksize:  BZIP_BLOCKSIZE '=' ARG {
> >
> >  bzip_small:  BZIP_SMALL '=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> > -               current_conf->bzip_small = 0;
> > +               current_conf->bzip_small = false;
> >         } else if (strcasecmp($3, "true") == 0) {
> > -               current_conf->bzip_small = 1;
> > +               current_conf->bzip_small = true;
> >         } else {
> >                 yyerror("bzip-small can only be 'true' or 'false'");
> >         }
> > @@ -283,9 +284,9 @@ bzip_small:  BZIP_SMALL '=' ARG {
> >
> >  remove_hll:  REMOVE_HLL'=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> > -               current_conf->remove_hll = 0;
> > +               current_conf->remove_hll = false;
> >         } else if (strcasecmp($3, "true") == 0) {
> > -               current_conf->remove_hll = 1;
> > +               current_conf->remove_hll = true;
> >         } else {
> >                 yyerror("remove-hll can only be 'true' or 'false'");
> >         }
> > @@ -294,9 +295,9 @@ remove_hll:  REMOVE_HLL'=' ARG {
> >
> >  relabel_store:  RELABEL_STORE'=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> > -               current_conf->relabel_store = 0;
> > +               current_conf->relabel_store = false;
> >         } else if (strcasecmp($3, "true") == 0) {
> > -               current_conf->relabel_store = 1;
> > +               current_conf->relabel_store = true;
> >         } else {
> >                 yyerror("relabel_store can only be 'true' or 'false'");
> >         }
> > @@ -305,9 +306,9 @@ relabel_store:  RELABEL_STORE'=' ARG {
> >
> >  optimize_policy:  OPTIMIZE_POLICY '=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> > -               current_conf->optimize_policy = 0;
> > +               current_conf->optimize_policy = false;
> >         } else if (strcasecmp($3, "true") == 0) {
> > -               current_conf->optimize_policy = 1;
> > +               current_conf->optimize_policy = true;
> >         } else {
> >                 yyerror("optimize-policy can only be 'true' or 'false'");
> >         }
> > @@ -316,9 +317,9 @@ optimize_policy:  OPTIMIZE_POLICY '=' ARG {
> >
> >  multiple_decls:  MULTIPLE_DECLS '=' ARG {
> >         if (strcasecmp($3, "false") == 0) {
> > -               current_conf->multiple_decls = 0;
> > +               current_conf->multiple_decls = false;
> >         } else if (strcasecmp($3, "true") == 0) {
> > -               current_conf->multiple_decls = 1;
> > +               current_conf->multiple_decls = true;
> >         } else {
> >                 yyerror("multiple-decls can only be 'true' or 'false'");
> >         }
> > @@ -398,26 +399,33 @@ static int semanage_conf_init(semanage_conf_t * conf)
> >         const char *policy_root = selinux_policy_root();
> >         if (policy_root != NULL) {
> >                 conf->store_path = strdup(semanage_basename(policy_root));
> > +               if (!conf->store_path)
> > +                       return -1;
> >         }
> >         conf->ignoredirs = NULL;
> >         conf->store_root_path = strdup("/var/lib/selinux");
> > +       if (!conf->store_root_path)
> > +               return -1;
> >         conf->compiler_directory_path = strdup("/usr/libexec/selinux/hll");
> > +       if (!conf->compiler_directory_path)
> > +               return -1;
> >         conf->policyvers = sepol_policy_kern_vers_max();
> >         conf->target_platform = SEPOL_TARGET_SELINUX;
> >         conf->expand_check = 1;
> >         conf->handle_unknown = -1;
> > -       conf->usepasswd = 1;
> > +       conf->usepasswd = true;
> >         conf->file_mode = 0644;
> >         conf->bzip_blocksize = 9;
> > -       conf->bzip_small = 0;
> > -       conf->ignore_module_cache = 0;
> > -       conf->remove_hll = 0;
> > -       conf->relabel_store = 1;
> > -       conf->optimize_policy = 1;
> > -       conf->multiple_decls = 1;
> > -
> > -       conf->save_previous = 0;
> > -       conf->save_linked = 0;
> > +       conf->bzip_small = false;
> > +       conf->ignore_module_cache = false;
> 
> In handle.c the function semanage_set_ignore_module_cache() assigns an
> int to this.
> It is fine to assign a bool to an int, but I would rather be more
> explicit when assigning an int to a bool, so that assignment should
> be:
> sh->conf->ignore_module_cache = (ignore_module_cache != 0);
> if you prefer, the following style is used in multiple places:
> sh->conf->ignore_module_cache = !!ignore_module_cache;

Understood. I chose your latter suggestion.

> > +       conf->remove_hll = false;
> 
> In direct_api.c, remove_hll is compared to 1, that comparison should just be:
> if (sh->conf->remove_hll) {

Done. I will send fixed v3 now.

br,
KK
