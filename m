Return-Path: <SRS0=gl5k=5J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8BC43331
	for <selinux@archiver.kernel.org>; Tue, 24 Mar 2020 16:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0D92076F
	for <selinux@archiver.kernel.org>; Tue, 24 Mar 2020 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB7A1/Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCXQjE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:39:04 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36939 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgCXQjE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Mar 2020 12:39:04 -0400
Received: by mail-ot1-f41.google.com with SMTP id i12so17671619otp.4
        for <selinux@vger.kernel.org>; Tue, 24 Mar 2020 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZmALmNLuUuBJNw1Iup4YijYOdGUl/T0DvyMVKynktc=;
        b=gB7A1/NclsQgFSs/OboFHC9zoGwFWslU9QzkC0NLFE/0J7Zt3OMy9eB/JQ4UTaKJAd
         gNEpiRPCbAgKOVOiCrMhUlYVrfE9l3EYUyBK+L8O5SOFkjBYipJAkWP7X0Kc6tLWUHK+
         3g0Pe16HiIrD9HpEW2zBh70Y7aKtFHbRdZi35I+faUqRek86GYMVf2caO2d9h6HvBfoZ
         wHQLSXvlcpC+7Ow0h9lUnGeiKQhf1sO7tXXCN32BLiSPJp8YGwBWEI4bkEbrPkqD8zJF
         m2fjPnojVBd0B8i/OjWtoTVfahylKoowKNwamSUcEovxxaR7Qv78p8nfgMNmAWSv3BNG
         HItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZmALmNLuUuBJNw1Iup4YijYOdGUl/T0DvyMVKynktc=;
        b=G5uwc4qlHMTR5ViczbgL+tujZ4JK4dhcHsIiLj+Yn51zahL6rizLsr8x45oh/o+gjj
         UhwZ/x7C70cfBDbcxsKOwuPGjyGHH27mEWlW+PAPudIhpjvE68lcIL3FdqBVU4UD4/xL
         UoGTM26EW3AYQ+/2VSbOLrOhW2GKsz/jkUPmWD8usBAdwQcYExtb28D1Tcb0dGw6o3Ai
         zqoU8668ojHmaz+vBroj1kbCWzj1u3HOuMHlQxmmehKCmEHOd80rkh1axfSltMF9acJ6
         KXFRoFV8KhnIWbel1vsiUbyUXJaqcA6gIBmmFwo6jOHSZ6BD3mFn2X2z1tKpjNhaiNKw
         nbbA==
X-Gm-Message-State: ANhLgQ0Amt/xRKKJyyaDKhT8BEZow7uqlfeITsvhvRwVo1eWIYPDLWWC
        8o5r1LZUnpXvLHTv/1rMNZ6uKzkWzhC9ObGGIro=
X-Google-Smtp-Source: ADFU+vv/dzttWllLPqL2St5swDapM3rw1JwJQ4qtloNsOvW4ut4A2Kyg7to0TlXjHJVBhsbR0CV2JTrO9QnbnP5zftg=
X-Received: by 2002:a4a:6841:: with SMTP id a1mr2264071oof.18.1585067943144;
 Tue, 24 Mar 2020 09:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQERRB3ZJv-+gytzt5AE6y0o+UE3vF+cBb=OAaFrcRKn=Q@mail.gmail.com>
In-Reply-To: <CAFPpqQERRB3ZJv-+gytzt5AE6y0o+UE3vF+cBb=OAaFrcRKn=Q@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Mar 2020 12:40:12 -0400
Message-ID: <CAEjxPJ5uwCJ_-r9Pa_bdO7yM5AovNAomfT4pkeXCWaDNdgwAWQ@mail.gmail.com>
Subject: Re: testing for disable-dontaudit in C code
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b4694605a19c63b6"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--000000000000b4694605a19c63b6
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 24, 2020 at 11:15 AM Ted Toth <txtoth@gmail.com> wrote:
>
> Is there a way to test whether semodule has be run with
> disable-dontaudit? Or better yet a netlink socket event?

Something like this?

$ make LDLIBS+=-lsemanage checkdisabledontaudit
$ sudo semodule -DB
$ sudo ./checkdisabledontaudit
dontaudits disabled
$ sudo semodule -B
$ sudo ./checkdisabledontaudit
dontaudits enabled

There isn't a specific netlink notification, although you could
register for the selinux policyload
notifications and check at that time.

--000000000000b4694605a19c63b6
Content-Type: text/x-csrc; charset="US-ASCII"; name="checkdisabledontaudit.c"
Content-Disposition: attachment; filename="checkdisabledontaudit.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k864icx90>
X-Attachment-Id: f_k864icx90

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHNlbWFuYWdl
L2hhbmRsZS5oPgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7CglzZW1hbmFnZV9o
YW5kbGVfdCAqc2g7CglpbnQgcmM7CgoJc2ggPSBzZW1hbmFnZV9oYW5kbGVfY3JlYXRlKCk7Cglp
ZiAoIXNoKSB7CgkJZnByaW50ZihzdGRlcnIsICIlczogQ291bGQgbm90IGNyZWF0ZSBzZW1hbmFn
ZSBoYW5kbGVcbiIsCgkJCWFyZ3ZbMF0pOwoJCWV4aXQoMSk7Cgl9CgoJcmMgPSBzZW1hbmFnZV9j
b25uZWN0KHNoKTsKCWlmIChyYyA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIiVzOiBDb3VsZCBu
b3QgY29ubmVjdCB0byBwb2xpY3kgaGFuZGxlclxuIiwKCQkJYXJndlswXSk7CgkJZXhpdCgxKTsK
CX0KCglyYyA9IHNlbWFuYWdlX2dldF9kaXNhYmxlX2RvbnRhdWRpdChzaCk7CglpZiAocmMpCgkJ
cHJpbnRmKCJkb250YXVkaXRzIGRpc2FibGVkXG4iKTsKCWVsc2UKCQlwcmludGYoImRvbnRhdWRp
dHMgZW5hYmxlZFxuIik7CglleGl0KDApOwp9Cg==
--000000000000b4694605a19c63b6--
