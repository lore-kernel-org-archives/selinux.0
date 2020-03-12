Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E510C10DCE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 21:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F34620637
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 21:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WraqFZAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCLVmO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:42:14 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34686 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgCLVmN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 17:42:13 -0400
Received: by mail-il1-f193.google.com with SMTP id c8so7028677ilm.1
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sno3HbUqh8/cTKQ94cqPg8WFMmm4Q/BHB4zmj7Wkt9I=;
        b=WraqFZAwHrmkQUQY1rwMTNqolPF23qiigCarBR7T7oPq+/o2eMzwBSvK/gzofh2QQy
         7Fh+qjkKEcAU82tpyYQ9+pvKkQktGaMEYntN5U6lOCTF0KLgVNIIAyPiCeNk4SPJs30G
         cvIW9v98Z4MTJCvi5qYzm5CN9VE1MctVvxuSaN9xj1lbwZdhszI+c9TU+Iffd3DD+2jE
         k5UnMP27EuJys5BPVoG3hgCOIK5F3whgJcwuy4SwTTO+bXy5h4KNACMD1jpS3dRTA++d
         9riQ+rNCsiCE2Q0PRce2+zvfXX6YXPoGmjR8qF7Q0b7WNU6s3fhMlktP0tZ8D6dbooj3
         geoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sno3HbUqh8/cTKQ94cqPg8WFMmm4Q/BHB4zmj7Wkt9I=;
        b=D/xpwOGSd3XinWCB2qEjnhDmDPd346pbp1hH7n94PwwKOEs4uyjJrg9EXuzQ4zaxN9
         d2oW09Hw7mcjgbTiUzUHWY38g0G21Uh3k4pGWjoU2Qu/Ij5eQW+ODkbl8x37YEhl4Si6
         LeIuY+pPW1RWpsPqkIiBXF9QlKgWkVZCX8GcIZYAmv0unYarDUeNhXq6kMTKDpiDj2Pq
         JjQ2wtE49OHoeaTceOY7iPdwUdZgvKqGOa9+0pY1X7Rw0uwJJPLqsNKrDy5rbwBfIVfa
         vT+5PLuxoeA0nioYcit9HrWTA8QLFroH7HNskEr42Vf59BeiK1Vq8nhSn62TnRhLjiPO
         ghAw==
X-Gm-Message-State: ANhLgQ2mBm84B39E1OSCyhfAx9hpoqKqLXP1tKg+EXDZ2jyO7MzJQBA/
        cX06m7ErptLm8MqiSckSLv7z4R3k+Q/KdvIa1kw=
X-Google-Smtp-Source: ADFU+vtpX1NvB/xdqNtoeV2n/6VxY+/G7USbE96Wm7B/wYmXz+zhIjhcgYMzA7a02DI4ULAI2uZlW292FOFJ3XsH59g=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr10408104ilj.174.1584049332609;
 Thu, 12 Mar 2020 14:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
 <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
 <CAFftDdoVwg2hvb_oiYzjpAO6_EPTXRiWQejtGBtN+8-B2O1kpg@mail.gmail.com> <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4b5zWvpSZDd+10sNm75zS1aM8zR7PzVqB257Q1bgyT_w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 12 Mar 2020 16:42:00 -0500
Message-ID: <CAFftDdqPtrg1jjcep=u_ny-SHuK04Fd_UhFu29pGohnxpNAP4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 12, 2020 at 3:21 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 12, 2020 at 9:59 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > I will fix the subject and add the Fixes: #165 to the commit when I
> > stage them if thats ok?
>
> Fixes both 165 and 204 IIUC because the real underlying issue for both was the
> fact that he was building with LTO and it was doing the wrong thing
> with hidden_def/hidden_proto.
> Otherwise works for me.  You can download the series from patchwork or
> via get-lore-mbox
> to pick up all the Acks automatically.

I have no idea how to do that, Ill have to spend some time and
familiarize myself with it.
For now I just manually added the acks and did the edits we discussed
and rebased ontop
of current master. Their was a simple conflict in libsepol/src/services.c.

I have them staged here:
https://github.com/SELinuxProject/selinux/pull/207

And since their were some minor edits before they go in, ill let them
sit a couple
of days for any last objections. Ill merge Monday March 16 end of workday if all
is silent.
