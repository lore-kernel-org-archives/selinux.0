Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC82C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 18:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E55021707
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 18:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkI74L+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2SCd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SCd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 14:02:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF1EC03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 11:02:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g19so2504853otk.5
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+cxaD/k6SmMnIv1Slpsl6IiBi4a+90EIKzUlwAp1k1o=;
        b=NkI74L+zJnWOLQtUhUluob6XN9sCwDoMSLaLKt7lAL7JkAP+Lg1x8UwnupT2EVrmL0
         JMhKhoDQELQVdrW/CmYeWzEOZMPNB2bbUIE0wJ4CN/RA8LkLorMF/s3qh37HpNc/Njrk
         snr3rw78V6TiTJurIXmHzd8ue1+q6dRVYnCsQ8bseASmxxY4DSefBaukyOtN8oJWdZj/
         Jbj4yfwyPg1wcoXeq41flNFx8020/h5otDnOGYuLZD1oKLiX2soye4JHUATQ04YnKnPJ
         BDwzopfDe4peKpw7Mi1nOiSPVEo1Zb014TGm45EBRbVqtdSOXKtmgSKX1ng4WZbBB7xy
         zIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+cxaD/k6SmMnIv1Slpsl6IiBi4a+90EIKzUlwAp1k1o=;
        b=cwF21AmlAmt7Kz6GTmDkCU6sIUQdnZbKcVi4QqHFBrC8BkdKunxEOAgdNyDr9C7nv/
         9Y9t16qDEPRn4KTTE37pd7i+Plnms0XhFis4vE5DfDhBeCMNSmArwFVY9hacEJ9Ibhwx
         RAc6faO0TfCnO/R5HGIk5gmUVU4gqhbvGYTl3Re47gBM0XIXCVNsh2NDXcntHt70o1QI
         gtKfwkeTVrypl355lDDa3A3X2dhdzql9vchcQK6eij38m74VQvas1i3mprtLgG+Ei5q6
         iwqhq6HWPpdw4rUrU2wzCRcQBUVDLncIVVNSfFilGn3eQviydP8awLtYyfxFdGXtn+XJ
         JP/g==
X-Gm-Message-State: AGi0PuYRHSDSAC3QjQxVQE7SQT7n9X07JIYeQ98bBEw/ICtKtwq9KlEI
        2EuiwK47NhXwzPBG+cv2ASw=
X-Google-Smtp-Source: APiQypIpNocKFyAC3K3MjZrYn9swSq1zlATXajfieCurptDKIUUXsaCxRpJcIuIJTULJPqlnhfWZlg==
X-Received: by 2002:a05:6830:19f8:: with SMTP id t24mr25797560ott.326.1588183352031;
        Wed, 29 Apr 2020 11:02:32 -0700 (PDT)
Received: from ian.penurio.us ([2605:6000:8c8b:a4fa:222:4dff:fe4f:c7ed])
        by smtp.gmail.com with ESMTPSA id a93sm511407otc.12.2020.04.29.11.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 11:02:31 -0700 (PDT)
Subject: Re: Daemon cannot execute python
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
 <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
From:   Ian Pilcher <arequipeno@gmail.com>
Message-ID: <1ddd7c0a-5903-6c4c-595a-bee00ebe7779@gmail.com>
Date:   Wed, 29 Apr 2020 13:02:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/29/20 11:47 AM, Stephen Smalley wrote:
> Sounds similar to
> https://lore.kernel.org/selinux/23A084A9-66A1-4E02-A766-F9214E63A628@nall.com/,
> which may be due to a kernel change outside SELinux as per that thread.

Yes.  That's exactly it.

> It is logically correct since the new domain is executing from the interpreter.

Indeed.  I was quite puzzled about how it ever worked.

> You can reduce the scope by defining and assigning a specific type to
> /usr/bin/python2.7
> but obviously that will have a rippling impact on the rest of the policy.

That would undoubtedly be painful!  For now, I've modified my systemd
service file to make a copy of the Python executable with the required
context, i.e.:

   [Service]
   Type=simple
   PrivateTmp=true
   ExecStartPre=/usr/bin/cp /usr/bin/python2 /tmp/python.denatc
   ExecStartPre=/usr/bin/chcon -t denatc_exec_t /tmp/python.denatc
   ExecStart=/tmp/python.denatc /usr/local/bin/denatc -d
   ExecStartPost=/usr/bin/rm /tmp/python.denatc

Thanks!

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================
