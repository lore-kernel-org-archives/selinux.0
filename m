Return-Path: <SRS0=duOh=PS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2556EC43444
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD6F214DA
	for <selinux@archiver.kernel.org>; Thu, 10 Jan 2019 17:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KnlM/It2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfAJRzG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:55:06 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:38654 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730617AbfAJRzG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 12:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547142904; bh=Yluaqh5o1H1K75fAXoM1NHt4NAZRMuwYjZZwnYdAsaA=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject; b=KnlM/It2i9tl9ex7501yeJrznyMXKFaDL1OSlJUKRYObraBd6i7KVOY0qIN4rdP3B+zzw7qdJQErfnqFopdon31KSE9RVjiWW0N+x3LKNZfyZtldYwjqjgrkWyRr3BqJXZfZ7a4cGp2b0+2P6IFep0n2O/iRUogVvOXzWlIpDcwCbxdUPMLeLzK8W9Z6+z/h8S+sGnmTWM1BHQK0H0scaninLHnQlRoY9qSegVt/8yWHMV0Q3ss6WIp7/0fgRqPHcJVo3YHCOqb2gmiAxEMKAWiaESHvA3thmFzZob74cemzVjMM+DvxJuEbB9i37Rym4NKeGu8yCwv5IwRKYsGeSw==
X-YMail-OSG: FH6M_fMVM1mCqaEUzWUi8oH4R7Q9NUnCme7SST6zptHBndBHRkLiWczb6FWI5sp
 1YU6D3Is_udPCauOKmP4KYXiILdcDwBwzn3wJNNOx9ZqjFMpLMm3thzRqPBHjVheqs_SUllyHQSj
 _j4Go8n0ODTGIJQKuRsS0eBdphRaLktD9NGf0JZwUYkvS8LCyzimSaeK1I8e2.wwMIpTzFHI2nQ5
 RzSm3LNWgtTNHhLf3AUuV7vWeiUe4s0Ky4ngTLOu8PpAx0WCsQfW9AIiohEMDHSiN6kK_2YB0QV4
 na2K5LiHpuJt2RbzoPQtEKaB65wYHi_ROPMUeNTmeWi1MkR1ggecG3TwtacsQdUegzW9HAaxY12P
 wkBz66WqaE5UE4EMOXVTY3V4lhcSbFIoXrrEPl23IqFtlgowl8bWe5ZL.fhF3iUrDKZK1Sk7FZCz
 sZW5KCuSt0du7OuKvZkMr.F6Gjk2bE2xLO0ziCTIyBnuhkadXyvQfdyvUBhsSg54fqP8pBVLXQk8
 MOZRA2o6UpKaxNeoVXa6rxOQ4HTiPI7BDVuKm3rZDv3APkIOmgvicABu8Q6dapRiyXrvEKxvW3Ua
 K4YFInigSQwjjnQGL2.wc4Ksrex1qHHPhtQaGLUqdP49iG8tAZgh0t7iYb7gPhxHrcg.lmYA9Lq5
 .VDtbwkLB2IkewifZk_nEhXri1PnTbXaHnS3Mfcpkpf6dyfeeGlD7ZyXxQ_jocOHgLhJBGaBkJW0
 hAl.nc5A38hyvY_rRlhgtKAHsXjad2Gu1q4Kg4QnJi0kt2Gghf3Ycusbzx2yp3fHkkArNfD5Qm1S
 Dhb6CgS0y2y8hb2ysEnkjPtEDPO57v.Gk_RwOqnfcTecGo_a_9x_6FmnRxkiGVEjGqKxFrK6K0OL
 ZYWcGapVsMBEgtaw3N6QIndkPubmdgKfdfM8H77Xe2S8JisOwahDEi4GNolu_.Avl7ZaBeeopJ7x
 LFUdYWs7CkLOHoer24bChNa5DqE3lLdHNkTK70l1FmgY5TT_EaZCrx0Hpip3H.JW9Ohd0A7pdv9A
 FbSdiVB_XN4WuHVFK_GWim0lDg.xwTuXyWZes87hHx.Z13hBPdqToeyXAitPWtIFQ0gO6bznnnkc
 B7Pkq2qieWecsFC6kMnmKaAWw7lu_LLRwubOEimUYdXXu7IJ3BqwVSOo_ho1M4i.Fw8XCD6PvXMg
 GK3zjqwbbusAr0pze.xugyw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 10 Jan 2019 17:55:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID bf9efd63a950395df95a7340eeba5d13;
          Thu, 10 Jan 2019 17:55:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20190109162830.8309-1-omosnace@redhat.com>
 <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
 <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov>
Message-ID: <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
Date:   Thu, 10 Jan 2019 09:54:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Resending after email configuration repair.

On 1/10/2019 6:15 AM, Stephen Smalley wrote:
> On 1/9/19 5:03 PM, Casey Schaufler wrote:
>> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
>>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
>>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>>>> Changes in v2:
>>>>> - add docstring for the new hook in union security_list_options
>>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>>>>     implemented
>>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>>>>
>>>>> This series adds a new security hook that allows to initialize the security
>>>>> context of kernfs properly, taking into account the parent context. Kernfs
>>>>> nodes require special handling here, since they are not bound to specific
>>>>> inodes/superblocks, but instead represent the backing tree structure that
>>>>> is used to build the VFS tree when the kernfs tree is mounted.
>>>>>
>>>>> The kernfs nodes initially do not store any security context and rely on
>>>>> the LSM to assign some default context to inodes created over them.
>>>>
>>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
>>>> and expected filesystem behavior?
>>>
>>> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
>>>
>>> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.
>>
>> OK, so as I said, this seems like a bug in kernfs.
>>
>>>
>>>>
>>>>> Kernfs
>>>>> inodes, however, allow setting an explicit context via the *setxattr(2)
>>>>> syscalls, in which case the context is stored inside the kernfs node's
>>>>> metadata.
>>>>>
>>>>> SELinux (and possibly other LSMs) initialize the context of newly created
>>>>> FS objects based on the parent object's context (usually the child inherits
>>>>> the parent's context, unless the policy dictates otherwise).
>>>>
>>>> An LSM might use information about the parent other than the "context".
>>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
>>>> to determine whether the Smack label of the new object should be taken
>>>> from the parent or the process. Passing the "context" of the parent is
>>>> insufficient for Smack.
>>>
>>> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.
>>
>> Right. But I'll point out that there is nothing to prevent an
>> LSM from using inode information outside of the xattrs (e.g. uids)
>> to determine the security state it wants to give a new object.
>
> If that's a real concern, the hook could pass the ia_iattr structure in addition to the simple_xattrs list and the security module could use any inode attributes it likes in making the decision.  Effectively it would be passing the entire kernfs_iattrs structure, but probably not directly since that definition is presently private to kernfs.

Yes, it's a real concern. And no, just passing all of the kernfs internal data
out in j-random formats does not pass muster. Al Viro was commenting the other
day on how bad the LSM infrastructure interfaces are. The original proposal here
is already big, cluttered and inadequate. Adding more to it to make up for its
shortcomings should be sending up red flags.

I've been wallowing in the LSM infrastructure for the past seven years.
Interfaces like this one, that propagate the idiosyncrasies of both
the caller (kernfs) and one potential callee (SELinux) are much too
common. I understand that there is a problem that needs a solution.
This isn't it.


>> I suggest that the better solution would be for kernfs to
>> use inodes like a real filesystem. Every special case like this
>> results in special cases like this special hook. It's hard
>> enough to keep track of the general case in the Linux kernel.
>
> Feel free to propose an implementation if you like, but doing a complete rewrite of kernfs internals seems a bit out of scope.

If this issue points out a serious problem with the kernfs implementation
then I would expect that addressing the problem at its source would be in
everyone's best interest. Did anyone even look at the possibility? If I
said that I would do that, how long would you be willing to wait for it?

