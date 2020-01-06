Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B8C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D562072A
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jqsA0Z4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgAFSDc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:03:32 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:37702
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbgAFSDc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 13:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578333810; bh=+z89FMZyqWma5PQcJPLJYqD85IkVmJ77ntVTF4dcCbE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jqsA0Z4tHAY3WUxCE58Ziw9hfKCbBQaGatE4XEYzMqCwpC+eo6b6YFKjdDbVkj4lt3YxRa6DDitd6xRp7TbcgWMUijGGEFhEUsmTjht6vLhC9B378Ng/hGFqbUXT+nZz8ubKXOg2RQTF3UsiuHnDJzqRoRsRWgO1UMN9wIw3byEugOiTzV42prbeb/3ZnbiQ3JwweFmKMuDi6D4yo/eLqN7+npIaTXOPorxw8NE6AKEWEwEzBNcd9PcIlbYNmISwbWq+GrJiBKEyEQG8snoSZoFQznKGZRjZ2pdsz9j910fb8hhriWHrqF4ty6ClcpAztvtnIK7b2XC31H7Sib5lYQ==
X-YMail-OSG: OrZiz.IVM1kh2ZscA3OdQlBOSfvtCLZgt9vOrJMgFA8F5M_jj2Eh6a0g3S_0sRp
 .EMmvs9VOrJbNXK0ajnvvRdF6fJh73J0nz3UQiAI.I.quwGV0nGmsEhS7Z9dCEAokNoGNEQ_dVNL
 efrtK5yXQIvG5knx5qcLiaGcfAla11jBV0bRE4hO7yrwC39Kgq0tYYjxH2khAQ0vR8e1XUmpeyVr
 Rdy2vvDcIjvzo_ABLr_Qw.dvM1ckJpE..kbBP_im3TvQhsCPt38rg6YZ8KHCSPCQvQTGxWFnfk1G
 noigy9Pd41Z_p_kYrSe0E6dtJa1y9pMGQWOWu4Iid7P77f5ZMQVqKBm3MeEEYIaENxK8PBIRhqbp
 BwFghC.LPGj9ccpG7Mr3SkHlpKkvsw0XlV4yQoYD6jQceCu.XaKp2pXIZ0t2FtQKNa0lOi9E0dFY
 uJ1Db0aoeFOM.4N..xWx58.Bi5tvfS_4S2UFnk1hmEGu14AnzVG7lHrtQNVdT_VUT0.jELoq6IbU
 P47h24UmXccjv.x8XjsMYpfAP6.e7Y6PosTFqSlb3nYkSBULjc8l82vLM3l2k6KIbuMMCmgVhbNQ
 VP8WQILSnM5HWjPaVxhey0GVNeyNE30l35KyBgrpipRrK2rqHaAGKxWZISUS4SexyAk.Z.JTQgOb
 Sf4nJdcIOvlqd3z2n9UEagh1rYlaqsIN6tl2dhcB65Ujje4PWG7d9e46kflfwXo48K6JAgaEGlXh
 mP2sAWcBm_94jlxGlzvIpjmm24z.VxvNLMJ92U1MHfVr8vZiV5FEKGTOak6DebZiJQgarRCJAQ.m
 _zQVEfTvOtr1tp325YJ4h0fh2b5oh4UACvhXx9UVwNE6GxK34RaKbsWfVftwJTA85dXOV4Q5ri12
 fYD0TANY.bbNa4b8tFZAxPaGARQV976mYrgRCEfH_gpQkfgK188s5oCLzO0KiN5Acswbs64E42CP
 ER5VSsoVGFL8vf.eCb308aKUQRVbs0Io53DHU58q3bFgBqqmkDncwE_reT.YQwVMLqJ3l6xFAu8o
 8nW1OZne5qyaV2B6_qUfd5M3UaAlPvc6UFQIqY_NWd3ZXVTM6oIFBRxhgGj56DIsYxbeOBFRN8wh
 tsVBsnyHgOX4IgUQAvg5zRKog7DTRW7UXRhTAFBGRtub6j3Fy_aIC3qAw8WFI3pTU6g8aGos9nM4
 ISnIHgqpWYuGOmGPKq7FejuowqFg8qoHEblhgPSktYUruj5iKHdZi36vDSweQXYTXZt_istXpsA4
 qW3lfOsNuX2G4tA.A1C10kEjVxLzw3W2PpTbkOLMq5RhC6RMrRYrcChhQzYjGZmReLi2uRTSqNaY
 eRUaMFbVWH4xjFKbGVHipteOVvy3BebRLyK8Awbjwv5jwiK5ZoD33Uz2z5j0reBo5wV4qFjw.zZ5
 eD8RkaMKGixwF.vnX4SQgNupdJc.qMQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Jan 2020 18:03:30 +0000
Received: by smtp407.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 87558fccfb3616fdcfe0361e6bf987a1;
          Mon, 06 Jan 2020 18:03:24 +0000 (UTC)
Subject: Re: [PATCH v13 23/25] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Simon McVittie <smcv@collabora.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-24-casey@schaufler-ca.com>
 <cce57d59-8c68-8ef0-b887-0597492e1833@tycho.nsa.gov>
 <20200106172949.GA80652@horizon>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1a392962-8a2d-a3f3-5cc1-a51e82ada41b@schaufler-ca.com>
Date:   Mon, 6 Jan 2020 10:03:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200106172949.GA80652@horizon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/6/2020 9:29 AM, Simon McVittie wrote:
> On Mon, 06 Jan 2020 at 12:15:57 -0500, Stephen Smalley wrote:
>> On 12/24/19 6:59 PM, Casey Schaufler wrote:
>>> The getsockopt SO_PEERSEC provides the LSM based security
>>> information for a single module, but for reasons of backward
>>> compatibility cannot include the information for multiple
>>> modules. A new option SO_PEERCONTEXT is added to report the
>>> security "context" of multiple modules using a "compound" format
>>>
>>>          lsm1\0value\0lsm2\0value\0
>>>
>>> This is expected to be used by system services, including dbus-daemon=
=2E
>>> The exact format of a compound context has been the subject of
>>> considerable debate. This format was suggested by Simon McVittie,
>>> a dbus maintainer with a significant stake in the format being
>>> usable.
>> Since upstream AA does not currently ever set the peer label info, the=
re is
>> no need for this support for stacking upstream AA today, and there is =
no way
>> to test this functionality with more than one module present currently=
 in an
>> upstream kernel.  Either fix AA to actually implement the functionalit=
y so
>> it can be tested properly, or drop it from this series please.

I agree that SO_PEERCONTEXT can be deferred until such time as we have
AppArmor upstream support for SO_PEERSEC.

>>   I don't
>> understand why AA continues to keep this kind of basic and longstandin=
g
>> downstream functionality out of tree.

Not everyone has the resource commitments of the world's largest
government. :(

> Alternatively, a pair of tiny in-tree or out-of-tree stackable LSMs
> that don't make any security decisions, and label every labellable
> process/socket/thing with something predictable, would make it really
> easy for both kernel and user-space developers to test this and the
> user-space code that uses it (D-Bus and others).

Sounds like a fun and educational project. Maybe one of our lurkers
could do something clever.

>
> For example, they could label process 1234 and all sockets created by
> process 1234 with "contexttest1\0pid1234\0contexttest2\0process1234" or=

> something like that.
>
> I'd love to see AppArmor in upstream kernels support SO_PEERSEC and
> SO_PEERCONTEXT, but setting up a development machine to stack AppArmor
> and SELinux (and still be able to boot, without one or the other LSM
> forbidding something important) seems likely to be harder than setting
> it up to load some toy LSMs.

>
>     smcv

