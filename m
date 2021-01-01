Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E587C433E0
	for <selinux@archiver.kernel.org>; Fri,  1 Jan 2021 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E7B20798
	for <selinux@archiver.kernel.org>; Fri,  1 Jan 2021 07:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbhAAHQj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Jan 2021 02:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbhAAHQj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Jan 2021 02:16:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691E2C061573
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 23:15:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g185so8619841wmf.3
        for <selinux@vger.kernel.org>; Thu, 31 Dec 2020 23:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xduLAXFxdzXXKqCmN2o3I52aOrcGKMyttCzHUkvKEko=;
        b=ynYZV6soQ6kVKaIlcscyz8k90+3y6N5ab8ZB+nWFFIFoofz4dfbPT5tPil0u7MAp6j
         H1fD5/iyKm61mZXUXUA0Sq867U98FJvf+u0GfIL/fcuRDlh98V2yam624VEcHZdXm+PG
         ZkXShQjF19SlrcN+6XHubSrYSWWwMXnrHFHSy1xznmTcBjtn7mgpKq6sny0nzAUcj7+h
         Rujx7xBLfVB0tXPSJqAiO+pQ+J9xQEk5Fq/lkJJDMM3d1cQwodjmmBV3llB4Bn8Dpa6a
         JmhAkpqWOwFQuGLu9aDp471rd6u5BAo7dT3jq6k5vvzNyzPpzcEELnZfoVfJAy1Z57zM
         9eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xduLAXFxdzXXKqCmN2o3I52aOrcGKMyttCzHUkvKEko=;
        b=uOMTgyDBhalsNPiEPdfh7SVqo/RIFfT4nIuCMdo45xZv2wJ7rtfQMH7BHdrNL4ADln
         53s0u9XRGqdAKeSQvq7g226vkGEbPVhQlMI5k+g0PAHmWdxt1BeZ2FSW9+Ve7BFBVUnl
         lHpA1DdeGuLI2Bt4D9jweO33GppDv6uap+jObKEsr7evFRPIU07p5TBbYKSw29/+TUUc
         KNZWzvjGGE6pbZ/tqPNv9oIwd7xKTEcamLKhWS2VDYpUhhiLckqbMke+sfNyp6GiMr6D
         I9/cZmN2MAZ+GBhxBNwVV+GHkk6Fhp9oGfg8kSYTwjhl/F0Yj7FIKNKYjxXrdbij4AWF
         oyuA==
X-Gm-Message-State: AOAM53093mzTBhH/fT/3pWnwd0/wTgsIZ7Rl4pcQ3TUZpGvekjYPQqig
        lOiLKhhZvuo21Kb7Oe4HWQYNjZCbJGuK/EHqrh12OToKjljfFI2w
X-Google-Smtp-Source: ABdhPJyZNqZnMNOptdpgPx9c9V/mET28da3FyIW1d5nX23s4/9TBDyD8Glk2F9zCSTRKmnVvopUE0BoCNACn5cr42wU=
X-Received: by 2002:a1c:1bcc:: with SMTP id b195mr14732146wmb.131.1609485355615;
 Thu, 31 Dec 2020 23:15:55 -0800 (PST)
MIME-Version: 1.0
References: <CAP2OjchiEZH7sxKipY0Q89L6e4mG9By4JYDKXf1HUWp0nWPtRw@mail.gmail.com>
In-Reply-To: <CAP2OjchiEZH7sxKipY0Q89L6e4mG9By4JYDKXf1HUWp0nWPtRw@mail.gmail.com>
From:   Ashish Mishra <ashishm@mvista.com>
Date:   Fri, 1 Jan 2021 12:45:44 +0530
Message-ID: <CAP2OjcgmOz1UDfp0mt-jfO9PetYgRvfBGJrrMPCNNBgUubPvCA@mail.gmail.com>
Subject: Re: Inputs w.r.t understanding of selinux notification and systemcall
To:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Group Members ,

Good Morning & Happy new Year !

Can group member please provide any input / feedback for below
functionality support in SELINUX :

a) Is there any mechanism to generate an event / notification for
selinux denials
     I came across Logstash, Logentries and Splunk , which i am
currently looking at.
     Is there any selinux equivalent plugin or any other way for
selinux specific.

b) Is there any mechanism to block certain system call / library calls ?
    I came across "seccomp" from https://lwn.net/Articles/656307/
    But is there any selinux equivalent plugin or any other way for
selinux specific.
    or "seccomp" should be the preferred way for this task .

Any pointer / feedback / inputs will be helpful on the same


Thanks ,
Ashish
Thanks ,
Ashish




On Sun, Dec 27, 2020 at 2:17 PM Ashish Mishra <ashishm@mvista.com> wrote:
>
> Hi All ,
>
> For one of our internal projects we wanted to evaluate the functionality below .
> Can group member please share any input w.r.t below aspect can be
> implemented or any pointers on same :
>
> a) Is there any mechanism to generate an event / notification for
> selinux denials
>     ( like say we have an action which is denied , so instead of user
> reading log
>       file if there is any notification mechanism which can be used )
>
> b) If there is any mechanism to block calling of certain system call's
> / library calls .
>    ( idea is to discourage certain instances of container to avoid calling some
>      predefined system call & library functions )
>
> Any pointers or comments or feedback on these two points will be helpful .
>
> Thanks ,
> Ashish
