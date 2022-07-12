Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB719C43334
	for <selinux@archiver.kernel.org>; Tue, 12 Jul 2022 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGLVOe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiGLVOd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jul 2022 17:14:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62314A58FB
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 14:14:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h17so12937060wrx.0
        for <selinux@vger.kernel.org>; Tue, 12 Jul 2022 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWD5yMUrDJWawVJXPESDlam9I0gkjM1YF8IS+nJ/eUg=;
        b=qLft1sMDs8QXpay4jg1/0uosoW+V9QY/3cM7yYAHFjaqroCwYlah2XO0Z27OtKZ9Il
         DLwFpEXTO3rrFshJm0s6uRytGZytz4HayipKlY0s7n9L4H8l9rk0A4587E3Xa0Uh5jaw
         8mll5zhbM2opo6Uv1w76n+mQXOkxZJe1C5UT+cu2zmq5VrTnjLTP+rh89jF/UyQZps01
         RVpf0gmFiQBpFedyAcdjv6DusuEVu89kOknwR4tJ4+nauIBo+ImGbZKZrSEz9mqT67M/
         Zt2w835LhEBqnwY4xeSQ7X4xCxh0SHOI23azm/782RsIeQflVZlSyMbBXg+bApUQkM07
         cDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWD5yMUrDJWawVJXPESDlam9I0gkjM1YF8IS+nJ/eUg=;
        b=K+Z7KOZ7nN9Bz2c6Iu6nPbjRTS0XKz/4na4OXjPFwzlxgFjDoXWpTOqVGiTCj7VcIU
         TiMPq/smsVebRwdutm3d/2ZdPNymToI0Sr5QV0ZlOLmpWbp1QGTbKdQGxvmvEO/E4ye0
         PDbwq/9LEwm0F/7dYo7IziDIrd93aJO0CiH04AJnBenYerhKDVGmmdvEX8l7yACcXJ0a
         YO9cLL4N/FFZNitTj+0K9kEFoUHRd67sD/vWxWRInxzdBQ1PRfWhbxbIgAmdGA5nBQOz
         3Z25nrbMEvePtYfN6DIQ4H5NmnJ6j1tESJd0i/D9JYLpEH9luI5vpUMCftQeLeI4EIIN
         y2zg==
X-Gm-Message-State: AJIora+oFO7UA92UQypAFirdV1vguQN2C2gqXCfWyNmH0eD5pp5/zwBy
        nRkeNZiDiDt2Jre/3V6WA7YwaFgpH81IIxyD9Kav
X-Google-Smtp-Source: AGRyM1vwkI0ULptv3WWRetQFdg/JSozkW5e0cGV2LC0oWbxfgoZnzI0JO4I+wYsTBBCk0/eCzn9YgvxeSzbIyNgM2i0=
X-Received: by 2002:a5d:4f0b:0:b0:21d:705c:caf with SMTP id
 c11-20020a5d4f0b000000b0021d705c0cafmr24389233wru.55.1657660469867; Tue, 12
 Jul 2022 14:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
 <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com>
 <CAFqZXNs49z1z5CE_sb8_fJAOGfFNhOc2PmFY516WOSfcj-2Zfw@mail.gmail.com>
 <CAHC9VhRrQVNwZw6dzAiYJZxwfUwdzN7+3Ki0EEsNNupH6jphRw@mail.gmail.com>
 <CAFqZXNtxnzc_UYfm6Q-UWLf3zK5BNL-Miji2WJDw7Mnu+cU9TA@mail.gmail.com>
 <CAHC9VhRyJ5d9fZYWFVmNaKGAmZr09Lrcc+5rAXjg38GPAO=erA@mail.gmail.com> <CAFqZXNtnjoLEhxguzfVKNVBAfdMdPH8ct+Zsifun4v1X=YpubQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtnjoLEhxguzfVKNVBAfdMdPH8ct+Zsifun4v1X=YpubQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jul 2022 17:14:18 -0400
Message-ID: <CAHC9VhTO8WjOXQvJoSGhLW=s09LN-ovxSzmheXd2s0RmEk4rtw@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 14, 2022 at 8:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Jun 7, 2022 at 5:08 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jun 7, 2022 at 8:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Fri, Jun 3, 2022 at 12:45 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Thu, Jun 2, 2022 at 10:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > On Wed, Jun 1, 2022 at 3:32 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Tue, May 31, 2022 at 7:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > ...
> >
> > > > > > From a quick skim of the SCTP RFCs, the ASCONF chunk is sent from a
> > > > > > remote endpoint to update the SCTP parameters so in this case I
> > > > > > believe the subject should be the remote peer (the association/sock's
> > > > > > peer_secid) and the object should be the local association/socket.
> > > > > > It's important to note that any access control checks using the remote
> > > > > > peer label should be gated by the selinux_peerlbl_enabled() function,
> > > > > > see selinux_socket_sock_rcv_skb() for an example.
> > > > >
> > > > > I don't like the idea of using peer_secid as the subject for
> > > > > socket::connect, which normally has a task sid as the subject.
> > > >
> > > > While I have concerns about reusing the socket:connect permission for
> > > > the ASCONF updates, it isn't because of the peer_secid.  The
> > > > peer_secid represents the security label of the remote peer and it is
> > > > the subject label for ASCONF operations.
> > >
> > > It does make sense to use it as a subject label, but not for the
> > > connect permission, where the convention is that the subject context
> > > is a process context. While we don't have any hard rule against mixing
> > > different "kinds" of contexts in the subject/target of a given
> > > permission, it makes both figuring out AVC denials and reasoning about
> > > policy harder and I want to avoid it wherever possible.
> >
> > The network peer label is a process label, it is intended to represent
> > the security attributes of the remote process.
>
> Hm, indeed, I misunderstood the semantics behind it. Let's disregard
> that argument then.
>
> Still, I'd say the situation "a remote process wants to potentially
> redirect communication to a different address" is different enough
> from "local process intends to initiate a connection to a given
> endpoint" that it warrants a special permission.

I had really hoped to have a patch on the list by now, but in the
process of fixing the original SCTP issue I found another related to
how SCTP traffic is labeled.  Fixing that problem exposed a bad
assumption in the selinux-testsuite SCTP tests which I'm currently
working on fixing.  I'm hopeful that it shouldn't be *too* much longer
before the patches hit the list, so let's just hold off on this thread
until we have some proper patches to discuss.

-- 
paul-moore.com
