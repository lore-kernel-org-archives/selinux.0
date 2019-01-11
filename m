Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55515C43444
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3170821848
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MlKkmLwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfAKSWZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:22:25 -0500
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:46581 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbfAKSWY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jan 2019 13:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547230942; bh=ACMUVvoRld9YnObV4eh1UYBaQTnEJs0idg5fDfUEKvA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=MlKkmLwW1OjO/Q+K1uPJnH/UM6YmVus+s2qnQ4mvnmTQIzAE0lNRripJUxJd3sWaKnRHcHTGVXccRFTn/Vm/ns6jDhz5PKhezswj4V6GH0cYHk5Xg3lKpuoPXl3klIBzh6BkGSkcTkkxYT06ITrKDJocwdegsZX9J7yGKgcPcv49rk1oBVV/S1wnXfonpf/cS8HXmJDyg/uDQAJlTwsOI/S6J/W8V4554oRmfT+63mkDCRFOHDAt5MdqPvyXVJkuZdRzHTU2nI/EJzAXN5ViIC5loar+WWKc6LHuHjjXBLB9vSs8dbpQd9X00JCcWdCH5XK+Obu3qz0H5pCRdmM4MA==
X-YMail-OSG: kfvN71YVM1lqHnvrutGU1I_hEe7j1BCnBseFRwW3GuJqnUkPX3Y67yrFBYVjGk7
 IHDLV_vOpcDsu5jDgu5SHl6X1xxt8hSbfPK.PF9CVIQwZz5LpjXdKgsH9EllCSTv7cw_JJ4ig2g.
 RJFF0o2pE8g3mgCoQprP6mGAr49NgmutspDdbgyIoeX96Go8hsrqSR07BrVw1UdC1eW1sySO0YTv
 cIlDmvqEkV2KGB1DbC9GBQd5kaCu4I2W0J5rPAD7KxLJeHbN5zBBEOohM.EP1jEPgd8WSVI0GHNo
 NvP_3hrLk5Jilm97Yp8iBj93M5UV3fndny64kcxN8jeS46f9q4qfd87nhhTISPL4CfdUWJgdZtYk
 dCnLh_gQFBh3MzdTXd21iNtmKzILIN5KSeMK4VYdyyrMfu5qFfUa0bw.UaIPStw1yOswEOiNxDJH
 hxpNQQ4C.Sc7Oy8p6ENU_BeJV2K8YolcvhFZvlqHBCocSVNg4YVRjrEdG6SAh_.oy_ok71nqv.HF
 XktfyC5.1pcDz7d5t2LUS_SmpSV_hO8awbEWjfn3WRfjQQfODDUjiZChzCl2E6UTb8btfdID3Qqk
 Lvh2rN3nhdiLLqRyU5Io8ovT373OtRkhmzl9rBO5R8JsqT3GU9mc.sumHD3P1ln0gtG0pjZYXTgS
 qNZjOLofiYbkd0xKfbEZEWa7n8tkglQLNKskNpCEoHdgx7hIjv8DtQD8ACjv8LA91UhA4rJI8KE9
 HRnMmZKk8txXkESmxez_MamH1ByDlmr3jYEHRwQE9lCJC1mbQ1OnY9fUQ6uChG2H93JjxXQ.FzKM
 ck5zSwYbI0Da6DxQhAOBHW2aiiF4key0qXiHJeKUoJeA6_WEhk.SJH21j74Rn7lPC5G96fQxzW8c
 _sSowxuxLqKRhn0HSuZ3VwupVuplnxEWQMEVkitUJvZzMtRw.YGAru98H_T2MHUs6jMSCZdHU_dI
 CRfA3FFINA2Fyt8iYO7Y0Ivw_Zoyp3GIeYISqh3Yx4t13bhANtcVHEccsdnnjRRWM1ifjYrxq0HP
 ALT9qWZXkUcPRD.OEtMW4hYOg9REOC.w6DlLyUZvfxpWKzaze.jlR18JQ4oivSCZ2AKtz0NZSwsS
 V6yYLb30bafCseloQniHLiHu_XwA3iZsYiC2vpasuKXIoAmRiNssB_m9L7F1p0nuEy5VXL9wce_B
 34lsDu7s8TCkuKT9d9aAc.EH784K6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Jan 2019 18:22:22 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dc8dcd6cd8ac76cfb4dab5dea6e2931d;
          Fri, 11 Jan 2019 18:22:21 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
 <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov>
 <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
 <2612c523-084a-7652-58ca-9e062b80138e@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <38636851-62e1-5cb8-ec1b-3fcd66c13dba@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 10:22:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <2612c523-084a-7652-58ca-9e062b80138e@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/2019 11:37 AM, Stephen Smalley wrote:
> On 1/10/19 12:54 PM, Casey Schaufler wrote:
>>
>> Resending after email configuration repair.
>>
>> On 1/10/2019 6:15 AM, Stephen Smalley wrote:
>>> On 1/9/19 5:03 PM, Casey Schaufler wrote:
>>>> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
>>>>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
>>>>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>>>>>> Changes in v2:
>>>>>>> - add docstring for the new hook in union security_list_options
>>>>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>>>>>>      implemented
>>>>>>> v1: https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/
>>>>>>>
>>>>>>> This series adds a new security hook that allows to initialize the security
>>>>>>> context of kernfs properly, taking into account the parent context. Kernfs
>>>>>>> nodes require special handling here, since they are not bound to specific
>>>>>>> inodes/superblocks, but instead represent the backing tree structure that
>>>>>>> is used to build the VFS tree when the kernfs tree is mounted.
>>>>>>>
>>>>>>> The kernfs nodes initially do not store any security context and rely on
>>>>>>> the LSM to assign some default context to inodes created over them.
>>>>>>
>>>>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to the usual
>>>>>> and expected filesystem behavior?
>>>>>
>>>>> sysfs / kernfs didn't support xattrs at all when we first added support for setting security contexts to it, so originally all sysfs / kernfs inodes had a single security context, and we only required separate storage for the inodes that were explicitly labeled by userspace.
>>>>>
>>>>> Later kernfs grew support for trusted.* xattrs using simple_xattrs but the existing security.* support was left mostly unchanged.
>>>>
>>>> OK, so as I said, this seems like a bug in kernfs.
>>>>
>>>>>
>>>>>>
>>>>>>> Kernfs
>>>>>>> inodes, however, allow setting an explicit context via the *setxattr(2)
>>>>>>> syscalls, in which case the context is stored inside the kernfs node's
>>>>>>> metadata.
>>>>>>>
>>>>>>> SELinux (and possibly other LSMs) initialize the context of newly created
>>>>>>> FS objects based on the parent object's context (usually the child inherits
>>>>>>> the parent's context, unless the policy dictates otherwise).
>>>>>>
>>>>>> An LSM might use information about the parent other than the "context".
>>>>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the parent
>>>>>> to determine whether the Smack label of the new object should be taken
>>>>>> from the parent or the process. Passing the "context" of the parent is
>>>>>> insufficient for Smack.
>>>>>
>>>>> IIUC, this would involve switching the handling of security.* xattrs in kernfs over to use simple_xattrs too (so that we can store multiple such attributes), and then pass the entire simple_xattrs list or at least anything with a security.* prefix when initializing a new node or refreshing an existing inode.  Then the security module could extract any security.* attributes of interest for use in determining the label of new inodes and in refreshing the label of an inode.
>>>>
>>>> Right. But I'll point out that there is nothing to prevent an
>>>> LSM from using inode information outside of the xattrs (e.g. uids)
>>>> to determine the security state it wants to give a new object.
>>>
>>> If that's a real concern, the hook could pass the ia_iattr structure in addition to the simple_xattrs list and the security module could use any inode attributes it likes in making the decision.  Effectively it would be passing the entire kernfs_iattrs structure, but probably not directly since that definition is presently private to kernfs.
>>
>> Yes, it's a real concern. And no, just passing all of the kernfs internal data
>> out in j-random formats does not pass muster. Al Viro was commenting the other
>> day on how bad the LSM infrastructure interfaces are. The original proposal here
>> is already big, cluttered and inadequate. Adding more to it to make up for its
>> shortcomings should be sending up red flags
> I don't quite see how the original patch set or hook can be called big and cluttered.  Switching the handling of security xattrs in kernfs to use simple_xattrs (a natural and seemingly straightforward cleanup) and passing the entire simple_xattrs list to the hook interface would allow you to support SMACK64TRANSMUTE, which was the one actual inadequacy you identified.  You claim that someone might need/want the parent uid/gid too, but there are no in-tree security modules that do so nor any submitted AFAIK, and if that situation arises, all we need to do to support it is to add the iattrs.  Obviously they can all be wrapped up in some larger structure if desired. At that point the security modules would have access to all of the inode attributes supported by kernfs.

We already have a structure to wrap all this in. It's an inode.

But, as you point out, there are no in tree LSMs that use
anything beyond the xattrs. So the change you're suggesting
is arguably sufficient, and considerably easier.

>
>> I've been wallowing in the LSM infrastructure for the past seven years.
>> Interfaces like this one, that propagate the idiosyncrasies of both
>> the caller (kernfs) and one potential callee (SELinux) are much too
>> common. I understand that there is a problem that needs a solution.
>> This isn't it.
> The solution sketched above should be capable of supporting the needs of any current security modules and of being easily extended for others if the need arises.

It, like security_inode_init(), is going to be
challenging to get right in the stacking environment.
But, that's my problem.

>
>>
>>
>>>> I suggest that the better solution would be for kernfs to
>>>> use inodes like a real filesystem. Every special case like this
>>>> results in special cases like this special hook. It's hard
>>>> enough to keep track of the general case in the Linux kernel.
>>>
>>> Feel free to propose an implementation if you like, but doing a complete rewrite of kernfs internals seems a bit out of scope.
>>
>> If this issue points out a serious problem with the kernfs implementation
>> then I would expect that addressing the problem at its source would be in
>> everyone's best interest. Did anyone even look at the possibility? If I
>> said that I would do that, how long would you be willing to wait for it?
>
> I don't know that it points to a serious problem with kernfs.  But I'll let you convince the kernfs maintainers of that. Meanwhile, we have a proposed solution that solves the problem for all in-tree security modules.  I see no reason to hold that up. Don't over-design.

I think the patch presented was hasty. It clearly didn't
account for any LSM but SELinux. I understand why. Adding an
LSM interface needs to account for the entire security sub-system.

