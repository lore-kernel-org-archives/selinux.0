Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED334C433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 17:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiKGRmI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiKGRmH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 12:42:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8FF2126C
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 09:42:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o12so17765854lfq.9
        for <selinux@vger.kernel.org>; Mon, 07 Nov 2022 09:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv4wpthTSoz0JhbC1BOeQPR8cJq1C4QIHzMYVUzj27U=;
        b=DVm1ngVeWyQu6Brg/hzbmYIrsINYuurr1x0xiq76zj5l4rIyDo4wyTtMRRqf6Os6Hj
         Cs+4gu59v8OSuZfYOqSCm/mBNZPXXh0NkenGV07Y5k1X/WhdjodFSopYUmWZ2F9WuYjO
         Ocz0qbUpOqVDuGY2BAJIdxZ+FnkqkGtpcCCgNjJ7eaJ8z1VWCJX7kO46VWKVkkKCIEyk
         PTtPZBYjps0QoZSmQBzlBnjUbdLPh0HuQ4mJKJQ6baFoQVgM8vIozMY6d0Xl1VQWu0+L
         5ezPstJ/tW86LbxiQSSq2NbIKG8k15rRotGmnR8SRlVmLYc8EMDnur5SeH13aYVotfVi
         PQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hv4wpthTSoz0JhbC1BOeQPR8cJq1C4QIHzMYVUzj27U=;
        b=ZFFGOg2Tf8Iu6lccL7qpHqNOmbt56ADWFmBwsZykqQiOvNOEb/hCGBpebjWypVgg+z
         woD+mrOX8xPEFA/SjiuUD7Tv5+a+8+wgkZdpZzD8EZSEN+iqkw9EZM/ngXYkyNB+sebL
         oBLHTMFKiLJiZIpn9eeL6CGFWhCpsFayEYHQ9FC3AJ0Ruqgljq5c03vbSCXFQb9n8Raw
         eBn5MXwr0l53+7QdjFD4XyYlTzOrTSoNdbhYOcn+aINNRhnv/euPbHSYbT0baIWRhjYC
         ayAD7kKNZV8hnjGA8iIB1A03rtyoaLAGtv/TaVYUvFIxuM9W332zvW10dTSYeukrDoLz
         5GEw==
X-Gm-Message-State: ACrzQf0VPjW5z8GENHITXPevofYIGC9TAsHDsvMMAuI08dup3IXKah+L
        MpANqw3hl8HWSDmu4jzE9gq3xbXKFCa7l8zKamfecu421S0=
X-Google-Smtp-Source: AMsMyM44K7L7Uh52FuNLOQ+VC/wr7e7XCHHMEJjzGbMzONewX1ak7J/ArkimIKolcZ+xiIaUFdBWJPyKTc2pw/lzuXs=
X-Received: by 2002:a19:7704:0:b0:4a4:5d9d:2f66 with SMTP id
 s4-20020a197704000000b004a45d9d2f66mr20098362lfc.515.1667842924784; Mon, 07
 Nov 2022 09:42:04 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_De6RdEPo=x0i=Zx5bFN_4RGNfHEVpbvchEK73bAaVUFHA@mail.gmail.com>
In-Reply-To: <CAJ2a_De6RdEPo=x0i=Zx5bFN_4RGNfHEVpbvchEK73bAaVUFHA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Nov 2022 12:41:53 -0500
Message-ID: <CAP+JOzT71DxjS8hWBaZMNr1b3R5tATGs37kpuHHpsN9Leh0NaA@mail.gmail.com>
Subject: Re: Constraints of policy identifiers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 5, 2022 at 1:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> SELinux policies contain a lot of different identifiers, like users,
> roles, types, attributes, booleans, level aliases, classes and
> permissions (non-exhaustive list).  In the frontend compilers, like
> checkpolicy(8) and secilc(8), those are quite limited with regard to
> the supported character set, mainly `[A-Za-z][A-Za-z0-9-_]*`.  For the
> vast majority of policies, and in particular the Reference and Fedora
> one, this range of possible identifiers should be sufficient.  I'd
> like to discuss two shortcomings I currently see:
>
> I. Length of identifiers
>
> There seems to be no identifier length limit in checkpolicy(8) and a
> quite high one of 2048 in secilc(8).  On the other hand netfilter
> secmark supports only (whole) security contexts with a length of 256
> (NFT_SECMARK_CTX_MAXLEN), and all selinuxfs operations are limited
> around the PAGE_SIZE (4096).
>

The limit in checkpolicy is YYLMAX which is 8192.

There definitely can be no problem with setting the limit at 4096.
I think it would be reasonable to set the identifier limit to 2048 and
the max context length to 4096. That shouldn't cause any problems and
it would still limit what the fuzzer needs to check. It would probably
be reasonable to set the identifier limit even lower.
It makes me wonder how long the character string representing the
categories in a context can get with 1024 categories.

> II. Binary Policies
>
> Parsing identifiers from a binary policy, either in userspace via
> libsepol or in the kernel (see str_read()), does neither impose any
> constraints related to character set or length.  Binary policies
> should generally be trusted, especialy when loading them into the
> kernel, but this might affect future additions of SELinux namespaces
> or debugging foreign policies in userspace.
>
>
> More strict constraints of identifiers would ensure crafted
> identifiers (unicode, control characters, etc.) would be invalid and
> need no special treating in userspace or the kernel.  Also the fuzzing
> libsepol would benefit, as the fuzzer is currently limited to an
> identifier limit of 65536 to avoid OOM failures.
>
> WDYT?

From checkpolicy an identifier must be:
{letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*    { return(IDENTIFIER); }

In seilc:
symbols can be almost anything.
spec_char    [\[\]\.\@\=3D\/\*\-\_\$\%\+\-\!\|\&\^\:\~\`\#\{\}\'\<\>\?\,]
symbol        ({digit}|{alpha}|{spec_char})+

But identifiers are checked more closely
In cil_verify_name(), there is a check that the first character is a
letter, and the rest of the characters are alphanumeric, "_", "-", or
".".

I am definitely ok with stricter checking when reading in a binary policy.

Jim
