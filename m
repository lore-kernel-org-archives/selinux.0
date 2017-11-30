Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAUIGfAX002536
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 13:16:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 3ynlwR5DyGzJ3GT
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 18:16:39 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 3ynlwR4VY7zJ3Ft
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 18:16:39 +0000 (UTC)
To: Eric Dumazet <eric.dumazet@gmail.com>, David Ahern <dsahern@gmail.com>,
 James Morris <james.l.morris@oracle.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 LSM <linux-security-module@vger.kernel.org>
References: <alpine.LFD.2.20.1711292113350.7808@localhost>
 <4d73f839-7a86-6edc-b44b-e296bd5947c2@schaufler-ca.com>
 <alpine.LFD.2.20.1711301130330.17322@localhost>
 <ae2e71e4-c366-5a1e-9fd6-4de944f4a158@schaufler-ca.com>
 <1512039044.19682.12.camel@gmail.com>
 <b92c6b3d-5c7e-9859-4bb2-b1a0aa64d86b@gmail.com>
 <d29937fd-dd04-8568-f89c-505ff725761a@gmail.com>
 <1512064629.19682.21.camel@gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1ea449e7-cc37-621d-4c77-6936b567b8b4@schaufler-ca.com>
Date: Thu, 30 Nov 2017 10:16:26 -0800
MIME-Version: 1.0
In-Reply-To: <1512064629.19682.21.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [BUG] kernel stack corruption during/after Netlabel
 error
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/30/2017 9:57 AM, Eric Dumazet wrote:
> On Thu, 2017-11-30 at 10:30 -0700, David Ahern wrote:
>> On 11/30/17 8:44 AM, David Ahern wrote:
>>> On 11/30/17 3:50 AM, Eric Dumazet wrote:
>>>> @@ -1631,24 +1659,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>>>  
>>>>  	th = (const struct tcphdr *)skb->data;
>>>>  	iph = ip_hdr(skb);
>>>> -	/* This is tricky : We move IPCB at its correct location
>>>> into TCP_SKB_CB()
>>>> -	 * barrier() makes sure compiler wont play
>>>> fool^Waliasing games.
>>>> -	 */
>>>> -	memmove(&TCP_SKB_CB(skb)->header.h4, IPCB(skb),
>>>> -		sizeof(struct inet_skb_parm));
>>>> -	barrier();
>>>> -
>>>> -	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
>>>> -	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th-
>>>>> syn + th->fin +
>>>> -				    skb->len - th->doff * 4);
>>>> -	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
>>>> -	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
>>>> -	TCP_SKB_CB(skb)->tcp_tw_isn = 0;
>>>> -	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
>>>> -	TCP_SKB_CB(skb)->sacked	 = 0;
>>>> -	TCP_SKB_CB(skb)->has_rxtstamp =
>>>> -			skb->tstamp || skb_hwtstamps(skb)-
>>>>> hwtstamp;
>>>> -
>>>>  lookup:
>>>>  	sk = __inet_lookup_skb(&tcp_hashinfo, skb,
>>>> __tcp_hdrlen(th), th->source,
>>>>  			       th->dest, sdif, &refcounted);
>>> I believe moving the above is going to affect lookups with VRF. Let
>>> me
>>> take a look before this gets committed.
>>>
>> Eric:
>>
>> Can you add this to the patch? Fixes socket lookups with VRF which
>> stashes a flag in the cb.

I've done my testing and it works both ways for Smack.


>>
>> Thanks,
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 4e09398009c1..6c020015d556 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -849,7 +849,7 @@ static inline bool inet_exact_dif_match(struct
>> net
>> *net, struct sk_buff *skb)
>>  {
>>  #if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
>>         if (!net->ipv4.sysctl_tcp_l3mdev_accept &&
>> -           skb && ipv4_l3mdev_skb(TCP_SKB_CB(skb)->header.h4.flags))
>> +           skb && ipv4_l3mdev_skb(IPCB(skb)->flags))
>>                 return true;
>>  #endif
>>         return false;
>
> I wonder if this should not be in a separate patch ?
>
> Bug was added in 971f10eca186cab238c49daa91f703c5a001b0b1 ("tcp: better
> TCP_SKB_CB layout to reduce cache line misses")  in linux 3.18
>
> While VRF was added later.
>
> If you agree, I will prepare a patch series, with different Fixes tag
> so that David can decide which path needs to be backported into each
> stable version.
>
> Thanks.
>
>
