Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83631C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 17:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA9E2075A
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 17:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci0v/g8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgE0RUY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbgE0RUX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 13:20:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F721C03E97D
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 10:20:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u23so141602otq.10
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1L1Cxfww5DGLNNxyS9evbVjs8/oAbquh++iTteg0tnQ=;
        b=Ci0v/g8Q+rOvwhb6ZO/0/nE4IkZX3mqzO8AUPbvQcl3kheBHGm4IGTfV78eo9zeJtM
         MqJSePDiDBktcz0Nze4V0qaYrMKpTvVFSfiLeYMXEbRdOvjVxHba8XqykMZHGemIOIzs
         bUI5gW7Ss18TUsSCKzySq7Q3JYo4xFG751kaA8QpQY795q2EfO0I4h0W/vTYJ3/3kXSP
         AQQgzjws81vdroI2DEpRWELcJ/uRrkshsGUp83ROeNm+/E1eZl4xIwvwWnD9CWqjh9GC
         o6ZF9/UFwF4pkT5tyLiK6L7plmCHQ5xfThGDFWqnYa1FHNM29yfNiqv+sh0niUcArZKD
         zO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1L1Cxfww5DGLNNxyS9evbVjs8/oAbquh++iTteg0tnQ=;
        b=Pm+Xo74MueeD5jr3kJVYlimKtPB+sUK57zUoqqd6o/+Y3cI9BReDei4FIMXXNzSGsB
         OXPr7jg+2sZQt+bN1aBrD9b29v0XGSEesUOR00UVGyuX3jZOGSErVWN9sBPdFTxhxuk6
         kv005K4M+51SyyF3oc/4I3KKtcKuIHhmiXSbFCdIS6mlPIHL+6fgexWHP/8VQYnOdw1w
         BN14mIrg3k9TV+SG9+z0fs3+k5szMiMAU9AjZ+u6NoaJMZ7Z1JbL8bJ/PJMVU5rr8wl4
         f2K2JZ0JJKF455mJkVh65Fs6xP3nyCZrTaXcTd87EP/aefDqAafZhxwGjNL2qXN5gazd
         nbmw==
X-Gm-Message-State: AOAM532Y4jKRXTE57AyV42KzTjZMzJKwP0ygIEnJTunxWLTzx+ssPLis
        /ePi0QtEx7rBvGLtKuPQ7nXIKfto8XWbi57JCf0=
X-Google-Smtp-Source: ABdhPJxU0BCe3E7wrTUrSd3TKn6jY1uP7TBCZ8+CDS+pJdMcNPzVAaYtLxGVDJT6L7Hkzqbc9MmUfwBIugQJVk7C/fA=
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr5277007otr.59.1590600021767;
 Wed, 27 May 2020 10:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145513.194440-1-jwcart2@gmail.com> <20200522145513.194440-3-jwcart2@gmail.com>
 <CAEjxPJ6UxEaNkZt4sdCfeVd2amr1fxE97d4jWRD=nkDif=oz+w@mail.gmail.com>
In-Reply-To: <CAEjxPJ6UxEaNkZt4sdCfeVd2amr1fxE97d4jWRD=nkDif=oz+w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 27 May 2020 13:20:10 -0400
Message-ID: <CAP+JOzTBqkDgqizyLodJk09-Ru3Kr54Wp=gOO-s_K+ZVX=cu+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] libsepol: Improve writing CIL category rules
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000047bb2d05a6a46d12"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--00000000000047bb2d05a6a46d12
Content-Type: text/plain; charset="UTF-8"

On Wed, May 27, 2020 at 12:44 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 10:58 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > Improves writing of CIL category rules when converting MLS kernel
> > policy to CIL. No changes to functionality, but eliminate useless
> > checks for category aliases when using the p_cat_val_to_name array,
> > find the actual number of aliases before allocating memory, and
> > skip the category alias rules if there are no aliases.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> This series looks fine to me but do you have a test case that exercises it?

See attached.

--00000000000047bb2d05a6a46d12
Content-Type: application/vnd.ms-artgalry; name="alias.cil"
Content-Disposition: attachment; filename="alias.cil"
Content-Transfer-Encoding: base64
Content-ID: <f_kapm515v0>
X-Attachment-Id: f_kapm515v0

KGhhbmRsZXVua25vd24gZGVueSkKKGNsYXNzIENMQVNTIChQRVJNMSBQRVJNMikpCihjbGFzc29y
ZGVyIChDTEFTUykpCihzaWQga2VybmVsKQooc2lkb3JkZXIgKGtlcm5lbCkpCihtbHMgdHJ1ZSkK
KHNlbnNpdGl2aXR5IFNFTlMpCihzZW5zaXRpdml0eW9yZGVyIChTRU5TKSkKKHNlbnNpdGl2aXR5
YWxpYXMgU0VOU0FMSUFTKQooc2Vuc2l0aXZpdHlhbGlhc2FjdHVhbCBTRU5TQUxJQVMgU0VOUykK
KGNhdGVnb3J5IENBVCkKKGNhdGVnb3J5b3JkZXIgKENBVCkpCihjYXRlZ29yeWFsaWFzIENBVEFM
SUFTKQooY2F0ZWdvcnlhbGlhc2FjdHVhbCBDQVRBTElBUyBDQVQpCihzZW5zaXRpdml0eWNhdGVn
b3J5IFNFTlMgKENBVCkpCih0eXBlIFRZUEUpCih0eXBlIHQxKQoodHlwZSB0MikKKHR5cGUgdHRh
KQoodHlwZSB0dGIpCih0eXBlIHR0YykKKGFsbG93IFRZUEUgc2VsZiAoQ0xBU1MgKFBFUk0xKSkp
CihhbGxvdyB0MSB0dGEgKENMQVNTIChQRVJNMSkpKQooYWxsb3cgdDEgdHRiIChDTEFTUyAoUEVS
TTEpKSkKKGFsbG93IHQxIHR0YyAoQ0xBU1MgKFBFUk0xKSkpCihhbGxvdyB0MiB0dGEgKENMQVNT
IChQRVJNMikpKQooYWxsb3cgdDIgdHRjIChDTEFTUyAoUEVSTTIpKSkKKHJvbGUgUk9MRSkKKHJv
bGUgb2JqZWN0X3IpCihyb2xldHlwZSBST0xFIFRZUEUpCihyb2xldHlwZSBvYmplY3RfciBUWVBF
KQoocm9sZXR5cGUgb2JqZWN0X3IgdDEpCihyb2xldHlwZSBvYmplY3RfciB0MikKKHJvbGV0eXBl
IG9iamVjdF9yIHR0YSkKKHJvbGV0eXBlIG9iamVjdF9yIHR0YikKKHJvbGV0eXBlIG9iamVjdF9y
IHR0YykKKHVzZXIgVVNFUikKKHVzZXJyb2xlIFVTRVIgUk9MRSkKKHVzZXJyb2xlIFVTRVIgb2Jq
ZWN0X3IpCih1c2VybGV2ZWwgVVNFUiAoU0VOUykpCih1c2VycmFuZ2UgVVNFUiAoKFNFTlMpIChT
RU5TIChDQVQpKSkpCihzaWRjb250ZXh0IGtlcm5lbCAoVVNFUiBST0xFIFRZUEUgKChTRU5TKSAo
U0VOUykpKSkK
--00000000000047bb2d05a6a46d12
Content-Type: application/x-shellscript; name="test_cil_alias.sh"
Content-Disposition: attachment; filename="test_cil_alias.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_kapm55qq1>
X-Attachment-Id: f_kapm55qq1

IyEvdXNyL2Jpbi9iYXNoCgpQUkVGSVg9L2hvbWUvamltL2xvY2FsCgpleHBvcnQgTERfTElCUkFS
WV9QQVRIPSRQUkVGSVgvbGliOiRQUkVGSVgvdXNyL2xpYjoke0xEX0xJQlJBUllfUEFUSH0KCiRQ
UkVGSVgvdXNyL2Jpbi9zZWNpbGMgLU0gMSAtbyBhbGlhcy5iaW4gYWxpYXMuY2lsCiRQUkVGSVgv
dXNyL2Jpbi9jaGVja3BvbGljeSAtQyAtTSAtYiAtbyBhbGlhcy5iaW4uY2lsIGFsaWFzLmJpbgok
UFJFRklYL3Vzci9iaW4vc2VjaWxjIC1NIDEgLW8gYWxpYXMuYmluLmNpbC5iaW4gYWxpYXMuYmlu
LmNpbApEUj1gZGlmZiBhbGlhcy5iaW4gYWxpYXMuYmluLmNpbC5iaW4gfCB3YyAtbGAKaWYgWyAk
RFIgIT0gMCBdCnRoZW4KZWNobyAiYWxpYXMuYmluIGFuZCBhbGlhcy5iaW4uY2lsLmJpbiBhcmUg
ZGlmZmVyZW50IgpmaQoK
--00000000000047bb2d05a6a46d12--
