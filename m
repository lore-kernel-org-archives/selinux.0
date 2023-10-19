Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302A7CDB483
	for <selinux@archiver.kernel.org>; Thu, 19 Oct 2023 13:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbjJSNDU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Oct 2023 09:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjJSNDN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Oct 2023 09:03:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD17198;
        Thu, 19 Oct 2023 06:03:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce2988d62eso364087a34.1;
        Thu, 19 Oct 2023 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697720590; x=1698325390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrbctvwUdJjoFDMB39ofux9myN+UyVqHAZvecjGxGQk=;
        b=hyYrZPihzsIiEnizqvyT9GOBFPlpZDMam3dFqxXdqkfbxDq3poqajsXuF7JERY2adx
         xtbM/EdRIwoJ+CL0W3qxDpEpAkMFyMNhtNJIIqTtZhe5NKG2OxoxN3U8LN4imrZutKgg
         R+W4NLA0cycEjOXXM4xqTxD2UDm2/YVhgRZSzSQFXP14VoPDFFgAZ5EmZHecj0ZV+Dh2
         FAtxXleh6LZ1+D7Ezw4TNOOeV3DngZacyA1p3j1j5+41AU+SMe4BxpyV9kMyPDWxdQA0
         /OYc9BOcdFy1paLeG6uP6JW7CtlKwGdIDFJ5LyFO2UrPMR00+PNiHiVV3nZKst0WWIB/
         7Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697720590; x=1698325390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrbctvwUdJjoFDMB39ofux9myN+UyVqHAZvecjGxGQk=;
        b=OEZzkCTEudSPcyFvNFhwi88zZvhLWPuIdlpCnyZ6H0bDAxvvQEM1PTQ+IBXphDgIbn
         GqqJHmuJArfkZBV2/MbNq4MV3KmsixhWL7E+89TyBrdlH+c0OkEl4UYuOfdY/u/TsXOK
         gazT1KAwypmnPgiD5zJ0LlXFaDQl3OekaUQ9yVMEWp/s6wZG4fKJ+iZHQn9STaHbZi13
         SjSyvZQvSUrne61Eye0ZYzWWBaR+ot+0YPW6bn0zv5+LfnftZ4c4FtVb1sU8+ncDzh/n
         dXvAvDHF+++PYE9Sv+wfDUmB4nTwYacy75jc9/+WgWKuL7ZK23pZOA0YKvKRTQbwdHeA
         rf3Q==
X-Gm-Message-State: AOJu0YyRvoAu+CNgWOjXGwMxfa7ctg749Z7kjs+vocrYIeZYCJlJaM43
        +oJZR2u9uWXAVTaVbFzfuEImw1MUh0Osy1HNOG0=
X-Google-Smtp-Source: AGHT+IE/5Atx+eyvSwnNFpj6hHaOhQKFVZ7HWKWxYDUzAGdLQ9ty+OD0UGqt1Bms3c9wXOiRcP906iq8LA/zGrzptU4=
X-Received: by 2002:a05:6830:16cb:b0:6bc:8cd2:dd97 with SMTP id
 l11-20020a05683016cb00b006bc8cd2dd97mr2053350otr.29.1697720590232; Thu, 19
 Oct 2023 06:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV>
In-Reply-To: <20231016220835.GH800259@ZenIV>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 19 Oct 2023 09:02:59 -0400
Message-ID: <CAEjxPJ5gdkXcpco3Y8xLTpia7QHoP+zL82pzZNXvEOnpzW=i1g@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> [
> That thing sits in viro/vfs.git#work.selinuxfs; I have
> lock_rename()-related followups in another branch, so a pull would be mor=
e
> convenient for me than cherry-pick.  NOTE: testing and comments would
> be very welcome - as it is, the patch is pretty much untested beyond
> "it builds".
> ]
>
> On policy reload selinuxfs replaces two subdirectories (/booleans
> and /class) with new variants.  Unfortunately, that's done with
> serious abuses of directory locking.
>
> 1) lock_rename() should be done to parents, not to objects being
> exchanged
>
> 2) there's a bunch of reasons why it should not be done for directories
> that do not have a common ancestor; most of those do not apply to
> selinuxfs, but even in the best case the proof is subtle and brittle.
>
> 3) failure halfway through the creation of /class will leak
> names and values arrays.
>
> 4) use of d_genocide() is also rather brittle; it's probably not much of
> a bug per se, but e.g. an overmount of /sys/fs/selinuxfs/classes/shm/inde=
x
> with any regular file will end up with leaked mount on policy reload.
> Sure, don't do it, but...
>
> Let's stop messing with disconnected directories; just create
> a temporary (/.swapover) with no permissions for anyone (on the
> level of ->permission() returing -EPERM, no matter who's calling
> it) and build the new /booleans and /class in there; then
> lock_rename on root and that temporary directory and d_exchange()
> old and new both for class and booleans.  Then unlock and use
> simple_recursive_removal() to take the temporary out; it's much
> more robust.
>
> And instead of bothering with separate pathways for freeing
> new (on failure halfway through) and old (on success) names/values,
> do all freeing in one place.  With temporaries swapped with the
> old ones when we are past all possible failures.
>
> The only user-visible difference is that /.swapover shows up
> (but isn't possible to open, look up into, etc.) for the
> duration of policy reload.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
