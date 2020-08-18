Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B55C433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 20:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5866E20786
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 20:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djZBv5SI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHRUKz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHRUKz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 16:10:55 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2545C061389
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 13:10:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so16115109qtn.7
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2020 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4vhBcpA9kIddPXlT9SLqED51sCfxu2oV4L3u2eLB4dk=;
        b=djZBv5SI1JUiTXwgqAFUBQhMsK4YbX+sQYdJ8C1oQD9BNlZjN1I3Gr3bDHH4c8Lq8E
         3bTfnWHheleztSJKCCy3X0gkKc7wHbc5/grFv9aMXB5JmDDw5jqs1LqEtEgzdIbI6961
         LFMUebRP/3ZK2ZUMzUFdkbc2MDKZ1g4ZQHWkVDfsZdlGVjkChHmorYwXFQcA61IItOSP
         zSmcebSczfZ3dR+WUp6IO9f8wegkkNj5qa+hStNEN/s4JWhekK+hpfI9ggcytPoCwfi9
         EYecHaYG15F/xiViVb29Irdok2eNGyBYEsw7iHy+TN1f/ekBAqEBzzyjEwypm5hdI+YR
         EqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4vhBcpA9kIddPXlT9SLqED51sCfxu2oV4L3u2eLB4dk=;
        b=LEbQSA+V/K1RtJxJD5DTz9/DgCia0QbLY78Ynmb7AOKM+rO+yGDFtH18A4pdG2w8h8
         /+WZNcEnXc2Wlmoh/GTpBBpcTNBh7MrV1BsbMmD7tYWJjMIK8ke44KvFPI2ldKzzYo2d
         RwRhnawUFBpo1RPVH5cJmBlgrOO/umvcz4LbGYiJhuOtCh6vCt1SHLs3H/2UskOVhgG1
         fmQUaM4JQRPlBhv3bpxdGZtd7HoAC2HJ3w+/Tt3zG9Jh0IF757AH1z08P2olDgo9+/Ej
         FM27Au2pODQXssaZZlvxSFpZtDVfmf76TUiJwxC4oKuMfv/Fo5AtWWe+pSqz4+gBfgNK
         cIUA==
X-Gm-Message-State: AOAM5313dATrYzvgyxmufgNobFr3sCTOyDju5wb3y2T/q5xQzz/y+tax
        GMgJywhEz2ZIrOe1srIV7Do=
X-Google-Smtp-Source: ABdhPJxvc4CdZx8ol41aYxh2NluoxwzKNOAmBp3zEaxYIkb8IWSysaSO7MnBNHA+Rlmf+9FGRzxBnw==
X-Received: by 2002:ac8:7405:: with SMTP id p5mr19554677qtq.308.1597781454101;
        Tue, 18 Aug 2020 13:10:54 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id p202sm21396001qke.97.2020.08.18.13.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 13:10:53 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: convert policy read-write lock to RCU
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        peter.enderborg@sony.com
References: <20200818194311.30018-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <0ada515b-803e-7718-78a4-8d216f779b00@gmail.com>
Date:   Tue, 18 Aug 2020 16:10:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818194311.30018-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/18/20 3:43 PM, Stephen Smalley wrote:

> Convert the policy read-write lock to RCU.  This is significantly
> simplified by the earlier work to encapsulate the policy data
> structures and refactor the policy load and boolean setting logic.
>
> Since the latest_granting sequence number is no longer read/written
> under the policy rwlock, convert it to an atomic_t counter. Alternatively
> it could be left as a u32, moved into the selinux_policy structure, and
> updated atomically upon the pointer update.  At that point struct
> selinux_ss would contain nothing but a pointer to struct selinux_policy
> and we could drop selinux_ss altogether?  If we leave it as an atomic_t,
> possibly it should be atomic_long_t instead to reduce likelihood of
> overflow.
>
> At present this change merely passes a hardcoded 1 to
> rcu_dereference_check() in the cases where we know we do not need to
> take rcu_read_lock(), with the preceding comment explaining why.
> Alternatively we could pass fsi->mutex down from selinuxfs and
> apply a lockdep check on it instead.
>
> We have to hand off the actual freeing of the policy data structure
> to a worker thread instead of doing it directly from the rcu callback
> because the avtab and certain other structures may be allocated/freed
> via vmalloc/vfree and vfree isn't permitted from rcu callback. I previously
> used this approach in the selinuxns series for freeing the selinux
> namespace, and it is based on the approach used for user namespaces
> in mainline.
>
> This change does not specifically do anything special with respect
> to the sidtab live convert; I am unclear as to whether it is safe
> as a result.  Comments welcome.
>
> Based in part on earlier attempts to convert the policy rwlock
> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
>
> [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
> [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Looking through the RCU documentation again, it occurs to me that this 
would be simpler if I just called synchronize_rcu() after updating the 
policy pointer and then freed things directly rather than from rcu 
callback? I took the call_rcu() approach in this patch because that is 
what KaiGai did and what was done in the AVC but it seems like 
synchronize_rcu() is preferred when possible.


