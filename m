Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573A0C43460
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 05:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2043A61157
	for <selinux@archiver.kernel.org>; Thu,  6 May 2021 05:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEFFmf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 May 2021 01:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhEFFm2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 May 2021 01:42:28 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D9C061761
        for <selinux@vger.kernel.org>; Wed,  5 May 2021 22:41:08 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 15so5901550ybc.0
        for <selinux@vger.kernel.org>; Wed, 05 May 2021 22:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NbGR8OtWDlz8Xu8V8OvbgP2W8lCZ6xi2hzAleuLgs5c=;
        b=D7U1fDwhZSfGmTPv4Xu1zqu+7RMI2bfa+OmuuX4qHfWFXlvT7EYiTcypazIh9b6hVA
         Vak9/+3jKrAnDERIVstUtOD/O+yp+36DkePuxQ/wN9OTZTNoa2lbg0cU3vmrVqKMbwHV
         fHz/Exr5SpJAvgUID2zoFuAKb9l3IIoMuTvyp5D6KD+flJ8kYdCcgM3bmNqvjoBwDQBh
         q4VqIVyiroAE+fn9Q9qt7Me3n18dMrq2gwAL5nCXGbjPaTsbn/HCwE2zYM/lUmk4clSi
         yt3Fy4Jcx2W0qrBFHltDO7fcoGVulEV1STCVsnRPn1JekB92nUF4w380opz+MdfhmkIU
         2ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NbGR8OtWDlz8Xu8V8OvbgP2W8lCZ6xi2hzAleuLgs5c=;
        b=NYGRl2JIqq3IHWThXrl+GvKiBTibvMEzv9ue0VfUvLaCS4m9O3gqtAnQSOm70qj94b
         6ielN9j66RQxRFGScwF3kRF2IqGmLg8kNzRzdQrpu6of6/NBg+33IULqrrSo4Hxu0Tyf
         ofw1mH5whCywDlnB0Q2aM0vHu2YNPzy0Ey306f2LOm9OHlXf75RcJKWsQnXlEvBtz5KB
         hG1g9yoQ1+S7XgzqgG0RZ7jomfSsvU4uND/XOtW6vRdPy0SCfENiH6FL4RdHhZIWC7C7
         Hu/lZibYkHrsYK26xhlnMdjcwJqoFuHjLTZE0c3dgQBFO1/xpSOIvbiiqBZslPRkvjHs
         CHdA==
X-Gm-Message-State: AOAM530fHN/+WGvfsiv5TyIkNscOKyek8dYOIIZ/QVLHdQxjaI3K65ef
        MSoFkmDRV9C836o+cXZjAsY8PBu41HXMnzFftaJE41iFVWPaOw==
X-Google-Smtp-Source: ABdhPJwNw++5beVHxHU8Yrbc5QCB1WQlU7HyXlO1/77VBb2GL/Crtd3F8wlfDtotDWZg7HFRpccmKeHhpRyFyBLTL18=
X-Received: by 2002:a25:ab2a:: with SMTP id u39mr3325957ybi.312.1620279667198;
 Wed, 05 May 2021 22:41:07 -0700 (PDT)
MIME-Version: 1.0
From:   clime <clime7@gmail.com>
Date:   Thu, 6 May 2021 07:40:56 +0200
Message-ID: <CAGqZTUt0jR2vF7G98DssbM+3_wdoTmaMN3TwaJB_QOngZRv2rA@mail.gmail.com>
Subject: improvement of setfiles man page
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

isn't it a bit strange that when i invoke

setfiles -F /etc/selinux/targeted/contexts/files/file_contexts /

it apparently also reads other files from
/etc/selinux/targeted/contexts/files/ like file_contexts.homedirs or
file_contexts.subs. I mean i am lucky it does but it doesn't seem
to be described in man pages. Could the documentation be improved in
this respect? I.e. state that it also can read other spec files than
just the one specified? (in some friendly form)

What I care about is differences of that command to restorecon, i.e. i
think that in the man page some info might be missing. There is this
thing regarding reading the spec files and then also here:
https://github.com/SELinuxProject/selinux/blob/master/policycoreutils/setfiles/setfiles.c#L174,
some more differences are mentioned. Recursive descent is already
mentioned in the man page but stuff like "Does not follow mounts"
isn't.

Could anyone, please, tweak the man page to point out those differences?

I am also attaching my conversation with grift on freenode #selinux
channel about this to provide more context. I was supposed to send a
patch for the man pages on this but I don't really feel like I can
provide correct formulations of this.

Thank you
clime (Michal Novotny)

The conversation:

2020-02-14 22:06:42 clime   hi, isn't it a bit strange that when i
invoke setfiles -F /etc/selinux/targeted/contexts/files/file_contexts
/, it apparently also reads other files from
/etc/selinux/targeted/contexts/files/ like file_contexts.homedirs or
file_contexts.subs. I mean i am lucky it does but it doesn't seem
to be described in man pages. What i care about is compatibility of
that command with restorecon
2020-02-14 22:07:57 grift   what you mean compatibility? restorecon is
a symlink to setfiles
2020-02-14 22:09:46 clime   grift: i mean that the command produces
the same labelling in the end as restorecon -R / would.
2020-02-14 22:23:12 grift   yes i guess it could be documented better
2020-02-14 22:26:21 grift   the differences are documented in the source it self
2020-02-14 22:26:34 grift
https://github.com/SELinuxProject/selinux/blob/master/policycoreutils/setfiles/setfiles.c#L192
2020-02-14 22:27:26 grift   so i guess it could be considered to add a
summery of the differences between setfiles being invaoke as setfiles
and as restorecon
2020-02-14 22:27:55 clime   yes, that would be great
2020-02-14 22:28:22 clime   should i file a bug somewhere?
2020-02-14 22:28:49 grift   can't you just send a patch to selinx maillist
2020-02-14 22:29:11 grift   i mean you could just copy and paste the
comments almost
2020-02-14 22:30:12 grift   recursive descent by default vs. no
recursive descent by default
2020-02-14 22:30:49 grift   does not expand paths via realpath vs.
expands path via realpath
2020-02-14 22:31:00 grift   .... etc
2020-02-14 22:31:15 grift   6 main differences
2020-02-14 22:31:25 clime   ok
2020-02-14 22:33:08 clime   i am still confused about how setfiles
really processes that spec_file argument (e.g.)
/etc/selinux/targeted/contexts/files/file_contexts i would expect it's
the only file it reads but no it reads also other associated files
2020-02-14 22:34:04 clime   and how restorecon (setfiles invoked under
that handle) is different in respect to that....
2020-02-14 22:35:01 grift   well it might not be different except for
the fact that restorecon does lazy init of file contexts?
2020-02-14 22:37:19 grift   dunno
2020-02-14 22:41:22 grift   probably this is used but i am not sure
:https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/label.c
2020-02-14 22:41:47 grift
https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/label_file.c
2020-02-14 22:42:32 clime
https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/label_file.c
... just found it too
2020-02-14 22:42:36 clime   you were faster
2020-02-14 22:42:53 grift   i think they probably both use the same code
2020-02-14 22:43:58 clime   yes
2020-02-14 22:45:08 clime   e.g. this is why .subs_dist gets processed
https://github.com/SELinuxProject/selinux/blob/master/libselinux/src/label_file.c#L746
2020-02-14 22:45:39 clime   anyway, i will post the pach to the
selinux mailing list probly will need some tweaks but i may try
2020-02-14 22:46:52 grift   basically all stuff in
/etc/selinux/TYPE/contexts/files is used if it exists
2020-02-14 22:47:05 grift   but if you specific a custom spec then that is used
2020-02-14 22:48:00 clime   yes that spec together with all the other
files around with recognized extensions
2020-02-14 22:48:31 grift   i see
2020-02-14 22:53:28 grift   you could also add a practical example
because setfiles is usually used in specific scenarios
2020-02-14 22:55:27 grift   this is a typical scenario for why you
would use setfiles:
2020-02-14 22:55:32 grift    339     /usr/sbin/setfiles -F -r /mnt/example \
2020-02-14 22:55:32 grift    340
/etc/selinux/dssp2-standard/contexts/files/file_contexts \
2020-02-14 22:55:32 grift    341                        /mnt/example/
2020-02-14 22:56:42 grift   basically to label images, pretty niche
2020-02-14 22:57:01 grift   and stuff like fixfiles abstracts it probably
2020-02-14 23:09:53 clime   yes, this is basically what i am trying to
do with setfiles
2020-02-14 23:12:26 clime   except it works better for me if i do
chroot /mnt/example first. That way setfiles doesn't complain about
unknown labels. Didn't yet find out why exactly
