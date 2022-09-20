Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79016C54EE9
	for <selinux@archiver.kernel.org>; Tue, 20 Sep 2022 13:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiITNGo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Sep 2022 09:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiITNGo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Sep 2022 09:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2AE08D
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663679202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUMcnG1VxC8A/8J/2iROP+SWNeXzFk2fombZPge33lM=;
        b=VWygyVcQ4fCGKzlkse8wAGaqV52WfrhyAgv9gxiDizahLdyUyOJbphHe6y4xOfD10kMgt9
        BrBaR5fhDY8U2c/JsoHVQTbNmvqFQMKOAwcJwBbzfca7pQNM9f3sTAi5G9PxsVyQck3RZq
        CJzDJFGGVdGJjen6XJXBhsowOC4NKmc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-V08ov1z7MlWVwOMWPoBxzw-1; Tue, 20 Sep 2022 09:06:41 -0400
X-MC-Unique: V08ov1z7MlWVwOMWPoBxzw-1
Received: by mail-pg1-f198.google.com with SMTP id u62-20020a638541000000b0043ad01a4e4bso1628743pgd.0
        for <selinux@vger.kernel.org>; Tue, 20 Sep 2022 06:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KUMcnG1VxC8A/8J/2iROP+SWNeXzFk2fombZPge33lM=;
        b=W2hqMaTbQuPo6+ZTFE1KcY0O0P8+9P4Z3egdnC7/vIjibkn+4b0mn+euFGAyLXniV4
         4RrFJA4XxFCzrKCEjma6aQ5p/hr55e33ghr7XeOhUxPa4fCJmiUtf4kO685958Eh7DF0
         R+93HSf2YtUky73VcAIwl0yBY25pSQ4ngVYII/dFBcDxayzrlWSiVrVO2f8Ws5oqReV1
         eC5Ir9ud9bAW+tUmVsQIAMs+4J7KAHIRCSKHmBIx9J5de+Zg13/OdpgsWpsINcknKdw3
         J4jO70yUbNNcJj/c7G+a+CyDNPyel5CORvHXeALpiJe4xIFLUiNVyg3g3qGo/X+IQq3l
         Q82A==
X-Gm-Message-State: ACrzQf2A2Hqipch1C1LsImV9MavwEez+svZjwe3Gwi38P1fjEVsE1eYD
        mSAbGAZ2U0UMDQnbyIqqtxJieMhazp4QRGiyc/fncDLkxn1udkB/mLHdvVHgG8AV1mu7rTyJxJA
        LnpUUij+79emKyE5gJpoeNasp233e7BLouA==
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id om14-20020a17090b3a8e00b0020055854099mr4007656pjb.70.1663679199663;
        Tue, 20 Sep 2022 06:06:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7+LCaCT3e3AGhHs/ae+ywYO9KaGei9AZiw2xKqVLXrCv/emH0rZz0hGDDDySTVvf0hYAcpJb2mAtpg6akaiMA=
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id
 om14-20020a17090b3a8e00b0020055854099mr4007617pjb.70.1663679199289; Tue, 20
 Sep 2022 06:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220919112901.1127409-1-omosnace@redhat.com> <CAJ2a_DcJkATZNBKH8Ua9_Wa1KKL16K-TopHQVW2hYOavPMjgWQ@mail.gmail.com>
 <CAFqZXNvp3hLUbR=0t7vfD1oQmL1mdKOpXRyfgWOoeZCv9UU5tw@mail.gmail.com> <87illj73vg.fsf@defensec.nl>
In-Reply-To: <87illj73vg.fsf@defensec.nl>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 20 Sep 2022 15:06:26 +0200
Message-ID: <CAFqZXNte=_rax99_m06VGSnsJxNiUZ0k_1EZxrHLn-26PBZYWg@mail.gmail.com>
Subject: Re: [PATCH userspace] fixfiles: do not cross mounts when traversing directories
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 19, 2022 at 5:58 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
> > On Mon, Sep 19, 2022 at 1:35 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> >>
> >> On Mon, 19 Sept 2022 at 13:29, Ondrej Mosnacek <omosnace@redhat.com> w=
rote:
> >> >
> >> > Always run find with -xdev to avoid unintended deleting/relabeling.
> >> > While this may sometimes skip subdirectories that should be relabele=
d,
> >> > the danger of crossing into random mounts is greater than leaving be=
hind
> >> > some unlabeled files. The find commands are just best-effort attempt=
s to
> >> > fix the labels anyway.
> >>
> >> The xdev option does not work for bind mounts (they are still followed=
).
> >
> > Hm... it does not if the bind mounted dir is on the same filesystem
> > (superblock), so in the case where /tmp is a plain directory on the
> > root filesystem it will allow traversing to other directories directly
> > on the root filesystem. I guess that's still better than nothing,
> > though...
> >
> > An alternative (at least for the more dangerous -delete part) could be
> > to change the prompt to suggest switching to do the equivalent of
> > `fixfiles -F onboot` + reboot. The current prompt instructs the user
> > to reboot the machine anyway, so it wouldn't really make things more
> > complicated for the user. Maybe I'll draft a patch for this...
>
> The reason why one is presented with an option to "clear" /tmp is because
> /tmp is a shared location. That property makes it so that file context
> specifications usually do not work for these locations in general and
> /tmp in particular. Relabeling does not apply there -because setfiles is
> told to ignore these locations- also not with
> fixfiles (-F) onboot. So telling people to run fixfiles onboot && reboot
> instead of clearing /tmp does not address the challenge.

Oh, sorry, I meant -f, not -F. That is, the user would be given two choices=
:
a) Don't touch /tmp and do the general relabeling immediately. In this
case the user will be warned that /tmp contents may remain incorrectly
labeled.
b) Schedule /tmp resetting + relabeling for next early boot (where the
recursive delete should be safe). In this case the user will be warned
that they need to reboot for anything to happen.

> What I find strange is that one is not also presented with an option to
> clear /var/tmp, because the same applies there. In that sense, I believe,
> this opportunity to clear /tmp is half baked. It does not solve the
> underlying issue of addressing locations that have no file context
> specifications associated with them for one reason or another.

To be fair, the whole fixfiles script is a mess... Feel free to
propose a patch, but my goal right now is just to make it less prone
to unexpected consequences.


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

