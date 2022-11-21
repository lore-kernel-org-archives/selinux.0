Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59DDC4332F
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 15:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiKUPIy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 10:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiKUPIh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 10:08:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0BDAD33
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 06:58:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y24so11586618edi.10
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 06:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dAKHtRbbUPV71CSSk1b46nTW9PHbg7MUWI+wRcCEt3o=;
        b=OT6b33Q2r6eQC+2rZ70Hx3NPeZijyHsc3Ow/tESFc29L4035UkuYu8aZhUGEEUjgIs
         sFLLnYnNIfJp/2p1DgI2IHi72OZeOIsjO18HwKiF5/QwDV1lDvSWmvAe9HB3Uq21VfT0
         IHPjEA2YH8livaG9JuPd2LB0OJKFezFieevfUxw8gKk11Ewj1GGjqj2M+qptNzIUCQw9
         mbXCAV1lExEzoM8kMmUt3QmAT4mrwCUzHBpJOP2u0pM/HjnZVnTSLdLJFpkT9d5Xwjse
         ws9gWz9lfgBVN7A/wLiPoe1TwBcy42itYW2x8XQDyQ1U6sdolsn8mv38QICg16DxcyaY
         BCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAKHtRbbUPV71CSSk1b46nTW9PHbg7MUWI+wRcCEt3o=;
        b=PV1h7+c7b72PZbyuqhgguk8S1v1VCEnaeOotfS4qPicyyd4yaSaxwOxxKqWECiqr60
         M1WvjDBK+MRS2O/gdJ8NyFd6gbDJrR6m+eoJMN4HH296Dx/9G5Llw9j9jLqH7Ai88Vbu
         AN2ENw/WcqPXA7lUpyTSZLZzl0uyCquAOmPypG6Z48YUurmF7/hdSau3g52nSTYNbEkN
         PhPptnV2arOkGhmAKbH33d6tAZxtnJD0NGg3qP2LFg0H9B5MLzCS9oUeXh9VupOWlcmr
         Z6k5zfgEuegGfsSWQ8P5poSnvorFKtg+n7y2LfkTXEJcg2+X7zpouDTQc+wXtuowEzN5
         xBUQ==
X-Gm-Message-State: ANoB5pm84gT7d2RCDAQDgt1cd9iXH7zDnrSsamJyBDu/jW5ay/W9xLYa
        oM8uCHc60khf3BKT2k7kMxy4fgc08XDy29CvfKlbBIjqaQw=
X-Google-Smtp-Source: AA0mqf7u3Gr4vXmw8VF7S69VA8wEFMklRHnYgoiC/wlBvHiRTcIYyrZ1V/z/ifkn2Ylh11nbUzXuz/ET9XGYO29M6/w=
X-Received: by 2002:a50:fe8d:0:b0:461:9183:834b with SMTP id
 d13-20020a50fe8d000000b004619183834bmr2317434edt.196.1669042721593; Mon, 21
 Nov 2022 06:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20221118125153.453700-1-lautrbach@redhat.com>
In-Reply-To: <20221118125153.453700-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 09:58:30 -0500
Message-ID: <CAP+JOzR6nuK1SOcS-ADGSQBTV7Go2V=7ybXcevJUCzEjaFTp4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] python/sepolicy: Fix sepolicy manpage -w ...
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 18, 2022 at 8:07 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
> improved sepolicy performance but broke `sepolicy manpage -w ...` as it
> didn't collect data about domains and roles from ManPage() and so
> HTMLManPages() generated only empty page. This is fixed now, domains
> and roles are being collected and used for HTML pages.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> - v3: improved the result loop, based on Ondrej Mosnacek <omosnace@redhat.com>'s suggestion
>
>
>  python/sepolicy/sepolicy.py         | 13 +++++++++++--
>  python/sepolicy/sepolicy/manpage.py | 12 +++++-------
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 733d40484709..82ff6af2bc2d 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -332,9 +332,10 @@ def manpage_work(domain, path, root, source_files, web):
>      from sepolicy.manpage import ManPage
>      m = ManPage(domain, path, root, source_files, web)
>      print(m.get_man_page_path())
> +    return (m.manpage_domains, m.manpage_roles)
>
>  def manpage(args):
> -    from sepolicy.manpage import HTMLManPages, manpage_domains, manpage_roles, gen_domains
> +    from sepolicy.manpage import HTMLManPages, gen_domains
>
>      path = args.path
>      if not args.policy and args.root != "/":
> @@ -347,9 +348,17 @@ def manpage(args):
>      else:
>          test_domains = args.domain
>
> +    manpage_domains = set()
> +    manpage_roles = set()
>      p = Pool()
> +    async_results = []
>      for domain in test_domains:
> -        p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web])
> +        async_results.append(p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web]))
> +    for result in async_results:
> +        domains, roles = result.get()
> +        manpage_domains.update(domains)
> +        manpage_roles.update(roles)
> +
>      p.close()
>      p.join()
>
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> index 3e61e333193f..de72cb6cda5f 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -21,7 +21,7 @@
>  #                                        02111-1307  USA
>  #
>  #
> -__all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_domains']
> +__all__ = ['ManPage', 'HTMLManPages', 'gen_domains']
>
>  import string
>  import selinux
> @@ -147,10 +147,6 @@ def _gen_types():
>  def prettyprint(f, trim):
>      return " ".join(f[:-len(trim)].split("_"))
>
> -# for HTML man pages
> -manpage_domains = []
> -manpage_roles = []
> -
>  fedora_releases = ["Fedora17", "Fedora18"]
>  rhel_releases = ["RHEL6", "RHEL7"]
>
> @@ -408,6 +404,8 @@ class ManPage:
>      """
>      modules_dict = None
>      enabled_str = ["Disabled", "Enabled"]
> +    manpage_domains = []
> +    manpage_roles = []
>
>      def __init__(self, domainname, path="/tmp", root="/", source_files=False, html=False):
>          self.html = html
> @@ -453,10 +451,10 @@ class ManPage:
>          if self.domainname + "_r" in self.all_roles:
>              self.__gen_user_man_page()
>              if self.html:
> -                manpage_roles.append(self.man_page_path)
> +                self.manpage_roles.append(self.man_page_path)
>          else:
>              if self.html:
> -                manpage_domains.append(self.man_page_path)
> +                self.manpage_domains.append(self.man_page_path)
>              self.__gen_man_page()
>          self.fd.close()
>
> --
> 2.38.1
>
