Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FB6C4CEC9
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC2721907
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 14:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVLnYqH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfIROL5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:11:57 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43048 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfIROL5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 10:11:57 -0400
Received: by mail-wr1-f54.google.com with SMTP id q17so7070277wrx.10
        for <selinux@vger.kernel.org>; Wed, 18 Sep 2019 07:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XyPZAgRpurbbTaM2ZSaVHCkzWNORzkvSs9D8YKisRM=;
        b=JVLnYqH14nmLA87XxKwQLI4zPKC1sAK5F1PL1zgVNny5wa3REhret5w8kE3LBFuwmT
         PKhs4m8MgU0nAqvo58MY5ncqJR2aMhPhHo37yFCZ3Xg/YXzN+7Ge15XZQ6wr2YqkUevW
         wX4R7Q2r3L5YMUvUvjMYoRLkssNaR+vrwVuO5r+CZ2zVpkftDh3F5M/HYHrJ+W+ikr1A
         oC3P+gJPPZSRWtXnjw8DFVb7e2zTN/Fflsdk5Jx21lOc5JlPgPHEqT3QpmfPpSuIViqF
         n9M5M5G/HVaZPXMml5F4mPFnPr7ixPIiqpcuR7MZGJWyMcnXR286117iAUe0ZQaTHKHA
         A5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XyPZAgRpurbbTaM2ZSaVHCkzWNORzkvSs9D8YKisRM=;
        b=Gz9Q7MwdyVDMFPL5snQj6YWlIDnBHczxQPxJlGbJddYqK94JIkDgBydgkOmK8bLCfR
         6VpOPDKUmxZvSSt/9fMSHWe0y8CayhXG3CnHyuXXDV10RTN6kPa48rYrLIXoADtg64Qy
         l1CotYajgjGB5FpP5V+m03/8RxrRzzUgto9dFqN/AhNI0eIimiNcPCrd/k6KEb0p73OP
         PJrhHZlQzgBedGUiEcDq1Qlk0fOYBb70U3hD5LHbE9sLT0/vaiSpQB6+OamZ5QtLMI0W
         owZ3V1bBTtlkctgGAW9nIJ17DxASHqo16dfIhiXYgVh/vyjbpfXYr1udfgYirPic+qdc
         1Ydg==
X-Gm-Message-State: APjAAAXauJBTPcXhNPudcJeShAPMJE9YwPwvaNfq9wJHkOBkElwYZGoV
        PMvRyerVa/rcre0EGjNK7p6sOqhQz+wPevwmrKk=
X-Google-Smtp-Source: APXvYqyoGFxPjulOIi7qkjn08Enj63NBV4MG47Q4OMZQ5il4P6B/ZPPAtAjhK7jAUt54R0+k+c8I7Aku5DbDBCcMK4Y=
X-Received: by 2002:a5d:6844:: with SMTP id o4mr3467534wrw.188.1568815915665;
 Wed, 18 Sep 2019 07:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <ac6433e2-88a4-747c-66f5-d241499f40d6@tycho.nsa.gov> <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
In-Reply-To: <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Wed, 18 Sep 2019 09:11:44 -0500
Message-ID: <CAFPpqQF4tta40msr_=Pqe2bta9GPi+qqEWzY8qFJ6iEazW+_KA@mail.gmail.com>
Subject: Re: strange tclass in AVCs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 18, 2019 at 9:03 AM Ted Toth <txtoth@gmail.com> wrote:
>
> On Wed, Sep 18, 2019 at 8:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > On 9/18/19 9:35 AM, Ted Toth wrote:
> > > I'm seeing things like tclass=context#012 in some AVCs what is this telling me?
> >
> > Just a guess here, but octal 012 is '\n' aka a newline character, and
> > libselinux/src/avc.c:avc_audit() appends a "\n" at the end of the buffer
> > before calling avc_log() to log the entire string.  avc_log() will call
> > the logging callback, and dbusd does define one, which calls
> > audit_log_user_avc_message().  Maybe audit_log_user_avc_message() is
> > escaping the newline character in its output as well as appending
> > additional data.
> >
> > I'm a little unclear though on why dbusd is checking a context contains
> > permission?
>
> These appear to only occur when systemd is starting the dbus daemon
> and they end up in /var/log/messages not /var/log/audit/audit.log as
> I'd expect.

Maybe audit isn't up yet.
