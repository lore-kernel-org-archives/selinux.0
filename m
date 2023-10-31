Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C035C4332F
	for <selinux@archiver.kernel.org>; Tue, 31 Oct 2023 06:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjJaGNP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Oct 2023 02:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbjJaGNO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Oct 2023 02:13:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F712A
        for <selinux@vger.kernel.org>; Mon, 30 Oct 2023 23:13:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso8567840a12.2
        for <selinux@vger.kernel.org>; Mon, 30 Oct 2023 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698732789; x=1699337589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GgoxWh+3mFmu9qGS5n4klAc9TWzAx3QMY9929RDoymk=;
        b=fxMnBbrnp1Sbak7YSMus263BayDnXXpjuTt19N/2e/PKT1YmRI3z33TlW/U1gV4eMd
         PQgTsQhNgM8TYnKAV/W/oCtG2Ow05+NtPGX4wZ+LU/FT9y5Xv54dkoX0GQCL8HIAbMXb
         uudS7+yBAi2vGGagroc0T7CmNVRC8hph2jMOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732789; x=1699337589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgoxWh+3mFmu9qGS5n4klAc9TWzAx3QMY9929RDoymk=;
        b=WBbcDmj0aNS87s6aNIqqs/vNsSzNPju/xaBAG/0ON6A/ECNQ6t7DoF3JsSFGF1f6ac
         5hRtmS0S/8WfX3bhoHIsOhQvo2ABdM9TPEbiruFadh6eAAY9+8L0PpE5ty6fo7wLNnHv
         fwZKdpGKMPlm3EEBjSMxQCOb4c0yYPc+tZOEZLTDAaIBseAilNWWJuromX20HE4NHzQX
         TKUVuh1qNf2Uu3uh78v0ThMSkhLf0S2RGAmQqqJclss9KnucGb/94iRJ4bzS7kOfDEIt
         NqcBFV1xZ6qx34wJMMDIxVnZDHobm8ax/AXDdygACWVcJdSfC1+O1O+dXQJBhYwXm9OR
         brsQ==
X-Gm-Message-State: AOJu0Ywk/IQi+jayDN3atZvcN9GkmlRQjKM+sQx4iQ/bS3x+AJv3bljC
        1gfUbpVtuUkQFmU+BVE0dP+h/toK3rxNHPxkDuvyy/x2
X-Google-Smtp-Source: AGHT+IG/DJMYPBwYbK5HvaILR7IiA76lbrFmL9O5cjZe0c4uSe8Chi8enW08mvD8NR4rPEOsKtAOiA==
X-Received: by 2002:a50:9b42:0:b0:543:55d2:df2d with SMTP id a2-20020a509b42000000b0054355d2df2dmr988070edj.41.1698732789707;
        Mon, 30 Oct 2023 23:13:09 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id h16-20020a50ed90000000b0053df23511b0sm522899edr.29.2023.10.30.23.13.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 23:13:09 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99de884ad25so804993866b.3
        for <selinux@vger.kernel.org>; Mon, 30 Oct 2023 23:13:08 -0700 (PDT)
X-Received: by 2002:a17:906:99c1:b0:9c7:4d98:9847 with SMTP id
 s1-20020a17090699c100b009c74d989847mr10898273ejn.53.1698732788596; Mon, 30
 Oct 2023 23:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
In-Reply-To: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 20:12:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=whOtZK1g_dzEnb5NEB8ssNqotmHy3CkUwbnab_4phFRdw@mail.gmail.com>
Message-ID: <CAHk-=whOtZK1g_dzEnb5NEB8ssNqotmHy3CkUwbnab_4phFRdw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20231030
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 30 Oct 2023 at 16:16, Paul Moore <paul@paul-moore.com> wrote:
>
> * Use a better hashing function for the SELinux role tansition hash
>   table.

Bah.

While the old hash function was garbage, the new one is quite expensive.

Maybe it's worth it.

But generally, if you find that "oh, just doing a modulus with a power
of two drops all high bits", the first thing to try is probably to
just do "hash_long(x, N)" to get N bits instead.

Assuming the input is somewhat ok in one word, it does a fairly good
job of mixing the bits with a simple multiply-and-shift.

Yes, yes, jhash is a fine hash, but it does a quite *lot* of (simple)
ALU ops. While "hash_long()" is often small enough to be inlined.

I also note that filenametr_hash() does the old "one byte at a time"
hash and partial_name_hash(). Is there any reason that code doesn't
use the "full_name_hash()" which does things a word at a time?

Probably doesn't matter, but since I looked at this to see what the
new hashing was, I noticed...

            Linus
