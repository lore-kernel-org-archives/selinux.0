Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC71AC43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7B12070D
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 14:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfAEOn2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 09:43:28 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44107 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfAEOn1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 09:43:27 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1E9FA5606AE
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 15:43:24 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id s5so34413374oth.7
        for <selinux@vger.kernel.org>; Sat, 05 Jan 2019 06:43:24 -0800 (PST)
X-Gm-Message-State: AJcUukdJfdXh9O1p5soieP9QemyBxuFzWf3C4moxaXsGvLJ/SE077rpB
        FWkMHzDMz4mLMzL+m0ePqHNoaCePFqaf54CcKPM=
X-Google-Smtp-Source: ALg8bN7bNaPl460o2y5BvhUO/ezKWXGl66x6JeSMA7RAcJCnz8LVHYJORw+zzTqf/LxtRsXaTusnXzom9wgkzNaj6ms=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr35028079otj.301.1546699403214;
 Sat, 05 Jan 2019 06:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20181220151420.30878-1-plautrba@redhat.com> <20190103120340.2695-1-plautrba@redhat.com>
 <20190103120340.2695-5-plautrba@redhat.com>
In-Reply-To: <20190103120340.2695-5-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 5 Jan 2019 15:43:12 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==C9+hrRxip9K+m7bPJNQCoH1LKXMHdjgYKCzdsky_zPg@mail.gmail.com>
Message-ID: <CAJfZ7==C9+hrRxip9K+m7bPJNQCoH1LKXMHdjgYKCzdsky_zPg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] python/sepolicy: Make policy files sorting more robust
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 15:43:24 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 3, 2019 at 1:03 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> The sorting order seems to be fragile because '100' < '99', so the policy
> filename needs to be parsed in order to extract the version as an integer and
> sort according to it.
>
> Based on idea from Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, merged all 5 commits.
Nicolas

> ---
>  python/sepolicy/sepolicy/__init__.py | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index b69a6b94..6f729472 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -119,23 +119,34 @@ all_allow_rules = None
>  all_transitions = None
>
>
> +def policy_sortkey(policy_path):
> +    # Parse the extension of a policy path which looks like .../policy/policy.31
> +    extension = policy_path.rsplit('/policy.', 1)[1]
> +    try:
> +        return int(extension), policy_path
> +    except ValueError:
> +        # Fallback with sorting on the full path
> +        return 0, policy_path
> +
>  def get_installed_policy(root="/"):
>      try:
>          path = root + selinux.selinux_binary_policy_path()
>          policies = glob.glob("%s.*" % path)
> -        policies.sort()
> +        policies.sort(key=policy_sortkey)
>          return policies[-1]
>      except:
>          pass
>      raise ValueError(_("No SELinux Policy installed"))
>
> -def get_store_policy(store, root="/"):
> -    try:
> -        policies = glob.glob("%s%s/policy/policy.*" % (selinux.selinux_path(), store))
> -        policies.sort()
> -        return policies[-1]
> -    except:
> +def get_store_policy(store):
> +    """Get the path to the policy file located in the given store name"""
> +    policies = glob.glob("%s%s/policy/policy.*" %
> +                         (selinux.selinux_path(), store))
> +    if not policies:
>          return None
> +    # Return the policy with the higher version number
> +    policies.sort(key=policy_sortkey)
> +    return policies[-1]
>
>  def policy(policy_file):
>      global all_domains
> --
> 2.20.1
>

