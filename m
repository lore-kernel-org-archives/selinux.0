Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94D18D4DC;
	Mon, 15 Jul 2024 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051196; cv=none; b=ti/zbBb51ZrVf7d0EWO48QByQScVCQxKHZWljPiylUsDHl3cBMiX3/aiUQ0aRh3m69Yn9C3BQGpha1iu+OEVUyi6H/vMsRXaA0i3Bo5nIxc31fzJM/RzHAIIN8YpkYbQd9H6E3EJIhd2mFEvb51mtGRYGGj1uo+oL5Ns43JXOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051196; c=relaxed/simple;
	bh=YvL4YXqVSR1PItB+6Eqr2+mQsw8VIIqpi/djcgEfun8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7ANNbbySlcA6eWbuY9EiIargO+R34J0WuM5+2BTvq+InOZNtqyQl5iIAe0t426T7Mt8jOWJFmyDEeLXkVGx7/bvWK180tkKWj3EOB6a/n80eUroRkQbc9NYJaxnwyYO+PinLVCjlFf//wugadY0Wec7uO8bHfwUJRlaMEKtmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShEh6Y6w; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShEh6Y6w"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c98b080012so2754520a91.1;
        Mon, 15 Jul 2024 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721051194; x=1721655994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYPHXexHkJ1Ep0UzTGnk/51UGHdb19RaEhRtZ797P/M=;
        b=ShEh6Y6wuPJJcYoLdNJQ1YjPQoBDiLUfZd/Wdzak2CZFoFld+CYRt7Td3EHMwUk46U
         sYhe3cCj10w/LAzW0xpD87cZN6cw/81UmcZslcHq/QB6A0TAgTXAmYeCW8aTYesi32zy
         r1i084FuCmFvnF6J+yQkMM6hhX01WxWf456AkrbFoX6Nvt1yp0aBCG/y2ogc80W1DOVk
         DyX5c28/qXXJ1Z8XPH3Nbii87UP63D8c19/XGhnnog4lkphKdvh1ytMuYmSy6zvxRzvd
         JZeLP9mGr4egdvqqm6tfNMrzQkiSG03F04Trcy03iTFbs22ZwhHBkKdP7exRWKHJCNHP
         o9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051194; x=1721655994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYPHXexHkJ1Ep0UzTGnk/51UGHdb19RaEhRtZ797P/M=;
        b=Iqe7tEXH81QoY1NLvBoY7fMdDH37nTbgojD8GQj8nldvoIKVnmokShEJddiG2cNfyc
         hRpnTXGX7j6T6ttD2E1Wf1zewwOX4RTMF9DvpzZnL9/rUpj8WopFnt65UDr/eFDLCqKr
         jtThmz/P+Y884phusGJc8hlDS8ujdL4g6yu//FY8XVFdZuoFCzDOrAnUgqRdFAIOBDNN
         v7SuUBz4IbJfvXTfAW1/iT8f+tOM6l1FveL7dHq0/969RhcYEWE3wsBuXtrsLBgg3pZk
         PufV1H2MH3uENlcO8xtetMxQ3DtrVd8dugsSgf73+7A5kd0Ed/tWuy8R7RU2Fkm+psae
         zf1A==
X-Forwarded-Encrypted: i=1; AJvYcCXc/MGBtd5mm3iecXq9YMySx+jXTMJUaMirsQSLuU9XxEOwpcayXeBiFWTMYbQpKiM34YCCzBYs9eAVNbM9bH6cV3MjDPi2FqNogrPVgEPuMtYGqJRB6uC54T1/zTbACv5VynMPNg==
X-Gm-Message-State: AOJu0Yz2nmME9M3bayVfKqKKg3baotKqIpEexbuduSOZNG/XJ7bogiTn
	OVOyhku6qDnEqmftPlIXGgbzKk8D2Nq6rz73uDwjBUnAx6u7l6ZD0lH5YODS6ZSbCaR20o2uyUe
	dLtdEpgDuiC0Hki4jlvr1kK7Tr3c=
X-Google-Smtp-Source: AGHT+IEI5AJkkZe6XMXeQ3BLcWtESRb1oTt5ylKqwyUiaCZy2nC0cdJYHEAifCfKSeqW+q4KNofYJgxLitysVaRPC5M=
X-Received: by 2002:a17:90b:4b02:b0:2c8:e3e6:ec99 with SMTP id
 98e67ed59e1d1-2ca35d5c69emr12984909a91.43.1721051194152; Mon, 15 Jul 2024
 06:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715014337.11625-1-guocanfeng@uniontech.com>
In-Reply-To: <20240715014337.11625-1-guocanfeng@uniontech.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jul 2024 09:46:22 -0400
Message-ID: <CAEjxPJ7QqEG+wyQfuPeDu0JqvjRCvbtVzZ6qtzwc-YwGz=mLjQ@mail.gmail.com>
Subject: Re: [RPC] Topic: Issues and Testing Regarding SELinx AVC Cache Modification
To: Canfeng Guo <guocanfeng@uniontech.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 9:44=E2=80=AFPM Canfeng Guo <guocanfeng@uniontech.c=
om> wrote:
>
> When calling avc_insert to add nodes to the avc cache, they are inserted =
into
> the head of the hash chain. Similarly, avc_calim_node removes nodes from
> the head of the same chain. so, SElinux will delete the latest added cach=
e
> infromation.
>
> I question whether the deletion logic proposed in the patch is more appro=
priate
> than the current implementation, or whether alternative mechanisms such a=
s
> LRU caching are beneficial.
>
> In my testing environment, I applied the above patch when avc_cache.solt =
and
> cache_threshold were both set to 512 by default. I only have over 280 nod=
es
> in my cache, and the longest observation length of the AVC cache linked l=
ist
> is only 7 entries. Considering this small size, the cost of traversing th=
e
> list is minimal, and such modifications may not incur additional costs.
>
> However, I don't know how to design a test case to verify its cost.
> And I cannot prove that this patch is beneficial.
>
> I attempted to simulate a more demanding scenario by increasing the cache=
_threshold
> to 2048 in order to establish a longer linked list of AVC caches, but
> I was unable to generate more than 2048 AVC records, possibly due to the =
need
> for a highly complex environment with numerous different SID interactions=
.
>
> Therefore, I have two questions:
> The necessity of modification:
>      Considering its potential impact on the cache performance of SELinx =
AVC,
>      is it worth investing effort into this modification?, i think that i=
n most cases,
>      this modification is not necessart.

I don't think it is desirable or necessary. The current logic prunes
the least recently used bucket and intentionally reclaims multiple
nodes at a time.

> Verification method:
>      If making such modifications is reasonable, how can I effectively
>      measure its impact on system performance?

The selinux-testsuite exercises many security contexts and thus should
enable reaching higher numbers of AVC nodes.

>
> Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
> ---
>  security/selinux/avc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 32eb67fb3e42..9999028660c9 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -477,6 +477,9 @@ static inline int avc_reclaim_node(void)
>
>                 rcu_read_lock();
>                 hlist_for_each_entry(node, head, list) {
> +                       while(node->next){
> +                               node =3D node->next;
> +                       }
>                         avc_node_delete(node);
>                         avc_cache_stats_incr(reclaims);
>                         ecx++;
> --
> 2.20.1
>
