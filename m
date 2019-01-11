Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CFAC43444
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 18:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46312183F
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 18:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="II3jOimp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbfAKSad (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:30:33 -0500
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:40859 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729479AbfAKSad (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jan 2019 13:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547231431; bh=EJ2TwDSUCIMrZZIWX5hvR9et60XMY6CYTmJ5wp6giW8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=II3jOimpZxSxsoCEgJEbA4XJhNXEcUn0Pn66hxNBKiWzIm8WuS2ploDclQYJB+YGOvfwLu8T5EqPf2858rRvvpuLz67m//xe5C0JeDMVYzpJpn2jj4Gs8qbnR4hP67kMv4DtPRrijj1P/Pa8Jt0D6k4pNz2VIdEpqkfDkbBlAUalxrHbbnHNqnI9nf5pEFjoHIWECBFzttisJQ/cdP6Ld3w9JYcwwiXmHG7oYEBzIQ2SotYJ2fNISGIiA3kLgUVWMdc/f1MLO77wS9GQYzVv7/PHWCCG/KQ3wgALjbSBOOSEtiS7jgk1Ov/tP6Alw+G64JeM/dv22kr9H9XkWTCkDw==
X-YMail-OSG: jH1on3QVM1kS78aejpECi16RzUagGqIdx6QZBIZVCFfS4cP_VNSB32qNqIbmoLM
 Mx6bHOgOqPAtKaYpSNR_1.JDsspq35vpG7haVaXHJsxz9bZE8r7dB0khRE3NiENW6vWsbny4PmJB
 f76QUFaWJDnRMQ7NKC2I4NyR8Z6gmSWRqiKZgBaKABeWVynerOBan4RpvZY3ucOOpReEoh9U7Vxz
 HvIwisbM3ACuiptXQVUR8XhKYyaW_In84dnn.GiUFVxaW80F1hRLr3pzut.6E6Awt9TQqz7j._CD
 _mgeXlKRoXPjBRmg1WEtElWApaTz_Rzk6lLcDDpzEZ1IxbGyOInHEPRQDjjcMgWTIecOVo.7swFM
 UK7ShXO3QObZAcdpN0vqZ1aDdm6XB_R6vzS2OHpV_qrhrW8YEpHkPBJTwu1uIe5Z3AFFlY4d2r7m
 5z2jV84NOUg.vj1vAsIg7ZM83rce09RG_nJdMNFeTsBOjvsj93tMt1W19jqpG4JN_L5Y861CaI3K
 2GN98Odkbjlm33zqtzuluk97fboSqVh9Lv.jJ.9BiZO0DNGyAlSelK4CV.hiJyr46W8hq6fb8Pla
 Dr2JJq5A49Frb2AnF89HxWWH6uBaORjoJUNvBJFB4ozv0YH.yX4jI4yyog7p3EmXtMCYo2wb5sfA
 zaM83SRUXdUFLkwBasicNtuPgr33PYcXZtvuV9x0ySnNfO.y0dH5fNTCk5mSSCFvkkoRr.2UpTkV
 kLooUjQluM2ITovS5I7F1rMmVmrH42qFN6X3QNrnQNUMb9PUdfIFJXGFRzfeXnkmbfOVhhwKOIwJ
 FI5N1fdKWJR0y2KHnxnTXn0HcrDKxK4srzboTRmO5KhdSg4dYqNK_shq_yz46xzFiUU1FNhuixlq
 SbBpXuZgJSl2ELk9fbMiKYopHkgD1GkeRTo59MonQD9QOHajcffUkYlS.teY4Zlr9bIi84rP_shi
 j6sjfSFlQI9Ir4Bq14HHklWAD_yIGXmeIxiFabwCJOnWg8Gah6euGNA1.Icj0XxUi5hok6tq5cAx
 Hn.SrOibgVOA.KpvrFrO2iAS5AYI9mkxQH854x8Sbk.gAJ.6hWsvNkT_C4sZAlNbTcFBbJK6PWYR
 T8DI_YwKpDQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Jan 2019 18:30:31 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 976f8d8cbb9bae56d3d953fd564906ee;
          Fri, 11 Jan 2019 18:30:28 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] LSM: Add new hook for generic node initialization
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <20190109162830.8309-2-omosnace@redhat.com>
 <cbe734fb-cd91-57a8-0de5-f4f0f8a1a2cd@schaufler-ca.com>
 <CAHC9VhS6pGycbT1GET5CHjxgYCDu1KCrcPtcF0n==1oH15kAVA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3c356ac1-8dd1-7d89-38ed-820e22dcecc7@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 10:30:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS6pGycbT1GET5CHjxgYCDu1KCrcPtcF0n==1oH15kAVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/2019 5:57 PM, Paul Moore wrote:
> On Wed, Jan 9, 2019 at 12:08 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>> This patch introduces a new security hook that is intended for
>>> initializing the security data for newly created pseudo filesystem
>>> objects (such as kernfs nodes) that provide a way of storing a
>>> non-default security context, but need to operate independently from
>>> mounts.
>>>
>>> The main motivation is to allow kernfs nodes to inherit the context of
>>> the parent under SELinux, similar to the behavior of
>>> security_inode_init_security(). Other LSMs may implement their own logic
>>> for handling the creation of new nodes.
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++++
>>>  include/linux/security.h  | 14 ++++++++++++++
>>>  security/security.c       | 10 ++++++++++
>>>  3 files changed, 54 insertions(+)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index aaeb7fa24dc4..3a2399d7721f 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -429,6 +429,31 @@
>>>   *   to abort the copy up. Note that the caller is responsible for reading
>>>   *   and writing the xattrs as this hook is merely a filter.
>>>   *
>>> + * Security hooks for special file-like objects
>>> + *
>>> + * @object_init_security:
>> I don't like the name. There are too many things that are "objects"
>> for this to be meaningful. I also dislike seeing names like
>> security_object_init_security. How about init_from_parent? If there's
>> never a chance that it will be used anywhere but with kernfs, it could
>> be kernfs_node_init. The existing set of hook names are sufficiently
>> confusing without adding to the mystery.
> I like the naming similarity with inode_init_security(), that seems
> helpful.  Although I somewhat understand you concern about the generic
> "object".  Could you live with kernfs_init_security()?  If another fs
> adopts it, we could always changing the name later if needed.

I can live with it as is, but kernfs_init_security would
be better. The security_blah_security names seem crazy to
me, but changing object to kernfs is really what's important.

