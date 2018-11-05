Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC83C0044C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 17:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62EB20827
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRUCiiGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62EB20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeKFC32 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:29:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37758 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbeKFC32 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Nov 2018 21:29:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so16019680qkd.4
        for <selinux@vger.kernel.org>; Mon, 05 Nov 2018 09:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uZ49yehx7JU8Tm8QgvhTvPTZBW6BqAejRUDJlRy/Pc=;
        b=TRUCiiGIsACIuJD2ytt+FsvhOf455Rm8GhMKbgKklaRsoI9vr2NnILy7vkIsCUFrJJ
         Xa5c6HIz6wQtP+pbKagGeMrEJHfoME7GfG7bPKAq+k/1NIE8i235IfFq5fkCMls0+bkR
         kGG3jdjmH1Kj3r2SxbNhlrJatc9mxRK32b0g3LNXibvRCt0RGjHCz8uZW+TJATyUfqi/
         0tCul5aDLGFbexTGOxoOIqWDEdVJbyWc0GkLJLU95H6imCV+ZoEPP383EAuwfweITv2c
         YsqsIa7mlcoB6GYLqR2TqH459DVFkyBN2XQW3H2yjAa3L0PVcyh9JZBcG50mqwjfxlLj
         fUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uZ49yehx7JU8Tm8QgvhTvPTZBW6BqAejRUDJlRy/Pc=;
        b=U7ny2b9dDLEviv0KuEzDW7VEaF/iPywnZYdqQ+BAWkYsQXW+ZisLLat/wc5IPZeTV0
         0vh+S+Qq/ysfQ37Q6A9BoD1S0dU/+201QQ6a0j2AK3KqN37ScD87leoD665U9bhTm4h7
         xrHVnU9paFHOLGNVwfX+fcfrv3CpFbHA3w4F0MlzPWEScLw10MnTQ+r/DQMsdCcZs7tt
         SeO5omKNoaaxKlPAPM/dx0DVmpl3cVGsLQcwW9+2coxVfD4znH3NZEaLiM/U6sNSqAu+
         V03pali63V7kcOHIFZYkd5mOacbdF9q2yixVXrkYadI4eAtSnoVfE9p6RtMEm7xz5vx3
         Glsw==
X-Gm-Message-State: AGRZ1gKSnoILXxEC94BnHAI6GKsGsfX1LMW0fHRPmdk6Sxr/q6u0ykiU
        6S9zhR3wE6+Ug2Sa330M2IfmvtnfEwTtfr625S8jk/KNeD7j6w==
X-Google-Smtp-Source: AJdET5cliiuUoC/yGxiWiMIqcGiCQjh8vVhZpGFT2z2LCskNlw2NAL01/cNOMCAnQ51WgeX/Y+0teOJryR0Pv4S0q4I=
X-Received: by 2002:a0c:8286:: with SMTP id i6mr22012672qva.65.1541437729517;
 Mon, 05 Nov 2018 09:08:49 -0800 (PST)
MIME-Version: 1.0
References: <CALeUXe4MeHnt_4_pSZVTCYC4RNt2UKG0kEg0O9PRQTnmkXiLEQ@mail.gmail.com>
 <20181031142146.8861-1-sds@tycho.nsa.gov> <8d1fd1f5-b073-6c1b-a217-2a374ebe1eff@tycho.nsa.gov>
In-Reply-To: <8d1fd1f5-b073-6c1b-a217-2a374ebe1eff@tycho.nsa.gov>
From:   Jiyong Park <jiyong@google.com>
Date:   Mon, 5 Nov 2018 09:08:12 -0800
Message-ID: <CALeUXe42Vc1wfAmS3_RvQQkUHN-=i3ktw2Qdw-bD0hh7cb3YrQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix overly strict validation of file_contexts.bin
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Stephen,

I've just confirmed that the issue was resolved with the patch. Thank you!

On Mon, Nov 5, 2018 at 6:34 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 10/31/18 10:21 AM, Stephen Smalley wrote:
> > load_mmap and regex_load_mmap (in the !USE_PCRE2 case) were
> > incorrectly treating the absence of any fixed stems or study data
> > as an error, rejecting valid file_contexts.bin files.  Remove
> > the extraneous validation checks.
> >
> > Test:
> > $ cat > file_contexts <<EOF
> > (/.*)?                u:object_r:system_file:s0
> > /lib                   u:object_r:system_dir:s0
> > EOF
> > $ sefcontext_compile file_contexts
> > $ selabel_lookup -b file -k /lib -f file_contexts.bin
> >
> > Before:
> > ERROR: selabel_open - Could not obtain handle.
> >
> > After:
> > Default context: u:object_r:system_dir:s0
> >
> > Reported-by: Jiyong Park <jiyong@google.com>
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> This has been merged.  Let us know if it didn't resolve the issue for you.
>
> > ---
> >   libselinux/src/label_file.c | 2 +-
> >   libselinux/src/regex.c      | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 560d8c3d..dbf51a93 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -232,7 +232,7 @@ end_arch_check:
> >
> >       /* allocate the stems_data array */
> >       rc = next_entry(&stem_map_len, mmap_area, sizeof(uint32_t));
> > -     if (rc < 0 || !stem_map_len)
> > +     if (rc < 0)
> >               return -1;
> >
> >       /*
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index dfc15d63..a6fcbbfe 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -348,7 +348,7 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
> >               goto err;
> >
> >       rc = next_entry(&entry_len, mmap_area, sizeof(uint32_t));
> > -     if (rc < 0 || !entry_len)
> > +     if (rc < 0)
> >               goto err;
> >
> >       if (entry_len) {
> >
>
