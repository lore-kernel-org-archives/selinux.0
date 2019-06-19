Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9949FC31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E58021537
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z6a2At2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfFSQm4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:42:56 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:34449
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfFSQm4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560962575; bh=TF2MA8hlrx7omPK0wnxp2mS0hXx/u/hSC+7oyk22Aho=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Z6a2At2oKF6rAvr5VqdXWfiDp51FVsr1Ue/k3GnCvdzcOfbMisMhVlXvU8FV+lXHTpKEMjVDpu/eHPuOGVQYg0EEKQ1lz1862xSzuK34HcQ5ChRpC0oH0Add7M/tlmLZ76vbVkoxOvypcN2AODf+IpcfBMHeubNvKZTHWCIW4M2CzH1Pk8cwb1tvvh55BN7yyqBjrdHsTlBtswqMhwi4LbQSYWGoLcDXTVbK162BSEvxxuCwSamJvyoOKaRVVwfvHem4eYUWwMyTtFah6Gch2PJS9qwG55yfQP69zskrp0kPvUDWysiJBhR6ieTOi2SP4QyOSAp5GsaCjM8ApKyoOA==
X-YMail-OSG: oIkiMaEVM1k0vmOu9Ra0isjbpGV.i_LTZ8akQ4ogCeICMxQakG0SKhcehwwGbTq
 qer3B1mJBCWBfldo_8sBUSoYRe80jnJdp9v3KoDS6EOvzjwxjBDJTJp3_hBLl6Gpp6zitCe3jWDF
 qXvct9rTVKNfEyYgixXUgW5A7Hs9nAo538XcSeYwv9J0dW8zUc1lojwRXlRSRweum7OlZRCvaj.A
 UtZxtsvTokZAavjjdfZuzdq1re9vbLNzVldcMFbW4XPIIGkZ8PKtjUw6MYRJuUW97cO.6bTLRQZ7
 QgfJ2cqBgNmkNPoBmc3I7xS.RNm6TUsYYSCjNoO_hmo411_TYkOOfFEXyZEXzuy9WXLaKEqByRou
 uUmMG6wCs03PFcQ93LquRzcaxmkP9DEDqtQDRhLil1PKvHnXHj_R3yAM1aZd.5we1KbaNijAJpdf
 lsA4xtj2vfKbW.I1GxehG_CLBCcRieDK0Svh.1KwRhWqMtDoGoYLbI.xvokHN2A.dVjoGjBM4KdZ
 aBS70LsLpS5GJy6BCgkb6ZSsXnXeVSdwjONDRJwGs8l4f0eJi3v0C9xrDOXHf4liBu4fqe7i6OxO
 AAiNQw1ggTkWwXl1jTz.9osuDu9YJxiNeMWhAh9vAiVcGHi0MiuitI.Grrk2QyHucczQW5JaZ8Ha
 CY5luJUMG1Y8QwKKA5TAWeT2b2LGeX__5evMn.2dYAR3GzCPQYFxThhLqTzloHbHH.d7.h3N6F96
 chFNUWbJ.HQ5NMKliKpbuk6IRlZaU8IvxBH5._TN4ppUEyknEsb3X0bjo2yyQU37fQgE05ktrcTW
 k7PBwFHxaIlJzJoeKIUJKALzTEra_O7YNVIYW10cYoHFKLZH7BPNxOwb9RZyoOKxvwE1IwONzLtH
 NAjTkD4nGcMlPwMsRqZf3XXBVEXYZnBHZ2KeQLUX2vBWfRRzJhSY9CIcP7hY4cpi17V_.pr1z0mQ
 6EJBdIkHgIerXO1ImGWQGKCxkKhM.tkJGiysCMvKlTUnA2LvmhhgWncG7ple5dV.bedUf5vsqQEz
 kebbupZ_z7aoo6M7gYixhRX2BujXM865ER9lRDQr2IoHrgzQ5trGoCtUQwlR2.qA1qo9lWkzaSMb
 1FxuvHbhlfA_zIdnNs4DzLKVjeOl.MGISXXQSh2E7Zjk4Wz0WvZw_0aZax1uTrStjHP7JxU_9qvS
 _unN7nA6CMWbCjVtHvzsxTIYp3.kNE4o3QVf6GLOXH37fE1l3PyT7OsNjh2F0Z1UkWoVEWkO964q
 zjeRnoyXyN6pCZEe6CmNiTCdkFVde8apv
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 16:42:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e5845186d8b17239bd78131a880fad4b;
          Wed, 19 Jun 2019 16:42:50 +0000 (UTC)
Subject: Re: [PATCH v2 07/25] net: Prepare UDS for secuirty module stacking
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-8-casey@schaufler-ca.com>
 <201906182157.29524DC78@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ad524097-fb9a-3df2-fae7-a561b5180510@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 09:42:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182157.29524DC78@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 9:59 PM, Kees Cook wrote:
> typo in Subject -> "secuirty" -> "security"
>
> On Tue, Jun 18, 2019 at 04:05:33PM -0700, Casey Schaufler wrote:
>> Change the data used in UDS SO_PEERSEC processing from a
>> secid to a more general struct lsmblob. Update the
>> security_socket_getpeersec_dgram() interface to use the
>> lsmblob. There is a small amount of scaffolding code
>> that will come out when the security_secid_to_secctx()
>> code is brought in line with the lsmblob.
> Can you spell this out a little more, "scaffolding code passes slot 1
> unconditionally while the following patches will fix this up when they
> are made aware of lsmblob" etc. (Also, why slot 1 and not slot 0?)

It should be slot 0. An earlier version had special meaning for
slot 0, but that proved unnecessary. This is a bug, as it will break
if you have exactly one of the major LSMs built in.

> -Kees
>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h |  7 +++++--
>>  include/net/af_unix.h    |  2 +-
>>  include/net/scm.h        |  8 +++++---
>>  net/ipv4/ip_sockglue.c   |  8 +++++---
>>  net/unix/af_unix.c       |  6 +++---
>>  security/security.c      | 16 +++++++++++++---
>>  6 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 89a5391f2441..64f5cc2dd249 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -1276,7 +1276,8 @@ int security_socket_shutdown(struct socket *sock, int how);
>>  int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
>>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>>  				      int __user *optlen, unsigned len);
>> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
>> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>> +				     struct lsmblob *l);
>>  int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
>>  void security_sk_free(struct sock *sk);
>>  void security_sk_clone(const struct sock *sk, struct sock *newsk);
>> @@ -1414,7 +1415,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
>>  	return -ENOPROTOOPT;
>>  }
>>  
>> -static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
>> +static inline int security_socket_getpeersec_dgram(struct socket *sock,
>> +						   struct sk_buff *skb,
>> +						   struct lsmblob *l)
>>  {
>>  	return -ENOPROTOOPT;
>>  }
>> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
>> index 3426d6dacc45..933492c08b8c 100644
>> --- a/include/net/af_unix.h
>> +++ b/include/net/af_unix.h
>> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>>  	kgid_t			gid;
>>  	struct scm_fp_list	*fp;		/* Passed files		*/
>>  #ifdef CONFIG_SECURITY_NETWORK
>> -	u32			secid;		/* Security ID		*/
>> +	struct lsmblob		lsmblob;	/* Security LSM data	*/
>>  #endif
>>  	u32			consumed;
>>  } __randomize_layout;
>> diff --git a/include/net/scm.h b/include/net/scm.h
>> index 1ce365f4c256..c87a17101c86 100644
>> --- a/include/net/scm.h
>> +++ b/include/net/scm.h
>> @@ -33,7 +33,7 @@ struct scm_cookie {
>>  	struct scm_fp_list	*fp;		/* Passed files		*/
>>  	struct scm_creds	creds;		/* Skb credentials	*/
>>  #ifdef CONFIG_SECURITY_NETWORK
>> -	u32			secid;		/* Passed security ID 	*/
>> +	struct lsmblob		lsmblob;	/* Passed LSM data	*/
>>  #endif
>>  };
>>  
>> @@ -46,7 +46,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
>>  #ifdef CONFIG_SECURITY_NETWORK
>>  static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
>>  {
>> -	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
>> +	security_socket_getpeersec_dgram(sock, NULL, &scm->lsmblob);
>>  }
>>  #else
>>  static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
>> @@ -97,7 +97,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>>  	int err;
>>  
>>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
>> -		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
>> +		/* Scaffolding - it has to be element 1 for now */
>> +		err = security_secid_to_secctx(scm->lsmblob.secid[1],
>> +					       &secdata, &seclen);
>>  
>>  		if (!err) {
>>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
>> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
>> index 82f341e84fae..fbe2147ee595 100644
>> --- a/net/ipv4/ip_sockglue.c
>> +++ b/net/ipv4/ip_sockglue.c
>> @@ -130,15 +130,17 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
>>  
>>  static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>>  {
>> +	struct lsmblob lb;
>>  	char *secdata;
>> -	u32 seclen, secid;
>> +	u32 seclen;
>>  	int err;
>>  
>> -	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
>> +	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
>>  	if (err)
>>  		return;
>>  
>> -	err = security_secid_to_secctx(secid, &secdata, &seclen);
>> +	/* Scaffolding - it has to be element 1 */
>> +	err = security_secid_to_secctx(lb.secid[1], &secdata, &seclen);
>>  	if (err)
>>  		return;
>>  
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index ddb838a1b74c..c50a004a1389 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -143,17 +143,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
>>  #ifdef CONFIG_SECURITY_NETWORK
>>  static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>>  {
>> -	UNIXCB(skb).secid = scm->secid;
>> +	UNIXCB(skb).lsmblob = scm->lsmblob;
>>  }
>>  
>>  static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>>  {
>> -	scm->secid = UNIXCB(skb).secid;
>> +	scm->lsmblob = UNIXCB(skb).lsmblob;
>>  }
>>  
>>  static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
>>  {
>> -	return (scm->secid == UNIXCB(skb).secid);
>> +	return lsmblob_equal(&scm->lsmblob, &(UNIXCB(skb).lsmblob));
>>  }
>>  #else
>>  static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>> diff --git a/security/security.c b/security/security.c
>> index 4296cd2ca508..5ed818699e15 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2132,10 +2132,20 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>>  				optval, optlen, len);
>>  }
>>  
>> -int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
>> +int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>> +				     struct lsmblob *l)
>>  {
>> -	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
>> -			     skb, secid);
>> +	struct security_hook_list *hp;
>> +	int rc = -ENOPROTOOPT;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
>> +			     list) {
>> +		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
>> +						      &l->secid[hp->slot]);
>> +		if (rc != 0)
>> +			break;
>> +	}
>> +	return rc;
>>  }
>>  EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>>  
>> -- 
>> 2.20.1
>>
