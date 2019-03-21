Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A5C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 18:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3508421873
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 18:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoyIse7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfCUS6k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:58:40 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:41511 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfCUS6k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 14:58:40 -0400
Received: by mail-qt1-f176.google.com with SMTP id w30so7851008qta.8;
        Thu, 21 Mar 2019 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/GDD/OMCau4AxuR5efEHRPbc33K77RNu6ejyQq1921w=;
        b=DoyIse7zoWRde++g1gTGilp6nVJXJRgwHFcyd0n8wMky0zu6ReIltjOfEYndx8ichs
         AULn+XntxO5AvAdWWpbAV921KUu6547JAcQkGHz3kB4ojsQRg51iMwnjYo1/0gmCm/6o
         8O2Uv8pUxIxwBfUl2V0N3EWSharK4PuAFXNdVqEHSvw00J9cglF79mpnMdejl7ZQbuMt
         U4ZA2Zbt5kNVkpOX92KieTiNLNSPAo4M/cjnp78o/ly5p5u/6bNzws3NbZmmrHSjHYah
         nwqrHzc6CZW9noFreFKOfdGgKq0XOGmuHRR838sNtAbzxXzfyKgC0YEtRh3jjfHc4eEv
         mMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/GDD/OMCau4AxuR5efEHRPbc33K77RNu6ejyQq1921w=;
        b=biC2iO6tCBDkE7Inqp87hg7ZdIZ30AEGHth6VGX+NZGebp7TBhjDRcZsIQFWA5wZL1
         XLVcWcAj1hRLxFu8cC1s9S/aFQ/beB5g44TC+lI4AUm/PZ2LnL5UmGtJUoGk4aj6tx+Z
         iZej+81NoXQR2QZMehtuJUgKTFQ4+strWWwy9PpK5eIOP/XAa3zuDf82K4Py1qHX82EZ
         LWRzahTGpKdAPAAgaAfID4klOJlJqSPSM2fj47rQ/0PgTbTOUJLsFAF7MhcqBAFChyC/
         W7hrhDAvqpRGB4kudU+RClmnsU/+SY2xKjbEOm92hhnpY+IetOhmQTsL7kdcCSFRv1B7
         yGfQ==
X-Gm-Message-State: APjAAAVxP7URHBuH9T1YXaxDeQq0f1ClqOm2Wk6LBhGabvBVIbj9tU06
        4k0vA70ST7+RnxnSpE8Wzg==
X-Google-Smtp-Source: APXvYqypG0e3zQpIaoUmI58OIMAEIvyB+C85b8VbCAHKLvlyeIYmAHRSyFGQfPdB3iZ9AdBIHUt5Gw==
X-Received: by 2002:a0c:e706:: with SMTP id d6mr4435735qvn.141.1553194719146;
        Thu, 21 Mar 2019 11:58:39 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id g5sm3147695qke.71.2019.03.21.11.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 11:58:38 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:58:35 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     syzbot <syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        dave.hansen@intel.com, eparis@parisplace.org,
        linux-kernel@vger.kernel.org, marcelo.leitner@gmail.com,
        nhorman@tuxdriver.com, paul@paul-moore.com,
        peter.enderborg@sony.com, pshelar@ovn.org, sds@tycho.nsa.gov,
        selinux@vger.kernel.org, shli@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, vyasevich@gmail.com, willy@infradead.org
Subject: Re: general protection fault in ebitmap_destroy (2)
Message-ID: <20190321185835.GC11352@kmo-pixel>
References: <0000000000006294c30584141805@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006294c30584141805@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

#syz test: http://evilpiepirate.org/git/bcachefs.git syzbot-fix
