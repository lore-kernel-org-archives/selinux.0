Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C66C63797
	for <selinux@archiver.kernel.org>; Mon,  6 Feb 2023 15:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBFPIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBFPId (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Feb 2023 10:08:33 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C987CC37
        for <selinux@vger.kernel.org>; Mon,  6 Feb 2023 07:08:22 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id c2so13072941qtw.5
        for <selinux@vger.kernel.org>; Mon, 06 Feb 2023 07:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7tqVFEp8KFWKd2c7CBd2KpnmW9qK2rwkTtRrZhSks0=;
        b=BU1otqkdQkkRh1V5JZ0WDmkhsTkC9wyCGG5THThWxwowzGctRFX2sLYp5kfpMd9dKL
         unExLQqVHGcGcEpN9r1KOJweDptGE7OGTQtXbDMjfMwBa4bva5Qoobc6UN+6BOZVMJYW
         tez7zsA/4Yg13K0icA2ae/HHybt9Vl585jBhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F7tqVFEp8KFWKd2c7CBd2KpnmW9qK2rwkTtRrZhSks0=;
        b=1mwaZZymg7PZAX8ab44G2DwR/4o/eN6wq92Im9ThFHhHBA7uPfZEZMqa15UHTsLRU7
         ahIMo27BYm+IgT144x4hGU/v9lSWS2QBlUhcmQQv2Es0N5ys1YL23I3MwrPTGtNIElad
         4Vs80MxN8gX59YoRlhakI1BoK09Vp2Cgmbvc/bA/rKqJukd9Q3PYvskRQGibyIck1JeO
         cKl2VX3+nAnqxv/UFsnttnhzI3yzTgUQjXvq3ne2bOJRoRem3kXmyqIFuym7Li9ExKII
         +6T84xWqsKqBx5T4vfnlI90GXt2y3DRIbwK0UDEpQV7xvohunJiFl0dr1Vk+XEmWYq6i
         iLbQ==
X-Gm-Message-State: AO0yUKW+Uco54Yi6fgCxQTZq3ezdD4lP+BeLQiAbzr/23Sc0eVMHlBGf
        bV9htHSCLdpYllL8iYl/beAChuEhik39ZdB092HbIDa2eZI57QK6snQWP1DgbgcLx8oSMjqDmGj
        6APyE5l31Igw7x2u+ZR7fSMCc8YD0L21idf2KgcklmGsdiESpWyOSNp1PZ+IBrIKXq/Swz4wAIy
        cpUfMG
X-Google-Smtp-Source: AK7set8BwSfkNnnTrh+ut/k9LYZhoz5k+1aIdymAglV2Usb7LuQkF5U0mcEtI0rUvySYYffHYTAOyw==
X-Received: by 2002:ac8:5ac2:0:b0:3b8:4e37:50ea with SMTP id d2-20020ac85ac2000000b003b84e3750eamr38070878qtd.58.1675696100285;
        Mon, 06 Feb 2023 07:08:20 -0800 (PST)
Received: from ?IPV6:2601:145:c200:a0a:3c0c:9831:4006:489c? ([2601:145:c200:a0a:3c0c:9831:4006:489c])
        by smtp.gmail.com with ESMTPSA id j6-20020ac84c86000000b003b642c7c772sm7312159qtv.71.2023.02.06.07.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 07:08:19 -0800 (PST)
Message-ID: <988e8169-e701-80c8-2b95-5fb2cc03e015@ieee.org>
Date:   Mon, 6 Feb 2023 10:08:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.4.1
Content-Language: en-US
To:     SElinux mailing list <selinux@vger.kernel.org>,
        SELinux Reference Policy mailing list 
        <selinux-refpolicy@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

An new release of SETools is available:

https://github.com/SELinuxProject/setools/releases/tag/4.4.1

Changes:

* Replace deprecated NetworkX function use in information flow and 
domain transition analysis. This function was removed in NetworkX 3.0.

* Fix bug in apol copy and cut functions when copying from a tree view.

* Fix bug with extended permission set construction when a range 
includes 0x0.

* Add sesearch -Sp option for permission subset match.

* Fix error in man page description for sesearch -ep option.

* Improve output stability in constraint, common, class, role, and user
queries.

* Updated permission map.

* Fix bug in sechecker parsing of multiline values.

* Other code cleanups not visible to users.

