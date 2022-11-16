Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84630C43217
	for <selinux@archiver.kernel.org>; Wed, 16 Nov 2022 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbiKPVvb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiKPVvJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Nov 2022 16:51:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B16C701
        for <selinux@vger.kernel.org>; Wed, 16 Nov 2022 13:50:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a29so31743133lfj.9
        for <selinux@vger.kernel.org>; Wed, 16 Nov 2022 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zzDyflN4kw9NUP10CbM9cbIz6A0WLzJOkhd8t7Fg0a4=;
        b=K/tKNgDfUlzHgVwGCI9edRAPogZDQKcEVciD6ARE6fmSpBblQE1MVk3U504SnO1V6O
         vbsJB5iBElOc7hW3PlLlOnCocY5sjv7xFDt7bCxlWA/sjbSRauaMNYhaYgStRHL4mNKJ
         WJh50aShv5LyQmZNHXjE78hYFk9HwjrbJHb6yq7KAHQCJHRRx4o6Ae9lCyaocI/r89Pl
         IxFepOvxvOkxF1gwkmaRdzD8H69YhK2kUZrP/S355YB1Z2tl9AynnGcYuGLjy3RSUcMY
         oHusnUB0K+ldaQL2Y0VW4Mk5Ui9XxVP8AsCE8XMH93RECL0Klz8YvgefwybIbOSECGqG
         rH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzDyflN4kw9NUP10CbM9cbIz6A0WLzJOkhd8t7Fg0a4=;
        b=Sv9vEnVWN2/V0x60Ry1CfUHJRRpiJYdpOzqzfw1JEaY0yL3/1eTdur1k3XRlrvCQJK
         naXdjVTIrg/AX4d6nPs6EbNl+dnEcq/Vr5ZIokHi6BWwOFmoBIaeOcSn2YDHbTh/cL8O
         glsy8ankGTvLdaVTkTNIFz0cxO+L88UxboXuQ8odE2fK/DZHFRkfddJmPSuh4RvN0dph
         vs+uHb2ZWYpGZM91osPQiZyRuSvemNcteuaARagpUcnXV41K6PzU+MT8egTvF0FeLrJC
         4lpvqlv43RW6/A7FjlVBkx290jqLU414dwof0s3JppvsIVeub9/YV0DtR5u42chS6/i6
         MLmA==
X-Gm-Message-State: ANoB5pn03OI+YS2kXflRTGK8ZlW2ah3RcWv0bBbmf95gtwniZ4ATA8Ns
        MIAKSrDlyeY1z2izTDaeZ533vArIXpCE/UwRvOg=
X-Google-Smtp-Source: AA0mqf6XNYSb5W0fPPEzOpCG+m/aPI7A04WYTb8z4PQzuMcKL4rFuzBjKw9LIsDifuXJxppNd+Jr/5xxmCcHC2igozk=
X-Received: by 2002:a05:6512:1106:b0:4a4:7b88:68fc with SMTP id
 l6-20020a056512110600b004a47b8868fcmr18958lfg.30.1668635414396; Wed, 16 Nov
 2022 13:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115194552.338640-1-plautrba@redhat.com>
In-Reply-To: <20221115194552.338640-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Nov 2022 16:50:02 -0500
Message-ID: <CAP+JOzSM8QkAKiKVk+dUFagFu-zJ2GCzcjnY0mYqX3Hh=p7AUA@mail.gmail.com>
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

I ran `sepolicy manpage -w -d unconfined_t` and received the following error:
"""
Traceback (most recent call last):
  File "/usr/lib64/python3.10/multiprocessing/pool.py", line 125, in worker
    result = (True, func(*args, **kwds))
  File "/home/jim/local/usr/bin/./sepolicy", line 335, in manpage_work
    return (m.manpage_domains, m.manpage_roles)
AttributeError: 'ManPage' object has no attribute 'manpage_domains'
"""

I don't get the error from the master branch, but I do confirm the bug
you reported above.

Thanks,
Jim

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
