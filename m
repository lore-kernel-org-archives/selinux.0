Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45AFC0015E
	for <selinux@archiver.kernel.org>; Fri, 28 Jul 2023 15:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjG1PPJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjG1PPJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jul 2023 11:15:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACB2D4D
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 08:15:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522462d8416so2872805a12.1
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690557305; x=1691162105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUsoDe1aciZkS3SYBk+FJnom/bcWm6HUHz7xtg9wGVE=;
        b=xlBQr91VrE+fcTMQtJeL8UehPRNRDcOoL3Jb7oeY/mrCveqo1mf708pc0eDYwfspAJ
         A+kaOd3By9dV4yBq+KBkmUafQK3E1WIz9fm1vsVKJtrzZ69uoTGDsVyPg7Xo8lpzBMV7
         F6TD0DCllb2LydrhPW33jZF0TgI2xFAg27NxhuBNndHVKqMobgm/+RCpx6Ngqg8YxKB7
         b83oDwxzwWX8OZXxHIXZG598ch1mn5d3uloQxGo1tY0/gZEnwuPNS6xRJH8gYeGIarEo
         Gc73xHWp4OAegZDVNbxQI5pzehlWrR/ANJAK/2Ze7/lopQhmjJV/Vq/9Qqv6X8RhKmbK
         ZQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690557305; x=1691162105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUsoDe1aciZkS3SYBk+FJnom/bcWm6HUHz7xtg9wGVE=;
        b=ft+K1iaGSCbnmGalv3RXeDljsBzi12X/EDUVUueNj1txnTj8YPwvsCKRX+oEcbfVv7
         oVpuf/SwPeQ3u2xUBvT1O26+TblzuIdM96O0DExhpxvAJEgRm83Udyjk85ngY3xwCZY1
         7EM43TkOj5sIN38BybxPtsX3d7Centu5yWxwIFQD/M/BNdSSlBnqs/xXPG9nkgG15Ren
         l1E4zx89CTn15EfpvbsS+1zt6dFq8ttpcqiRec7rqjtG80c4XDMQRvmd3sTq/yQUVdR7
         gsmCxf2D2P4bGPHrBaVyT8NKlhL4cqbgOXU34x4itB4L0pNYJ+2oO8i6VMN8luzICGHj
         P3gw==
X-Gm-Message-State: ABy/qLZybRJnkJjDgilo8+dB7EUwuq5xcxmAmDRUPpQLyL6I2gQ4tkpy
        khTNEFdUrXqB+QLEdRu5G3266w==
X-Google-Smtp-Source: APBJJlGrx217B3+2JoDDsOR5Pe+xG2RV8Yfclk4WQBqChj/RTKdH94R2bDDyfq5dnAZDNu9v1WPHIA==
X-Received: by 2002:aa7:c68f:0:b0:51e:24e1:c0e9 with SMTP id n15-20020aa7c68f000000b0051e24e1c0e9mr2023024edq.10.1690557304905;
        Fri, 28 Jul 2023 08:15:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id ba4-20020a0564021ac400b00522572f323dsm1880856edb.16.2023.07.28.08.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:15:04 -0700 (PDT)
Message-ID: <1023fdeb-a45a-2e9e-cd2e-7e44e655e8fc@tessares.net>
Date:   Fri, 28 Jul 2023 17:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v5] bpf: Force to MPTCP
Content-Language: en-GB
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <3076188eb88cca9151a2d12b50ba1e870b11ce09.1689693294.git.geliang.tang@suse.com>
 <CAHC9VhS_LKdkEmm5_J5y34RpaRcTbg8==fpz8pMThDCjF6nYtQ@mail.gmail.com>
 <b41babb1-f0f2-dc2f-c2e3-1870107fbd9f@tessares.net>
 <ZMKxC+CFj4GbCklg@google.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ZMKxC+CFj4GbCklg@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Stanislav,

On 27/07/2023 20:01, Stanislav Fomichev wrote:
> On 07/27, Matthieu Baerts wrote:
>> Hi Paul, Stanislav,
>>
>> On 18/07/2023 18:14, Paul Moore wrote:
>>> On Tue, Jul 18, 2023 at 11:21 AM Geliang Tang <geliang.tang@suse.com> wrote:
>>>>
>>>> As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
>>>>
>>>> "Your app can create sockets with IPPROTO_MPTCP as the proto:
>>>> ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
>>>> forced to create and use MPTCP sockets instead of TCP ones via the
>>>> mptcpize command bundled with the mptcpd daemon."
>>>>
>>>> But the mptcpize (LD_PRELOAD technique) command has some limitations
>>>> [2]:
>>>>
>>>>  - it doesn't work if the application is not using libc (e.g. GoLang
>>>> apps)
>>>>  - in some envs, it might not be easy to set env vars / change the way
>>>> apps are launched, e.g. on Android
>>>>  - mptcpize needs to be launched with all apps that want MPTCP: we could
>>>> have more control from BPF to enable MPTCP only for some apps or all the
>>>> ones of a netns or a cgroup, etc.
>>>>  - it is not in BPF, we cannot talk about it at netdev conf.
>>>>
>>>> So this patchset attempts to use BPF to implement functions similer to
>>>> mptcpize.
>>>>
>>>> The main idea is add a hook in sys_socket() to change the protocol id
>>>> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
>>>>
>>>> [1]
>>>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>>>> [2]
>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/79
>>>>
>>>> v5:
>>>>  - add bpf_mptcpify helper.
>>>>
>>>> v4:
>>>>  - use lsm_cgroup/socket_create
>>>>
>>>> v3:
>>>>  - patch 8: char cmd[128]; -> char cmd[256];
>>>>
>>>> v2:
>>>>  - Fix build selftests errors reported by CI
>>>>
>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>> ---
>>>>  include/linux/bpf.h                           |   1 +
>>>>  include/linux/lsm_hook_defs.h                 |   2 +-
>>>>  include/linux/security.h                      |   6 +-
>>>>  include/uapi/linux/bpf.h                      |   7 +
>>>>  kernel/bpf/bpf_lsm.c                          |   2 +
>>>>  net/mptcp/bpf.c                               |  20 +++
>>>>  net/socket.c                                  |   4 +-
>>>>  security/apparmor/lsm.c                       |   8 +-
>>>>  security/security.c                           |   2 +-
>>>>  security/selinux/hooks.c                      |   6 +-
>>>>  tools/include/uapi/linux/bpf.h                |   7 +
>>>>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 128 ++++++++++++++++--
>>>>  tools/testing/selftests/bpf/progs/mptcpify.c  |  17 +++
>>>>  13 files changed, 187 insertions(+), 23 deletions(-)
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c
>>>
>>> ...
>>>
>>>> diff --git a/security/security.c b/security/security.c
>>>> index b720424ca37d..bbebcddce420 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -4078,7 +4078,7 @@ EXPORT_SYMBOL(security_unix_may_send);
>>>>   *
>>>>   * Return: Returns 0 if permission is granted.
>>>>   */
>>>> -int security_socket_create(int family, int type, int protocol, int kern)
>>>> +int security_socket_create(int *family, int *type, int *protocol, int kern)
>>>>  {
>>>>         return call_int_hook(socket_create, 0, family, type, protocol, kern);
>>>>  }
>>>
>>> Using the LSM to change the protocol family is not something we want
>>> to allow.  I'm sorry, but you will need to take a different approach.
>>
>> @Paul: Thank you for your feedback. It makes sense and I understand.
>>
>> @Stanislav: Despite the fact the implementation was smaller and reusing
>> more code, it looks like we cannot go in the direction you suggested. Do
>> you think what Geliang suggested before in his v3 [1] can be accepted?
>>
>> (Note that the v3 is the same as the v1, only some fixes in the selftests.)
> 
> We have too many hooks in networking, so something that doesn't add
> a new one is preferable :-(

Thank you for your reply and the explanation, I understand.

> Moreover, we already have a 'socket init' hook, but it runs a bit late.

Indeed. And we cannot move it before the creation of the socket.

> Is existing cgroup/sock completely unworkable? Is it possible to
> expose some new bpf_upgrade_socket_to(IPPROTO_MPTCP) kfunc which would
> call some new net_proto_family->upgrade_to(IPPROTO_MPTCP) to do the surgery?
> Or is it too hacky?

I cannot judge if it is too hacky or not but if you think it would be
OK, please tell us :)

> Another option Alexei suggested is to add some fentry-like thing:
> 
> noinline int update_socket_protocol(int protocol)
> {
> 	return protocol;
> }
> /* TODO: ^^^ add the above to mod_ret set */
> 
> int __sys_socket(int family, int type, int protocol)
> {
> 	...
> 
> 	protocol = update_socket_protocol(protocol);
> 
> 	...
> }
> 
> But it's also too problem specific it seems? And it's not cgroup-aware.

It looks like it is what Geliang did in his v6. If it is the only
acceptable solution, I guess we can do without cgroup support. We can
continue the discussions in his v6 if that's easier.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
