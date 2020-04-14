Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D500FC352B6
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B07C22075E
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHef8kwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438097AbgDNKGv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438121AbgDNKGr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 06:06:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479FC061A0E;
        Tue, 14 Apr 2020 03:06:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id d2so11053359ilc.0;
        Tue, 14 Apr 2020 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbydlPiIItolcocBG5rOceoTVirC9APRMvqPzphfqlo=;
        b=mHef8kwrpLi4rmsSVlKLN7Fs4yIYaefU56m6v/R4gvxN399128TzjJ1sPCETotHedH
         xYteSe4RKKwSXcSkvLfWsO0hBWCGxLde5oeLr1UB6gt4+2iQqBq8CHSA1+H/hRsVckQV
         1Wv2V3NKi1IgSX++wIUR9JHiRqE9BUNVkN8FABWOQerX7+Xl0QeC27ESXSHoGFtCl0jN
         /gxmYj0qR4Mjh/nWFMSIqRii2ldWBtlBE1q8wkz1Uy8LZaTbxjtGFz1D5fBHJ/F2PKEA
         NbcTf1LTwBJFg9T05iBH+tBfu3+PU83vK09ZX6Yp1OBfACULHLicqN9b64t76IXO8eyB
         9foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbydlPiIItolcocBG5rOceoTVirC9APRMvqPzphfqlo=;
        b=IyLEAzwqWmQnMGi+2BguFDOqTI3reaPbPrQoUpcdl2QUrZ3f3vGDtARFOxoQpvVs2+
         8JGfPJchY7Qnn+l2U1E4w/RrvPfBUVI3bmjXbQuezlR4XR8q60b2hQkzgXUlWDXPF6Cj
         d7jgcy75EE5/mKbgDZIs1j6ClE8yKHfTznLPnKTYdl9+RlSAuK5SDpsR+MTezZJxJ4t2
         jpTafatPYmjpqD0EOYNN+AyOQSyWqUjor/r8fhM9O4zW51/HYCO3dxGt/SNH5dJE8ZLL
         MfsnZx0aj+SS8/mdsg+NFcrh1NHxN/6XkeTKt5yT/okraWPWwhhXdEncrrdeGKKi+dao
         wb7w==
X-Gm-Message-State: AGi0PuaeCpGPyg6pGOLxT5+TE7Qadhek45NG0wHGUzSzyeYKfbaGwIdD
        95E2HFS0HoVhWaYYBDNkisG8B5n+N0o3CR2FSCM=
X-Google-Smtp-Source: APiQypJWmkXUW3rbwvOceWTXYIJLKf5bRmo5eOdXLdcYV9U6pi2N3q72+/Kb7qs0WTkPgXcT8JiiHYk0rvvg2vdbkT0=
X-Received: by 2002:a92:8f49:: with SMTP id j70mr21022494ild.117.1586858805678;
 Tue, 14 Apr 2020 03:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <f92bef0f-eb40-0e07-540c-321134e4b070@linux.microsoft.com>
 <CAB9W1A1=JyOV3-+6jn3xX-M+GKWBB2cCNh-VWB_kzf+YiR_d2Q@mail.gmail.com>
 <CAP22eLGJbSvUU=W0Jp=gvOFv-nxLC8YTnta3OU2PKbh746MCkQ@mail.gmail.com> <1586826679.7311.174.camel@linux.ibm.com>
In-Reply-To: <1586826679.7311.174.camel@linux.ibm.com>
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Tue, 14 Apr 2020 13:06:34 +0300
Message-ID: <CAP22eLGBxy7_Q8dMoJTjBsrhveqhfh7nibzBCqrtWKhXzY74fQ@mail.gmail.com>
Subject: Re: [RFC] IMA: New IMA measurements for dm-crypt and selinux
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Stephen Smalley <stephen.smalley@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>, dm-devel@redhat.com,
        James Morris <jmorris@namei.org>, chpebeni@linux.microsoft.com,
        nramas@linux.microsoft.com, balajib@microsoft.com,
        sashal@kernel.org, suredd@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 14, 2020 at 4:11 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Sun, 2020-04-12 at 11:15 +0300, Lev R. Oshvang . wrote:
> > On Sat, Apr 11, 2020 at 10:07 PM Stephen Smalley
> > It sees to me that  LKRG (kernel run time guard)  takes the role of
> > measuring kernel structures.  Perhaps you need to consult with LKRG
> > guys.
>
> There definitely sounds like there is some overlap.  LKRG seems to be
> measuring kernel structures for enforcing local integrity.  In the
> context of IMA, measurements are included in the IMA measurement list
> and used to extend a TPM PCR so that it can be quoted.
>
> A generic method for measuring structures and including them in the
> IMA measurement list sounds interesting.
>
> Mimi
>
I frankly do not understand the threat model.
Secure boot or TPM provides trust in encryption/decryption keys
dm-crypt/dm-verify use.
When dm-verify discovers that the disk image is modified it will just
do not allow the system to work ( mount roots, etc).
So imagine that adversary took control of TPM  and changed the keys
dm-verify work with in order to sign malicious content on disk. In
this case, remote attestation should alert of compromised TPM, no
matter whether dmvery keys or other keys were forged.

SELinux is another story and I think a run-time check of SElinux
structures fits well into LKRG. IMA only provide guarantees that
SELinux (or any other LSM) control files and attributes were intact.
