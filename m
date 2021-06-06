Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CC3C4743D
	for <selinux@archiver.kernel.org>; Sun,  6 Jun 2021 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC47460FDB
	for <selinux@archiver.kernel.org>; Sun,  6 Jun 2021 18:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFFSel (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Jun 2021 14:34:41 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:38419 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhFFSek (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Jun 2021 14:34:40 -0400
Received: by mail-pf1-f175.google.com with SMTP id z26so11417958pfj.5
        for <selinux@vger.kernel.org>; Sun, 06 Jun 2021 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=g3UnKcmrcJ0zE+YNjMOAVqbVJek3TtrsnKW2qsPbcrs=;
        b=mrG7iNLGAx0j+C+fVRd/KpX8o0HrwajvHQyU8O4kTtE2MaCwjIvyMpAcGazB2fRFaE
         +L6QpCGhKiDWqDPdKwLOhoV8uhS9xNhqIxSODI9RHdXIisvdivHY3wDmfx7egXp+QLod
         D/t1KsuXuobcuVLrTP1/Exdt+mhrgYDzhEKYcer6oS4HrgDdjkBRwIUoN9R9CYmjmEKN
         0H364L/gJJYdHyyUusSBRS9RFhGF6lYTALpW8HpnQwa5Jf+Og6ZPGRaBY5Ky+TH+/a0g
         PKXTcAtxCUpl42PUtbRA0RaZfFm9fYcWWY+t5FzPzgmoVXfT8DeF1xI8Yvjt+4ys9DHp
         J/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=g3UnKcmrcJ0zE+YNjMOAVqbVJek3TtrsnKW2qsPbcrs=;
        b=U1Tx2w5wn6rFPvlWMp3+LP+IU2sY/XH7MJhikT30GMfEqoF9ot/cT7p0TruGMdthzb
         ZBThdQ6HyrrCOmSMWTYccz9CcVi0wnBPikUPP0gmw6jvKiGwKB/bEWda+9s5nYum2gSG
         l0QNLtPZiKsMyRjhYGthwJzkiAxQWic+W9vB/4+9CK4dBcHRB3WrsRznqSAkJgVjrNoV
         qIL5jn1Ei8Xw4HgELG+0uowozPFn3p9AHozJNSpAD9ZHfXsWzO0kJv4fpyHjRF7IZy6T
         g4QZOH4qp4M3nxVhHuFBkCrXaTRkokkLfinIOQDpG4YbJQgScWMCVVRAMIkqiywYzCEp
         MahQ==
X-Gm-Message-State: AOAM533AgGwaYPxNVeo3KTMaxHoHUjEzbOZmTo1JRRVJgaNDSjD94tms
        G6vLjgK1idRmDPSFeCysoO6IQEt6TqD3O92l
X-Google-Smtp-Source: ABdhPJy9U/u5FeElpDa5N8rCp5tgvDe4aDEMfj1wfMaGK6W20jhUQmY/xtx1IUQnqEomyTUFgtYbrg==
X-Received: by 2002:a62:6581:0:b029:2ef:bcb1:c406 with SMTP id z123-20020a6265810000b02902efbcb1c406mr2805066pfb.28.1623004309958;
        Sun, 06 Jun 2021 11:31:49 -0700 (PDT)
Received: from localhost (136-24-42-138.cab.webpass.net. [136.24.42.138])
        by smtp.gmail.com with ESMTPSA id o24sm6551482pgl.55.2021.06.06.11.31.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 11:31:49 -0700 (PDT)
Date:   Sun, 6 Jun 2021 11:31:47 -0700
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Subject: SELinux IRC channel moved to Libera
Message-ID: <YL0Uk2+Zx7wInSqt@anduin.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi SELinux Community!

For those of you that are on the #selinux IRC channel, we've moved our
primary channel to Libera.Chat from Freenode. A large number of the
regulars on IRC have already found it but just wanted to post the info
here in case anyone hasn't found the new channel yet :)

IRC Link: ircs://irc.libera.chat:6697/selinux
Webchat Link: https://web.libera.chat/?channel=#selinux
More info on connecting can be found here: https://libera.chat/guides/connect
The website has more info on how to auth with SASL or CertFP for several
common IRC clients too.

I have added info on the github wiki, if you know of other places that
need to be updated still, let me know and I'll try take care of that.

And as always, please remember to keep the channel respectful and civil :)
See you all there! :)

Wkr,
Jason

