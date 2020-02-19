Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4227C34050
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 08:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D922208E4
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 08:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjtL84kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSIZ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:25:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48771 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbgBSIZ6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 03:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582100756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtJWfY2ycYed/QiHs0/W5jwGSnZ64bMnxXCk0p3Usss=;
        b=ZjtL84kKBh3XsG4+Ebi7IMUjhck3ZUESQJB1LDzi/hZONnkepGxavD/p+3d7c/YOoYUr0g
        gC7LqaGTzFmk5t0gVRGMlChaZyI4DIV3VTStvdKkORx+9nvp12LTxMsP36IsofVB+A5Zmx
        +m6oBrj/kKnPgG5akcm8y/ruWJl3VcI=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361--NESsoadMWy4daSIU4H5vw-1; Wed, 19 Feb 2020 03:25:52 -0500
X-MC-Unique: -NESsoadMWy4daSIU4H5vw-1
Received: by mail-ot1-f70.google.com with SMTP id 39so14010822otr.21
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 00:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtJWfY2ycYed/QiHs0/W5jwGSnZ64bMnxXCk0p3Usss=;
        b=SgKeAvcGeiNOCw3aIKP486BVqEsT09lUilGp8uSg89nb/jbxfSiSMMqDQmu/VlhqIu
         zHpzrL3tTyb1M17xuOfi56+b9g+ajN3AmyXqvROe+4VN5osrp3qNfwqmtz3BVNw0EQEb
         PUXd9gj4Fy3spyaIcqx0YY/kb3NkHvCojX2ouoEcqoRs25Rc0wFG5XFAG0edn5wLP1X6
         6IhsKVedPb/6RM5zRnISiS8Z5VzzjJ6WcaQeuB78hMqRVJemYv0Tns9kCALpgFT9pgTD
         /EPGFmI1pOB99orUCIzrfM0ztgW5fIenXl7GuqxD9ku+Exbv1JyeG9FsApn/PdbNl16p
         /BDA==
X-Gm-Message-State: APjAAAX2fzQC3ph1hhRSEO8ZBcdLUPfAtRyfS6tTGl60Hcc4szG/Pbxr
        AzKbxL8F5QIzRyi22acPXNZSeQBRaNv8/YT5SV8+M1da+yLPyKcUQX7pw0NwwlWJ3YiwYoHf3wJ
        bhii6rEI+WDAweWQGDKzY3LMi8uR+GHDgdg==
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr17582126oth.43.1582100751468;
        Wed, 19 Feb 2020 00:25:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqolGfl/tCa4gquqmv+361MceGxXVzc+Cx1VwWuasUBvPLcqIMtJ+GqaZHKPkzhFb7PPmvrMMCt6J5unzUJxM=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr17582114oth.43.1582100751099;
 Wed, 19 Feb 2020 00:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20200218203911.30502-1-jwcart2@tycho.nsa.gov>
In-Reply-To: <20200218203911.30502-1-jwcart2@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Feb 2020 09:25:40 +0100
Message-ID: <CAFqZXNth6mpsSJ1--czyyfSXCbHTD26MzR+u3UhF5Qn8meHKLg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use ebitmap_length() to check for an empty ebitmap
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 18, 2020 at 9:45 PM James Carter <jwcart2@tycho.nsa.gov> wrote:
> When checking whether or not an ebitmap has any bits set, use
> ebitmap_length() instead of ebitmap_cardinality().
>
> There is no need to find out how many bits are set, if all that is
> needed is to determine if any bits are set at all.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/src/kernel_to_cil.c  | 10 +++++-----
>  libsepol/src/kernel_to_conf.c |  8 ++++----
>  libsepol/src/module_to_cil.c  | 16 ++++++++--------
>  3 files changed, 17 insertions(+), 17 deletions(-)

Thanks, this looks good! Although I'm thinking if we shouldn't add a
specific function for this, e.g.:

static inline bool ebitmap_is_empty(ebitmap_t *e)
{
        return ebitmap_length(e) == 0;
}

...because ebitmap_length() is kind of an implementation detail and it
is easy to confuse ebitmap_length() and ebitmap_cardinality(). Note
there are already some existing callers of ebitmap_length() that would
also need converting to ebitmap_is_empty() in that case.

<diff snipped>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

