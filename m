Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62979C04A94
	for <selinux@archiver.kernel.org>; Thu, 27 Jul 2023 19:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjG0TL6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjG0TL4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jul 2023 15:11:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D47272C
        for <selinux@vger.kernel.org>; Thu, 27 Jul 2023 12:11:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40553466a08so8295321cf.3
        for <selinux@vger.kernel.org>; Thu, 27 Jul 2023 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1690485111; x=1691089911;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ndCZRS9/qLGwGoTSb7mQojrJ45wu7yObjWDURNRfRs=;
        b=BOSHCUQMinZtc24EvosTfOT7Mqlntfp7PFeGOm6Ix/dkVh8lQtlHauPwkMMRXIenH3
         PqgQlVCvVI77a92wDf9pwrO56f85zFT40yhni8eKVt4xU+tb4zKpjbDfVGrX2hitThgM
         4agdb9gtEDTt5aQv1Jjs1tvHlV2puYLB4lDO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485111; x=1691089911;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ndCZRS9/qLGwGoTSb7mQojrJ45wu7yObjWDURNRfRs=;
        b=gbGDWw1pBP7HoDqNwkDEktEqCeQlAiI8KopIbSCQWwNefiClOaxwBGxkpPGoDQRT7W
         UFAEJKlunKFl2kTpYif6U5NYxxRAC3EMJClVB/9QolOdLyxRn0PpVUPLhC2VVJtfPZoh
         gOwN/9xU91hgJZSEuP4TC416BN1sHt4uMN5f12mjj7WBsNPHZY0RqT/KT1rX3ToiPKF/
         aI8jDQvxEJ7A45W72NaT6YmqrwLYbn2TMymM8GjFt8PXR+nsujVGCB2sDRi8O7Khflk6
         pK/W7ENDRIumYdBo9+4t0sFRF84g+4tTa7c5qpomWZ1p9JvSWbUYRnOtj42dSnP6HrwR
         /xFQ==
X-Gm-Message-State: ABy/qLYrAIIKUht412qHpt+CfAAIymG6q2f+X6cGBSfDaJnyGmynUZkg
        VgZXGmqdgekMw6712XYB2JcvWCobIAi9Z5LPse0pXWyGxf2ffnUn+E3kjAPE8mi92nf1nByRVdj
        4Q27gIs2bZ2fltp/fO0EgFb4Um+0I6ewCjFeHa8yMtdfNj5WGiLttCdHvbmXXA2zOpjzh5fdZ26
        k=
X-Google-Smtp-Source: APBJJlGo1vkvr3EDfA/t1J4AKhcTVgIeSek2gsqGijJgrAPf+s6AnRnJdRBtS1B+s+oZYGVHqAtIGA==
X-Received: by 2002:ac8:7d89:0:b0:403:b291:71bd with SMTP id c9-20020ac87d89000000b00403b29171bdmr459721qtd.13.1690485110983;
        Thu, 27 Jul 2023 12:11:50 -0700 (PDT)
Received: from ?IPV6:2601:145:c200:a0a:18fd:8997:bb9c:5cbc? ([2601:145:c200:a0a:18fd:8997:bb9c:5cbc])
        by smtp.gmail.com with ESMTPSA id ck13-20020a05622a230d00b0040549add997sm617719qtb.71.2023.07.27.12.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 12:11:50 -0700 (PDT)
Message-ID: <09e9b84d-b492-c63b-57cf-46eba7dce5fd@ieee.org>
Date:   Thu, 27 Jul 2023 15:11:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     SElinux mailing list <selinux@vger.kernel.org>,
        SELinux Reference Policy mailing list 
        <selinux-refpolicy@vger.kernel.org>
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.4.3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A new release of SETools is available:

https://github.com/SELinuxProject/setools/releases/tag/4.4.3

Changes:

* Fix compilation with Cython 3.0.0.
* Improve man pages.
* Remove neverallow options in sediff.
* Add -r option to seinfoflow to get flows into the source type.
* Reject a rule with no permissions as invalid policy.

-- 
Chris PeBenito
