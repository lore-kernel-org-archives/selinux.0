Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54307C3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A9821775
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 18:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbiwGwZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCBSya (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:54:30 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:40071 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSya (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 13:54:30 -0500
Received: by mail-oi1-f173.google.com with SMTP id j80so288812oih.7
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nrIYwJsX0FBLw2q2orjMNQeuq9J3c1sWQnDZ/WdP9NA=;
        b=vbiwGwZzhXEJNhLgnDbintEr52KQmJLjzTxXI9udHaDUD3SAsMEWaeRx5Du7bevq7A
         F6FXQXewTkHwQnq6hd6nWJl4LUqRNHp/H+KLKVHolNZUwwXuRoPBh2YnqgpjyRZo8r96
         dJqZRnmLVYI4fS4SpMty6X6NrJ/E6Wh01JM0wxMnTBk7Hh7PZh9sa2vY+nY9GO7SCwTQ
         1j6uK7ubl5tX5kBgUy76FrgmaQ9lOLAKYJfKvx9JgA395qSae4IGUN+V0Gfx6rWcapYb
         OsTyCtysBhv+gmbRPl3Op9bhcDCv9MsgHsY4Yq7MwqrtRHygZm4UeuzvZr/eRVlxFdBR
         C/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nrIYwJsX0FBLw2q2orjMNQeuq9J3c1sWQnDZ/WdP9NA=;
        b=QFZHFXIji6ZC3E9I6h0vawfkGs6q66JG7vu0ehHkzeUVzY9ZQ9qy3yvHioGuzdo/Pa
         1ROttc0U2r+1JE2veQ1awXPwRW5PRrIsLXiq5jOMomSRCKUi/au3J8sCZ0y5iyUq38/L
         kPbneQ9qa3Y6/i3fMkwqLgxbwlHasF5cQJhE/Gx8rHpy5WmYWW+6zPCMCo9kpjDkoCEJ
         dXE5Gpcv13PhEmNTMqTw4RMav0/BWG3MNqFNMIz3Iadg5piO4RKxT89tFgcJl3h/GJo0
         CiGrEminGQH3wvBecYoN0Wrp1jy0hL8qXjT6r3hCfu102tgLUTmCx5sLDEOrcHcAnNNj
         44Jg==
X-Gm-Message-State: ANhLgQ0NXdF1iskMWzFiQvJmduCCOQf+s4vm1MVyrAv6XCzq789626DN
        4XM8lQRira2Wd19NmPflCkhCcn6ca3TPYZo146Y8Tg==
X-Google-Smtp-Source: ADFU+vv5pBImNMFDrfO5MtrHsV34bRbzYgGe89flU+7WeLWKxLuY75qdMU/I9EpOU5K7rEuVdHixzi9mFu3c27C+t4A=
X-Received: by 2002:aca:ad54:: with SMTP id w81mr3691oie.172.1583175269828;
 Mon, 02 Mar 2020 10:54:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_DdmVfru8dcuEqeQkceVv_UskSYBw=qickHG6SOCEAbPsA@mail.gmail.com>
In-Reply-To: <CAJ2a_DdmVfru8dcuEqeQkceVv_UskSYBw=qickHG6SOCEAbPsA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 13:56:16 -0500
Message-ID: <CAEjxPJ6XdUe5zUTLxiHGBqa9AsiYT7JLVhdg=x9m6qerAg09rA@mail.gmail.com>
Subject: Re: target context of security:setbool permission check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 10:44 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Hi,
>
> currently the target context of the security:setbool permission check
> is hardcoded to the security-initial-sid.[1][2]
> Nowadays it is possible to label the boolean pseudo files via genfscon.
>
> Is this by design or did nobody yet make it possible to base the check
> on the actual file-context?
>
> Or is the current access limitation to booleans via the file:write
> permission to the boolean pseudo-files sufficient?

I would think the file write check suffices if you want that level of
granularity, while keeping the setbool check as
a coarse-grained control over who can set booleans at all.  setbool is
also used to control the ability to commit
pending bools.  Most of the security permissions predate selinuxfs
itself and harken back to the original system call interface
although that wouldn't be the case for booleans.



>
>
> [1]: https://github.com/torvalds/linux/blob/b1dba2473114588be3df916bf629a=
61bdcc83737/security/selinux/selinuxfs.c#L1234
> [2]: https://github.com/torvalds/linux/blob/b1dba2473114588be3df916bf629a=
61bdcc83737/security/selinux/selinuxfs.c#L1290
