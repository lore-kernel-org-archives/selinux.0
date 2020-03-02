Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79AC3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A972173E
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 16:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBI/WTbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCBQiD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:38:03 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43914 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgCBQiD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 11:38:03 -0500
Received: by mail-wr1-f54.google.com with SMTP id e10so493663wrr.10
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=F02R+1y+ua8RXzaGX7q8MjfAouUr5fssET3NHnJzaSg=;
        b=SBI/WTbkf0I7/8tYr7nF3kC5f06r7OvFOxIJsnsBC2mHLU8gfMfX0Ysslmj1+1D+HL
         cSKA8XgTn81tZjshebHCm4lT65Vps8jdmTN+/CEBts25VDzik6xW6K2ObzEYoEhR17ma
         eJ/GYBJvXs6iuqd5sU8rY8gbV2ACawpZz1g9KuJsn79w4TYHrfNUzUsD28SyfG3Nsp7X
         t/ItlDqgUKMCv/vKDdNl0S1z4Wz7WFMcSIekrBSZzw/2YiD483Q7Ez/yt7V8YosyJOZC
         MTSko/Sh96uxurD0UOQQXELktWa92gY2POYV+7KKoRCCKrd8YC/+2rFM1WcqFDykpVft
         o/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=F02R+1y+ua8RXzaGX7q8MjfAouUr5fssET3NHnJzaSg=;
        b=k0YdJJkdjLeEket7nodbFbuZt2+OFNnG7+54Svl4oksjgITW6EBbtmeGzq8XkDZRNt
         WBqux5nfNHQQK1MceKMYNHlLPFDrrK/nL9XAHtfVFCDiuXAPJ7sRKg9mTmfaLgreKXBw
         xY27Mr3wG9ewi2M0tLWYssj9szuvRIm1EUsv78ebAa5kklzAhEOm9UiYfVHwXUZEgQRs
         Evs/1C8fCMw9OXpf4+a/ALoQTpixaYdWtZDMcSdTy/fJiFZBls3TO58YF7rVuZIaiTrS
         Cj0xRvTAO99MBW1lg6Gbno2ofR559PP65sEwtqWTZSGJeyOoWUJprbbWrbx5quKPGbIk
         eIVA==
X-Gm-Message-State: ANhLgQ2GX9w3w1GVDu/YkInynJsU7R07R0+vuyTLvW4qDTFP+zb1hEy9
        CFMbYCCK1mmZU+1GH+y151YYSnzf
X-Google-Smtp-Source: ADFU+vsLFYFF3m8QDDF0gQXnUOPBwmVOMReL9CquoosbV4ouA4G/eD0rYLO8J1GHFpb3ToXfNzhm5Q==
X-Received: by 2002:adf:ffc1:: with SMTP id x1mr417669wrs.3.1583167080125;
        Mon, 02 Mar 2020 08:38:00 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id f16sm19706772wrx.25.2020.03.02.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 08:37:59 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: target context of security:setbool permission check
References: <CAJ2a_DdmVfru8dcuEqeQkceVv_UskSYBw=qickHG6SOCEAbPsA@mail.gmail.com>
Date:   Mon, 02 Mar 2020 17:37:57 +0100
In-Reply-To: <CAJ2a_DdmVfru8dcuEqeQkceVv_UskSYBw=qickHG6SOCEAbPsA@mail.gmail.com>
        ("Christian \=\?utf-8\?Q\?G\=C3\=B6ttsche\=22's\?\= message of "Mon, 2 Mar 2020
 16:44:36 +0100")
Message-ID: <87mu8ybtlm.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Hi,
>
> currently the target context of the security:setbool permission check
> is hardcoded to the security-initial-sid.[1][2]
> Nowadays it is possible to label the boolean pseudo files via genfscon.
>
> Is this by design or did nobody yet make it possible to base the check
> on the actual file-context?
>
> Or is the current access limitation to booleans via the file:write
> permission to the boolean pseudo-files sufficient?

From my experience blocking write access to the bool file is sufficient

>
>
> [1]: https://github.com/torvalds/linux/blob/b1dba2473114588be3df916bf629a=
61bdcc83737/security/selinux/selinuxfs.c#L1234
> [2]: https://github.com/torvalds/linux/blob/b1dba2473114588be3df916bf629a=
61bdcc83737/security/selinux/selinuxfs.c#L1290

--=20
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift
