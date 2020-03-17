Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DB1C1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 22:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1403720714
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584483162;
	bh=GtO3h5LfPzZi/9AqSF52rEVhhdDidm949zcOUZxWt3o=;
	h=Date:From:To:Subject:List-ID:From;
	b=FO2qF5T9dJsNSDRGkbZzlbIHv5clFKcMShNpJ+dY9P9Z4av5BDqNHtlXaNXHFYqM7
	 meKGTvwYR/9vg5VDFdC/2O2FmPsfpin1tmCgeJX4kVAmk4aesT1hpyXz7ZwprfMSyD
	 4CW530utFO0pSsthSxrwt0mcUTkWqfROY9iTM22Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgCQWMl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:12:41 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38973 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCQWMl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 18:12:41 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so7804807qvf.6
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=caW/QunyOk5mz+Kj+0iK5Gu+F5vdx65w78WqgIIoRGs=;
        b=NuDiiRGlB+87QHwaMIgJg9eyLpOixJ2WaGpRxFZGtgGYkyEft+pmUoTDt2KsxS72tz
         b1hBwRAi/w74k+TYO2UhtPGPSVVsSpGCzP5PwnVZZ/9JxYPzDIkpnDkA0aWlER3U68ZT
         mF+OHmosPGjqfPeqGcQ5uuZ/dBUnhueRMRhYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=caW/QunyOk5mz+Kj+0iK5Gu+F5vdx65w78WqgIIoRGs=;
        b=O1dSA6sgaf6AodDv+u5PeYUvOmNW9lq6d5K0B/KVsHEZKKT1viiAumISGtkwXLBsp/
         z4gpY2EBIt8wPwdLnBVgry+JGfbHOLW4Omf2pJVt97k0IRqU4u3iq+XkyhUe10pL5zkM
         dxWyPql6zmrS8kIpAcshokU1YkPKpOz9xmiMaFtamsUfzlH8HTdz/11DqRzqoqFVvimK
         bxiIoad+kwKRO7RS/mwn6E50cpHAB//bd2cqAw/Qs3Kvi2TOnV1FtLlJIVrU7N+57Ix/
         xDAmNiPGfZlbuF/zORi16OnYt6c39+SRjdzu9hcuXbQ9IffLKa3bVrbiNcXNw1hWH5wx
         rieg==
X-Gm-Message-State: ANhLgQ3UQhzc16JV4xKLm1i5gQDBjhsaR+GMKfdDEnBIwlkas06bb9wO
        aiYmnDfteVMqZhPDyiEYpCuTmlxZMfjzgA==
X-Google-Smtp-Source: ADFU+vtcWcPfvZd0LKb+DqBWIj5SY4MxYU6czzWZPfyp2YnBtOhAuw8p+/9tIB3AHZL28DAoWNTrAw==
X-Received: by 2002:ad4:44a7:: with SMTP id n7mr1319359qvt.152.1584483160046;
        Tue, 17 Mar 2020 15:12:40 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id f21sm3284873qtc.97.2020.03.17.15.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 15:12:39 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:12:37 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     selinux@vger.kernel.org, linux-audit@vger.kernel.org
Subject: Looking for help testing patch attestation
Message-ID: <20200317221237.vrkru2kdc63zq3vi@chatter.i7.local>
Mail-Followup-To: selinux@vger.kernel.org, linux-audit@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello, all:

I'm reaching out to you because you're a security-oriented mailing list 
and would likely be among the folks most interested in end-to-end 
cryptographic patch attestation features -- or, at least, you're likely 
to be least indifferent about it. :)

In brief:

- the mechanism I propose uses an external mailing list for attestation 
  data, so list subscribers will see no changes to the mailing list 
  traffic at all (no proliferation of pgp signatures, extra junky 
  messages, etc)
- attestation can be submitted after the fact for patches/series that 
  were already sent to the list, so a maintainer can ask for attestation 
  to be provided post-fact before they apply the series to their git 
  tree
- a single attestation document is generated per series (or, in fact, 
  any collection of patches)

For technical details of the proposed scheme, please see the following 
LWN article:
https://lwn.net/Articles/813646/

The proposal is still experimental and requires more real-life testing 
before I feel comfortable inviting wider participation. This is why I am 
approaching individual lists that are likely to show interest in this 
idea.

If you are interested in participating, all you need to do is to install 
the "b4" tool and start submitting and checking patch attestation.  
Please see the following post for details:

https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

With any feedback, please email the tools@linux.kernel.org list in order 
to minimize off-topic conversations on this list.

Thanks in advance,
-- 
Konstantin Ryabitsev
The Linux Foundation
