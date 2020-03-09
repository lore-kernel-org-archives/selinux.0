Return-Path: <SRS0=v7Ke=42=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D6C10F29
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7640020873
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/NsmG9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgCINkj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:40:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46183 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCINki (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 09:40:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id a22so10080123oid.13
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 06:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FA0aiCPgFhTTad337WT/97xTcb21dMFq9GTSqz5o6/0=;
        b=a/NsmG9HdYpqxkwOBOcOOxdHCd2kS8du+Qt/DtO0IaPCZAjNapDdnyExP2ufoBSWah
         6/D39HotfDZi6b6jwPPV1dc2ajccAzWzykfVIuKe3OfEWPUDGH0NuWlINUn4ijGX5Khk
         7PDL5DenFvXjFlk8OVDJy52RUfGrnWl8JWALpCTtOl+jOV+97Mlfz3vvbc4fPm6hB4kQ
         PF9sIEgxJCRdjMNsDhlgANEaXlnk/6pV4PJcZ97GQrAboBN31r7cUJqpbw9F3i7lqGuq
         xt+Vgok3WCJJtNVkOTgC136WtCZBLLITnFgSwSe9dkcwEX33n6HKbBLtyvBJcnwdQ7eF
         HfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FA0aiCPgFhTTad337WT/97xTcb21dMFq9GTSqz5o6/0=;
        b=aqNtebrw/D4ce4rTLG537EBnpMpH0EIipUFW83i0KU2Oy9f6JiMca3wBJ1cQ+Mh1UQ
         Dfsp8tcIumph7cGwgPOmHhs2Gpj1LjIReU/4rarcxo5DH0+l1Gjn4B7awwnlR0YD6NZ9
         05XtutjNUGVj4JVW/S9G5amAumKfOWCDHqxQL6Kuys1O9qlaBjRR/Hk198/SNegCbrl4
         UhR/NNEcJj4Nmp5pIATGDkViJDdxkKHaK1MNkgnBk7lMwka5LByh8Zyyd+C6FSuqBaYM
         bmMufk0+JvX41JJ4TsAzB43wGjwgimXzB67M3amzv+oWvjxVrDS1yTTqDTWcQaxhWJu4
         T5XQ==
X-Gm-Message-State: ANhLgQ0eOYH+w2aSHsQMh1bBjUM5MaRjBih34vjQIz3cDbYoDsEoQlxf
        IDjjSdcElWArn5yG8NogOyJZ22UacIDnbtb27Ek=
X-Google-Smtp-Source: ADFU+vtQRxz20pjyAL4bTBrm4wbIoq3qCvJPuhRLjscCJsroYSnh0b0TO9oJFPZZtpXWsvxPyOSz1gEqLyFgSoL+RG8=
X-Received: by 2002:aca:ad54:: with SMTP id w81mr11620730oie.172.1583761237393;
 Mon, 09 Mar 2020 06:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200305184034.165554-1-dburgener@linux.microsoft.com>
 <CAEjxPJ5OZpvvrWq9h1xYudLwZFgHj6nyr-uPnFqxoGEv91fk2A@mail.gmail.com> <f7d669b6-25bc-699c-5bc7-f7dbc12b3a24@linux.microsoft.com>
In-Reply-To: <f7d669b6-25bc-699c-5bc7-f7dbc12b3a24@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 9 Mar 2020 09:42:14 -0400
Message-ID: <CAEjxPJ626xX1QV8=+iThX4gDm01tjeKtPiZg69but6q_aDw16Q@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Add --werror flag to checkmodule and
 checkpolicy to treat warnings as errors.
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     James Carter <jwcart2@gmail.com>,
        Joshua Brindle <joshua.brindle@crunchydata.com>,
        pebenito@ieee.org, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 6, 2020 at 9:16 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 3/6/20 8:57 AM, Stephen Smalley wrote:
> > On Thu, Mar 5, 2020 at 1:40 PM Daniel Burgener
> > <dburgener@linux.microsoft.com> wrote:
> >> When the lexer encounters an unexpected character in a policy source
> >> file, it prints a warning, discards the character and moves on. In
> >> some build environments, these characters could be a symptom of an
> >> earlier problem, such as unintended results of expansion of
> >> preprocessor macros, and the ability to have the compiler halt on
> >> such issues would be helpful for diagnosis. Signed-off-by: Daniel
> >> Burgener <Daniel.Burgener@microsoft.com>
> > I'm trying to remember why this particular case (unmatched character
> > in the lexer) isn't already a fatal error. If there isn't a real
> > reason for it, we could alternatively just switch it to use yyerror()
> > in that case. Otherwise, your description suggests that you only want
> > to make that particular case a fatal error; are you sure you want to
> > treat all warnings as fatal errors?
>
> That's a bug in the description rather than the code.  That particular
> case is what caused me to want this option, but my intent was to add an
> ability to treat all warnings as errors.  I can resubmit with a better
> message if you'd like.
>
> I'm not sure why the behavior is that that particular case is a
> warning.  Git blame shows it as going back to the import from svn, so
> it's been that way for a while.  I'd think that --werror would be
> helpful either way.  If no one has a reason for this particular case to
> be a warning rather than an error, I can submit a patch for that change
> as well.

Ok.  I have no objections to your patch, just wanted to make sure it
is doing what you really want it to do.
I'd also be willing to accept a patch to make unexpected characters fatal.
