Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF24E80AD
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363313; cv=pass; b=Djcrg83SiFKGPuwT+8auS1YpTu1PeMzJQz6s12EKaBy6Pe9L85fQ7gXo3OjlhLjJKXJET+jgfid8MpN0QmAeWerO+m+YD/o4y+NC3ND80XnoZMSZ2tKXJop7JmjmuDPXWC8D7pxQZBvmyGTEF0DU7h/mmCkkfebxrGEuDV27VPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363313; c=relaxed/simple;
	bh=f6JbZrf1bkdONNn5ckDQmyefg4CJ12AvY8hfc4UKLUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msRnGIbXzyCDQ2+geAZ/zsgvkNIjwb/9zgz0RnbOhVSiOD7ZzzFodGWMWQm8012e3EbpUTt7khyCJcDu9QTK2rhVDOV0ZxvN14IlZ+jMCkiEfgHSay4181ggH9KCcHdF2oUIXN3HPJ3q0ObDnPo4wDw9v1qcWEJ5dOYw0FOMkrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbWGD67k; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbWGD67k"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532bbso11319907b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363302; cv=none;
        d=google.com; s=arc-20260327;
        b=i9H59MX8JXNp54VZH/c91LQudPzcGo9YJUsjbzwawqk7xc0cpeEqkrdORFSIkwlcta
         87x3F6z3cFVcyxMsOb6Lte35z2yOWT+RbK504Ps4Y6Su9eN+lP2ocTOllTohk5+QyhSS
         cJXRSWwHjidY4e7jOeU4ptkPhNEY6FlZQjtz2gG/UC2rgDjuoJWmH3v+IaymgkPntcb3
         O2cI6acgYIZR+Gp3r/owjpZXZ6X9ze18V4j6fLtAUFLwxXr/8U1RvJCdx9VAjC+KmCi0
         jsmArni+x+Djw+zmRSm7fyfLwF4xasggzpTkRNKTsrRRiwdAzvd/LrrCCX2Sf8ryflvS
         2k1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6JbZrf1bkdONNn5ckDQmyefg4CJ12AvY8hfc4UKLUw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=JCK1BYsUhuI2YIPwOwYJOTpBoPsUpm9L0cyY/ibIvSwwOj5O2GssED0fwnvC9NIjLA
         AEY+oIO0z+JZN/H2ohaOKMDcMGZE+CTIGPqd1iI6nUOLwwzJ35UwIbfVlroJCFWwY4DL
         HvhBS4xqapAB5kF8dXPs9DW2iwpVeDy0YXyXwFjHDgeJVSs8EbKmciZkLHuVFxYjpjO0
         IEeSaTTI3SLlrtpXYamnao8eut1Ia8pQ/4QAusr+w6hDA3/Q3H4ztpaNaKZaJmelk2/8
         aczyJmb4g1IdI2SwRdtECH5ms7RHklPJTYxDRRD9/BolRteU7FhJ+UKqeMmdcPzXgHRW
         +BXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363302; x=1790968102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f6JbZrf1bkdONNn5ckDQmyefg4CJ12AvY8hfc4UKLUw=;
        b=mbWGD67k0gaEkjQSDkZxYZlNc01gYA5M2jDz49f0ukM1GPyC91LHmEOg9Aa1bI32/x
         BYgGNR4TpIeY6p+Jx2zst1oEM0EV65+wCSJYXA13H34jgYUqgft3GtyDtlPysK35dXDi
         pVKBJOF/tAP5RquGFKJm6M1D2lbrrP0/VQG3S0x156tc7zE9xO8lbxSEfBcWPk7VdQkG
         uiFRhMUxdnKAebLrgnYlDV2W9ts1ZOrae1mDagrJe63C7B7Zh+aDa6qL92oCbk9ZBPvD
         qkBjbfvSPAd1X/Z957BmOE1/XEHzzi1xgeaD/FZDVhGvJw4TIMRxbyrKFrrEQKZAwW8O
         8isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363302; x=1790968102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f6JbZrf1bkdONNn5ckDQmyefg4CJ12AvY8hfc4UKLUw=;
        b=kE45h5A7TH/4RgpEriYqDKemABAmEttt3a3glWbWahNn6JEVSgI91L357/Er/UqyBj
         Td2K3l6NmLhSC1D16+jEJTQqHBsoFRO/yQjL1HJzMH4rHeqqVPWsAIVtdjQKAa7TIgGZ
         j64uhzGDxy2WfegA9dR/9gXdp4EkICZVahdpAPv8V/jXw0i2dzWfTxd8e74en0As34tI
         2N/XUUSFi8qMfYeoxm/3auYYYyezWF+HTgNlfY1nSBOQSHY3CGGES9OIiZFs7bKjWufI
         8w0CGWNOPMyxot47v7tg7xIdN+d/cpC97Y4P+/NxL1VZc9w3fmhmE+xdZ5yqnrO3TiGk
         zL1g==
X-Gm-Message-State: AFuF++nMnxgxqoF8WcF4FJQUx1GzuY9kTOeH/JtMxH5PMGlt9vZO7BHS
	5iF8Ro2KqkswAc7Ab76F6hFrtGM4nI5ftmmUJOo10GYxbUrM/xaZGqngW09ftJgIb/Bq7ooM8TJ
	dg5nw6EYrAHJ+KWafxBVPBKWFw7RiTsA=
X-Gm-Gg: AYBFou0meKFinPvJ8lxQQHTKosGbh22JuqHvkeBaKSLhM56grqgE3uSQKygoZ3xSxzD
	8i0M9aYdwUUsXFCnKBWkXqg31WnliX3C0PtqWwpq3f1h/dOgMccfSt+zqhK7tk44r04bXB6sOxN
	rtKu/OmZm1Xxgj7Ow1mvBcyycpKqh/1auWxPTH00o086R24HX1PDsNw7OkVeNtigLCe32tb2fv3
	IqarJ/Kxh2NlMCLFAEeUdDg9ndEojjX3AzdjzbUD59r2KhQf4J2RZE0XQhW/wTcWBwdkSluoh82
	ZQrpt/jrLsWMoEbsFcQFFbLDwSMbpc5Cthe6XFPPM8dlGH9N6xxpFYA=
X-Received: by 2002:a05:690c:e215:20b0:8a8:91c6:8a66 with SMTP id
 00721157ae682-8a891c69ba0mr3211247b3.33.1790363301680; Fri, 25 Sep 2026
 12:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-9-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:08:10 -0400
X-Gm-Features: AclHuK9UzBLqelRuZGWnQ4aXhbI5AIF5KPCb-fMuuX5V1-fyMtUyDURt2fdoUJY
Message-ID: <CAEjxPJ5N==sEJA=zp8JiXXxgeh_qOOoHyUhDgxs7xHyPmAG21g@mail.gmail.com>
Subject: Re: [PATCH 10/21] tests: port scripts to sh and please shellcheck
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:21=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Improve portability and avoid actual issues being hidden.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
