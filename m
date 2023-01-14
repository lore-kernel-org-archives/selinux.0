Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A14FC46467
	for <selinux@archiver.kernel.org>; Sat, 14 Jan 2023 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjANPjN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 14 Jan 2023 10:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjANPjM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 14 Jan 2023 10:39:12 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C665A5
        for <selinux@vger.kernel.org>; Sat, 14 Jan 2023 07:39:11 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q9so16846947pgq.5
        for <selinux@vger.kernel.org>; Sat, 14 Jan 2023 07:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ksDCogpM44p1MYL9LvFyCbpk9oMtoefLtPsNaDS+1Uw=;
        b=IThA4Qp/47WBuI8os4H/m5l293jq3yndtbTSIqr6XNO4cHloGhTf4aQC+MrbVp/iCg
         uQUFidWlLHRRd+h6RcmveluRwt5NZoo2An/ZrpKUusSIBQtWwpEke2+cvnxAvRBHtHLn
         RgYxP8kmNXGdxXI3I/NGNv1AVMLLxyQB+nIQVYY65yK5WtqyLqwXo/aIyA2PTaUbJf3x
         7gB93AeEoKRWKe6ebRVReiDQucBx/ON1ULR2srNsmWevrdVVSgPuAe1wvJR5eBHrGpwe
         f0wYNYh56HFn2p+lw/2LgcxemNgqos5uyxPZZJwz8Y6x5DkpKBMS/7pS536sxtq8Yj34
         5wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksDCogpM44p1MYL9LvFyCbpk9oMtoefLtPsNaDS+1Uw=;
        b=pyXzXSL+AUxQAlkcJ2IdTqF3fFdrBkB1ncx/nV4JC1Hsh4j6mQh7hSWESN/6rK0MBg
         Uqimj3iIusd38MxT9PL8sf7s4DGIV/BnnQMoEQslTZl/mOoNsg+Ws4axGUmszSq9Ny/t
         ROyTX4r0hn1vCssoNTuxWJ4ljmq/2tXsYmgbLxVmw4uEO7B1ne46OR07ajxVAbxPxUyo
         WUDzg//wK5szyL58lktbx8k93NkX3v6NFwg+Qcfd3eS8hWf8JYKZyiCH6OhwO+buzkjF
         dqYIv1OihL7/5l5x1B08hcc2jmZPTVBtxLT3vnaQCQrX+CKjtosC8bxwVS8cjAFTbnX6
         ciLQ==
X-Gm-Message-State: AFqh2kp/uk1tVR8/1vWFGp2m62O5nwYO0/vQKLU02YTlj+Cct22S9+Ds
        ySJMhD+z4FYVfkR/IxQ58ZiYjLqLFuf9TC0lyAVc
X-Google-Smtp-Source: AMrXdXv4BoDUHdpVNEYbOge+hC2COffpE8YpFO3Rq+AKRcoghZ8QDj5/8j6P++J0htEwejt6n9QXCwzM9ZhEw+/GTlc=
X-Received: by 2002:a63:ea10:0:b0:4c7:ac8f:9e9c with SMTP id
 c16-20020a63ea10000000b004c7ac8f9e9cmr99166pgi.92.1673710750546; Sat, 14 Jan
 2023 07:39:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673666803.git.lucien.xin@gmail.com> <d19e0bd55ea5477d94567c00735b78d8da6a38cb.1673666803.git.lucien.xin@gmail.com>
In-Reply-To: <d19e0bd55ea5477d94567c00735b78d8da6a38cb.1673666803.git.lucien.xin@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 14 Jan 2023 10:38:59 -0500
Message-ID: <CAHC9VhRXd+RkHSRLUt=0HFm42xPKGsSdSkxA6EHwipDukZH_mA@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] cipso_ipv4: use iph_set_totlen in skbuff_setattr
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, davem@davemloft.net,
        kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Ilya Maximets <i.maximets@ovn.org>,
        Aaron Conole <aconole@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Mahesh Bandewar <maheshb@google.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 13, 2023 at 10:31 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> It may process IPv4 TCP GSO packets in cipso_v4_skbuff_setattr(), so
> the iph->tot_len update should use iph_set_totlen().
>
> Note that for these non GSO packets, the new iph tot_len with extra
> iph option len added may become greater than 65535, the old process
> will cast it and set iph->tot_len to it, which is a bug. In theory,
> iph options shouldn't be added for these big packets in here, a fix
> may be needed here in the future. For now this patch is only to set
> iph->tot_len to 0 when it happens.

I'm not entirely clear on the paragraph above, but we do need to be
able to set/modify the IP options in cipso_v4_skbuff_setattr() in
order to support CIPSO labeling.  I'm open to better and/or
alternative solutions compared to what we are doing now, but I can't
support a change that is a bug waiting to bite us.  My apologies if
I'm interpreting your comments incorrectly and that isn't the case
here.

> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/ipv4/cipso_ipv4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 6cd3b6c559f0..79ae7204e8ed 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2222,7 +2222,7 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
>                 memset((char *)(iph + 1) + buf_len, 0, opt_len - buf_len);
>         if (len_delta != 0) {
>                 iph->ihl = 5 + (opt_len >> 2);
> -               iph->tot_len = htons(skb->len);
> +               iph_set_totlen(iph, skb->len);
>         }
>         ip_send_check(iph);
>
> --
> 2.31.1

--
paul-moore.com
