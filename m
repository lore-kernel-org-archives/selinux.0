Return-Path: <SRS0=WnGO=YL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1581CA9EA0
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D3021897
	for <selinux@archiver.kernel.org>; Fri, 18 Oct 2019 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuCbofG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389980AbfJRJWQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:22:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37373 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbfJRJWQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Oct 2019 05:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571390534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0KuXJ+I6Kyym7Wbp44uifMDO77KHLiStuwB/HjRw6s=;
        b=QuCbofG0Y4YSNnpocH0f2c6MAH7PO76yZ7kW/QlL+NKIYOJyjvoGCzzKfTyTGuvVI8X8k6
        Kwz9untyatSqX0vqqU2xNBpyeP3Xv50o828GAOqkM2nQW+8BGFo1BlLv80irVRVsKUB9mg
        7C7fsUUFY9gTO/AjUIR7LfJlvgEMoks=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-d1-g6ffLNwuLkRv85NH6zw-1; Fri, 18 Oct 2019 05:22:13 -0400
Received: by mail-ot1-f71.google.com with SMTP id t7so2646034otm.4
        for <selinux@vger.kernel.org>; Fri, 18 Oct 2019 02:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1diiFOoBn+aPjZNERTJSHqMcI1iFpSGLBN/SfEFseP8=;
        b=iPxpc9CZivFFQ826Udvv8M1ZS+/uo7cOrV4fdKiczJTNU+/imtbOeF5t4BQCxYpMHE
         keCVgUEs1bvwmo8IQJTo2HTQro41T6Uu52zlPkLtKKTbcORrmrSdt68eiquMH1r1/CVF
         aIhYHwWEP9nDyMxEXFqeuTaLqKVdq7JQEZQ/OruNfJ0ieXKKDXSxlZqgYmfMVbJxNyg0
         kOt9HVSZFSocd+Hgw9deCnk4FXcPMj6G40g+Uag2LA/n6AzghfR5bT+pW56TDZVIcxpl
         gytJOHVBOrXEc+NlXpu1ZWKzS5cI0VFrZbOilE6NbHu6/bI3KjuP0Bzfm0ovzl41TNlK
         T5qw==
X-Gm-Message-State: APjAAAUKbBZ7Qos4x7VwZnwD10n8lwBQPSTTMQ8k7tdWoHB94zS2ssF0
        xaUwE83s4NNxax0XVGBIfe/M/0KgG5WuAMHjnjfFAvvPXGV4UF6wNMrTuoFiS5ModzDqlO8w6o5
        Fg5GH6t/lubYo5FVi3q/K3GIfOknBdEBJ+g==
X-Received: by 2002:a05:6830:1d9:: with SMTP id r25mr6844853ota.66.1571390532594;
        Fri, 18 Oct 2019 02:22:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmmvS7mOLvPx8Fl3ahvtwE7jlYEpguZAzFke5b9Qml1ZYSev7elY0rpQsxeeAVkhb8JSTsRmeXgUeZYgXV6f8=
X-Received: by 2002:a05:6830:1d9:: with SMTP id r25mr6844834ota.66.1571390532291;
 Fri, 18 Oct 2019 02:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191014080647.19602-1-omosnace@redhat.com> <d6755428-b0bd-1d88-69f7-0dd953eb7300@tycho.nsa.gov>
 <CAFqZXNsMVm2OmWOTiMaKybkhX8Zerp6rDeFfEd0UwhZRiNuNXQ@mail.gmail.com>
 <511ca06c-7786-1b90-4694-a5cb842a8fca@ieee.org> <0a554b63-df42-fbc0-6877-f58c16156a9e@ieee.org>
In-Reply-To: <0a554b63-df42-fbc0-6877-f58c16156a9e@ieee.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 18 Oct 2019 11:22:01 +0200
Message-ID: <CAFqZXNt5eYLMHCOuBBVjxRHSTG6H_FzNhHaHxza9kHC2yF+utA@mail.gmail.com>
Subject: Re: [PATCH userspace] sepolicy: generate man pages in parallel
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: d1-g6ffLNwuLkRv85NH6zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 18, 2019 at 11:01 AM Chris PeBenito <pebenito@ieee.org> wrote:
> On 10/18/19 5:00 AM, Chris PeBenito wrote:
> > On 10/18/19 3:44 AM, Ondrej Mosnacek wrote:
> >> Since there are plans to support
> >> only Python 3 in 3.0+ this may not be an issue, but I could also add a
> >> few lines to fallback to sequential execution under Python 2 for the
> >> sake of compatibility. Would that be OK or should I not bother?
> >
> > Python 2 end of life is in less than 2 months.  Please don't add new
> > code only for Python 2 compatibility.
>
> I can't count.  It's a little over 2 months.  The point still stands :)

OK, I posted a v2 without the fallback.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

