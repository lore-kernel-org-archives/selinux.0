Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94F5C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1B524680
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 19:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up6+4mYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgB0Tvu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:51:50 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38498 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgB0Tvu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 14:51:50 -0500
Received: by mail-wm1-f54.google.com with SMTP id a9so743104wmj.3
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AtGO+FkYHWIbKvPhBBNx3kzWeNMvfGxpDjVJEo0DIlU=;
        b=up6+4mYIM3/q/mw2MHa0eiGtWKp6d0NXaSs+fzC4Vw1Y5zKMMQlqwyOSQX1HwsPIBf
         qWS2xW6zf3k8QyApXyVluxSPJizdCsPY46geBb0wrkHgBLKREJOwbjuhhBMjUjnuqCu6
         vlbdmL5dDHcl0HHtclVTyVu/FEvHyKRTQiWZQ+PiLBUDcaFUSTmCmpzgg0h7CYL69c0j
         NvmWgsdsD2Ey8nseSf3N/bF/BRpuFr6fV/GJRYRl8DyiDmsk2ZH6KiLKzshgpF93M2D9
         5MkwHb0sv+eYYgcsMc0moea3cFrWkdE9jFd7KMh0etJN+qeEkQnzBJqfcKnL7TZE2Sbg
         M/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AtGO+FkYHWIbKvPhBBNx3kzWeNMvfGxpDjVJEo0DIlU=;
        b=TtiT7y8GSealjgqMBq+LRv1Z7gsAW+4zjY67ACdjln/Kh/oE5XTO1g+Va2MDsCDqCr
         lllotKoE/Ti/swNaIJlhOW+5ZgIuNldBFqOecrufK1zdWkCVE6wwNuvf3PBMgqWVZaGu
         HT3cxCaeQ8MWYpthgETbQHD6DeiI69xRdWGQ+qJX2L/zP/TuU0ISsUUV+A66cThlVuGX
         pWJAPdaCnwyql3+mue3kjgwueyv/i9g6IRWeLpByC4SqtNEzzC7fEBsUXlSCKBPaCZVK
         E28UyiKFZUi9RPLGMKrSdTdH0aDsK0aO7w0rO7pAfrJ9usioCq8zW0W7rqhUyyFtfyzM
         Oesw==
X-Gm-Message-State: APjAAAVFpf6wofBugY9L3LTHYXHioWXAH7HTS19voZ7vBeeDOsESf2Ya
        GE+6xOnHKS1s42SpCj4YdimmvkSK
X-Google-Smtp-Source: APXvYqzC8x+3FVWr7yGfbRiDkkZuiwaARsJA37v7/bzJhBgVvf/aT8RjmwqFq0vP9cGmk3Wg7PFFcw==
X-Received: by 2002:a1c:994b:: with SMTP id b72mr388273wme.83.1582833107958;
        Thu, 27 Feb 2020 11:51:47 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id m19sm8992680wmc.34.2020.02.27.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:51:47 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     James Carter <jwcart2@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Subject: Re: Fwd: strange issue with name-base type trans
References: <CAB9W1A3-z1YokQUHusrgeuaX2SGyRuh+4X7b_GMEgEo5xe6k_Q@mail.gmail.com>
        <65b5e705-3d42-57c9-6502-973486b3c3c8@tycho.nsa.gov>
        <CAP+JOzSZoUwi8Lfioiu7PRgmexU=0h73p-rkpRConE_jEXboSA@mail.gmail.com>
Date:   Thu, 27 Feb 2020 20:51:45 +0100
In-Reply-To: <CAP+JOzSZoUwi8Lfioiu7PRgmexU=0h73p-rkpRConE_jEXboSA@mail.gmail.com>
        (James Carter's message of "Thu, 27 Feb 2020 14:27:30 -0500")
Message-ID: <87v9nrbyge.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Sorry, email problems has made life a bit difficult over the past
> week. Steve had to forward this to me.
>
> So far, I am unable to duplicate what you are seeing.

You can try it with my dssp3 policy:

git clone git://defensec.nl/dssp3.git
cd dssp3
[kcinimod@brutus dssp3 (master=)]$ secilc `find . -name "*.cil"`
[kcinimod@brutus dssp3 (master=)]$ sesearch policy.32 -T | grep sudo | grep tmp
type_transition sudo.subj file.log:file pam.faillog.log btmp;
type_transition sudo.subj file.tmp:file sudo.tmp;
[kcinimod@brutus dssp3 (master=)]$ sed -i 's/(call obj_type_transition_tmp_fixme (subj file))/(call obj_type_transition_tmp (subj file "*"))/' poli
cy/app/s/sudo.cil
[kcinimod@brutus dssp3 (master *=)]$ secilc `find . -name "*.cil"`
[kcinimod@brutus dssp3 (master *=)]$ sesearch policy.32 -T | grep sudo | grep tmp
type_transition sudo.subj file.log:file pam.faillog.log btmp;
type_transition sudo.subj file.tmp:file sudo.tmp ARG3;

Note the "ARG3" in the latter result

>
> I tried to create policy similar to what you are doing, but I am
> getting the correct results. The following is what I tested (the
> attached policy is the full policy).
>
> (macro trans_base ((type ARG1)(type ARG2)(type ARG3)(class ARG4)(name ARG5))
>     (typetransition ARG1 ARG2 ARG4 ARG5 ARG3)
> )
>
> (block b0
>        (type t0)
>        (macro trans_add1 ((type ARG1)(type ARG2)(class ARG3)(name ARG4))
>           (call trans_base (ARG1 t0 ARG2 ARG3 ARG4))
>        )
> )
>
> (block b1
>        (type t1a)
>        (type t1b)
>        (type t1c)
>        (type t1d)
> )
>
> (in b1
>     (macro trans_parent1a ((type ARG1)(class ARG2))
>            (call .b0.trans_add1 (ARG1 t1a ARG2 "thisworks1a"))
>     )
>     (macro trans_parent2a ((type ARG1)(class ARG2)(name ARG3))
>            (call .b0.trans_add1 (ARG1 t1b ARG2 ARG3))
>     )
> )
>
> (call .b1.trans_parent1a (.b1.t1c CLASS))
> (call .b1.trans_parent2a (.b1.t1d CLASS "thisdoesntwork2a"))
>
> I then compiled and decompiled the policy:
>   secilc -v -v -v -o test3.bin typetransition_problem_3.cil
>   checkpolicy -b -C -o test3.cil test3.bin
>
> In test3.cil, there is the following typetransition rules (which are
> as they should be):
>   (typetransition b1.t1c b0.t0 CLASS thisworks1a b1.t1a)
>   (typetransition b1.t1d b0.t0 CLASS thisdoesntwork2a b1.t1b)
>
> I must be doing something slightly different from what your policy is
> doing and I could use help in figuring out what that might be.
>
> Jim
>
> ---------- Forwarded message ---------
> From: Dominick Grift <dominick.grift@defensec.nl>
> Date: Mon, Feb 24, 2020 at 12:07 PM
> Subject: strange issue with name-base type trans
> To: <selinux@vger.kernel.org>
>
>
> The scenario:
>
> (in user
> (macro obj_type_transition_mytmp1 ((type ARG1)(class ARG2))
> (call .file.tmp_obj_type_transition (ARG1 tmp ARG2 "thisworks")))
> (macro obj_type_transition_mytmp2 ((type ARG1)(class ARG2)(name ARG3))
> (call .file.tmp_obj_type_transition (ARG1 tmp ARG2 ARG3))))
>
> (call .user.obj_type_transition_mytmp1 (user.subj chr_file))
> (call .user.obj_type_transition_mytmp2 (user.subj chr_file "thisdoesntwork"))
>
> The outcome:
>
> [root@myguest ~]# sesearch -T -s user.subj -c chr_file,blk_file | grep tmp
> type_transition user.subj file.tmp:chr_file user.tmp ARG3;
> type_transition user.subj file.tmp:chr_file user.tmp thisworks;
>
> [root@myguest ~]# uname -a
> Linux myguest 5.5.5-200.fc31.x86_64 #1 SMP Wed Feb 19 23:28:07 UTC
> 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@myguest ~]# rpm -qa libsepol
> libsepol-3.0-3.fc32.x86_64
> [root@myguest ~]# rpm -qa libselinux
> libselinux-3.0-3.fc32.x86_64
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
>
>

-- 
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
