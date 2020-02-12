Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FCCC35242
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF29B206DB
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 02:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nS/6sCiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBLCMe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:12:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36139 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBLCMe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 21:12:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id j17so561297edp.3
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 18:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8VNf3lerfB8aOYGiSI7xgTzRgqXGx/zUnXGButZJ5w=;
        b=nS/6sCiE+3nRtv5darPLq7XSlPRJM7DhuOSsGY7uKufKETvtRPGj6Ri7WDXbJu0Kv4
         MIL5JxKjXTcDXjrPZr5tOGI6OUHDfCITdCJVVmoe6vUaPWcEkDl5Vfy0oE0e7KRp6nIu
         BKdPVahWSe47QiaNyehcfPn2QNY2SGn6tPNxFeIEoztwC6jdqEN+5FC446rip/tdBUlm
         GxLYvCMN+swRD+2/IPp64/bmoMXw/BpHmxa2JoHPE3x+Lvtl4Ocf2tBQLXrinUcCxMAt
         H9S+vQAaucPyvcrFzZ0LjrAWpRcJDJmcGiykGz6bMMnkvDwQBOj8FzfAC/jfsDUF5KGK
         gYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8VNf3lerfB8aOYGiSI7xgTzRgqXGx/zUnXGButZJ5w=;
        b=sx8HpkxubpyhyHGV6DLQA3tVU2lcHEfLX326L6uxEVKu3xZ+KsE/4BREvC51wv09V+
         2gJYcA9S9THhyvIPzqWZi3Te9f0pUJniWeSt1kkdBkArCLF1a/090yP+urGQzBZUxuOG
         24dzv0MWaq9C/0TULCDXegJbYYwk55GqwQ1ShODryb9QE7+lSZ6bcDZVCFGE0MHsVWZC
         +Ay2LvlgEgcDywkGEmVIerOMrW7lfLl1DYCg2+z0Sa5PoqUZtpK8xM+tsIC/akrAvL5Q
         gfIG6WDSOGqa8bv9P5orkRUzb403vnKPbW80oRMSdtk+u2ZpBFOEgBhlBjxWVnt7kRsk
         bEFg==
X-Gm-Message-State: APjAAAUN8wzbDuz+SBFM2QcprbwV0SgyzfC6H2TaAO/mX/bQcpmZaF7k
        oo3gGTEEVk6e4ijNlVjk6L+OpaYOsOyHxDNtBeqv7hlJ3g==
X-Google-Smtp-Source: APXvYqxhh6sziWQdD6g+GgPG3AimoLP1B6uY59JrOlC2Oli/dPssvoJftmCf3vtJlYWI4bE6JHI1B85K4wu/6b/dQDk=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr8381982edr.164.1581473551457;
 Tue, 11 Feb 2020 18:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20200131230017.199775-1-richard_c_haines@btinternet.com> <CAHC9VhQ=GQ7smodGjSD1iVOxpWCRNaCV8Ov+LYwZRVXoZWvgAw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=GQ7smodGjSD1iVOxpWCRNaCV8Ov+LYwZRVXoZWvgAw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Feb 2020 21:12:20 -0500
Message-ID: <CAHC9VhQCLhPenD9hR80mH7v=NJXO=K=x6WRu-LoraSpxBwyQaQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Binder goto brexit fix
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 5, 2020 at 6:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jan 31, 2020 at 6:00 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Now the deed is done, correct the final leaving date.
> > Could not resist adding the relevant dates to complement the 'goto brexit'
> > statements.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> > Before anyone asks regarding '240616' It's the result that counts !!!
> >
> >  tests/binder/binder_common.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Without venturing into a political discussion, I feel the joke
> deserves the proper magic number.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

I haven't seen an objection, so I'm going to merge this into the tree - thanks!

-- 
paul moore
www.paul-moore.com
