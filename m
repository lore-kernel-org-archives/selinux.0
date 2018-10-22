Return-Path: <SRS0=10e4=NC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF9C004D3
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 18:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B55205F4
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 18:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B55205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJWCWz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:22:55 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56993 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbeJWCWz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Oct 2018 22:22:55 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2018 22:22:54 EDT
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 75F825647ED
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 19:54:06 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id 14so36945329oth.2
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 10:54:06 -0700 (PDT)
X-Gm-Message-State: ABuFfohoTP30Q566L9aJwvvAUTH939IJ/+FKorNt89I/pCP4bbOAK8e2
        ysZCmlRJojGK/OfHxBfia7qVL7NY3nrji+KlsVE=
X-Google-Smtp-Source: ACcGV63BtxEfvoWzdi2Z2XVFxZBTyuf++ObZfpdlGi3o+iaw/ChNfRjUV5YZ3aKX0S1LfYBtSu3/gpA8+iGIF5AmrMM=
X-Received: by 2002:a9d:330:: with SMTP id 45mr31405528otv.165.1540230845394;
 Mon, 22 Oct 2018 10:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=nSsAKJ=MB6HiZ3mDE3kVa4Yx8imkVDsq-ngC-2O8Vfpg@mail.gmail.com>
 <20181022154313.19577-1-vmojzis@redhat.com>
In-Reply-To: <20181022154313.19577-1-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 22 Oct 2018 19:53:54 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==tKhuWAmzgw+O5fhX9n8h0Jo_0zgmn3zbcqW=yf_JaJw@mail.gmail.com>
Message-ID: <CAJfZ7==tKhuWAmzgw+O5fhX9n8h0Jo_0zgmn3zbcqW=yf_JaJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] python/sepolicy: Stop rejecting aliases in sepolicy commands
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Oct 22 19:54:07 2018 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 22, 2018 at 5:43 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Fix CheckDomain and CheckPortType classes to properly deal with aliases.
>
> Resolves:
>    https://bugzilla.redhat.com/show_bug.cgi?id=1600009
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/sepolicy/sepolicy.py          |  8 +++-----
>  python/sepolicy/sepolicy/__init__.py | 16 +++++++++++++++-
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index a000c1ad..01380fbe 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -60,8 +60,6 @@ class CheckPath(argparse.Action):
>  class CheckType(argparse.Action):
>
>      def __call__(self, parser, namespace, values, option_string=None):
> -        domains = sepolicy.get_all_domains()
> -
>          if isinstance(values, str):
>              setattr(namespace, self.dest, values)
>          else:
> @@ -103,7 +101,7 @@ class CheckDomain(argparse.Action):
>          domains = sepolicy.get_all_domains()
>
>          if isinstance(values, str):
> -            if values not in domains:
> +            if sepolicy.get_real_type_name(values) not in domains:
>                  raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (values, ", ".join(domains)))
>              setattr(namespace, self.dest, values)
>          else:
> @@ -112,7 +110,7 @@ class CheckDomain(argparse.Action):
>                  newval = []
>
>              for v in values:
> -                if v not in domains:
> +                if sepolicy.get_real_type_name(v) not in domains:
>                      raise ValueError("%s must be an SELinux process domain:\nValid domains: %s" % (v, ", ".join(domains)))
>                  newval.append(v)
>              setattr(namespace, self.dest, newval)
> @@ -167,7 +165,7 @@ class CheckPortType(argparse.Action):
>          if not newval:
>              newval = []
>          for v in values:
> -            if v not in port_types:
> +            if sepolicy.get_real_type_name(v) not in port_types:
>                  raise ValueError("%s must be an SELinux port type:\nValid port types: %s" % (v, ", ".join(port_types)))
>              newval.append(v)
>          setattr(namespace, self.dest, values)
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 8484b28c..9ea10835 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -446,6 +446,20 @@ def get_file_types(setype):
>              mpaths[f] = []
>      return mpaths
>
> +def get_real_type_name(name):
> +    """Return the real name of a type
> +
> +    * If 'name' refers to a type, return the same name.
> +    * If 'name' refers to a type alias, return the corresponding type name.
> +    * Otherwise return None.
> +    """
> +    if not name:
> +        return None
> +
> +    try:
> +        return next(info(TYPE, name))["name"]
> +    except (RuntimeError, StopIteration):
> +        return None
>
>  def get_writable_files(setype):
>      file_types = get_all_file_types()
> @@ -1061,7 +1075,7 @@ def gen_short_name(setype):
>          domainname = setype[:-2]
>      else:
>          domainname = setype
> -    if domainname + "_t" not in all_domains:
> +    if get_real_type_name(domainname + "_t") not in all_domains:
>          raise ValueError("domain %s_t does not exist" % domainname)
>      if domainname[-1] == 'd':
>          short_name = domainname[:-1] + "_"
> --
> 2.17.2
>
Looks good to me. I will let the possibility for others to comment and
will merge these patches tomorrow.

Thanks,
Nicolas

