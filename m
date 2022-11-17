Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD8C433FE
	for <selinux@archiver.kernel.org>; Thu, 17 Nov 2022 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbiKQShr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiKQShq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Nov 2022 13:37:46 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52873BAB
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 10:37:45 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id d3so3885042ljl.1
        for <selinux@vger.kernel.org>; Thu, 17 Nov 2022 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MRtyIliWjmjZz//9qy9gEXVJvZjXhui6uEiFWfOyThQ=;
        b=etXJomtp7kkOPzddKjrRfDwbVf5tdg7VybFyCH7mphInq/lZ6isJIXK40jKdOchvi7
         3gyj7r7EI8Rft7zTN0rOmf91IsM7cyzxxE5P8va0lUZR6xgDKAgjCnZ32F1T47jvTryA
         GyDB3J3/H+QbGnls66ijcIST6yEpFP+S1JaJiFpEgY4fOAJWFHkuMGXde/+4ZyOjS3UR
         Xm1OmCshllrpkhhNCDDMZKjhQ1eTE5DBH7jEZ0tkaX7Vb9z1OuwvSX2ApOAzJ2JXGrXG
         HWd4T+FebeHDAXTf/1Bg+6V28m4PaLDcwtjod5ZHlPKWyC/qayqN6praao0PSLErDArT
         0IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRtyIliWjmjZz//9qy9gEXVJvZjXhui6uEiFWfOyThQ=;
        b=QDKnj/Dvh16WA7NmM2k2nKnTL1SuwoOVCR8voJg8ivsyyiKl+PTxWQCtMag9cYdk9w
         w/eB+Jx/SS4Tv0VvNQetm0jCTmeIoPMMh4qXkPgZbUjq5zmwx53IBNmMwrzcH3SeWN45
         8Wqubqhnh1TYz50+PPJTSRMmlFqCgPE1aaisy8XaRxl+dTZFOT2+Msg4/nfYyKqmDUCw
         7t9aSzd5UCFtjtHTfv5ITloMgHy2mpLu9x5W3XRehfoIhCttnDSOZfQn/tX3IJtlqfZc
         LNlMRj7PxyBeU7BSc4EEeynNKYtkBqxb6zDMjhLgv1IkczQubrUa1sn5wXj1avhrUmEx
         NdZA==
X-Gm-Message-State: ANoB5pmSGZ8UMZU1DPuAtXKUMkwBhMyA7ApQka40Y1TwKQeencP1AxOL
        ZI/HM1sxK5gSODF0QrywAcr5Vg2td3r8joIouVq+G81onpM=
X-Google-Smtp-Source: AA0mqf4j3nx8bWwYqfPVavRMwRWrB+m6dvfBKKsOQYJDQRmu3PE2p58BrNl54MTsLMqPgelOP7adWhYiSMpDMFHCwAc=
X-Received: by 2002:a2e:83c5:0:b0:277:aed:be6b with SMTP id
 s5-20020a2e83c5000000b002770aedbe6bmr1554852ljh.322.1668710263739; Thu, 17
 Nov 2022 10:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20221115194552.338640-1-plautrba@redhat.com>
In-Reply-To: <20221115194552.338640-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 17 Nov 2022 13:37:32 -0500
Message-ID: <CAP+JOzTmSeozgeXpZsE0N5MHMr__qvZvV+u9GRt4kDcXwE2U3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] python/sepolicy: Fix sepolicy manpage -w ...
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 15, 2022 at 2:58 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Petr Lautrbach <lautrbach@redhat.com>
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
>  python/sepolicy/sepolicy.py         | 13 +++++++++++--
>  python/sepolicy/sepolicy/manpage.py | 12 +++++-------
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 733d40484709..2ca02ee9a0cf 100755
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
> +    results = map(lambda x: x.get(), async_results)
> +    for result in results:
> +        manpage_domains.update(set(result[0]))
> +        manpage_roles.update(set(result[1]))
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
