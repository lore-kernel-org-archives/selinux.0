Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEC3DCDB5
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539074; cv=pass; b=a+kK0MaXfdhWxiq06zzrvhTxbEonxk63qYkDO85CgpBm7q0/PRT2xa/ctPz1B2wdbjJgDEiN5iKykwX5Vaa0tC1Mvwh297jqqMNfH4DGnXF21CS44vsjdrVX3RddMQg9pE5Sj51ezjNm8eGFwghZsJYed0Rru6H6h0fRYBf4eAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539074; c=relaxed/simple;
	bh=0mf3SRpE5IG7MGRJ0l6yfha3UW450fYYwhRG5IWqiV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKe52i9WNAN/OA2oQ81vhR+pE3BdZnvm9+Ci4M6e3JUhvEGpvWZ4NDXWbdHBSyzFp5zbfoQ00bWJ6h8Tww4PDAs7vXSrY6E/1pFLszON7rlkeFpLcDtMFV3LLlbgdsbTy48HRdX/z2jDH+r0TgmWxPfW1fbh9j14PFrwNJW35gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxk86Cc6; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxk86Cc6"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso1942505ad.3
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2026 12:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783539071; cv=none;
        d=google.com; s=arc-20260327;
        b=CNeFabK9vAgSrVPNyGoP5Y9gcKJL9WnsS3oHkoVItwT97DaB8JL7MdgVAMiIkq8Jbb
         FAP3KAZqzU8OX1YPyIeZgN8PBbp54NQmOW0CEl7nUCQ2jxtNfFCmxPXLNP4jPRUPw+VD
         PdSbAY69qeCMa4mxZYF6+H1QNKF1GEgri+JtQq6Oz1GXkm1ioT/9pujGyQ3tOApAfR0V
         blvaW4Zj5jRM7tWubLKEsmQh7JvauxPj1Ud8ihZSeT2rrTEDBk6yjLKJ5BL23VfWWAJe
         X2grm6q2njjxfWRhDoUzGopMcKMEcmP2XJ3l41MTsqE28hBP1HmpDBQP0r+VEgnLv/EA
         bxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v5o0cwpxBeVF228p357rRrT6L6ljkSDZRB630XZUbMM=;
        fh=ZcAUPWE1vpKCk0K4bN4zE93AIlTGmFaLSeje2FwW79w=;
        b=PhwHF3lrjQwBT0bSl/esTvhTK+fHQDVkFdRPfjxMl1K84xmhzn7BZmGwpZHH1osKHU
         5lFOtJIdgWC41cUEh48MYHkh+Ogb9sE5HxnjySvGbzi6MpEPMjx5iSMjktYxhD5NT5oj
         zw8XR9NPtiB1gFKJdmsck4iAJOEHJjGlo0fiK65N224DsA+NR7enaCTdQS7rhIgdHcfa
         gfy7888RX7R3qkK3mfzjcn3A29AFfgKxeh0DxWo2ZgBzsR0XA/C0zTqzeyaVosVwlh0J
         TcF1QljP5QP0FW/nESo/t16GVLGFS5TzLJOTACx0uzJLZ9RW7lSpV80BMEKewyZVWbzE
         zHbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783539071; x=1784143871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v5o0cwpxBeVF228p357rRrT6L6ljkSDZRB630XZUbMM=;
        b=hxk86Cc6FFMz4cVeAPcoELuv0wLNah8hnZQOSlKqP+HDXks9hFlFvdPIIfqj2iqMQ3
         qn+OfO4lKTe/ogGgm3nfvfPbWoeVwDpfo3qVNRqrQ59dlHO8EZTnjOT+BSwAgTcDNI8H
         79ZYUxBbH/09SoXPzOXC7CA04Y0DMXQnZIAngHNv3n3md6urHomIEfhyq4fBA+zCPoXk
         DEtuwV/ebncc311vIw1GwKWbxVOeViWot8Y7bJ5WvibMFEfTtACWJMkVyUWY+CGz1bYL
         KwrxrSZygev8iRhy65Ii8/TDASSiMSI4H23F9s4z9VMpYVEr1ZgMEwx33r0q3TM66WyN
         auQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539071; x=1784143871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5o0cwpxBeVF228p357rRrT6L6ljkSDZRB630XZUbMM=;
        b=mFjJDribwnT5aNbzs45UdpY1iBO5+rV+yNiGdx0LFLjPtfQsBfJDRIwx8+djlBlj+/
         XC5ugBCFvI1+Gb8K0ysahEabroi2NdCD/UF6Ooxo24sU+oG1UlLSkgWTHVlx5sBf6ITL
         xjGEw7C5D/csnzvFhNLTChnIyH7sk/rhtQlEdimgzJx1uV5s/CeF65N7I171tfHexNkp
         dPeKEZ68BcS7n3bSvI/t9fL8pFYZ6nGBAnKn2rlfR75vWqBCaaQBc8NRJytuMyVe2/3i
         i8NYm0xJEM9GUQ90rIpmqjSRUg8CrSfzexslsFj9D1U5AhHH1/HN7ZzHVsrRJM6OLUZH
         UdNA==
X-Gm-Message-State: AOJu0YxEDNfmH9BECx0M53gytiaxQWe4WPq41Z10We7dew+100YUj54+
	OXt0+s6WHhl7t4aAdXGcRHxckvUYLtN4hK8JL3ncn3Xd3AEv5JvswVUWhnWwMt23npLJcehWe/i
	6QDxKsXUu6yQyAmQhWj/u/rQnDmA/S6QH0A==
X-Gm-Gg: AfdE7cmDpGTgwUiL3j+hxciOV/fzyfXD/50gEGdZEeDFxWmD+IoTj3dkt4u0xhv11Ea
	NVODDSFfnCHvefqdkVZyHa+T5ASAj4jdVHUqSX6iTJGHQi8oh8WbP4JxWhC3ptUbi6hQQVqsHUi
	IPsyolGpwPY1/UdJVgDLSrTUmCg7C27DfKKCq1VaeOGIV2wzPMvK82nDTVW6s/zw3T845jShKVt
	hHfNZ4CnD8Bg/HFq1vbZvkDtUmbIjtXEWlou75YU1cCbUuZzz8re9ro3YvCHvWh5Lj51okn
X-Received: by 2002:a17:902:d548:b0:2ca:de3:15e1 with SMTP id
 d9443c01a7336-2ccea45f224mr36024655ad.31.1783539071151; Wed, 08 Jul 2026
 12:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707143938.1653637-1-bill.c.roberts@gmail.com>
In-Reply-To: <20260707143938.1653637-1-bill.c.roberts@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Jul 2026 15:31:00 -0400
X-Gm-Features: AVVi8CdIGfHHpU3ZNCw1DecSP9v5CdC47OLgpLE05wNIZ5PXSrhb37lrOdz6GSA
Message-ID: <CAEjxPJ5X1pEmUSLRfz21Em-B4a18_HKd5pvH-6VGQ5+cHBW0Mw@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: remove William Roberts
To: Bill Roberts <bill.c.roberts@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 10:39=E2=80=AFAM Bill Roberts <bill.c.roberts@gmail.=
com> wrote:
>
> Signed-off-by: Bill Roberts <bill.c.roberts@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  SECURITY.md | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 2a7ce5b3..a1d02c4d 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -38,7 +38,6 @@ the issue as quickly as possible and shorten the disclo=
sure window.
>  * Jason Zaman, perfinion@gentoo.org
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EA=
F
>  * Steve Lawrence, slawrence@tresys.com
> -* William Roberts, bill.c.roberts@gmail.com
>  * Ondrej Mosnacek, omosnace@redhat.com
>
>  ### Resolving Sensitive Security Issues
> --
> 2.54.0
>
