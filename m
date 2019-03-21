Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74676C10F0E
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417B821917
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 22:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfCUWUM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:20:12 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:40464 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfCUWUB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 18:20:01 -0400
Received: by mail-it1-f198.google.com with SMTP id f84so404424ita.5
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 15:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AKAQL6SN5/2UzB+RkKMFpwf94T/ySCo80NExPKYq0ew=;
        b=FjSXaF5fuYT3BHsAhQnG6vLKync7czCWLmngMwhVEBYbjANUgCoPlsGTNlT0NDNJXI
         Rqs+7YDLoTtzdc0POp/MGfIA121tVhblrdspyDv1C3ZQD496EbTf3rrtEIUn4gKRUFrL
         Y82Y/1b9xgk92/1zYcbnsc/p8f10rhFGVHR72yFdngMCTDxsMQwpap7lC82ZP2MkUcz/
         vXZ5A1A49zDRgLdjwFA460ed+CW4fyisr4E+0a+ytbyN02COBkswvm93kRXymS6REY4z
         i6CqzdMzmPYCErLUq2jszk1X+eySfOYQtzpzD0TVEycufGr/Sf1OfXNWK8ockVlVQ85k
         dNpQ==
X-Gm-Message-State: APjAAAWnRwL6Zrj7W0lu64MOZc+7cQTXv7E6OtdFZ7ZW8wFIx7yESyrX
        tKWlbbs7XPMIiRASm8Dk4GJ8uhIq6g31K+6Ic5mL6P7fvlM5
X-Google-Smtp-Source: APXvYqx3k7GwJRdjT/SMXiOoTuFNSsB39ih2fS0r4d7DVE2vPLBIBHaowktbplgTLyy9kEbtt5LgmB2QMhHXzebmpathnDsb9sfH
MIME-Version: 1.0
X-Received: by 2002:a6b:8f0a:: with SMTP id r10mr4466549iod.22.1553206800656;
 Thu, 21 Mar 2019 15:20:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:20:00 -0700
In-Reply-To: <20190321185835.GC11352@kmo-pixel>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009db4840584a223b9@google.com>
Subject: Re: general protection fault in ebitmap_destroy (2)
From:   syzbot <syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        dave.hansen@intel.com, eparis@parisplace.org,
        kent.overstreet@gmail.com, linux-kernel@vger.kernel.org,
        marcelo.leitner@gmail.com, nhorman@tuxdriver.com,
        paul@paul-moore.com, peter.enderborg@sony.com, pshelar@ovn.org,
        sds@tycho.nsa.gov, selinux@vger.kernel.org, shli@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, vyasevich@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com

Tested on:

commit:         9a03b23d selinux: fix calling ebitmap_destroy() on null ptr
git tree:       http://evilpiepirate.org/git/bcachefs.git syzbot-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f8e9856965eaf03
compiler:       gcc (GCC) 9.0.0 20190115 (experimental)

Note: testing is done by a robot and is best-effort only.
