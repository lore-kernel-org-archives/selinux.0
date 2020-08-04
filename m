Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6043C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE91207FC
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 16:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="btBJkeO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgHDQ5a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgHDQ5W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 12:57:22 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68ADC06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 09:57:21 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z17so19712864ill.6
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2020 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5V81FPLgZ6GiFNtE9DoqR50sEsJyRCd4U04QoAl7qo=;
        b=btBJkeO5Iu7Udjq6xYeA38lWPp6CZMdVaHNyHV4BLLqqvPvBuOko3Mt49gpXJZ9YUv
         tP2dKuks1iVHNIBGcoc6FB8onGokOxnlV5pv+la3vonD22mkZe3OZyK5lFA3WevrYqHD
         lA41vYNIzxAzons5jk0HP3D/mND+PM4o1TzhH6aMU53H4JsJO/O3ZtT8lJPaCQP8UK9D
         1seoCi05CWDT6OQAAUUXpvYYpneJeY1kBlNHqhU1Lz4zbnfsKCGvM7+2hdy1a2bZiSGw
         GevXoPdTCw5QXuNz54Gm44nhrOv4CWq84hwoINJzcUxrVvdcmwqwbTvt2AoByqaCy0Tz
         V8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5V81FPLgZ6GiFNtE9DoqR50sEsJyRCd4U04QoAl7qo=;
        b=kf5Bac7hdUTo3++dAzxIH2nGjsVhn6Hv6gjMBL36M5DHEUYlfjsZU0laHrZTsYH06R
         JwxI4na316ZYxSqDYRVdGV5giD+dwp8bpjIrCzkc1+6BrJxelONHSbVvHlHguKJm4CDm
         f3rADlFrOqluQCb0jZEVMqfZpDprs7g8DoCbag1Fz+0wcZl1UszrAZGxw0xvJ8zvrCj8
         yt94MuIkKoYtAQPz+fjdAi+F5BmvpolIdiB4abRROjiRNk2hIMrJQuA7bxELtwfzceLi
         KFW+0dREfi/zhoXv3Ur86CstiVh6aJlFx3bVSLZpuRNH+tPociRzK6Vqf11612665DcN
         hiiQ==
X-Gm-Message-State: AOAM532LOszoBRtyM/i5I3Fpw4jrRS/HypYvqUI9GpjiNV72OPJ3KuZJ
        kbmwB+nS02ATPr4f267ZX0/ai2ruQDkFkYCp8wNSDg==
X-Google-Smtp-Source: ABdhPJyggTGB8/aGjgnAJADJhLVexBTQESfHkhTYf5iqC/2VfXQk8EdCD0nqI3tnLv95Ln9qMosRZBEkh6Gfet70LSs=
X-Received: by 2002:a92:4a0d:: with SMTP id m13mr5754118ilf.276.1596560241252;
 Tue, 04 Aug 2020 09:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <309a97d9-194b-a449-337c-bcbade76317d@gmail.com>
In-Reply-To: <309a97d9-194b-a449-337c-bcbade76317d@gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Tue, 4 Aug 2020 12:56:53 -0400
Message-ID: <CAGB+Vh4ezWPAU1PY1jMuMxU34kVqhphgUNfN+Yn7sn3XEhTAug@mail.gmail.com>
Subject: Re: Label files under HOME_DIR with a range by default
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 2, 2020 at 5:20 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Hello,
>
> The user level is currently used as the range for files under HOME_DIR.
> It appears that the Bell-LaPadula model makes the assumption that all objects are single leveled, this assumption is also made in libsepol. (I haven't really found a good source for this assumption)
>

libsepol does not make any assumptions about policy. Everything is
defined in the policy mls or mcs files in terms of constraints.

> But in my own (MCS) policy objects are not single leveled.

Files are, by definition, single level objects because they cannot be
decomposed. A file with U - TS data in it is a TS file.

The policy (not libsepol) handles enforcing single-level objects, for
example in refpolicy:

# make sure these file classes are "single level"
mlsconstrain { file lnk_file fifo_file } { create relabelto }
        ( l2 eq h2 );

You cannot create or relabel a file with anything other than low = high.

Directories can be ranged, if they contain files of multiple levels,
again, from refpolicy:
# Directory "write" ops
mlsconstrain dir { add_name remove_name reparent rmdir }
        (( l1 eq l2 ) or
         (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1
domby h2 )) or
         (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
         ( t1 == mlsfilewrite ) or
         ( t2 == mlstrustedobject ));

So the source low must equal the directory low or one of the mls
exception attributes controls fine grained usage.

> Read (and process communication) operations are allowed if a processes high level dominates an objects low level.
> Write operations are allowed if a processes high level dominates an objects high level.
>
> Later I've found that someone else had also come up with this idea independently, see https://lore.kernel.org/selinux/20091103114530.GH1672@myhost.felk.cvut.cz/ and https://lore.kernel.org/selinux/20091125202727.GD1649@myhost.felk.cvut.cz/ .
>
> For this I want to label files under HOME_DIR with the range user_lowest-user_highest.
> Ignoring process communication this would prevent a login with less than maximum clearance from escalating by writing to e.g. ~/.bashrc .
>
> For example a user with the range s0-s0:c0.c3 would have his home files labeled as s0-s0:c0.c3.
> A local tty login with the maximum clearance s0-s0:c0.c3 would be able to edit ~/.bashrc .
> But an ssh login from e.g. an insecure network with only the range s0-s0:c1 would be able to read but not write important files such as ~/.bashrc .
>
> Using user_highest-user_highest as user level would force the user to correct the context of potentially a lot of files required by whatever is run with less than user_highest high, so I want to avoid this.
>
> Would it make sense to change libsepol to accept a range as user level (and perhaps changing the name) ?

libsepol isn't really doing anything here. You can use semanage to set
a file context, something like:

# semanage fcontext -r s0-s0:c0.c3 /home/username
# restorecon -R /home/username

But you do need to be careful of escalation as you've noted, you may
need a number of these to set specific files to the user high level

> --
> bauen1
> https://dn42.bauen1.xyz/
