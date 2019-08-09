Return-Path: <SRS0=nXDU=WF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C5C433FF
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CD020C01
	for <selinux@archiver.kernel.org>; Fri,  9 Aug 2019 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GvVGDg6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407365AbfHIPWx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:22:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37522 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407329AbfHIPWx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Aug 2019 11:22:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id z28so38222173ljn.4
        for <selinux@vger.kernel.org>; Fri, 09 Aug 2019 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jh6fzs0ikG2BlMAtozcducufBjiT5WvI3N4CmuMHhsg=;
        b=GvVGDg6J/CLpTYR71Tg/s0OpycVpMoLFH7NmrXphH2GQeb6Dbu54kb/e3Ya3Zmqwdy
         IYI2noOoC8tNWiEaVxNNw1VqIcJIxFuV9enFoT/6WvWXVhsmwRQgRdX+a+m4XiwScYI9
         1bS/107V86j7QhXn5UhbxVwvmwl+9U7xONHX2tHeuBS9R1cCfU7pc0HOcTx5FDlQyZ0T
         4w60yTDkjCkpGfQJqtq5B5EcJy9kwlV3b/s0JYe7Ze8x2Of4yMdW9MRVDTL6yqNuoget
         TB8P+WkHKrPyEsRFh1CKJLm8XNezdQ55WiPc7UE1dhTh+RVUvxzg3GqomyU17oXR0ja7
         yUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jh6fzs0ikG2BlMAtozcducufBjiT5WvI3N4CmuMHhsg=;
        b=mS9eRVsMf7xkD6ZSAuEp32hsDYFBZt+pinHx+UtnksCB5fVmKQsh45luOQ3a8TqUMi
         AXAYrBH+1PpcjlYQ7pBM5iVtsKdMhdaXeKWk2V36SonK4I0A09zWc8diaN+lc0dWzLzP
         a3Q8NTddZl4WTZ7AAJj4/lMJu0nUf4Nxe3zzZRmMM3QXM1u9z/ZSqwNPzW6aPgmv8IHz
         e5/2WfBBFbZTtzs8NKFKV9uleSYe+wPAp9NYviVVLjeVUrKS800j10wk5VqSteB3YFyf
         eEr8shOFP/IQHO55nE413z0sdTpbk/FbvHLLJt+7lX5i2dlAMX8HtcyG6RFihTyH1YQQ
         f/rg==
X-Gm-Message-State: APjAAAXO12bjXTxumGbfo2oZweZc+lXuZq6sdBpUXBJKZTPZ03zk5zCZ
        PcSwOT7HwaQBiuqIS5XBbB6t3ZDFGtz1FE6llzJ0
X-Google-Smtp-Source: APXvYqwBFkpJqHKwF8iqFvrO4kMnNF4S8wnrJxNHcFPkhkrrN6LjhEJK016hLciAhD/jltYDwhDTtL8iJ/mRida4I0I=
X-Received: by 2002:a2e:834e:: with SMTP id l14mr7267230ljh.158.1565364170957;
 Fri, 09 Aug 2019 08:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190801111232.5589-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190801111232.5589-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 9 Aug 2019 11:22:39 -0400
Message-ID: <CAHC9VhS+76AW-qVO_DRGaGdVz25mX0hbiz1V2dGAX7mEyi3yXQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] selinux-testsuite: Add BPF tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 1, 2019 at 7:12 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> This adds basic BPF tests for map and prog functions.
>
> The check-syntax script has been modified to exclude files listed
> in tools/chk_c_exclude. This is because of macros in bpf_common.c
> that get horribly reformatted by check-syntax.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change - Split BPF code into bpf_common.c for others to use.
>
>  README.md              |  4 +-
>  defconfig              |  5 +++
>  policy/Makefile        |  4 ++
>  policy/test_bpf.te     | 77 ++++++++++++++++++++++++++++++++
>  tests/Makefile         |  4 ++
>  tests/bpf/.gitignore   |  2 +
>  tests/bpf/Makefile     | 12 +++++
>  tests/bpf/bpf_common.c | 99 ++++++++++++++++++++++++++++++++++++++++++
>  tests/bpf/bpf_test.c   | 83 +++++++++++++++++++++++++++++++++++
>  tests/bpf/test         | 57 ++++++++++++++++++++++++
>  tools/check-syntax     |  2 +-
>  tools/chk_c_exclude    |  1 +
>  12 files changed, 348 insertions(+), 2 deletions(-)
>  create mode 100644 policy/test_bpf.te
>  create mode 100644 tests/bpf/.gitignore
>  create mode 100644 tests/bpf/Makefile
>  create mode 100644 tests/bpf/bpf_common.c
>  create mode 100644 tests/bpf/bpf_test.c
>  create mode 100755 tests/bpf/test
>  create mode 100644 tools/chk_c_exclude

...

> diff --git a/tools/check-syntax b/tools/check-syntax
> index 7f9768d..5b7c211 100755
> --- a/tools/check-syntax
> +++ b/tools/check-syntax
> @@ -11,7 +11,7 @@
>  #
>
>  CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name "*.h")"
> -CHK_C_EXCLUDE=""
> +CHK_C_EXCLUDE="$(cat tools/chk_c_exclude)"
>
>  CHK_PERL_LIST="$(find tests/ -name "*.pl") $(find tests/ -name "test")"
>  CHK_PERL_EXCLUDE=""
> diff --git a/tools/chk_c_exclude b/tools/chk_c_exclude
> new file mode 100644
> index 0000000..20facbf
> --- /dev/null
> +++ b/tools/chk_c_exclude
> @@ -0,0 +1 @@
> +tests/bpf/bpf_common.c

Why are we excluding bpf_common.c from the style checks?

-- 
paul moore
www.paul-moore.com
