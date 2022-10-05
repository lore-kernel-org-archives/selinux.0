Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F3C433FE
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiJEUpA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJEUo7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 16:44:59 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F32D76F
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 13:44:57 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-131dda37dddso87318fac.0
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=HxKDra6grJcWD9CqHYMkRMp+vE+Qyi1aeN+LauRdjq4=;
        b=u+3ecqY1nx8e0ZshkkP0b2uySRbILkUIxFh5s8rISRBxLuj+MR/2ZUi8TOHp5CF/Tr
         WPR4yfgljwIagRkXG/TsSYmI0tpFdS/hmQ5YMPdpFd3uuF/XG9J05L5Noy3meoMir+L3
         uG76c/pzEEv9RHioeJu4MpzaFUKCX1ZOAHBlXVO+Tld09SRP/dczI+R7dPni7/MjQMuA
         qaDOF1yTATVwCXHaxCt1o3W2y8Go/aAPcYRvIdp4IXubdf66GBxsYbiMgQeuklJVpCJJ
         ereRKliPGfQX3ack9O5tbzUb4nRdq3o+pRpzhhqY5A0V7RWzWPaqQrjgPv/aHOVcCceP
         hkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=HxKDra6grJcWD9CqHYMkRMp+vE+Qyi1aeN+LauRdjq4=;
        b=gpppp6KjxRyTI0/HGR/cYE8Zd0aAye0uUKkO3z+XYWI3UuvImRZT33WCKEB7eRL36l
         sYWguDXQVuKvtVdL9bgxBT86AD+An6R4vSxV2LysWCcB9kGxLJ9qQ63ZgCtVuJ6YzclA
         HzYSENJ7tEZKmf4mz1laZEM/NhC2JfS/ENaCiDAz6ZQ/uwvh9LMh14Xr5FLK6oJtcnYd
         tXOXcIPs7OCEI/2ZLIDH5lfvxNch5Ipo58+Hq64P6BVh82XeLQqr8x7+PszplRecfjqI
         67VUxw8vYKHq36fQYIgkFp0i1dx5yC1ptdoUrN+YAOhrHhNAgZftudMjJlKWUlK31ih2
         zjbQ==
X-Gm-Message-State: ACrzQf1VqK0icMw/b+qCSk7jNkdd/GyZDtJQIT4nMmyLsnPE0F8o34MS
        SB4ae5uGqdLQzr6eIhLbh2+6UWaaRgBRXU35BsNX
X-Google-Smtp-Source: AMsMyM7oCOUKqnFgeWu0J+edPTN5UWcgccxor+gfSCZhi7qgSbllRBCRaxT4WOKCYdwJzSmzf1A0EjK3mntCtiWcFB0=
X-Received: by 2002:a05:6870:a916:b0:131:9361:116a with SMTP id
 eq22-20020a056870a91600b001319361116amr812898oab.172.1665002696779; Wed, 05
 Oct 2022 13:44:56 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 16:44:46 -0400
Message-ID: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
Subject: SO_PEERSEC protections in sk_getsockopt()?
To:     Martin KaFai Lau <martin.lau@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Martin,

In commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
sockptr_t argument") I see you wrapped the getsockopt value/len
pointers with sockptr_t and in the SO_PEERSEC case you pass the
sockptr_t:user field to avoid having to update the LSM hook and
implementations.  I think that's fine, especially as you note that
eBPF does not support fetching the SO_PEERSEC information, but I think
it would be good to harden this case to prevent someone from calling
sk_getsockopt(SO_PEERSEC) with kernel pointers.  What do you think of
something like this?

  static int sk_getsockopt(...)
  {
    /* ... */
    case SO_PEERSEC:
      if (optval.is_kernel || optlen.is_kernel)
        return -EINVAL;
      return security_socket_getpeersec_stream(...);
    /* ... */
  }

-- 
paul-moore.com
