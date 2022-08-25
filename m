Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D583ECAA27
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 19:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiHYTzT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiHYTzS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 15:55:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5FE402FE
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 12:55:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b44so7207941edf.9
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=lDoY8S6d3ZFIw9ERKbh2u8r2NJcTApcA4HyCS267O+E=;
        b=OBQh9KhLld8wI5pHAtnOr69LIoUqF3WYrmWtxfreg4BqUsetLXtOf7CkjuJ3IDhgae
         ASzEcT4X6ejNMQddcgH76ec/ZHRuIgcXCRNfBWL+zQUbM7BpHq/ZtX4M12H+ES4Nxfh+
         pZg4dzV7PRTUsr3gBFtt+mtI1EeFwT+XBWHGLwaZj/6byczaTi1u0xaMwBNY5zqi5dTN
         zvaM8mUZP+Qdh/tsISOSZfux6jjWxVmigns3ewLFfn1QWPlH1Gfx54EgGCNbdCOXGfF8
         EhVFLpJdBnAEjPhWvZwp/8On6yA5qudMCkd9zbK2fMI9JL3SGIzmHKS4rmuYNw+TADjV
         C2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lDoY8S6d3ZFIw9ERKbh2u8r2NJcTApcA4HyCS267O+E=;
        b=gp+NcgtiO6S+MQkIgEg36lgMSYFLDxKmTz5oH4q5HoIUnLxoYTZS4Z+fa4hTEriOz5
         IQOhbrPttJUUOSExvzFTlYu+fhhAS5q5YedO7u0iNv59fBJybS1Vlvq7o0vQS6HFVtdg
         yuBKNNQgFU6lJilJcMxq3xcRKGgElcSlEAA/gHE4cBLgsSHXkvRe2O1r3yOnE0UztL83
         zUa8Ak5VLDO5SjnIr3qLE1AO5Xf0gxW7lJKsRwK3rP1gyTL/n7WPpp+c9i6svDhgzYSy
         qgXS3MRzKOslw42Wodx9mTdW7gmWMdxwhxOEaM+EOplEDOUNiJDzGF1sgF/5MFGcZS9N
         yPYA==
X-Gm-Message-State: ACgBeo2D9hp9/toYBU3MHGZgH0+S3BwSTaoqyDM5zAd8K85bK71QL5BL
        WWb1y7zhTRYabmtrGILq5GBvxSAzdulnR5EEFXvJoVom
X-Google-Smtp-Source: AA6agR4mW9jhJWIG0Gtf6ReWVB7sFkOME/JIaKf2Bt+66DXDAB+tQG56bcFFYiiMhJCcTp0LpU5i3eSUFs/RdVtkXII=
X-Received: by 2002:a05:6402:4446:b0:43b:e1f4:8525 with SMTP id
 o6-20020a056402444600b0043be1f48525mr4385707edb.236.1661457314796; Thu, 25
 Aug 2022 12:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
 <CAFPpqQFCjUksVa6YN0uV1-77OB0ZQyrQnDDqjA7LKoyOjZU8tg@mail.gmail.com>
In-Reply-To: <CAFPpqQFCjUksVa6YN0uV1-77OB0ZQyrQnDDqjA7LKoyOjZU8tg@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 25 Aug 2022 14:55:03 -0500
Message-ID: <CAFPpqQHrDzhx30z=K6cu=iWVu0ykf=J4eetpJRRxazjwp4Gusw@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I tried setting the context of the port with semanage and starting the
service but netstat shows the type as init_t and not the type I set.
The system I tried this on is in permissive.

On Thu, Aug 25, 2022 at 8:30 AM Ted Toth <txtoth@gmail.com> wrote:
>
> Maybe if I set the port type using semanage then a type transition
> will happen automatically?
>
> On Thu, Aug 25, 2022 at 8:22 AM Ted Toth <txtoth@gmail.com> wrote:
> >
> > I asked on the systemd-devel list about enabling systemd to set the
> > context of a socket and got the answer I've included below. I don't
> > know how a transition rule can be written to transition tcp sockets to
> > multiple different target contexts, is this possible and if so how?
> >
> > ---------- Forwarded message ---------
> > From: Lennart Poettering <lennart@poettering.net>
> > Date: Thu, Aug 25, 2022 at 4:19 AM
> > Subject: Re: [systemd-devel] socket activation selinux context on create
> > To: Ted Toth <txtoth@gmail.com>
> > Cc: <systemd-devel@lists.freedesktop.org>
> >
> >
> > On Mi, 24.08.22 11:50, Ted Toth (txtoth@gmail.com) wrote:
> >
> > > I don't see a way to set the context of the socket that systemd
> > > listens on. If there is a way to do this please tell me otherwise I'd
> > > like to see an option (SELinuxCreateContext?) added to be able to set
> > > the context (setsockcreatecon) to be used by systemd when creating the
> > > socket. Currently as an extra layer of security I add code called in
> > > the socket activation ExecStartPre process to check that the source
> > > context (peercon) can connect to the target context (getcon). If a
> > > sockets context was set by systemd I would have to perform this
> > > additional check as my SELinux policy would do it for me.
> >
> > This was proposed before, but SELinux maintainers really want that the
> > loaded selinux policy picks the label, and not unit files.
> >
> > i.e. as I understand their philosophy: how labels are assigned should
> > be encoded in the database and in the policy but not elsewhere,
> > i.e. in unit files. I think that philosophy does make sense.
> >
> > Lennart
> >
> > --
> > Lennart Poettering, Berlin
