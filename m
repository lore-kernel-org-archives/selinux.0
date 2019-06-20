Return-Path: <SRS0=BfFT=UT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1DAC43613
	for <selinux@archiver.kernel.org>; Thu, 20 Jun 2019 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B84206BA
	for <selinux@archiver.kernel.org>; Thu, 20 Jun 2019 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H1MX5dYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFTRd1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:33:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38191 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTRd1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jun 2019 13:33:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id g4so1666895plb.5
        for <selinux@vger.kernel.org>; Thu, 20 Jun 2019 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ejsb9xT7nqTS0o41g7yLkIa9uZIzX6Xwz+a1I5H+q6I=;
        b=H1MX5dYzZA+IVjBwuX0pEJGyf4dgBIuxGzAqKfkE+fsVNBcn+FvMW7OY8SSpVwc65I
         pN8FXlrGk5Z9EFpUmVLD+e7RyikifrFlfVruXNr5mARtI2OkWKgHdQTZH/TTSRs0gkki
         MTiQREmn0s63xsCjPCBuuhBNK3OGr12yye3FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ejsb9xT7nqTS0o41g7yLkIa9uZIzX6Xwz+a1I5H+q6I=;
        b=DUn+yG+3yuf6MWBcL7NsZeWYMZP/YJXmJ+WfMtJ3eghN0fKfATBzQLA0LRz7PP+f5n
         sp4HFCR3LRVClbvrcYTlRzGsWcWM3zzgNVYAuykpMjaP1S2ETgn0duPOUAh174KMOEe5
         QHSHSV0UB7eHluPd292ipCbr6MqYId6cgZRysAGFJ9EfAOhKsGOOEgzN22S0BE9GzR8+
         D1getYXx2ujXRqmto8d9mpjOQb5kJ9dtLe4wtZ7tCMIdaSuDxpC5RMFA/DWvc4zY8QKB
         XrqZ3L4Zre0tNXk2lmUUd4NtIDayTDleRTlrl/vHLluk6nGrjXTvdBkzpRnVd8hbVvfE
         K4lw==
X-Gm-Message-State: APjAAAVuBfOddqTzFc3t/B2waTPCamMsDRZAbQZOTJbJ3x237PHUI9ap
        bFfLBoAzPV41++zeFKwuKEdLZA==
X-Google-Smtp-Source: APXvYqzZ/qgX+VooAvQpMfM1yQf1VctPwpsb+po2tTIclwXw3KEamIuAcyFOcSopHq9CEAqjAbywFw==
X-Received: by 2002:a17:902:bf08:: with SMTP id bi8mr91402087plb.189.1561052007066;
        Thu, 20 Jun 2019 10:33:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e184sm69143pfa.169.2019.06.20.10.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:33:26 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:33:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Stacked LSMs (was Re: [PATCH v2 00/25] LSM: Module stacking for
 AppArmor)
Message-ID: <201906201029.0476F14A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LRH.2.21.1906200555400.25930@namei.org>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 20, 2019 at 06:08:03AM +1000, James Morris wrote:
> We extended stacking support in March to allow Landlock and SARA to be 
> merged and have not seen anything from them since.

Salvatore and Mickaël, have you had a chance to look at the stacking
changes? I'd love to see work progress on your LSMs now that the
stacking prerequisites have landed.

Thanks!

-- 
Kees Cook
