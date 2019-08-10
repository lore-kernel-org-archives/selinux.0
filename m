Return-Path: <SRS0=Dti4=WG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654FC32751
	for <selinux@archiver.kernel.org>; Sat, 10 Aug 2019 15:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579162089E
	for <selinux@archiver.kernel.org>; Sat, 10 Aug 2019 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jwoEaoab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfHJPBV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 10 Aug 2019 11:01:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36926 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfHJPBU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 10 Aug 2019 11:01:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id f17so8535157otq.4
        for <selinux@vger.kernel.org>; Sat, 10 Aug 2019 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=HUDSd7i/htayX6jqq4C7gPDtbtppJM/qR3mm2XcvGrk=;
        b=jwoEaoabGCfPXtp21c+t/l8gxWKFOLo2EoBApecNIxMmWj7qoLsSng+Fu9F2z92mH+
         F1ER6twcBJIF3Xl6jewkkv9WAXSCcplIreQlekeIOgpin5VwkKrTGWOR+ih/cZL3kkoN
         kCRRiNdvXAYh1fC+Mrqwmv+kWfzIl894uqDLM88l98kZ0twTR8EuHPULTQtQxlOFKDXa
         vAub0EM8tKlNOCF3+aVqR558CrB68BWplNVKDYtFird7s5mz+EketczIHGerYiC7pabr
         rhh0+cv/813iIrmE4cE/JKl0KKPnzd0nw7W2EsVpq6AGX6nxqrexEVepZsKMZ9idgdMb
         rSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=HUDSd7i/htayX6jqq4C7gPDtbtppJM/qR3mm2XcvGrk=;
        b=R5Oj3QX2Chc+YcTPB3UBTPbRrv054DP1k8qMTU4zMvNfx7aealsFqeTCtTpXomSfB0
         /CQXgIPl2i+hB1twsKHZUev71F6TfGQHlgOgTJq6BYVD9/dT4zqbYgkhh2xhjjmu5pDq
         Umyfqe7Mm464gW9/BIcTJUpTrCPYaBGkXQSZ+phFF07uINUY7nF94NIRts832nNRS/7i
         danoUt4hmQZt8s54ZFAIula9J+ZwpIp1kCXaZcPFQkchRT6yZ+fKq1XJiVVJmwbYgnkO
         2qljpbGHPSEjDEdh6b/QZmc5bftJWjkuY83bw1Y5vrtJt8lRmKrdCXoH6UlpOrW3fTIC
         6GmA==
X-Gm-Message-State: APjAAAVakP43u9L88LKUWjGjaJ0zZWqR1hntBcxPDvaNb1Ee7gONEiHT
        gK1XWAaukge4cFvOTDoGfYXg
X-Google-Smtp-Source: APXvYqwGMcXFAW9sQ4taXNd66lrYiKQ/0qsMbSK1KXixdKYx0pNMT6mp74AtY7lUB0WRipkqWg4o7g==
X-Received: by 2002:a5e:a90f:: with SMTP id c15mr19282643iod.41.1565449279276;
        Sat, 10 Aug 2019 08:01:19 -0700 (PDT)
Received: from [10.0.0.20] (c-68-61-65-124.hsd1.mi.comcast.net. [68.61.65.124])
        by smtp.gmail.com with ESMTPSA id r20sm5983944ioj.32.2019.08.10.08.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Aug 2019 08:01:18 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Aaron Goidel <acgoide@tycho.nsa.gov>, <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Date:   Sat, 10 Aug 2019 11:01:16 -0400
Message-ID: <16c7c0c4a60.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAOQ4uxiGNXbZ-DWeXTkNM4ySFbBbo1XOF1=3pjknsf+EjbNuOw@mail.gmail.com>
References: <20190731153443.4984-1-acgoide@tycho.nsa.gov>
 <CAHC9VhQUoDwBiLi+BiW=_Px18v3xMhhGYDD2mLdu9YZJDWw1yg@mail.gmail.com>
 <CAOQ4uxigYZunXgq0BubRFNM51Kh_g3wrtyNH77PozUX+3sM=aQ@mail.gmail.com>
 <CAHC9VhRpTuL2Lj1VFwHW4YLpx0hJVSxMnXefooHqsxpEUg6-0A@mail.gmail.com>
 <CAOQ4uxiGNXbZ-DWeXTkNM4ySFbBbo1XOF1=3pjknsf+EjbNuOw@mail.gmail.com>
User-Agent: AquaMail/1.20.0-1462 (build: 102100002)
Subject: Re: [PATCH] fanotify, inotify, dnotify, security: add security hook for fs notifications
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On August 10, 2019 6:05:27 AM Amir Goldstein <amir73il@gmail.com> wrote:

>>>> Other than Casey's comments, and ACK, I'm not seeing much commentary
>>>> on this patch so FS and LSM folks consider this your last chance - if
>>>> I don't hear any objections by the end of this week I'll plan on
>>>> merging this into selinux/next next week.
>>>
>>> Please consider it is summer time so people may be on vacation like I w=
as...
>>
>> This is one of the reasons why I was speaking to the mailing list and
>> not a particular individual :)
>
> Jan is fsnotify maintainer, so I think you should wait for an explicit AC=
K
> from Jan or just merge the hook definition and ask Jan to merge to
> fsnotify security hooks.

Aaron posted his first patch a month ago in the beginning of July and I don=
't recall seeing any comments from Jan on any of the patch revisions. I wou=
ld feel much better with an ACK/Reviewed-by from Jan, or you - which is why=
 I sent that email - but I'm not going to wait forever and I'd like to get =
this into -next soon so we can get some testing.

--
paul moore
www.paul-moore.com



