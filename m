Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D803C001DB
	for <selinux@archiver.kernel.org>; Tue, 15 Aug 2023 02:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjHOCwQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 22:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjHOCvr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 22:51:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5682114
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 19:51:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so4151603a91.0
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 19:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1692067906; x=1692672706;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eTjcw/8D2nvgNEovPDNAunkGW/khAzoCSkLLfHBnfS0=;
        b=HCsHDAQuu5iQ/sMCKP7jU05AWhLBspoIvhFH9fEcxPrXrQEJDMutaQtWVDARkbPMqh
         4sXdCIJOeIbw2u9OVGDKaIWf+m4RJsg5Uzxh477YzO2gW+9qo6YpfNKM949kPZPGtz4b
         ao1b4CB3Ahhpe00NRRIIzog8VdTYKd9uoBTuHP+sWge5P1mhn8dX89wRzZhDGtcvxObT
         yJsb7PhjHxos6elXpx7xtrJfCPDgQ9uiwYXuWFOFNX+T9NU6exLmHAIS8za6MDYK2IUT
         ckZ4kA84bh+nV/Cr/DfJYv0dZaiCW2H750ji0LOJgUl642ZGcQh9XFiygsEHJbgiN+ee
         tpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692067906; x=1692672706;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTjcw/8D2nvgNEovPDNAunkGW/khAzoCSkLLfHBnfS0=;
        b=G+W/xrl7Tg8d31PUdapNqyvTPb7VQO2gwy7vu1s7riueEdhLSMQizDUw6whM3Q4+VT
         9WNFcqIvXcVZpeXv5syFfLBXceCbS1/37uCzxAkIHUAA5zFM2eRRprrtaaNusFQR+fXb
         prJOQSdgBX4bRWfnBeqrk+PC0vXg/uTZP6p4gDZrR7717xuSOiX9/iR+yFjHXUQHAmAr
         OEHjWYcAl4RtW0vlqo91wCPpFs6zzy8NHSDW1KApIS8cbmZQaFeXJJT6V8qNN/LpTp3w
         1fSaLrlySg9afI2MIGxD2LmgLFMHWNGA440gFLuPxmWB1kSDGeDmzkf3LDD8TRkpQ2/L
         Ae0w==
X-Gm-Message-State: AOJu0YwAzdCI0Kqztqa1SM2EElqq+2BQQn4sg4eMgSaF6uVVOZHIpRHf
        0lvpFPbp95+qoUE7VQ32TprNhq3epAdrNIWrW2MsOzabNTSZxanCZDY=
X-Google-Smtp-Source: AGHT+IGeJr/BZZrbP3XCdI89anr8FS03YGwnsZiw4cAODKWOLTO/G3oQg4gr5MYvG6g4ouYiInJKru8yl3SUlvZER6o=
X-Received: by 2002:a17:90a:9485:b0:268:4498:ad68 with SMTP id
 s5-20020a17090a948500b002684498ad68mr991495pjo.19.1692067906011; Mon, 14 Aug
 2023 19:51:46 -0700 (PDT)
MIME-Version: 1.0
From:   Alan Ma <alanma@gwmail.gwu.edu>
Date:   Mon, 14 Aug 2023 22:51:27 -0400
Message-ID: <CACzUrp4own2mQpHtcpsRgWH6LbJOginxMWqcbZRRrh1AGF5MNg@mail.gmail.com>
Subject: AWS RHEL Image / SplunkWeb / SELinux
To:     selinux@vger.kernel.org, stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello SELinux experts,

I have one odd RHEL 8 AWS host that refuses to allow me to run on port
8000 for Splunk to run it's Web application when SElinux is enforcing
or permissive. I have another host with the same AMI and VLAN that
works flawlessly.

I have reviewed all Splunk, and Firewalld configurations.

The host is not throwing any deny or errors in var/log/audit or /messages.

The only time SplunkWeb loads is when SELinux is disabled.

The browser will throw an error when SELinux is enabled.

I suspect this maybe a bug as Splunk and SELinux had a known
compatibility issue almost 20 years ago.

However, those old fixes no longer work.

I appreciate and look forward to everyone's response. Thank you in advance.


-- 
Very Respectfully,

Alan Ma
(703) 609-5617
George Washington University
Executive Masters Information Systems Technology
CIO University Certificate
