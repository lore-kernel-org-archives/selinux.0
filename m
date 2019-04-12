Return-Path: <SRS0=nflz=SO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB362C10F0E
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F8520869
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 19:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijG+PPDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfDLTcB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:32:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33296 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDLTcB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Apr 2019 15:32:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so8536641ede.0
        for <selinux@vger.kernel.org>; Fri, 12 Apr 2019 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gc0MHinUTsHN9q92dsP9kT0J7vfJskXF3bPWoGDmXds=;
        b=ijG+PPDkDU/U1x2Qdg4TJAQhGHP6MM3Xj5J/NLWJYN/XKmLKGLDiqM25DjB+zvdwEV
         foMJHK619aUJLANBQyGxX/+wg7k2eMQDBmFa0qQOvubFNmIoWiznYHV3S7UwxvaY6MFb
         nvhPyf7bjzAeKt/olI4k++Y7OePua0/tRqXgzcp9eSN/cQt9k2y+r7cZv+9jzookrNZY
         ZDynZ8pIu/3uvXLkVgfdI2Tbj9iERBbkCS+60jL8mtyOQVRSfUtlT/FCbFz04Xiti6XJ
         D6Dc/i5e5swz+iE2BdhnKeEHhZdD1/G/NZ46LUmkSb2E78TkFuLo8vKsxZEWgleuks6B
         hIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Gc0MHinUTsHN9q92dsP9kT0J7vfJskXF3bPWoGDmXds=;
        b=pomUVDsSx/jd5E7eReDmjyMSj5FC/Cz9zrDQa/faxUB28aajIvoWZR7zoJ5e+gUk7E
         EpoDaGjFV0WtFSvHgH3egRJ44le+EVK98ujjl+Y+gBnvJ0N86og5INrMlD5k/tMGNjBE
         iIkMT90w6375ZWMECRNu2dxEF42zC51G/vwHMemdt/7kVnB9A2WbC2bHGusXfCYDZZDe
         UGczFsn/WJuBKRfSaVwieOr8HSm12weNxLI32Zz6+5lTc6wWI4En2hhH11Ex2Fp1DfFj
         J2w5NoxvlLNm/7IumJLxgM1/e8ezkWIyNzHXZbQDc2VSPZvlTdl7WnurvVKTAJw09X3k
         tatA==
X-Gm-Message-State: APjAAAX/d4ZFQBnnKUkIItxtHvfyLIrLM+io2ZVCDe+M0k01BGoXMX/P
        OY4XK7dwpKcW3Dv8HrgdVrJ2H+hU
X-Google-Smtp-Source: APXvYqztFfYHEDeYcsF01vQkJf8p14+ILbn2kpkOl8J+T4fNVLPQSiOIJSaiNofE9LRSy0cuf9U5LQ==
X-Received: by 2002:a50:eacb:: with SMTP id u11mr31492954edp.212.1555097518714;
        Fri, 12 Apr 2019 12:31:58 -0700 (PDT)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id e17sm7680428eja.33.2019.04.12.12.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 12:31:57 -0700 (PDT)
From:   Dominick Grift <dac.override@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
        <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
        <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
        <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
        <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com>
        <CAHC9VhQujkY+Cbkb=ge10JXYyCmftphNOzCCeBaHXLXGMa6_ig@mail.gmail.com>
        <CAHC9VhSDzofwhqhAKaScfzB21cnus8=iir-TayjEeWfDa9h9rA@mail.gmail.com>
        <05b9c3920262f93f8f7af0058821a5301b138526.camel@btinternet.com>
        <CAHC9VhTUSm1vx_TtmrX+VRd5C56=tKOt8dP2MYwFGsKwCRfKPw@mail.gmail.com>
Date:   Fri, 12 Apr 2019 21:31:57 +0200
In-Reply-To: <CAHC9VhTUSm1vx_TtmrX+VRd5C56=tKOt8dP2MYwFGsKwCRfKPw@mail.gmail.com>
        (Paul Moore's message of "Fri, 12 Apr 2019 15:20:46 -0400")
Message-ID: <87mukvvx3m.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Fri, Apr 12, 2019 at 12:37 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
>> On Fri, 2019-04-12 at 10:46 -0400, Paul Moore wrote:
>> > On Thu, Apr 11, 2019 at 6:07 PM Paul Moore <paul@paul-moore.com>
>> > wrote:
>> > > On the negative side I realized when playing with your test changes
>> > > that I wasn't building BINDERFS in my test kernels - oops.  I'm
>> > > fixing
>> > > that now, but I might not get a chance to do another test until
>> > > tomorrow; at least I can verify that your BINDERFS testing logic
>> > > works
>> > > :)
>> >
>> > I rebuilt my test kernel (the latest "secnext" builds have it) with
>> > BINDERFS only to realize that Fedora Rawhide doesn't seem to ship
>> > /usr/include/linux/android/binderfs.h so I manually copied the file
>> > from the kernel-devel package only to run into this when building the
>> > new binder tests:
>> >
>> > # make
>> > cc -DHAVE_BINDERFS    check_binder.c binder_common.c binder_common.h
>> > -lselinux -lrt -o check_binder
>> > binder_common.c: In function =E2=80=98cmd_name=E2=80=99:
>> > binder_common.c:35:7: error: =E2=80=98BR_TRANSACTION_SEC_CTX=E2=80=99 =
undeclared
>> > (first use in t
>> > his function); did you mean =E2=80=98BC_TRANSACTION_SG=E2=80=99?
>> >   35 |  case BR_TRANSACTION_SEC_CTX:
>> >      |       ^~~~~~~~~~~~~~~~~~~~~~
>> >      |       BC_TRANSACTION_SG
>> > binder_common.c:35:7: note: each undeclared identifier is reported
>> > only once for
>> > each function it appears in
>> > binder_common.c: In function =E2=80=98print_trans_data=E2=80=99:
>> > binder_common.c:126:23: error: =E2=80=98FLAT_BINDER_FLAG_TXN_SECURITY_=
CTX=E2=80=99
>> > undeclared (f
>> > irst use in this function)
>> >  126 |          obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ?
>> > "YES" : "NO");
>> >      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > make: *** [<builtin>: check_binder] Error 1
>> > # grep "BR_TRANSACTION_SEC_CTX" *
>> > binder_common.c:        case BR_TRANSACTION_SEC_CTX:
>> > binder_common.c:                return "BR_TRANSACTION_SEC_CTX";
>> > service_provider.c:             case BR_TRANSACTION_SEC_CTX: {
>> > # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binderfs.h
>> > # grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binder.h
>> >
>> > ... and that's when I stopped playing with this.  If it helps, I
>> > pulled my binderfs.h file from a current Rawhide kernel.  What are
>> > you
>> > using to run these tests?
>> >
>> > At the very least, I'm thinking we'll also want to include some notes
>> > in the README.md file under the "Optional Prerequisites" section
>> > about
>> > how to get this running with BINDERFS.
>>
>> The BR_TRANSACTION_SEC_CTX is defined in an updated binder.h file, so
>> you need both binder.h and binderfs.h from devel.
>>
>> I guess I must have copied them over by hand as I tested on rawhide.
>> I'll add a note in the README.md file.
>
> Okay, that solved the problem, thanks.
>
> I just noticed that the kernel-headers package on my Rawhide systems
> are *really* old.  I suspect this may be due to the fact that I'm not
> running Fedora Rawhide kernels and thus my currently installed kernel
> packages don't match what is present in the main Rawhide repos; this
> problem might be limited to just me (and anyone exclusively running
> the secnext kernels on their system).
>
> Can anyone with a Rawhide system confirm if they have the
> /usr/include/linux/android/binderfs.h header file?

[root@brutus ~]# rpm -qf /usr/include/linux/android/binderfs.h
kernel-headers-5.1.0-0.rc2.git1.1.fc31.x86_64

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift
