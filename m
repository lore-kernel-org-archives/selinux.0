Return-Path: <SRS0=MRHa=BY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B86EC433DF
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753D8221E2
	for <selinux@archiver.kernel.org>; Fri, 14 Aug 2020 13:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4Pil4/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHNNFc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHNNF3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Aug 2020 09:05:29 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C3C061385
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2020 06:05:28 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r7so4607213vsq.5
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2020 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQ/SjJonqKxF8GqCYSrKygb2G6Do+uwecY0D4M9064g=;
        b=A4Pil4/RFWeLrHcENNRRVSO0/AZSQdJupDPKS5tlWoCkoMkNw06kCszKvafEQDBNHv
         Fi9gfNRoPqBXepsGkmqrtOX93y98u7yeKQdR9BptHKzn1iN0qvbKV+XklXCvXIycIDS8
         69gZm0mb5KAbQD4Kj+hB6+owUxKSpZY2RdMI87ZprMgIIROq76w/r7Cqr4fhZnoEYfpD
         fdNIjnj4h8Vb75FwXG+M5U1CDpUvIuw5hb/UqPBU1tmeBQB2eGp+JEDh6C5QrYMDzfRW
         BQr3Je7R0G+1OXEYD9V4Gr+fL2RnfjE52MNZpkIuFJw6dWKR3dVhWdwAOymjmjgbav3C
         XGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQ/SjJonqKxF8GqCYSrKygb2G6Do+uwecY0D4M9064g=;
        b=jjndvjmkKLJ+XnXRXwScJFWdMFARylIZrRTvc4C8BgrFBX9QhLSgVLJA28DlHq6CPS
         6qxIkRqhBDpwFYsTYEyQzVQz44oy8i7QBlDKE9ZhkI9Y3mwrUhU+p3eW2oDN31LbYG3a
         XaPO8ktpoHVGcEJqEqeCRzBZA9W4z/f8CrZ0P8WN9E5TNA2pNUImyqpeHch53clkrsro
         u4ecOYI/vPbkB68LGot96RU32lBkos0CF3acFSt0/tGWWtpdFNO2lZYnKXsgvkvFOoyh
         JBQ+M+Ya9HcHSP5I5qTHgsBM5rGb1Iu5m5+ep7mZOV/qJY8Zq9KidKjJ/TBbdxZyvKXW
         JvpA==
X-Gm-Message-State: AOAM533CYQiIqqF1jEHsyRSJetmV2dipeXwNZvx130neral+Ddc2bzBW
        EvC3iGeQV2tB1H2KUE8XOxuz0fdOr+WsBmcaORakuQ==
X-Google-Smtp-Source: ABdhPJznfIURwtfqhTJXBe5k3jUmS8MgBLhTdadGFjOpcAaaNn0XsIT2a+H/+tQ/Ig+R9zm/ulURQ0E3g2LcyXnblCs=
X-Received: by 2002:a05:6102:1049:: with SMTP id h9mr1108246vsq.183.1597410322798;
 Fri, 14 Aug 2020 06:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200813144914.737306-1-tweek@google.com> <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
In-Reply-To: <15e2e26d-fe4b-679c-b5c0-c96d56e09853@gmail.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Fri, 14 Aug 2020 15:05:05 +0200
Message-ID: <CA+zpnLcf94HGmE=CGH6nT8ya0oax5orXc5nP1qToUgaca6FeQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: add tracepoint on denials
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 13, 2020 at 5:41 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> An explanation here of how one might go about decoding audited and
> tclass would be helpful to users (even better would be a script to do it
> for them).  Again, I know how to do that but not everyone using
> perf/ftrace will.

What about something along those lines:

The tclass value can be mapped to a class by searching
security/selinux/flask.h. The audited value is a bit field of the
permissions described in security/selinux/av_permissions.h for the
corresponding class.
