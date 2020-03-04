Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0740C3F2CE
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 18:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1FB2084E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKW1Sghw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgCDSwZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:52:25 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44175 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCDSwZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 13:52:25 -0500
Received: by mail-ot1-f46.google.com with SMTP id v22so3062609otq.11
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZsrW3RBiv9vefnfvLcu7rTCas6/SPeRnYpNPHfUnLQ=;
        b=gKW1SghwhosXV7OHQU67bcE8gRPIpG2dlR5Z4Tzd6HDvdI2pXQeIs+dL8zCxywtVSn
         p6TGH0IL4KtrC2ikeGCp65MrtMpbwbUz0aCJ9ptZ0868UycTpzmIzR4yI/WPSUKNS1MU
         w1IxkZCwv963yT1hEhF5qsaB25DvmYDLsNTZVX20RWoharIBExyV4AedvElNYjyXU4o1
         tJrcjU2bkNf4hGrXrUnV+9z4YHYQ7Sx4MNHubvX3sz5CJmFxWna+InuSQG13iJ2TL3G8
         GajBfnuiJ2DJeL9015U6ZaaRJriOP4nDdA5delo1vtIc2EyDe9Gw3ZAkd0e1nifocgRC
         /4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZsrW3RBiv9vefnfvLcu7rTCas6/SPeRnYpNPHfUnLQ=;
        b=tvdOVdDxMmu6klAcpODMYQ9UJaVetlTKFQd1crFbd7sE062YouccFnHvjmDF8RljLe
         s7KYJa+xTI17S6knyi1Mea/wG0OcPKd3gQMxLejTpLHO25QKKmBN27/+CLF+ejPCT35B
         oLbpvXsc2bwNp8WoUJD48e7dqYgI58R0HXqeSampPt45O2sZuvG4VsJigQHkGOIeBezY
         cpleJyM7q6WncJSADsFOowltzFK1JJtk2HGCYeT9BIpQQc2v/PDWm0bzApqKneXqEw9f
         uD6PjQeeETafZhm/CQR3GGLOxDyWqVntZYUZZISrc7JHu+CjwTbktIX1Kqtp2iv3urJp
         2LNQ==
X-Gm-Message-State: ANhLgQ1++VEDjcyYUPoBG/RQWmTsDdMAxWf+tjtVNhSunHIotuTRsI58
        oAPkjzdeFlcn7hkX97wiCC/YIPqNWQltLc2S1+RU8bXT
X-Google-Smtp-Source: ADFU+vsIf1OP0qfAKDCngQnQKB3uKdpzZukqsoS9FsiXtc7AI3Bfr15FY2Oml5HaIN4ti8ekGTmf6N+CUna/oFW6amU=
X-Received: by 2002:a05:6830:1144:: with SMTP id x4mr3445804otq.59.1583347942896;
 Wed, 04 Mar 2020 10:52:22 -0800 (PST)
MIME-Version: 1.0
References: <CAB9W1A3-z1YokQUHusrgeuaX2SGyRuh+4X7b_GMEgEo5xe6k_Q@mail.gmail.com>
 <65b5e705-3d42-57c9-6502-973486b3c3c8@tycho.nsa.gov> <CAP+JOzSZoUwi8Lfioiu7PRgmexU=0h73p-rkpRConE_jEXboSA@mail.gmail.com>
 <87v9nrbyge.fsf@gmail.com>
In-Reply-To: <87v9nrbyge.fsf@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 4 Mar 2020 13:53:47 -0500
Message-ID: <CAP+JOzTwO6zNA1o=ztKkO627TT8f9tp7dG=amde8Thx5wu+6JQ@mail.gmail.com>
Subject: Re: Fwd: strange issue with name-base type trans
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 2:51 PM Dominick Grift <dac.override@gmail.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Sorry, email problems has made life a bit difficult over the past
> > week. Steve had to forward this to me.
> >
> > So far, I am unable to duplicate what you are seeing.
>
> You can try it with my dssp3 policy:
>
> git clone git://defensec.nl/dssp3.git
> cd dssp3
> [kcinimod@brutus dssp3 (master=)]$ secilc `find . -name "*.cil"`
> [kcinimod@brutus dssp3 (master=)]$ sesearch policy.32 -T | grep sudo | grep tmp
> type_transition sudo.subj file.log:file pam.faillog.log btmp;
> type_transition sudo.subj file.tmp:file sudo.tmp;
> [kcinimod@brutus dssp3 (master=)]$ sed -i 's/(call obj_type_transition_tmp_fixme (subj file))/(call obj_type_transition_tmp (subj file "*"))/' poli
> cy/app/s/sudo.cil
> [kcinimod@brutus dssp3 (master *=)]$ secilc `find . -name "*.cil"`
> [kcinimod@brutus dssp3 (master *=)]$ sesearch policy.32 -T | grep sudo | grep tmp
> type_transition sudo.subj file.log:file pam.faillog.log btmp;
> type_transition sudo.subj file.tmp:file sudo.tmp ARG3;
>
> Note the "ARG3" in the latter result
>

I found the problem. In dssp3/policy/user/user_runtimeuser.cil there
is the following macro definition.

    (macro obj_type_transition_runtimeuser ((type ARG1)(class ARG2)(name ARG2))
           (call .file.runtimeuser_obj_type_transition
                 (ARG1 runtimeuser ARG2 ARG3)))

Notice that ARG2 is used twice and ARG3 is not actually an argument
and is taken as a name.

There are a couple of bugs here. First, CIL should give an error for
the duplicate argument names and, second, CIL should be checking if a
name is actually a macro parameter before it checks whether that name
is already in the name symbol table.

You were seeing what you saw because the macro above is never called
but it does put ARG3 into the symbol table so that it is not
recognized as a parameter later.

Jim
