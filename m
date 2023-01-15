Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A5C3DA78
	for <selinux@archiver.kernel.org>; Sun, 15 Jan 2023 22:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjAOWNP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Jan 2023 17:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAOWNN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Jan 2023 17:13:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893D1B54F
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 14:13:11 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so5655669pjg.4
        for <selinux@vger.kernel.org>; Sun, 15 Jan 2023 14:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9UK7rBr2lK8LDXuFtR1AHyd23hRt13ktbWGEhApewQ=;
        b=yz8O4JBcJRCHScHQvDY0iKb86Kg0qm11MJt+z6wRI5xLChInf+vty2IzEbJzzA0Xxg
         eH9QpgqHHqZYwSevUKrF8wtI/js1DhIq2b9AJzm/awXbJpslu9WJn8Ba12SY10Ag3V/l
         62Htxpc87U2ytP5McOjLhSK/YsVTkpuzSUOAQKOsQbqIgCZmaAdjfd3XT3AafIWHm/pb
         Fib8IGgyZ8PJMDTdsJ3QeakG1Ij0O51hnGCFisKDbIzFQjEKEuZHjUN8dyRAt0UBGFmN
         UzwPBe/Pr4LLVcVeo+YVjvFjpXCmguC/ml3JZciv72XX2+AYrEuwTvfnoejAqXMIRSqb
         5SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9UK7rBr2lK8LDXuFtR1AHyd23hRt13ktbWGEhApewQ=;
        b=Axo0j2677KHIMj3So9iRjKP7k04aHT/FTY2Lg+6YMqyrQDCIfK/aMUE/ABdQ1WQZWA
         Q7a6YoxADZjYxb8U+jBc5SKyFwu6V/58OiCqRDeV5phugCUxU3Oge+e5/SRb4VT8N6vN
         /p1dSMVT/mp24L5fCrQpof+Bwl9Oen3zrAER5glFe1Uhzf88VvQG4bHjKadt/jF0HUm9
         D+OSHIkY5xEmfR8munVnVpQOlumodpboULLXsfUC48E7UwOnGje75THpJKVhdtS7tubj
         yUiJl1WUwhw+sNhKpGZ+SkDL+9jjDjD3JWLSFXg0FNe4CVIKcxdJT2HS9Hs3Qw8MqRdb
         ecDQ==
X-Gm-Message-State: AFqh2kp2Yqupuz6nGzm5KZOKzjwQ5XL9071mHlETH/24v90IoEnTJ/r5
        ngWW1FwOzJYPwH/q4ZzBWBDM+bZmYQTVBUKHixo=
X-Google-Smtp-Source: AMrXdXtFQHZIefQanClBDXnDb6KN/z8VYpUuiyVODG9HxXywkiBZtkUyMTzQCcFhNkxySuZ7TyjbAw==
X-Received: by 2002:a05:6a20:be03:b0:b8:5813:e700 with SMTP id ge3-20020a056a20be0300b000b85813e700mr5128612pzb.3.1673820791073;
        Sun, 15 Jan 2023 14:13:11 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id y127-20020a623285000000b0058abddad316sm10145770pfy.209.2023.01.15.14.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 14:13:10 -0800 (PST)
Date:   Sun, 15 Jan 2023 14:13:09 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] python/sepolicy: add missing booleans to man pages
Message-ID: <Y8R6dd0tGdUFokkm@anduin.perfinion.com>
References: <20230109170626.815271-1-vmojzis@redhat.com>
 <20230110103726.865532-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110103726.865532-1-vmojzis@redhat.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 10, 2023 at 11:37:26AM +0100, Vit Mojzis wrote:
> get_bools should return a list of booleans that can affect given type,
> but it did not handle non trivial conditional statements properly
> (returning the whole conditional statement instead of a list of booleans
> in the statement).
> 
> e.g. for
> allow httpd_t spamc_t:process transition; [ httpd_can_check_spam && httpd_can_sendmail ]:True
> get_bools used to return [("httpd_can_check_spam && httpd_can_sendmail", False)] instead of
> [("httpd_can_check_spam", False), ("httpd_can_sendmail", False)]
> 
> - rename "boolean" in sepolicy rule dictionary to "booleans" to suggest
>   it can contain multiple values and make sure it is populated correctly
> - add "conditional" key to the rule dictionary to accommodate
>   get_conditionals, which requires the whole conditional statement
> - extend get_bools search to dontaudit rules so that it covers booleans
>   like httpd_dontaudit_search_dirs
> 
> Note: get_bools uses security_get_boolean_active to get the boolean
>       value, but the value is later used to represent the default.
>       Not ideal, but I'm not aware of a way to get the actual defaults.
> 
> Fixes:
>         "sepolicy manpage" generates man pages that are missing booleans
>         which are included in non trivial conditional expressions
>         e.g. httpd_selinux(8) does not include httpd_can_check_spam,
>         httpd_tmp_exec, httpd_unified, or httpd_use_gpg
> 
>         This fix, however, also adds some not strictly related booleans
>         to some man pages. e.g. use_nfs_home_dirs and
>         use_samba_home_dirs are added to httpd_selinux(8)
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Jason Zaman <jason@perfinion.com>

Merged, thanks!
-- Jason

> ---
> 
> Add "dontaudit" rules to get_bools search (otherwise same as the
> previous patch).
> 
> 
>  python/sepolicy/sepolicy/__init__.py | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 68907a4f..8611a51b 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -335,7 +335,12 @@ def _setools_rule_to_dict(rule):
>          pass
>  
>      try:
> -        d['boolean'] = [(str(rule.conditional), enabled)]
> +        d['booleans'] = [(str(b), b.state) for b in rule.conditional.booleans]
> +    except AttributeError:
> +        pass
> +
> +    try:
> +        d['conditional'] = str(rule.conditional)
>      except AttributeError:
>          pass
>  
> @@ -440,12 +445,12 @@ def get_conditionals(src, dest, tclass, perm):
>                  x['source'] in src_list and
>                  x['target'] in dest_list and
>                  set(perm).issubset(x[PERMS]) and
> -                'boolean' in x,
> +                'conditional' in x,
>                  get_all_allow_rules()))
>  
>      try:
>          for i in allows:
> -            tdict.update({'source': i['source'], 'boolean': i['boolean']})
> +            tdict.update({'source': i['source'], 'conditional': (i['conditional'], i['enabled'])})
>              if tdict not in tlist:
>                  tlist.append(tdict)
>                  tdict = {}
> @@ -459,10 +464,10 @@ def get_conditionals_format_text(cond):
>  
>      enabled = False
>      for x in cond:
> -        if x['boolean'][0][1]:
> +        if x['conditional'][1]:
>              enabled = True
>              break
> -    return _("-- Allowed %s [ %s ]") % (enabled, " || ".join(set(map(lambda x: "%s=%d" % (x['boolean'][0][0], x['boolean'][0][1]), cond))))
> +    return _("-- Allowed %s [ %s ]") % (enabled, " || ".join(set(map(lambda x: "%s=%d" % (x['conditional'][0], x['conditional'][1]), cond))))
>  
>  
>  def get_types_from_attribute(attribute):
> @@ -716,9 +721,9 @@ def get_boolean_rules(setype, boolean):
>      boollist = []
>      permlist = search([ALLOW], {'source': setype})
>      for p in permlist:
> -        if "boolean" in p:
> +        if "booleans" in p:
>              try:
> -                for b in p["boolean"]:
> +                for b in p["booleans"]:
>                      if boolean in b:
>                          boollist.append(p)
>              except:
> @@ -1141,7 +1146,7 @@ def get_bools(setype):
>      bools = []
>      domainbools = []
>      domainname, short_name = gen_short_name(setype)
> -    for i in map(lambda x: x['boolean'], filter(lambda x: 'boolean' in x and x['source'] == setype, get_all_allow_rules())):
> +    for i in map(lambda x: x['booleans'], filter(lambda x: 'booleans' in x and x['source'] == setype, search([ALLOW, DONTAUDIT]))):
>          for b in i:
>              if not isinstance(b, tuple):
>                  continue
> -- 
> 2.37.3
> 
