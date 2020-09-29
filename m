Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7EC4727C
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 17:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071912075A
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601400256;
	bh=DfVo+QTy1+Ugv+kDx0DjL4/XsDfAyp7qiuKBUZYURrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k8tNbvz19aj+XTiZL6gPU/+jtAi5YB3r7G3YT1u1ootfYF6Q8+oq/BqJVtif9McTW
	 7NOUt3I5UmLnaKIw7DTqTMZBiTJhK+113KP7k8+83LoRpEiy/bOIc5DS4Qe13PIn/S
	 cvBlH1cwtn0fERfDsYlB7eDvzNacS50+dHWfe7S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgI2RYP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgI2RYP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 13:24:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF0C061755
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 10:24:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m5so6458712lfp.7
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLAA/pJeKW+cqg50Ky57VCHaGTK5qDXo2yqA2pvF+eQ=;
        b=LjUkXudSoFBbDOO0M3Aw/aA5ORisoLfOBbWS+EuHcCdJ4UVE9j8EhvhFGCA/Zca0w7
         4AaPgkaAJsBVuA6YpTFf7WTJVEp9xTmUeQvlINdGGPRg09Hegrf+uVZEXdkKqgmMKiN+
         Ebp/oOmLKEC9pbX17X2DwXblyrVa/XS3QfE+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLAA/pJeKW+cqg50Ky57VCHaGTK5qDXo2yqA2pvF+eQ=;
        b=BzLbX9dUM1eAy+i3n1otb+/q3Lo7TzkT1c3ZxDZhsFyzoMscYF6XETzFM4h/h53SJF
         AOpJ4pwPiR0J6aEH2eUpyUaCwmLJfcdon3j/bXxZmRlehBa3C9U1lrXeWfbEHaQ5m+tc
         ywI+ZzVVDlCXhwUGayvXyjIwojWR6oREfh1iEf6TJ2v9cP0NkmWoajrr4jbGUJgIyrTd
         0PfLGnT1jTpazGqDSAkkPky3NKzgeOJFU6zV2SAtH8YekQVm7fBIkzxtEAmF+x4T64Sf
         3F+Nu/XVA7v1g67ALKZnTutRJi88BTSJIUZTuilhJSF4blVVEhvAXI1E7jJD7J09iEaQ
         zQBA==
X-Gm-Message-State: AOAM531bbkAS24C+OT1+bcQTAhdSK0Wptm98kD4dsLHZitxGNPdfDroG
        cVLSHt8ghai+sn62dIoWLqiKd1rbUvZAwA==
X-Google-Smtp-Source: ABdhPJx3oqSx1RA5lrmtKNE0Gk0vk8KKyj8sIBesYM2isgkaHNLPu/36vSGnaIytN/o7vjOJgSRWwQ==
X-Received: by 2002:a19:c002:: with SMTP id q2mr1508275lff.372.1601400252956;
        Tue, 29 Sep 2020 10:24:12 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id e24sm417872ljg.33.2020.09.29.10.24.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 10:24:06 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id x69so6461425lff.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 10:24:06 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr1747057lfg.603.1601400246233;
 Tue, 29 Sep 2020 10:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
 <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
 <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
 <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
 <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
 <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
 <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net> <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
In-Reply-To: <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Sep 2020 10:23:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
Message-ID: <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000d2228705b0770cbc"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--000000000000d2228705b0770cbc
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> OK, so it seems that reverting comes out as the best choice here.

Yeah.

> BTW, I'm looking at rw_verify_area() and I see this "If (ppos)" check
> and the comment above it... And then I look at autofs_write(), which
> passes &file->f_pos, while ksys_write() passes file_ppos(file)

Ok, that doesn't matter for the security_file_permission() issue, but
yes, autofs is doing the traditional thing, and it's pointless. Using
file_ppos(file) isn't an option since it's an inline to read_write.c,
but it could just pass in NULL these days and avoid that too.

So how about we just do the appended patch? Can whoever sees this
problem just verify, even though it looks trivially correct...

            Linus

--000000000000d2228705b0770cbc
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kfo8cery0>
X-Attachment-Id: f_kfo8cery0

IGZzL2F1dG9mcy93YWl0cS5jIHwgMiArLQogZnMvcmVhZF93cml0ZS5jICAgfCAxICsKIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvYXV0b2ZzL3dhaXRxLmMgYi9mcy9hdXRvZnMvd2FpdHEuYwppbmRleCA3NGM4ODZmN2M1MWMu
LjVjZWQ4NTlkYWM1MyAxMDA2NDQKLS0tIGEvZnMvYXV0b2ZzL3dhaXRxLmMKKysrIGIvZnMvYXV0
b2ZzL3dhaXRxLmMKQEAgLTUzLDcgKzUzLDcgQEAgc3RhdGljIGludCBhdXRvZnNfd3JpdGUoc3Ry
dWN0IGF1dG9mc19zYl9pbmZvICpzYmksCiAKIAltdXRleF9sb2NrKCZzYmktPnBpcGVfbXV0ZXgp
OwogCXdoaWxlIChieXRlcykgewotCQl3ciA9IGtlcm5lbF93cml0ZShmaWxlLCBkYXRhLCBieXRl
cywgJmZpbGUtPmZfcG9zKTsKKwkJd3IgPSBfX2tlcm5lbF93cml0ZShmaWxlLCBkYXRhLCBieXRl
cywgTlVMTCk7CiAJCWlmICh3ciA8PSAwKQogCQkJYnJlYWs7CiAJCWRhdGEgKz0gd3I7CmRpZmYg
LS1naXQgYS9mcy9yZWFkX3dyaXRlLmMgYi9mcy9yZWFkX3dyaXRlLmMKaW5kZXggNWRiNThiOGM3
OGQwLi4yZmMzMTk0ZTRkMzAgMTAwNjQ0Ci0tLSBhL2ZzL3JlYWRfd3JpdGUuYworKysgYi9mcy9y
ZWFkX3dyaXRlLmMKQEAgLTUzOCw2ICs1MzgsNyBAQCBzc2l6ZV90IF9fa2VybmVsX3dyaXRlKHN0
cnVjdCBmaWxlICpmaWxlLCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90CiAJ
aW5jX3N5c2N3KGN1cnJlbnQpOwogCXJldHVybiByZXQ7CiB9CitFWFBPUlRfU1lNQk9MX0dQTChf
X2tlcm5lbF93cml0ZSk7CiAKIHNzaXplX3Qga2VybmVsX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxl
LCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBjb3VudCwKIAkJCSAgICBsb2ZmX3QgKnBvcykK
--000000000000d2228705b0770cbc--
