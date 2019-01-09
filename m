Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5995FC43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 17:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A73620660
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="samaJmwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfAIRTl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:19:41 -0500
Received: from sonic301-28.consmr.mail.gq1.yahoo.com ([98.137.64.154]:34899
        "EHLO sonic301-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbfAIRTl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 12:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547054378; bh=9Mn+I/UR/khtUI+gple4O/A+ZEwY/KarkcOPd5R0DJ8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=samaJmwD37jOe8nghfsdbmYznpzGwkHoJWG9uUMRzA+4AiPeAiyMUKC0GL6R/BhbEpqq4M4E4ZMJ1ilahs0CdJGn76towix2Dkzxa+6xlUxTQctdz8Lhhm9IHyNlrjo5eugkJUAeRDwyj6HwVCqFVpr8QFdKB0xluNWg2vaW6FCNMP7e1i3YTC0zMjg9vdTGt1kyGe7V2eBULl+T7tVsli/ODO7XNkmJ2oGoejzn9BOVl4gjpD6O0nYVGwb0JXO1bUzFKVEOgdcDYTGCuJLNpwe4WowJN/cJf6bSDXKThvrEMnrAJkQ/JgaOwpybPW2rLUWvQelKYSyyRLiU5N4BYQ==
X-YMail-OSG: W7WRRjAVM1mdIF4W1BUJONLsYR648ILp4Pq2E3gBIR23nIK9XpW7xtEZ3L4Ages
 O3BiST.MrEJ82XlyuietxaBuWnTMIAJwn.ABp_AtJA.EuG60zYLuucrd5Ca86kZfVFlY49Gk6SU5
 P88rPBb.Dq0LBn6TdHq87ScDWmqVL1uHQl7yhEgU5h92pWgBrfARg2TzRbIhWSelPgluy5UA_M3z
 F9oWcDiKnZguyfE_rN7m.CRxatzEXsuGG3z_QxZdZlZ.uoPTWrb84grqPoFIHcSUky36lZYUJkTA
 tNXWfwh9LSHhn18owtlFxJceUpvcbXtk5RGZu0o8cRhk0JsR1kw1EVTHFqwCeeFcFkwhS0TOeqGP
 sQfxveE9Tu017WyfK.Z4119.x85oMs09bbVYQ3.7BH_DAhNGbxPdh79ASsq6US7y5UlBhaabdj30
 2SoV_Af_gkk_jAgQoVq9xON8gakSDMxGxw_G_v6m96HutFb49mLusPOmDan5h1N4it8CGWeNghW_
 xKApmdjB7A1pCKH_7yel7EcOb12VOQP_rQwIhZPD859.fy5ipfxNLGyYU5odFbFDIjcOPpxw6ttB
 6jcogZjCqiScejdDVfP0HV6AAWQ2dh09W9rFf6DzX5HNGh3ELZsGSnTu3FmfDhonvSmYu6yeFsN1
 N1zwckAZfIEgsU1.Ya.qMd9RST4Wv7aEAT3JDsoO0IWFf7LTJ2BQARFBo3YDHBGpm3hKCfg3jVnp
 BTBOB6ft6wMDr4Eheu.o_MKCM5Ga2UX3ooZBanmbjp7rBcCzgFpKIc7WGBjvWUEXGQKLdLhDgN2_
 4Z72cIIGWlN0zh8qmx5GDlmQOlJLXxaSzFSJql2E1433jmUImH7c3m9aYU6jDhw4PzY7iwQ3Aktj
 6wP6AyaipeGh2DrxV4UQEO7ya8SYXcVcdpvI0jcWKQNssbwz7MUHFB1kqoPPv__0CO5kV3y_SzNN
 0Yr_eH7prRMsdj2KSDJ_4ip3mIxLMSo7LVGH2AXtUymVK2d.jgWg8NAqty0sV3BvmL.A9s32trBD
 3IfDJLa0ZVo1rW8QUILGNj0QLmMJVwVFw54CBk0VfFcZoZd3lvgjQ0D74yxsnlDaE7.gXGeX0l9h
 9gGIUGviAApPEXzw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Wed, 9 Jan 2019 17:19:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bb9aeb0e60b31220300e58ba4fbf53b1;
          Wed, 09 Jan 2019 17:19:33 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
Date:   Wed, 9 Jan 2019 09:19:31 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190109162830.8309-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
> Changes in v2:
> - add docstring for the new hook in union security_list_options
> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>   implemented
> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>
> This series adds a new security hook that allows to initialize the security
> context of kernfs properly, taking into account the parent context. Kernfs
> nodes require special handling here, since they are not bound to specific
> inodes/superblocks, but instead represent the backing tree structure that
> is used to build the VFS tree when the kernfs tree is mounted.
>
> The kernfs nodes initially do not store any security context and rely on
> the LSM to assign some default context to inodes created over them. 

This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
and expected filesystem behavior?

> Kernfs
> inodes, however, allow setting an explicit context via the *setxattr(2)
> syscalls, in which case the context is stored inside the kernfs node's
> metadata.
>
> SELinux (and possibly other LSMs) initialize the context of newly created
> FS objects based on the parent object's context (usually the child inherits
> the parent's context, unless the policy dictates otherwise). 

An LSM might use information about the parent other than the "context".
Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
to determine whether the Smack label of the new object should be taken
from the parent or the process. Passing the "context" of the parent is
insufficient for Smack.

> This is done
> by hooking the creation of the new inode corresponding to the newly created
> file/directory via security_inode_init_security() (most filesystems always
> create a fresh inode when a new FS object is created). However, kernfs nodes
> can be created "behind the scenes" while the filesystem is not mounted
> anywhere and thus no inodes exist.
>
> Therefore, to allow maintaining similar behavior for kernfs nodes, a new LSM
> hook is needed, which would allow initializing the kernfs node's security
> context based on the context stored in the parent's node (if any).
>
> The main motivation for this change is that the userspace users of cgroupfs
> (which is built on kernfs) expect the usual security context inheritance
> to work under SELinux (see [1] and [2]). This functionality is required for
> better confinement of containers under SELinux.
>
> The first patch adds the new LSM hook; the second patch implements the hook
> in SELinux; and the third patch modifies kernfs to use the new hook to
> initialize the security context of kernfs nodes whenever its parent node
> has a non-default context set.
>
> Note: the patches are based on current selinux/next [3], but they seem to
> apply cleanly on top of v5.0-rc1 as well.
>
> Testing:
> - passed SELinux testsuite on Fedora 29 (x86_64) when applied on top of
>   current Rawhide kernel (5.0.0-0.rc1.git0.1) [4]
> - passed the reproducer from the last patch
>
> [1] https://github.com/SELinuxProject/selinux-kernel/issues/39
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/log/?h=selinux-pr-20181224
> [4] https://copr.fedorainfracloud.org/coprs/omos/kernel-testing/build/842855/
>
> Ondrej Mosnacek (3):
>   LSM: Add new hook for generic node initialization
>   selinux: Implement the object_init_security hook
>   kernfs: Initialize security of newly created nodes
>
>  fs/kernfs/dir.c             | 49 ++++++++++++++++++++++++++++++++++---
>  fs/kernfs/inode.c           |  9 +++----
>  fs/kernfs/kernfs-internal.h |  4 +++
>  include/linux/lsm_hooks.h   | 30 +++++++++++++++++++++++
>  include/linux/security.h    | 14 +++++++++++
>  security/security.c         | 10 ++++++++
>  security/selinux/hooks.c    | 41 +++++++++++++++++++++++++++++++
>  7 files changed, 149 insertions(+), 8 deletions(-)
>

