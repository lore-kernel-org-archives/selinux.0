Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF3CC43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EC5217D6
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 06:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="0jNqh1BH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLSGPH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:15:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33311 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeLSGPH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 01:15:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so8994472pgu.0
        for <selinux@vger.kernel.org>; Tue, 18 Dec 2018 22:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kb1ypVj3IGTdFEKg5z0G7qj4yvJTj/p8KyZ0Pxrn8tE=;
        b=0jNqh1BHvKNsqZkj7pSGQiiBiaf9IbePbmNkFCRDcpJHeiu/lVfUiayFAzB67oAJYz
         1073NnhpwMMyF3RBR13jlsTUbv8+iv9Q1dji4yQNQGS3Ocffj6M5jGXilDRYvHF+/dBb
         CQoI1V9E5jKvrv9MmZUgyl9l1jgDh7u4qojEE5L64BlLim+32nA793ijzIgAfpXVLoSk
         bbInjXKLeIkbYL9B58xJr+4920WYxARSBa0ALGZohWdUPQxqDEiv8FTh3grqAEe0Rzda
         bS4X/DJ6vDzm2RcCN5eaceD5U6q3YEbibwsX2YkMhqC3JBa8obzIl/zh8Y6OR/NOOuvW
         kliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kb1ypVj3IGTdFEKg5z0G7qj4yvJTj/p8KyZ0Pxrn8tE=;
        b=hvM7XUYridO9jmQb83C19+QY44KazHWXo3WLLhtm1Ao0l1YwZhRmQoPUBqAJ3ThMs/
         oD/xzfwTHJu2PLNvFLPWjVvrhIc3i1xPIJUnOp0kHZC7/jcJWfILbQd5Ik7Fc3TnlkJf
         4Q1GMGIhtzFx2fHrfzOB57wX1/2WydpdRXcuCre2QS/otxxfnKQ0ncKdiSzOm32RxNSb
         g/yAftZLyhmlxhwWAsX6AbMGwP+uuFxqeQcZImw+L+7KUjPyNAT1Tcacb5WOF1mNAVuF
         Y5mcelP7e2BELimy8PfyOYBc2nouk5bC9UQm7Ep0rsXnrmi7F0lXYFVJkTsvzyZ4HBZc
         RhlA==
X-Gm-Message-State: AA+aEWbZ7a30fKWsZ3iu2/L+pklX/1uV2kOKfgUf9/Er4fXech0fGsfD
        1gagr3DpZoTRln5veAo7Lp7bGw==
X-Google-Smtp-Source: AFSGD/WVDxD3jZOEe6A85J+qUH3lC9C8VuQ+Lo9L3IVa8AsvNm2zWV6rHqogW6vEsmErNg1im6+mUA==
X-Received: by 2002:a63:587:: with SMTP id 129mr18082546pgf.273.1545200105559;
        Tue, 18 Dec 2018 22:15:05 -0800 (PST)
Received: from localhost ([2404:e800:e600:402:a043:dee9:8fe1:5766])
        by smtp.gmail.com with ESMTPSA id m19sm42259006pgn.35.2018.12.18.22.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 22:15:04 -0800 (PST)
Date:   Wed, 19 Dec 2018 14:15:02 +0800
From:   Jason Zaman <jason@perfinion.com>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, ps@pks.im,
        berrange@redhat.com, Eric Paris <eparis@parisplace.org>,
        Eric Paris <eparis@redhat.com>, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
Message-ID: <20181219061502.GA12688@baraddur.perfinion.com>
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov>
 <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
 <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com>
 <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
 <CAFftDdoMFfjn=2yB-qXhwH=TonH=42pBNbczkVVwvQtr7UZn9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFftDdoMFfjn=2yB-qXhwH=TonH=42pBNbczkVVwvQtr7UZn9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 18, 2018 at 11:02:54AM -0800, William Roberts wrote:
> + Eric and Dan, as Stephen pointed out to me, they introduced the -Wp
> portion in commit 41649ca78
> 
> On Tue, Dec 18, 2018 at 8:03 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > Patrick,
> >
> > Hoping you could maybe weigh in on your choice for bypassing the
> > compiler driver with -Wp and not setting _FORTIFY_SOURCE to something
> > like 1 or 2?
> >
> > I'm seeing this issue on Ubuntu 16.04.5:
> > <command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
> >
> > gcc version:
> > gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
> >
> > My thought is to undef/redef _FORTIFY_SOURCE in CFLAGS and set the
> > level to 2. Setting CFLAGS via the env/make arg will override this
> > behavior
> > and use CFLAGS as is.

Just wanted to say that in Gentoo Hardened our toolchain also already
has _FORTIFY_SOURCE set to 2. If anything we should set it to 2 not 1.
and if setting it, we gotta add the undefine first otherwise we get
this:

$ gcc -Werror -O2 -D_FORTIFY_SOURCE=2 main.c 
<command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
<built-in>: note: this is the location of the previous definition
<command-line>:0:17: error: expected identifier or ‘(’ before numeric constant
main.c:3:1: note: in expansion of macro ‘_FORTIFY_SOURCE’
 _FORTIFY_SOURCE
 ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Its not really a big deal since basically everyone sets their own CFLAGS
but =2 is safer so we should have it as the default.

-- Jason

> >
> > On Fri, Dec 14, 2018 at 8:02 AM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > On Fri, Dec 14, 2018 at 6:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >
> > > > On 12/14/18 8:43 AM, Stephen Smalley wrote:
> > > > > On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
> > > > >> From: William Roberts <william.c.roberts@intel.com>
> > > > >>
> > > > >> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
> > > > >> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
> > > > >> <command-line>:0:0: note: this is the location of the previous definition
> > > > >>
> > > > >> Correct this by undefining it first and redefining it. Also, the previous
> > > > >> command line option was using -Wp which passing the value *AS IS* to the
> > > > >> pre-processor rather than to the compiler driver. The C pre-processor has
> > > > >> an undocumented interface subject to change per man 1 gcc. Just use the
> > > > >> -D option as is.
> > > > >
> > > > > See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid
> > > > > redefining _FORTIFY_SOURCE") for why we don't specify a value for
> > > > > _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.
> > >
> > > I'm not 100% convinced that the patch is the best solution or the commit message
> > > is describing the problem correctly. I could also be understanding it
> > > wrong here.
> > > The man page is saying not to bypass the compiler driver via -Wp, and I don't
> > > see a good reason for it either.
> > >
> > > See my comments below, they feed back into this.
> > >
> > > >
> > > > I guess the issue here is that we want to provide sane defaults for
> > > > building without breaking the build when others specify their own
> > > > definitions and without weakening those definitions.  By undefining and
> > > > re-defining, it seems like we might weaken existing builds that were
> > > > specifying 2.
> > >
> > > We conditionally assign to CFLAGS via ?= operator. Thus, CFLAGS and the
> > > corresponding addition of EXTRA_CFLAGS which contains the undef/def
> > > is not appended. CFLAGS specified via the environment or as an argument to
> > > make will cause this assignment not to occur (via ?= semantics) and whatever
> > > they specify for CFLAGS is sent to CC.
> > >
> > > Here is some sample output:
> > > make CFLAGS='-D_FORTIFY_SOURCE=2'
> > > cc -D_FORTIFY_SOURCE=2 -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND
> > >  -fPIC -DSHARED -c -o stringrep.lo stringrep.c
> > >
> > > With that said, *i think its safe* to bump it back to '-D_FORTIFY_SOURCE=2'
> > >
> > > >
> > > > >
> > > > >>
> > > > >> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > >> ---
> > > > >>   libselinux/src/Makefile   | 2 +-
> > > > >>   libselinux/utils/Makefile | 2 +-
> > > > >>   2 files changed, 2 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > > >> index 977b5c8cfcca..ee55bd0dbff7 100644
> > > > >> --- a/libselinux/src/Makefile
> > > > >> +++ b/libselinux/src/Makefile
> > > > >> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
> > > > >>   EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op
> > > > >> -Wpacked-bitfield-compat -Wsync-nand \
> > > > >>       -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> > > > >> -Wsuggest-attribute=const \
> > > > >>       -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
> > > > >> -Wtrampolines -Wjump-misses-init \
> > > > >> -    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > > > >> -Wp,-D_FORTIFY_SOURCE
> > > > >> +    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > > > >> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
> > > > >>   else
> > > > >>   EXTRA_CFLAGS = -Wunused-command-line-argument
> > > > >>   endif
> > > > >> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > > > >> index d06ffd66893b..64ab877015c6 100644
> > > > >> --- a/libselinux/utils/Makefile
> > > > >> +++ b/libselinux/utils/Makefile
> > > > >> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
> > > > >> -Wformat-security -Winit-self -Wmissi
> > > > >>             -Wformat-extra-args -Wformat-zero-length -Wformat=2
> > > > >> -Wmultichar \
> > > > >>             -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > > > >>             -Wno-missing-field-initializers -Wno-sign-compare \
> > > > >> -          -Wno-format-nonliteral
> > > > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
> > > > >> +          -Wno-format-nonliteral
> > > > >> -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE
> > > > >> -D_FORTIFY_SOURCE=1 \
> > > > >>             -fstack-protector-all --param=ssp-buffer-size=4
> > > > >> -fexceptions \
> > > > >>             -fasynchronous-unwind-tables -fdiagnostics-show-option
> > > > >> -funit-at-a-time \
> > > > >>             -Werror -Wno-aggregate-return -Wno-redundant-decls \
> > > > >>
> > > > >
> > > >
