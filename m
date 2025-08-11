Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72029BDA6
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936020; cv=none; b=AJu1xg2G+h+ktaxpW25F8pyu0BU2amsLk+6KoeqEgCnHfIBz/JAi7u/bF9T1od0N2yEsY698f8cIYa6ObDzgvrAxE10m5toAh0CuweG52NPMvGT/lBm1NcxjI4FivpnNTJe24Or/2CzE0AAh06MeHwGo0Vs9rJ6ma/IDVES7hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936020; c=relaxed/simple;
	bh=MGz3zpmAdJFlmQxEP3Nv2ZjUYoenqK7ItbI7W4t1EDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZws+nxNQ7PqrzD67LvAncWkOwgAC5gCaBGf5JymjiIwwsYw9wRd/hstRuSXeUnj6d6okivQmloQqMhQi9Pclzex7r17wIzNUnLp4oX3ezh68sigXpKXJ24dqtG/VNmFiiex/CcU4D4kJrLWg2sxmp6Np52BK4ZDhf65t7MzLp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPzZMkFq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPzZMkFq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so4298909a91.3
        for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754936018; x=1755540818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ4k07QPRa9+LJy2XiYGx83lK4oYjCTO3lMIv01asgU=;
        b=VPzZMkFqU3J+++0du9WMZTCwq+wvcv8iPIrzL1/bj1HFj53sP+XgJ0uEtLax3zy4I9
         hZoDnFe2YmX4vI6v1W9l1R6TyUyzy9+IHCFRGsdUBbHzJTjKlaZmaWMqQibJnA90EcRo
         TfEYTLCIS4GNKaBBV42xe94gSg6kjkRnnMTokukH6OVURDoKjg98bka5vnAPJ0HuwOsJ
         ZHNHcDZxeecTR6K5sLLzAHJFn1A74WqzZGYHPESKL8HdrUefeDuW/yyCq/5sYq+P2jhW
         hpReBkfAO6Eh2159jlVcUvR9u7tSJ7+PyBLzo8JxhWughRCICRpgcGGSX330M6DKSyyX
         E9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936018; x=1755540818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ4k07QPRa9+LJy2XiYGx83lK4oYjCTO3lMIv01asgU=;
        b=iSekl55aKEwb7sNu/3571VRCYBVNVBnaTKzgCzKByBr7SYgHsNt9kguBJ1n86tiuTq
         3TK0t3dFePmjKV3hMj9QSVv5CE0Oks2kXDBLUxWu2twLHFKxoyP8VwUvCCaYMlb94Lhy
         BgQ21gjsSkvjAA2yWD8sFO/kkrVCwwGoX/vtJ7oYNke7F7J1o56hvdwyL6iaXkCt+oCg
         MTe+sCHWIaM/U7gGl6uoq9T5fCX5ANoIW73j6Ro/gE6TrXLy55SgXwHqXB+oMCVYVX0V
         Ko+gDKfA22S+vt3750XlyYLhfg0DEEkRDelqkUD+OXUCYjtZxwOIRPEwKPGS4BvOlU1W
         mKog==
X-Forwarded-Encrypted: i=1; AJvYcCVbA/mhVkAh5l9ocJCjPVBh5MCIr2wvP+czIPTbCQXveleqo/+IloVFnN2jiz+iJhKAucB/sIQA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yX+h1Dwgc946fsnG9VF/p8/TwT/Y9My9/WLJJQokhaqe8RJH
	XLRC7mjx3oRet/uDZLVUYqHfx+Oqx5nWbsTM+ypFpe77WEq0UYUZNietXrfDkAH/dCq7jPxnT28
	X5kYJML2b90DloNT4H59EHHPs8WLsrZgjvw==
X-Gm-Gg: ASbGncvs0gklFV2uGh09xNF9ScStFjqrSytEUPdOijVzgBPkFCIWwNFkHu3atq2rC5l
	V2CGbicftnWW9VgSLG8UK8UAK7COduc2TcBcR1gvzgJyLZf7yL4abktvgs1eYw3WEGzjMzDEf7f
	BJ4qPxOtew/34g8MoCuifJvRpS/7zEhWmnrG+RomF7dkAmEXKqPKAJnrop2dQ29ipnin1zfAD2M
	M03io4=
X-Google-Smtp-Source: AGHT+IFjH+dRDxcZHkC+Vcsw6vXaMuH6ntc7FqU0vlcDU4XOcVQFJPA5O4WrpaB0vdO7zf5w4b/jMHV0+wWmW1cQzrM=
X-Received: by 2002:a17:90b:35c4:b0:31f:22f:a23e with SMTP id
 98e67ed59e1d1-321c0b6f743mr676789a91.27.1754936018306; Mon, 11 Aug 2025
 11:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
 <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com> <CAHC9VhSck4zDgsBtdBJhJ0qYtNz-tFYjj=3=as+4yX38JNTOGQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSck4zDgsBtdBJhJ0qYtNz-tFYjj=3=as+4yX38JNTOGQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 11 Aug 2025 14:13:27 -0400
X-Gm-Features: Ac12FXxp8zlV8TS8tp15r_X-Uo-x9HPVWv4HhE3AlZ8cdC5fB0TNo-C9DRZ7pvQ
Message-ID: <CAEjxPJ4gAOXFShde9focOFpO747UaNMcxa9+-YJHT_Yu0GwETQ@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: ericsu@linux.microsoft.com, danieldurning.work@gmail.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Aug 7, 2025 at 9:46=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Also, since you are introducing new permissions and a policy
> > capability, please include instructions in the commit description for
> > running your testsuite, see
> > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#a=
dd-new-permissions
> > and
> > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#a=
dding-a-new-selinux-policy-capability
> > for instructions and links to example previous commits.
>
> I think it's fair to simply call out the new permissions and policy
> capability in the patch's description along with a simple explanation
> that the new behavior is gated on the new policy capability.
> Including instructions on how to enable a policy capability is
> something that I think we can consider "an exercise left to the
> reader", with documentation located outside the patch description.
> The unfortunate reality is that there is no single right way to add a
> policy capability to a system, and those instructions which are distro
> independent are likely to also clash with the distro supplied policy
> packages.
>
> Unfortunately, while the process around adding policy capabilities
> have improved somewhat over the years, it's still and ugly thing to
> have to do and I'm not sure a commit description is the best place to
> document that process.  I still have hope that some of the new policy
> work will improve this somewhat.

My request and the linked example I provide in the wiki page is to put
this information into the testsuite patch description, not the kernel
patch description, which I think is reasonable to reduce the burden on
testsuite maintainers.
The instructions in the linked example are distro-agnostic and just
leveraging a CIL module, so nothing specialized there.
At the very least, the specific name of the new policy capability and
the names of any new permissions and what classes they should be added
to needs to be clearly identified in the description.
I will not review a testsuite patch without this information.
