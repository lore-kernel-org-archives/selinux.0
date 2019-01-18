Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E72AC07EBF
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E117B20850
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jHguP4jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfARRRu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:17:50 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:55834 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfARRRu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 12:17:50 -0500
Received: by mail-it1-f176.google.com with SMTP id m62so7738805ith.5
        for <selinux@vger.kernel.org>; Fri, 18 Jan 2019 09:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4K8R6Q51eEdWnsPEoc47hm+xUdIWKo4UDb1MW0Y/pyg=;
        b=jHguP4jdbEhee/Iaa1EoaRThqqQci4/0PVMLcsdpMRZ3Bwyy46rCaNEgzLLh127XKD
         JzWVQYfFWjV7A0ryv8E97PeaNWH8j90dpWybUaqT1DlMnUgNRNpym7lVwcg+47ANmdRY
         ojTuY1KhiuRIevNRiolGme28Q9X6PlprIeKMSO4X2WIGWBzxO7UWat6MUGuHoDVvzTT1
         yzG1vmXVleDAEmGzSKiZT8n1QuoMLGbuPVw+n6/z5OiG/rOMH2x0hoJPsa0z7wRIofD4
         XTOLR+1s/YXqUtnBS1SKl1Mwb8y9IVblUzFWb8sPNMrBYfJcfuXrMOHqvvEv/iGKzX+6
         sYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4K8R6Q51eEdWnsPEoc47hm+xUdIWKo4UDb1MW0Y/pyg=;
        b=TA+b28LotW9TjLnQ9G3ZB8f/t7//A4FQH125t3+BP2Slf5+pQdVfS45IDAORH+shTa
         8vt+gSRzbX/u7y/GrvBbdlxEB7yhsCTxMqqTbnUwJdQY58gHsbK6S8408GxfZYlbxZR/
         lccZljC2K88fIn8rKtdqxDkU59df/fC2N0Aj20th6rO3x3jQCEyzujCdBpwYxh2wZzeh
         vIJwW81ysBlu8SoE9hLvR+vAWiJa2VbR+tw3l4rWxhgCg0VM9vKuPl8JFcVhz2MxGZIN
         FFHrzwncMGeZwsfPfrqgkILnTCrjUUYWoydQcv3z99p7caFcYPXxjirMRZjDdI/Fz5UX
         hLOA==
X-Gm-Message-State: AJcUukeoqeS7BWEv38sP98Ov6YdeAsluW+7lBhMf9fI+N5r6RlBNVlzy
        t89K4LbLHJVoJpi9UPWcLGKVlj0D/dZ5Z8KT6FYZ
X-Google-Smtp-Source: ALg8bN6Xl9IgCzpTdXPjLC8lYgLCnxVL+bJ4rR7golRJjLRuGqUBcN4q3A79Qj1Wj3P8POhh3/HIVzyV8TmKdyhLCTQ=
X-Received: by 2002:a24:67c6:: with SMTP id u189mr11444539itc.106.1547831868660;
 Fri, 18 Jan 2019 09:17:48 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com> <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net>
In-Reply-To: <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Jan 2019 12:17:37 -0500
Message-ID: <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 18, 2019 at 11:34 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> Hi, Paul!
> I don't like this. As you said, fix any calls to icmp_send is a trivial.
> But in cipso_v4_optptr, we repeating the work already done, and in cipso_v4_error
> we will need to do even more again.

Yes, this is extra overhead, but it is in an error path so I'm not
overly concerned about the performance impact on the given connection.

I will admit that it isn't an ideal solution from a LSM/NetLabel
perspective, but historically the netdev folks have not been overly
receptive to changes which negatively impact the core network stack
regardless of how important it may be for the LSMs.  If we could
modify icmp_send() so that it works regardless of the caller's
location in the stack, that would be great, I'm just not sure it would
be deemed acceptable.  I suggested the approach I did because I think
that has the best chance of getting merged.

Regardless, I would encourage you to put together a patch and post it
for review, I think that's the best way to get a response.  If you
aren't able, or aren't comfortable, submitting a patch please let me
know.

> Any code, working with IP header data on several
> levels of TCP/IP stack need to do this again and again. Is looks too overloaded!
> In my opinion, this is a problem of TCP/IP stack design, comes from standing
> compiled IP header data in different places at different stack layers.
> May be better to add some flag or pointer to struct sk_buff?
> But, I think, we need netdev developers advice for this.
> Regards, Sergey.
>
> 18.01.2019, 17:53, "Paul Moore" <paul@paul-moore.com>:
> > On Tue, Jan 15, 2019 at 2:52 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > It's been a few days now with no comments from the netdev folks, so I
> > think it's probably best to start putting together a RFC patch for
> > review/comment. Nazarov, would you like to do that? If not, that's
> > okay, just let me know.
> >
> > I'm still concerned about calling ip_options_compile() in icmp_send()
> > and I'm thinking we might be better off to add a new ip_options
> > parameter to icmp_send(); if the parameter is NULL we behave as we do
> > today, but if it is non-NULL we use the given ip_options parameter in
> > place of calling ip_options_echo(). With that change in place, we
> > would need to update cipso_v4_error() to do the extra work of calling
> > ip_options_compile() and __ip_options_echo(). There looks to be maybe
> > a dozen (or two?) existing icmp_send() callers, but it should be
> > pretty trivial to update them to pass NULL for the new parameter.
> >
> > What do you think?

-- 
paul moore
www.paul-moore.com
