Return-Path: <SRS0=2qaZ=YD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464EBC4360C
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 19:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1E214E0
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 19:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfJJTsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:48:55 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:36451 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfJJTsz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Oct 2019 15:48:55 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3A2FE564779
        for <selinux@vger.kernel.org>; Thu, 10 Oct 2019 21:48:52 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id 83so6016249oii.1
        for <selinux@vger.kernel.org>; Thu, 10 Oct 2019 12:48:52 -0700 (PDT)
X-Gm-Message-State: APjAAAXWsTUcjjr4SUo830u5jd4+FozoH/3sBBa9mFgpbPWfsOSCUhua
        oRC9OqNdydyymaUgactrIuPvRc922Kz1bW5hwlk=
X-Google-Smtp-Source: APXvYqwWg3IAy0wA05C4cC+AqwvYbzPSj7WYhsu2J69IlGoAzqX4I60t0D19wxVJqup2rjwN+fJWOxVomF96OQBbeW0=
X-Received: by 2002:a54:4797:: with SMTP id o23mr8602077oic.50.1570736930948;
 Thu, 10 Oct 2019 12:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191009142024.9278-1-sds@tycho.nsa.gov>
In-Reply-To: <20191009142024.9278-1-sds@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 10 Oct 2019 21:48:39 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mQ1MwfWC-R+QM45runiOunGQqTq-cjA8LZptN1n8g-2w@mail.gmail.com>
Message-ID: <CAJfZ7=mQ1MwfWC-R+QM45runiOunGQqTq-cjA8LZptN1n8g-2w@mail.gmail.com>
Subject: Re: [PATCH v2] python/sepolicy: call segenxml.py with python3
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Oct 10 21:48:52 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 9, 2019 at 4:20 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/61
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 wraps basedir + filename in parentheses as per Nicolas Iooss' suggestion.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

>
>  python/sepolicy/sepolicy/interface.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
> index 583091ae18aa..187419fa7822 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -196,7 +196,7 @@ def get_xml_file(if_file):
>          from subprocess import getstatusoutput
>      basedir = os.path.dirname(if_file) + "/"
>      filename = os.path.basename(if_file).split(".")[0]
> -    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
> +    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % (basedir + filename))
>      if rc != 0:
>          sys.stderr.write("\n Could not proceed selected interface file.\n")
>          sys.stderr.write("\n%s" % output)
> --
> 2.21.0
>

