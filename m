Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E5AC4332F
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 15:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiLHPfd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 10:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiLHPfK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 10:35:10 -0500
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED01A13D2
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670513586; bh=bAXj1zQgUqxwL+NfnAA1mkuO8NrpRS0bZrRSsA8Ai7Y=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=U14M7xTTSXpURi3inbYBNTdhtj223knANIrG/B2KBhnUkwomX8mydA/+fx12kpNIevxfRsr0Ik1/LOdg5Ukjn6+eB0uY65GoehNun4CRY+YKv/0hER0Njlz62Lh3nJgm4sZaEiKoS46qyp+7BmwKprodsb17NLKUF1SRhuxvzTsR22hWiemnLuE4WS9kH9/YRi+uJ3I1hrlphjiXy+FHrWpM3VgjfmhgH0R8hH/x6v1nJdEy6JWqYbYrbv0yBPg1e8vmfseruvTscvkMJTeXxp2QA6oJZDLpcAqFYJfn8k9gVAqEmrl8Oc0SSGSdBO+ePYykL5tCc73dQhQNOn7hug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1670513586; bh=+j3fx/y3x/+OH2L2dtdrscsnx1t3lpp1vtanp8nTyjh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DWzDvXcugVCgIEMyqPpJ5zJWN97QSQlAwF4FAfyY/kfwO+VLxR5JEg1eIHofwzoqotHdz9d0XvHbte0hGEMQdM+9LFaR+GiAPH+11qhNmSOYf4gBwMnkD2atES4f93SzeUa9jMgH2dQ2i37wTSc5wX3AwDqx/JbAjKlvdU4B6JYGjtGROsa6Y7FfXEoQQmKHQP1sC6xmC2BjAgrlIqQX3BzxvOPMwD/qD99E3orRNIXjsLgRzFRb0byp6ptmurvbx8o4fnMouE/Gv1dXpJLgYOupe4D8zWqJZxkoeturQ5d+I5MYAYV0yp9Fxy39VVljRgCq8Pb1SorHD6Jf5Ae7NQ==
X-YMail-OSG: C28rwg8VM1n6hHhnKM4z1AJ_F0w_AVTXer8C.OcgniARUCy0D8hRGlcagCSHTr0
 X6pyHz7vBNIMtvBOupJ6mQPRdbHv4e1rQfvRTvBS5vEZCkyTDUmMb.3XfgPK9aPAARM..kvKN9j2
 eZKrN7v46ocVwBKbz6N0KtocsTIBbfh7v0r6HATsDhWlpO9lRHpOLdXA5hj7gpABEuR8xvqMbP7u
 lbjFJEKypu_PS6XuUxYcymXA4NRBn7_UHvmdE1MTkiDj3tP.Npl2g0eGsX1otX7LEEdDNj.gNbcj
 9PNmNzgMT9MYGeyl3DhGc5rW1_ZTR0OfU.ZaUDcE6C5HX0LgAsuIIcY8QsglUd8NGo70Ku5C__d3
 BGPhPfug8f7MS5oIq1oiCHpLdxIU3grNhn.sY2WExwdsvm2KT43PttjXxYe2LtImGK2HGysjGO7s
 obylB8R.uDiJFmjllvocMuswyT3O2qM5OKH0xJHCOrpIv.7Qs0UhC.a9lCa_q3OTYYR20Hly7N2k
 ArhIfPNWNzNLt__pGNY5gOFTXUAjbFfL5ljWG9IkkTo7iWK9O6TQ0VAiDbMCqaaYzClNnvnoOSZM
 T5elUJOm6Rq2Pk3khW2t2HXKuL3xEty0tAbwEtBKHDuP1kavkYL.EkZVvxHuDS6ypykYEDqnuHUS
 NnCVoi8pLZku1UxRnjdFbkbJODudFuSfmakikilw8941GIeXOyFRqG0sGT02vU_xbQ27y3txTike
 OKpyngC7gWGqbRvcZydhfWF.6rDO4wZe7Ub4RrX8W9JlbLgl0Zj7_2WbgMDmOXBjRKJERWL6yVqx
 _.PL_IgbUlPZfl_i2NkAio8nCzQ8brfX2orTt01xkEJIBJ2nqpwIhU_QwXZmmP.ayDCg5evb3VUT
 nO6hL.TLaS6godP2LgQCoYR1jN7e564QcMGQf7AagGgfB.5RrN0AMLIhuQlM7SjJvqxMH6s4VKqx
 0T.Seq9xeRU6WuIywOBM2A9.NnSgym3sjdNt2Uvt.91lidl_Fd6CFCpwBDGqH91NnVZSIl8KDmXC
 sFFFRPlHGwNF_c.JXxEbmjP0inKzCyInjDunq1gHjV7PoDyolG5h7CpBrjkB85e5LKIobMXt0Eu.
 ZDvaR7vJJadbgFHYlOlhnY4T_JiXMLMnWae3PD9dLdI.66AmILCWZ.8TQWHX5.ZMGrwcOhaAkPrP
 pJWvENoNg.s02ucRFAnCs7.4senoRwBTfcEd1mGlad4qh24eKhayGjo21MMWLYUvKJ4TUlk4Gs4n
 GOF4Z..EZmrBSPG.6A0wqnO8Av79mcXixS2yAjf5ZpJdh6BU5qJHfPAjYziB5VNqTeBOX9RF3tl2
 ZkCeqJpqgCyjKX09J1SlI0vs5ERPEjLDMWimHj8uR3GnaVSHfMEr8YOMuJhOdbTa.VDIDnM9Gugu
 w0GUmPjG2jgLQ25lCy6h4uds29uHC.g5qtJPBDeX0o6bhuaE4_FYJrjUPTOyKFZSaeNDBowV04ZJ
 _Y9qlFxsA8NKfZ0JjrDvEqLOE.rrqHWj__TYhgf.tsGJYS2I8XULgqxJotTAXuBvOMeRipneATCw
 nGNz4LCUMgY.u3jD11lEp8lGhZcWIGnDzuxSobACeJS3iw2PIJSeJbHpVg_Qy3Z9zOLNI_YkQLnO
 ZHx0D5iNkmyhUwTltOBnG8qpG_o3w4ymwCaBQknS3p0muN6Fyw2zgJBV95jQ71u0OdHLkfbIjyfU
 CWpI9ZPHDevONIcG4zj08EYfm6TIztY1lkwAGKQuS0fnbKr_gUYP8yYyY41xNcQ8ecEc5KqdAGTk
 qONAgggW084qDEcQA7JKHtCeIk4F44YoFalvtXNG6RY1WcH9YydWllU_oPTOtvZpva_TTKTlvA0M
 8Yuau0lXOApmaTOSZs2sdKu6sqYjYrzmlXOpFkwNa4vJv6o7xT1ucKjYjCl7gGjwajmWRZVRq6no
 1mUoMelmmQE7.rLC3y8V3MZji44P6RiwYvtyb_6I8pKSbqNWmCDIVt9JWoX3ucBQSJpNx_OSQUVO
 7ubCPwzteRYEpmCPF42IWGa5Vm6H8jubAZ2LXnwuXdfBWEK0eITXwsjXs_V6iesV7qOH3YFFNgfc
 qNDftQNAkCVvhFRfi9u9nNxhJQR33uHnyiKfrUTN1qwRiPlzcv8dRAOdBIElZVNqHDkpu4pZ1JKD
 MhLtivA10DZ6pa5Mh9N_R.H3bXC9o2bSYocC7psXBycMC9q9Va8z0HFdUUh_5FUQieOTXVEvEF6j
 elZEMMo0Pl.GBnynGGTdv9YktXCcXscw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Dec 2022 15:33:06 +0000
Received: by hermes--production-gq1-d898c4779-lkhfb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e73aadf127eff01f7a55e8a7a7a39458;
          Thu, 08 Dec 2022 15:33:02 +0000 (UTC)
Message-ID: <fc052c3c-7545-4d84-05d8-adb5659348a1@schaufler-ca.com>
Date:   Thu, 8 Dec 2022 07:33:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
Content-Language: en-US
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     mptcp@lists.linux.dev, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
 <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20926 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/7/2022 6:19 PM, Mat Martineau wrote:
> On Wed, 7 Dec 2022, Paolo Abeni wrote:
>
>> MPTCP sockets created via accept() inherit their LSM label
>> from the initial request socket, which in turn get it from the
>> listener socket's first subflow. The latter is a kernel socket,
>> and get the relevant labeling at creation time.
>>
>> Due to all the above even the accepted MPTCP socket get a kernel
>> label, causing unexpected behaviour and failure on later LSM tests.
>>
>> Address the issue factoring out a socket creation helper that does
>> not include the post-creation LSM checks. Use such helper to create
>> mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
>> vs the current user for the first subflow, as a kernel socket otherwise.
>>
>> Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
>> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP content looks good to me:
>
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
>
> I didn't see issues with the socket.c changes but I'd like to get some
> security community feedback before upstreaming - Paul or other
> security reviewers, what do you think?

I haven't had the opportunity to work out what impact, if any, this will
have on Smack. I haven't seen a reproducer for the problem, is one available?
Sorry to chime in late.

>
>
> Thanks,
>
> Mat
>
>
>> ---
>> include/linux/net.h |  2 ++
>> net/mptcp/subflow.c | 19 ++++++++++++--
>> net/socket.c        | 60 ++++++++++++++++++++++++++++++---------------
>> 3 files changed, 59 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/net.h b/include/linux/net.h
>> index b73ad8e3c212..91713012504d 100644
>> --- a/include/linux/net.h
>> +++ b/include/linux/net.h
>> @@ -251,6 +251,8 @@ int sock_wake_async(struct socket_wq *sk_wq, int
>> how, int band);
>> int sock_register(const struct net_proto_family *fam);
>> void sock_unregister(int family);
>> bool sock_is_registered(int family);
>> +int __sock_create_nosec(struct net *net, int family, int type, int
>> proto,
>> +            struct socket **res, int kern);
>> int __sock_create(struct net *net, int family, int type, int proto,
>>           struct socket **res, int kern);
>> int sock_create(int family, int type, int proto, struct socket **res);
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index d5ff502c88d7..e7e6f17df7ef 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1646,11 +1646,26 @@ int mptcp_subflow_create_socket(struct sock
>> *sk, struct socket **new_sock)
>>     if (unlikely(!sk->sk_socket))
>>         return -EINVAL;
>>
>> -    err = sock_create_kern(net, sk->sk_family, SOCK_STREAM,
>> IPPROTO_TCP,
>> -                   &sf);
>> +    /* the subflow is created by the kernel, and we need kernel
>> annotation
>> +     * for lockdep's sake...
>> +     */
>> +    err = __sock_create_nosec(net, sk->sk_family, SOCK_STREAM,
>> IPPROTO_TCP,
>> +                  &sf, 1);
>>     if (err)
>>         return err;
>>
>> +    /* ... but the MPC subflow will be indirectly exposed to the
>> +     * user-space via accept(). Let's attach the current user security
>> +     * label to the first subflow, that is when msk->first is not yet
>> +     * initialized.
>> +     */
>> +    err = security_socket_post_create(sf, sk->sk_family, SOCK_STREAM,
>> +                      IPPROTO_TCP, !!mptcp_sk(sk)->first);
>> +    if (err) {
>> +        sock_release(sf);
>> +        return err;
>> +    }
>> +
>>     lock_sock(sf->sk);
>>
>>     /* the newly created socket has to be in the same cgroup as its
>> parent */
>> diff --git a/net/socket.c b/net/socket.c
>> index 55c5d536e5f6..d5d51e4e26ae 100644
>> --- a/net/socket.c
>> +++ b/net/socket.c
>> @@ -1426,23 +1426,11 @@ int sock_wake_async(struct socket_wq *wq, int
>> how, int band)
>> }
>> EXPORT_SYMBOL(sock_wake_async);
>>
>> -/**
>> - *    __sock_create - creates a socket
>> - *    @net: net namespace
>> - *    @family: protocol family (AF_INET, ...)
>> - *    @type: communication type (SOCK_STREAM, ...)
>> - *    @protocol: protocol (0, ...)
>> - *    @res: new socket
>> - *    @kern: boolean for kernel space sockets
>> - *
>> - *    Creates a new socket and assigns it to @res, passing through LSM.
>> - *    Returns 0 or an error. On failure @res is set to %NULL. @kern
>> must
>> - *    be set to true if the socket resides in kernel space.
>> - *    This function internally uses GFP_KERNEL.
>> - */
>>
>> -int __sock_create(struct net *net, int family, int type, int protocol,
>> -             struct socket **res, int kern)
>> +
>> +/*creates a socket leaving LSM post-creation checks to the caller */
>> +int __sock_create_nosec(struct net *net, int family, int type, int
>> protocol,
>> +            struct socket **res, int kern)
>> {
>>     int err;
>>     struct socket *sock;
>> @@ -1528,11 +1516,8 @@ int __sock_create(struct net *net, int family,
>> int type, int protocol,
>>      * module can have its refcnt decremented
>>      */
>>     module_put(pf->owner);
>> -    err = security_socket_post_create(sock, family, type, protocol,
>> kern);
>> -    if (err)
>> -        goto out_sock_release;
>> -    *res = sock;
>>
>> +    *res = sock;
>>     return 0;
>>
>> out_module_busy:
>> @@ -1548,6 +1533,41 @@ int __sock_create(struct net *net, int family,
>> int type, int protocol,
>>     rcu_read_unlock();
>>     goto out_sock_release;
>> }
>> +
>> +/**
>> + *    __sock_create - creates a socket
>> + *    @net: net namespace
>> + *    @family: protocol family (AF_INET, ...)
>> + *    @type: communication type (SOCK_STREAM, ...)
>> + *    @protocol: protocol (0, ...)
>> + *    @res: new socket
>> + *    @kern: boolean for kernel space sockets
>> + *
>> + *    Creates a new socket and assigns it to @res, passing through LSM.
>> + *    Returns 0 or an error. On failure @res is set to %NULL. @kern
>> must
>> + *    be set to true if the socket resides in kernel space.
>> + *    This function internally uses GFP_KERNEL.
>> + */
>> +
>> +int __sock_create(struct net *net, int family, int type, int protocol,
>> +          struct socket **res, int kern)
>> +{
>> +    struct socket *sock;
>> +    int err;
>> +
>> +    err = __sock_create_nosec(net, family, type, protocol, &sock,
>> kern);
>> +    if (err)
>> +        return err;
>> +
>> +    err = security_socket_post_create(sock, family, type, protocol,
>> kern);
>> +    if (err) {
>> +        sock_release(sock);
>> +        return err;
>> +    }
>> +
>> +    *res = sock;
>> +    return 0;
>> +}
>> EXPORT_SYMBOL(__sock_create);
>>
>> /**
>> -- 
>> 2.38.1
>>
>>
>>
>
> -- 
> Mat Martineau
> Intel
