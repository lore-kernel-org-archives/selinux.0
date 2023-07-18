Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083FCEB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGRWC1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGRWB4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:56 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBDD1FF6
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:30 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4039f7e1d3aso50546921cf.0
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717689; x=1692309689;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbnlGsxyxSPT53z8AvSahZZVuaqRwE/5/RY1mx0XV3U=;
        b=dxfo7k0ShfODOvc1LMGi2GhhOlc40dkJm/0iSfwwzsqI2crweOjOlZm0BdcwX63ncO
         Vo+oRwQQAUcIuf2X+J6WuvULXlVlmfY2/pdV7DkVj4wS2i+g+VigiI3WAF+jmdzQCysa
         kUpvQFbMHkJ9O5tHLscyTDw3+vyggnbCqcUMMtWlCviReklTU3h0zx6FIK8OhHaRVRxU
         dvq3D/6TkWGtHjdvJxUPPGHwBXuW74K5cNM0GKYM+PRfjfm3UBpfc8FSJG6MiZJ0DdDZ
         01YtWeystBAY+zKtzpa9iCW8yBPfDFHtEw6Sz3vLobGGfEDRWVuyKW+cHwPL60U7EmZm
         zduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717689; x=1692309689;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbnlGsxyxSPT53z8AvSahZZVuaqRwE/5/RY1mx0XV3U=;
        b=eC77IhwebhPcvgVOCk52ormi2sraBjL21H1qtj8tihuqX/SFnCH94fREmNSciWZcJH
         q350nF2rtlMxwq+jgXlWjavWezG04UW9UCjHQXdbmQAHQ16YHwodlt7YYd+s5TCItnKr
         5XcWxo7HtWL/5b+IerFiBCRjyLHkp571WpfMUam1rNy0OD+1l7qzJwTnoyqKb7uxyckW
         fFAN8sjnIP71eWGkDRrKVKr4sMvTi2LfWbaldCAal2CxqplnbK73SFwTPG5l2cjhMVgB
         oWV3hRhq2/1TSH1xDkHQtPRT3iXZcWKLnbv9+Wr0M8w0kYKqTBdS5RFcjsVWn+Nfdmon
         0VvQ==
X-Gm-Message-State: ABy/qLaRs8/JERxxJWURHazIuBileHjLMFjOI9HWlezO9EFBH7hEVLaG
        scuavcL4ftx+G5EqM0Y5ghuLoXxKtT1ccyAfug==
X-Google-Smtp-Source: APBJJlFkW+yhcw5ylGow/CbTw0mSkaS+eN+VAZvgCsFAbr1u8TvxpY5Q2HMXr34JCpqgNW1lABFBPA==
X-Received: by 2002:ac8:5e0d:0:b0:403:3b39:45a0 with SMTP id h13-20020ac85e0d000000b004033b3945a0mr24971831qtx.33.1689717689286;
        Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l24-20020ac81498000000b003fdebf1a634sm910209qtj.75.2023.07.18.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:28 -0400
Message-ID: <ed0f1aaa999340e2e9ee34aa7a60754f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 18/20] selinux: nlmsgtab: implicit conversion
References: <20230706132337.15924-18-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-18-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use an unsigned type as loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/nlmsgtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Loop iterators ...

--
paul-moore.com
