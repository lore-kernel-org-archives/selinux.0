Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCCC10F00
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 22:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B475206CC
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 22:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="FW3pqn6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCFWO5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:14:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33077 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCFWOz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 17:14:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id c62so4305002edf.0
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 14:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcdjmaRekvCPDwmZxTjQpg1+N6fA5VT5QjOCecOrNrk=;
        b=FW3pqn6lgMi6u9sEIUTxdGwpMAmC0UKJBzo5zeZtYFkXgnwDE2+ZADmnGQEwVdAA6Y
         SFnyoHho4lbxS3YsT52Y2khUZwE1TMz72JvnpvYLm0R9AVO56+sALJrU/YjN1nMS8xnD
         LtDdoxpy8mM5jB51I9OuXR6VKzVL+cmHgu/qNUSIh7l3eJg/lQK5D2dJA/ExKuTmgjN8
         /4HHoc39nD6hUK5gJGMThJocJXl5YN7e0UQih5BprTaLQfJLcZky8vZtuynbwqxDLN5X
         geDrnkUCHUJ62GIPxhW0VE7Z9d1oiBQZQ204Ram+3pXn4z5EWYEtU/hhHET8Xjv4Oysc
         XT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcdjmaRekvCPDwmZxTjQpg1+N6fA5VT5QjOCecOrNrk=;
        b=Rl3fz+Zk4uX9JumyuwnrShqSDTdeBkg9jdTmYlsv5GZhU6kzcnRQ8AugaOkexIbEIV
         TzvqVWIWpzedaQeSW1ue42Y6Q0W0X0kjjWwh5K/rOvOjF3eWdrPkFe42yHyaOcC0TlsY
         hHVymzfjn/kd/9cwL8KK/VfMrlcocp1XdfjOfdL29QEw1dFT5KAabVZ1fq/f9wScbSTX
         yh6tGrHuORm6362FO0GG+qvG5YPG504vARjLmt6NDxRqn15MJ6188WVNadnw6x+mbGG1
         pVPU9R+qYIWVgYBZi5vkZ+wmda864JY80tijPO6iUzdU626t49dLEzmh9EV3A7d2jbQt
         ptsA==
X-Gm-Message-State: ANhLgQ1QAhVu1Fp1eOonooAYpyOSOV1aBqmAw0jE6mDwcO4BAl+uT7Fr
        eg98YU9uDnN7JB+BuFSrRCJN+AyVWOagcSK532/c
X-Google-Smtp-Source: ADFU+vsixzV1y4EglCyRYDMFz+wcwbsfsTFvxWNrq3W3sPcERYd6U08Xb/S+mfm7uEWz+ITiCokD2tWovKHcicItz9U=
X-Received: by 2002:a50:e108:: with SMTP id h8mr5261802edl.196.1583532893430;
 Fri, 06 Mar 2020 14:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-6-casey@schaufler-ca.com>
In-Reply-To: <20200214234203.7086-6-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 17:14:42 -0500
Message-ID: <CAHC9VhQzSqbEh_RN3zqnhOqVMCjrKwGhyBXnYb8Du4LUq7=txQ@mail.gmail.com>
Subject: Re: [PATCH v15 05/23] net: Prepare UDS for security module stacking
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 6:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the data used in UDS SO_PEERSEC processing from a
> secid to a more general struct lsmblob. Update the
> security_socket_getpeersec_dgram() interface to use the
> lsmblob. There is a small amount of scaffolding code
> that will come out when the security_secid_to_secctx()
> code is brought in line with the lsmblob.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org
> ---
>  include/linux/security.h |  7 +++++--
>  include/net/af_unix.h    |  2 +-
>  include/net/scm.h        |  8 +++++---
>  net/ipv4/ip_sockglue.c   |  8 +++++---
>  net/unix/af_unix.c       |  6 +++---
>  security/security.c      | 18 +++++++++++++++---
>  6 files changed, 34 insertions(+), 15 deletions(-)

...

> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 17e10fba2152..59af08ca802f 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>         kgid_t                  gid;
>         struct scm_fp_list      *fp;            /* Passed files         */
>  #ifdef CONFIG_SECURITY_NETWORK
> -       u32                     secid;          /* Security ID          */
> +       struct lsmblob          lsmblob;        /* Security LSM data    */
>  #endif
>         u32                     consumed;
>  } __randomize_layout;

This might be a problem.  As it currently stands, the sk_buff.cb field
is 48 bytes; with CONFIG_SECURITY_NETWORK=n unix_skb_parms is 28 bytes
on a 64-bit system.  That leaves 20 bytes (room for 5 LSMs) assuming a
tight packing *and* that netdev doesn't swoop in and drop another few
fields in unix_skb_parms.

This may work now, and you might manage to sneak this by the netdev
crowd, but I predict problems in the future.

-- 
paul moore
www.paul-moore.com
