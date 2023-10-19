Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70083CDB483
	for <selinux@archiver.kernel.org>; Thu, 19 Oct 2023 01:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjJSBj1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Oct 2023 21:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJSBj0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Oct 2023 21:39:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1615FA
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 18:39:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so7477960276.0
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697679561; x=1698284361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vX68/OE0qLrF3A1/NDlCjZF1ajE8ZMP/wy8PcFgCC1k=;
        b=B/hriZb/a5usUFTona5xSSGqFGx7M7E+IQoS3ZNjotoDDqZoV2dWm77wY8kONdLpMi
         N1XfykBCX1djn41p8RS7XMmDUowa3OP5AGT0mp4MQbIQZ6RRVQgB8apci73hwTR4ETbG
         p0fUcSOar50eWTrlnQjWQmv+TuMa8nhx/RAoIK9QlbtHYk8066iD5kEeRtTJXtijmwLn
         2TnHslHatbWcO+iatBIhBDSXlPgZbIA10sVt6AgKHuk4YlXxeRSCceqeBiDHOdMUvbxP
         zAKAJNby7R85c1iq1QJtEkEGUMIsh3vYjRTAfnoYpeUj4DgnNMDe2dL1SQvgapZKCN7k
         zWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697679561; x=1698284361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX68/OE0qLrF3A1/NDlCjZF1ajE8ZMP/wy8PcFgCC1k=;
        b=im69B78pQ5EH5aw4kX35U09cIGa0qfQUZjGVc4WK/K9t1gDIauN8eXuWi/4LYK5fSY
         CjyXbrJZzl7opZv3ZOVXBp36xUpuBM7pCAMwLPPphuFdhfMbxZY7oblOt15U9x5gOlaV
         z3fpZLjUobCRNxS+TCottstofhydtPCBAMjXC6E3XVTyg2pi7Uk/m56o6X+xno5xTTBX
         wE8+8iRwO7CPkR6bZolFpQMS9PL515XASSKU25WlQD9rULRlg7sSXRe6Hez4mnXISf9C
         BBRWL/tmrE+fSLOV00BV7lOlu98c4G9VzwvXtrHvwf9L1Ya2MJrMz6n/NPb49Y6uAGEf
         gMrQ==
X-Gm-Message-State: AOJu0YxjeGwF2nXxpjvU+AvdFlHgUeGdNWAnjI/lJUiSHYo/LI0nU310
        duTRCIbpHF9tPCNqNamQJ+UUSZjfqwvIcGNU7RawNwwjYKSDW3M=
X-Google-Smtp-Source: AGHT+IHhIoDNFAW1nx6xHUnFoODV7tpJlxCRuJvySLom8kFciPpNz1TSp3WvEUHvnPNxYR6g8vN0WkWsdcb6Dfh3VC4=
X-Received: by 2002:a25:ada4:0:b0:d9a:4da4:b793 with SMTP id
 z36-20020a25ada4000000b00d9a4da4b793mr1172039ybi.62.1697679561081; Wed, 18
 Oct 2023 18:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTToc-rELe0EyOV4kRtOJuAmPzPB_QNn8Lw_EfMg+Edzw@mail.gmail.com>
 <20231018043532.GS800259@ZenIV>
In-Reply-To: <20231018043532.GS800259@ZenIV>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Oct 2023 21:39:10 -0400
Message-ID: <CAHC9VhSx0UiHyQYR-=va4X0r3XpEFz9n9f96DkQ9bhbB97RnnQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 18, 2023 at 12:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Tue, Oct 17, 2023 at 04:28:53PM -0400, Paul Moore wrote:
> > Thanks Al.
> >
> > Giving this a very quick look, I like the code simplifications that
> > come out of this change and I'll trust you on the idea that this
> > approach is better from a VFS perspective.
> >
> > While the reject_all() permission hammer is good, I do want to make
> > sure we are covered from a file labeling perspective; even though the
> > DAC/reject_all() check hits first and avoids the LSM inode permission
> > hook, we still want to make sure the files are labeled properly.  It
> > looks like given the current SELinux Reference Policy this shouldn't
> > be a problem, it will be labeled like most everything else in
> > selinuxfs via genfscon (SELinux policy construct).  I expect those
> > with custom SELinux policies will have something similar in place with
> > a sane default that would cover the /sys/fs/selinux/.swapover
> > directory but I did add the selinux-refpol list to the CC line just in
> > case I'm being dumb and forgetting something important with respect to
> > policy.
> >
> > The next step is to actually boot up a kernel with this patch and make
> > sure it doesn't break anything.  Simply booting up a SELinux system
> > and running 'load_policy' a handful of times should exercise the
> > policy (re)load path, and if you want a (relatively) simple SELinux
> > test suite you can find one here:
> >
> > * https://github.com/SELinuxProject/selinux-testsuite
> >
> > The README.md should have the instructions necessary to get it
> > running.  If you can't do that, and no one else on the mailing list is
> > able to test this out, I'll give it a go but expect it to take a while
> > as I'm currently swamped with reviews and other stuff.
>
> It does survive repeated load_policy (as well as semodule -d/semodule -e,
> with expected effect on /booleans, AFAICS).  As for the testsuite...
> No regressions compared to clean -rc5, but then there are (identical)
> failures on both - "Failed 8/76 test programs. 88/1046 subtests failed."
> Incomplete defconfig, at a guess...

Thanks for the smoke testing, the tests should run clean, but if you
didn't adjust the Kconfig you're likely correct that it is the source
of the failures.  I'll build a kernel with the patch and give it a
test.

From what I can see, it doesn't look like this is a candidate for
stable, correct?

--=20
paul-moore.com
