Return-Path: <SRS0=so3z=V3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447BC0650F
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA72A20657
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qkbhFq0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfG3PKZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:10:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33422 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfG3PKZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jul 2019 11:10:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so62456589ljg.0
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEnoYL6CceGfS8gggQyxSn9XrgZY5KeGdQDAWn5IJdg=;
        b=qkbhFq0Mbpd875nqioPvde7q/S1jCrmLak7H3lcYKwjqIU67RzANhivcHHPvpboeR+
         aIX100AscFYWfF7ShVohjniUqiKf3oNm4dQic9sbzgT+BfmVCX/XZkZj61Un1v+HWLaF
         B4tFLhmJbZWDkKeb2ElBQzUPNwnsQ/0C9KsSY8/6cx7BeZq0ZnvKzLVpjoq+pUwnyBLA
         MRODZWTF/9mh0iXwECKIg66i4ijhXynN3EeBqvjSbrredu7QbqSAzMUOlQlSm8KXKp+L
         Labbnj5IrS/PMG0gAt6QfwkIJOybhKLK3pavv4axSw1DmsRGEjmEmZjb9B/Xo0C5d8TK
         19FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEnoYL6CceGfS8gggQyxSn9XrgZY5KeGdQDAWn5IJdg=;
        b=pgevRIhhXDUXfmSBJmtF3m73HIyZcdX0gd0WtIkj1qnaXsHlMou3bQ5Q6iIupbza2L
         MTTIu2quYKODqrWB7fFWXLqiuSzkEGDgtpTnGAsYmlL0tkB0jcMOroT03MIQ8TUXJbji
         0JsPFjo3flP8QT72/yJN9kVGhN9FkoMYi3zkBdDQG4WcVydo2qWGLXBOmPqGpinKu2y+
         YqlI3O21h4VqTVX9udHGZK4PE3/Afdf2VQbBfHDcGxmWc0U2lcVwJ7JUjVHCBpuoGAp6
         DAcgY04GgH+vMhc8PhtXGUfUrDPwAtkDczCuo8hsKCAmEYT8z5BE0brPWPq4A7H5S2HU
         rf2Q==
X-Gm-Message-State: APjAAAVbNAnKboW8IohMiOxFOqZtJ9NSYNHk5NDvoz02qvLYKcSA5XbZ
        mo/lkIiIVNizI+5mdftVhCC05JKQklOvpYQ/mw==
X-Google-Smtp-Source: APXvYqwFGG4VVcrJ+1mzTQsrgzFVl9BpTC+hKwnJIOQfaoBtpieLz/ljoHM9TRffhQV4InEuprW4GVCl9xTfWrkxgYs=
X-Received: by 2002:a2e:9858:: with SMTP id e24mr37439973ljj.91.1564499422993;
 Tue, 30 Jul 2019 08:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190729084117.18677-1-omosnace@redhat.com> <20190729084117.18677-2-omosnace@redhat.com>
 <CAHC9VhSRvfGJjBfxkNc2kdwbN5UZP6LSJbyYuBa+OE8YJ1-weg@mail.gmail.com> <CAFqZXNsEH1H5=rLyn=SEay3od+=bdAGYW3_CKvNWBhjNsvHd6g@mail.gmail.com>
In-Reply-To: <CAFqZXNsEH1H5=rLyn=SEay3od+=bdAGYW3_CKvNWBhjNsvHd6g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Jul 2019 11:10:11 -0400
Message-ID: <CAHC9VhR85CBD4FRPrh+ANf0rZeDgmxH9DWNOW8F4DXMyM2Exrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: policydb - fix memory leak in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 30, 2019 at 8:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Jul 30, 2019 at 12:48 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Jul 29, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Since roles_init() adds some entries to the role hash table, we need to
> > > destroy also its keys/values on error, otherwise we get a memory leak in
> > > the error path.
> > >
> > > To avoid a forward declaration and maintain a sane layout, move all the
> > > destroy stuff above policydb_init. No changes are made to the moved code
> > > in this patch. Note that this triggers some pre-existing checkpatch.pl
> > > warnings - these will be fixed in follow-up patches.
> > >
> > > Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 976 +++++++++++++++++----------------
> > >  1 file changed, 489 insertions(+), 487 deletions(-)
> >
> > Hmmm, that is one ugly patch isn't it?  If I saw this diff I'm not
> > sure I would have suggested what I did, or rather I would have
> > suggested something slightly different.
> >
> > When I ran my quick test when I was looking at your v1 patch, I only
> > moved perm_destroy() through ocontext_destroy(), leaving out
> > policydb_destroy(), and the diff was much more cleaner[*] (diffstat
> > below, includes the actual fix too).  Could you try that and see if it
> > cleans up your patch?
>
> Yeah, excluding policydb_destroy() from the move is what's needed to
> get a nice patch...

Good, let's just do that.

> Actually, what do you think about keeping the
> bugfix patch as before (with the forward declaration) and then doing
> the moving around in a separate patch (removing the forward
> declaration)?

Yes, I thought about that too when looking at your patch yesterday and
trying to sort out why it was such a messy diff.

> Then we keep the patch with the actual fix small, but
> still get a clean final result. It would also allow moving
> policydb_destroy() up closer to the other destroy functions in another
> separate patch (I tried it and both patches end up clean when the move
> is split up like this). (I don't have a strong preference for this,
> let me know what works best for you.)

I'm fine with leaving policydb_destroy() where it is, but I agree that
separating the fix is likely worthwhile.  I'll go ahead and merge your
v1 patch into selinux/stable-5.3 (it's borderline -stable material
IMHO, but I'm pretty sure GregKH would pull it into -stable anyway, he
pulls everything with a "Fixes" tag it seems), and then merge the
reorganization patch into selinux/next.  Honestly, I can go ahead and
submit the reorg patch, it's basically already sitting in a tree on my
disk anyway, but if you would prefer to do it that's fine too, just
let me know.

I'll may also merge the v1 fix into selinux/next in order to fix the
inevitable merge conflict, but that isn't something you have to worry
about.

-- 
paul moore
www.paul-moore.com
