Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6132FA30
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586384; cv=pass; b=cFOHd6LJSJBBPaRE9yM39xVl731kcpyyO0e7ilipG05f/iHOjlatrxaA4l8JoZOiSvyKYfu+fodLj9Ml1OaU7WFvqj6T/Fww2JaiJYcNKJxeKbQf/5AYQ9RI81cIeAP7T6p0R3FlBlsMDztzJtQq/tYXdW4jUjZZuwWroilw0Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586384; c=relaxed/simple;
	bh=/qaVjgzX0zb5BqiFZT7Egz8CRkQ6XXfz/gYjqWgiD+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3yRo7LIhyjv6x6tbO4On8WUobaDLOQ0BsInELvPFruAAZxSbhuqLG1a9Jsuc+wvMQukjydkx8G2UtWXvQVg3ug3oQZX0i2C1z/26HmeIpqG693AVa5hY564NSqFBxsT/yv6TY1IwAPHpwgjyuD/tuOYIG0yrZ2sA8R5qRLfuOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Lg/xhPBX; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lg/xhPBX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9f316d68so5941195ad.2
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 14:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777586382; cv=none;
        d=google.com; s=arc-20240605;
        b=HeYiyNTb5gcmi4jW1B++MptDYXJF0AYlfaHPSooyvkvBArL3f8cCIHtyb3GJLjlgW3
         D2xuV1WAdfPLcvWsGcsruoHtDZc72Ulf5kMoGT2HfdOY7opSybbQ6DRSF1ddrbbj/vW6
         sAD5oNJRwpYMy2HmUsPNGQO7xbCcAerXFOVpcrc+JZX0UDgutbcGHW9vF41zIXbUZOqq
         Ps7cpA07HnP3rZLb5BddV7Pkg4TmO2Hpk7QJVFWvdvt27Kz07DanksM5AwxU7bfblMrV
         21/FzLgY2bjsCFzQSho/r+oiV6fA0tSwMqlYoDUVsadxw9z3M4CBzCvB6OqjT8PFZb+2
         Dv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vnXYS+VXMsjgoiQ5oRQftrCeBE18f9iIBknwJmAc3LM=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=Jsb0FI/8Okz5nvQhKpqQsN1CkkfZtSasOWxUVb3q+7FD3/FjwqnpcbV36hluRRZinG
         bJ8Hi/oEsZmLVthNKEY9AocjS02aHjGa94CwR+/5U7vfLN1eDQBdPtZIhTIT/PcYLYko
         HMFRCANte6nAnKdOREaQLyJswb7H7MA7d2rqBFll2yIv4G51YPF/akn1XW+qcLoY+x3E
         ytT4P224O7TcbqiH688iKKaP/9BRIKFav3vH08u/fvyjKy5PWHtrRA+jSLDAgCluHxmz
         ji/E5R9r9w6hVwRU5o+ADLw8GmzwGxatPrTy8dTTg+k8xNv+zxorPABqCUP0f3LVBcbr
         vJaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777586382; x=1778191182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnXYS+VXMsjgoiQ5oRQftrCeBE18f9iIBknwJmAc3LM=;
        b=Lg/xhPBXO94Ljs6lrJheU1OJ5c9Zaj9j9zD7Sd+tFgxNxUe4rXctnjeBmUrubBaftg
         O+EkjI2lk5GbNdQlwJzKD+kqG5NKzQhPPo6G2MWbjk6PXIuZiBNvkcBCBOecjp87mh7D
         LdvQMb6SMheZ6UkYADizWyo66bSiONhyejFnDkWAtcINmB+FyCaK0kN42emk8wH6VfaT
         k3HZxcVg/U1XNdJYiz+hPX+COwM3iWlx3E26tlzugx/K32DcyBpRoUIgVtcp+157mxkr
         2IYzwE1rtzmiXKb7vJQnfsjzW85GAQkecqRFTV4IIRZxW1BO2zqqhSJrJ1Ff26hK4lVb
         fDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586382; x=1778191182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnXYS+VXMsjgoiQ5oRQftrCeBE18f9iIBknwJmAc3LM=;
        b=NenH+BbOUmclxgmVfbQFpJRkbuks1ydVwnTbSdkSFtYH74ztJvowmr2P7f+6sU//dO
         kZNrEpjqQjzuz8O56zyJ7Nvnj43Ug/CPTbZN96fOsBOxxS6B9dr33TkCGeiDXygp/jGf
         ZB3kQCNLXZd9FSSXja3g1zMhuDQRmkaW3zRx8gf3aVAgew4Q4OuX12DIZJtVEj4n9BSg
         tZ8L0sDg8J5VcAsHjBrh+BAG0+HM/9fk0NttncwV2OCPuhPHfwAS5oA0o/TQu1pcMBM2
         zpl2nR8Z+gt1zsNsYIXsIkQRqnPCpbo/hQiSYvMtrfuuoQikbap/E86lRFb48dGVxzu+
         87/Q==
X-Gm-Message-State: AOJu0YxOY5b/7WKzd9oGFoyv71fSQfOwGkXqrsZlU1YTG7sJNTlPMm03
	05dES38iVVyRY43RUZ/mKx7gqm2F66Bz+0bO42oPZrtZhDxOGNu95fm7pZo8Sf6XH+p/cS7Lrh+
	CRvNmdIlFzU9JTi5ckzJZKgEbAxprwuJBCI9rgThEc5BHn1foeBtz6w==
X-Gm-Gg: AeBDieu9p6LkTI3lOWPZhpn1JehIAG1XTjrRBc5ajOscZ2+8B96g+4C8/7Mtrclkd6i
	v4V4aMnmhSzfMzcrB6ZoAOUH8FbHncN9AMxYr6YNOLhz3XQWQYwi6/VuOLiDZlM3g+USG1ChSP9
	rSBgN9Ro8kVLsuA+V6cYIYolNnFVqktWkIeSNIGydJKVGuxIYYpfW9z/4BrhzVq7HbCAff21T6D
	WekcHYxedHERhP0qaHUCyv+Nc2XzunIDyN9xtWJm/8r2LzjZwnxh27BNPbOaPX6x+UCAK62vz7/
	nKev9YG2VRRvQkA3YgIvu4ztESAf
X-Received: by 2002:a17:902:f650:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b9a24f9dc0mr49688015ad.29.1777586382381; Thu, 30 Apr 2026
 14:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430210001.56995-1-kalevi@kolttonen.fi>
In-Reply-To: <20260430210001.56995-1-kalevi@kolttonen.fi>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Apr 2026 17:59:31 -0400
X-Gm-Features: AVHnY4KpDdkF7ZikrgBlWbXGY8a9mj3BZIIaYmJahHTpim2yiBbwH47d4a2jcFs
Message-ID: <CAHC9VhT4q5NQ9Q9crSv4SegvJq6uNan_j1xWgppPSgQaCrirsg@mail.gmail.com>
Subject: Re: [PATCH] Remove unneeded goto and its label
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 5:18=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  security/selinux/avc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

A general rule when submitting Linux kernel patches is to prefix the
subject line with the subsystem's name followed by a colon, e.g.
"selinux: ...".  For example, look at the top three patches in the
selinux/dev branch using 'git log':

% git log --oneline | head -n 3
cf6a513f1937 selinux: switch two allocations to use kzalloc_objs()
ef5b517e7bac selinux: fix sel_kill_sb()
4e3881b0a300 selinux: use QSTR() instead of QSTR_INIT() in init_sel_fs

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 813e82bcfc27..a9401d6c2e5f 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -497,7 +497,7 @@ static struct avc_node *avc_alloc_node(void)
>
>         node =3D kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
>         if (!node)
> -               goto out;
> +               return NULL;
>
>         INIT_HLIST_NODE(&node->list);
>         avc_cache_stats_incr(allocations);
> @@ -506,7 +506,6 @@ static struct avc_node *avc_alloc_node(void)
>             selinux_avc.avc_cache_threshold)
>                 avc_reclaim_node();
>
> -out:
>         return node;
>  }
>
> --
> 2.54.0

--=20
paul-moore.com
