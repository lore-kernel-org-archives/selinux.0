Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F4C7619A
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 20:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDLUBc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDLUBb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 16:01:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795362D55
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 13:01:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50506ac462bso552721a12.3
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681329685; x=1683921685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om6MyzF2kNgGSuQwSm4lUO4lNXWwben4ffrJjzSLTUo=;
        b=SzLuD+qH+viUUZNiLZKL4mKaUzsPa6XQENmMXtu3POazYT+QN2iqDiWtUN9K23L2Ff
         KdyTwAn5dp87EBZTDM87adgXhwOjqbMg3c6s9o23PkLAcQ1h+gKapnKjxFNHiv65U6V2
         ywkSympTyMxpsKjKs9if4bFhqJp+zVYKbvtmVAo33dsMa9MFkGpWL4rHB8LoyopaeNBx
         XhMb4ExStAHCQUCyJu9SlwSY8Tt7L3nmuPRNAIK7eSLaj1VEM9hFSKwtoA0IxOl+wR/O
         IcSz3AJ2KnL+XCNH+oXBmShhL6K6qBUgLF8NpbI07ISoe1n9bSoQerJmU5wxp45v4QH4
         r4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329685; x=1683921685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Om6MyzF2kNgGSuQwSm4lUO4lNXWwben4ffrJjzSLTUo=;
        b=DdXyqL2biQnxz0F2OuKAe4eerkmVi63+HrqBwB5fprepl/LKIvwES3UdsborvD8O1/
         25qup94BAMBXFuUiCljDhHvnytHmkn9pySoWQap72xxOJlYJIDqqg4xXckcQdJ4F70aX
         /xUAVlaqmz/o7ZFcVmbieYLoV+YA17u9tOER0aJqDfbUZwvD3aDRfArVIhS7zcPvbinH
         DROhx5zBQWuP1G82VwA6MD1uOJP+/xPrNXd+Uf8+JUUENnE/evJu2+IZbmUEJE35Ckkw
         FdUvcy6M8RBe1gHVkeO79hL5pJhWTlQGM6OOFrBjRgI4WQicDmXnfhV5sIuV0CgWkmOX
         o+jw==
X-Gm-Message-State: AAQBX9dwcFkQUpI/RGbamKBhRmU1LWEp+5eJyJPDSc6FSbrr0RSKATwK
        0fYrvRnUK8DKV3iaW1Z3qBzXDIfg7eRCuGuSOQB2mTFk
X-Google-Smtp-Source: AKy350YU0rMVSLfruG/VYJ/E4MUHSOFeWCUIOqisW6nDxHFXIoR07nIwYBfYcG//GWwOipHVW7Ohoz6HOnWYdAasmgE=
X-Received: by 2002:a50:bb62:0:b0:504:b2dc:83cd with SMTP id
 y89-20020a50bb62000000b00504b2dc83cdmr1807082ede.4.1681329684768; Wed, 12 Apr
 2023 13:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOdf3gqCNHoFT_U8cDTy2v8oB-UKmzJn-hyai8Cn9=Zk7uuTsw@mail.gmail.com>
 <CAP+JOzReUxaxCDwdF57QuV0UqsNKBzcKk2M_PqUFLg_W-1kRsQ@mail.gmail.com> <CAOdf3goJUzhbBBcLX7wOsLzMn1dnnoANgVXePzzArU+9ZgR+Qg@mail.gmail.com>
In-Reply-To: <CAOdf3goJUzhbBBcLX7wOsLzMn1dnnoANgVXePzzArU+9ZgR+Qg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Apr 2023 16:01:13 -0400
Message-ID: <CAP+JOzQ7KLi_s03W95-ogZnqprg93UGjXGiHPoSTvZXaa53LbA@mail.gmail.com>
Subject: Re: portcon tcp 80 change type
To:     Etienne Champetier <champetier.etienne@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 12, 2023 at 1:55=E2=80=AFPM Etienne Champetier
<champetier.etienne@gmail.com> wrote:
>
> Le mer. 12 avr. 2023 =C3=A0 11:21, James Carter <jwcart2@gmail.com> a =C3=
=A9crit :
> >
> > On Wed, Apr 12, 2023 at 1:12=E2=80=AFAM Etienne Champetier
> > <champetier.etienne@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > Is there a way to ship a cil module changing the type of port 80 ?
> > >
> > > ie something like
> > > > (portcon tcp 80 (system_u object_r websm_port_t ((s0)(s0))))
> > >
> > > When I try to install such module I get an error, I guess because por=
t
> > > 80 is already defined
> > > > Problems processing portcon rules
> > > > Failed post db handling
> > > > semodule:  Failed!
> > >
> > > Best
> > > Etienne
> >
> > The portcon rules are all in the base module.
> >
> > You could do the following (on a Fedora system):
> > 1) Extract the base module into a cil file
> > semodule -cE base
> > 2) Modify the portcon rule for tcp 80
> > 3) Install the modified base module at a higher priority
> > semodule -X 200 -i base.cil
> >
> > The original base module will still exist at priority 100.
> > You can see that by doing:
> > semodule -lfull
> >
> > You can remove the higher priority module later by doing:
> > semodule -X 200 -r base
> >
> > That will revert you back to the original base module.
>
> Thanks for the hack, indeed modifying base could be a solution
>
> I'm still wondering why the limitation exists (I only tested on Alma 8),
> I can ship a portcon rule in a .cil module if the port is not already def=
ined,
> and ports.local is basically just portcon rules,
> no special modifier to say that we are modifying an existing ports
>

The problem is that only one rule can apply to a given port. If you
have multiple rules, then which one do you use? If you just use the
last portcon rule, then the ordering of rules becomes important. In
CIL, we did not want the order of the rules to matter. If you used a
special modifier, then you still have the problem of what to do if two
portcon rules used the special modifier.

If all the portcon rules were in a separate module, then we could
probably modify semanage to track portcon rules and update that module
as necessary. But there hasn't been much demand for that.

Jim


> > I hope that helps.
> > Jim
