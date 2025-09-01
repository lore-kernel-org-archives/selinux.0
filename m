Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC04320A27
	for <selinux@vger.kernel.org>; Mon,  1 Sep 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756748521; cv=none; b=nvnK1k/CvIfssh0Fz6SHt279300qlz/TaXWcegA8xw/XCP3pBMxqMzMOaPiwhnOCjwi+hYhhRupBvg/xSGhVeaxFjowikaizKyS8DYNlAF0aox1r2mTdq4aSCDlTLDhglrruls7eOkQwECi1upkcXsg8MWi5snFFFST14WHktk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756748521; c=relaxed/simple;
	bh=aeO7w22JsIXvwgIVmsOZtSBEpoX8hLYBy75BKM8cZEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmRYvknEx3JWnXgsNlIe64h5WQKMykg9W0Pr2R+x7QEk8AkVouVN1+UGjYzT8U6d4frJpnB2TzSxJxSxdeB8WNDeT1FjxDYAdfAtU1GX33VAZpOtZaw0qX+XkKXrr0oTPzcCrSADaAQ5Zf0lsjd/zgkrolktTxUU0ASasclZE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WVvquctc; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WVvquctc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1756748513; bh=POM1fQ/+P+zBZfrS3l3h0rrmQRygV/aJvyFDpjpsvJ0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WVvquctcGzwKfRL7oaXDCSNafwdUy8+ENQ09XzLIqsZp+FNhnlkpU7A4AC7DOt9+pOfuMvQcOqul64P0MImypI1To/zl3WIXL2QIQxOzlBNwLj4A8byEWBMzzNZ5GaeY7buElmJykdpcvxEMCiTYVAXpmrX6/NL+0GNopzJya1iVOA/B8BVc73KttKoCyhklzjHHsPVBpfFDJLq7DKPfmc5NuOMKgMDcH583lAHYsQGkKXp95gNIp0t2n60tu3JfjIaE3s+BJ1tQtsp489kEbqslzdPLnDlSXrdb5EXoILHh64+aI/DDm3NOc9GhhFowBmd9NAPqUIpQ6RpHfxE5EA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1756748513; bh=8TZSOz9SWf6k9rWcymp4T+EZIjoU0vHnwKT7J0xNTWU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OqfmJec0K8y4NmReBB7u86psHNL1zPWZbNpV3tCMqYzPLNQt7h+UyNFkcC1RZeb0kvk2d8FHwdTCsVnaVthNxpo5Tr+ZDFZnT4qKrkpjyCILMWTnEz+9MXlN8+jx6hGp1vYjBB8Dw4AYgGveYjj+H6Edv2s4ss6lcIrtmeCXZWpr9XgN5avBNXQw4QJ3wE14Blee3L6hxRXt/KTYR0d8Bp+Shuz+MoAysJgJ8O6664rbULUTEZrmA5a/MGznyMinTnTMwwPaUCcJGqzZcyE5ibISo1FuYLR22CtWjTqUJ1ImtYWiyV9VqVjwAI4YDCiQFp/hgxeMQ57AGiL3zo+7bw==
X-YMail-OSG: QdFLtB8VM1kQR67xgKoKRHaRETUc9a9DyKEzL9xN1VYCEdWIY4oOCobQ9em.ZGi
 KF_8dQcMkxc4zEbliuf9qVQXIB9fjjcB85WJLSS1nZuuIYqzEJhopltXX7MbDeUx6po4P4urGt.m
 Ws.D3_vD7519vWsep3PfQZWwmRRFAoCs2RZ1d99s5F6AtXHi_xoV1BwHu.P1aJPy2XkjCO3sqCgl
 x_i4MKoST.JtuFirMXTtl1cRs5mrBIt5AgRv1ZTvhQZpDHqTIMqKXN86E5HCtRr1NG5dDwAvZ_6w
 iaTOij6gV_wmqLhdilgSz0XXLh6tgGVACA6BXWiSYJEvGfMjFMKfZBUUmZtjyNV92Hr1dyeht_7o
 c8EgkGfHa6GM7WuZHZvR1gsu3TCSRzkBF6UcsChN5SK9CXLbkB4yNFZobNQRUaHpoWw7BzXF3BUj
 bG9oZwOV_SLP9HJM9eXBjz7tabzZpOSK.WbRwQ64d78Zp2KPWpTkNieWE511ckrXQopJ3pIqxDLi
 fIl5LoVuKXf3hoUj_De6TsAjABewjk3Vberty3ILbwOhdlzhtuQOWPTcvV9W7rL918V_JAc1Z3SF
 0jItNTpryaP9GuQUBptRkTWN3QFgrMbhZ5CGFHW3dn9ZctB7ryckRvWoS0INmUScG8ceeiao18zI
 oeaZFDvjoy_g8gTDBTcglJ20vtwNofXOT.XIf7ukw0I5NEOGko2UAFl.klUIuBfdLp601pOl40Qz
 T3eHcjtTBjX4qxfcM6nBtOwH6PyPnJu6jeiwJVe6TILdhdUe9_rq8Hcgs2gDBuAgzvuLqd1zX0cj
 8s8oxRX9mcBIDWcnuhoHE81UbjLLhwknPds20UbhDTP3Wn9ypgW8nAJvr1NSMe2xngOztIKIZuBr
 DpfSah0dMWQWnuss_8LjU_btZnAKQHqS_8ouQadhCWhROz_MaAjTIHkbDr5Fb3rQ.7DdmjLWGM2d
 OfkJkuF6KPc5ETu3EyfIFb0IlB9.srHau_PtO2D3yjEanOVB_9D82eoC1iISQAGeDrSJ.kwjaFcD
 l0Ym41efJGtEORzHYbSXjN93AI5PEyWtsM3zm0rpDInUNOVqclJQxfBM5NvmOXJoQAoUBGOli6U6
 OSJj_8.iRdxnDe422T_Ap88fIt1wUJM1n_AxOMJjReGhPZE6Km_cySOAGedX0nG0IEjACSReSEp6
 2o7F4BluA67e0r_wldx2T_41rNsJXrGJhCyj_OSFWi5sceSV1q0VlP9fz8jHzvn1C7CmIyWtp3kk
 hn9Vm8hsmPEqqz3VUEXVfiV6MvDH9TwhaTpNmc9wRKfayKcn_HkYDWStPrMeMKlhrTEP45GMFNtC
 CwbZh7LJjWXAPnubfL63B.xao.Y9oGxif2r13CvMG1QSryx.iI1LOGmzzXiMtRnDw6Lyz2doOpNE
 DLlbEwAu3NV3QiTIIBcjaopN1OwO8KL.DgItuQVY6yXcYdXT1qroJ91OXPDQFToKn9mJ4omcGb4w
 UxwHc5dkmignCfuOqt9wazWPwL4tT4Qu6Ul7t7JQlpHYgFK6M7DnPvDMceAhURNEKahAqq5Z3Udp
 sKNpq8wYBthhLQ8ypfyvHn1l_Cng1GLwWYVE6gJf6IOB.IjXAYJEvOyJrT8vEzxxXi_.1my1zW_g
 kql8RvUNnXu6wKhI5ZXMbJq4G2xy8LyU.Dj5TCVvvItOyuvIMijhZV2AH1vUt11eyzmd.xJVG2.y
 Z2MuU2kPQN7pKy2gu_HwU1rXtAFr6khWeDNV0XfBc2ma3pImJzcEsEq8x2Drxs.K51wTS0.H9n_n
 A4BZKtFduW9.pWJurhChIwbSi8TQXQwGv3kym7v7z3ThzH7hNx5gkIOte4CV8.Fa0iQZFCuCNXmZ
 g6mDSAfqgjDhjRHKPbLItShxcXmeOkPVpAXiKT5lQzT7wyOmBoP_DimhPgLddP1Y5S1ecqz6lbWv
 X.7_qITPD3hVvFgcVCPAEnGyQz_Xb.2BLut0nOGy66Ygg1YaBK9RW_2.9MB9DJGPlr3.sS.xG_rh
 GrBLOPopbMi8pmEXeaXeWDt.TgCcQfr78XGvne0_.icHkDddndSjr8Xlcmap_seBDkl68C.MefqM
 QZDlKXlkCrjK5zN2I9BccUaMgvOOZza9aw8ylg4ucQ9aif5phG88iys.fG3NPw1IyBcuQNSNoAJX
 IDh0himGm91xVaIQ7qMZ56dqytdTI28hfaRGNz7qcKv97Na4rv5RQDPvUiRpxguREoLIDmEh.Jnu
 MHKFaewyYsBJ5k7CPgYgFgdbn63ZZrPH_Hx1uFWY6VWTs9gF7E3Jlyd.DkmSXOCpyrLi.1g9c89x
 u6t68_8wnX2s0Aa6u
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 30a0067b-e111-43e1-8a48-99a3e3fca653
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 1 Sep 2025 17:41:53 +0000
Received: by hermes--production-gq1-7bfc77444d-qpx7l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ac7bd9a5dd28be86d0a7d9b2d3af8b1;
          Mon, 01 Sep 2025 17:31:44 +0000 (UTC)
Message-ID: <3826d6c2-164b-415f-8bf4-63060ce428df@schaufler-ca.com>
Date: Mon, 1 Sep 2025 10:31:43 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: "Dr. Greg" <greg@enjellic.com>,
 John Johansen <john.johansen@canonical.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
 <aKcskclwVVe1X4kP@mail.hallyn.com>
 <6c69fc81-32a7-442c-8c7f-992eda9c2d18@canonical.com>
 <20250901160102.GA9179@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250901160102.GA9179@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24362 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/1/2025 9:01 AM, Dr. Greg wrote:
> On Thu, Aug 21, 2025 at 07:57:11AM -0700, John Johansen wrote:
>
> Good morning, I hope the week is starting well for everyone.
>
> Now that everyone is getting past the summer holiday season, it would
> seem useful to specifically clarify some of the LSM namespace
> implementation details.
>
>> On 8/21/25 07:26, Serge E. Hallyn wrote:
>>> On Thu, Aug 21, 2025 at 12:46:10AM -0700, John Johansen wrote:
>>>> On 8/19/25 10:47, Stephen Smalley wrote:
>>>>> On Tue, Aug 19, 2025 at 10:56???AM Paul Moore <paul@paul-moore.com> 
>>>>> wrote:
>>>>>> Hello all,
>>>>>>
>>>>>> As most of you are likely aware, Stephen Smalley has been working on
>>>>>> adding namespace support to SELinux, and the work has now progressed
>>>>>> to the point where a serious discussion on the API is warranted.  For
>>>>>> those of you are unfamiliar with the details or Stephen's patchset, or
>>>>>> simply need a refresher, he has some excellent documentation in his
>>>>>> work-in-progress repo:
>>>>>>
>>>>>> * https://github.com/stephensmalley/selinuxns
>>>>>>
>>>>>> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
>>>>>> about SELinux namespacing, you can watch the presentation here:
>>>>>>
>>>>>> * https://www.youtube.com/watch?v=AwzGCOwxLoM
>>>>>>
>>>>>> In the past you've heard me state, rather firmly at times, that I
>>>>>> believe namespacing at the LSM framework layer to be a mistake,
>>>>>> although if there is something that can be done to help facilitate the
>>>>>> namespacing of individual LSMs at the framework layer, I would be
>>>>>> supportive of that.  I think that a single LSM namespace API, similar
>>>>>> to our recently added LSM syscalls, may be such a thing, so I'd like
>>>>>> us to have a discussion to see if we all agree on that, and if so,
>>>>>> what such an API might look like.
>>>>>>
>>>>>> At LSS-NA this year, John Johansen and I had a brief discussion where
>>>>>> he suggested a single LSM wide clone*(2) flag that individual LSM's
>>>>>> could opt into via callbacks.  John is directly CC'd on this mail, so
>>>>>> I'll let him expand on this idea.
>>>>>>
>>>>>> While I agree with John that a fs based API is problematic (see all of
>>>>>> our discussions around the LSM syscalls), I'm concerned that a single
>>>>>> clone*(2) flag will significantly limit our flexibility around how
>>>>>> individual LSMs are namespaced, something I don't want to see happen.
>>>>>> This makes me wonder about the potential for expanding
>>>>>> lsm_set_self_attr(2) to support a new LSM attribute that would support
>>>>>> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
>>>>>> provide a single LSM framework API for an unshare operation while also
>>>>>> providing a mechanism to pass LSM specific via the lsm_ctx struct if
>>>>>> needed.  Just as we do with the other LSM_ATTR_* flags today,
>>>>>> individual LSMs can opt-in to the API fairly easily by providing a
>>>>>> setselfattr() LSM callback.
>>>>>>
>>>>>> Thoughts?
>>>>> I think we want to be able to unshare a specific security module
>>>>> namespace without unsharing the others, i.e. just SELinux or just
>>>>> AppArmor.
>>>> yes which is part of the problem with the single flag. That choice
>>>> would be entirely at the policy level, without any input from userspace.
>>> AIUI Paul's suggestion is the user can pre-set the details of which
>>> lsms to unshare and how with the lsm_set_self_attr(), and then a
>>> single CLONE_LSM effects that.
>> yes, I was specifically addressing the conversation I had with Paul at
>> LSS that Paul brought up. That is
>>
>>   At LSS-NA this year, John Johansen and I had a brief discussion where
>>   he suggested a single LSM wide clone*(2) flag that individual LSM's
>>   could opt into via callbacks.
>>
>> the idea there isn't all that different than what Paul proposed. You
>> could have a single flag, if you can provide ancillary information. But
>> a single flag on its own isn't sufficient.
> If one thing has come out of this thread, it would seem to be the fact
> that there is going to be little commonality in the requirements that
> various LSM's will have for the creation of a namespace.
>
> Given that, the most infrastructure that the LSM should provide would
> be a common API for a resource orchestrator to request namespace
> separation and to provide a framework for configuring the namespace
> prior to when execution begins in the context of the namespace.
>
> The first issue to resolve would seem to be what namespace separation
> implies.
>
> John, if I interpret your comments in this discussion correctly, your
> contention is that when namespace separation is requested, all of the
> LSM's that implement namespaces will create a subordinate namespace,
> is that a correct assumption?
>
> It would seem, consistent with the 'stacking' concept, that any LSM
> with namespace capability that chooses not to separate, will result in
> denial of the separation request.  That in turn will imply the need to
> unwind or delete any namespace context that other LSM's may have
> allocated before the refusal occurred.

Were it true that 'stacking' rated the status of a 'concept'.

An LSM that is capable of namespacing (the definition of which is
elusive at this time) should be allowed to decline participation
in a namespace creation. That, or there needs to be a convention
for "null" namespaces, by which an LSM can pretend that it isn't
involved in the new namespace. I think the latter smells funny
and would invite "security people don't understand performance"
remarks. No LSM should be allowed to prevent another from using
namespaces.


>
> This model also implies that the orchestrator requesting the
> separation will need to pass a set of parameters describing the
> characteristics of each namespace, described by the LSM identifier
> that they pertain to.  Since there may be a need to configure multiple
> namespaces there would be a requirement to pass an array or list of
> these parameter sets.

Just like lsm_set_self_attr(2).

> There will also be a need to inject, possibly substantial amounts of
> policy or model information into the namespace, before execution in
> the context of the namespace begins.

Yup. A major downside of loadable policy.

> There will also be a need to decide whether namespace separation
> should occur at the request of the orchestrator or at the next fork,
> the latter model being what the other resource namespaces use.  We
> believe the argument for direct separation can be made by looking at
> the gymnastics that orchestrators need to jump through with the
> 'change-on-fork' model.
>
> Case in point, it would seem realistic that a process with sufficient
> privilege, may desire to place itself in a new LSM namespace context
> in a manner that does not require re-execution of itself.
>
> With respect to separation, the remaining issue is if a new security
> capability bit needs to be implemented to gate namespace separation.
> John, based on your comments, I believe you would support this need?

I don't like the notion of a new capability for this. But then,
I object to almost every new capability proposed. Existing namespaces
don't need their own capabilities. I don't see this case as special.

>
>> You can do a subset with a single flag and only policy directing things,
>> but that would cut container managers out of the decision. Without a
>> universal container identifier that really limits what you can do. In
>> another email I likend it to the MCS label approach to the container
>> where you have a single security policy for the container and each
>> container gets to be a unique instance of that policy. Its not a perfect
>> analogy as with namespace policy can be loaded into the namespace making
>> it unique. I don't think the approach is right because not all namespaces
>> implement a loadable policy, and even when they do I think we can do a
>> better job if the container manager is allowed to provide additional
>> context with the namespacing request.
> In order to be relevant, the configuration of LSM namespaces need to
> be under control of a resource orchestrator or container manager.

I do not approve of kernel features that are pointless without specific
user space support. If it can't be used in ways other than those
defined by a particular user space component they really don't belong
in the kernel. 

>
> What we hear from people doing Kubernetes, at scale, is a desire to be
> able to request that a container be run somewhere in the hardware
> resource pool and for that container to implement a security model
> specific to the needs of the workload running in that container.  In a
> manner that is orthogonal from other security policies that may be in
> effect for other workloads, on the host or in other containers.

That sounds to me like they want per-container security policy. That
would require that the kernel have the 'concept' of a container. That's
not something I expect to see in my lifetime.

>
> Hopefully the above will be of assistance in furthering discussion.
>
> Have a good week.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>
