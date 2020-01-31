Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBBC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02293206F0
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 19:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RiDD9AZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgAaTPh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:15:37 -0500
Received: from sonic315-22.consmr.mail.bf2.yahoo.com ([74.6.134.196]:33378
        "EHLO sonic315-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgAaTPh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 14:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580498133; bh=+HMZ1cNkdNn0Xm67ZFi1VgVmua/C4u4lizvOrWvjHVk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RiDD9AZ1aeOKoUyAN8wwm6zBs/vvsB0wzy8qwbDOwQvKY+r2xIunVsR0hNW1CLkKC6EH/o1XX2SSSNVQhlt8ewJV3kOL4th7L1pX5AlaEckmiPbXEfG5H7uhhZP+wGkibAHSWM8rnwvGcvHuAM0a2wjGgWdmqLUBCkaAGxt/HbIQw0ZbD1gvX5JU3FvZGU/OEeKY9q7OA2iUsmF1uLkD+/rghrc/0syjBaVnhSzEdnIYm7XRVUU8yuEsB4DSljk90onqaH+RkFTR9PpAd+Tw7MfECGLvuLfqHae3X0hkTQyJ/h5qf/ByCnfq6o5tt3EeWxmXSWwk/gCPYpeMF1eJXQ==
X-YMail-OSG: s073JVQVM1kABIc6kXirvZe9qRP3gYn5vglZj.b3yZ5z5ara5_3vb1iR2gLe9Ug
 RGcG_bde4_v8HRsAenxVsF.LqpKrbcgpEPBXT3St9lSCHtVIOwhSlISXKPRPGPzy1bv0kMSXzd6w
 9BI9yzOLKaGt3ADHm3DVfJ0k5cG3Th_Na6IswcbhvQwzWrt62dFQVkO9ra_RNavACS458r.BJ_XZ
 u.XPQZN0LuUTo19peAqZhwex.BBiE6fruWws348owHIQ6.KxMYs2T9E9H5iX4fjueVbMoMYjFTIY
 2ND38dnAjWBP0skX8Ku2cdYr_NLtyresLlaf5SQ_G9GXrWYM32IWTzOwCkxfoxY5g4AwHeLiZXxc
 T4itbVNj8lERgqwScGX2NssL90a.1cZJPWc6UXlTgEr9c_P3puV0_1SePJEmdU94ayF5qTzxkRI8
 pvlbgyZvM6nz_9L67rfoYi1kNAhe4qbcjZTXAHWXfdlaypRonn2F3Qrc4kJaA2Xbr6eUWDEP46gr
 PpQVaxwhV51_TFG3XCFPaauGzQDsIrAWai8ica8MPrjHW4vtdNdTVF4lEvuk226cc0vjcB5aeL.A
 PbKAtSqmXBchOJQjIi7W78FmkFhIjQeaaAnfzz6kAgHrMps9BiqV8PXAhbNcFAg_Qh4y7YKTaCtU
 Nd2WgDlEc2sae5Pukjt_4iuLtAb9pZb0M4Gw1iCDGBw1MSAd2CBgoEG8m6awLjfBuGp4O5bQgef1
 Qk9YnNiDHLkVYZ.sDacSIQYkGXGczZKFn5_zHiaaW4CQ9xwBDVUyX4UdC.D3ZzE5T48L0XUDyCT7
 70NYofACRwwZt2hxFbAS2fsyobt0NpPtLrK9uejGb5n6u9NKqM9.Q8_jpqlUY7lSi_D_VRSK6kuy
 m4SfdaQ.3E0SdI0qcSTuVysujbP5_0ymEfvn_oV_PTGa.SGE.poKndb9ntXi46sEmdKohtFVXJu0
 A_.oeUGhe8isHQnIRGB2oC46lPQaqMa7sEmrKAnEACe2C72q3OPUz2TbzMo0vM9imDguxS6zwdOJ
 3Zb5Bf5R.xYFVt.bIgKIK6FOrw162oWcWeAKV149iJMKHRQ98vp1muG5_k25nqK6G4kI.DgpOrRm
 dbLJhq6rEyyzDI8AcNOJVwcn4joTXGkwTtXVetCXMQAYSnzzYokOF0boiYpUtF2lBNWDJi6UekVN
 mZkWarOt_JS._TDVSG_TXlbWKlPgV2VYvBFENFroVvkBNAGggH7f5nFLmXeoSO.qIZeHDduuFsLH
 75cux9YHqd5Ppc5oefNkX21pvkXZ3dyIe7da5jjXeLEaBX6ygtICLaqsrOtCBaEPp8HquSEVr9m3
 LnnphjARVblBptzWZMpHVeu3sU39wLyqEkwsTS7YdpteIPxzBBOZG3j70.O4p4nBb_UykY4EEiQl
 c2Ih6xZ2F3IBFdHm3q7YOYD0yh7qnhjak
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 Jan 2020 19:15:33 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9c3599fd7b7b5227ab5bb2874628a14e;
          Fri, 31 Jan 2020 19:15:31 +0000 (UTC)
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CAOSEQ1poqrUQdRc+ZLNbEoPqgd4MMomeYmefjca_mj-2zxrdUA@mail.gmail.com>
 <7ebd42d8-5392-90f6-fc08-4364176cfbb6@schaufler-ca.com>
 <CAOSEQ1p0q4gxVwN3MJkP=xxn4GUVaKsaArtQpxNy5rv7vYvVVw@mail.gmail.com>
 <abd4dddb-8968-2655-3d80-ce446451b3de@canonical.com>
 <CAOSEQ1rBu+wRzgk_Jh2RsZpf8Lv1+WUi-Pte-EsBMphnEr4SsQ@mail.gmail.com>
 <e7cfc960-32fb-7712-b21c-37999cf29430@tycho.nsa.gov>
 <2a984c76-a499-53f6-68c5-5d3604094ba4@tycho.nsa.gov>
 <CAOSEQ1o3nhY-svtsFSSv+M=V+NchxmBbhY-FvqoTzJgMnZ1ydw@mail.gmail.com>
 <1479ac1a-b957-f907-b983-c0bcefd51457@tycho.nsa.gov>
 <fe62d7a7-5f7c-cb14-01b1-f3d7fef2862b@tycho.nsa.gov>
 <CAOSEQ1o6+uL-ATjQ_YXaJP9KxFTS3_b_bzeO7M8eiKbCB9dsyQ@mail.gmail.com>
 <c98000ea-df0e-1ab7-a0e2-b47d913f50c8@tycho.nsa.gov>
 <6abc1c24-1dad-da7b-657f-94a3c046413a@tycho.nsa.gov>
 <CAOSEQ1rOQ50WjvvUSeVpf0RREenP_59u34yx1YQE1YdigzOXcg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6f06bde2-b54c-a32c-4062-2ac680628aea@schaufler-ca.com>
Date:   Fri, 31 Jan 2020 11:15:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1rOQ50WjvvUSeVpf0RREenP_59u34yx1YQE1YdigzOXcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15113 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/2020 11:08 AM, Wenhui Zhang wrote:
> Hi, Smalley:
> DAC, MAC and SELinux's performance data is performed, and it seems like our conclusion is consistent with our previous evaluation.
> Please see here (configuration files are included as well):
>  5.3.0-results <https://drive.google.com/drive/folders/1NPkHYoffPnkvMlXIM5ytrqzBThLwXx86>
> I am trying to test other modules (SMACK, Apparmor, Integrity etc. )
>
> However what confused me a lot is the Kconfig file in ./linux/security/Kconfig:
> config LSM
>         string "Ordered list of enabled LSMs"
>         default "newmodule,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
>         default "newmodule,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
>         default "newmodule,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
>         default "newmodule,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
>         default "newmodule,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> IMHO, it seems like it is a little confusing, changing it to below maybe make it a lilttle more clear:
> config LSM
>         string "Ordered list of enabled LSMs"
>         default "newmodule,yama,loadpin,safesetid,integrity, tomoyo, apparmor, selinux, smack" if DEFAULT_SECURITY_SMACK
>         default "newmodule,yama,loadpin,safesetid,integrity,tomoyo, smack, selinux, apparmor" if DEFAULT_SECURITY_APPARMOR
>         default "newmodule,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
>         default "" if DEFAULT_SECURITY_DAC *# could we leave this to empty string*
>         default "newmodule,yama,loadpin,safesetid,integrity,*selinux,smack,tomoyo,apparmor"  # on Ubuntu, apparmor be the the dedault, however on centos etc, maybe selinux be the default, on andriod smack as default  *
> Any suggestions on clean up the code on this part please?
>
The ordering is historical. The "major" security modules are
listed in the order they where accepted into Linus' tree.

BTW, as much as I'd like it to be true, Android would not use
Smack as its default.

>
> On Fri, Jan 24, 2020 at 9:56 AM Stephen Smalley <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>> wrote:
>
>     On 1/15/20 11:04 AM, Stephen Smalley wrote:
>     > On 1/15/20 10:59 AM, Wenhui Zhang wrote:
>     >>
>     >>
>     >> On Wed, Jan 15, 2020 at 10:41 AM Stephen Smalley <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
>     >> <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>> wrote:
>     >>
>     >>     On 1/15/20 10:34 AM, Stephen Smalley wrote:
>     >>      > On 1/15/20 10:21 AM, Wenhui Zhang wrote:
>     >>      >>
>     >>      >> On Wed, Jan 15, 2020 at 9:08 AM Stephen Smalley
>     >>     <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov> <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
>     >>      >> <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov> <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>>> wrote:
>     >>      >>
>     >>      >>     On 1/15/20 8:40 AM, Stephen Smalley wrote:
>     >>      >>      > On 1/14/20 8:00 PM, Wenhui Zhang wrote:
>     >>      >>      >> Hi, John:
>     >>      >>      >>
>     >>      >>      >> It seems like, the MAC hooks are default to*return 0 or
>     >>     empty
>     >>      >> void
>     >>      >>      >> hooks* if CONFIG_SECURITY, CONFIG_SECURITY_NETWORK ,
>     >>      >>      >> CONFIG_PAGE_TABLE_ISOLATION, CONFIG_SECURITY_INFINIBAND,
>     >>      >>      >> CONFIG_SECURITY_PATH, CONFIG_INTEL_TXT,
>     >>      >>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR,
>     >>      >>      >>
>     >>     CONFIG_HARDENED_USERCOPY, CONFIG_HARDENED_USERCOPY_FALLBACK *are
>     >>      >>     NOT
>     >>      >>      >> set*.
>     >>      >>      >>
>     >>      >>      >> If HOOKs are "return 0 or empty void hooks", MAC is not
>     >>     enabled.
>     >>      >>      >> In runtime of fs-benchmarks,
>     >>     if CONFIG_DEFAULT_SECURITY_DAC=y,
>     >>      >> then
>     >>      >>      >> capability is enabled.
>     >>      >>      >>
>     >>      >>      >> Please correct me if I am wrong.
>     >>      >>      >>
>     >>      >>      >> For the first test, wo-sec is tested with:
>     >>      >>      >> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>     >>      >>      >> # CONFIG_SECURITY is not set
>     >>      >>      >> # CONFIG_SECURITYFS is not set
>     >>      >>      >> # CONFIG_PAGE_TABLE_ISOLATION is not set
>     >>      >>      >> # CONFIG_INTEL_TXT is not set
>     >>      >>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>     >>      >>      >> # CONFIG_HARDENED_USERCOPY is not set
>     >>      >>      >> CONFIG_FORTIFY_SOURCE=y
>     >>      >>      >> # CONFIG_STATIC_USERMODEHELPER is not set
>     >>      >>      >> CONFIG_DEFAULT_SECURITY_DAC=y
>     >>      >>      >>
>     >>      >>      >>
>     >>      >>      >> For the second test, w-sec is tested with:
>     >>      >>      >> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>     >>      >>      >> CONFIG_SECURITY=y
>     >>      >>      >> CONFIG_SECURITYFS=y
>     >>      >>      >> # CONFIG_SECURITY_NETWORK is not set
>     >>      >>      >> CONFIG_PAGE_TABLE_ISOLATION=y
>     >>      >>      >> CONFIG_SECURITY_INFINIBAND=y
>     >>      >>      >> CONFIG_SECURITY_PATH=y
>     >>      >>      >> CONFIG_INTEL_TXT=y
>     >>      >>      >> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
>     >>      >>      >> CONFIG_HARDENED_USERCOPY=y
>     >>      >>      >> CONFIG_HARDENED_USERCOPY_FALLBACK=y
>     >>      >>      >> # CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
>     >>      >>      >> CONFIG_FORTIFY_SOURCE=y
>     >>      >>      >> # CONFIG_STATIC_USERMODEHELPER is not set
>     >>      >>      >> # CONFIG_SECURITY_SMACK is not set
>     >>      >>      >> # CONFIG_SECURITY_TOMOYO is not set
>     >>      >>      >> # CONFIG_SECURITY_APPARMOR is not set
>     >>      >>      >> # CONFIG_SECURITY_LOADPIN is not set
>     >>      >>      >> # CONFIG_SECURITY_YAMA is not set
>     >>      >>      >> # CONFIG_SECURITY_SAFESETID is not set
>     >>      >>      >> # CONFIG_INTEGRITY is not set
>     >>      >>      >> CONFIG_DEFAULT_SECURITY_DAC=y
>     >>      >>      >> #
>     >>      >>      >>
>     >>      >>
>     >>      >>
>     >>     
>     >> CONFIG_LSM="yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo"
>     >>
>     >>
>     >>      >>
>     >>      >>
>     >>      >>      >>
>     >>      >>      >
>     >>      >>      > Your configs should only differ with respect to
>     >>     CONFIG_SECURITY*
>     >>      >>     if you
>     >>      >>      > want to evaluate LSM, SELinux, etc overheads.
>     >>      >> PAGE_TABLE_ISOLATION,
>     >>      >>      > INTEL_TXT, and HARDENED_USERCOPY are not relevant to LSM
>     >>     itself.
>     >>      >>      >
>     >>      >>      > Also, what benchmarks are you using?  Your own home-grown
>     >>     ones, a
>     >>      >>     set of
>     >>      >>      > open source standard benchmarks (if so, which ones?).
>     >>     You should
>     >>      >>      > include both micro and macro benchmarks in your suite.
>     >>      >>      >
>     >>      >>      > How stable are your results?  What kind of variance /
>     >>     standard
>     >>      >>     deviation
>     >>      >>      > are you seeing?
>     >>      >>      >
>     >>      >>      > It is hard to get meaningful, reliable performance
>     >>     measurements
>     >>      >>     so going
>     >>      >>      > down this road is not to be done lightly.
>     >>      >>
>     >>      >>     Also, I note that you don't enable CONFIG_SECURITY_NETWORK
>     >>     above.
>     >>      >> That
>     >>      >>     means you aren't including the base LSM overhead for the
>     >>     networking
>     >>      >>     security hooks.  So if you then compare that against SELinux
>     >>     (which
>     >>      >>     requires CONFIG_SECURITY_NETWORK), you are going to end up
>     >>      >> attributing
>     >>      >>     the cost of both the LSM overhead and SELinux overhead all to
>     >>      >> SELinux.
>     >>      >>     If you truly want to isolate the base LSM overhead, you
>     >> need to
>     >>      >> enable
>     >>      >>     all the hooks.
>     >>      >>
>     >>      >> I will give it a try for enabling CONFIG_SECURITY_NETWORK later
>     >>     this
>     >>      >> week, however I wonder if this would affect the test results
>     >>     that much.
>     >>      >> I am testing with LMBench 2.5 , with focusing on filesystem unit
>     >>      >> tests, however not network stack at this time.
>     >>      >> My understanding of why this result is so different from previous
>     >>      >> paper 20 years ago, is that the Bottleneck changes.
>     >>      >> As Chris was testing with 4 cores , each 700MHz CPU, and 128MB
>     >>     memory,
>     >>      >> with HDD (latency is about 20,000,000 ns for sequential read).
>     >>      >> The  Bottleneck of accessing files w/ MAC are mostly on I/O.
>     >>      >> However hardware setup is different now,  we have much larger and
>     >>      >> faster memory (better prefetching as well), with SSD (latency is
>     >>     about
>     >>      >> 49,000 ns for sequential read). , while CPU speed is not
>     >>     increasing as
>     >>      >> much as that of I/O.
>     >>      >> The Bottleneck of accessing files w/ MAC are mostly on CPU now.
>     >>      >
>     >>      > Don't know if lmbench is still a good benchmark and I recall
>     >>     struggling
>     >>      > with it even back then to get stable results.
>     >>      >
>     >>      > Could be bottleneck changes, could be the fact that your kernel
>     >>     config
>     >>      > changes aren't limited to CONFIG_SECURITY* (e.g. PTI introduces
>     >>      > non-trivial overheads), could be changes to LSM since that time
>     >>     (e.g.
>     >>      > stacking support, moving security_ calls out-of-line, more hooks,
>     >>     ...),
>     >>      > could be that running SELinux w/o policy is flooding the system
>     >> logs
>     >>      > with warnings or other messages since it wasn't really designed
>     >>     to be
>     >>      > used that way past initialization.  Lots of options, can't tell
>     >>     without
>     >>      > more info on your details.
>     >>
>     >>     I'd think that these days one would leverage perf and/or lkp for
>     >> Linux
>     >>     kernel performance measurements, not lmbench.
>     >>
>     >>
>     >> Thanks so much, I will give it a try for lkp and let you know how it
>     >> goes.
>     >> Maybe later next week or this weekend, we should have the results.
>     >
>     > Ok, please make sure your kernel configs are truly comparable (i.e. no
>     > differences other than the right set of CONFIG_SECURITY* options), that
>     > all of the same LSM hooks are enabled for comparing LSM-only versus
>     > SELinux (i.e. CONFIG_SECURITY and CONFIG_SECURITY_NETWORK both enabled),
>     > and consider using a distribution that actually supports SELinux out of
>     > the box (e.g. Fedora) so that you can properly test SELinux with a
>     > policy loaded in enforcing mode.  Similarly if you want to do the same
>     > for AppArmor, except for it you'll need to enable CONFIG_SECURITY_PATH
>     > as well for the pathname-based hooks and you'll want to use Ubuntu or
>     > latest Debian to get a working policy.
>
>     One last point that I should have mentioned: you should likely run your
>     benchmarks both under an unconfined profile/domain and under a confined
>     profile/domain (the latter could be one that you define specifically for
>     your benchmark that just allows it everything) at least for AppArmor.
>     The reason is that AppArmor has an intrinsic concept of unconfined since
>     it was designed for targeted enforcement and its hook functions directly
>     test for the unconfined label early and skip permission checking in that
>     case, so if you only collect data while running benchmarks unconfined,
>     you won't see the real overheads imposed on a confined profile/domain.
>     In contrast, SELinux has no intrinsic concept of unconfined since it was
>     designed for full system confinement (as applied in "strict"
>     configurations and in Android); if there is an unconfined domain, it is
>     merely defined through policy (i.e. there must be explicit allow rules
>     allowing it everything) and the hook functions invoke the same
>     permission checking for both unconfined and confined domains alike.
>
>
>
> -- 
> V/R,
>  
> Wenhui Zhang
>  
> Email: wenhui@gwmail.gwu.edu <mailto:wenhui@gwmail.gwu.edu>
>            Telephone: 1-(703) 424 3193
>           
>  
>  
>  
>
>
