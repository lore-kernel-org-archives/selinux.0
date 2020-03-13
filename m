Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91235C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BCA2072C
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khiCbGXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCMP4R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:56:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37451 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMP4Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 11:56:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so5323392otp.4
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OL70V98bjaeTpEsGsce6GBCcyxbMOeWz75t3M1myGJM=;
        b=khiCbGXdBtc3FYDTDWqilUFZATDEl1XeTOepJregS6qRCWOu3YMZeIw/aHqVwHMEk4
         0yIeZKTijM1/TlhkDgkc90oxxsrCmVdTTEWOOV5DMj341ptmBsu4vaSQHTCFOWS9NOyo
         KeeXx8+Iwk1CwePajQzjC66UytYibQuQNusQAB9dUE/3Dhv+MHVhGaMKUE+tJpIvUVqX
         n/Ni1bxoVYjoNVJnw46D/lcChYhAofmQK0a3awxucvqMhwsb+VddvUMu9AYhjhrldEfT
         WGsWQn8db1vdYTTZB8xeuK+vzpxEZB7oQ7X2KIFKHVvyTRoYNtyBoPMnFD4YiUquS8Zu
         gH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OL70V98bjaeTpEsGsce6GBCcyxbMOeWz75t3M1myGJM=;
        b=ek6s+Cl7Sw8/Sqb2bMp16VIRnaQtDAIRFAASwr9fZltoNTYD0VwI1cI+gOhI7ww093
         e5X2MM2rmyuyEcdIZIy7YxGjWliF//NF+X5edrxCBGBG2PWoABPlRs2kp8NiiXYktbhw
         nM+44WDBAU54GTTXvJVvrz24SKqFenh9A/b4+LRxjLOPB0PlmWJPY26p2Pa4Lewvng05
         NcMp9jrZ2rzefsgec1LD6CQqSDWZVOi04mf0P3sbjUVoFLOGuSiGFF+myAdDUaM1AtiX
         irs0KzedHL7+uq/xa4U3hpVaF2HHVGekvUlyuSzdC/wWWe+qGte/IUs3ghSaP1F+4UUv
         VNrg==
X-Gm-Message-State: ANhLgQ2VCkx0aIems9B6Fa9qWOJquTSNslDcecDDzqwoDqygqJ/oEvQc
        CxfOKGEfRDdsN34zZPDdz7+xVb3Q7P2Q11LrROtXOA==
X-Google-Smtp-Source: ADFU+vuWaae2xOXH28mzrU+qKwNOfDfbZ6S68a31YopBrT4sXG1CTeExH1BjdftwvbNTBn0JNVCwVquE5qmrMGjIQnE=
X-Received: by 2002:a05:6830:2391:: with SMTP id l17mr11877850ots.339.1584114975951;
 Fri, 13 Mar 2020 08:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200313112921.166817-1-omosnace@redhat.com> <CAP+JOzQmr1McXTO49xw60MvLy-4tE9QfSFYj-B+5HXHa=QqB3A@mail.gmail.com>
In-Reply-To: <CAP+JOzQmr1McXTO49xw60MvLy-4tE9QfSFYj-B+5HXHa=QqB3A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 13 Mar 2020 11:57:36 -0400
Message-ID: <CAP+JOzTQQx6aM81QyVe0yoiPJeDU+7xE6nn=0UMAB1EZ_c9ryA@mail.gmail.com>
Subject: Re: [PATCH] secilc: add basic test for policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000006d44c805a0be8298"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0000000000006d44c805a0be8298
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 13, 2020 at 10:01 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Mar 13, 2020 at 7:30 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
<snip>
>
> I can trim these policies and make them smaller. I'll send you smaller versions.
>

Try these two attached policies. I've removed everything not related
to the redundant rules.

Jim

--0000000000006d44c805a0be8298
Content-Type: application/vnd.ms-artgalry; name="opt-input.cil"
Content-Disposition: attachment; filename="opt-input.cil"
Content-Transfer-Encoding: base64
Content-ID: <f_k7qd6ip40>
X-Attachment-Id: f_k7qd6ip40

KGhhbmRsZXVua25vd24gZGVueSkKKGNsYXNzIGNsMDEgKHAwMWEgcDAxYiBwMTFhIHAxMWIpKQoo
Y2xhc3NvcmRlciAoY2wwMSkpCihzaWQga2VybmVsKQooc2lkb3JkZXIgKGtlcm5lbCkpCihtbHMg
dHJ1ZSkKKHNlbnNpdGl2aXR5IHMwMSkKKHNlbnNpdGl2aXR5b3JkZXIgKHMwMSkpCihjYXRlZ29y
eSBjMDEpCihjYXRlZ29yeW9yZGVyIChjMDEpKQooc2Vuc2l0aXZpdHljYXRlZ29yeSBzMDEgKGMw
MSkpCih0eXBlYXR0cmlidXRlIGF0MDEpCih0eXBlYXR0cmlidXRlIGF0MDIpCihib29sZWFuIGIw
MSBmYWxzZSkKKHR5cGUgdHAwMSkKKHR5cGUgdHAwMikKKHR5cGUgdHAwNCkKKHR5cGUgdHByMSkK
KHR5cGUgdHByMikKKHR5cGUgdHByMykKKHR5cGUgdHByNCkKKHR5cGUgdHByNSkKKHR5cGVhdHRy
aWJ1dGVzZXQgYXQwMSAodHAwMSkpCih0eXBlYXR0cmlidXRlc2V0IGF0MDIgKHRwMDEgdHAwMikp
CihhbGxvdyBhdDAyIHRwcjEgKGNsMDEgKHAxMWEgcDAxYSBwMDFiKSkpCihhbGxvdyBhdDAyIHRw
cjMgKGNsMDEgKHAxMWEgcDAxYSBwMDFiKSkpCihhbGxvdyB0cDAxIGF0MDEgKGNsMDEgKHAxMWIp
KSkKKGFsbG93IHRwMDEgc2VsZiAoY2wwMSAocDExYSBwMDFhKSkpCihhbGxvdyB0cDAxIHRwMDEg
KGNsMDEgKHAwMWIpKSkKKGFsbG93IHRwMDEgdHByMSAoY2wwMSAocDExYSBwMTFiIHAwMWEgcDAx
YikpKQooYWxsb3cgdHAwMiB0cHIxIChjbDAxIChwMTFhIHAwMWEpKSkKKGRvbnRhdWRpdCBhdDAy
IHRwcjIgKGNsMDEgKHAxMWEgcDAxYSBwMDFiKSkpCihkb250YXVkaXQgYXQwMiB0cHI0IChjbDAx
IChwMTFhIHAwMWEgcDAxYikpKQooZG9udGF1ZGl0IHRwMDEgdHByMiAoY2wwMSAocDExYSBwMTFi
IHAwMWEgcDAxYikpKQooZG9udGF1ZGl0IHRwMDIgdHByMiAoY2wwMSAocDExYSBwMDFhKSkpCihi
b29sZWFuaWYgKGIwMSkKICAgICh0cnVlCiAgICAgICAgKGFsbG93IHRwMDEgdHByMyAoY2wwMSAo
cDExYSBwMTFiIHAwMWEgcDAxYikpKQogICAgICAgIChhbGxvdyB0cDAxIHRwcjUgKGNsMDEgKHAx
MWEgcDExYiBwMDFhIHAwMWIpKSkKICAgICAgICAoYWxsb3cgdHAwMiB0cHIzIChjbDAxIChwMTFh
IHAwMWEpKSkKICAgICAgICAoYWxsb3cgdHAwMiB0cHI1IChjbDAxIChwMTFhIHAwMWEpKSkKICAg
ICAgICAoZG9udGF1ZGl0IHRwMDEgdHByNCAoY2wwMSAocDExYSBwMTFiIHAwMWEgcDAxYikpKQog
ICAgICAgIChkb250YXVkaXQgdHAwMiB0cHI0IChjbDAxIChwMTFhIHAwMWEpKSkKICAgICkKICAg
IChmYWxzZQogICAgICAgIChhbGxvdyBhdDAyIHRwcjUgKGNsMDEgKHAxMWEgcDAxYSBwMDFiKSkp
CiAgICApCikKKHJvbGUgb2JqZWN0X3IpCihyb2xlIHJsMDEpCihyb2xldHlwZSBybDAxIHRwMDEp
Cihyb2xldHlwZSBvYmplY3RfciB0cDAxKQoocm9sZXR5cGUgb2JqZWN0X3IgdHAwMikKKHJvbGV0
eXBlIG9iamVjdF9yIHRwMDQpCihyb2xldHlwZSBvYmplY3RfciB0cHIxKQoocm9sZXR5cGUgb2Jq
ZWN0X3IgdHByMikKKHJvbGV0eXBlIG9iamVjdF9yIHRwcjMpCihyb2xldHlwZSBvYmplY3RfciB0
cHI0KQoocm9sZXR5cGUgb2JqZWN0X3IgdHByNSkKKHVzZXIgdXMwMSkKKHVzZXJyb2xlIHVzMDEg
b2JqZWN0X3IpCih1c2Vycm9sZSB1czAxIHJsMDEpCih1c2VybGV2ZWwgdXMwMSAoczAxKSkKKHVz
ZXJyYW5nZSB1czAxICgoczAxKSAoczAxKSkpCihzaWRjb250ZXh0IGtlcm5lbCAodXMwMSBybDAx
IHRwMDEgKChzMDEpIChzMDEpKSkpCg==
--0000000000006d44c805a0be8298
Content-Type: application/vnd.ms-artgalry; name="opt-expected.cil"
Content-Disposition: attachment; filename="opt-expected.cil"
Content-Transfer-Encoding: base64
Content-ID: <f_k7qd6p0m1>
X-Attachment-Id: f_k7qd6p0m1

KGhhbmRsZXVua25vd24gZGVueSkKKGNsYXNzIGNsMDEgKHAwMWEgcDAxYiBwMTFhIHAxMWIpKQoo
Y2xhc3NvcmRlciAoY2wwMSkpCihzaWQga2VybmVsKQooc2lkb3JkZXIgKGtlcm5lbCkpCihtbHMg
dHJ1ZSkKKHNlbnNpdGl2aXR5IHMwMSkKKHNlbnNpdGl2aXR5b3JkZXIgKHMwMSkpCihjYXRlZ29y
eSBjMDEpCihjYXRlZ29yeW9yZGVyIChjMDEpKQooc2Vuc2l0aXZpdHljYXRlZ29yeSBzMDEgKGMw
MSkpCih0eXBlYXR0cmlidXRlIGF0MDIpCihib29sZWFuIGIwMSBmYWxzZSkKKHR5cGUgdHAwMSkK
KHR5cGUgdHAwMikKKHR5cGUgdHAwNCkKKHR5cGUgdHByMSkKKHR5cGUgdHByMikKKHR5cGUgdHBy
MykKKHR5cGUgdHByNCkKKHR5cGUgdHByNSkKKHR5cGVhdHRyaWJ1dGVzZXQgYXQwMiAodHAwMSB0
cDAyKSkKKGFsbG93IGF0MDIgdHByMSAoY2wwMSAocDAxYSBwMDFiIHAxMWEpKSkKKGFsbG93IGF0
MDIgdHByMyAoY2wwMSAocDAxYSBwMDFiIHAxMWEpKSkKKGFsbG93IHRwMDEgc2VsZiAoY2wwMSAo
cDAxYSBwMDFiIHAxMWEgcDExYikpKQooYWxsb3cgdHAwMSB0cHIxIChjbDAxIChwMTFiKSkpCihk
b250YXVkaXQgYXQwMiB0cHIyIChjbDAxIChwMDFhIHAwMWIgcDExYSkpKQooZG9udGF1ZGl0IGF0
MDIgdHByNCAoY2wwMSAocDAxYSBwMDFiIHAxMWEpKSkKKGRvbnRhdWRpdCB0cDAxIHRwcjIgKGNs
MDEgKHAxMWIpKSkKKGJvb2xlYW5pZiBiMDEKICAgICh0cnVlCiAgICAgICAgKGFsbG93IHRwMDEg
dHByMyAoY2wwMSAocDExYikpKQogICAgICAgIChhbGxvdyB0cDAxIHRwcjUgKGNsMDEgKHAwMWEg
cDAxYiBwMTFhIHAxMWIpKSkKICAgICAgICAoYWxsb3cgdHAwMiB0cHI1IChjbDAxIChwMDFhIHAx
MWEpKSkKICAgICAgICAoZG9udGF1ZGl0IHRwMDEgdHByNCAoY2wwMSAocDExYikpKQogICAgKQog
ICAgKGZhbHNlCiAgICAgICAgKGFsbG93IGF0MDIgdHByNSAoY2wwMSAocDAxYSBwMDFiIHAxMWEp
KSkKICAgICkKKQoocm9sZSBvYmplY3RfcikKKHJvbGUgcmwwMSkKKHJvbGV0eXBlIHJsMDEgdHAw
MSkKKHJvbGV0eXBlIG9iamVjdF9yIHRwMDEpCihyb2xldHlwZSBvYmplY3RfciB0cDAyKQoocm9s
ZXR5cGUgb2JqZWN0X3IgdHAwNCkKKHJvbGV0eXBlIG9iamVjdF9yIHRwcjEpCihyb2xldHlwZSBv
YmplY3RfciB0cHIyKQoocm9sZXR5cGUgb2JqZWN0X3IgdHByMykKKHJvbGV0eXBlIG9iamVjdF9y
IHRwcjQpCihyb2xldHlwZSBvYmplY3RfciB0cHI1KQoodXNlciB1czAxKQoodXNlcnJvbGUgdXMw
MSBvYmplY3RfcikKKHVzZXJyb2xlIHVzMDEgcmwwMSkKKHVzZXJsZXZlbCB1czAxIChzMDEpKQoo
dXNlcnJhbmdlIHVzMDEgKChzMDEpIChzMDEpKSkKKHNpZGNvbnRleHQga2VybmVsICh1czAxIHJs
MDEgdHAwMSAoKHMwMSkgKHMwMSkpKSkK
--0000000000006d44c805a0be8298--
