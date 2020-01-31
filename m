Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA45AC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 19:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F2620707
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 19:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TuE1ajHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgAaTt4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:49:56 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:55713 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAaTt4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 14:49:56 -0500
X-EEMSG-check-017: 52728752|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,386,1574121600"; 
   d="scan'208";a="52728752"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Jan 2020 19:49:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580500192; x=1612036192;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8Rdw6KkFq1TvJ0bsrY92FGP1caDjSUyMylJunPjAU2g=;
  b=TuE1ajHXW3ek+vc6YgHrhnHAH0jFNRtC9WWjN6ZqwJ98FRM/uxWEbgDD
   49TUQqyaOZZ6A/IRfBtRl4bwJvhFdPI8KTI/q93WgsGJN6d57jy1fK6pV
   e8qG7Dz+rsjIlgUKN0F1Oe6BtHvmeHsSYcoaTZjEMQvgk+/wjCdovNA19
   8324Dsd9DdAe2eD4nsELAmnEHCK26u0VLI63wKpjxerd/rNvRsEW3nTt4
   SIiTi7WYXMNbnHl0f6qYCfEpSizALoUb8hrXNJ6rFDZN/gAJdGWKju9Lp
   nR1AfMCCdHCv5P/gF0iLfX/Mkn1B/Lmw9+mYoGT9DP0uw3Fz/gF3ilaih
   A==;
X-IronPort-AV: E=Sophos;i="5.70,386,1574121600"; 
   d="scan'208";a="38533078"
IronPort-PHdr: =?us-ascii?q?9a23=3AuoWbLx/kHli6+v9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1ugRIJqq85mqBkHD//Il1AaPAdyHra4cwLOM6+igATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4RvJro+xh?=
 =?us-ascii?q?fUvHdEZ/ldyWd0KV6OhRrx6dq88ZB5/yhMp/4t8tNLXLnncag/UbFWFiktPX?=
 =?us-ascii?q?ov5M3suxnDTA+P6WUZX24LjBdGABXL4Q/jUJvpvST0quRy2C+BPc3rVr80Qi?=
 =?us-ascii?q?it771qSBDzligKMSMy/XzNhcxxiKJbpw+hpwB6zoXJboyZKOZyc6XAdt4BW2?=
 =?us-ascii?q?FPQtheWDBAAoOkbosAEewBPfpDr4Lgo1cCtAayCRWwCO/qzDJHiGX23akn2O?=
 =?us-ascii?q?o/Fw/I0hErE9YXvHjKqNj5MaEfWv23wqbV1zXOd+5Y1ynz6IbIcR4vr/+DUr?=
 =?us-ascii?q?1yfsXNxkciDB/Fg1aKpID5Iz+Y2OYAvm6G5ORgT+KvjGsnphlsrDiz2Mgsko?=
 =?us-ascii?q?nJiZwTylvZ6Ct5xZw6Jdm8SEFlYd+vDZxdtzqHOIttWc4iX2Fptzo6yr0Bo5?=
 =?us-ascii?q?K7ejMKx449yx7QbPyHbZGF7xT+X+ifJjd4gWhqeLO5hxuq6kiv1On8Vsiy0F?=
 =?us-ascii?q?ZXoStFisPMtncP1xPN9seHVuFx/kC72TaAzwzT5eZEIUc7larfNZEt2KI/lp?=
 =?us-ascii?q?0WsUnFAyT4m132gbeLekgr9eWk8eTqbqj8qpOCOIJ4lBvyPrkol8eiG+o3KB?=
 =?us-ascii?q?IOUHKe+emk0b3j+lD2T6tSg/0tl6nZrIjaJcMGpq6lGwNV0pgs6xK4Dzq+zN?=
 =?us-ascii?q?QXh2MHLFNYeBKclYTpOlfOIP7/DfeknVujjC1nx+zGP7L9ApXNKWLPkLH9cr?=
 =?us-ascii?q?Zm90FQ0g8zzdFb555MC7EBJuz8WlPpudDFARI0PBa4zub6BNlnyI8TVnyDDr?=
 =?us-ascii?q?WEPK/KtF+H/OMvI+2CZI8Pvzb9LuAo5+Xzgn8iglIdYamo0ocXaHC/BPhmJV?=
 =?us-ascii?q?6ZbmD2jtcOFmcKoBIyTPb2h12aTT5Te3GyUroy5z4lDoKmDZrDRoG2jbyO0i?=
 =?us-ascii?q?a7G4dZZmFCClyWHnfpeZiEV+0SZy2PP89riiYEWqS5S489yRGusxf3y7hgLu?=
 =?us-ascii?q?rU/C0Ur5Dj1N915+LJkxEy7iJ7D8KG3m6RVW50mGQIRzk33K9ju0N9zk2P3r?=
 =?us-ascii?q?R/g/xdDdZT/e9GUh8mNZ7AyOx3E8z9VRjaftiXSFerWc6mDi0xTt0r3t8ObU?=
 =?us-ascii?q?J9FMu4jhzawyWlGaUZmKCMBJwx6qjcxWT+J95hy3ba06ksl0UpTdFUNWK4hq?=
 =?us-ascii?q?9z7RPTCJLJk0qDiqaqe6Ac0zDX9GqYzGqOul1YXxB0UanfQX8fYU7Wp8zj5k?=
 =?us-ascii?q?zeV7+uFagnMgxZxM6AL6tKbcfpjU9HRPf4I9neZXi+m2KuChaJ3L+Ma5Dqe2?=
 =?us-ascii?q?oF1iXHFEcEixwT/WqBNQUmAiehomTeDCFhFF72eEPj7/VxqG6hTk810wGLb1?=
 =?us-ascii?q?Rt17+y+hEImPycT+0c06kauCcutTp0Bkyx39HIBNqaoQpuYqFcbck64Fdd2m?=
 =?us-ascii?q?LTrxZ9MYC4L6B+ml4edBx6v1jw2BVzC4VAl9UqrXwxwQpsJqKXzklBeymb3Z?=
 =?us-ascii?q?/uIL3XLHf9/BS1Z67RwFHe386c+r0T5/Qgt1XjoAapG1Ih83p5zdZVyGeT5p?=
 =?us-ascii?q?LNDAoRSp/+TkY39wJ9p7HfYyk9+obU2WdrMamuvT/Iw8gpC/c9yha8Y9dfN7?=
 =?us-ascii?q?uJFBfsHM0cCMiuNe0qm16wYhIHIu9S7qg0MN2id/ad2a6nJeJgnDW4jWtZ+o?=
 =?us-ascii?q?x9yViD9ylhSu7SxZkJ2feY0RWdWzf+lFerqtr3lpxcZTEOAmq/zjDpBJZLaa?=
 =?us-ascii?q?1veYYGEn+uLNeqxtV6npLtXnlY9Fm5B1wYwsOmZR2Sb1mulTFXgHsap3y6mG?=
 =?us-ascii?q?OKzzVynHl9saeZ3DHP6+v9cRMGPihEW3QkgFvxd9ualdcfCXO0YhApmR3t3k?=
 =?us-ascii?q?Pzw6xWtewrNGXIaVtZdCjxaWd5W+2/saTUMJ0H048hrSgCCLf0WludULOo5k?=
 =?us-ascii?q?JAgi4=3D?=
X-IPAS-Result: =?us-ascii?q?A2DEBgArhDRe/wHyM5BlDhABCxyDcwWBGFUgEoQ+iQOGW?=
 =?us-ascii?q?AEBAQEBAQaBN4lvkHBZCQEBAQEBAQEBAS0KAQGEQAKCVTgTAhABAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIU3DII7KQGDAQEBAQECASMPAQVBBQsJAhgCAiYCAlcGDQgBARqCS?=
 =?us-ascii?q?T8BglYFIA8DkjGbA3WBMoQ1AYEUg0eBPoEOKow6eYEHgREnD4IvLj6CZAKEc?=
 =?us-ascii?q?4JeBI1Igk+HZnuWaIJFgk6Ed4VHiS0GG4JIeIcVkDCXR5RCIjeBISsIAhgII?=
 =?us-ascii?q?Q87gm0HAUcYDY4pF4NQhRSFBFkjA455AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 31 Jan 2020 19:49:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00VJmh8r175284;
        Fri, 31 Jan 2020 14:48:45 -0500
Subject: Re: Perf Data on LSM in v5.3
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
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
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c757fd5b-b6b8-b969-d71a-9d615d738798@tycho.nsa.gov>
Date:   Fri, 31 Jan 2020 14:50:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1rOQ50WjvvUSeVpf0RREenP_59u34yx1YQE1YdigzOXcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/20 2:08 PM, Wenhui Zhang wrote:
> Hi, Smalley:
> DAC, MAC and SELinux's performance data is performed, and it seems like 
> our conclusion is consistent with our previous evaluation.
> Please see here (configuration files are included as well):
> 5.3.0-results 
> <https://drive.google.com/drive/folders/1NPkHYoffPnkvMlXIM5ytrqzBThLwXx86>
> I am trying to test other modules (SMACK, Apparmor, Integrity etc. )

Still looks like there are some unrelated differences in kernel configs 
among dac, mac, and selinux that aren't actually related to what you are 
testing.  Also, looks like there is a typo in your CONFIG_LSM for 
selinux-config.txt, not sure what effect that has if any.

Looks like you are only running micro benchmarks?

What did you use as your base distribution?  Fedora 31?  Is SELinux 
running enforcing with a policy loaded, and no denials during the 
benchmark runs (i.e. no avc:  denied messages in ausearch -m AVC -ts 
boot or journalctl -b output)?  Is the benchmark running in unconfined_t 
or some other context?

> However what confused me a lot is the Kconfig file in 
> ./linux/security/Kconfig:
> config LSM
>          string "Ordered list of enabled LSMs"
>          default 
> "newmodule,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" 
> if DEFAULT_SECURITY_SMACK
>          default 
> "newmodule,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" 
> if DEFAULT_SECURITY_APPARMOR
>          default "newmodule,yama,loadpin,safesetid,integrity,tomoyo" if 
> DEFAULT_SECURITY_TOMOYO
>          default "newmodule,yama,loadpin,safesetid,integrity" if 
> DEFAULT_SECURITY_DAC
>          default 
> "newmodule,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> IMHO, it seems like it is a little confusing, changing it to below maybe 
> make it a lilttle more clear:
> config LSM
>          string "Ordered list of enabled LSMs"
>          default "newmodule,yama,loadpin,safesetid,integrity, tomoyo, 
> apparmor, selinux, smack" if DEFAULT_SECURITY_SMACK
>          default "newmodule,yama,loadpin,safesetid,integrity,tomoyo, 
> smack, selinux, apparmor" if DEFAULT_SECURITY_APPARMOR
>          default "newmodule,yama,loadpin,safesetid,integrity,tomoyo" if 
> DEFAULT_SECURITY_TOMOYO
>          default "" if DEFAULT_SECURITY_DAC *# could we leave this to 
> empty string*
>          default 
> "newmodule,yama,loadpin,safesetid,integrity,*selinux,smack,tomoyo,apparmor"  
> # on Ubuntu, apparmor be the the dedault, however on centos etc, maybe 
> selinux be the default, on andriod smack as default *
> Any suggestions on clean up the code on this part please?

I could be wrong but I think the ordering is to preserve the old 
behavior of DEFAULT_SECURITY_FOO while still allowing future stacking 
if/when it is supported by the respective modules.  So the default major 
module has to precede any other major modules in the list in order to 
win at registration time.

BTW Android uses SELinux [1], not Smack.

[1] http://selinuxproject.org/page/SEAndroid
